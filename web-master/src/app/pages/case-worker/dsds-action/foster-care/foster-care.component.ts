
import {pluck, share, map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import moment from 'moment';
import { Observable } from 'rxjs';

import { AppConstants } from './../../../../@core/common/constants';
import { PaginationInfo, PaginationRequest } from './../../../../@core/entities/common.entities';
import { AlertService, AuthService, CommonHttpService, SessionStorageService, DataStoreService } from './../../../../@core/services';
import { InvolvedPerson } from './../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from './../../case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { FinanceUrlConfig } from '../../../finance/finance.url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'foster-care',
    templateUrl: './foster-care.component.html',
    styleUrls: ['./foster-care.component.scss'],
    standalone: false
})
export class FosterCareComponent implements OnInit {
    id!: string;
    daNumber!: string;
    placementStrType: any[] = [];
    bundledPlcmntServicesType: any[] = [];
    childCharacteristics: any[] = [];
    fcProviderSearch: any[] = [];
    otherLocalDeptmntType: any[] = [];
    providerSearchForm!: FormGroup;
    referalForm!: FormGroup;
    exitForm!: FormGroup;
    addPlacementForm!: FormGroup;
    cpaEntryExitForm!: FormGroup;
    involevedPerson$!: Observable<InvolvedPerson[]>;
    selectedProvider: any;
    ResponseRejectedList: any[] = [];
    ResponseAcceptedList: any[] = [];
    isAddPlacement = false;
    reportedChildDob: any;
    intakeservicerequestactorid: any;
    selectedChild!: InvolvedPerson | null;
    selectedPlacementStructure: any;
    placement$!: Observable<any[]>;
    placementCount$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    markersLocation: Array<any> = [];
    zoom!: number;
    defaultLat!: number;
    defaultLng!: number;
    selectedPlacement: any;
    userRole: any;
    isSupervisor!: boolean;
    selectedResponseStructure: any;
    exitTypeList: any[] = [];
    reasonForExitList: any[] = [];
    childHistory: any[] = [];
    cpaHomeList: any[] = [];
    cpaChildHistory: any[] = [];
    isChildRemoval = false;
    childRemovalData: any[] = [];
    isExit!: boolean;
    showReviewStats!: boolean;
    reviewStats: any;
    childPaymentHistory: any[] = [];
    childPaymentHistory$!: Observable<any[]>;
    accountpayableList: any;
    paymentDetails: any;

    isPublicProvider!: boolean;
    isPrivateProvider!: boolean;
    isServiceCase!: boolean;
    isDateTime!: boolean;
    fcTotal!: number;
    fcpaginationInfo: PaginationInfo = new PaginationInfo();
    comarRateRequired!: boolean;
    inputRequest!: Object;

    dtformat = 'YYYY-MM-DD';
    addplacementpopupid = '#addPlacement';
    placementexitapproved = 'Placement Exit Approved';
    placementexitrejected = 'Placement Exit Rejected';
    placementapproved = 'placement Approved';

    constructor(private _commonService: CommonHttpService, private formBuilder: FormBuilder,
        private _alertService: AlertService, private _authService: AuthService,
        private _session: SessionStorageService, private _dataStoreService: DataStoreService) {
    }

    ngOnInit() {
        this.isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        if (this.isServiceCase) {
            this.inputRequest = {
                objectid: this.id,
                objecttypekey: 'servicecase'
            };
        } else {
            this.inputRequest = { intakeservreqid: this.id };
        }
        this.initProviderSearchForm();
        this.initReferalForm();
        this.initaddPlacementForm();
        this.initExitForm();
        this.initCpaEntryExitFormForm();

        this.getBundledPlcmntServicesType();
        this.getChildCharacteristics();
        this.getOtherLocalDeptmntType();
        this.getPlacementStrType(null);
        this.getExitTypeList();
        this.getPlacement(1);
        this.getInvolvedPerson();
        this.isSupervisor = (this._authService.getCurrentUser().role.name === AppConstants.ROLES.SUPERVISOR) ? true : false;
        this.getChildRemoval();
        this.isPublicProvider = false;
        this.isPrivateProvider = false;
        this.isDateTime = false;
    }

    getChildRemoval() {
        this._commonService.getSingle(
            {
                where: this.inputRequest,
                method: 'get'
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                .GetChildRemovalList + '?filter'
        )
            .subscribe(result => {
                if (result && result.length) {
                    this.isChildRemoval = true;
                    this.childRemovalData = result;
                }
            });
    }

    showPlacementInfo(placement: any) {
        this.selectedPlacement = placement;
        this.showReviewStats = !!(this.selectedPlacement.status === 'Review' && this.selectedPlacement.placementlog && this.selectedPlacement.placementlog.length);
        if (this.showReviewStats) {
            this.reviewStats = this.selectedPlacement.placementlog[this.selectedPlacement.placementlog.length - 1];
        }
        (<any>$('#placement-view')).modal('show');
    }

    initProviderSearchForm() {
        this.providerSearchForm = this.formBuilder.group({
            childcharacteristics: [null],
            bundledplacementservices: [null],
            otherLocalDeptmntTypeId: [null],
            placementstructures: [null],
            zipcode: [''],
            isLocalDpt: [false],
            firstname: [''],
            middlename: [''],
            lastname: [''],
            isgender: [false],
            isAge: [false],
            providerid: [''],
            agemin: null,
            agemax: null,
            gender: null
        });
    }

    initReferalForm() {
        this.referalForm = this.formBuilder.group({
            sentDate: [null],
            description: [null],
            responseAccepted: [null],
            responseRejected: [null],
            placementStructure: [''],
            comarRate: [''],
            begindate: [null],
            begintime: ['08:00'],
            ifcapproval: [false],
            ifcapprovaldt: [null],
            reasonnonpreferredtx: ['']
        });
        this.referalForm.get('ifcapproval')?.disable();
        this.referalForm.get('ifcapprovaldt')?.disable();
    }

    initaddPlacementForm() {
        this.addPlacementForm = this.formBuilder.group({
            providerid: [null],
            providername: [null],
            localdept: [null],
            phonenumber: [null],
            schooldistrict: [''],
            direction: [''],
            address: [null],
            programname: [null],
            programstructure: [null],
            removaldate: [null],
            comarrate: [null],
            fiscalcategorycode: [null],
            mostrecentfiscalcode: [''],
            begindate: [''],
            entrytime: [null],
            mpp: [false],
            cop: [false],
            icpc: [false],
        });
    }

    initExitForm() {
        this.exitForm = this.formBuilder.group({
            providerid: [null],
            providername: [null],
            localdept: [null],
            phonenumber: [null],
            schooldistrict: [''],
            direction: [''],
            address: [null],
            programname: [null],
            programstructure: [null],
            removaldate: [null],
            comarrate: [null],
            fiscalcategorycode: [null],
            mostrecentfiscalcode: [''],
            startdate: [''],
            starttime: [null],
            enddate: [''],
            endtime: [null],
            exitType: [null],
            reasonforexit: [null],
            explanation: [''],
        });
    }

    initCpaEntryExitFormForm() {
        this.cpaEntryExitForm = this.formBuilder.group({
            homeproviderid: [null],
            homeprovidername: [null],
            programname: [null],
            homestartdate: [null],
            homestarttime: [null],
            homeenddate: [null],
            homeaddress: [''],
            homeendtime: [null],
            homeexitType: [null],
            homereasonforexit: [null],
            homenotes: [''],
        });
    }
    isdateTimeChanged() {
        this.isDateTime = true;
    }
    getPlacement(page: number) {
        const source = this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    page: page,
                    limit: this.paginationInfo.pageSize,
                    where: {
                        casenumber: this.daNumber
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fostercarereferallistUrl + '?filter'
            ).pipe(
            map((res) => {
                return {
                    data: res.data,
                    count: res.count
                };
            }),
            share(),);
        this.placement$ = source.pipe(pluck('data'));
        if (page === 1) {
            this.placementCount$ = source.pipe(pluck('count'));
        }
    }

    getPlacementWithPersonId(page: number, personidtemp: any) {
        const source = this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    page: page,
                    limit: this.paginationInfo.pageSize,
                    where: {
                        casenumber: this.daNumber,
                        personid: personidtemp
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fostercarereferallistUrl + '?filter'
            ).pipe(
            map((res) => {      // NOSONAR      // This function has less than 3 lines of identical code. Hence markng it as no sonar.
                return {
                    data: res.data,
                    count: res.count
                };
            }),
            share(),);
        this.placement$ = source.pipe(pluck('data'));
        if (page === 1) {
            this.placementCount$ = source.pipe(pluck('count'));
        }
    }

    pesonDateOfBirth(item: any) {
        this.reportedChildDob = item.value.dob;
        this.intakeservicerequestactorid = item.value.intakeservicerequestactorid;
        this.selectedChild = item.value;
        this.getPlacementWithPersonId(1, this.selectedChild?.personid);
        this.placement$.pipe(
            map((res) => {
                const id = item.value.cjamspid;
                const blah = res.find((ite) => (ite.clientid === id && item.placementexitdate));
                if (blah) {
                    this.isAddPlacement = false;
                } else {
                    this.isAddPlacement = true;
                }
            }))
            .subscribe();
    }

    getInvolvedPerson() {
        this.involevedPerson$ = this._commonService
            .getArrayList(
                {
                    method: 'get',
                    where: this.inputRequest
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            ).pipe(
            map((res: any) => {
                return res['data'].filter((item: any) => item.rolename === 'CHILD' || item.rolename === 'RC' || item.rolename === 'AV');
            }));
    }

    getBundledPlcmntServicesType() {
        this._commonService.getArrayList(new PaginationRequest({
            nolimit: true,
            method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.bundledPlcmntServicesTypeUrl).subscribe(result => {
            this.bundledPlcmntServicesType = result;
        });
    }

    getChildCharacteristics() {
        this._commonService.getArrayList(new PaginationRequest({
            where: {
                'picklist_type_id': '43'
            },
            nolimit: true,
            method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.childCharacteristicsUrl).subscribe(result => {
            this.childCharacteristics = result;
        });
    }

    getResponseAcceptedList() {
        this._commonService.getArrayList(new PaginationRequest({
            where: {
                'picklist_type_id': '756'
            },
            nolimit: true,
            method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.childCharacteristicsUrl).subscribe(result => {
            this.ResponseAcceptedList = result;
        });
    }

    getResponseRejectedList() {
        this._commonService.getArrayList(new PaginationRequest({
            where: {
                'picklist_type_id': '143'
            },
            nolimit: true,
            method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.childCharacteristicsUrl).subscribe(result => {
            this.ResponseRejectedList = result;
        });
    }

    getChildHistory() {
        if (this.selectedChild && this.selectedChild.cjamspid) {
            this.accountpayableList = [];
            this._commonService.getPagedArrayList(
                new PaginationRequest({
                    limit: this.paginationInfo.pageSize,
                    page: this.paginationInfo.pageNumber,
                    method: 'post',
                    where: {
                        clientid: this.selectedChild.cjamspid
                    }
                }), 'tb_payment_header/getAccountsPayableHeaderForCase'
            ).subscribe((result: any) => {
                if (result) {
                    this.accountpayableList = result.data;
                }
            });
        }
    }

    toggleTable(id: string, paymentid: string) {
        (<any>$('.collapse.in')).collapse('hide');
        (<any>$('#' + id)).collapse('toggle');
        this._commonService.getPagedArrayList(new PaginationRequest({
            where: {
                clientid: this.selectedChild?.cjamspid,
                paymentid: paymentid
            },
            page: 1,
            limit: 10,
            method: 'post'
        }), FinanceUrlConfig.EndPoint.accountsPayable.getAccountsPayableInfo).subscribe(res => {
            this.paymentDetails = res.data;
        });
    }

    getCPAChildHistory() {
        this._commonService.getPagedArrayList(new PaginationRequest({
            where: {
                'casenumber': this.daNumber,
                'placement_id': this.selectedPlacement.placement_id
            },
            nolimit: true,
            method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.cpaHomePlacementLHistoryUrl + '?filter').subscribe(result => {
            this.cpaChildHistory = result.data;
        });
    }

    getCPAHomeList() {
        this._commonService.getArrayList(new PaginationRequest({
            where: {
                'provider_parent_id': this.selectedPlacement.provider_parent_id
            },
            nolimit: true,
            method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.cpaHomeProviderNameUrl + '?filter').subscribe(result => {
            this.cpaHomeList = result;
        });

    }

    getExitTypeList() {
        this._commonService.getArrayList(new PaginationRequest({
            where: {
                'picklist_type_id': '737'
            },
            nolimit: true,
            method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.ExitTypeUrl + '?filter').subscribe(result => {
            this.exitTypeList = result;
        });
    }

    getReasonForExitList(event: any) {
        this._commonService.getArrayList(new PaginationRequest({
            where: {
                'picklist_value_cd': event.value
            },
            nolimit: true,
            method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.ExitReasonTypeUrl + '?filter').subscribe(result => {
            this.reasonForExitList = result;
        });
    }

    addPlacementRequest() {
        const body = {
            'medicaid_paid_sw': (this.addPlacementForm.getRawValue().mpp) ? 'Y' : 'N',
            'court_ordered_sw': (this.addPlacementForm.getRawValue().cop) ? 'Y' : 'N',
            'icpc_approved_sw': (this.addPlacementForm.getRawValue().icpc) ? 'Y' : 'N',
            'entry_dt': moment(this.addPlacementForm.getRawValue().begindate).format(this.dtformat),
            'entry_tm': this.addPlacementForm.getRawValue().entrytime
        };

        this._commonService.patch(this.selectedPlacement.placement_id, body, CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.addPlacementRequestUrl).subscribe(result => {
            this.selectedChild = null;
            this.getPlacement(1);
            (<any>$(this.addplacementpopupid)).modal('hide');
            this._alertService.success('Successfully addedd to placement');

        });
    }

    addCPAHomePlacement() {
        const cpa = this.cpaEntryExitForm.getRawValue();
        const body = {
            'placement_id': this.selectedPlacement.placement_id,
            'provider_id': cpa.homeproviderid,
            'entry_dt': cpa.homestartdate,
            'entry_tm': moment(cpa.homestarttime).format('HH.mm.ss'),
            'exit_dt': cpa.homeenddate,
            'exit_tm': moment(cpa.homeendtime).format('HH.mm.ss'),
            'exit_type_cd': cpa.homeexitType,
            'exit_reason_cd': cpa.homereasonforexit,
            'comments_tx': cpa.homenotes

        };
        this._commonService.create(body, CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.addcpaHomeplacementUrl).subscribe(result => {
            if (this.selectedPlacement.provider_category_cd !== 3302) {
                this.getPlacement(1);
                (<any>$(this.addplacementpopupid)).modal('hide');
            } else {
                (<any>$('#entry_view')).click();
            }
            this.selectedChild = null;
            this._alertService.success('Successfully addedd to placement');

        });
    }

    placementExitOrUpdate() {
        const exitOrUpdate = this.exitForm.getRawValue();
        const body = {
            entry_dt: moment(exitOrUpdate.startdate).format(this.dtformat),
            entry_tm: exitOrUpdate.starttime,
            'exit_reason_cd': exitOrUpdate.reasonforexit,
            'exit_type_cd': exitOrUpdate.exitType,
            'exit_explanation_tx': exitOrUpdate.explanation,
            'exit_dt': exitOrUpdate.enddate ? moment(exitOrUpdate.enddate).format(this.dtformat) : null,
            'exit_tm': exitOrUpdate.endtime,
            placement_id: this.selectedPlacement.placement_id,
            intakeserviceid: this.id,
            delete_sw: 'N'
        };
        this._commonService.create(body, CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.placementexitapproval)
            .subscribe(result => {
                this.selectedChild = null;
                this.getPlacement(1);
                (<any>$('#exit')).modal('hide');
                this._alertService.success(`${this.isExit ? 'Exit request send for approval.' : 'Change request send for approval.'}`);

            });
        this.isDateTime = false;
    }


    approveOrReject(placementID: string, isApprove: boolean) {
        const request = isApprove ? {
            objectid: placementID,
            eventcode: 'PLTR',
            status: 'Approved',
            comments: this.placementexitapproved,
            notifymsg: this.placementexitapproved,
            routeddescription: this.placementexitapproved
        } : {
                objectid: placementID,
                eventcode: 'PLTR',
                status: 'Rejected',
                comments: this.placementexitrejected,
                notifymsg: this.placementexitrejected,
                routeddescription: this.placementexitrejected
            };

        this._commonService.create(request, CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.approveOrReject)
            .subscribe(result => {
                this.getPlacement(1);
                this._alertService.success(`${isApprove ? 'Approved successfully.' : 'Rejected successfully.'}`);

            });
    }

    approvePlacementRequest(placement: { placement_id: string; }) {
        const body = {
            'objectid': this.id,
            'eventcode': 'PLAREF',
            'status': 'Approved',
            'comments': this.placementapproved,
            'notifymsg': this.placementapproved,
            'routeddescription': this.placementapproved,
            'approval_status_cd': '3047'
        };
        this._commonService.patch(placement.placement_id, body,
            CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.approvePlacementRequestUrl).subscribe(result => {
                this._alertService.success('Successfully approved placement');
                this.getPlacement(1);
            });
    }

    rejectPlacementRequest(placement: { placement_id: string; }) {
        this._commonService.patch(placement.placement_id, { 'approval_status_cd': '3281' }
            , CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.rejectPlacementRequestUrl).subscribe(result => {
                this._alertService.success('Successfully rejected placement');
                this.getPlacement(1);
            });
    }

    getFcProviderSearch() {
        const formValues = this.providerSearchForm.getRawValue();
        let body: any = {};
        Object.assign(body, formValues);
        body['localdepartmenthomecaregiver'] = this.isPublicProvider;



        const dob = moment(this.reportedChildDob);
        const age16 = dob.clone().add(16, 'years');
        const age21 = dob.clone().add(21, 'years');
        const isAgeBtwn16And18 = moment().isBetween(age16, age21, null, '[]');
        if (isAgeBtwn16And18 && formValues.placementStrTypeId === '1') {// Independent Living Residential Program
            this._alertService.error('A child between the age of 16 and 21 years cannot be placed in \'Independent Living Residential Program\' Placement Structure.');
            return false;
        }
        body = {
            childcharacteristics: parseInt(formValues.childCharacteristicsid, 10),
            placementstructures: parseInt(formValues.placementStrTypeId, 10),
            bundledplacementservices: parseInt(formValues.bundledPlcmntServicesTypeId, 10),
            providerid: formValues.providerid,
            zipcode: parseInt(formValues.zipcode, 10),
            localdepartmenthomecaregiver: formValues.isLocalDpt
        };
        this._commonService.getPagedArrayList(new PaginationRequest({
            where: body,
            page: this.paginationInfo.pageNumber,
            limit: 10,
            method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fcProviderSearchUrl).subscribe(result => {
            this.fcProviderSearch = result.data;
            this.fcTotal = result.count;
            (<any>$('#fc_list')).click();
        });
    }

    fcPageChanged(pageEvent: { page: number; }) {
        this.paginationInfo.pageNumber = pageEvent.page;
        this.getFcProviderSearch();
    }

    getOtherLocalDeptmntType() {
        this._commonService.getArrayList(new PaginationRequest({
            where: {
                'picklist_type_id': '104'
            },
            nolimit: true,
            method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.otherLocalDeptmntTypeUrl).subscribe(result => {
            this.otherLocalDeptmntType = result;
        });
    }

    getPlacementStrType(providerId: any) {
        this._commonService.getArrayList(new PaginationRequest({
            where: {
                'structure_service_cd': 'P',
                'provider_id': providerId
            },
            nolimit: true,
            method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.placementStrTypeUrl).subscribe(result => {
            this.placementStrType = result;
        });
    }

    saveReferal() {
        if (this.referalForm.valid) {
            const referalDetails = this.referalForm.getRawValue();

            const referalDate: any = new Date(referalDetails.begindate);
            const timeSplit = referalDetails.begintime.split(':');
            let referalTimeHour: number = Number(timeSplit[0]);
            const referalTimeMinPlusMeridiem = timeSplit[1];
            const referalTimeMinAndMeridiem = referalTimeMinPlusMeridiem.split(' ');
            const appointmentTimeMin = referalTimeMinAndMeridiem[0];
            const meridiem = referalTimeMinAndMeridiem[1];

            if (meridiem === 'PM') {
                referalTimeHour += 12;
            }

            referalDate.setHours(referalTimeHour);
            referalDate.setMinutes(appointmentTimeMin);

            if (this.isChildRemoval && this.childRemovalData && this.childRemovalData[0].hasOwnProperty('removaldate')) {
                const removalDate = new Date(this.childRemovalData[0].removaldate);

                if (referalDate < removalDate) {
                    this._alertService.warn('Placement entry begin date should be greater than child removal date.');
                    return false;
                }
            }

            const body = this.prepareReferralData(referalDetails);
            this._commonService.create(body, CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.saveReferalUrl).subscribe(result => {
                this._alertService.success('Placement sent for Approval');
                this.getPlacementWithPersonId(1, this.selectedChild?.personid);
                (<any>$('#addReferal')).modal('hide');
            });
        } else {
            this._alertService.warn('Please fill mandatory fields');
        }
    }

    prepareReferralData(referalDetails: any) {
        return {
            'case_id': this.daNumber,
            'intakeserviceid': this.id,
            'client_id': this.selectedChild?.cjamspid,
            'removal_id': null,
            'provider_organization_id': (this.selectedProvider.providerdetails
                && this.selectedProvider.providerdetails.length) ? this.selectedProvider.providerdetails[0].provider_organization_id : null,
            'provider_id': this.selectedProvider.provider_id,
            'contract_program_id': (this.selectedProvider.providerdetails && this.selectedProvider.providerdetails.length) ? this.selectedProvider.providerdetails[0].contract_program_id : null,
            'facility_id': null,
            'medicaid_paid_sw': null,
            'entry_dt': null,
            'entry_tm': null,
            'other_services_tx': null,
            'exit_dt': null,
            'exit_tm': null,
            'exit_explanation_tx': null,
            'exit_reason_cd': null,
            'over_under_sw': null,
            'approval_status_cd': null,
            'placement_structure_id': referalDetails.placementStructure, // manditory
            'void_sw': null,
            'void_reason_cd': null,
            'exit_type_cd': null,
            'court_ordered_sw': null,
            'icpc_approved_sw': null,
            'short_list_id': null,
            'payment_header_id': null,
            'placement_change_dt': null,
            'fiscal_category_cd': null,
            'rate_structure_id': referalDetails.comarRate, // comar id
            'conversion_sw': null,
            'orig_placement_id': null,
            'data_valid_sw': null,
            'client_merge_id': null,
            'void_approval_status_cd': null,
            'void_approval_dt': null,
            'tfc_ifc_conversion_sw': null,
            'providerdetails': {
                'reject_reason_cd': referalDetails.responseRejected, 
                'placed_with_sw': null,
                'accepted_cd': referalDetails.responseAccepted, 
                'reason_non_preferred_tx': referalDetails.reasonnonpreferredtx,
                'info_sent_dt': moment(referalDetails.sentDate).format(this.dtformat), 
                'info_description_tx': referalDetails.description,
                'provider_service_id': referalDetails.placementStructure, 
                'service_id': (this.selectedProvider.providerdetails && this.selectedProvider.providerdetails.length) ? this.selectedProvider.providerdetails[0].service_id : null, 
                'rate_structure_id': referalDetails.comarRate, 
                'entry_dt': moment(referalDetails.begindate).format(this.dtformat), 
                'entry_tm': referalDetails.begintime, 
                'ssa_ifc_approval_sw': (referalDetails.ifcapproval) ? 'Y' : 'N',
                'ssa_ifc_approval_dt': (referalDetails.ifcapprovaldt) ? moment(referalDetails.ifcapprovaldt).format(this.dtformat) : null
            }

        };
    }

    resetSearch() {
        this.providerSearchForm.reset();
        this.referalForm.reset();
        this.referalForm.patchValue({
            begintime: '08:00',
        });

    }
    resetReferal() {
        this.referalForm.reset();
        this.referalForm.patchValue({
            begintime: '08:00',
        });
    }

    selectedProv(provId: any) {
        this.selectedProvider = provId;
    }

    getCpaDetails() {
        this.getCPAChildHistory();
        this.getCPAHomeList();
    }

    goToReferal() {
        this.resetReferal();
        this.referalForm.patchValue({
            sentDate: new Date()
        });
        if (this.selectedProvider.provider_category_cd === '1783') {
            this.referalForm.get('comarRate')?.enable();
            this.referalForm.get('comarRate')?.setValidators([Validators.required]);
            this.referalForm.get('comarRate')?.updateValueAndValidity();
            this.comarRateRequired = true;
        } else {
            this.referalForm.get('comarRate')?.disable();
            this.referalForm.get('comarRate')?.clearValidators();
            this.referalForm.get('comarRate')?.updateValueAndValidity();
            this.comarRateRequired = false;
        }
        this.getResponseAcceptedList();
        this.getResponseRejectedList();
        this.getPlacementStrType(this.selectedProvider.provider_id);
        (<any>$('#fc_referal')).click();
    }
    goToSearch() {
        this.resetSearch();
        (<any>$('#fc_search')).click();
    }

    placementStructureSelect(item: { value: any; source: { triggerValue: string; }; }) {
        this.selectedPlacementStructure = item.value;
        if (this.selectedProvider.provider_category_cd !== '1783') {
            this.referalForm.get('comarRate')?.disable();
            this.referalForm.get('comarRate')?.clearValidators();
            this.referalForm.get('comarRate')?.updateValueAndValidity();
            this.comarRateRequired = false;
        } else if (this.selectedProvider.provider_category_cd === '1783' && this.selectedPlacementStructure.comar_sw === 'Y') {
            const placementStructure = this.referalForm.getRawValue().placementStructure;
            this.referalForm.patchValue({
                comarRate: placementStructure
            });
            this.referalForm.get('comarRate')?.disable();
            this.referalForm.get('comarRate')?.clearValidators();
            this.referalForm.get('comarRate')?.updateValueAndValidity();
            this.comarRateRequired = false;
        } else {
            this.referalForm.get('comarRate')?.enable();
            this.referalForm.get('comarRate')?.setValidators([Validators.required]);
            this.referalForm.get('comarRate')?.updateValueAndValidity();
            this.comarRateRequired = true;
        }
        if (item.source.triggerValue === 'Intermediate Foster Care Difficulty of Care') {
            this.referalForm.get('ifcapproval')?.enable();
            this.referalForm.get('ifcapprovaldt')?.enable();
        } else {
            this.referalForm.patchValue({
                ifcapprovaldt: null,
                ifcapproval: false,
            });
            this.referalForm.get('ifcapproval')?.disable();
            this.referalForm.get('ifcapprovaldt')?.disable();
        }
    }

    responseSelect(item: { value: any; }) {
        this.selectedResponseStructure = item.value;
        if (this.selectedResponseStructure === '4612') {
            this.referalForm.get('responseRejected')?.disable();
        } else {
            this.referalForm.get('responseRejected')?.enable();
        }
    }

    listMap() {
        this.zoom = 11;
        this.defaultLat = 39.29044;
        this.defaultLng = -76.61233;
        this.fcProviderSearch.forEach((m) => {
            this.markersLocation = [];
            if (m.length > 0) {
                m.forEach((res: any) => {
                    const mapLocation = {
                        lat: +res.latitude,
                        lng: +res.longitude,
                        draggable: +true,
                        providername: res.providername,
                        addressline1: res.addressline1
                    };
                    this.markersLocation.push(mapLocation);
                    this.defaultLat = this.markersLocation[0].lat;
                    this.defaultLng = this.markersLocation[0].lng;
                });
                (<any>$('#map-popup')).modal('show');
            }
        });
    }
    mapClose() {
        this.markersLocation = [];
    }

    openTitle4e() {
        (<any>$('#title4e')).modal('show');
    }

    selectPlacement(placement: any) {
        (<any>$(this.addplacementpopupid)).modal('show');
        this.selectedPlacement = placement;
        this.addPlacementForm.patchValue({
            providerid: placement.provider_id,
            providername: placement.providername,
            localdept: '',
            phonenumber: '',
            schooldistrict: '',
            direction: '',
            address: null,
            programname: placement.programname,
            programstructure: '',
            removaldate: null,
            comarrate: '',
            fiscalcategorycode: '',
            mostrecentfiscalcode: '',
            begindate: placement.referalstartdate,
            entrytime: placement.referalstarttime,
            mpp: false,
            cop: false,
            icpc: false,
        });
        this.addPlacementForm.disable();
        this.addPlacementForm.get('mpp')?.enable();
        this.addPlacementForm.get('cop')?.enable();
        this.addPlacementForm.get('icpc')?.enable();

        (<any>$('#entry_view')).click();
    }

    selectPlacementToExit(placement: any) {
        this.isExit = true;
        this.patchPlacementForm(placement);
        (<any>$('#exit')).modal('show');
    }

    private patchPlacementForm(placement: any) {
        this.selectedPlacement = placement;
        this.exitForm.patchValue({
            providerid: placement.provider_id,
            providername: placement.providername,
            localdept: '',
            phonenumber: '',
            schooldistrict: '',
            direction: '',
            address: null,
            programname: placement.programname,
            programstructure: '',
            removaldate: null,
            comarrate: '',
            fiscalcategorycode: '',
            mostrecentfiscalcode: '',
            startdate: placement.placemententrydate,
            starttime: placement.placemententrytime,
            enddate: null,
            endtime: null,
            exitType: null,
            reasonforexit: null,
            explanation: ''
        });
        this.exitForm.disable();
        if (this.isExit) {
            this.exitForm.get('enddate')?.enable();
            this.exitForm.get('endtime')?.enable();
            this.exitForm.get('exitType')?.enable();
            this.exitForm.get('reasonforexit')?.enable();
            this.exitForm.get('explanation')?.enable();
            this.exitForm.controls.enddate.setValidators([Validators.required]);
            this.exitForm.controls.endtime.setValidators([Validators.required]);
        } else {
            this.exitForm.get('startdate')?.enable();
            this.exitForm.get('starttime')?.enable();
        }
    }

    editPlacement(placement: any) {
        this.isExit = false;
        this.isDateTime = false;
        this.patchPlacementForm(placement);
        (<any>$('#exit')).modal('show');
    }

    getAge(dateValue: any) {
        if (dateValue && moment(new Date(dateValue), 'MM/DD/YYYY', true).isValid()) {
            const rCDob = moment(new Date(dateValue), 'MM/DD/YYYY').toDate();
            return moment().diff(rCDob, 'years');
        } else {
            return '';
        }
    }


    providerTypeSelected(event: { value: string; }) {
        if (event.value === '1') {
            this.isPublicProvider = true;
            this.isPrivateProvider = false;
        } else {
            this.isPublicProvider = false;
            this.isPrivateProvider = true;
        }
    }

    scShowPlacement(placement: any) {
        this.selectedPlacement = placement;
        (<any>$('#fc-view')).modal('show');
    }

    getPlacementDates(log: any, isentry: any) {
        if (log && log.length) {
            const event = this.getEvent(log, isentry);
            return event.date + ' ' + event.time;
        } else {
            return '';
        }
    }

    getEvent(log: any, isentry: number) {
        const event = { date: '', time: '' };
        if (isentry === 1) {
            event.date = (log[0].entry_dt) ? log[0].entry_dt : '';
            event.time = (log[0].entry_tm) ? log[0].entry_tm : '';
        } else {
            event.date = (log[0].exit_dt) ? log[0].exit_dt : '';
            event.time = (log[0].exit_tm) ? log[0].exit_tm : '';
        }
        return event;
    }

    selectAccountsPayable(_payment: any) {
        // No data or function to call
    }

    searchClearPlacement() {
        // No data or function to call
    }

    onChange(_event: any) {
        // No data or function to call
    }

    localdptSelected(_event: any) {
        // No data or function to call
    }

}
