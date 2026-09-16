
import {EMPTY,  Observable } from 'rxjs';

import {map} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { DropdownModel, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { GenericService, AlertService } from '../../../../../@core/services';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { DATypeScreenStatus, ServiceRequestTypeConfig } from '../_entities/da-type-config.models';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'doc-type',
    templateUrl: './doc-type.component.html',
    standalone: false
})
export class DocTypeComponent implements OnInit {
    @Input()
    id!: string;
    @Input()
    screenStatus!: DATypeScreenStatus;
    docTypeDropdownList$!: Observable<DropdownModel[]>;
    docTypes$!: Observable<ServiceRequestTypeConfig[]>;
    docTypeForm!: FormGroup;
    constructor(
        private formBuilder: FormBuilder,
        private _alertService: AlertService,
        private _serviceRequestTypeConfigService: GenericService<ServiceRequestTypeConfig>,
        private _docTypeDropdown: CommonHttpService
    ) {}
    ngOnInit() {
        this.formInitilize();
        this.docTypeDropdownList();
        if (this.id !== '0') {
            this.loadDocType();
        }
    }

    formInitilize() {
        this.docTypeForm = this.formBuilder.group({
            entityroletypekey: ['', Validators.required]
        });
    }
    private docTypeDropdownList() {
        this.docTypeDropdownList$ = this._docTypeDropdown
            .getArrayList(new PaginationRequest({ nolimit: true, method: 'get' }), AdminUrlConfig.EndPoint.DAConfig.GetProviderAgreementDocTypeUrl + '?filter').pipe(
            map((result) => {
                return result.map((res) => new DropdownModel({ text: res.typedescription, value: res.provideragreementdocumenttypekey }));
            }));
    }
    saveItem(modal: ServiceRequestTypeConfig) {
        let Doctype = [];
        this.docTypes$.subscribe((docSelect) => {
            if (docSelect) {
                Doctype = docSelect.filter((item) => item.name === modal.entityroletypekey);
            }
            if (!Doctype.length) {
                this._serviceRequestTypeConfigService.endpointUrl = 'daconfig/servicerequesttypeconfigrole';
                modal = Object.assign(new ServiceRequestTypeConfig(), modal);
                modal.servicerequesttypeconfigid = this.id;
                modal.entityroletype = 'DocumentType';
                modal.entityroletypekey = this.docTypeForm.value.entityroletypekey;
                this._serviceRequestTypeConfigService.create(modal).subscribe(
                    (_response: any) => {
                        this._alertService.success('DocumentType added successfully');
                        this.docTypes$ = EMPTY;
                        this.loadDocType();
                        this.formInitilize();
                    },
                    (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                this._alertService.error('DocumentType Already exists');
            }
        });
    }
    deleteDocType(data: any) {
        this._serviceRequestTypeConfigService.patch(data.id, { activeflag: 0 }).subscribe(
            (_response: any) => {
                this.loadDocType();
            },
            (_error: any) => {
            }
        );
    }
    loadDocType() {
        this._serviceRequestTypeConfigService.endpointUrl = 'daconfig/servicerequesttypeconfigrole';
        this.docTypes$ = this._serviceRequestTypeConfigService
            .getPagedArrayList(
                {
                    where: {
                        servicerequesttypeconfigid: this.id,
                        activeflag: 1,
                        entityroletype: 'DocumentType'
                    },
                    method: 'get'
                },
                'daconfig/servicerequesttypeconfigrole/list?filter'
            ).pipe(
            map((result) => {
                this.screenStatus.hasDocType = !(result.data === null || result.data.length === 0);
                return result.data;
            }));
    }
}
