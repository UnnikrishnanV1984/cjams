
import {of as observableOf, EMPTY, Observable, Subscription, forkJoin } from 'rxjs';
import {pluck, map, share} from 'rxjs/operators';
import { AfterViewChecked, AfterViewInit, ChangeDetectorRef, Component, Injector, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { DropdownModel, PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonHttpService, DataStoreService, ValidationService, AlertService } from '../../../../@core/services';
import { AuthService } from '../../../../@core/services/auth.service';
import { DispositionCode, DispostionOutput, Sdm, Disqualifyingcriteria } from '../_entities/newintakeModel';
import { ComplaintTypeCase, General } from '../_entities/newintakeSaveModel';
import { NewUrlConfig } from './../../newintake-url.config';
import { DispositionConfig } from './_configurations/reason';
import { IntakeStoreConstants, MyNewintakeConstants } from '../my-newintake.constants';
import { Router, ActivatedRoute } from '@angular/router';
import { AppConstants } from '../../../../@core/common/constants';
import jsPDF from 'jspdf';
import moment from 'moment';
import { IntakeConfigService } from '../intake-config.service';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { ObjectUtils } from '../../../../@core/common/initializer';
import { CpsDocLetterComponent } from '../intake-document-creator/cps-doc-letter/cps-doc-letter.component';
import { IntakeUtils } from '../../../_utils/intake-utils.service';
import { Html2CanvasService } from '../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'intake-disposition',
    templateUrl: './intake-disposition.component.html',
    styleUrls: ['./intake-disposition.component.scss'],
    standalone: false
})
export class IntakeDispositionComponent implements OnInit, AfterViewInit, AfterViewChecked {
    general!: General | null | undefined;
    scnRecommendOveride: any;
    caseDispositions: DispostionOutput[] = [];
    statusDropdownItems$!: Observable<DropdownModel[] | undefined>;
    dispositionList: DispositionCode[] = [];
    dispositionDropDown: DropdownModel[] = [];
    supDispositionDropDown: DropdownModel[] = [];
    disposition!: string;
    dispositionDropdownItems$!: Observable<DropdownModel[]>;
    pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
    dispositionFormGroup!: FormGroup;
    supervisorOverrideForm!: FormGroup;
    date = new Date();
    serviceTypeId!: string;
    showReason = false;
    supervisorUser!: boolean;
    timeReceived!: string;
    selectedNotes: any;
    showStatus = true;
    daTypeSubType!: string;
    role!: AppUser;
    agencyStatus!: string;
    intakePurpose: any;
    isKinship = true;
    isSENflag = false;
    showBehalfOfRequester = false;
    actionDropdown: DropdownModel[] = [];
    initRecomentdationDropdown: DropdownModel[] = [];
    agencyTypeDropdown!: Observable<DropdownModel[]>;
    supervisorOverrideReasons: any;
    isssta = false;
    isCW = false;
    isAS = false;
    sdm: Sdm;
    store: any;
    selectedPurpose: any;
    selectedServices:any;
    disableCPSIntakeReport = false;
    dispositionStatus: any[] = [];
    isCWIntakeWorker = false;
    isCWSupervisor = false;
    supervisourComments!: string;
    isReopenCase!: boolean;
    dispositioncode = '';
    isCWinfoNreff!: boolean;
    addedPersons: any[] = [];
    personsDob: any[] = [];
    isEvpa = false;
    checkVPA: any[] = [];
    isCaptureReason!: boolean;
    intakeRecommond!: string;
    dataStoreSubscription!: Subscription;
    intakeRecomendation!: string; // temp fix for monday demo
    emailForm!: FormGroup;
    supStatus: any;
    selectedServiceDescriptions: string [] = [];
    isSupervisorCommentRequired = false;
    isClosed = false;
    supervisorOverrides: any[] = [];
    supervisorOverridesLoaded = false;
    supervisoverridedecision = null;
    intakeapproveddate!: string;
    overridesmaxed!:boolean;
    accessStatus = true;
    alertMessage!:string;
    @ViewChild(CpsDocLetterComponent) cpsDoc!: CpsDocLetterComponent;
    isROHFlag = false;
    CPSFlag : string;
    isIRFlag!: boolean;
    reviewStatus: any;
    displayValidationMessages: boolean = false;
    informationandreferral = 'Information and Referral';
    requestforservices = 'Request for services';
    progressroa = 'Progress ROA';
    kinshipnavigator = 'Kinship Navigator';
    needmoreinformation = 'Need more information';
    returntoworkertxt = 'Return to Worker';
    screenout = 'Screen Out';
    inhomeserviceuuid = 'd207bdd4-f281-4ec8-949c-8fd9657227f9';
    intakesrtypeuuid = '247a8b26-cdee-4ce8-b36e-b37e49fd0103';
    getdispositionlisturl = 'daconfig/servicerequesttypeconfigdispositioncode/getdispositionlist?filter';
    selectedpurposesubtype: any;
    showoverrideerrormsg: boolean =false;
    supervisordisposition!: string | null | undefined;
    supervisoroverrideallreason: any[] = [];
    roletypekeyData = ['CWKN','CWKA']
    approvedIntake = false;
    submissionHistory: any;

    private _commonHttpService: CommonHttpService;
    private readonly formBuilder: FormBuilder;
    private readonly _authService: AuthService;
    private readonly _changeDetect: ChangeDetectorRef;
    private readonly _dataStoreService: DataStoreService;
    private readonly _router: Router;
    private readonly route: ActivatedRoute;
    private html2canvas:Html2CanvasService;

    isIntakeserreqstatustypekey = false;
    roaCPS: any;
    sdmIsFinalscreenin: any = '';
    constructor(
        private readonly injector : Injector,
        private readonly _intakeService: IntakeConfigService,
        private readonly _alertService: AlertService,
        private readonly _util: IntakeUtils
    ) {
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._changeDetect = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._router = this.injector.get<Router>(Router);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this.html2canvas = this.injector.get<Html2CanvasService>(Html2CanvasService);

        this.store = this._dataStoreService.getCurrentStore();
        this.addedPersons = this.store[IntakeStoreConstants.addedPersons];
        const addNarrative = this.store[IntakeStoreConstants.addNarrative];
        const intake = this._dataStoreService.getData('intake');
        this.CPSFlag = this._dataStoreService.getData('CPSFlag');
        this.sdm = this.store[IntakeStoreConstants.intakeSDM];
        this.selectedServices = this.store[IntakeStoreConstants.intakeService];

        if (addNarrative?.Narrative === '') {
            alert('Please complete Narrative!');
            this._util.intakeTabSwitch$.next('narrative');
            const url = '/pages/newintake/my-newintake/' + intake.number + '/' + intake.action + '/narrative';
            this._router.navigate([url]);
            return;
        }


        this.checkAddedPersonsFn();

        const voluntaryPlacementId = this._dataStoreService.getData('voluntryPlacementType');
        if (voluntaryPlacementId !== 'VPA') {
            this.isEvpa = false;
        } else {
            this.isEvpa = true;
        }

        this.dispositioncode = '';
        this.checkSdmConditionFn();
    }

    private checkAddedPersonsFn() {
        if (this.addedPersons && this.addedPersons.length > 0) {
            this.personsDob = this.addedPersons.filter(
                person => (this.calculateAge(person.Dob) >= 18 && this.calculateAge(person.Dob) <= 20.5));
            if (this.personsDob && this.personsDob.length > 0) {
                const countId = this._dataStoreService.getData('countyId');
                this.checkVPA = [];
                this.personsDob.forEach(person => {
                    this._commonHttpService
                        .getArrayList(
                            new PaginationRequest({
                                method: 'get',
                                where: {
                                    county: countId,
                                    personid: person.Pid
                                },
                                limit: 10,
                                order: 'desc',
                                page: 1,
                                count: -1
                            }),
                            'Intakeservs/getvpadetails?filter'
                        )
                        .subscribe(
                            (result) => {
                                this.vpaDetailsResponseFn(result, person);
                            }
                        );
                });
            }
        }
    }

    private vpaDetailsResponseFn(result: any[], person: any) {
        if (result && result.length && result[0].checkvpa) {
            const checkVpaStatus = result[0].checkvpa.filter((item: any) => item.status === false || item.status === 'false');
            let vpaObj = { personid: person.Pid, status: true, checkVPA: result[0].checkvpa };
            if (checkVpaStatus && checkVpaStatus.length > 0) {
                vpaObj = { personid: person.Pid, status: false, checkVPA: result[0].checkvpa };
            }
            this.checkVPA.push(vpaObj);
        }
    }

    private checkSdmConditionFn() {
        if (this.sdm) {
            this.handleScnRecommendOverideFn();
        } else {
            const purpose = this._dataStoreService.getData(IntakeStoreConstants.purposeSelected);
            if (purpose && (purpose.code === 'CHILD'   || (purpose.code === this.kinshipnavigator &&(this.selectedServices && (this.selectedServices[0]?.description ==='Formal' || this.selectedServices[0]?.description ==='Informal'))))) {
                this.dispositioncode = 'ScreenOUT';
            }
        }
    }
    // Assosiated to checkSdmConditionFn method
    private handleScnRecommendOverideFn() {

        if (this.sdm.scnRecommendOveride === '') {
            if (this.sdm.screeningRecommend === 'ScreenOUT') {
                this.dispositioncode = 'ScreenOUT';
            } else if (this.sdm.screeningRecommend === 'Scrnin') {
                this.dispositioncode = 'Scrnin';
            }
        } else if (this.sdm.scnRecommendOveride === 'OvrScrnout') {
            this.dispositioncode = 'OvrScrnout';
        } else if (this.sdm.scnRecommendOveride === 'Ovrscrnin') {
            this.dispositioncode = 'Ovrscrnin';
        } else {
            this.dispositioncode = '';
        }

        this.sdmIsFinalscreenin = '';
        if (this.sdm.isfinalscreenin){
            this.sdmIsFinalscreenin = this.sdm.isfinalscreenin;
        }
    }

    ngOnInit() {

        this.checkClosedStatus();
        this.agencyTypeDropDownList();
        this.role = this._authService.getCurrentUser();
        const roletypekeyData = this.role?.user?.userprofile?.teammemberassignment?.teammember?.roletypekey;
        
        if (this._authService.isCW()) {
            this.isCWIntakeWorker = (this.role.role.name === AppConstants.ROLES.INTAKE_WORKER);
            this.isCWSupervisor = (this.role.role.name === AppConstants.ROLES.SUPERVISOR);
        }
        if (this._authService.isAS()) {
            this.isAS = true;
        }
        if (roletypekeyData && this.roletypekeyData.includes(roletypekeyData)) {
            this.isKinship = false;
        }

        this.supervisorUser = this.role.role.name === 'apcs' || this.role.role.name === 'Kinship Supervisor';
        this.selectedPurpose = this.store[IntakeStoreConstants.purposeSelected];
        this.selectedServices = this.store[IntakeStoreConstants.intakeService];
        this.actionDropdown = DispositionConfig.config.action;
        this.initRecomentdationDropdown = DispositionConfig.config.initialRecomendation;
        this.agencyStatus = this.store[IntakeStoreConstants.agency];
        this.roaCPS = this.store[IntakeStoreConstants.roacps];
        this.dispositionForm();
        this.buildSupervisorOverrideForm();
        this.getSupervisorOverrideReason();
        this.getSupervisorOverrides();
        const checkInput = {
            nolimit: true,
            where: { teamtypekey: 'all' },
            method: 'get'
        };
        this._commonHttpService.getArrayList(new PaginationRequest(checkInput), NewUrlConfig.EndPoint.Intake.IntakePurposes + '/list?filter').subscribe(result => {
            this.intakePurpose = result;
        });
        // end of - to get the label for datype

        this.ifAgencyNameCWCheckFn();

        // const currentStatus = this._dataStoreService.getData(IntakeStoreConstants.INTAKE_STATUS);
        this.reviewStatus = this._dataStoreService.getData(IntakeStoreConstants.INTAKE_STATUS);
        // this.isClosed = (currentStatus === 'Closed' || currentStatus === 'Completed');
        this.emailForm = this.formBuilder.group({
            email: ['', [ValidationService.mailFormat, Validators.required]]
        });

        if (this._dataStoreService.getData(IntakeStoreConstants.INTAKE_IS_CLOSED)) {
            this.isClosed = true;
            this.emailForm.disable();
            this.dispositionFormGroup.disable();
        }
        this.checkSelectedPurposeFn();

        // Reason For Delay
        this.checkReasonForDelayFn();
        this.isCW = this.role.role.teamtypekey === 'CW';
        
        // });
        // this.purposeCheckboxOutput$.subscribe(result => {
        //     result.forEach(item => {
        //         if (item.description === 'SSTA Request') {
        //             console.log('is ssta');
        //             this.isssta = true;
        //             this.loadDropdown();
        //         }
        //     });
        // });

        this.listenForVPEnabled();
        this.filterSelectedServicesFn();
        this.accessStatus = this._dataStoreService.getData(IntakeStoreConstants.ACCESS_STATUS);

        // Reassigning caseDispositions data after navigating from SDM page to decision page. This data is resetting when we are navigating from decion tab to sdm.
        if(this.reviewStatus === 'Review') {
            let caseDispositionsStoredValue = this._dataStoreService.getData('caseDispositions_Data');
            if(caseDispositionsStoredValue?.length > 0){
                caseDispositionsStoredValue.forEach((data: any, index: any) => {
                    if(data.DADisposition == 'ScreenOut' || data.DADisposition == 'Scrnin'){
                        this.onChangeSupDispoType(data.DADisposition, index);
                    }
                });
            }
        }
    }

    private checkReasonForDelayFn() {
        this.timeReceived = this.store[IntakeStoreConstants.timeleft];
        if (this.timeReceived) {
            if (this._intakeService.isNonCPS()) {
                this.disableReasonfordelay();
            } else {
                this.enableReasonfordelay();
            }
        }
    }

    private filterSelectedServicesFn() {
        if (this._intakeService.selectedPurposeIs(MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL)
            || this._intakeService.selectedPurposeIs(MyNewintakeConstants.PURPOSE.REQUEST_FOR_SERVICES)
            ||(this._intakeService.selectedPurposeIs(MyNewintakeConstants.PURPOSE.KINSHIP_NAVIGATOR ))) {
            const selectedServices = this.store[IntakeStoreConstants.intakeService];
            if (selectedServices && selectedServices.length) {
                const intakeSelectedDiscription = selectedServices.map((item: { description: any; }) => item.description);
                if(intakeSelectedDiscription.includes('I&R')){
                    const latestIntakeType = intakeSelectedDiscription[intakeSelectedDiscription.length-1];
                    this.selectedServiceDescriptions = [latestIntakeType];
                } else {
                    this.selectedServiceDescriptions = intakeSelectedDiscription;
                }
        }
    }
    this.accessStatus = this._dataStoreService.getData(IntakeStoreConstants.ACCESS_STATUS);
    }

    private checkSelectedPurposeFn() {
        if (this.selectedPurpose) {
            this.daTypeSubType = this.selectedPurpose.value;
            this.statusDropdownItems$ = EMPTY;
            if (this.selectedPurpose?.value === '619c4dcf-ef22-4fc4-9269-d7678e8a8f6a') {
                this.showBehalfOfRequester = true;
                this.disableCPSIntakeReport = false;
                const model = new DropdownModel();
                model.text = 'Recommended to Close I & R';
                model.value = 'Closed';
                this.handleCaseDispositionFn(model);
            } else if (this.selectedPurpose?.value=='7933508f-0350-4552-be50-350598a387a7' && this.selectedServices && this.selectedServices[0]?.description==='I&R' && !this.isCWSupervisor){
                this.showBehalfOfRequester = false;
                this.disableCPSIntakeReport = false;
                const model = new DropdownModel();
                model.text = 'Review';
                model.value = 'Review';
                this.handleCaseDispositionFn(model);
            } else if (this.selectedPurpose.code === 'ROACPS') {
                this.ifROACPSCodeFn();
            } else if (this.selectedPurpose.code === this.requestforservices && this._dataStoreService.getData(IntakeStoreConstants.clearhistory)) {
                this.showBehalfOfRequester = false;
                this.disableCPSIntakeReport = false;
                const model = new DropdownModel();
                model.text = 'Recommended to close Request for Services';
                model.value = 'Closed';
                this.statusDropdownItems$ = observableOf([model]);
                this.dispositionFormGroup.patchValue({
                    intakeserreqstatustypekey: 'Closed'
                });
                this.onChangeTaskStatus('Closed');
                this._dataStoreService.setData(IntakeStoreConstants.closeintakecw, true);
            } else {
                this.handleCheckSelectedPurposeCondFn();
            }
        }
    }
    // Assosiated to checkSelectedPurposeFn method
    private handleCheckSelectedPurposeCondFn() {
        if (this.selectedPurpose?.code === 'CHILD' || (this.selectedPurpose?.code === this.kinshipnavigator && (this.selectedServices && (this.selectedServices[0]?.description === 'Formal' || this.selectedServices[0]?.description === 'Informal')))) { // CPS
            {
                // this.ifCHILDCodeSdmFn();
                this.ifCHILDDispositionsFn();

            }
            this.loadDropdown();
        } else if (this.selectedPurpose.value === this.inhomeserviceuuid) { // In-Home Service
            this._dataStoreService.setData(IntakeStoreConstants.closeintakecw, false);
            this.disableCPSIntakeReport = true;
            this.showBehalfOfRequester = false;
            this.isIntakeserreqstatustypekey = true;
            this.loadDropdown();
            this.ifInhomeserviceuuidFn();

        } else if (this.selectedPurpose.value === '7933508f-0350-4552-be50-350598a387a7' && !this.isCWSupervisor) {
            if (this.selectedServices && this.selectedServices[0]?.description === 'I&R') {
                this.showBehalfOfRequester = false;
                this.disableCPSIntakeReport = false;
                const model = new DropdownModel();
                model.text = 'Recommended to Close I & R';
                model.value = 'Closed';
                model.text = 'Review';
                model.value = 'Review';
                this.statusDropdownItems$ = observableOf([model]);
                this.dispositionFormGroup.patchValue({
                    intakeserreqstatustypekey: 'Closed'
                });
                this.onChangeTaskStatus('Closed');
                this._dataStoreService.setData(IntakeStoreConstants.closeintakecw, true);
                this._dataStoreService.setData(IntakeStoreConstants.navigatetonarrative, false);
            } else {
                const model = new DropdownModel();
                model.text = 'Review';
                model.value = 'Review';
                this.statusDropdownItems$ = observableOf([model]);
                this.caseDispositions.forEach((item) => {
                    const model1 = new DropdownModel({
                        text: 'Screen In',
                        value: 'Scrnin'
                    });
                    const model2 = new DropdownModel({
                        text: this.screenout,
                        value: 'ScreenOUT'
                    });

                    item.intakeMultipleDispositionDropdown = [model1, model2];
                });
            }
        } else if (this.selectedPurpose.code === this.kinshipnavigator && this.isCWSupervisor) {
            const model3 = new DropdownModel();
            const model4 = new DropdownModel();
            model3.text = 'Accepted';
            model3.value = 'Approved';
            model4.text = this.returntoworkertxt;
            model4.value = 'Reopen';
            this.statusDropdownItems$ = observableOf([model3, model4]);
            this.dispositionFormGroup.patchValue({ supStatus: "Approved" });
            this.supOnChangeTaskStatus('Approved');
            this.caseDispositions.forEach((item) => {
                const model1 = new DropdownModel({
                    text: 'Screen In',
                    value: 'Scrnin'
                });
                const model2 = new DropdownModel({
                    text: this.screenout,
                    value: 'ScreenOUT'
                });
                item.intakeMultipleDispositionDropdown = [model1, model2];
                item.supMultipleDispositionDropdown = [model1, model2];
            });
        } else {
            this._dataStoreService.setData(IntakeStoreConstants.closeintakecw, false);
            this.disableCPSIntakeReport = false;
            this.showBehalfOfRequester = false;
            this.isIntakeserreqstatustypekey = true;
        }
    }
    // Assosiated to checkSelectedPurposeFn method
    private handleCaseDispositionFn(model: DropdownModel) {
        this.statusDropdownItems$ = observableOf([model]);
        this.dispositionFormGroup.patchValue({
            intakeserreqstatustypekey: 'Closed'
        });
        this.onChangeTaskStatus('Closed');
        this._dataStoreService.setData(IntakeStoreConstants.navigatetonarrative, false);
        this.caseDispositions.forEach((item) => {
            const model1 = new DropdownModel({
                text: 'Screen In',
                value: 'Scrnin'
            });
            const model2 = new DropdownModel({
                text: this.screenout,
                value: 'ScreenOUT'
            });
            const model3 = new DropdownModel({
                text: this.needmoreinformation,
                value: 'Dontmetreq'
            });

            item.intakeMultipleDispositionDropdown = [model1, model2];
            item.supMultipleDispositionDropdown = [model1, model2, model3];
        });
    }

    private ifInhomeserviceuuidFn() {
        let disps: any[] | null = null;
        disps = this.store[IntakeStoreConstants.disposition];
        if (disps && Array.isArray(disps) && disps.length && (disps[0].DADisposition != '' || disps[0].dispositioncode != '')) {
            this.intakeRecomendation = disps[0].DADisposition ? disps[0].DADisposition : disps[0].dispositioncode;
            this.intakeRecomendation = this.getDisposition(this.intakeRecomendation);
        } else {
            this.onChangeDispoType('Scrnin', 0);
            this.intakeRecommond = 'Scrnin';
        }
    }

    private ifCHILDDispositionsFn() {
        let dispositions: any[] | null = null;
        dispositions = this.store[IntakeStoreConstants.disposition];
        if (dispositions && Array.isArray(dispositions) && dispositions.length) {
            this.intakeRecomendation = this.scnRecommendOveride ? this.scnRecommendOveride : this.returnIntakeRecomendationFalseCondFn(dispositions);
            this.intakeRecomendation = this.getDisposition(this.intakeRecomendation);
        } else {
            this.ifNotDispositionsFn();
        }
    }

    private returnIntakeRecomendationFalseCondFn(dispositions: any[]): string {
        return (this.sdm && this.sdm.screeningRecommend) ? this.sdm.screeningRecommend : this.returnScreeningRecommendFalseCondFn(dispositions);
    }

    private returnScreeningRecommendFalseCondFn(dispositions: any[]): string {
        return dispositions[0].DADisposition ? dispositions[0].DADisposition : dispositions[0].dispositioncode;
    }

    private ifNotDispositionsFn() {
        if (!this.sdm) {
            this.callScreenOutFn();
        } else if (!this.sdm.screeningRecommend) {
            this.callScreenOutFn();
        } else if (this.sdm.screeningRecommend === 'ScreenOUT' && this.sdm.scnRecommendOveride === '') {
            this.callScreenOutFn();
        } else if (this.sdm.screeningRecommend === 'ScreenOUT' && this.sdm.scnRecommendOveride === 'Ovrscrnin') {
            this.callScreenInFn();
        } else if (this.sdm.screeningRecommend === 'Scrnin' && this.sdm.scnRecommendOveride === '') {
            this.callScreenInFn();
        } else if (this.sdm.screeningRecommend === 'Scrnin' && this.sdm.scnRecommendOveride === 'OvrScrnout') {
            this.callScreenOutFn();
        }
    }

    private callScreenInFn() {
        this.onChangeDispoType('Scrnin', 0);
        this.intakeRecomendation = 'Scrnin';
    }

    private callScreenOutFn() {
        this.onChangeDispoType('ScreenOUT', 0);
        this.intakeRecomendation = 'ScreenOUT';
    }

    private ifCHILDCodeSdmFn() {
        if (this.sdm) {
            if (this.sdm.scnRecommendOveride === 'OvrScrnout') {
                this.scnRecommendOveride = 'OvrScrnout';
                this.sdm.cpsResponseType = null;
                this.sdm.isir = false;
                this.sdm.isar = false;
            }
            if (this.sdm.scnRecommendOveride === 'Ovrscrnin') {
                this.scnRecommendOveride = 'Ovrscrnin';
                this.sdm.cpsResponseType = null;
                this.sdm.isir = false;
                this.sdm.isar = false;
            }
            if (this.sdm.scnRecommendOveride === '') {
                this.ifSdmScnRecommendOverideFn();
            }
        }
    }

    private ifSdmScnRecommendOverideFn() {
        if (((ObjectUtils.checkTrueProperty(this.sdm.screenOut) ?? 0) >= 1) ||
            (this.sdm.screenOut && (this.sdm.screenOut.duplicatereportflag === 1 || this.sdm.screenOut.isscrnoutrecovr_historicalinformation === 1 ||
                this.sdm.screenOut.isscrnoutrecovr_information === 1 || this.sdm.screenOut.isscrnoutrecovr_insufficient === 1 ||
                this.sdm.screenOut.isscrnoutrecovr_otherspecify === 1 || this.sdm.screenOut.scrnout_description))) {
            this.scnRecommendOveride = 'OvrScrnout';
            this.sdm.cpsResponseType = null;
            this.sdm.isir = false;
            this.sdm.isar = false;
        } else if (((ObjectUtils.checkTrueProperty(this.sdm.screenIn) ?? 0) >= 1) ||
            (this.sdm.screenIn && (this.sdm.screenIn.isscrninrecovr_courtorder === 1 ||
                this.sdm.screenIn.isscrninrecovr_otherspecify === 1 || this.sdm.screenIn.scrnin_description))) {
            this.scnRecommendOveride = 'Ovrscrnin';
        }
    }

    private ifROACPSCodeFn() {
        this.showBehalfOfRequester = false;
        this.disableCPSIntakeReport = false;
        const model = new DropdownModel();
        const model1 = new DropdownModel();
        const model0 = new DropdownModel();
        let intakeserreqstatustypekey;
        let closeintakecw;
        model.text = 'Recommended to close ROA CPS';
        model.value = 'Approved';
        model1.text = this.returntoworkertxt;
        model1.value = 'Reopen';
        model0.text = 'Request to close ROA CPS';
        model0.value = 'Review';
        let disposition = this._dataStoreService.getData(IntakeStoreConstants.disposition);
        disposition = disposition ? disposition[0] : null;
        if (this.isCWSupervisor) {
            intakeserreqstatustypekey = 'Approved';
            closeintakecw = true;
            this.onChangeTaskStatus('Approved');
            if (!(this.caseDispositions && this.caseDispositions.length &&
                (this.caseDispositions[0].supStatus && this.caseDispositions[0].intakeserreqstatustypekey !== 'Review'))) {
                this.dispositionFormGroup.patchValue({
                    supStatus: 'Approved'
                });
                this.supOnChangeTaskStatus('Approved');
            }
        } else {
            intakeserreqstatustypekey = 'Review';
            closeintakecw = false;
            this.onChangeTaskStatus('Review');
        }
        if (this.isCWSupervisor || (disposition && disposition.supStatus)) {
            this.statusDropdownItems$ = observableOf([model, model1]);
            this.supOnChangeTaskStatus('Approved');
        }
        else {
            this.statusDropdownItems$ = observableOf([model0]);
        }
        this.dispositionFormGroup.patchValue({
            intakeserreqstatustypekey: intakeserreqstatustypekey
        });


        this._dataStoreService.setData(IntakeStoreConstants.closeintakecw, closeintakecw);
        this.intakeRecomendation = this.progressroa;
        this.onChangeDispoType(this.intakeRecomendation, 0);
    }

    private ifAgencyNameCWCheckFn() {
        if (this._authService.getAgencyName() === 'CW') {
            this.isCWinfoNreff = (this.selectedPurpose && (this.selectedPurpose.code === this.informationandreferral)) ? true : false;
            this.setCaseDispositionForCW();
            if (this.caseDispositions && this.caseDispositions.length &&
                (!this.caseDispositions[0].intakeserreqstatustypekey || this.caseDispositions[0].intakeserreqstatustypekey === '')) {
                this.scnRecommendOverideCondFn();
            } else if (this.selectedPurpose && this.selectedPurpose.code !== 'ROACPS'
            && this.selectedPurpose.code !== MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL && !(
                this.selectedPurpose.code == MyNewintakeConstants.PURPOSE.KINSHIP_NAVIGATOR && this.selectedServices[0]?.description==='I&R'
             )) {

                this.dispositionFormGroup.patchValue({
                    intakeserreqstatustypekey: 'Review'
                });
                this.onChangeTaskStatus('Review');
                this.changeDisp();
                this.isIntakeserreqstatustypekey = true;
            }
        } else {
            this.setCaseDispositionForAS();
        }
    }

    private scnRecommendOverideCondFn() {
        if (this.caseDispositions && this.caseDispositions.length &&
            (!this.caseDispositions[0].intakeserreqstatustypekey ||
                (this.selectedPurpose && (this.selectedPurpose.code === this.requestforservices && this._dataStoreService.getData(IntakeStoreConstants.clearhistory))))) {
            this.dispositionFormGroup.patchValue({
                intakeserreqstatustypekey: 'Review'
            });
            this.onChangeTaskStatus('Review');
            this.changeDisp();
        }
        this.isIntakeserreqstatustypekey = false;
    }

    listenForVPEnabled() {
        this._intakeService.isVoluntaryPlacement$.subscribe((data) => {
            if (data) {
                this.isEvpa = true;
            } else {
                this.isEvpa = false;
            }

            if (this.dispositionFormGroup.getRawValue().isYouthIndependentLive === 1) {
                this.dispositionFormGroup.controls['isYouthIndependentLive'].reset();
                this.dispositionFormGroup.controls['isYouthIndependentLive'].clearValidators();
                this.dispositionFormGroup.controls['isYouthIndependentLive'].updateValueAndValidity();
            }
        });
    }

    calculateAge(dob: any) {
        let age = 0;
        if (dob && moment(new Date(dob), 'MM/DD/YYYY', true).isValid()) {
            const rCDob = moment(new Date(dob), 'MM/DD/YYYY').toDate();
            age = moment().diff(rCDob, 'years');
        }
        return age;
    }

    printCasePdf(element: string) {
        (<any>$('#intake-cps-doc1')).modal('hide'); // NOSONAR
        const printContents: any = document.getElementById('CPS-Intake-Report')?.innerHTML;
        const popupWin: any = window.open('', '_blank', 'top=0,left=0,height=100%,width=auto');
        popupWin.document.open();
        popupWin.document.write(`
      <html>
        <head>
          <title>CPS Intake Report</title>
          <style>
          .section-header {
            height: 25px;
            border: 1px solid black;
            text-align: center;
            padding-bottom: 15px;
            background-color: #556080;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .section-body table td{border: 1px solid #ccc; padding: 5px;}
        .section-lable {
            text-align: left;
            padding-right: 15px;
            font-weight: 600;
            margin-bottom: 5px;
        }.section-value {
            min-height: 22px;
            padding-left: 0px;
        }
        .sizeA4 {
                width: 21cm;
                height: 29.7cm;
            }.margin-wrapper {
                margin-left: 1.2cm;
                margin-right: 1.2cm;
            }
            .pdf-page .row {
                margin-left: 0px;
                margin-right: 0px;
            }
            .align-center {
                text-align: center
            }
            </style>
        </head>
    <body onload="window.print();window.close()">${printContents}</body>
      </html>`);
        popupWin.document.close();
    }

    async downloadCasePdf(element: string) {
        const source: any = document.getElementById(element);
        const pages = source.getElementsByClassName('pdf-page');
        let pageImages: any = [];
        for (let i = 0; i < pages.length; i++) {
            const pageName = pages.item(i).getAttribute('data-page-name');
            const isPageEnd = pages.item(i).getAttribute('data-page-end');
            await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas: any) => {
                const img = canvas.toDataURL('image/png');
                pageImages.push(img);
                if (isPageEnd === 'true') {
                    this.pdfFiles.push({ fileName: pageName, images: pageImages });
                    pageImages = [];
                }
            });
        }
        this.convertImageToPdf();
    }
    convertImageToPdf() {
        let doc: any = null;
        this.pdfFiles.forEach(pdfFile => {
          doc = new jsPDF();
            const width = doc.internal['pageSize'].getWidth() - 10;
            const heigth = doc.internal['pageSize'].getHeight() - 10;
            pdfFile.images.forEach((image, index) => {
                doc.addImage(image, 'JPEG', 3, 5, width, heigth);
                if (pdfFile.images.length > index + 1) {
                    doc.addPage();
                }
            });
            doc.save(pdfFile.fileName);
        });
        (<any>$('#intake-complaint-pdf1')).modal('hide'); // NOSONAR
        this.pdfFiles = [];
    }

    private agencyTypeDropDownList() {
        const source = forkJoin([
          this._commonHttpService.getArrayList(
            {
                method: 'get',
                nolimit: true,
                where: { 'active_sw': 'Y', 'picklist_type_id': '14', 'delete_sw': 'N' }
            },
            'tb_picklist_values/getpicklist' + '?filter'
          ),

        ]).pipe(map((result) => {
          return {
            agencyTypeList: result[0].map(
              (res) =>
                new DropdownModel({
                  text: res.description_tx,
                  value: res.value_tx
                })
            )
          };
        }),
        share(),);
        this.agencyTypeDropdown = source.pipe(pluck('agencyTypeList'));
      }

    setCaseDispositionForAS(): any {
        let dispositions = null;
        dispositions = this.store[IntakeStoreConstants.disposition] ? this.store[IntakeStoreConstants.disposition] : [];
        const complaints = this.store[IntakeStoreConstants.createdCases];
        const intakeNumber = this.store[IntakeStoreConstants.intakenumber];
        const purposeSelected = this.store[IntakeStoreConstants.purposeSelected];
        const purposeId = purposeSelected ? purposeSelected.value : '';
        let dispositioncode = '';
        if (this.dispositioncode && this.dispositioncode !== '') {
            dispositioncode = this.dispositioncode;
        }
        if (complaints) {
            this.ifComplaintsLoopFn(complaints, dispositions, intakeNumber, purposeId, dispositioncode);
        }
    }

    private ifComplaintsLoopFn(complaints: any, dispositions: any, intakeNumber: any, purposeId: any, dispositioncode: string) {
        this.caseDispositions = [];
        complaints.forEach((element: ComplaintTypeCase) => {
            const acase: DispostionOutput = dispositions.find((item: { ServiceRequestNumber: string; }) => item.ServiceRequestNumber === element.caseID);
            const createdCase1: any = this.createdCase1DataFn(element, intakeNumber, acase, purposeId, dispositioncode);
            if (acase && acase.supComments) {
                this.supervisourComments = acase.supComments ? acase.supComments : '';
                this.isReopenCase = acase.supStatus === 'Reopen' ? true : false;
            }
            this.caseDispositions.push(createdCase1);
            // this.createdCase.dispositioncode: '',
            // this.createdCase.intakeserreqstatustypekey: '',
            if (this.caseDispositions.length > 0) {
                this.ifCaseDispositionsFn();
            }
        });
    }

    private ifCaseDispositionsFn() {
        if (this.caseDispositions[0].intakeserreqstatustypekey) {
            this.onChangeTaskStatus(this.caseDispositions[0].intakeserreqstatustypekey);
        }
        if (this.caseDispositions[0].supStatus) {
            this.supOnChangeTaskStatus(this.caseDispositions[0].supStatus);
        }
        this.dispositionFormGroup.patchValue({
            intakeserreqstatustypekey: this.caseDispositions[0].intakeserreqstatustypekey ? this.caseDispositions[0].intakeserreqstatustypekey : '',
            dispositioncode: this.caseDispositions[0].dispositioncode ? this.caseDispositions[0].dispositioncode : '',
            supStatus: this.caseDispositions[0].supStatus ? this.caseDispositions[0].supStatus : '',
            supDisposition: this.caseDispositions[0].supDisposition ? this.caseDispositions[0].supDisposition : '',
            comments: this.caseDispositions[0].comments ? this.caseDispositions[0].comments : '',
            supComments: this.caseDispositions[0].supComments ? this.caseDispositions[0].supComments : '',
            isYouthIndependentLive: this.caseDispositions[0].isYouthIndependentLive,
            captureReason: this.caseDispositions[0].captureReason ? this.caseDispositions[0].captureReason : ''
        });
        this.changeDisp();
    }

    private createdCase1DataFn(element: ComplaintTypeCase, intakeNumber: any, acase: DispostionOutput, purposeId: any, dispositioncode: string) {
        return {
            ServiceRequestNumber: element.caseID ? element.caseID : intakeNumber,
            DaTypeKey: this.returnDaTypeKeyFn(acase, purposeId),
            subSeriviceTypeValue: element && element.subSeriviceTypeValue ? element.subSeriviceTypeValue : '',
            DasubtypeKey: element.subServiceTypeID,
            DAStatus: '',
            DADisposition: '',
            Summary: '',
            dispositioncode: this.returnDispositioncodeFn(dispositioncode, acase),
            intakeserreqstatustypekey: this.returnIntakeserreqstatustypekeyFn(acase),
            comments: acase && acase.comments ? acase.comments : '',
            ReasonforDelay: '',
            supStatus: acase && acase.supStatus ? acase.supStatus : '',
            supDisposition: this.returnSupDispositionFn(acase),
            supComments: acase && acase.supComments ? acase.supComments : '',
            intakeMultipleDispositionDropdown: [],
            supMultipleDispositionDropdown: [],
            GroupNumber: this.returnGroupNumberFn(acase),
            GroupReasonType: this.returnGroupReasonTypeFn(acase),
            GroupComment: this.returnGroupCommentFn(acase),
            isYouthIndependentLive: '',
            captureReason: ''
        };
    }

    private returnGroupNumberFn(acase: DispostionOutput) {
        return acase && acase.GroupNumber ? acase.GroupNumber : null;
    }

    private returnGroupCommentFn(acase: DispostionOutput) {
        return acase && acase.GroupComment ? acase.GroupComment : null;
    }

    private returnGroupReasonTypeFn(acase: DispostionOutput) {
        return acase && acase.GroupReasonType ? acase.GroupReasonType : null;
    }

    private returnSupDispositionFn(acase: DispostionOutput) {
        return acase && acase.supDisposition ? acase.supDisposition : '';
    }

    private returnDispositioncodeFn(dispositioncode: string, acase: DispostionOutput) {
        return dispositioncode ? dispositioncode : this.returnDispositioncodeFalseFn(acase);
    }

    private returnDaTypeKeyFn(acase: DispostionOutput, purposeId: any) {
        return acase && acase.serviceTypeID ? acase.serviceTypeID : purposeId;
    }

    private returnIntakeserreqstatustypekeyFn(acase: DispostionOutput) {
        return acase && acase.intakeserreqstatustypekey ? acase.intakeserreqstatustypekey : '';
    }

    private returnDispositioncodeFalseFn(acase: DispostionOutput) {
        return acase && acase.dispositioncode ? acase.dispositioncode : '';
    }

    getDisposition(code: any) {
      let dispCode = '';
      switch (code) {
          case 'OvrScrnout':
                   dispCode = 'ScreenOUT';
                   break;
          case 'Ovrscrnin':
                   dispCode = 'Scrnin';
                   break;
          default:  dispCode = code;
      }
      return dispCode;
    }

    setCaseDispositionForCW(): any {
        let dispositions: any = null;
        let supStatus: any = null;
        let dispositioncode = '';
        dispositions = this.store[IntakeStoreConstants.disposition];
        const intakeStatus = this.store[IntakeStoreConstants.INTAKE_STATUS];
        this.approvedIntake = false;

        if (dispositions && Array.isArray(dispositions) && dispositions.length) {
            this.intakeRecomendation = dispositions[0].DADisposition ? dispositions[0].DADisposition : dispositions[0].dispositioncode;
            this.intakeRecomendation = this.getDisposition(this.intakeRecomendation);
            dispositioncode = dispositions[0].DADisposition ? dispositions[0].dispositioncode : '';
            dispositioncode = this.getDisposition(dispositioncode);
            supStatus = dispositions[0].supStatus ?? null;
            if (supStatus && supStatus === 'Approved' && !intakeStatus && this.isClosed && dispositions[0].supDisposition && dispositions[0].supDisposition !== ''){
                this.approvedIntake = true;
            }
        }

        const intakeNumber = this.store[IntakeStoreConstants.intakenumber];
        const purposeSelected = this.store[IntakeStoreConstants.purposeSelected];
        const purposeId = purposeSelected ? purposeSelected.value : '';

        if (this.selectedPurpose.code === 'CHILD' && this.sdmIsFinalscreenin === 'Ovr_as_noncps'){
            this.dispositioncode = 'Scrnin';
        }

        if (this.dispositioncode && this.dispositioncode !== '' && (dispositioncode === '' || (this.selectedPurpose.code === 'CHILD' && (!supStatus || supStatus !== 'Approved' || (supStatus === 'Approved' && intakeStatus && intakeStatus === 'Review') || !this.isClosed)))) {
            dispositioncode = this.getDisposition(this.dispositioncode);
        }

        
        if (dispositions) {
            this.ifDispositionForCWFn(dispositions, intakeNumber, purposeId, dispositioncode);
        } else if (purposeId) {
            this.handleIfPurposeIdFn(intakeNumber, purposeId, dispositioncode);
        }
    }

    private handleIfPurposeIdFn(intakeNumber: any, purposeId: any, dispositioncode: string) {
        this.caseDispositions = [];
        const complaintTypeCase: DispostionOutput = new DispostionOutput();
        complaintTypeCase.ServiceRequestNumber = intakeNumber;
        complaintTypeCase.DaTypeKey = purposeId;
        if (dispositioncode) {
            complaintTypeCase.dispositioncode = dispositioncode;
        }
        this.caseDispositions.push(complaintTypeCase);
    }

    private ifDispositionForCWFn(dispositions: any, intakeNumber: any, purposeId: any, dispositioncode: string) {
        this.caseDispositions = [];
        dispositions.map((item: any) => {
            const createdCase1 = this.createdCase1DataForCWFn(item, intakeNumber, purposeId, dispositioncode);

            this.isCaptureReason = (item.isYouthIndependentLive === 0) ? true : false;
            this.caseDispositions.push(createdCase1);
            // this.createdCase.dispositioncode: '',
            // this.createdCase.intakeserreqstatustypekey: '',
            if (this.caseDispositions.length > 0) {
                this.caseDispositionsForCWFn();
            }
            this.supStatus = item.supStatus ? item.supStatus : null;
        });
    }

    private caseDispositionsForCWFn() {
        if (this.caseDispositions[0].intakeserreqstatustypekey) {
            this.onChangeTaskStatus(this.caseDispositions[0].intakeserreqstatustypekey);
        }
        if (this.caseDispositions[0].supStatus) {
            this.supOnChangeTaskStatus(this.caseDispositions[0].supStatus);
        }
        this.dispositionFormGroup.patchValue({
            intakeserreqstatustypekey: this.caseDispositions[0].intakeserreqstatustypekey ? this.caseDispositions[0].intakeserreqstatustypekey : '',
            dispositioncode: this.caseDispositions[0].dispositioncode ? this.caseDispositions[0].dispositioncode : '',
            supStatus: this.caseDispositions[0].supStatus ? this.caseDispositions[0].supStatus : '',
            supDisposition: this.caseDispositions[0].supDisposition ? this.caseDispositions[0].supDisposition : '',
            comments: this.caseDispositions[0].comments ? this.caseDispositions[0].comments : '',
            supComments: this.caseDispositions[0].supComments ? this.caseDispositions[0].supComments : '',
            isYouthIndependentLive: this.caseDispositions[0].isYouthIndependentLive,
            captureReason: this.caseDispositions[0].captureReason ? this.caseDispositions[0].captureReason : '',
            reason: this.caseDispositions[0].reason ? this.caseDispositions[0].reason : '',
            agencyContact: this.caseDispositions[0].agencyContact ? this.caseDispositions[0].agencyContact : '',
            agencyName: this.caseDispositions[0].agencyName ? this.caseDispositions[0].agencyName : '',
            agencyType: this.caseDispositions[0].agencyType ? this.caseDispositions[0].agencyType : '',
            intakeAction: this.caseDispositions[0].intakeAction ? this.caseDispositions[0].intakeAction : '',
        });
        this.changeDisp();
    }

    private createdCase1DataForCWFn(item: any, intakeNumber: any, purposeId: any, dispositioncode: string) {
        return {
            ServiceRequestNumber: this.returnServiceRequestNumberForCWFn(item, intakeNumber),
            DaTypeKey: item.serviceTypeID ? item.serviceTypeID : purposeId,
            subSeriviceTypeValue: item.subSeriviceTypeValue,
            DasubtypeKey: item.subServiceTypeID,
            DAStatus: '',
            DADisposition: '',
            Summary: '',
            dispositioncode: this.returnDispositioncodeForCWFn(dispositioncode, item),
            intakeserreqstatustypekey: this.returnIntakeserreqstatustypekeyForCWFn(item),
            comments: item.comments ? item.comments : '',
            ReasonforDelay: '',
            supStatus: item.supStatus ? item.supStatus : '',
            supDisposition: item.supDisposition ? item.supDisposition : '',
            supComments: item.supComments ? item.supComments : '',
            intakeMultipleDispositionDropdown: [],
            supMultipleDispositionDropdown: [],
            GroupNumber: item.GroupNumber ? item.GroupNumber : null,
            GroupReasonType: item.GroupReasonType ? item.GroupReasonType : null,
            GroupComment: item.GroupComment ? item.GroupComment : null,
            isYouthIndependentLive: item.isYouthIndependentLive,
            captureReason: item.captureReason ? item.captureReason : '',
            reason: item.reason ? item.reason : '',
            agencyContact: item.agencyContact ? item.agencyContact : '',
            agencyName: item.agencyName ? item.agencyName : '',
            agencyType: item.agencyType ? item.agencyType : '',
            intakeAction: item.intakeAction ? item.intakeAction : '',
        };
    }

    private returnIntakeserreqstatustypekeyForCWFn(item: any) {
        return item.intakeserreqstatustypekey ? item.intakeserreqstatustypekey : '';
    }

    private returnServiceRequestNumberForCWFn(item: any, intakeNumber: any) {
        return item.caseID ? item.caseID : intakeNumber;
    }

    private returnDispositioncodeForCWFn(dispositioncode: string, item: any) {
        return dispositioncode ? dispositioncode : this.dispositioncodeForCWFalseFn(item);
    }

    private dispositioncodeForCWFalseFn(item: any) {
        return item.dispositioncode ? item.dispositioncode : '';
    }

    sendEmail () {
        const caseID = this.store[IntakeStoreConstants.intakenumber];
        if (this.emailForm.valid) {
        const request = {
            email : this.emailForm.getRawValue().email,
            caseNumber: caseID,
            body: document.getElementById('CPS-Intake-Report')?.innerHTML
        };
        this._commonHttpService.create(request, 'Intakeservicerequestpurposes/sendemailcontact').subscribe(
            (result) => {
                this._alertService.success('Email Sent successfully!');
            },
            (error) => {
               console.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    } else {
        this._alertService.error('Please enter valid email address!');
        }
    }

    ngAfterViewInit() {
        this.general = this.store[IntakeStoreConstants.general];
        this.checkSEN();
    }
    ngAfterViewChecked() {
        this._changeDetect.detectChanges();
    }
    dispositionForm() {
        this.dispositionFormGroup = this.formBuilder.group({
            intakeserreqstatustypekey: ['', Validators.required],
            dispositioncode: ['', Validators.required],
            statusdate: [this.date],
            duedate: [this.date],
            completiondate: [this.date],
            dateseen: null,
            financial: [''],
            seenwithin: [this.date],
            edl: [''],
            jointinvestigation: [''],
            investigationsummary: [''],
            visitinfo: [''],
            supStatus: [''],
            supDisposition: [''],
            supComments: [''],
            comments: [''],
            reason: [''],
            isDelayed: [false],
            intakeAction: [''],
            agencyName: [''],
            agencyContact: [''],
            agencyType: [''],
            isYouthIndependentLive: [null],
            captureReason: ['']
        });
    }

    buildSupervisorOverrideForm(){
        this.supervisorOverrideForm = this.formBuilder.group({
            overrideDecision: [null],
            overrideReason: [null, Validators.required],
            contactmadewithhhmember :[null],
            overrideComment: [null],
            overrideDate: [this.date],
            intakeNumber: [null],
            supervisoroverridetype:[null],
            intakeRecomendation:[null],
            caseNumber:[null],
            intakeserviceid:[null]
        })
    }

    loadDropdown() {
        this.statusDropdownItems$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: {
                        intakeservreqtypeid: this.selectedPurpose.value === this.inhomeserviceuuid ? this.intakesrtypeuuid : this.daTypeSubType,
                        servicerequestsubtypeid: this.selectedPurpose.value === this.inhomeserviceuuid ? this.intakesrtypeuuid : this.daTypeSubType
                    },
                    method: 'get'
                }),
                'Intakeservicerequestdispositioncodes/getstatuslist?filter'
            ).pipe(
    //     this.agencyTypeDropdown = this._commonHttpService.getArrayList(
    //             {
    //               method: 'get',
    //               nolimit: true,
    //               where: { 'active_sw': 'Y', 'picklist_type_id': '14', 'delete_sw': 'N' }
    //             },
    //             'tb_picklist_values/getpicklist' + '?filter'
    //           )
            map(result => {

                if (result && result.length) {
                    this.dispositionList = result;
                    return this.returnResultMapFn(result);
                } else {
                    this.dispositionList = [];
                }
            }));

        if (this._authService.isCW()) {
            this.dispositionStatus = [];
            this.loadDropdownIfisCWFn();
            this.statusDropdownItems$ = observableOf(this.dispositionStatus);

        }

        if (this.role.role.name === 'Intake Worker' && (this.selectedPurpose.code === 'CHILD' || this.selectedPurpose.code === this.requestforservices ) ) {
            const model = new DropdownModel();
                model.text = 'Review';
                model.value = 'Review';
                this.onChangeTaskStatus('Review');
            if(this.isClosed || this._dataStoreService.getData(IntakeStoreConstants.dispositionReadOnly)){
                this.statusDropdownItems$ = observableOf(this.dispositionStatus);
            }else{
                this.statusDropdownItems$ = observableOf([model]);
            }
        }
    }

    private loadDropdownIfisCWFn() {
        this.statusDropdownItems$.subscribe(result => {
            if (result && result.length > 0) {
                this.statusDropdownItemsLoopFn(result);
            }
        });
    }

    private statusDropdownItemsLoopFn(result: DropdownModel[]) {
        for (const element of result) {
            this.dispositionStatus.push(element);
        }
        if (this.caseDispositions[0].intakeserreqstatustypekey !== '' && this.isCWSupervisor) {
            this.setDispositionStatusDropdown(result)
        }
        /* D-11889 - CJAMS - CW -  Decision Tab
        */
        if (this.isCWSupervisor && ((this.caseDispositions[0].DAStatus==='Review' && this.caseDispositions[0].supStatus === '') || (this.caseDispositions[0].DAStatus==='Review' && this.caseDispositions[0].supStatus === 'Approved'))){
        this.setDispositionToAccepted(result);
        }
    }



    private returnResultMapFn(result: any[]): DropdownModel[] {
        return result.map(
            res => new DropdownModel({
                text: res.description,
                value: res.intakeserreqstatustypekey
            })
        ).filter(statusItem => {
            return this.returnDispositionListFn(statusItem);
        });
    }

    private returnDispositionListFn (statusItem: any) {
        if (this.isCWSupervisor) {
            if (statusItem.text === 'Accepted' || statusItem.text === this.returntoworkertxt ) {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    }

    checkClosedStatus(){
        if (this._dataStoreService.getData(IntakeStoreConstants.INTAKE_STATUS) === 'Closed' || this._dataStoreService.getData(IntakeStoreConstants.INTAKE_STATUS) === 'Completed') {
            this.isClosed = true;
           } else {
            this.isClosed = false;
        }
        if (this._dataStoreService.getData(IntakeStoreConstants.INTAKE_IS_CLOSED)) {
            this.isClosed = true;
        }

        this.submissionHistory = this._dataStoreService.getData('submissionHistory');
        if (!this.isClosed && this.submissionHistory  && this.submissionHistory.length && this.submissionHistory.length >=2){
            this.checkLatestStatus();
        }
    }

    checkLatestStatus(){
        let latestStatus = '';
        this.submissionHistory.forEach((item: any) => {
            latestStatus = item.status;
        });

        if (latestStatus === 'Closed' || latestStatus === 'Accepted'){
            this.isClosed = true;
        }
    }

    onChangeTaskStatus(statusId: any) {
        if (!this.caseDispositions || this.caseDispositions.length === 0) {
            return;
        }
            this.caseDispositions.forEach((item: any) => {
                item.DAStatus = statusId;
               const isKinshipNavigation = this.selectedPurpose.code == MyNewintakeConstants.PURPOSE.KINSHIP_NAVIGATOR;
                if (item.issubtypekey) {
                    item.DasubtypeKey = null;
                }
                if (this.selectedPurpose.code === 'ROACPS') {
                    item.intakeMultipleDispositionDropdown = [
                        {
                            text: this.progressroa,
                            value: this.progressroa
                        }
                    ];
                } else if (item.DaTypeKey === this.inhomeserviceuuid) {
                    this.handleIfInhomeserviceuuidFn(item);
                } else {
                    this.handleIfNotInhomeserviceuuidOrROACPSFn(item, statusId);
                }
                if(isKinshipNavigation){
                    this.dispositionFormGroup.patchValue({
                        intakeserreqstatustypekey: 'Review'
                    });
                }
            });
        // }
    }
    // Assosiated to onChangeTaskStatus method
    private handleIfNotInhomeserviceuuidOrROACPSFn(item: DispostionOutput, statusId: any) {
        this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: this.handledispostionOutputWhereCondFn(item, statusId),
                    method: 'get'
                }),
                this.getdispositionlisturl
            )
            .subscribe(result => {
                if (!result || result.length === 0) {
                    return;
                }
                item.intakeMultipleDispositionDropdown = result.map(
                    res => new DropdownModel({
                        text: res.description,
                        value: res.dispositioncode
                    })
                ).filter(iwdisposition => {
                    if (!this.isCW) {
                        return true;
                    }
                    if (this.isCW && this._intakeService.selectedPurposeIs(this.informationandreferral)) {
                        return true;
                    }
                    if (iwdisposition.value === 'Scrnin' || iwdisposition.value === 'ScreenOUT') {
                        return true;
                    } else {
                        return false;
                    }

                });
            });
    }
    // Assosiated to onChangeTaskStatus method
    private handledispostionOutputWhereCondFn(item: DispostionOutput, statusId: any): any {
        return {
            intakeservreqtypeid: item.DaTypeKey,
            servicerequestsubtypeid: item.DasubtypeKey ? item.DasubtypeKey : item.DaTypeKey,
            statuskey: (this.selectedPurpose.code === this.requestforservices && this._dataStoreService.getData(IntakeStoreConstants.clearhistory)) ? 'Closed' : statusId
        };
    }

    // Assosiated to onChangeTaskStatus method
    private handleIfInhomeserviceuuidFn(item: DispostionOutput) {
        this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: {
                        intakeservreqtypeid: this.intakesrtypeuuid,
                        servicerequestsubtypeid: this.intakesrtypeuuid,
                        statuskey: 'Review'
                    },
                    method: 'get'
                }),
                this.getdispositionlisturl
            )
            .subscribe(result => {
                if (!result || result.length === 0) {
                    item.intakeMultipleDispositionDropdown = [];
                    return;
                }
                item.intakeMultipleDispositionDropdown = result.map(
                    resp => new DropdownModel({
                        text: resp.description,
                        value: resp.dispositioncode
                    })
                ).filter(iwdisposition => {
                    if (!this.isCW) {
                        return true;
                    }
                    if ((this.selectedPurpose?.code === this.kinshipnavigator && this.selectedServices[0]?.description === 'I&R') || this.selectedServices[0]?.description?.toLowerCase() === 'cps history clearance' ) {
                        if (iwdisposition.value === 'Closed') {
                            return true;
                        } else {
                            return false;
                        }
                    }
                    if (iwdisposition.value === 'Scrnin' || iwdisposition.value === 'ScreenOUT' || iwdisposition.value === 'Closed') {
                        return true;
                    } else {
                        return false;
                    }
                });
            });
    }

    // private getIntakeMultipleDispositionDropdownFn(res: any): DropdownModel {
    //     return new DropdownModel({
    //         text: res.description,
    //         value: res.dispositioncode
    //     });
    // }

    supOnChangeTaskStatus(id: any) {
        const roaCPS = this.store[IntakeStoreConstants.roacps];
        this.changeDisp();
        this.caseDispositions.forEach(item => {
            item.DAStatus = id;
            if (this.selectedPurpose.code !== this.kinshipnavigator) {
                item.supMultipleDispositionDropdown = [];
              }
            if (this.selectedPurpose.code === 'ROACPS') {
                this.changeTaskStatusROACPSFn(id, roaCPS, item);
            } else if (this.selectedPurpose.code === this.kinshipnavigator) {
                if (id === 'Reopen') {
                  item.supMultipleDispositionDropdown = [
                      {
                          text: this.needmoreinformation,
                          value: 'Dontmetreq'
                      }
                  ];

                  this.dispositionFormGroup.patchValue({
                      intakeserreqstatustypekey: 'Review'
                  });

                  this._dataStoreService.setData(IntakeStoreConstants.closeintakecw, false);

                } else {
                  this.caseDispositions.forEach((dispItem) => {
                      const model1 = new DropdownModel({
                          text: 'Screen In',
                          value: 'Scrnin'
                      });
                      const model2 = new DropdownModel({
                          text: this.screenout,
                          value: 'ScreenOUT'
                      });
                      dispItem.supMultipleDispositionDropdown = [model1, model2];
                  });
                }
            }
            else  if (item.DaTypeKey === this.inhomeserviceuuid) {
                this._commonHttpService
                    .getArrayList(
                        new PaginationRequest({
                            nolimit: true,
                            where: {
                                intakeservreqtypeid: this.intakesrtypeuuid,
                                servicerequestsubtypeid: this.intakesrtypeuuid,
                                statuskey: (id === 'Reopen') ? id : 'Review'
                            },
                            method: 'get'
                        }),
                        this.getdispositionlisturl
                    )
                    .subscribe(result => {
                        this.getdispositionlistApiResponseFn(result, item);
                    });
            } else {
                this._commonHttpService
                .getArrayList(
                    new PaginationRequest({
                        nolimit: true,
                        where: {
                            intakeservreqtypeid: item.DaTypeKey,
                            servicerequestsubtypeid: item.DasubtypeKey,
                            statuskey: id
                        },
                        method: 'get'
                    }),
                    this.getdispositionlisturl
                )
                .subscribe(result => {
                    this.getdispositionlistApiResponseFn(result, item);
                });
            }
        });
    }

    private getdispositionlistApiResponseFn(result: any[], item: DispostionOutput) {
        if (result && result.length) {
            item.supMultipleDispositionDropdown = result.map(
                response => new DropdownModel({
                    text: response.description,
                    value: response.dispositioncode
                })
            ).filter(supervisorDisposition => {
                if (!this.isCW) {
                    return true;
                }
                if (this.isCW && this._intakeService.selectedPurposeIs(this.informationandreferral)) {
                    return true;
                }
                if (supervisorDisposition.value === 'Scrnin'
                    || supervisorDisposition.value === 'ScreenOUT'
                    || supervisorDisposition.value === 'Dontmetreq') {
                    return true;
                } else {
                    return false;
                }
            });
        }
    }

    private changeTaskStatusROACPSFn(id: any, roaCPS: any, item: DispostionOutput) {
        if (id === 'Approved' && roaCPS && roaCPS.statetype === 'outofstate') {
            this.supMultipleDispositionDropdownAssignDataFn(item);
        } else if (id === 'Approved') {
            this.supMultipleDispositionDropdownAssignDataFn(item);
        } else if (id === 'Reopen') {
            item.supMultipleDispositionDropdown = [
                {
                    text: this.needmoreinformation,
                    value: 'Dontmetreq'
                }
            ];

            this.dispositionFormGroup.patchValue({
                intakeserreqstatustypekey: 'Review'
            });

            this._dataStoreService.setData(IntakeStoreConstants.closeintakecw, false);

        }
    }

    private supMultipleDispositionDropdownAssignDataFn(item: DispostionOutput) {
        item.supMultipleDispositionDropdown = [
            {
                text: this.progressroa,
                value: this.progressroa
            }
        ];
    }

    onChangeDispoType(daSubtype: any, index: any) {
        if (this.sdm) {
            this.dispositioncode = daSubtype;
        }
        this.caseDispositions[index].DADisposition = daSubtype;
        this.caseDispositions[index].dispositioncode = daSubtype;
        this.changeDisp();
    }
    onChangeSupDispoType(daSubtype: any, index: any) {
        this.caseDispositions[index].DADisposition = daSubtype;
        this.caseDispositions[index].supDisposition = daSubtype;
        /* D-11889 - CJAMS - CW -  Decision Tab
         */
        if (this.caseDispositions[index].dispositioncode !== daSubtype) {
            this.isSupervisorCommentRequired = true;
        } else {
            this.isSupervisorCommentRequired = false;
        }

        this.changeDisp();
        this._dataStoreService.setData('caseDispositions_Data', this.caseDispositions);
    }

    changeDisp() {
        if (this.caseDispositions && this.caseDispositions.length > 0) {
            const dispositionFormValues = this.dispositionFormGroup.getRawValue();
            this.caseDispositions.forEach(item => {
                this.caseDispositionsChangeDispFn(item, dispositionFormValues);
            });
            if (this.sdm && (ObjectUtils.checkTrueProperty(this.sdm.screenOut) ?? 0) >= 1) {
                this.intakeRecomendation = 'ScreenOUT';
            }

            this._dataStoreService.setData(IntakeStoreConstants.disposition, this.caseDispositions);
        }
    }

    private caseDispositionsChangeDispFn(item: DispostionOutput, dispositionFormValues: any) {
        item.intakeserreqstatustypekey = dispositionFormValues.intakeserreqstatustypekey ? dispositionFormValues.intakeserreqstatustypekey : '';
        item.comments = this.dispositionFormGroup.value.comments ? this.dispositionFormGroup.value.comments : item.comments;
        item.intakeAction = this.dispositionFormGroup.value.intakeAction ? this.dispositionFormGroup.value.intakeAction : '';
        item.supStatus = this.dispositionFormGroup.value.supStatus ? this.dispositionFormGroup.value.supStatus : item.supStatus;
        item.supComments = this.dispositionFormGroup.value.supComments ? this.dispositionFormGroup.value.supComments : item.supComments;
        item.reason = this.dispositionFormGroup.value.reason ? this.dispositionFormGroup.value.reason : item.reason;
        item.caseID = this.dispositionFormGroup.value.ServiceRequestNumber ? this.dispositionFormGroup.value.ServiceRequestNumber : '';
        item.serviceTypeID = this.dispositionFormGroup.value.DaTypeKey ? this.dispositionFormGroup.value.DaTypeKey : '';
        item.isYouthIndependentLive = (dispositionFormValues.isYouthIndependentLive !== null) ? dispositionFormValues.isYouthIndependentLive : item.isYouthIndependentLive;
        item.captureReason = this.dispositionFormGroup.value.captureReason ? this.dispositionFormGroup.value.captureReason : item.captureReason;
        item.agencyContact = dispositionFormValues.agencyContact ? dispositionFormValues.agencyContact : item.agencyContact;
        item.agencyName = dispositionFormValues.agencyName ? dispositionFormValues.agencyName : item.agencyName;
        item.agencyType = dispositionFormValues.agencyType ? dispositionFormValues.agencyType : item.agencyType;
    }

    enableReasonfordelay() {
        if (this.timeReceived === 'Overdue') {
            this.showReason = true;
            this.dispositionFormGroup.patchValue({ isDelayed: true });
            this.dispositionFormGroup.get('reason')?.setValidators([Validators.required]);
            this.dispositionFormGroup.get('reason')?.updateValueAndValidity();
        } else {
            this.disableReasonfordelay();
        }
    }

    disableReasonfordelay() {
        this.showReason = false;
        this.dispositionFormGroup.patchValue({ isDelayed: false });
        this.dispositionFormGroup.get('reason')?.clearValidators();
        this.dispositionFormGroup.get('reason')?.updateValueAndValidity();
    }

    previewCpsDoc(version:string) {
        let snapshotId = null
        let overrideservicecasenumber =null
        const isdraft = this._dataStoreService.getData(IntakeStoreConstants.IS_DRAFT);
        const caseDetails ={...this._dataStoreService.getData(IntakeStoreConstants.SELECTED_INTAKE_CASE_DETAILS)}
        if (version === 'initial'){
            snapshotId = this.supervisorOverrides[0].referralsnapshotid;
            if(caseDetails){
           caseDetails['caseNumber'] = this.supervisorOverrides[0].servicerequestnumber;
            } else{
                 overrideservicecasenumber = this.supervisorOverrides[0].servicerequestnumber;
            }

        }else if (version === 'previous'){
            snapshotId = this.supervisorOverrides[(this.supervisorOverrides.length - 1)].referralsnapshotid;
            const len =this.supervisorOverrides.length
            if(caseDetails){
           caseDetails['caseNumber'] = this.supervisorOverrides[len-1].servicerequestnumber;
            } else{
                 overrideservicecasenumber = this.supervisorOverrides[len-1].servicerequestnumber;
            }
        }


        if(String(this.store[IntakeStoreConstants.intakenumber]).startsWith('CW')){
            if(this.cpsDoc){
                this.cpsDoc.downloadCPSIntakePdf();
                return ;
            }
        }

        this.previewCpsDocIsdraftCheckFn(isdraft, snapshotId, caseDetails, overrideservicecasenumber);
    }
    // Assosiated to previewCpsDoc method
    private previewCpsDocIsdraftCheckFn(isdraft: any, snapshotId: any, caseDetails: any, overrideservicecasenumber: any) {
        if (!isdraft) {
            this._alertService.warn('Please save the intake to generate report');
            return;
        }
        let serviceCase = caseDetails ? this.checkAndReturnServicecaseFn(caseDetails, overrideservicecasenumber) : null;
        if(this.selectedPurpose?.code == MyNewintakeConstants.PURPOSE.KINSHIP_NAVIGATOR){
            const isIAndR = this.selectedServices.some((item: any) => item.description === "informal" || item.description === "formal");
            const selectdItem = this.selectedServices.length > 0 ? this.selectedServices[this.selectedServices.length - 1]?.description : serviceCase;
            serviceCase =  isIAndR ? `I&R ${selectdItem.charAt(0).toUpperCase() + selectdItem.slice(1)}` : selectdItem;
        }
        const modal = this.handleGenerateintakedocumentDataFn(snapshotId, caseDetails, overrideservicecasenumber, serviceCase);
        this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
            .subscribe(res => {
                const blob = new Blob([new Uint8Array(res)]);
                const link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = `CPS_Intake_Report-` + this.store[IntakeStoreConstants.intakenumber] + `.pdf`;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });
    }
    // Assosiated to previewCpsDoc method
    private checkAndReturnServicecaseFn(caseDetails: any, overrideservicecasenumber: any) {
        return ((caseDetails.caseNumber || overrideservicecasenumber) ? caseDetails.serviceCase : null);
    }

    // Assosiated to previewCpsDoc method
    private handleGenerateintakedocumentDataFn(snapshotId: any, caseDetails: any, overrideservicecasenumber: any, serviceCase: any) {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        return {
            method: 'post',
            where: {
                documenttemplatekey: ['intakereport'],
                status: 'intake',
                'intakenumber': this.store[IntakeStoreConstants.intakenumber],
                snapshotid: snapshotId,
                caseNumber: caseDetails ? caseDetails.caseNumber : this.returnCaseNumberFalseFn(overrideservicecasenumber),
                servicecaseid: caseDetails ? caseDetails.servicecaseid : null,
                caseDate: caseDetails ? caseDetails.caseDate : null,
                serviceCase,
                isExpungementSuperUser: isExpungementSuperUser,
                iscaseexpunged: iscaseexpunged
            },
            limit: 10,
            order: 'desc',
            page: 1,
            count: -1
        };
    }

    private returnServiceCaseTrueFn(caseDetails: any, overrideservicecasenumber: any) {
        return (caseDetails.caseNumber || overrideservicecasenumber) ? caseDetails.serviceCase : null;
    }

    private returnCaseNumberFalseFn(overrideservicecasenumber: any) {
        return overrideservicecasenumber ? overrideservicecasenumber : null;
    }

    isYouthIndependentLiving(value: any) {
       this.isCaptureReason =  (value) ? false : true;
       this.dispositionFormGroup.get('captureReason')?.reset();
       if (!value) {
            this.intakeRecommond = 'ScreenOUT';
       } else {
            this.intakeRecommond = 'Scrnin';
            this.isEvpa = false;
       }
       this.onChangeDispoType(this.intakeRecommond, 0);

       this._intakeService.changeHomeServiceValue(value);

    }

    checkSEN() {
        this.isSENflag = false;
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        const intakesdmcheck = this.store[IntakeStoreConstants.intakeSDM];
        const dispositions = this.store[IntakeStoreConstants.disposition];
        const isROHFlagCheck: any = intakesdmcheck && intakesdmcheck.riskofHarm ? ObjectUtils.checkTrueProperty(intakesdmcheck.riskofHarm) : 0;
        const responseType = this._dataStoreService.getData('caseType');
        const responseTypeValue = intakesdmcheck?.cpsResponseType ?? responseType;
        const responseTypeCheck = responseTypeValue === 'CPS-AR' || responseTypeValue === 'CPS-IR';

        if (responseTypeCheck) {       // @TM: CPS IR & CPS AR over-ride SEN cases
            // this.validateIRAR();
            this.isSENflag = false;
        } else if (isROHFlagCheck >= 1) {
            this.isROHFlag = true;
        } else if (addedPersons) {
            this.drugexposednewbornflagCheckFn(addedPersons);
        }
        if(this.sdm?.isnegrh_exposednewborn === true) {
            this.isSENflag = true;
        } else {
            this.isSENflag = false;
        }
        this.checkSENChangeDispoTypeFn(dispositions);
    }

    // Associated to checkSEN Function
    private checkSENChangeDispoTypeFn(dispositions: any) {
        const scnRecommendOveride = this.sdm ? this.sdm.scnRecommendOveride : null;
        if (((this.isSENflag || this.isROHFlag) && !scnRecommendOveride) || scnRecommendOveride === 'Ovrscrnin') {
            this.defaultROHDataSetFn(dispositions);
        } else if (scnRecommendOveride === 'OvrScrnout') {
            this.onChangeDispoType('ScreenOUT', 0);
            this.intakeRecomendation = 'ScreenOUT';
        } else if (dispositions && Array.isArray(dispositions) && dispositions.length && dispositions[0].DADisposition ? dispositions[0].DADisposition : dispositions[0].dispositioncode !== '') {
            this.onChangeDispoType(dispositions[0].DADisposition ? dispositions[0].DADisposition : dispositions[0].dispositioncode, 0);
            this.intakeRecomendation = dispositions[0].DADisposition ? dispositions[0].DADisposition : dispositions[0].dispositioncode;
        }
    }
    private defaultROHDataSetFn(dispositions: any) {
        const intakeRecStatus = this.returnScreeningRecommendFalseCondFn(dispositions);
        if (this.isROHFlag && intakeRecStatus) {
            this.onChangeDispoType(intakeRecStatus, 0);
            this.intakeRecomendation = intakeRecStatus;
        } else {
            this.onChangeDispoType('Scrnin', 0);
            this.intakeRecomendation = 'Scrnin';
        }
    }

    // Associated to checkSEN Function
    private drugexposednewbornflagCheckFn(addedPersons: any) {
        addedPersons.map((item: { drugexposednewbornflag: number; }) => {
            // @TM: Set ROH (Risk of Harm) flag for SEN (Substance Exposed New-born) case
            if (item.drugexposednewbornflag === 1) {
                this.isSENflag = true;
            }
        });
    }

    getSupervisorOverrideReason() {
        this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    where: {
                        referencetypeid: 600,
                        teamtypekey: 'CW'
                    }
                },
                'referencetype/gettypes' + '?filter'
            )
            .subscribe((item) => {
                this.supervisorOverrideReasons = item;
                this.supervisoroverrideallreason =item;
                this.supervisordisposition =this.caseDispositions[0].supDisposition;
                if(this.caseDispositions[0].supDisposition === 'Scrnin'){
                this.supervisorOverrideReasons =  this.supervisorOverrideReasons.filter((val: { ref_key: string; }) => val.ref_key !== 'RISO');


                } else if(this.caseDispositions[0].supDisposition === 'ScreenOUT'){
                    this.supervisorOverrideReasons =  this.supervisorOverrideReasons.filter((val: { ref_key: string; }) => val.ref_key !== 'RISI');
                }


                if(this.supervisorOverridesLoaded && this.supervisorOverrides && this.supervisorOverrides.length){
                    this.supervisorOverrides.forEach(override => {
                        const reasonList = this.supervisorOverrideReasons.find((reason: { ref_key: any; }) => reason.ref_key === override.overridereasontypekey);
                        if(reasonList) {
                            override.reason = reasonList.description;
                        }
                    })
                }
            });

    }

    getSupervisorOverrides(){
        this.supervisorOverrides = [];
        this.overridesmaxed = false;
        this._commonHttpService.getSingle(
            {
                method: 'get',
                nolimit: true,
                where: { 'intakenumber':  this.store[IntakeStoreConstants.intakenumber]}
            },
            'Intakedastagings/getoverride' + '?filter'
          ).subscribe((res) => {
              this.supervisorOverridesLoaded = true
            if(res && res.data){
            this.supervisorOverrides = res.data;
            if(res.data.length && res.data[0] && res.data[0].intakeapproveddate){
                this.intakeapproveddate = res.data[0].intakeapproveddate;}
            if(this.supervisorOverrides && this.supervisorOverrides.length>1){
                this.overridesmaxed = true;}
            this.supervisorOverrides.forEach(override => {
                const reasonList = this.supervisoroverrideallreason.find(reason => reason.ref_key===override.overridereasontypekey)
                if(reasonList){
                    override.reason = reasonList.description;}
            })
        }

          })
    }

    sendOverrideForApproval(event: any){
        this.displayValidationMessages =false;
        this?.supervisorOverrideForm?.get('overrideReason')?.setValidators([Validators.required]);
        this?.supervisorOverrideForm?.get('overrideReason')?.updateValueAndValidity();
        if (this.supervisorOverrideForm.invalid) {
            this.displayValidationMessages =true;
            this.supervisorOverrideForm.markAllAsTouched();
            return;
        }
        const caseDetails =  this._dataStoreService.getData(IntakeStoreConstants.SELECTED_INTAKE_CASE_DETAILS);
        this.supervisorOverrideForm.patchValue({
            intakeNumber :  this.store[IntakeStoreConstants.intakenumber],
            supervisoroverridetype: event,
            intakeRecomendation:this.intakeRecomendation,
            caseNumber: caseDetails?.servicerequestnumber ? caseDetails?.servicerequestnumber : '',
            intakeserviceid :caseDetails?.intakeserviceid ? caseDetails?.intakeserviceid :''
        });


        this._commonHttpService.create(this.supervisorOverrideForm.getRawValue(),'Intakedastagings/sendoverride').subscribe(
            res => {
                if (res.data && res.data[0] && res.data[0].recordintakeadministrativeoverride) {
                    this.sendoverrideResponseFn(res, event);
                }
                else {
                    this._alertService.error('Request failed, please start from intake dashboard screen and try again');
                }
            }
        )
    }

    private sendoverrideResponseFn(res: any, event: any) {
        if (res.data[0].recordintakeadministrativeoverride === 'success') {
            if (event === "narrative") {
                this._dataStoreService.setData(IntakeStoreConstants.navigatetonarrative, true);
                this.navigatetonarrative();
            } else if (event === "worker") {
                this.returntoworker();
            }

            else if (res.data[0].recordintakeadministrativeoverride === 'invalid-sc') {
                this.alertMessage = 'There is a service case connected to this intake and this intake cannot be overriden';
                (<any>$('#alertPopup')).modal('show'); // NOSONAR
            }
            else if (res.data[0].recordintakeadministrativeoverride === 'invalid-cc') {
                this.alertMessage = 'CPS case connected to this intake is Closed/Completed and this intake cannot be overriden';
                (<any>$('#alertPopup')).modal('show'); // NOSONAR
            }
            (<any>$('#supervisorOverride')).modal('hide'); // NOSONAR
        }
    }

    canBeOverridden() {

        if (this.intakeapproveddate) {
            const approvedDate = moment(new Date(this.intakeapproveddate)).toDate();
            const days = moment().diff(approvedDate, 'days');
            if (days > 5 || !this.isClosed){
                return false;
            }else{
                return true;}
        }
        else{
            return true;}
    }


    validateIRAR() {
        const disqualifyingCriteria = (this.sdm.disqualifyingCriteria) ? this.sdm.disqualifyingCriteria : new Disqualifyingcriteria();
        if (this.CPSFlag === 'disable') {       //@TM: not sure why this condition was applied, verify
            this.ifCPSFlagDisabledFn();
        } else {
            this.validateIRElseConditionFn(disqualifyingCriteria);
        }

        if (this.validateIRARIfConditionFn())// ------------------------AR Conditions
        {
            this.sdm.cpsResponseType = 'CPS-AR';
            this.sdm.isir = false;
            this.sdm.isar = true;
        } else if (this.isIRFlag) {
            this.isIRFlagElseIfConditionFn();
        } else {
            this.sdm.cpsResponseType = null;
            this.sdm.isir = false;
            this.sdm.isar = false;
        }
  }

    private ifCPSFlagDisabledFn() {
        if ( // ----------IR Conditions
            !this.sdm.physicalAbuse.ismalpa_suspeciousdeath &&
            !this.sdm.generalNeglect.isneggn_suspiciousdeath &&
            !this.sdm.generalNeglect.isneggn_signsordiagnosis &&
            !this.sdm.ismenab_psycologicalability &&
            !this.sdm.ismenng_psycologicalability &&
            !this.sdm.sexualAbuse.ismalsa_physicalindicators &&
            !this.sdm.sexualAbuse.ismalsa_sex_trafficking &&
            !this.sdm.sexualAbuse.ismalsa_sexualact &&
            !this.sdm.sexualAbuse.ismalsa_sexualexploitation &&
            !this.sdm.sexualAbuse.ismalsa_sexualmolestation) {
            this.sdm.cpsResponseType = null;
            this.isIRFlag = false;
            this.sdm.isir = false;
            this.sdm.isar = false;
        } else if (this.sdm.physicalAbuse.ismalpa_suspeciousdeath ||
            this.sdm.generalNeglect.isneggn_suspiciousdeath ||
            this.sdm.generalNeglect.isneggn_signsordiagnosis ||
            this.sdm.ismenab_psycologicalability ||
            this.sdm.ismenng_psycologicalability ||
            this.sdm.sexualAbuse.ismalsa_physicalindicators ||
            this.sdm.sexualAbuse.ismalsa_sex_trafficking ||
            this.sdm.sexualAbuse.ismalsa_sexualact ||
            this.sdm.sexualAbuse.ismalsa_sexualexploitation ||
            this.sdm.sexualAbuse.ismalsa_sexualmolestation) {
            this.sdm.cpsResponseType = 'CPS-IR';
            this.isIRFlag = true;
            this.sdm.isir = true;
            this.sdm.isar = false;

        }
    }

    private validateIRElseConditionFn(disqualifyingCriteria: Disqualifyingcriteria) {
        if (this.sdm.childfatality === 'no' && //CIDM-10584
            ( // ----------IR Conditions
            !this.sdm.physicalAbuse.ismalpa_suspeciousdeath &&
            !this.sdm.generalNeglect.isneggn_suspiciousdeath &&
            !this.sdm.generalNeglect.isneggn_signsordiagnosis &&
            !this.sdm.ismenab_psycologicalability &&
            !this.sdm.ismenng_psycologicalability &&
            !this.sdm.sexualAbuse.ismalsa_physicalindicators &&
            !this.sdm.sexualAbuse.ismalsa_sex_trafficking &&
            !this.sdm.sexualAbuse.ismalsa_sexualact &&
            !this.sdm.sexualAbuse.ismalsa_sexualexploitation &&
            !this.sdm.sexualAbuse.ismalsa_sexualmolestation &&
            // Mandatory Disqualifying Criteria - this is still required to ensure correct precedence
            !disqualifyingCriteria.isrisk &&
            !disqualifyingCriteria.ismaltreatment3yrs &&
            !disqualifyingCriteria.ismaltreatment12yrs &&
            !disqualifyingCriteria.ismaltreatment24yrs &&
            !disqualifyingCriteria.isactiveinvestigation &&
            !disqualifyingCriteria.isdeathorserious &&
            !disqualifyingCriteria.islabortrafficking &&
            !disqualifyingCriteria.isoutofhome &&
            !disqualifyingCriteria.isreportmeets &&
            !disqualifyingCriteria.issexualabuse &&
            !disqualifyingCriteria.issignordiagonises &&
            // Discretionary Disqualifying Factors - this is still required to ensure correct precedence
            !this.sdm.disqualifyingFactors.isreportedhistory &&
            !this.sdm.disqualifyingFactors.ismultiple &&
            !this.sdm.disqualifyingFactors.isdomesticvoilence &&
            !this.sdm.disqualifyingFactors.iscriminalhistory &&
            !this.sdm.disqualifyingFactors.isthread &&
            !this.sdm.disqualifyingFactors.islawenforcement &&
            !this.sdm.disqualifyingFactors.iscourtiinvestigation)) {
            this.sdm.cpsResponseType = null;
            this.isIRFlag = false;
            this.sdm.isir = false;
            this.sdm.isar = false;
        } else if ( this.sdm.childfatality === 'yes' || //CIDM-10584
            (this.sdm.physicalAbuse.ismalpa_suspeciousdeath ||
            this.sdm.generalNeglect.isneggn_suspiciousdeath ||
            this.sdm.generalNeglect.isneggn_signsordiagnosis ||
            this.sdm.ismenab_psycologicalability ||
            this.sdm.ismenng_psycologicalability ||
            this.sdm.sexualAbuse.ismalsa_physicalindicators ||
            this.sdm.sexualAbuse.ismalsa_sex_trafficking ||
            this.sdm.sexualAbuse.ismalsa_sexualact ||
            this.sdm.sexualAbuse.ismalsa_sexualexploitation ||
            this.sdm.sexualAbuse.ismalsa_sexualmolestation ||
            // Disqualifying Criteria - this is still required to ensure correct precedence
            disqualifyingCriteria.isrisk ||
            disqualifyingCriteria.ismaltreatment3yrs ||
            disqualifyingCriteria.ismaltreatment12yrs ||
            disqualifyingCriteria.ismaltreatment24yrs ||
            disqualifyingCriteria.isactiveinvestigation ||
            disqualifyingCriteria.isdeathorserious ||
            disqualifyingCriteria.islabortrafficking ||
            disqualifyingCriteria.isoutofhome ||
            disqualifyingCriteria.isreportmeets ||
            disqualifyingCriteria.issexualabuse ||
            disqualifyingCriteria.issignordiagonises ||
            // Discretionary Disqualifying Factors - this is still required to ensure correct precedence
            this.sdm.disqualifyingFactors.isreportedhistory ||
            this.sdm.disqualifyingFactors.ismultiple ||
            this.sdm.disqualifyingFactors.isdomesticvoilence ||
            this.sdm.disqualifyingFactors.iscriminalhistory ||
            this.sdm.disqualifyingFactors.isthread ||
            this.sdm.disqualifyingFactors.islawenforcement ||
            this.sdm.disqualifyingFactors.iscourtiinvestigation)) {
            this.sdm.cpsResponseType = 'CPS-IR';
            this.isIRFlag = true;
            this.sdm.isir = true;
            this.sdm.isar = false;
        }
    }

    private isIRFlagElseIfConditionFn() {
        if (this.isOnlyProviderInvolved()) {
            this.sdm.cpsResponseType = 'CPS-IR';
            this.sdm.isir = true;
            this.sdm.isar = false;
        } else {
            this.sdm.cpsResponseType = 'CPS-IR';
            this.sdm.isir = true;
            this.sdm.isar = false;
        }
    }

    private validateIRARIfConditionFn() {
        return (!this.isIRFlag &&
            (
                this.sdm.physicalAbuse.ismalpa_caregiver ||
                this.sdm.physicalAbuse.ismalpa_childtoxic ||
                this.sdm.physicalAbuse.ismalpa_injuryinconsistent ||
                this.sdm.physicalAbuse.ismalpa_insjury ||
                this.sdm.physicalAbuse.ismalpa_nonaccident ||
                this.sdm.generalNeglect.isneggn_inadequatefood ||
                this.sdm.arGeneralNeglect?.isneggn_exposuretounsafe ||
                this.sdm.arGeneralNeglect?.isneggn_inadequateclothing ||
                this.sdm.arGeneralNeglect?.isneggn_inadequatesupervision ||
                this.sdm.arGeneralNeglect?.isnegrh_treatmenthealthrisk ||
                this.sdm.generalNeglect.isneggn_childdischarged ||
                this.sdm.isnegfp_cargiverintervene ||
                this.sdm.isnegab_abandoned ||
                this.sdm.unattendedChild.isneguc_leftaloneinappropriatecare ||
                this.sdm.unattendedChild.isneguc_leftalonewithoutsupport ||
                this.sdm.unattendedChild.isneguc_leftunsupervised ||
                this.sdm.isnegmn_unreasonabledelay
            ));
    }

    isOnlyProviderInvolved() {
        let result = true;

        if (this.checkAndReturnSdmDataFn()){
            result = false;
        }
        return result;
    }
    // Assosiated with isOnlyProviderInvolved method
    private checkAndReturnSdmDataFn() {
        return (((ObjectUtils.checkTrueProperty(this.sdm.sexualAbuse) ?? 0) >= 1) ||
            ((ObjectUtils.checkTrueProperty(this.sdm.physicalAbuse) ?? 0) >= 1) ||
            ((ObjectUtils.checkTrueProperty(this.sdm.generalNeglect) ?? 0) >= 1) ||
            ((ObjectUtils.checkTrueProperty(this.sdm.arGeneralNeglect) ?? 0) >= 1) ||
            (this.sdm.ismenab_psycologicalability === true || this.sdm.ismenng_psycologicalability === true) ||
            ((ObjectUtils.checkTrueProperty(this.sdm.riskofHarm) ?? 0) >= 1));
    }

    resetValidation(){
        this.displayValidationMessages = false;
        this?.supervisorOverrideForm?.get('overrideReason')?.clearValidators();
        this?.supervisorOverrideForm?.get('overrideReason')?.updateValueAndValidity();
    }

    getErrorsMessage(ControlName: any, displayName: any){
        if(this.supervisorOverrideForm.controls[ControlName].status =='INVALID' ){
        return 'Please enter valid ' + displayName
        }
    }
    navigatetonarrative(){
        const intake = this._dataStoreService.getData('intake')
        this._util.intakeTabSwitch$.next('narrative');
        const url = '/pages/newintake/my-newintake/' + intake.number + '/' + intake.action + '/narrative';
        this._router.navigate([url],{relativeTo :this.route});
    }
    contacthhmember(){
        if(this.supervisorOverrideForm?.get('contactmadewithhhmember')?.value  ===1 &&
         this.supervisorOverrideForm?.get('overrideReason')?.value  ==='RISI' ){
             this.showoverrideerrormsg = true;

         } else{
            this.showoverrideerrormsg  = false;
         }


    }
    returntoworker(){
    // add aPi for return to worker
    this._router.navigate(['/pages/cjams-dashboard/cw-intake-referals']);
    setTimeout(() => {
        window.location.reload();
    }, 1000);


    }

    private setDispositionToAccepted(result: DropdownModel[]){
        const acceptedItem = result.find(item => item.text === 'Accepted');
        if (acceptedItem) {
            this.dispositionFormGroup.patchValue({ supStatus: acceptedItem.value });
            this.supOnChangeTaskStatus(acceptedItem.value);
        }
    }

    private setDispositionStatusDropdown(result: DropdownModel[]){
        for (const element of result) {
            if (['Reopen', 'Approved', 'Rejected'].includes(element.value)) {
                if (!this.dispositionStatus.some(item => item.value === element.value)) { this.dispositionStatus.push(element); }
            }
        }
    }

}
