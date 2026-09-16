import { Component, OnInit, Injector } from '@angular/core';
import {
    CommonHttpService,
    AlertService,
    DataStoreService,
    AuthService,
    SessionStorageService
} from '../../../../../@core/services';
import { ServiceCasePermanencyPlanService } from '../service-case-permanency-plan.service';
import { ActivatedRoute, Router } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import moment from 'moment';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { IntakeUtils } from '../../../../_utils/intake-utils.service';
@Component({
    selector: 'permanency-plan-form',
    templateUrl: './permanency-plan-form.component.html',
    styleUrls: ['./permanency-plan-form.component.scss'],
    standalone: false
})
export class PermanencyPlanFormComponent implements OnInit {
    childList: any[] = [];
    planHistoryById: any[] =[];
    planHistoryDetails: any;
    permanencyPlanList: any;
    accountpayableList = [];
    placementList = [];
    selectedChildren!: any[];
    selectedChild: any;
    involvedPersons: any;
    id!: string;
    permanencyType: any;
    userInfo!: AppUser;
    primaryPlanSubType: any;
    isAppla!: boolean;
    permanencyPlanForm!: FormGroup;
    personsInvolved: any;
    formAction!: string;
    placementchk: any;
    paginationInfo: PaginationInfo = new PaginationInfo();
    errorMessage!: string;
    isViewMode!: boolean;
    endMaxDate: any;
    concurrentPlanRequired = false;
    minDate: any;
    isInView = false;
    planEstablishedMinDate: any;
    disableEndPlan = true;
    isReadonly = true;
    disableSave  = false;
    isValue: number = 1;
    historyRequest!: { intakeservicerequestactorid: any; personid: any; sortcol: any; sortby: any; updatedfrom: any; updatedto: any; updatedby: any; };
    planHistory!: any[];
    planreviewdate: any;
    auditlogTrail: any;
    auditlogTrailExpand: any;
    exitDate: any;
    removedChildren: any = [];
    showAuditLogInfo: boolean = false;
    isremovalendated: boolean = true;
    displayValidationMessages:boolean =false;
    validationmsg = 'Primary and concurrent permanency plan cant be the same.';
    private _serviceCasePermanencyPlanService: ServiceCasePermanencyPlanService;
    private commonHttpService: CommonHttpService;
    private router: Router;
    private route: ActivatedRoute;
    private formBuilder: FormBuilder;
    private _alert: AlertService;
    private _dataStoreService: DataStoreService;
    private _authService: AuthService;
    private _intakeUtils: IntakeUtils;
    private storage: SessionStorageService;
    constructor( private injector : Injector ) {        
        this._serviceCasePermanencyPlanService = this.injector.get<ServiceCasePermanencyPlanService>(ServiceCasePermanencyPlanService);
        this.commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.router = this.injector.get<Router>(Router);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._alert = this.injector.get<AlertService>(AlertService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._intakeUtils = this.injector.get<IntakeUtils>(IntakeUtils);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    }

    ngOnInit() {
        this.forminit();
        this.disableSave = false;
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.getInvolvedPerson();
        this.formAction = 'Add';
        const activeModuleRole = this.storage.getItem('activeModuleRole');
        if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
            this.isReadonly = false;
        } else {
            this.isReadonly = this._authService.readonlyButton('read_only_access', 'readonly-permform');
        }
        this.userInfo = this._authService.getCurrentUser();
        this.isViewMode = this._serviceCasePermanencyPlanService.isViewMode;
        this.formAction = this._serviceCasePermanencyPlanService.formAction;
        this.toggleFormMode();
        if (this.userInfo && this.userInfo.user.userprofile.displayname) {
            this.permanencyPlanForm.patchValue({
                caseworkername: this.userInfo.user.userprofile.displayname
            });
        }
        
        this.setPermanencyPlanList();
        this._serviceCasePermanencyPlanService.placementApprovalQueue$.subscribe(
            data => {
                this._alert.success(data);
                setTimeout(() => {
                    this.goBack();
                }, 2000);
            }
        );
        this.planreviewdate = this.storage.getObj('planreviewdateFrHistory');
        const reviewdate: any = this.permanencyPlanForm.controls['reviewdate'];
        reviewdate.patchValue(new Date(Date.parse(this.planreviewdate))); 
        this.exitDate = this.storage.getObj('exitDateFrHistory');

        this.loadHistory();
        this.onChngPermanencyplanremainssame();
    }

    setPermanencyPlanList() {
        const allPlan = this.getAllPlan();
        const selectedChild = this._serviceCasePermanencyPlanService.selectedChildren[0];
        this.removedChildren = this._serviceCasePermanencyPlanService.selectedChildren[0];
        if (selectedChild && selectedChild.removaldate) {
            this.planEstablishedMinDate = new Date(selectedChild.removaldate);
        }
        this.isRemovalEndated(selectedChild);
        this.setMinDate();
        if (selectedChild) {
            const person = allPlan.find(child => child.personid === selectedChild.personid);
            this.permanencyPlanList = (person) ? person.permanencyplans : [];
        }
    }

    getAllPlan(){
        return (Array.isArray(this._serviceCasePermanencyPlanService.permanencyPlanList)) ? this._serviceCasePermanencyPlanService.permanencyPlanList : [];
    }
    isRemovalEndated(selectedChild: any) {
        if (selectedChild && selectedChild.removalList && selectedChild.removalList.length > 0) {
            for (let item of selectedChild.removalList) {
                if (item.exitdate && this.isremovalendated) {
                    this.isremovalendated = true;
                } else {
                    this.isremovalendated = false;
                }
            }
        }
    }
    setMinDate() {
        const multiSelectedChild = this._serviceCasePermanencyPlanService.selectedChildren;
        if (multiSelectedChild && multiSelectedChild.length > 0) {
            for (let item of multiSelectedChild) {
                if (this.minDate) {
                    if (this.minDate < item.dob) {
                        this.minDate = item.dob;
                    }
                } else {
                    this.minDate = item.dob;
                }
            }
        }
    }

    forminit() {
        this.permanencyPlanForm = this.formBuilder.group({
            permanencyplanid: [null],
            primaryplandate: [null, Validators.required],
            concurrentplandate: [null],
            caseworkername: [null],
            primarypermanencytype: [null, Validators.required],
            concurrentpermanencytype: [null, Validators.required],
            primaryarrangetype: [null],
            concurrentarrangetype: [null],
            remarks: [null],
            concurrentcomments: [null],
            courtorderreceived: [null],
            permanencyplanremainssame: [null],
            permanencyplanremainssamedate: [null],
            isreviewsubmit: [0], // 0 - save  1-submit,
            isInClosedProximity: [null],
            isInClosedProximityExpln: [null],
            meetingSafetyNeedsExpln: [null],
            sixMonthsPlacementExpln: [null],
            courtOrdersExpln: [null],
            permToPermExpln: [null],
            parentname: [null],
            parent2name: [null],
            safeAndCareExpln: [null],
            assessmentPeriodExpln: [null],
            lifebookExpln: [null],
            serviceAgreementExpln: [null],
            isProviderAgree: [null],
            isProviderAgreeExpln: [null],
            serviceAgreementForOtherExpln: [null],
            reason: [null],
            enddate: [null],
            achieveddate: [null],
            reviewdate: [null]
            // endcomments: [null]
        });

    }

    toggleFormMode() {
        this.isInView = false;
        switch (this.formAction) {
            case 'Add':
                this.forminit();
                this.permanencyPlanForm.controls['achieveddate'].disable();
                this.permanencyPlanForm.controls['enddate'].disable();
                this.permanencyPlanForm.controls['reason'].disable();
                break;
            case 'Edit':
                const formData = this._serviceCasePermanencyPlanService
                    .selectedPermanencyPlan;
                this.LoadPermanencyForm(formData);
                this.permanencyPlanForm.enable();
                this.permanencyPlanForm.controls['achieveddate'].disable();
                this.permanencyPlanForm.controls['enddate'].disable();
                this.permanencyPlanForm.controls['reason'].disable();
                break;
            case 'View':
                this.permanencyPlanForm.disable();
                this.isInView = true;
                const viewFormData = this._serviceCasePermanencyPlanService
                    .selectedPermanencyPlan;
                this.LoadPermanencyForm(viewFormData);
                this.permanencyPlanForm.controls['permanencyplanremainssamedate'].disable();
                this.permanencyPlanForm.controls['achieveddate'].disable();
                this.permanencyPlanForm.controls['enddate'].disable();
                this.permanencyPlanForm.controls['reason'].disable();
                break;
            case 'Review':
                const planReviewformData = this._serviceCasePermanencyPlanService
                    .selectedPermanencyPlan;
                this.LoadPermanencyForm(planReviewformData);
                this.permanencyPlanForm.controls.permanencyplanremainssame.reset();
                this.permanencyPlanForm.controls.permanencyplanremainssamedate.reset();
                break;
            case 'AuditLog':
                this.isValue = 3;
                this.showAuditLogInfo = true;
                this.formAction = '';
                const auditdata = this._serviceCasePermanencyPlanService
                    .selectedPermanencyPlan;
                this.LoadPermanencyForm(auditdata);
                break;    
            case 'Exit':
                const exitViewFormData = this._serviceCasePermanencyPlanService
                    .selectedPermanencyPlan;
                this.LoadPermanencyForm(exitViewFormData);
                break;
            default:
                break;
        }
    }

    LoadPermanencyForm(formData: any) {
        const data: any = {};
        data['permanencyplanid'] = this.nullCheck(formData.permanencyplanid);
        data['concurrentplandate'] = this.nullDateCheck(formData.establisheddate);
        data['primaryplandate'] = this.nullDateCheck(formData.establisheddate);
        data['primarypermanencytype'] = formData.primarypermanency ? this.nullCheck(formData.primarypermanency[0].permanencyplantypekey) : null;
        data['concurrentpermanencytype'] = formData.concurrentpermanency ? this.nullCheck(formData.concurrentpermanency[0].concurrentplantypekey) : null;
        data['primaryarrangetype'] = this.nullCheck(formData.primaryarrangetype);
        data['concurrentarrangetype'] = this.nullCheck(formData.concurrentarrangetype);
        data['remarks'] = this.nullCheck(formData.primarycomments);
        data['concurrentcomments'] = this.nullCheck(formData.concurrentcomments);
        data['enddate'] = this.nullDateCheck(formData.enddate);
        data['reason'] = formData.reason
            ? formData.reason.trim() 
            : null;
        data['parentname'] = this.nullCheck(formData.parentname);   
        data['parent2name'] = this.nullCheck(formData.parent2name);     
        data['achieveddate'] = this.nullDateCheck(formData.achieveddate);
        data['courtorderreceived'] = this.nullCheck(formData.courtorderreceived);
        data['permanencyplanremainssame'] = formData.permanencyplanremainssame === '' || null ? null : formData.permanencyplanremainssame;
        data['permanencyplanremainssamedate'] = this.nullCheck(formData.permanencyplanremainssamedate);

        this.permanencyPlanForm.patchValue(data);
        this.endMaxDate = new Date(data['primaryplandate']);
        const permplanquestdata = formData && formData['permplanquestdata'] ? formData['permplanquestdata'] : null;
        if (permplanquestdata) {
            this.permanencyPlanForm.patchValue({
                'isInClosedProximity': permplanquestdata.isInClosedProximity,
                'isInClosedProximityExpln': permplanquestdata.isInClosedProximityExpln,
                'meetingSafetyNeedsExpln': permplanquestdata.meetingSafetyNeedsExpln,
                'sixMonthsPlacementExpln': permplanquestdata.sixMonthsPlacementExpln,
                'courtOrdersExpln': permplanquestdata.courtOrdersExpln,
                'permToPermExpln': permplanquestdata.permToPermExpln,
                'safeAndCareExpln': permplanquestdata.safeAndCareExpln,
                'assessmentPeriodExpln': permplanquestdata.assessmentPeriodExpln,
                'lifebookExpln': permplanquestdata.lifebookExpln,
                'serviceAgreementExpln': permplanquestdata.serviceAgreementExpln,
                'isProviderAgree': permplanquestdata.isProviderAgree,
                'isProviderAgreeExpln': permplanquestdata.isProviderAgreeExpln,
                'serviceAgreementForOtherExpln': permplanquestdata.serviceAgreementForOtherExpln,
            });
        }
        this.controlPermanencyPlanForm(formData);
        
    }
    nullCheck(inputData: any){
        return inputData ? inputData : null;
    }
    nullDateCheck(inputData: any){
        return inputData ? new Date(inputData) : null;
    }
    controlPermanencyPlanForm(formData: any) {
        const primaryFormData = this.permanencyPlanForm.getRawValue();
        if (primaryFormData.primarypermanencytype === 'Reunification') {
            this.permanencyPlanForm.controls['primarypermanencytype'].disable();
        } else {
            this.permanencyPlanForm.controls['primarypermanencytype'].enable();
        }
        if (this.isViewMode) {
            this.permanencyPlanForm.disable();
            this.isInView = true;
            this.disableEndPlan = true;
        } else {
            this.isInView = false;
        }

        if (formData.status === 'Approved' || formData.status === 'Rejected') {
            if (!formData.enddate) {
                this.permanencyPlanForm.controls['enddate'].enable();
                this.permanencyPlanForm.controls['reason'].enable();
            }
            if (this.formAction != 'Review') {
                this.permanencyPlanForm.disable();
                this.permanencyPlanForm.controls['achieveddate'].enable();
                this.permanencyPlanForm.controls['enddate'].enable();
                this.permanencyPlanForm.controls['reason'].enable();
            } else {
                this.permanencyPlanForm.disable();
            }

            this.disableEndPlan = false;
            this.isInView = true;
            if (formData.status === 'Rejected') {
                this.isInView = false;
            }
        }
        if (this.permanencyPlanForm.getRawValue().primarypermanencytype === 'APPLA') {
            this.permanencyPlanForm.controls['achieveddate'].enable();
        } else {
            this.permanencyPlanForm.controls['reason'].clearValidators();
            this.permanencyPlanForm.controls['enddate'].clearValidators();
        }
        this.permanencyPlanForm.controls['permanencyplanremainssame'].enable();
        this.permanencyPlanForm.controls['permanencyplanremainssamedate'].disable();
    }

    loadPermanencyTypeDropDown() {
        this.commonHttpService
            .getArrayList(
                {},
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PermanencyPlan
                    .PermanancyPlanTypeSubType + '?filter={}'
            )
            .subscribe(type => {
                this.permanencyType = type;
                if(this.permanencyType ){
                const details =  this.permanencyPlanForm.getRawValue();
                this.getAuditInformation(details.permanencyplanid);
                }
                // Removing Auto Population of Primary permanency plan as Reunification
                // if (!this._serviceCasePermanencyPlanService.isAnyPlansExist()) {
                //     this.permanencyPlanForm.patchValue({
                //         primarypermanencytype: 'Reunification'
                //     });
                // }
            });
    }

    private getInvolvedPerson() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');     
        let url = '';

        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        this.commonHttpService
            .getArrayList(
                {
                    page: 1,
                    method: 'get',
                    where: {objectid: this.id , objecttypekey : 'servicecase',isExpungementSuperUser:isExpungementSuperUser,'iscaseexpunged': iscaseexpunged}
                },
                url + '?filter'
            )
            .subscribe((res: any) => {
                if (res['data'] && res['data'].length) {
                    this.involvedPersons = [];
                    this.involvedPersonResponseDataLoopFn(res);
                    if(this.involvedPersons && this.involvedPersons.length) {
                    this.involvedPersons.sort((a: any,b: any)=>a.fullname.localeCompare(b.fullname));
                    }
                    }
            });
    }
    // Assosiated with getInvolvedPerson function 
    private involvedPersonResponseDataLoopFn(res: any) {
        res['data'].map((item: any) => {
            // console.info(item.roles,"roles")
            const roles = (Array.isArray(item.roles)) ? item.roles : [];
            const parent = roles.some((role: { intakeservicerequestpersontypekey: string; }) => ['PARENT', 'LG', 'ADOPTIVEPARENT'].includes(role.intakeservicerequestpersontypekey));
            if (parent) {
                this.involvedPersons.push(item);
                if (this.involvedPersons) {
                    this.loadPermanencyTypeDropDown();
                }
            } else {
                this.loadPermanencyTypeDropDown();
            }
        });
    }

    getRoles(item: { roles: any; }){
        return (Array.isArray(item.roles)) ? item.roles : [];
    }

    onChangePrimaryPlan(selected: any) {
        const formData = this.permanencyPlanForm.getRawValue();
        const concurrentPlan = formData.concurrentpermanencytype;
        if (concurrentPlan && concurrentPlan === selected) {
            this._alert.error(
                this.validationmsg
            );
            this.permanencyPlanForm.patchValue({ primarypermanencytype: null });
        }
        if (concurrentPlan && concurrentPlan === 'APPLA' && selected === 'CRLTC') {
            this._alert.error(
                this.validationmsg
            );
            this.permanencyPlanForm.patchValue({
                primarypermanencytype: null
            });
        }
        if (concurrentPlan && concurrentPlan === 'CRLTC' && selected === 'APPLA') {
            this._alert.error(
                this.validationmsg
            );
            this.permanencyPlanForm.patchValue({
                primarypermanencytype: null
            });
        }

        // concurrency plan is now mandatory for all primary concurrency plan
        //CDM-159
        if (selected === 'APPLA') {
                 this.permanencyPlanForm.get('concurrentpermanencytype')?.clearValidators();
                 this.concurrentPlanRequired = false;
        }else{
            this.permanencyPlanForm.get('concurrentpermanencytype')?.setValidators([Validators.required]);
        this.concurrentPlanRequired = true;
        }
       
    }

    onChangeConcurrentPlan(selected: any) {
        const formData = this.permanencyPlanForm.getRawValue();
        const permanencyPlan = formData.primarypermanencytype;
        this.onChangePrimaryDate();
        if (permanencyPlan && permanencyPlan === selected) {
            this._alert.error(
                this.validationmsg
            );
            this.permanencyPlanForm.patchValue({
                concurrentpermanencytype: null
            });
        }

        if (permanencyPlan && permanencyPlan === 'APPLA' && selected === 'CRLTC') {
            this._alert.error(
                this.validationmsg
            );
            this.permanencyPlanForm.patchValue({
                concurrentpermanencytype: null
            });
        }
        if (permanencyPlan && permanencyPlan === 'CRLTC' && selected === 'APPLA') {
            this._alert.error(
                this.validationmsg
            );
            this.permanencyPlanForm.patchValue({
                concurrentpermanencytype: null
            });
        }
    }

    onChangePrimaryDate() {
        const formData = this.permanencyPlanForm.getRawValue();
        const permanencyPlanDate = formData.primaryplandate;
        if (permanencyPlanDate) {
        this.endMaxDate = new Date(permanencyPlanDate);      
            this.permanencyPlanForm.patchValue({
                concurrentplandate: new Date(permanencyPlanDate)
            }); 
        
     }
    }

    goBack() {
        this._serviceCasePermanencyPlanService
            .getChildRemovalInfoAndPlacements()
            .subscribe(response => {
                this._serviceCasePermanencyPlanService.broadCastPageRefresh();
                this.router.navigate(['../'], { relativeTo: this.route });
            });
    }

   
    submitPermanencyPlan(isreviewsubmit: any) {
        this.displayValidationMessages =false;
        ['primarypermanencytype', 'primaryplandate', 'parentname','concurrentpermanencytype','achieveddate','enddate','reason'].forEach((item) => {
            this?.permanencyPlanForm?.get(item)?.clearValidators();
            this?.permanencyPlanForm?.get(item)?.updateValueAndValidity();
        });  
        if(this?.formAction === 'Exit') {
            ['achieveddate', 'enddate', 'reason'].forEach((item) => {
                this?.permanencyPlanForm?.get(item)?.setValidators([Validators.required]);
                this?.permanencyPlanForm?.get(item)?.updateValueAndValidity();
            });
        } else {            
            ['primarypermanencytype', 'primaryplandate', 'concurrentpermanencytype'].forEach((item) => {
                this?.permanencyPlanForm?.get(item)?.setValidators([Validators.required]);
                this?.permanencyPlanForm?.get(item)?.updateValueAndValidity();
            });
            if(this?.permanencyPlanForm?.getRawValue()?.primarypermanencytype === 'Reunification') {
                this.permanencyPlanForm.get('parentname')?.setValidators([Validators.required]);
                this.permanencyPlanForm.get('parentname')?.updateValueAndValidity();
            }
            if(this?.permanencyPlanForm?.getRawValue()?.primarypermanencytype === 'APPLA') {
                this.permanencyPlanForm.get('concurrentpermanencytype')?.clearValidators();
                this.permanencyPlanForm.get('concurrentpermanencytype')?.updateValueAndValidity();
            }
        }
        if (this.permanencyPlanForm && this.permanencyPlanForm.invalid) {
            this.displayValidationMessages =true;
            this.permanencyPlanForm.markAllAsTouched();
        }
       this.disableSave = true;
       if (this.permanencyPlanForm.invalid && isreviewsubmit != 0) {
            this._alert.error('Please fill required fields');
            this.disableSave = false;
            return false;
        }
        this.sendApproval(isreviewsubmit);
    }
    checkIsExists(isExist: any){
        return (isExist) ? false : true;
    }
    sendApproval(isreviewsubmit: any) {
        const planData = this.permanencyPlanForm.getRawValue();
        if (planData.primarypermanencytype === 'Reunification' && !planData.permanencyplanid && (planData.parentname === null || planData.parentname === '')) {
            this._alert.error('Please fill required fields');
            this.disableSave = false;
            return false;
        }
        // CIDM-8128 To Restrict special characters as get_audittrail_field_difference function is failing, can be removed once the SP is fixed
        if (this.checkPlanData1(planData) || this.checkPlanData2(planData)) {
            this._alert.error('Special characters like [ , ] , { , } are not allow, Please remove and try it again');
            this.disableSave = false;
            return false;
        }

        const isAllowed = this.checkIsAllowed(planData);
        if (isAllowed) {
            this.sendApprovalValidation(planData,isreviewsubmit);
        } else {
            this._alert.warn('Active Permanency plan already exist.');
            this.disableSave = false;
        }
    }
    checkPlanData1(planData: any){
        if( (planData.isInClosedProximityExpln && planData.isInClosedProximityExpln.includes('[',']')) || (planData.meetingSafetyNeedsExpln && planData.meetingSafetyNeedsExpln.includes('[',']')) ||
            (planData.sixMonthsPlacementExpln && planData.sixMonthsPlacementExpln.includes('[',']')) || (planData.courtOrdersExpln && planData.courtOrdersExpln.includes('[',']')) ||
            (planData.permToPermExpln && planData.permToPermExpln.includes('[',']')) || (planData.safeAndCareExpl && planData.safeAndCareExpln.includes('[',']')) || (planData.assessmentPeriodExpln && planData.assessmentPeriodExpln.includes('[',']'))) {
            return true;
        } else {
            return false;
        }
    }
    checkPlanData2(planData: any){
        if( (planData.lifebookExpln && planData.lifebookExpln.includes('[',']')) || (planData.serviceAgreementExpln && planData.serviceAgreementExpln.includes('[',']')) ||
            (planData.isProviderAgreeExpln && planData.isProviderAgreeExpln.includes('[',']')) || (planData.serviceAgreementForOtherExpln && planData.serviceAgreementForOtherExpln.includes('[',']'))) {
            return true;
        } else {
            return false;
        }
    }

    sendApprovalValidation(planData: any, isreviewsubmit: any){
        const permplanquestdata = {
            'isInClosedProximity': planData.isInClosedProximity,
            'isInClosedProximityExpln': planData.isInClosedProximityExpln,
            'meetingSafetyNeedsExpln': planData.meetingSafetyNeedsExpln,
            'sixMonthsPlacementExpln': planData.sixMonthsPlacementExpln,
            'courtOrdersExpln': planData.courtOrdersExpln,
            'permToPermExpln': planData.permToPermExpln,
            'safeAndCareExpln': planData.safeAndCareExpln,
            'assessmentPeriodExpln': planData.assessmentPeriodExpln,
            'lifebookExpln': planData.lifebookExpln,
            'serviceAgreementExpln': planData.serviceAgreementExpln,
            'isProviderAgree': planData.isProviderAgree,
            'isProviderAgreeExpln': planData.isProviderAgreeExpln,
            'serviceAgreementForOtherExpln': planData.serviceAgreementForOtherExpln,
        };
        planData.permplanquestdata = permplanquestdata;
        this.selectedChildren = this._serviceCasePermanencyPlanService.selectedChildren;
        if (
            (!this.selectedChildren || !this.selectedChildren.length) &&
            !planData.permanencyplanid
        ) {
            this._alert.error('Please Select Child');
            this.disableSave = false;
            return;
        }

        if (planData.primarypermanencytype === 'APPLA' || planData.primarypermanencytype === 'CRLTC') {
            let isValidAgeForAllChildCount = 0;
            this.selectedChildren.forEach(child => {
                const age = moment().diff(child.dob, 'years', true);
                if (age >= 16) {
                    isValidAgeForAllChildCount++;
                }
            });

            if (isValidAgeForAllChildCount !== this.selectedChildren.length) {
                this.errorMessage = 'APPLA should not be used as a permanency plan for child/children under the age of 16 years';
                (<any>$('#validation-error')).modal('show');
                this.disableSave = false;
                return;
            }
        }

        if (planData.primaryplandate && planData.enddate && new Date(planData.enddate) < new Date(planData.primaryplandate)) {
            this._alert.error('End date should be Equal to or Greater than Plan Established Date');
            this.disableSave = false;
            return;
        }

        planData['isreviewsubmit'] = isreviewsubmit;
        if (!this._serviceCasePermanencyPlanService.addedPermanencyplan) {
            this._serviceCasePermanencyPlanService.sendApprovalInQueue(planData);
        }
    }

    checkIsAllowed(planData: any){
        const isExist = this.permanencyPlanList.some((plan: { primarypermanency: any; enddate: any; status: string; }) => {
            const list = (Array.isArray(plan.primarypermanency)) ? plan.primarypermanency : [];
            const isPresent = list.some(item => {
                return ((((item.permanencyplantypekey === planData.primarypermanencytype) && !plan.enddate)
                    || ((item.permanencyplantypekey === planData.primarypermanencytype) && plan.status !== 'Approved')) && plan.status !== 'Rejected');
            });
            this.disableSave = false;
            return isPresent;
        });
       return (this.formAction === 'Edit' || 'Review') ? true : this.checkIsExists(isExist);
    }

    selectParent1(item: any) {
        if(item !=null && this.involvedPersons){
            this.permanencyPlanForm.patchValue({
                parent2name: null
            });
        }
    }

    selectParent2(item: any) {
        const parent1 = this.permanencyPlanForm.getRawValue().parentname;
        if(item === parent1) {
            this._alert.warn('The parent name is already chosen in Parent 1 selection. Please select some other parent name');
            this.permanencyPlanForm.patchValue({
                parent2name: null
            });
        }
    }


    loadHistory() {
        const obj = this.storage.getObj('historyRequestReview');
        const permanencyplanid = this.storage.getObj('permanencyplanIdFrHistory');
        if (obj && permanencyplanid) {
            this.historyRequest = {

                'intakeservicerequestactorid': obj.intakeservicerequestactorid,
                'personid': obj.personid,
                'sortcol': obj.sortColumn,
                'sortby': obj.sortBy,
                'updatedfrom': obj.fromDate,
                'updatedto': obj.toDate,
                'updatedby': obj.worker
            };
            this._serviceCasePermanencyPlanService.getPermanencyPlanHistory(1, this.historyRequest).subscribe(result => {
                this.setPlanHistory(result,permanencyplanid);
            });

            this._serviceCasePermanencyPlanService.getPermanencyPlanHistoryDetails(permanencyplanid).subscribe(result  => {
                if (result) {
                  this.planHistoryDetails = result;
                  this.checkPlanHistoryDetails();
                } else {
                  this.planHistoryDetails = [];
                }
              });
        }
    }

    setPlanHistory(result: any, permanencyplanid: any){
        if (result && result.data && result.data.length) {
            this.planHistory = result.data;
            this.planHistoryById = this.planHistory.filter((i: any) => (i.permanencyplanid === permanencyplanid))
        } else {
            this.planHistory = [];
        }
    }

    checkPlanHistoryDetails() {
        const caseworkerid = this.planHistoryDetails.filter((i: any) => (i.status === 'Review'));
        this.planHistoryDetails.forEach((i: any) => {
            if (i.permanencyplanremainssame) {
                i.permanencyplanremainssame = 'Yes'
            } else if (!i.permanencyplanremainssame) {
                i.permanencyplanremainssame = 'No'
            } else {
                i.permanencyplanremainssame = 'NA'
            }
            if (caseworkerid && caseworkerid.length) {
                i.caseworkerdetails = caseworkerid[0].fullname;
                i.caseworkerupdated = caseworkerid[0].updatedon;
            }
        })
    }

    onChngPermanencyplanremainssame() {
        if (this.formAction === 'Review') {
            const flag = this.permanencyPlanForm.controls.permanencyplanremainssame.value;
            const remainsDate: any = this.permanencyPlanForm.controls['permanencyplanremainssamedate']; 
            const setTime = remainsDate.value === null? moment(new Date()).format('YYYY-MM-DDTHH:mm') : remainsDate.value;
            if (flag) {
                this.permanencyPlanForm.enable();
                this.permanencyPlanForm.controls['primarypermanencytype'].disable();
                this.permanencyPlanForm.controls['primaryplandate'].disable();
                this.permanencyPlanForm.controls['remarks'].disable();
                this.permanencyPlanForm.controls['parentname'].disable();
                this.permanencyPlanForm.controls['parent2name'].disable();
                this.permanencyPlanForm.controls['concurrentpermanencytype'].enable();
                this.permanencyPlanForm.controls['concurrentplandate'].disable();
                this.permanencyPlanForm.controls['concurrentcomments'].disable();
                this.permanencyPlanForm.controls['achieveddate'].disable();
                this.permanencyPlanForm.controls['achieveddate'].reset();
                this.permanencyPlanForm.controls['enddate'].disable();
                this.permanencyPlanForm.controls['enddate'].reset();
                this.permanencyPlanForm.controls['reason'].disable();
                this.permanencyPlanForm.controls['reason'].reset();
                remainsDate.patchValue(setTime);
            } else if (!flag) {
                this.permanencyPlanForm.disable();
                this.permanencyPlanForm.controls['primarypermanencytype'].enable();
                this.permanencyPlanForm.controls['primaryplandate'].enable();
                this.permanencyPlanForm.controls['remarks'].enable();
                this.permanencyPlanForm.controls['parentname'].enable();
                this.permanencyPlanForm.controls['parent2name'].enable();
                this.permanencyPlanForm.controls['concurrentplandate'].enable();
                this.permanencyPlanForm.controls['concurrentcomments'].enable();
                this.permanencyPlanForm.controls['achieveddate'].enable();
                this.permanencyPlanForm.controls['enddate'].patchValue(moment(new Date()).format('YYYY-MM-DD'));
                this.permanencyPlanForm.controls['enddate'].enable();
                this.permanencyPlanForm.controls['reason'].enable();
                remainsDate.patchValue(moment(new Date()).format('YYYY-MM-DDTHH:mm'));
            }else{
                this.permanencyPlanForm.disable();
            }
            this.permanencyPlanForm.controls['permanencyplanremainssame'].enable();
            this.permanencyPlanForm.controls['permanencyplanremainssamedate'].disable();
            this.permanencyPlanForm.controls['primarypermanencytype'].disable();
            this.permanencyPlanForm.controls['primaryplandate'].disable();
            this.permanencyPlanForm.controls['remarks'].disable();
            this.permanencyPlanForm.controls['courtorderreceived'].disable();
            this.permanencyPlanForm.controls['parentname'].disable();
            this.permanencyPlanForm.controls['parent2name'].disable();

            this.permanencyPlanForm.controls['concurrentplandate'].disable();
            this.permanencyPlanForm.controls['concurrentcomments'].disable();

        }
        if ((this.formAction === 'Exit' && this.exitDate !== null && !this.isremovalendated) || 
                (this.exitDate !== null && this.permanencyPlanForm.controls.permanencyplanremainssame.value === false && !this.isremovalendated)) {
            this._alert.success('There is an Open/Active Removal. You must enter a new Permanency Plan.')
        }
    }

    auditlogTrailOpen(id: any, index: any) {
        if(id.modifieddata.data && id.modifieddata.data.length) {
            this.auditlogTrailExpand  = id.modifieddata.data
        }
        (<any>$('#audittrail-expand')).modal('show');
    }


    showOrHideAuditLog(value: any) {
        if(value) {
            this.showAuditLogInfo = true;
            this.isValue = 3;
        } else {
            this.showAuditLogInfo = false;
            this.isValue = 1;
        }

    }

    getAuditInformation(permanencyplanid: any) {
        this.commonHttpService.getPagedArrayList(
            new PaginationRequest({
                limit: 30,
                page: 1,
                method: 'get',
                where: {
                    columnid: 'permanencyplanid',
                    tableid: 'permanencyplan_history',
                    objectid: permanencyplanid
                }

            }),
            'servicecase/getauditlog?filter').subscribe((result) => {
                if (result && result.data) {
                    const sortresult = result.data;
                    this.setAuditLogTrail(sortresult);
                }
            });
    }

    setAuditLogTrail(sortresult: any){
        sortresult.forEach((el: any) => {
            const a = el.modifieddata && el.modifieddata.data ? el.modifieddata.data : null;
            const statusCheck = el.modifieddata.status ? el.modifieddata.status : null;
            if (a && a.length) {
                a.forEach((element: any) => {
                    element.new_value = this.checkElementNewValue(element,statusCheck);
                    element.old_value = this.checkElementOldValue(element,statusCheck);
                });
            }
        })
        this.auditlogTrail = sortresult;
    }

    checkElementNewValue(element: any,statusCheck: any) {
        element.new_value = this.checkElementNewValue1(element);

        if (element.key.includes('isInClosedProximity') || element.key.includes('isProviderAgree')) {
            element.new_value = this.checkElementNewValue2(element);
        }

        if (element.key.includes('permanencyplanremainssamedate')) {
            element.new_value = this.checkElementNewValue3(element);
        }

        if (element.key.includes('approvedon') || element.key.includes('submittedon') || element.key.includes('rejectedon')) {
            element.new_value = this.checkElementNewValue3(element);
        }

        if (element.key.includes('primarypermanencytype') || element.key.includes('concurrentpermanencytype')) {
            element.new_value = this.checkElementNewValue4(element);
        }

        if (element.key.includes('parent2name') || element.key.includes('parentname')) {
            element.new_value = this.checkElementNewValue5(element);
        }
        if (element.key.includes('permanencyplanremainssame') && statusCheck !== 'Inserted' && !element.key.includes('permanencyplanremainssamedate')) {
            element.new_value = this.checkElementNewValue6(element);
        }
        if (element.key.includes('isInClosedProximity') && statusCheck !== 'Inserted') {
            element.new_value = this.checkElementNewValue6(element);
        }
        if (element.key.includes('isProviderAgree') && statusCheck !== 'Inserted') {
            element.new_value = this.checkElementNewValue6(element);
        }
        return element.new_value;
    }

    checkElementOldValue(element: any,statusCheck: any) {
        element.old_value = this.checkElementOldValue1(element);

        if (element.key.includes('isInClosedProximity') || element.key.includes('isProviderAgree')) {
            element.old_value = this.checkElementOldValue2(element);
        }

        if (element.key.includes('permanencyplanremainssamedate')) {
            element.old_value = this.checkElementOldValue3(element);
        }

        if (element.key.includes('primarypermanencytype') || element.key.includes('concurrentpermanencytype')) {
            element.old_value = this.checkElementOldValue4(element);
        }

        if (element.key.includes('parent2name') || element.key.includes('parentname')) {
            element.old_value = this.checkElementOldValue5(element);
        }
        if (element.key.includes('permanencyplanremainssame') && statusCheck !== 'Inserted' && !element.key.includes('permanencyplanremainssamedate')) {
            element.old_value = this.checkElementOldValue6(element);
        }
        if (element.key.includes('isInClosedProximity') && statusCheck !== 'Inserted') {
            element.old_value = this.checkElementOldValue6(element);
        }
        if (element.key.includes('isProviderAgree') && statusCheck !== 'Inserted') {
            element.old_value = this.checkElementOldValue6(element);
        }
        return element.old_value;
    }

    checkElementNewValue1(element: any){
        if (element.new_value === true || element.new_value === 1) {
            element.new_value = 'Yes';
        }
        if (element.new_value === false || element.new_value === 2 || element.new_value === 0) {
            element.new_value = 'No';
        }

        if (element.key.includes('date') && !element.key.includes('permanencyplanremainssamedate')) {
            if (element.new_value && moment(element.new_value).isValid()) {
                element.new_value = this.getDateFormatted(element.new_value);
            }
        }
        if (element.key.includes('time')) {
            if (element.new_value && moment(element.new_value).isValid()) {
                element.new_value = this.getTimeFormatted(element.new_value);
            }
        }
        return element.new_value;
    }

    checkElementOldValue1(element: any){
        if (element.old_value === true || element.old_value === 1) {
            element.old_value = 'Yes';
        }
        if (element.old_value === false || element.old_value === 2 || element.old_value === 0) {
            element.old_value = 'Yes';
        }
        if (element.key.includes('date') && !element.key.includes('permanencyplanremainssamedate')) {
            if (element.old_value && moment(element.old_value).isValid()) {
                element.old_value = this.getDateFormatted(element.old_value);
            }
        }
        if (element.key.includes('time')) {
            if (element.old_value && moment(element.old_value).isValid()) {
                element.old_value = this.getTimeFormatted(element.old_value);
            }
        }
        return element.old_value;
    }

    checkElementNewValue2(element: any){
        if (element.new_value == 1) {
            element.new_value = 'Yes';
        }
        if (element.new_value == 0) {
            element.new_value = 'No';
        }
        if (element.new_value == 2) {
            element.new_value = 'NA';
        }
        return element.new_value;
        
    }

    checkElementOldValue2(element: any){
        if (element.old_value == 1) {
            element.old_value = 'Yes';
        }
        if (element.old_value == 0) {
            element.old_value = 'No';
        }
        if (element.old_value == 2) {
            element.old_value = 'NA';
        }
        return element.old_value;
    }

    checkElementNewValue3(element: any){
        if (element.new_value && moment(element.new_value).isValid()) {
            element.new_value = this.getDateTimeFormatted(element.new_value);
        }
        return  element.new_value;
    }

    checkElementOldValue3(element: any){
        if (element.old_value && moment(element.old_value).isValid()) {
            element.old_value = this.getDateTimeFormatted(element.old_value);
        }
        return  element.old_value;
    }

    checkElementNewValue4(element: any){
        if (element.new_value) {
            element.new_value = this.permanencyType.filter((i: { permanencyplantypekey: any; }) => i.permanencyplantypekey == element.new_value)[0].description;
        }
        return  element.new_value;
    }
 
    checkElementOldValue4(element: any){
        if (element.old_value) {
            element.old_value = this.permanencyType.filter((i: { permanencyplantypekey: any; }) => i.permanencyplantypekey == element.old_value)[0].description;
        }
        return  element.old_value;
    }

    checkElementNewValue5(element: any){
        if (element.new_value) {
            const parent_name = this.involvedPersons.filter((i: { intakeservicerequestactorid: any; }) => i.intakeservicerequestactorid == element.new_value);
            element.new_value = parent_name[0]?.firstname + ' ' + parent_name[0]?.lastname;
        }
        return  element.new_value;
    }
 
    checkElementOldValue5(element: any){
        if (element.old_value) {
            const parent_name = this.involvedPersons.filter((i: { intakeservicerequestactorid: any; }) => i.intakeservicerequestactorid == element.old_value);
            element.old_value = parent_name[0]?.firstname + ' ' + parent_name[0]?.lastname;
        }
        return  element.old_value;
    }


    checkElementNewValue6(element: any){
        if (element.new_value == null) {
            element.new_value = 'NA'
        }
        return  element.new_value;
    }
 
    checkElementOldValue6(element: any){
        if (element.old_value == null) {
            element.old_value = 'NA'
        }
        return  element.old_value;
    }


    getDateFormatted(date: any){
        if(date){
          return moment(date).format('MM/DD/YYYY');
        }else{
          return '';}
      }
    
      getDateTimeFormatted(date:any){
        if(date){
          return moment(date).format('MM/DD/YYYY, hh:mm A');
        }else{
          return '';}
      }
    
      getTimeFormatted(date:any){
        if(date){
          return moment(date).format('hh:mm a');
        }else{
          return '';}
      }

      getErrorsMessage(ControlName: any, displayName: any){
        if(this.permanencyPlanForm.controls[ControlName].status =='INVALID' ){
        return 'Please select valid ' + displayName
        }
      }

}
