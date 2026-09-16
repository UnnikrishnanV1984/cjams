
import {share, pluck, map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { DropdownModel, ListDataItem, PaginationInfo } from '../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, GenericService, DataStoreService } from '../../../../@core/services';

import { forkJoin ,  Observable } from 'rxjs';

import { ReferralsResponse } from './_entities/referral.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { DSDSActionSummary } from '../../_entities/caseworker.data.model';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'referral',
    templateUrl: './referral.component.html',
    styleUrls: ['./referral.component.scss'],
    standalone: false
})
export class ReferralComponent implements OnInit {
    daNumber: string;
    intakeServReqTypeId: string;
    createDate = new Date();
    referralAddForm!: FormGroup;
    totalRecords$!: Observable<number>;
    reasonDropdownItems$!: Observable<DropdownModel[]>;
    referredToDropdownItems$!: Observable<DropdownModel[]>;
    dispositionyDropdownItems$!: Observable<DropdownModel[]>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    viewReferralsResponse?: ReferralsResponse;
    dsdsActionsSummary = new DSDSActionSummary();
    referralsResponse$!: Observable<any>;

    constructor(
        private _formBuilder: FormBuilder,
        private _commonHttpService: CommonHttpService,
        private _refferalService: GenericService<ReferralsResponse>,
        private _alertService: AlertService,
        private _dataStoreService: DataStoreService
    ) {
        this.intakeServReqTypeId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }

    ngOnInit() {
        this.initiateFormGroup();
        this.loadDropdownItems();
        this.getPage();
    }
    saveReferral(modal: ReferralsResponse) {
        modal.intakeserviceid = this.intakeServReqTypeId;
        modal.assignedto = 'Neil';
        modal.status = 'Open';
        this.viewReferralsResponse = modal;
        this._refferalService.create(modal, CaseWorkerUrlConfig.EndPoint.DSDSAction.Referrals.IntakeServiceRequestReferralUrl).subscribe(
            (response: any) => {
                this._alertService.success('Referral added successfully!');
                this.getPage();
                this.clearReferralForm();
                $('#myModal-referral-add').modal('hide');
            },
            (error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                return false;
            }
        );
    }
    clearReferralForm() {
        this.referralAddForm.reset();
        this.referralAddForm.patchValue({
            reason: '',
            referredto: '',
            disposition: ''
        });
    }
    private initiateFormGroup() {
        this.referralAddForm = this._formBuilder.group({
            reason: ['', Validators.required],
            referredto: ['', Validators.required],
            status: [''],
            disposition: ['', Validators.required],
            assignedto: [''],
            referralnote: ['', Validators.required]
        });
    }

    private loadDropdownItems() {
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Referrals.ReasonListUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: {},
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Referrals.ReferredToTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: {
                        intakeserviceid: this.intakeServReqTypeId
                    },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Referrals.DispositionListUrl + '?filter'
            )
        ]).pipe(
            map((result) => {
                return {
                    reasons: result[0].map(
                        (res) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.classkey
                            })
                    ),
                    referredToTypes: result[1].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.referredtotypekey
                            })
                    ),
                    dispositions: result[2].map(
                        (res) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.dispositioncode
                            })
                    )
                };
            }),
            share(),);
        this.reasonDropdownItems$ = source.pipe(pluck('reasons'));
        this.referredToDropdownItems$ = source.pipe(pluck('referredToTypes'));
        this.dispositionyDropdownItems$ = source.pipe(pluck('dispositions'));
    }

    private getPage() {
        const source = this._commonHttpService
            .getPagedArrayList(
                {
                    limit: this.paginationInfo.pageSize,
                    order: '',
                    page: 1,
                    count: 10,
                    where: {
                        intakeserviceid: this.intakeServReqTypeId
                    },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Referrals.IntakeServiceRequestReferralListUrl + '?filter'
            ).pipe(
            map((result) => {
                return { data: result };
            }),
            share(),);
        this.referralsResponse$ = source.pipe(pluck('data'));
    }
}
