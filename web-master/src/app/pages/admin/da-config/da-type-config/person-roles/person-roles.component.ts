
import {EMPTY,  Observable } from 'rxjs';

import {map} from 'rxjs/operators';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { DropdownModel, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { GenericService, AlertService } from '../../../../../@core/services';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { DATypeScreenStatus, ServiceRequestTypeConfig } from '../_entities/da-type-config.models';
import { AdminUrlConfig } from '../../../admin-url.config';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-roles',
    templateUrl: './person-roles.component.html',
    standalone: false
})
export class PersonRolesComponent implements OnInit {
    @Input()
    id!: string;
    @Input()
    screenStatus!: DATypeScreenStatus;
    @Output() focusRoleTypeListedItems = new EventEmitter<Observable<ServiceRequestTypeConfig[]>>();
    personRolesForm!: FormGroup;
    personRoleDropdownItems$!: Observable<DropdownModel[]>;
    personRolesTypes$!: Observable<ServiceRequestTypeConfig[]>;
    servicerequesttypeconfigroleurl = 'daconfig/servicerequesttypeconfigrole';
    constructor(
        private formBuilder: FormBuilder,
        private _alertService: AlertService,
        private _personRolesservice: GenericService<ServiceRequestTypeConfig>,
        private _commonService: CommonHttpService
    ) {
        this._personRolesservice.endpointUrl = this.servicerequesttypeconfigroleurl;
    }
    ngOnInit() {
        this.formInitilizer();
        this.personRoleDropdownItems$ = this._commonService
            .getArrayList(new PaginationRequest({ nolimit: true, method: 'get' }), AdminUrlConfig.EndPoint.General.ActorTypeUrl + '?filter').pipe(
            map((result) => {
                return result.map(
                    (res) =>
                        new DropdownModel({
                            text: res.typedescription,
                            value: res.actortype
                        })
                );
            }));
        if (this.id !== '0') {
            this.loadPersonRoles();
        }
    }
    formInitilizer() {
        this.personRolesForm = this.formBuilder.group({
            entityroletypekey: ['', Validators.required],
            isdefault: ['']
        });
    }
    saveItem(modal: ServiceRequestTypeConfig) {
        let Person = [];
        this.personRolesTypes$.subscribe((personSelect) => {
            if (personSelect) {
                Person = personSelect.filter((item) => item.name === modal.entityroletypekey);
            }
            if (!Person.length) {
                this._personRolesservice.endpointUrl = this.servicerequesttypeconfigroleurl;
                modal = Object.assign(new ServiceRequestTypeConfig(), modal);
                modal.servicerequesttypeconfigid = this.id;
                modal.isdefault = this.personRolesForm.value.isdefault;
                modal.entityroletype = 'PersonRole';
                this._personRolesservice.create(modal).subscribe(
                    (response: any) => {
                        this._alertService.success('PersonRoles added successfully');
                        this.personRolesTypes$ = EMPTY;
                        this.loadPersonRoles();
                        this.formInitilizer();
                    },
                    (error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                this._alertService.error('PersonRoles Already exists');
            }
        });
    }
    deleteItem(data: any) {
        this._personRolesservice.patch(data.id, { activeflag: 0 }).subscribe((response: any) => {
            if (response) {
                this.loadPersonRoles();
            }
        });
    }
    loadPersonRoles() {
        const this$ = this;
        this._personRolesservice.endpointUrl = this.servicerequesttypeconfigroleurl;
        this$.personRolesTypes$ = this._personRolesservice
            .getPagedArrayList(
                {
                    where: {
                        servicerequesttypeconfigid: this.id,
                        activeflag: 1,
                        entityroletype: 'PersonRole',
                        nolimit: true
                    },
                    method: 'get'
                },
                this.servicerequesttypeconfigroleurl + '/list?filter'
            ).pipe(
            map((result) => {
                this.screenStatus.hasPersonRoles = !(result.data === null || result.data.length === 0);
                return result.data;
            }));
        this.focusRoleTypeListedItems.emit(this$.personRolesTypes$);
    }
}
