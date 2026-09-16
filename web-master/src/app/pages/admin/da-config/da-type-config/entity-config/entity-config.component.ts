
import {pluck, map, share} from 'rxjs/operators';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable ,  forkJoin } from 'rxjs';

import { DropdownModel, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { GenericService, AlertService } from '../../../../../@core/services';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { DATypeScreenStatus, ServiceRequestTypeConfig } from '../_entities/da-type-config.models';
import { AdminUrlConfig } from '../../../admin-url.config';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'entity-config',
    templateUrl: './entity-config.component.html',
    styleUrls: ['./entity-config.component.scss'],
    standalone: false
})
export class EntityConfigComponent implements OnInit {
    @Input()
    id!: string;
    @Input()
    screenStatus!: DATypeScreenStatus;
    @Output() focusentityCategoryRolesListed = new EventEmitter<Observable<ServiceRequestTypeConfig[]>>();
    entityConfigCategoryForm!: FormGroup;
    entityConfigRolesForm!: FormGroup;
    entityRoles$!: Observable<ServiceRequestTypeConfig[]>;
    entityCategories$!: Observable<ServiceRequestTypeConfig[]>;
    entityRoleDropdownList$!: Observable<DropdownModel[]>;
    entityCategoryDropdownList$!: Observable<DropdownModel[]>;
    servicerequesttypeconfigroleurl = 'daconfig/servicerequesttypeconfigrole';
    constructor(
        private fromBuilder: FormBuilder,
        private _alertService: AlertService,
        private _serviceRequestTypeConfigService: GenericService<ServiceRequestTypeConfig>,
        private _entityConfigHttpService: CommonHttpService
    ) {
        this._serviceRequestTypeConfigService.endpointUrl = this.servicerequesttypeconfigroleurl;
    }
    ngOnInit() {
        this.categoryFormInitilize();
        this.rolesFormInitilize();
        this.loadDropdownItems();
        if (this.id !== '0') {
            this.LoadCategoryEntityRole();
            this.loadEntityRoleType();
        }
    }
    categoryFormInitilize() {
        this.entityConfigCategoryForm = this.fromBuilder.group({
            entityroletypekey: ['', Validators.required]
        });
    }
    rolesFormInitilize() {
        this.entityConfigRolesForm = this.fromBuilder.group({
            entityroletypekey: ['', Validators.required]
        });
    }
    loadDropdownItems() {
        const source = forkJoin([
            this._entityConfigHttpService.getArrayList(new PaginationRequest({ nolimit: true, method: 'get' }), AdminUrlConfig.EndPoint.DAConfig.GetAgencyRoleTypeUrl + '?filter'),
            this._entityConfigHttpService.getArrayList(new PaginationRequest({ nolimit: true, method: 'get' }), AdminUrlConfig.EndPoint.DAConfig.GetAgencyCategoryUrl + '?filter')
        ]).pipe(
            map((resultsVal) => {
                return {
                    entityRoleDropdownList: resultsVal[0].map((res) => new DropdownModel({ text: res.typedescription, value: res.agencyroletypekey })),
                    entityCategoryDropdownList: resultsVal[1].map((res) => new DropdownModel({ text: res.description, value: res.agencycategorykey }))
                };
            }),
            share(),);
        this.entityRoleDropdownList$ = source.pipe(pluck('entityRoleDropdownList'));
        this.entityCategoryDropdownList$ = source.pipe(pluck('entityCategoryDropdownList'));
    }
    saveEntityCategory(modal: ServiceRequestTypeConfig) {
        let Category = [];
        this.entityCategories$.subscribe((categorySelect) => {
            if (categorySelect) {
                Category = categorySelect.filter((item) => item.name === modal.entityroletypekey);
            }
            if (!Category.length) {
                this._serviceRequestTypeConfigService.endpointUrl = this.servicerequesttypeconfigroleurl;
                modal = Object.assign(new ServiceRequestTypeConfig(), modal);
                modal.servicerequesttypeconfigid = this.id;
                modal.entityroletype = 'EntityRole';
                modal.entityroletypekey = this.entityConfigCategoryForm.value.entityroletypekey;
                this._serviceRequestTypeConfigService.create(modal).subscribe(
                    (response: any) => {
                        this._alertService.success('Category added successfully');
                        this.LoadCategoryEntityRole();
                        this.categoryFormInitilize();
                    },
                    (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                this._alertService.error('Category Already exists');
            }
        });
    }

    saveEntityRole(modal: ServiceRequestTypeConfig) {
        let Provider = [];
        this.entityRoles$.subscribe((providerSelect) => {
            if (providerSelect) {
                Provider = providerSelect.filter((item) => item.name === modal.entityroletypekey);
            }
            if (!Provider.length) {
                this._serviceRequestTypeConfigService.endpointUrl = this.servicerequesttypeconfigroleurl;
                modal = Object.assign(new ServiceRequestTypeConfig(), modal);
                modal.servicerequesttypeconfigid = this.id;
                modal.entityroletype = 'EntityRoleType';
                modal.entityroletypekey = this.entityConfigRolesForm.value.entityroletypekey;
                this._serviceRequestTypeConfigService.create(modal).subscribe(
                    (_response: any) => {
                        this._alertService.success('Provider added successfully');
                        this.loadEntityRoleType();
                        this.rolesFormInitilize();
                    },
                    (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                this._alertService.error('Provider Already exists');
            }
        });
    }
    deleteCategoryRole(data: any) {
        this._serviceRequestTypeConfigService.endpointUrl = this.servicerequesttypeconfigroleurl;
        this._serviceRequestTypeConfigService.patch(data.id, { activeflag: 0 }).subscribe(
            (response: any) => {
                if (response) {
                    this.LoadCategoryEntityRole();
                }
            },
            (_error: any) => {
            }
        );
    }
    deleteEntiryRoleType(data: any) {
        this._serviceRequestTypeConfigService.endpointUrl = this.servicerequesttypeconfigroleurl;
        this._serviceRequestTypeConfigService.patch(data.id, { activeflag: 0 }).subscribe(
            (response: any) => {
                if (response) {
                    this.loadEntityRoleType();
                }
            },
            (_error: any) => {
            }
        );
    }

    LoadCategoryEntityRole() {
        this._entityConfigHttpService.endpointUrl = this.servicerequesttypeconfigroleurl;
        this.entityCategories$ = this._entityConfigHttpService
            .getPagedArrayList(
                {
                    where: {
                        servicerequesttypeconfigid: this.id,
                        activeflag: 1,
                        entityroletype: 'EntityRole'
                    },
                    method: 'get'
                },
                this.servicerequesttypeconfigroleurl + '/list?filter'
            ).pipe(
            map((result) => {
                this.screenStatus.hasEntityRole = !(result.data === null || result.data.length === 0);
                return result.data;
            }));
        this.focusentityCategoryRolesListed.emit(this.entityCategories$);
    }
    loadEntityRoleType() {
        this._entityConfigHttpService.endpointUrl = this.servicerequesttypeconfigroleurl;
        this.entityRoles$ = this._entityConfigHttpService
            .getAllPaged({
                where: {
                    servicerequesttypeconfigid: this.id,
                    activeflag: 1,
                    entityroletype: 'EntityRoleType'
                }
            }).pipe(
            map((result) => {
                this.screenStatus.hasEntityConfig = !(result.data === null || result.data.length === 0);
                return result.data;
            }));
    }
}
