
import {share, map, pluck, debounceTime, distinctUntilChanged} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';
import { forkJoin ,  Observable ,  Subject } from 'rxjs';

import { DropdownModel } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService } from '../../../../@core/services/alert.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { GenericService } from '../../../../@core/services/generic.service';
import { HttpService } from '../../../../@core/services/http.service';
import { AdminUrlConfig } from '../../admin-url.config';
import {
    PermissionGroup,
    PermissionRoles,
    Resource,
    RolePermission,
    UpdateRoles,
    UserRole,
} from '../_entites/user-security-profile.data.modal';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'user-role',
    templateUrl: './user-role.component.html',
    styleUrls: ['./user-role.component.scss'],
    standalone: false
})
export class UserRoleComponent implements OnInit {
    userRole: UserRole[] = [];
    editPermissionDetails: UserRole = new UserRole();
    updateuserRoles: UpdateRoles = new UpdateRoles();
    addUserRoleForm!: FormGroup;
    rolePermissionForm!: FormGroup;
    rolePermissionFormArray!: FormArray;
    PermissionGroup$: Observable<any> = new Observable<any>()
    intakeAgencies$: Observable<DropdownModel[]> = new Observable<DropdownModel[]>();
    rolesDropdownItems$: Observable<DropdownModel[]> = new Observable<DropdownModel[]>();
    addPermission: boolean = false;
    totalRolePermissions: any[] = [];
    roleid!: number;
    totaluserroles: any;
    userRoleId!: number | null;
    resourseListSubject$ = new Subject<Resource[]>();
    resourseSubject$ = new Subject<Resource>();
    resourceid!: string;
    resourceroleid!: string;
    userPermissionRolesList$: PermissionRoles[] = [];
    issupervisable: boolean = false;
    submitRole: Object = new Object();
    addNewPermission: boolean = false;
    updateRole: Object = new Object();
    deleteUser: any;
    roleresourceid: any;
    rolegroupfilterText: any;
    permissiongroupfilterText!: FormControl;
    selectedResources: Resource[] = [];
    selectedItems: any[] = [];
    rolePermissionGroup: RolePermission[] = [];
    constructor(
        private _service: CommonHttpService,
        private _httpService: HttpService,
        private _servicePermissionGroup: GenericService<PermissionGroup[]>,
        private _serviceResource: GenericService<Resource>,
        private formBuilder: FormBuilder,
        private _alertService: AlertService
    ) {
        this.addUserRoleForm = this.formBuilder.group({
            name: [],
            Agency: ['', Validators.required],
            roletypecode: ['', Validators.required],
            Rolekey: [''],
            rolename: [''],
            openamrole: [''],
            description: ['']
        });
    }

    ngOnInit() {
        this.formInitilize();
        this.loadDropdown();
        this.getUserRole();
        this.rolegroupfilterText = new FormControl('');
        this.permissiongroupfilterText = new FormControl('');
        this.issupervisable = false;
        this.rolegroupfilterText.valueChanges.pipe(
            debounceTime(400),
            distinctUntilChanged()
        ).subscribe((res: string) => {
            this.userRole = this.totaluserroles.filter((t: { description: string; })=> t.description.toLowerCase().indexOf(res.toLowerCase()) > -1);
        });
        this.permissiongroupfilterText.valueChanges.pipe(debounceTime(400),
        distinctUntilChanged(),)
        .subscribe((res: any) => {
            const filteredData: any = this.totalRolePermissions.filter(t=> t.get('permissiongroupname').value.toLowerCase().indexOf(res.toLowerCase()) > -1);
            (this.rolePermissionForm.controls['rolePermissionFormArray'] as FormGroup).controls = filteredData;
        });
        this.resourseSubject$.subscribe((item) => {
            const selectedResource = this.selectedResources.filter((itm) => itm.id === item.id);
            if (selectedResource.length) {
                const index = this.selectedResources.indexOf(selectedResource[0]);
                this.selectedResources[index] = item;
            }
        });
    }
    formInitilize() {
        this.rolePermissionForm = this.formBuilder.group({
            rolePermissionFormArray: this.formBuilder.array([this.createPermission()])
        });
    }
    createPermission() {
        return this.formBuilder.group({
            description: [''],
            isSelected: false,
            permissiongroupid: [''],
            permissiongroupname: ['']
        });
    }
    setRolePermission() {
        this.rolePermissionForm.setControl('rolePermissionFormArray', this.formBuilder.array([]));
        const control = <FormArray>this.rolePermissionForm.controls['rolePermissionFormArray'];
        this.rolePermissionGroup.forEach((x) => {
            control.push(this.buildMenuForm(x));
        });
        this.totalRolePermissions = this.rolePermissionForm.get('rolePermissionFormArray')?.value ?? [];
    }
    private buildMenuForm(x: RolePermission): FormGroup {
        return this.formBuilder.group({
            description: x.description,
            isSelected: x.isSelected ? x.isSelected : false,
            permissiongroupid: x.permissiongroupid,
            permissiongroupname: x.permissiongroupname
        });
    }
    addRole() {
        this.userRole.push();
        this.submitRole = {
            teamtypekey: this.addUserRoleForm.value.Agency,
            roletypecode: this.addUserRoleForm.value.roletypecode,
            description: this.addUserRoleForm.value.description,
            rolename: this.addUserRoleForm.value.rolename,
            openamrole: this.addUserRoleForm.value.openamrole,
            issupervisable: this.issupervisable
        };
        if (this.addUserRoleForm.dirty && this.addUserRoleForm.valid) {
            this._httpService.post(AdminUrlConfig.EndPoint.UserProfile.AddRole, this.submitRole).subscribe(
                (res) => {
                    if (res === 'Already Exist') {
                        this._alertService.error('Role already exists.');
                    } else {
                        this._alertService.success('Role added successfully!');
                    }
                    this.getUserRole();
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
            this.addUserRoleForm.reset();
            this.issupervisable = false;
        }
    }
    showAddPermission() {
        this.addPermission = true;
    }

    loadDropdown() {
        const source = forkJoin([this._service.getArrayList({}, AdminUrlConfig.EndPoint.UserProfile.UserRoleAgency), this._service.getArrayList({
            nolimit: true,
            method: 'get'
        }, 'roletype?filter')]).pipe(
            map((result) => {
                return {
                    intakeAgency: result[0].map(
                        (response) =>
                            new DropdownModel({
                                text: response.description,
                                value: response.teamtypekey
                            })
                    ),
                    intakeRole: result[1].map(
                        (response) =>
                            new DropdownModel({
                                text: response.roletypename,
                                value: response.roletypecode
                            })
                    )
                };
            }),
            share(),);
        this.intakeAgencies$ = source.pipe(pluck('intakeAgency'));
        this.rolesDropdownItems$ = source.pipe(pluck('intakeRole'));
    }
    deleteRoleName() {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.UserProfile.DeleteRolesUrl;
        this._service.remove(this.deleteUser.id).subscribe(
            (result) => {
                this._alertService.success('Role deleted successfully!');
                this.getUserRole();
            },
            (err) => {
                console.error(err);
            }
        );
        $('#delete-alias-popup').modal('hide');
    }
    confirmDelete(user: any) {
        this.deleteUser = user;
        $('#delete-alias-popup').modal('show');
    }
    updatePermissionRoles() {
        this.updateuserRoles.id = this.userRoleId;
        this.updateuserRoles.roleresource = this.selectedResources;
        this.updateuserRoles.roleresource.forEach((item) => {
            item.roleid = String(this.userRoleId);
            item.temproleresourceid = item.resourceid;
            item.resourceid = item.id;
            item.id = item.temproleresourceid;
            item.permissiontype = 2;
            return item;
        });

        this._httpService.post(AdminUrlConfig.EndPoint.UserProfile.UpdateRolesUrl, this.updateuserRoles).subscribe(
            (res) => {
                this.getUserRole();
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    showResourceListUsingRoleId(modal: UserRole, _roleId: any, _index: any) {
        this.addNewPermission = true;
        this.userRoleId = modal.id ? modal.id : null;
        this._serviceResource
            .getArrayList(
                {
                    where: { roleid: this.userRoleId, resourcetype: [1] },
                    method: 'get'
                },
                AdminUrlConfig.EndPoint.UserProfile.ResourceListUrl + '?filter'
            )
            .subscribe((result) => {
                if(result && result.length >0){
                    this.getresources(result);
                }
            });
    }
    getresources(result: any[]){
        let count = 0;
        result = result.map((item) => {
             if (!item.isallowed) {
                item.isallowed = false;
            } 
            if (!item.isenabled) {
                item.isenabled = false;
            }
            if (!item.isvisible) {
                item.isvisible = false;
            }
            if (item.isallowed || item.isenabled || item.isvisible) {
                count++;
            }
            return item;
        });
        if (count === 0) {
            this.addNewPermission = false;
        }
        this.selectedResources = result;
        if (this.selectedResources && this.selectedResources.length) {
            this.resourseListSubject$.next(this.selectedResources);
        }
    }

    getPermissiongroupList(roleId: number | undefined) {
        this._service
            .getArrayList(
                {
                    where: { roleid: roleId },
                    method: 'get',
                    nolimit: true
                },
                AdminUrlConfig.EndPoint.UserProfile.PermissionGroupUrl + '/list?filter'
            )
            .subscribe((result) => {
                this.rolePermissionGroup = result;
                if (this.rolePermissionGroup && this.rolePermissionGroup.length) {
                    this.setRolePermission();
                }
            });
    }
    editPermissionGroup(modal: UserRole, index: any) {
        this.editPermissionDetails = modal;
        this.getPermissiongroupList(this.editPermissionDetails.id);
        if (index !== '') {
            this.userRole.forEach((item) => {
                item.isSelected = false;
            });
            this.userRole[index].isSelected = true;
        }
    }
    updateRoles() {
        this.selectedItems = [];
        const rolePermissionFormArray: FormArray = this.rolePermissionForm.get('rolePermissionFormArray') as FormArray;
        rolePermissionFormArray.value.map((res: { permissiongroupid: string; isSelected: boolean; }) => {
            if (res.permissiongroupid !== '' && res.isSelected === true) {
                this.selectedItems.push({
                    resourceid: res.permissiongroupid,
                    isallowed: true,
                    isvisible: true,
                    isenabled: true,
                    permissiontype: 1
                });
            }
        });
        const inputRequest = {
            name: this.editPermissionDetails.name,
            description: this.editPermissionDetails.description,
            id: this.editPermissionDetails.id,
            roleresource: this.selectedItems.length > 0 ? this.selectedItems : []
        };
        this._httpService.post(AdminUrlConfig.EndPoint.UserProfile.UpdateRolesUrl, inputRequest).subscribe(
            () => {
                this._alertService.success('Saved successfully!');
                this.getUserRole();
            },
            () => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    private getUserRole() {
        this._service
            .getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                AdminUrlConfig.EndPoint.UserProfile.UserRoleUrl + '?filter'
            )
            .subscribe((resp) => {
                this.totaluserroles= resp;
                this.userRole = resp;
                if (this.userRole && this.userRole.length !== 0) {
                    this.userRole[0].isSelected = true;
                    this.editPermissionGroup(this.userRole[0], 0);
                }
            });
    }

    private getPermissionGroupsUsingRoleId(roleId: string) {
        if (roleId !== '') {
            const source = this._servicePermissionGroup
                .getPagedArrayList(
                    {
                        where: { roleid: roleId },
                        method: 'get'
                    },
                    AdminUrlConfig.EndPoint.UserProfile.PermissionGroupUrl + '/list?filter'
                ).pipe(
                map((result) => {
                    return { data: result };
                }));
            this.PermissionGroup$ = source.pipe(pluck('data'));
        } else {
            const source = this._servicePermissionGroup.getPagedArrayList({}, AdminUrlConfig.EndPoint.UserProfile.PermissionGroupUrl + '?filter={}').pipe(map((result) => {
                return { data: result };
            }));
            this.PermissionGroup$ = source.pipe(pluck('data'));
        }
    }

    isSuperVisible() {
        if (this.issupervisable === false) {
            this.issupervisable = true;
        } else if (this.issupervisable === true) {
            this.issupervisable = false;
        }
    }

    getRolePermissionFormData(name: string): any[] {
        return Object.values((this.rolePermissionForm.get(name) as FormGroup).controls);
    }
}