
import {map, pluck, share, distinctUntilChanged, debounceTime} from 'rxjs/operators';
import { ChangeDetectionStrategy, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';
import { forkJoin ,  Observable } from 'rxjs';
import { GenericService } from '../../../../@core/services';
import { AlertService } from '../../../../@core/services/alert.service';
import { AdminUrlConfig } from '../../admin-url.config';
import {
    PermissionGroup,
    SaveResource,
} from '../_entites/user-security-profile.data.modal';
import { ResourcePermission } from '../../../provider-applicant/new-public-applicant/_entities/newApplicantModel';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'permission-group',
    templateUrl: './permission-group.component.html',
    styleUrls: ['./permission-group.component.scss'],
    changeDetection: ChangeDetectionStrategy.Default,
    standalone: false
})
export class PermissionGroupComponent implements OnInit {
    permissionGroupForm!: FormGroup;
    addPermission: boolean = false;
    permissionGroupId: string | undefined;
    editPermission!: PermissionGroup;
    permissionGroup: PermissionGroup[] = [];
    menuList$: Observable<any> = new Observable<any>();
    moduleList$: Observable<any> = new Observable<any>();
    screenList$: Observable<any> = new Observable<any>();
    actionList$: Observable<any> = new Observable<any>();
    elementList$: Observable<any> = new Observable<any>();
    isMenu = false;
    isModule = false;
    isScreen = false;
    isAction = false;
    isElement = false;
    menufilterText!: FormControl;
    permissiongroupfilterText!: FormControl;
    modulefilterText!: FormControl;
    screenfilterText!: FormControl;
    actionfilterText!: FormControl;
    elementModuleTypeFilter!: FormControl;
    actionModuleTypeFilter!: FormControl;
    screenModuleTypeFilter!: FormControl;
    menuModuleTypeFilter!: FormControl;
    elementfilterText!: FormControl;
    selectedControls: any[] = [];
    subMenuList$: Observable<any> = new Observable<any>();
    totalPermissionGroup: any[] = [];
    constructor(
        private formBuilder: FormBuilder,
        private _service: GenericService<PermissionGroup>,
        private _resourceListTree: GenericService<ResourcePermission>,
        private _saveResource: GenericService<SaveResource>,
        private _formBuilder: FormBuilder,
        private _alertService: AlertService
    ) { }

    ngOnInit() {
        this.menufilterText = new FormControl('');
        this.permissiongroupfilterText = new FormControl('');
        this.modulefilterText = new FormControl('');
        this.screenfilterText = new FormControl('');
        this.actionfilterText = new FormControl('');
        this.elementfilterText = new FormControl('');
        this.elementModuleTypeFilter = new FormControl(null);
        this.actionModuleTypeFilter = new FormControl(null);
        this.screenModuleTypeFilter = new FormControl(null);
        this.menuModuleTypeFilter = new FormControl(null);
        this.formInitilize();
        this.getPermissionGroup();
        this.permissiongroupfilterText.valueChanges.pipe(debounceTime(400),
        distinctUntilChanged(),)
        .subscribe(res => {
            this.permissionGroup = this.totalPermissionGroup.filter(t=> t.permissiongroupname.toLowerCase().indexOf(res.toLowerCase()) > -1);
        });
        this.menufilterText.valueChanges.pipe(debounceTime(400),
        distinctUntilChanged(),)
        .subscribe(res => {
            this.getResourceList(res);
        }); 
        this.modulefilterText.valueChanges.pipe(debounceTime(400),
        distinctUntilChanged(),)
        .subscribe(res => {
            this.getResourceList(res);
        }); 
        this.screenfilterText.valueChanges.pipe(debounceTime(400),
        distinctUntilChanged(),)
        .subscribe(res => {
            this.getResourceList(res);
        }); 
        this.actionfilterText.valueChanges.pipe(debounceTime(400),
        distinctUntilChanged(),)
        .subscribe(res => {
            this.getResourceList(res);
        }); 
        this.elementfilterText.valueChanges.pipe(debounceTime(400),
        distinctUntilChanged(),)
        .subscribe(res => {
            this.getResourceList(res);
        });
        this.menuModuleTypeFilter.valueChanges.pipe(debounceTime(400),
        distinctUntilChanged(),)
        .subscribe(res => {
            this.menuList$ = this.moduletypechange(res, [1,5]).pipe(pluck('list'));
        }); 
        this.screenModuleTypeFilter.valueChanges.pipe(debounceTime(400),
        distinctUntilChanged(),)
        .subscribe(res => {
            this.screenList$ = this.moduletypechange(res, [3]).pipe(pluck('list'));
        }); 
        this.actionModuleTypeFilter.valueChanges.pipe(debounceTime(400),
        distinctUntilChanged(),)
        .subscribe(res => {
            this.actionList$ = this.moduletypechange(res, [4]).pipe(pluck('list'));
        });
        this.elementModuleTypeFilter.valueChanges.pipe(debounceTime(400),
        distinctUntilChanged(),)
        .subscribe(res => {
            this.elementList$ = this.moduletypechange(res,[7]).pipe(pluck('list'));
        });
    }
    private moduletypechange(res: any,resourcetype: number[]){
      return this._resourceListTree.getArrayList(
            {
                method: 'get',
                where: { permissiongroupid: this.editPermission.permissiongroupid, resourcetype: resourcetype, modulekey: res},
                nolimit: true
            },
            AdminUrlConfig.EndPoint.UserProfile.ResourceFlatList + '?arg'
        ).pipe(map(result => {            
            return {
                list: result  
            };
        }),share(),);
    }
    formInitilize() {
        this.permissionGroupForm = this.formBuilder.group({
            groupName: ['', Validators.required]
        });
    }
    private getPermissionGroup() {
        this.addPermission = true;
        this._service.endpointUrl = AdminUrlConfig.EndPoint.UserProfile.PermissionGroupUrl + '?filter';
        this._service.getArrayList({ method: 'get', nolimit: true }).subscribe((result) => {
            this.permissionGroup = result;
            this.totalPermissionGroup = result;
            if (this.permissionGroup && this.permissionGroup.length) {
                this.permissionGroupId = this.permissionGroup[0].permissiongroupid;
                this.permissionGroup[0].isActive = true;
                this.addPermission = true;
                this.getPermissionDetail(this.permissionGroup[0], 0);
            } else {
                this.addPermission = false;
            }
        });
    }
    getResourceList(search: string) {
        const source = forkJoin([
            this._resourceListTree.getArrayList(
                {
                    method: 'get',
                    where: { permissiongroupid: this.editPermission.permissiongroupid, resourcetype: [1, 5] },
                    nolimit: true
                },
                AdminUrlConfig.EndPoint.UserProfile.ResourceFlatList + '?arg'
            ),
            this._resourceListTree.getArrayList(
                {
                    method: 'get',
                    where: { permissiongroupid: this.editPermission.permissiongroupid, resourcetype: [2] },
                    nolimit: true
                },
                AdminUrlConfig.EndPoint.UserProfile.ResourceFlatList + '?arg'
            ),
            this._resourceListTree.getArrayList(
                {
                    method: 'get',
                    where: { permissiongroupid: this.editPermission.permissiongroupid, resourcetype: [3] },
                    nolimit: true
                },
                AdminUrlConfig.EndPoint.UserProfile.ResourceFlatList + '?arg'
            ),
            this._resourceListTree.getArrayList(
                {
                    method: 'get',
                    where: { permissiongroupid: this.editPermission.permissiongroupid, resourcetype: [4] },
                    nolimit: true
                },
                AdminUrlConfig.EndPoint.UserProfile.ResourceFlatList + '?arg'
            ),
            this._resourceListTree.getArrayList(
                {
                    method: 'get',
                    where: { permissiongroupid: this.editPermission.permissiongroupid, resourcetype: [7] },
                    nolimit: true
                },
                AdminUrlConfig.EndPoint.UserProfile.ResourceFlatList + '?arg'
            )
        ]).pipe(map(result => {
            result[0] = search ? result[0].filter((res: any) => (res.name).toLowerCase().indexOf(search.toLowerCase()) !== -1) : result[0];
            result[1] = search ? result[1].filter((res: any) => (res.name).toLowerCase().indexOf(search.toLowerCase()) !== -1) : result[1];
            result[2] = search ? result[2].filter((res: any) => (res.name).toLowerCase().indexOf(search.toLowerCase()) !== -1) : result[2];
            result[3] = search ? result[3].filter((res: any) => (res.name).toLowerCase().indexOf(search.toLowerCase()) !== -1) : result[3];
            result[4] = search ? result[3].filter((res: any) => (res.name).toLowerCase().indexOf(search.toLowerCase()) !== -1) : result[4];
            return {
                menuList: result[0],
                moduleList: result[1],
                screenList: result[2],
                actionList: result[3],
                elementList: result[4],
                subMenuList: result[0].filter((item) => item.resourcetype === 5).length
            };
        }),share(),);
        this.menuList$ = source.pipe(pluck('menuList'));
        this.moduleList$ = source.pipe(pluck('moduleList'));
        this.screenList$ = source.pipe(pluck('screenList'));
        this.actionList$ = source.pipe(pluck('actionList'));
        this.elementList$ = source.pipe(pluck('elementList'));
        this.subMenuList$ = source.pipe(pluck('subMenuList'));
    }

    updateMenuList(event: any,prop: string){
        this.menuList$.subscribe(res => {
            if (prop === 'allow') {
                const selAll: any[] = [];
                this.selectedControls = [];
                res.map((item: { resourcetype: string; resourceid: any; id: any; isallowed: any; }) => {
                    if (item.resourcetype === '1') {
                        item.resourceid = item.id;
                        item.isallowed = event.target.checked;
                        selAll.push(item);
                    }
                });
                this.selectedControls.push(...selAll);
                $('.menuAllowAll').prop('checked', event.target.checked);
            } else if (prop === 'enable') {
                const selAll: any = [];
                this.selectedControls = [];
                res.map((item: { resourcetype: string; resourceid: any; id: any; isallowed: any; }) => {
                    if (item.resourcetype === '5') {
                        item.resourceid = item.id;
                        item.isallowed = event.target.checked;
                        selAll.push(item);
                    }
                });
                this.selectedControls.push(...selAll);
                $('.subMenuAllowAll').prop('checked', event.target.checked);
            }
        });
    }

    updateModuleList(event: any,prop: string){
        this.moduleList$.subscribe(res => {
            if (prop === 'allow') {
                res.map((item: { resourceid: any; id: any; isallowed: any; }) => {
                    item.resourceid = item.id;
                    item.isallowed = event.target.checked;
                });
                this.selectedControls = [];
                const selAll = [].concat(...res);
                this.selectedControls.push(...selAll);
            }
        });
        $(".moduleAllowAll").prop('checked', event.target.checked);
    }

    updateScreenList(event: { target: { checked: any; }; },prop: string){
        this.screenList$.subscribe(res => {
            if (prop === 'allow') {
                res.map((item: { resourceid: any; id: any; isallowed: any; }) => {
                    item.resourceid = item.id;
                    item.isallowed = event.target.checked;
                });
                this.selectedControls = [];
                const selAll = [].concat(...res);
                this.selectedControls.push(...selAll);
                $(".screenAllowAll").prop('checked', event.target.checked);
            } else if (prop === 'enable') {
                res.map((item: { resourceid: any; id: any; isenabled: any; }) => {
                    item.resourceid = item.id;
                    item.isenabled = event.target.checked;
                })
                this.selectedControls = [];
                const selAll = [].concat(...res);
                this.selectedControls.push(...selAll);
                $(".screenEnableAll").prop('checked', event.target.checked);
            }
        });
    }

    updateActionList(event: any,prop: string){
        this.actionList$.subscribe(res => {
            if (prop === 'allow') {
                res.map((item: { resourceid: any; id: any; isallowed: any; }) => {
                    item.resourceid = item.id;
                    item.isallowed = event.target.checked;
                })
                this.selectedControls = [];
                const selAll = [].concat(...res);
                this.selectedControls.push(...selAll);
                $(".actionAllowAll").prop('checked', event.target.checked);
            } else if (prop === 'visible') {
                res.map((item: { resourceid: any; id: any; isvisible: any; }) => {
                    item.resourceid = item.id;
                    item.isvisible = event.target.checked;
                })
                this.selectedControls = [];
                const selAll = [].concat(...res);
                this.selectedControls.push(...selAll);
                $(".actionVisibleAll").prop('checked', event.target.checked);
            } else if (prop === 'enable') {
                res.map((item: { resourceid: any; id: any; isenabled: any; }) => {
                    item.resourceid = item.id;
                    item.isenabled = event.target.checked;
                })
                this.selectedControls = [];
                const selAll = [].concat(...res);
                this.selectedControls.push(...selAll);
                $(".actionEnableAll").prop('checked', event.target.checked);
            }
        });
    }

    updateElementList(event: any,prop: string){
        this.elementList$.subscribe(res => {
            if (prop === 'allow') {
                res.map((item: { resourceid: any; id: any; isallowed: any; }) => {
                    item.resourceid = item.id;
                    item.isallowed = event.target.checked;
                })
                this.selectedControls = [];
                const selAll = [].concat(...res);
                this.selectedControls.push(...selAll);
                $(".elementAllowAll").prop('checked', event.target.checked);
            } else if (prop === 'visible') {
                res.map((item: { resourceid: any; id: any; isvisible: any; }) => {
                    item.resourceid = item.id;
                    item.isvisible = event.target.checked;
                })
                this.selectedControls = [];
                const selAll = [].concat(...res);
                this.selectedControls.push(...selAll);
                $(".elementVisibleAll").prop('checked', event.target.checked);
            } else if (prop === 'enable') {
                res.map((item: { resourceid: any; id: any; isenabled: any; }) => {
                    item.resourceid = item.id;
                    item.isenabled = event.target.checked;
                })
                this.selectedControls = [];
                const selAll = [].concat(...res);
                this.selectedControls.push(...selAll);
                $(".elementEnableAll").prop('checked', event.target.checked);
            }
        })
    }

    selectAllControls(event: any, type: string, prop: any) {
        if(type === 'menu') {
           this.updateMenuList(event,prop); 
        } else if(type === 'module') {
            this.updateModuleList(event,prop);
        } else if(type === 'screen') {
            this.updateScreenList(event,prop);
        } else if(type === 'action') {
            this. updateActionList(event,prop);
        }
        else if(type === 'element') {
           this.updateElementList(event,prop); 
        }
    }

    addGroup() {
        this.permissionGroup.forEach((item) => {
            item.isActive = false;
        });
        const resource = {
            permissiongroupname: this.permissionGroupForm.value.groupName,
            description: ''
        };
        this.addUpdatePermissionGroup(resource, 'Add Group');
    }

    getPermissionDetail(modal: PermissionGroup, index: any) {
        this.permissionGroupId = modal.permissiongroupid;
        this.editPermission = modal;
        this.addPermission = true;
        this.isMenu = true;
        this.isModule = false;
        this.isScreen = false;
        this.isAction = false;
        this.isElement = false;
        $('#searchbtn').prop('checked', false);
        $('#searchbtnmodule').prop('checked', false);
        $('#searchbtnscreen').prop('checked', false);
        $('#searchbtnvisible').prop('checked', false);
        $('#searchbtnenabled').prop('checked', false);
        this.getResourceList('');
        if (index !== '') {
            this.permissionGroup.forEach((item) => {
                item.isActive = false;
            });
            this.permissionGroup[index].isActive = true;
        }
    }
    deletePermission(modal: any) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.UserProfile.DeletePermissionGroupUrl;
        this._service.remove(modal.permissiongroupid).subscribe(
            (_result: any) => {
                this._alertService.success('Deleted Group successfully');
                this.getPermissionGroup();
            },
            (err: any) => {
                console.error(err);
            }
        );
    }
    showAddPermission() {
        this.addPermission = true;
    }
    saveGroup() {
        const validation = this.conditionValidation();
        const resource = {
            permissiongroupname: this.editPermission.permissiongroupname,
            description: this.editPermission.description,
            resource: this.selectedControls,
            permissiongroupid: this.editPermission.permissiongroupid
        };
        if (validation) {
            this.addUpdatePermissionGroup(resource, 'Save Group');
        }
    }
    conditionValidation(): boolean {
        if (this.selectedControls.length === 0) {
            this._alertService.warn('Please select atlease one resource');
            return false;
        } else if (!this.editPermission.permissiongroupid) {
            this._alertService.warn('Please select permission group');
            return false;
        } else if (this.permissionGroupForm.value.groupName) {
            this._alertService.warn('Please enter group Name');
            return false;
        }
        return true;
    }
    addUpdatePermissionGroup(resource: SaveResource, type: string) {
        this._saveResource.create(resource, AdminUrlConfig.EndPoint.UserProfile.SaveGroupUrl).subscribe(
            (_result: any) => {
                this._alertService.success(type + ' successfully');  
                this.permissionGroupForm.reset();
                this.selectedControls = [];
                this.getResourceList('');

            },
            (err: any) => {
                console.error(err);
            }
        );
    }
    onControlChange(resource: any, event: any, prop: string, resourceid?: any, type?: string) {
        let selObj = resource;
        let hasCheckObj = false;
        selObj.resourceid = resource.id;
        if(this.selectedControls.length) {
            const checkObj = this.selectedControls.filter(itm => itm.resourceid === selObj.id);
                if(checkObj && checkObj.length) {
                    if (resource.pgresourceid) {
                        checkObj[0].pgresourceid = resource.pgresourceid;
                    }
                    selObj = checkObj[0];
                    hasCheckObj = true;
                }
                selObj = this.updateSelectedControls(selObj,hasCheckObj,event,prop,resourceid,type);
                if(!hasCheckObj){
                    this.selectedControls.push(selObj);
                }
                    
        } else {
            this.updateControls(selObj,event,prop,resourceid,type);          
        }
    }

    updateControls(selObj: any,event: any,prop: string,resourceid: any,type: any){
        if (prop === 'enable' && (resourceid === 5 || resourceid === 1)) {
            selObj.isallowed = (!event.target.checked && resourceid === 1) ? null : !event.target.checked;
            selObj.isvisible = !event.target.checked;
            selObj.isenabled = !event.target.checked;
        } else if (prop === 'allow' && ( ['screen','module'].includes(type) )) {
            selObj.isallowed = event.target.checked;
            selObj.isvisible = event.target.checked;
        }/* else if (prop === 'allow' && type === 'module') {
            selObj.isallowed = event.target.checked; //SonarQube - same block above , so combined the condition
            selObj.isvisible = event.target.checked;
        }*/ else if (prop === 'allow') {
            selObj.isallowed = event.target.checked;
        } else if (prop === 'visible') {
            selObj.isvisible = event.target.checked;
        } else if (prop === 'enable') {
            selObj.isenabled = event.target.checked;
        }
        this.selectedControls.push(selObj);
    }

    updateSelectedControls(selObj: any,hasCheckObj: boolean,event: any,prop: string,resourceid: any,type: any){
        
        if (prop === 'enable' && ( [5,1].includes(resourceid) )) {
            selObj.isallowed = (!event.target.checked && resourceid === 1) ? null : !event.target.checked;
            selObj.isvisible = !event.target.checked;
            selObj.isenabled = !event.target.checked;
        } else if (prop === 'allow' && type === 'screen') {
            selObj.isallowed = event.target.checked;
            selObj.isvisible = event.target.checked;
        } else if (prop === 'allow' && type === 'module') {
            selObj.isallowed = event.target.checked;
            selObj.isenabled = event.target.checked && !selObj.isenabled ? true : false;
        } else if (prop === 'allow') {
            selObj.isallowed = event.target.checked;
        } else if (prop === 'visible') {
            selObj.isvisible = event.target.checked;
        } else if (prop === 'enable') {
            selObj.isenabled = event.target.checked;
        }

        return selObj;
        
    }
}