
import {forkJoin as observableForkJoin,  Observable } from 'rxjs';

import {pluck, share, map} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import moment from 'moment';

import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DropdownModel, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService, DataStoreService } from '../../../../../@core/services';
import { AuthService } from '../../../../../@core/services/auth.service';
import { DSDSActionSummary } from '../../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { CourtOrderList, HearingDetails, PetitionList } from '../../court/_entities/court.data.model';
import { InvolvedPerson } from '../../service-plan/_entities/service-plan.model';
import { PermanencyPlan, PermanencyPlanType } from '../_entities/placement.model';
import { AppConstants } from '../../../../../@core/common/constants';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { DsdsService } from '../../_services/dsds.service';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'permanency-plan',
    templateUrl: './permanency-plan.component.html',
    styleUrls: ['./permanency-plan.component.scss'],
    standalone: false
})
export class PermanencyPlanComponent implements OnInit {
    childAge!: string | number;
    id!: string;
    isAddForm = true;
    userInfo!: AppUser;
    permanencyPlanViewDetail!: PermanencyPlan;
    permanencyPlanForm!: FormGroup;
    involvedPerson$!: Observable<InvolvedPerson[]>;
    planTypeSubType$!: Observable<PermanencyPlanType[]>;
    permanencyPlan$!: Observable<PermanencyPlan[]>;
    permanencyPlanWrappers: any = [];
    primaryPlanSubType = new PermanencyPlanType();
    concurrentPlanSubType = new PermanencyPlanType();
    dsdsActionsSummary = new DSDSActionSummary();
    maxDate = new Date();
    isAppla!: boolean;
    petitonListDetails: any;
    hearingDetails: HearingDetails = new HearingDetails();
    hearingtypeArray: string[] = [];
    hearingstatustypeArray: string[] = [];
    caseNumber!: string;
    courtOrderList!: CourtOrderList;
    stateDropdownItems$!: Observable<DropdownModel[]>;
    countyDropdownItems$!: Observable<DropdownModel[]>;
    genderDropdownItems$!: Observable<DropdownModel[]>;
    providerSearchForm!: FormGroup;
    providerSearch!: any[];
    isHistoryTab!: boolean;
    rcRoleList: InvolvedPerson[] = [];
    repRoleList: InvolvedPerson[] = [];
    addoptRoleList: InvolvedPerson[] = [];
    childList: InvolvedPerson[] = [];
    selectedChild: any;
    private planType!: string;
    private planTypeSubType!: PermanencyPlanType[];
    childCharacteristics$!: Observable<any>;
    otherLocalDeptmntType$!: Observable<any[]>;
    placementStrType$!: Observable<any[]>;
    bundledPlcmntServicesType$!: Observable<any[]>;
    personsInvolved!: InvolvedPerson[];
    selectedProviderId: any;
    selectedProvider: any;
    isViewForm!: boolean;
    selectedPermanencyPlanId!: string;
    isSupervisor!: boolean;
    actorid!: string;
    private isGapValidated!: boolean;
    permanencyListingCriteria: any = null;
    isServiceCase = false;
    placementchk!: boolean;
    private form: FormBuilder;
    private _httpService: CommonHttpService;
    private route: ActivatedRoute;
    private _dataStoreService: DataStoreService;
    private _alert: AlertService;
    private _authService: AuthService;

    constructor(
        private readonly injector : Injector,
        private _router: Router,
        private _dsdsService: DsdsService
    ) {
        this.form = this.injector.get<FormBuilder>(FormBuilder);
        this._httpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._alert = this.injector.get<AlertService>(AlertService);
        this._authService = this.injector.get<AuthService>(AuthService);
    }

    ngOnInit() {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.caseNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.permanencyListingCriteria = { intakeserviceid: this.id };
        this.isServiceCase = this._dsdsService.isServiceCase();
        if (this.isServiceCase) {
            this.permanencyListingCriteria = { intakeserviceid: null, objecttypekey: 'servicecase', objectid: this.id };
        }
        this.userInfo = this._authService.getCurrentUser();
        this.isSupervisor = this.userInfo.role.name === AppConstants.ROLES.SUPERVISOR;
        this.initializeForm();
        this.loadDropdown();
        this.loadPetitionDetail();
        this.viewHistory();
        this.isHistoryTab = true;

        if (this.userInfo.user.userprofile.displayname) {
            this.permanencyPlanForm.patchValue({
                caseworkername: this.userInfo.user.userprofile.displayname
            });
        }
        this.permanencyPlanForm.get('establisheddate')?.valueChanges.subscribe(result => {
            this.permanencyPlanForm.patchValue({
                achieveddate: null,
                projecteddate: null
            });
        });
        this.permanencyPlanForm.get('projecteddate')?.valueChanges.subscribe(result => {
            this.permanencyPlanForm.patchValue({ achieveddate: null });
        });
        this.permanencyPlanForm.get('primaryarrangetype')?.valueChanges.subscribe(res => {
            if (res === 'By Relative') {
                this.permanencyPlanForm.patchValue({ primarynonrelativename: '' });
                this.permanencyPlanForm.get('primaryrelativename')?.enable();
                this.permanencyPlanForm.get('primarynonrelativename')?.disable();
            } else if (res === 'By Non-Relative') {
                this.permanencyPlanForm.patchValue({ primaryrelativename: '' });
                this.permanencyPlanForm.get('primaryrelativename')?.disable();
                this.permanencyPlanForm.get('primarynonrelativename')?.enable();
            } else {
                this.permanencyPlanForm.get('primaryrelativename')?.enable();
                this.permanencyPlanForm.get('primarynonrelativename')?.enable();
            }
        });
        this.permanencyPlanForm.get('concurrentarrangetype')?.valueChanges.subscribe(res => {
            if (res === 'By Relative') {
                this.permanencyPlanForm.patchValue({ concurrentnonrelativename: '' });
                this.permanencyPlanForm.get('concurrentrelativename')?.enable();
                this.permanencyPlanForm.get('concurrentnonrelativename')?.disable();
            } else if (res === 'By Non-Relative') {
                this.permanencyPlanForm.patchValue({ concurrentrelativename: '' });
                this.permanencyPlanForm.get('concurrentrelativename')?.disable();
                this.permanencyPlanForm.get('concurrentnonrelativename')?.enable();
            } else {
                this.permanencyPlanForm.get('concurrentrelativename')?.enable();
                this.permanencyPlanForm.get('concurrentnonrelativename')?.enable();
            }
        });
    }
    private permanencyGapValidate() {
        this._httpService
            .getSingle(
                new PaginationRequest({
                    where: {
                        intakeserviceid: this.id,
                        intakeservicerequestactorid: this.actorid
                    },
                    method: 'get'
                }),
                'permanencyplan/permanencygapvalidation?filter'
            )
            .subscribe(res => {
                this.isGapValidated = res ? res.iseligible : false;
            });
    }
    pesonDateOfBirth(item: any) {
        this.permanencyPlanForm.patchValue({
            dateofbirth: item.value.dob,
            intakeservicerequestactorid: item.value.intakeservicerequestactorid,
            gender: item.value.gender,
            cjamspid: item.value.cjamspid
        });
        this.selectedChild = item.value;
        this.actorid = item.value.intakeservicerequestactorid;
        this.childAge = this.getAge(item.value.dob) ?? null;
        const conPlan = this.permanencyPlanForm.value.primaryPlan;
        if (conPlan && conPlan.length) {
            conPlan.forEach((appla: { permanencyplantypekey: string; }, index: any) => {
                if (appla.permanencyplantypekey === 'APPLA') {
                    conPlan.splice(index, 1);
                }
            });
            this.permanencyPlanForm.patchValue({ primaryPlan: conPlan });
        }
        this.permanencyGapValidate();
        this.getRecommendedList();
    }
    addPlan() {
        this.isHistoryTab = false;
        this.isViewForm = false;
        this.permanencyPlanForm.enable();
        this.permanencyPlanForm.reset();
        this.permanencyPlanForm.patchValue({
            caseworkername: this.userInfo.user.userprofile.displayname
        });
        this.permanencyPlanForm.get('primaryprovidername')?.disable();
        this.permanencyPlanForm.get('concurrentprovidername')?.disable();
        this.permanencyPlanForm.get('dateofbirth')?.disable();
        this.permanencyPlanForm.get('gender')?.disable();
        this.permanencyPlanForm.get('cjamspid')?.disable();
    }
    resetPlan() {
        this.primaryPlanSubType.permanencyplansubtype = [];
        this.concurrentPlanSubType.permanencyplansubtype = [];
        this.permanencyPlanForm.reset();
        this.isAddForm = true;
    }
    onPrimaryPlanChange(event: any, init: any) {
        if (this.selectedChild) {
            if (event && event.value && event.value.permanencyplantypekey === 'APPLA') {
                this.isAppla = true;
            } else {
                this.isAppla = false;
            }
            if (init === 0) {
                this.primaryPlanSubType = Object.assign({}, event);
            } else {
                this.checkPermanencyplantypekeyFn(event);
            }
        } else {
            this._alert.error('Please select a child name to proceed.');
            this.permanencyPlanForm.patchValue({
                primaryPlan: null
            });
        }
    }
    // Assosiated with onPrimaryPlanChange fuction
    private checkPermanencyplantypekeyFn(event: any) {
        if (event.value.permanencyplantypekey === 'Adoption' || event.value.permanencyplantypekey === 'ADOPTNR') {
            const repRoleList = this.personsInvolved.filter(
                child => child.rolename === 'Rep' || (child.roles.length && child.roles.filter(itm => itm.intakeservicerequestpersontypekey === 'Rep').length)
            );
            const addoptRoleList = this.personsInvolved.filter(
                child => child.rolename === 'ADOPTPARNT' || (child.roles.length && child.roles.filter(itm => itm.intakeservicerequestpersontypekey === 'ADOPTPARNT').length)
            );
            const rcRoleList = this.personsInvolved.filter(
                child => child.rolename === 'RC' || (child.roles.length && child.roles.filter(itm => itm.intakeservicerequestpersontypekey === 'RC').length)
            );
            this.primaryPlanSubType = Object.assign({}, event.value);
            this.checkRcRoleListFn(rcRoleList, addoptRoleList, repRoleList, event);
            // } else if (event.value.permanencyplantypekey === 'Guardianship' && !this.isGapValidated) {
            //     this._alert.error('Guardianship is not eligible');
            //     this.permanencyPlanForm.patchValue({ primaryPlan: '', primarypermanencytype: '' });
        } else {
            this.permanencyPlanForm.patchValue({ primarypermanencytype: event.value.permanencyplantypekey });
            if (event.value.permanencyplansubtype && event.value.permanencyplansubtype.length) {
                this.permanencyPlanForm.get('primaryarrangetype')?.setValidators([Validators.required]);
            } else {
                this.permanencyPlanForm.get('primaryarrangetype')?.clearValidators();
            }
        }
    }
    // Assosiated with onPrimaryPlanChange fuction
    private checkRcRoleListFn(rcRoleList: InvolvedPerson[], addoptRoleList: InvolvedPerson[], repRoleList: InvolvedPerson[], event: any) {
        if (!rcRoleList.length) {
            this._alert.error('Please add reported child');
            this.permanencyPlanForm.patchValue({ primaryPlan: '', primarypermanencytype: '' });
        } else if (!addoptRoleList.length) {
            this._alert.error('Please add adoptive parent');
            this.permanencyPlanForm.patchValue({ primaryPlan: '', primarypermanencytype: '' });
        } else if (!repRoleList.length) {
            this._alert.error('Please add reporter');
            this.permanencyPlanForm.patchValue({ primaryPlan: '', primarypermanencytype: '' });
        } else if (!this.placementchk) {
            this.permanencyPlanForm.patchValue({
                primaryPlan: null
            });
            this._alert.error('Child is not in care for 15 out of the last 22 months');
        } else {
            this.permanencyPlanForm.patchValue({ primarypermanencytype: event.value.permanencyplantypekey });
            if (event.value.permanencyplansubtype && event.value.permanencyplansubtype.length) {
                this.permanencyPlanForm.get('primaryarrangetype')?.setValidators([Validators.required]);
            } else {
                this.permanencyPlanForm.get('primaryarrangetype')?.clearValidators();
            }
        }
    }

    onConcurrentPlanChange(event: any) {
        this.concurrentPlanSubType = Object.assign({}, event.value);
        this.permanencyPlanForm.patchValue({ concurrentpermanencytype: event.value.permanencyplantypekey });
        if (event.value.permanencyplansubtype && event.value.permanencyplansubtype.length) {
            this.permanencyPlanForm.get('concurrentarrangetype')?.setValidators([Validators.required]);
        } else {
            this.permanencyPlanForm.get('concurrentarrangetype')?.clearValidators();
        }
    }
    savePlan() {
        if (!this.permanencyPlanForm.value.primaryrelativename && !this.permanencyPlanForm.value.primarynonrelativename && !this.permanencyPlanForm.value.ispriresourceidentified) {
            this._alert.error('Please fill Primary Relative fields');
            return;
        }
        if (this.permanencyPlanForm.value.primaryPlan && this.permanencyPlanForm.value.primaryPlan.permanencyplantypekey === 'ADOPTNR') {
            $('#alert-non-relative').modal('show');
        } else {
            this.reviewPlan();
        }
    }
    reviewPlan() {
        const permanencyPlanInput = this.permanencyPlanForm.value;
        permanencyPlanInput.intakeserviceid = this.id;
        permanencyPlanInput.ispriresourceidentified = this.permanencyPlanForm.value.ispriresourceidentified ? 1 : 0;
        permanencyPlanInput.isconresourceidentified = this.permanencyPlanForm.value.isconresourceidentified ? 1 : 0;
        delete permanencyPlanInput.concurrentPlan;
        delete permanencyPlanInput.primaryPlan;
        delete permanencyPlanInput.childName;
        this._httpService.create(permanencyPlanInput, CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PermanencyPlan.PermanencyPlanAdd).subscribe(response => {
            this._alert.success('Plan is sent for review');
            $('#alert-non-relative').modal('hide');
            this.isHistoryTab = true;
            this.resetPlan();
            this.planListing();
        });
    }
    viewPlan(modal: any) {
        this.isHistoryTab = false;
        this.isViewForm = true;
        this.selectedPermanencyPlanId = modal.permanencyplanid;
        this.permanencyPlanForm.disable();
        this.personsInvolved.forEach(person => {
            if (person.intakeservicerequestactorid === modal.intakeservicerequestactorid) {
                this.permanencyPlanForm.patchValue({ gender: person.gender, dob: person.dob, cjamspid: person.cjamspid });
            }
        });
        this.permanencyPlanForm.patchValue(modal);
        this.permanencyPlanForm.patchValue({
            projecteddate: modal.projecteddate,
            childName: modal.childname,
            primaryprovidername: modal.primaryprovider,
            concurrentprovidername: modal.concurrentprovide
        });
        if (modal.primarypermanency && modal.primarypermanency.length) {
            this.planTypeSubType.forEach(res => {
                if (res.permanencyplantypekey === modal.primarypermanency[0].permanencyplantypekey) {
                    this.primaryPlanSubType = Object.assign({}, res);
                    this.permanencyPlanForm.patchValue({ primaryPlan: res.permanencyplantypekey });
                }
            });
            this.permanencyPlanForm.patchValue({ primaryarrangetype: modal.primarypermanency[0].permanencyplansubtypekey });
        }
        if (modal.concurrentpermanency && modal.concurrentpermanency.length) {
            if (modal.concurrentpermanency[0].permanencyplantypekey) {
                this.planTypeSubType.forEach(res => {
                    if (res.permanencyplantypekey === modal.concurrentpermanency[0].permanencyplantypekey) {
                        this.concurrentPlanSubType = Object.assign({}, res);
                        this.permanencyPlanForm.patchValue({ concurrentPlan: res.permanencyplantypekey });
                    }
                });
                this.permanencyPlanForm.patchValue({ concurrentarrangetype: modal.concurrentpermanency[0].permanencyplansubtypekey });
            }
        }
        setTimeout(() => {
            this.permanencyPlanForm.patchValue({ achieveddate: modal.achieveddate });
        }, 100);
        this.isAddForm = false;
        this.permanencyPlanViewDetail = modal;
    }

    getProviderSearch() {
        const formValues = this.providerSearchForm.getRawValue();
        const body = {
            childcharacteristics: parseInt(formValues.childCharacteristicsid, 10),
            placementstructures: parseInt(formValues.placementStrTypeId, 10),
            bundledplacementservices: parseInt(formValues.bundledPlcmntServicesTypeId, 10),
            zipcode: parseInt(formValues.zipcode, 10)
        };
        this._httpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: body,
                    page: 1,
                    limit: 20,
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fcProviderSearchUrl
            )
            .subscribe(result => {
                this.providerSearch = result.data;
                $('#fc_list').click();
            });
    }
    clearSelectedProvider(planType: any) {
        if (planType === 'primary') {
            this.permanencyPlanForm.patchValue({
                primaryprovidercode: '',
                primaryprovidername: ''
            });
        } else if (planType === 'concurrent') {
            this.permanencyPlanForm.patchValue({
                concurrentprovidercode: '',
                concurrentprovidername: ''
            });
        }
        this.resetSearch();
    }
    resetSearch() {
        this.providerSearchForm.reset();
        this.providerSearch = [];
        this.selectedProvider = {};
    }
    openSearch(planType: any) {
        if (this.permanencyPlanForm.value.intakeservicerequestactorid) {
            this.loadSearchDropdown();
            this.planType = planType;
            $('#search-provider').modal('show');
            $('#fc_search').click();
            this.resetSearch();
        } else {
            this._alert.error('Please select a child');
        }
    }
    chooseProvider(provider: any) {
        this.selectedProvider = provider;
    }
    selectProvider() {
        if (this.planType === 'primary') {
            this.permanencyPlanForm.patchValue({ primaryprovidercode: this.selectedProvider.provider_id, primaryprovidername: this.selectedProvider.providername });
        } else if (this.planType === 'concurrent') {
            this.permanencyPlanForm.patchValue({ concurrentprovidercode: this.selectedProvider.provider_id, concurrentprovidername: this.selectedProvider.providername });
        }
        $('#search-provider').modal('hide');
    }
    viewHistory() {
        this.isHistoryTab = !this.isHistoryTab;
        if (this.isHistoryTab) {
            this.planListing();
        }
    }
    approvePlan(status: any) {
        this._httpService
            .create(
                {
                    intakeserviceid: this.id,
                    objectid: this.selectedPermanencyPlanId,
                    eventcode: 'PPLR',
                    status: status,
                    comments: 'Safety Plan Approved',
                    notifymsg: 'Permanency plan Approved',
                    routeddescription: 'Permanency plan Approved'
                },
                'routing/routingupdate'
            )
            .subscribe(
                res => {
                    this._alert.success('Plan Is ' + status + ' Successfully');
                    this.viewHistory();
                },
                err => {
                    this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }
    private initializeForm() {
        this.permanencyPlanForm = this.form.group({
            intakeservicerequestactorid: ['', [Validators.required]],
            dateofbirth: [null],
            establisheddate: [null, [Validators.required]],
            projecteddate: [null, [Validators.required]],
            primaryPlan: ['', [Validators.required]],
            caseworkername: [''],
            reviseddate: [null],
            achieveddate: [null],
            concurrentPlan: [''],
            concurrentarrangetype: [null],
            primaryarrangetype: [null],
            // address1: [''],
            // address2: [''],
            // state: [''],
            // city: [''],
            // country: [''],
            // zipcode: [''],
            primaryrelativename: [''],
            primarynonrelativename: [''],
            concurrentrelativename: [''],
            concurrentnonrelativename: [''],
            primaryprovidercode: ['', [Validators.required]],
            concurrentprovidercode: [''],
            ispriresourceidentified: [null],
            Isconresourceidentified: [null],
            primaryprovidername: [''],
            concurrentprovidername: [''],
            childName: [''],
            gender: [''],
            cjamspid: [''],
            primarypermanencytype: [null],
            concurrentpermanencytype: [null]
        });
        this.permanencyPlanForm.get('primaryprovidername')?.disable();
        this.permanencyPlanForm.get('concurrentprovidername')?.disable();
        this.permanencyPlanForm.get('dateofbirth')?.disable();
        this.permanencyPlanForm.get('gender')?.disable();
        this.permanencyPlanForm.get('cjamspid')?.disable();
        this.providerSearchForm = this.form.group({
            childCharacteristicsid: [null],
            bundledPlcmntServicesTypeId: [null],
            otherLocalDeptmntTypeId: [null],
            placementStrTypeId: [null],
            zipcode: [''],
            isLocalDpt: [false],
            firstname: [''],
            middlename: [''],
            lastname: [''],
            isgender: [false],
            isAge: [false],
            providerId: ['']
        });
        this.providerSearchForm.get('firstname')?.disable();
        this.providerSearchForm.get('middlename')?.disable();
        this.providerSearchForm.get('lastname')?.disable();
    }
    proccessPermancyPlans(response: any) {
        if (this.isServiceCase) {
            return response;
        } else {
            return [{
                permanencyplans: response.data
            }];
        }

    }
    private planListing() {
        this._httpService
            .getPagedArrayList(
                {
                    method: 'get',
                    page: 1,
                    limit: 10,
                    where: this.permanencyListingCriteria
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PermanencyPlan.PermanencyPlanList + '?filter'
            ).subscribe(response => {
                this.permanencyPlanWrappers = this.proccessPermancyPlans(response);
            });
    }
    private loadDropdown() {
        const source = observableForkJoin([
            this._httpService.getArrayList(
                {
                    method: 'get',
                    where: { intakeservreqid: this.id }
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            ),
            this._httpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PermanencyPlan.PermanancyPlanTypeSubType + '?filter={}'),
            this._httpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.StateListUrl + '?filter'
            ),
            this._httpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true,
                    order: 'countyname asc'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CountyListUrl + '?filter'
            ),
            this._httpService.create(
                {
                    where: { activeflag: 1 },
                    method: 'post',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.GenderTypeUrl + '/genderlist'
            )
        ]).pipe(
            map((item: any) => {
                return {
                    children: item[0]['data'].filter((child: { rolename: string; }) => child.rolename === 'RC' || child.rolename === 'AV' || child.rolename === 'CHILD'),
                    typeSubType: item[1],
                    states: item[2].map((res: { statename: any; stateabbr: any; }) =>
                            new DropdownModel({
                                text: res.statename,
                                value: res.stateabbr
                            })
                    ),
                    county: item[3].map((res: { countyname: any; }) =>
                            new DropdownModel({
                                text: res.countyname,
                                value: res.countyname
                            })
                    ),
                    genders: item[4].map((res: { typedescription: any; gendertypekey: any; }) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.gendertypekey
                            })
                    )
                };
            }),
            share(),);
        this.involvedPerson$ = source.pipe(pluck('children'));
        this.planTypeSubType$ = source.pipe(pluck('typeSubType'));
        this.stateDropdownItems$ = source.pipe(pluck('states'));
        this.countyDropdownItems$ = source.pipe(pluck('county'));
        this.genderDropdownItems$ = source.pipe(pluck('genders'));
        this.planTypeSubType$.subscribe(item => {
            this.planTypeSubType = item;
        });
        this._httpService
            .getPagedArrayList(
                {
                    method: 'get',
                    where: { intakeservreqid: this.id }
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            )
            .subscribe(res => {
                this.personsInvolved = res.data;
            });
    }
    private getAge(dateValue: any) {
        if (dateValue && moment(new Date(dateValue), 'MM/DD/YYYY', true).isValid()) {
            const rCDob = moment(new Date(dateValue), 'MM/DD/YYYY').toDate();
            return moment().diff(rCDob, 'years');
        } else {
            return '';
        }
    }
    private loadPetitionDetail() {
        const isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        observableForkJoin([
            this._httpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.HearingTypeUrl + '?filter={"nolimit":true,"order":"description"}'),
            this._httpService.getArrayList({}, 'hearingstatustype' + '?filter={"nolimit":true,"order":"description"}'),
            this._httpService.getArrayList({ method: 'get', where: { intakeservicerequestid: this.id, isExpungementSuperUser: isExpungementSuperUser,'iscaseexpunged':iscaseexpunged} }, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionListUrl + '?filter'),
            this._httpService.getArrayList({ method: 'get', where: { intakeservicerequestid: this.id,isExpungementSuperUser:isExpungementSuperUser,'iscaseexpunged':iscaseexpunged} }, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.getHearingUrl + '?filter'),
            this._httpService.getArrayList({ method: 'get', where: { intakeserviceid: this.id } }, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.GetCourtOrderUrl + '?filter')
        ]).subscribe(data => {
            data[0].forEach(type => {
                this.hearingtypeArray[type.hearingtypekey] = type.description;
            });
            data[1].forEach(type => {
                this.hearingstatustypeArray[type.hearingstatustypekey] = type.description;
            });
            if (data[2].length) {
                data[2].forEach(actor => {
                    this.petitonListDetails = {
                        intakeservicerequestpetitionid: actor.intakeservicerequestpetitionid,
                        associatedattorneys: actor.associatedattorneys,
                        petitionid: actor.petitionid,
                        petitiontypekey: actor.petitiontypekey,
                        actordetails: actor.intakeservicerequestpetitionactor
                    };
                });
                if (data[3].length) {
                    this.hearingDetails = data[3][0];
                }
                if (data[4].length) {
                    this.courtOrderList = data[4][0];
                }
            }
        });
    }
    private loadSearchDropdown() {
        const source = observableForkJoin([
            this._httpService.getPagedArrayList(
                new PaginationRequest({
                    where: {
                        picklist_type_id: '43'
                    },
                    nolimit: true,
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.childCharacteristicsUrl
            ),
            this._httpService.getArrayList(
                new PaginationRequest({
                    where: {
                        picklist_type_id: '104'
                    },
                    nolimit: true,
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.otherLocalDeptmntTypeUrl
            ),
            this._httpService.getArrayList(
                new PaginationRequest({
                    where: {
                        structure_service_cd: 'P'
                    },
                    nolimit: true,
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.placementStrTypeUrl
            ),
            this._httpService.getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.bundledPlcmntServicesTypeUrl
            )
        ]).pipe(
            map(item => {
                return {
                    childCharacter: item[0],
                    otherLocalDept: item[1],
                    placementStrType: item[2],
                    bundledPlcmntServicesType: item[3]
                };
            }),
            share(),);
        this.childCharacteristics$ = source.pipe(pluck('childCharacter'));
        this.otherLocalDeptmntType$ = source.pipe(pluck('otherLocalDept'));
        this.placementStrType$ = source.pipe(pluck('placementStrType'));
        this.bundledPlcmntServicesType$ = source.pipe(pluck('bundledPlcmntServicesType'));
    }
    // private patchHearingDetail() {
    //     if (this.courtOrderList && this.courtOrderList.hearingoutcometypekey) {
    //         this.planTypeSubType.map(res => {
    //             if (res.permanencyplantypekey === this.courtOrderList.hearingoutcometypekey) {
    //                 this.primaryPlanSubType = Object.assign({}, res);
    //                 this.permanencyPlanForm.patchValue({ primaryPlan: res });
    //             }
    //         });
    //         this.permanencyPlanForm.patchValue({ establisheddate: this.courtOrderList.courtorderdate ? this.courtOrderList.courtorderdate : null });
    //         this.selectedPermanencyPlanPP = this.courtOrderList.hearingoutcometypekey;
    //     }
    // }

    routeToPlan(plan: any) {
        this._dataStoreService.setData('adoptedchildId', plan.intakeservicerequestactorid);
        if (plan.primarypermanency && plan.primarypermanency.length > 0) {
            const primary = plan.primarypermanency[0];
            let url = '';
            if (primary.permanencyplantypekey === 'ADOPTNR' || primary.permanencyplantypekey === 'Adoption') {
                this._dataStoreService.setData('permanencyPlan', plan, true);
                url = '../adoption/tpr-recom';
            } else if (primary.permanencyplantypekey === 'Guardianship') {
                this._dataStoreService.setData('permanencyPlan', plan, true);
                url = '../placement-gap/disclosure-checklist';
            }
            
            this._router.navigate([url], { relativeTo: this.route });
        }
    }
    private getRecommendedList() {
        this._httpService
            .getSingle(
                new PaginationRequest({
                    where: {
                        intakeserviceid: this.id,
                        intakeservicerequestactorid: this.selectedChild.intakeservicerequestactorid
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.TprRecommendationList + '?filter'
            )
            .subscribe(res => {
                if (res) {
                    const tprlist = res.tprlist;
                    this.placementchk = tprlist.some((item: { checklistname: string; isvalidated: number; }) => (item.checklistname === 'childplacement' && item.isvalidated === 1));
                }
            });
    }

    returnChildFn(chAge: any, perPlantypekey: any) {
        return chAge !== null && chAge < 13 && perPlantypekey === 'APPLA'
    }
}
