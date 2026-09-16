
import {EMPTY,  Observable } from 'rxjs';

import {pluck, map, share} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { AlertService, GenericService } from '../../../../../@core/services';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { DATypeScreenStatus, ServiceRequestTypeConfig } from '../_entities/da-type-config.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'user-roles',
    templateUrl: './user-roles.component.html',
    standalone: false
})
export class UserRolesComponent implements OnInit {
    @Input()
    id!: string;
    @Input()
    screenStatus!: DATypeScreenStatus;
    userRolesDropdownList$!: Observable<DropdownModel[]>;
    userRoles$!: Observable<ServiceRequestTypeConfig[]>;
    servicerequesttypeconfigroleurl = 'daconfig/servicerequesttypeconfigrole';
    userRolesForm!: FormGroup;
    constructor(
        private forBuilder: FormBuilder,
        private _serviceRequestTypeConfigService: GenericService<ServiceRequestTypeConfig>,
        private _userRolesDropdown: CommonHttpService,
        private _alertService: AlertService
    ) {
        this._serviceRequestTypeConfigService.endpointUrl = this.servicerequesttypeconfigroleurl;
    }
    ngOnInit() {
        this.formInitilizer();
        this.loadDropdownItems();
        if (this.id !== '0') {
            this.loadUserRoles();
        }
    }
    formInitilizer() {
        this.userRolesForm = this.forBuilder.group({
            entityroletypekey: ['', Validators.required]
        });
    }
    loadDropdownItems() {
        // tslint:disable-next-line:max-line-length
        const source = this._userRolesDropdown
            .getArrayList(
                {
                    where: { itemtype: 0 },
                    order: 'name asc',
                    method: 'get',
                    nolimit: true
                },
                AdminUrlConfig.EndPoint.DAConfig.GetItemStableUrl + '?filter'
            ).pipe(
            map((result) => {
                return { userRoles: result.map((res) => new DropdownModel({ text: res.name, value: res.itemid })) };
            }),
            share(),);
        this.userRolesDropdownList$ = source.pipe(pluck('userRoles'));
    }

    saveItem(modal: ServiceRequestTypeConfig) {
        let User = [];
        this.userRoles$.subscribe(userSelect => {
            if (userSelect) {
                User = userSelect.filter(
                    item => item.name === modal.entityroletypekey
                );
            }
            if (!User.length) {
                this._serviceRequestTypeConfigService.endpointUrl =
                    this.servicerequesttypeconfigroleurl;
                modal = Object.assign(new ServiceRequestTypeConfig(), modal);
                modal.servicerequesttypeconfigid = this.id;
                modal.entityroletype = 'UserRole';
                this._serviceRequestTypeConfigService.create(modal).subscribe((response: any) => {
                    if (response.servicerequesttypeconfigid) {
                        this.userRoles$ = EMPTY;
                        this.loadUserRoles();
                        this.formInitilizer();
                    }
                });
            } else {
                this._alertService.error('User Role alredy exists');
            }
        });
    }

    deleteItem(data: any) {
        this._serviceRequestTypeConfigService
            .patch(data.id, { activeflag: 0 })
            .subscribe((response: any) => {
                if (response) {
                    this.loadUserRoles();
                }
            });
    }
    loadUserRoles() {
        this.userRoles$ = this._serviceRequestTypeConfigService
            .getPagedArrayList(
                {
                    where: {
                        servicerequesttypeconfigid: this.id,
                        activeflag: 1,
                        entityroletype: 'UserRole'
                    },
                    method: 'get'
                },
                this.servicerequesttypeconfigroleurl + '/list?filter'
            ).pipe(
            map((result) => {
                this.screenStatus.hasUserRoles = !(result.data === null || result.data.length === 0);
                return result.data;
            }));
    }
}
