
import {EMPTY,  Observable ,  forkJoin } from 'rxjs';

import {map, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { ControlUtils } from '../../../../@core/common/control-utils';
import { ObjectUtils } from '../../../../@core/common/initializer';
import { DropdownModel, PaginationRequest } from '../../../../@core/entities/common.entities';
import { AlertService, GenericService } from '../../../../@core/services';
import { AuthService } from '../../../../@core/services/auth.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { AdminUrlConfig } from '../../admin-url.config';
import * as categories from './_configurations/category.json';
import * as duedate from './_configurations/duedate.json';
import * as workload from './_configurations/workload.json';
import { DaTypeConfigMainData, DATypeScreenStatus, ServiceRequestDispositionConfig, ServiceRequestTypeConfig } from './_entities/da-type-config.models';
import { LENGTH } from '../../../../@core/entities/constants';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'add-edit-da-type-config',
    templateUrl: './add-edit-da-type-config.component.html',
    styleUrls: ['./add-edit-da-type-config.component.scss'],
    standalone: false
})
export class AddEditDaTypeConfigComponent implements OnInit {
    id = '0';
    hasMainContentFilled = false;
    isEditMode = false;
    addEditDaTypeConfigForm!: FormGroup;
    rolesEntityForm!: FormGroup;
    daTypeDropdownItems$!: Observable<DropdownModel[]>;
    daSubTypeDropdownItems$!: Observable<DropdownModel[]>;
    planTypeDropdownItems$!: Observable<DropdownModel[]>;
    daTypeConfig = new DaTypeConfigMainData();
    daTypeScreenStatus: DATypeScreenStatus = new DATypeScreenStatus();
    dispositions$!: Observable<ServiceRequestDispositionConfig[]>;
    personRolesTypes$!: Observable<ServiceRequestTypeConfig[]>;
    entityCategories$!: Observable<ServiceRequestTypeConfig[]>;
    roleEntityTypeChecked: DaTypeConfigMainData = new DaTypeConfigMainData();
    categoriesDropdown: DropdownModel[] = [];
    workLoadDropdown: DropdownModel[] = [];
    dueDateDropdown: DropdownModel[] = [];
    listurl = '/list?filter';
    constructor(
        private route: ActivatedRoute,
        private router: Router,
        private formBuilder: FormBuilder,
        private _authService: AuthService,
        private _alertService: AlertService,
        private _daTypeConfigService: GenericService<DaTypeConfigMainData>,
        private _commonHttpService: CommonHttpService
    ) {}
    ngOnInit() {
        this.categoriesDropdown = <any>categories;
        this.workLoadDropdown = <any>workload;
        this.dueDateDropdown = <any>duedate;
        this.formGroupInitialize();
        this.loadMainDropdowns();
        this.route.params.subscribe((item) => {
            this.id = item['id'];
            if (this.id !== '0') {
                this.isEditMode = true;
                this._daTypeConfigService.getById(this.id, AdminUrlConfig.EndPoint.DAConfig.ServiceRequestTypeConfigUrl).subscribe((result: any) => {
                    this.hasMainContentFilled = true;
                    this.addEditDaTypeConfigForm.patchValue(result);
                    this.addEditDaTypeConfigForm.patchValue({effectivedate: new Date(result.effectivedate), expirationdate: new Date(result.expirationdate)});
                    this.onChangeDaSubType(result.intakeservreqtypeid);
                    this.roleEntityTypeChecked = result;
                });
            }
            $('#add-DA-configuration').modal('show');
        });
    }
    closeItem() {
        $('#add-DA-configuration').modal('hide');
        this.router.routeReuseStrategy.shouldReuseRoute = function() {
            return false;
        };
        const currentUrl = 'pages/admin/da-config/da-type-config';
        this.router.navigateByUrl(currentUrl).then(() => {
            this.router.navigated = false;
            this.router.navigate([currentUrl]);
        });
    }

    formGroupInitialize() {
        this.addEditDaTypeConfigForm = this.formBuilder.group(
            {
                intakeservreqtypeid: ['', Validators.required],
                servicerequestsubtypeid: ['', Validators.required],
                intakeservicerequestplantypekey: ['', Validators.required],
                internalfile: [false],
                duedateoffset: ['', Validators.required],
                limitedrouting: [false],
                focusroletype: [''],
                category: ['', Validators.required],
                effectivedate: ['', Validators.required],
                expirationdate: ['', [Validators.required , LENGTH.MIN_LENGTH_VALIDATOR]],
                workload: ['', Validators.required],
                intakeserreqstatustypeid: [''],
                displaydatype: [''],
                displaydasubtype: [''],
                focusentitytype: ['']
            },
            { validators: this.checkDateRange }
        );
    }
    checkDateRange(group: FormGroup) {
        if (group.controls.expirationdate.value) {
            if (group.controls.expirationdate.value < group.controls.effectivedate.value) {
                return { notValid: true };
            }
            return null;
        }
    }
    loadMainDropdowns() {
        const source = forkJoin([
            this._commonHttpService.getPagedArrayList(
                new PaginationRequest({
                    order: 'intakeservreqtypekey ASC',
                    nolimit: true,
                    where: { archiveon: null },
                    method: 'get'
                }),
                AdminUrlConfig.EndPoint.DAConfig.DaTypeUrl + this.listurl 
            ),
            this._commonHttpService.getPagedArrayList(
                new PaginationRequest({
                    order: 'intakeservicerequestplantypekey ASC',
                    nolimit: true,
                    where: { activeflag: '1' },
                    method: 'get'
                }),
                AdminUrlConfig.EndPoint.DAConfig.PlanTypeUrl + this.listurl 
            )
        ]).pipe(
            map((resultvalue) => {
                return {
                    daTypes: resultvalue[0].data.map(
                        (res) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.intakeservreqtypeid
                            })
                    ),
                    planTypes: resultvalue[1].data.map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.intakeservicerequestplantypekey
                            })
                    )
                };
            }),
            share(),);
        this.daTypeDropdownItems$ = source.pipe(pluck('daTypes'));
        this.planTypeDropdownItems$ = source.pipe(pluck('planTypes'));
    }
    onChangeDaSubType(intakeservreqtypeid: string) {
        this.daSubTypeDropdownItems$ = this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    order: 'workloadweight ASC',
                    nolimit: true,
                    where: { intakeservreqtypeid: intakeservreqtypeid },
                    method: 'get'
                }),
                AdminUrlConfig.EndPoint.DAConfig.DaConfigSubtypeUrl + this.listurl 
            ).pipe(
            map((result) => {
                return result.data.map(
                    (res) =>
                        new DropdownModel({
                            text: res.classkey,
                            value: res.servicerequestsubtypeid
                        })
                );
            }));
    }
    changeRoleType(roleType: string) {
        if (roleType === 'Role') {
            this.addEditDaTypeConfigForm.get('focusentitytype')?.disable();
            this.addEditDaTypeConfigForm.get('focusroletype')?.enable();
            this.addEditDaTypeConfigForm.patchValue({ focusentitytype: '' });
            this.addEditDaTypeConfigForm.value.focusentitytype = null;
        } else if (roleType === 'Entity') {
            this.addEditDaTypeConfigForm.get('focusroletype')?.disable();
            this.addEditDaTypeConfigForm.get('focusentitytype')?.enable();
            this.addEditDaTypeConfigForm.patchValue({ focusroletype: '' });
            this.addEditDaTypeConfigForm.value.focusroletype = null;
        }
    }
    saveDaType(modal: DaTypeConfigMainData) {
        if (this.addEditDaTypeConfigForm.dirty && this.addEditDaTypeConfigForm.valid) {
            modal = Object.assign(new DaTypeConfigMainData(), modal);
            this._daTypeConfigService.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.ServiceRequestTypeConfigUrl;
            ObjectUtils.removeEmptyProperties(modal);
            if (this.id === '0') {
                modal.insertedby = this._authService.getCurrentUser().userId;
                this._daTypeConfigService.create(modal).subscribe(
                    (response: any) => {
                        this.id = response.servicerequesttypeconfigid;
                        this.isEditMode = true;
                        this.hasMainContentFilled = true;
                        this._alertService.success('Service type saved successfully');
                    }
                );
            }
        } else {
            ControlUtils.validateAllFormFields(this.addEditDaTypeConfigForm);
            ControlUtils.setFocusOnInvalidFields();
            this._alertService.warn('Please fill mandatory fields');
        }
    }
    updateDaType(modal: DaTypeConfigMainData) {
        if (this.addEditDaTypeConfigForm.dirty && this.addEditDaTypeConfigForm.valid) {
            modal = Object.assign(new DaTypeConfigMainData(), modal);
            this._daTypeConfigService.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.ServiceRequestTypeConfigUrl;
            ObjectUtils.removeEmptyProperties(modal);
            modal.updatedby = this._authService.getCurrentUser().userId;
            modal.insertedby = this._authService.getCurrentUser().userId;
            this._daTypeConfigService.patch(this.id, modal).subscribe(
                (response: any) => {
                    this.id = response.servicerequesttypeconfigid;
                    this.hasMainContentFilled = true;
                    this.closeItem();
                    this._alertService.success('Service type updated successfully');
                }
            );
        }
    }
    dispositionListed(dispositions$: Observable<ServiceRequestDispositionConfig[]>) {
        this.dispositions$ = EMPTY;
        this.dispositions$ = dispositions$;
    }
    focusCategoryRolesListed(entityCategories$: Observable<ServiceRequestTypeConfig[]>) {
        this.entityCategories$ = EMPTY;
        this.entityCategories$ = entityCategories$;
    }
    focusRoleTypeListedItems(personRolesTypes$: Observable<ServiceRequestTypeConfig[]>) {
        this.personRolesTypes$ = EMPTY;
        this.personRolesTypes$ = personRolesTypes$;
    }

    get duedateoffsetControl(): FormControl { 
        return this.addEditDaTypeConfigForm.get('duedateoffset') as FormControl; 
    }
    
    get workloadControl(): FormControl { 
        return this.addEditDaTypeConfigForm.get('workload') as FormControl; 
    }

    get expirationdateControl(): FormControl { 
        return this.addEditDaTypeConfigForm.get('expirationdate') as FormControl; 
    }
    
    get effectivedateControl(): FormControl { 
        return this.addEditDaTypeConfigForm.get('effectivedate') as FormControl; 
    }

    get intakeservicerequestplantypekeyControl(): FormControl { 
        return this.addEditDaTypeConfigForm.get('intakeservicerequestplantypekey') as FormControl; 
    }
    
    get servicerequestsubtypeidControl(): FormControl { 
        return this.addEditDaTypeConfigForm.get('servicerequestsubtypeid') as FormControl; 
    }

    get intakeservreqtypeidControl(): FormControl { 
        return this.addEditDaTypeConfigForm.get('intakeservreqtypeid') as FormControl; 
    }
    
    get categoryControl(): FormControl { 
        return this.addEditDaTypeConfigForm.get('category') as FormControl; 
    }
}
