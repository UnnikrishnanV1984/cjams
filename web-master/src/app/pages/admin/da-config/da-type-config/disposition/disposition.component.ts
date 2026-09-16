
import {map, share, pluck} from 'rxjs/operators';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable ,  forkJoin } from 'rxjs';

import { DropdownModel, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { GenericService, AlertService } from '../../../../../@core/services';
import { AuthService } from '../../../../../@core/services/auth.service';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { DATypeScreenStatus, ServiceRequestDispositionConfig } from '../_entities/da-type-config.models';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'disposition',
    templateUrl: './disposition.component.html',
    standalone: false
})
export class DispositionComponent implements OnInit {
    @Input()
    id!: string;
    @Input()
    screenStatus!: DATypeScreenStatus;
    @Output() dispositionListed = new EventEmitter<Observable<ServiceRequestDispositionConfig[]>>();
    descriptionLabel!: string;
    dispositions$!: Observable<ServiceRequestDispositionConfig[]>;
    dispositionStatusDropDownList$!: Observable<DropdownModel[]>;
    dispositionTypeDropDownList$!: Observable<DropdownModel[]>;
    dispositionsForm!: FormGroup;
    isDjsUser = false;
    constructor(
        private formBuilder: FormBuilder,
        private _authService: AuthService,
        private _alertService: AlertService,
        private _dispositionConfigService: GenericService<ServiceRequestDispositionConfig>,
        private _dispositionHttpService: CommonHttpService
    ) {
        this._dispositionConfigService.endpointUrl = 'daconfig/servicerequesttypeconfigdispositioncode';
    }
    ngOnInit() {
        this.formInitilize();
        this.loadDropdownItems();
        if (this.id !== '0') {
            this.loadDispositions();
        }
        if (this._authService.getCurrentUser().role.teamtypekey === 'DJS') {
            this.isDjsUser = true;
        }
    }
    formInitilize() {
        this.dispositionsForm = this.formBuilder.group({
            intakeserreqstatustypeid: ['', Validators.required],
            dispositioncode: ['', Validators.required],
            recommendationtype: ['']
        });
    }
    private loadDropdownItems() {
        const source = forkJoin([
            this._dispositionHttpService.getArrayList(new PaginationRequest({ nolimit: true, method: 'get' }), AdminUrlConfig.EndPoint.General.IntakeSerReqstStatusTypeUrl + '?filter'),
            this._dispositionHttpService.getArrayList(new PaginationRequest({ where: {}, nolimit: true, method: 'get' }), AdminUrlConfig.EndPoint.General.DispositionCodeUrl + '?filter')
        ]).pipe(
            map((result) => {
                return {
                    dispStatusList: result[0].map((res) => new DropdownModel({ text: res.intakeserreqstatustypekey, value: res.intakeserreqstatustypeid })),
                    dispTypeList: result[1].map((res) => new DropdownModel({ text: res.description, value: res.dispositioncode }))
                };
            }),
            share(),);
        this.dispositionStatusDropDownList$ = source.pipe(pluck('dispStatusList'));
        this.dispositionTypeDropDownList$ = source.pipe(pluck('dispTypeList'));
    }
    setDispositionLabel(option: any) {
        this.descriptionLabel = option.label.trim();
    }
    saveItem(modal: ServiceRequestDispositionConfig) {
        modal = Object.assign(new ServiceRequestDispositionConfig(), modal);
        this._dispositionConfigService.endpointUrl = 'daconfig/servicerequesttypeconfigdispositioncode/';
        modal.servicerequesttypeconfigid = this.id;
        modal.description = this.descriptionLabel;
        modal.insertedby = this._authService.getCurrentUser().userId;
        this._dispositionConfigService.create(modal).subscribe(
            (_response: any) => {
                this._alertService.success('DocumentType added successfully');
                this.loadDispositions();
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
        this.dispositionsForm.patchValue({ intakeserreqstatustypeid: '', dispositioncode: '' });
    }
    deleteItem(data: any) {
        this._dispositionConfigService.endpointUrl = 'daconfig/servicerequesttypeconfigdispositioncode';
        this._dispositionConfigService.patch(data.servicerequesttypeconfigiddispostionid, { activeflag: 0 }).subscribe(
            (response: any) => {
                if (response) {
                    this.loadDispositions();
                }
            }
        );
    }
    loadDispositions() {
        this._dispositionConfigService.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.GetDispositionCodeUrl + '?filter';
        this.dispositions$ = this._dispositionConfigService
            .getArrayList({
                include: 'intakeserreqstatustype',
                where: {
                    servicerequesttypeconfigid: this.id,
                    activeflag: 1
                },
                method: 'get'
            }).pipe(
            map((result) => {
                const dispositions = result.map((model) => new ServiceRequestDispositionConfig(model));
                this.screenStatus.hasDispositions = !(dispositions === null || dispositions.length === 0);
                return dispositions;
            }),
            share(),);
        this.dispositionListed.emit(this.dispositions$);
    }
}
