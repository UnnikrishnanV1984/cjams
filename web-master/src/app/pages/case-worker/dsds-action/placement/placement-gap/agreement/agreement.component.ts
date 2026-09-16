import { Component, OnInit, ViewChild, Injector } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import jsPDF from 'jspdf';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import { DynamicObject, PaginationRequest, PaginationInfo, DropdownModel } from '../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { AuthService } from '../../../../../../@core/services/auth.service';
import { CommonHttpService } from '../../../../../../@core/services/common-http.service';
import { DataStoreService } from '../../../../../../@core/services/data-store.service';
import { Agreement, GapAgreement, Gapagreementrate, GapDetails, Placement, RouteToSupervisor } from '../../_entities/placement.model';
import { PlacementGapService } from '../placement-gap.service';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { SessionStorageService} from '../../../../../../@core/services';
import moment from 'moment';
import { AppConfig } from '../../../../../../app.config';
import { config } from '../../../../../../../environments/config';
import { HttpHeaders } from '@angular/common/http';
import { NgxfUploaderService, FileError } from 'ngxf-uploader';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { ServiceCasePlacementsService } from '../../../service-case-placements/service-case-placements.service';
import { FinanceService } from '../../../../../finance/finance.service';
import { Observable, forkJoin } from 'rxjs';
import { AttachmentUpload } from '../../../../../provider-applicant/new-public-applicant/_entities/newApplicantModel';
import { map, share, pluck } from 'rxjs/operators';
import { DocumentUploadListSharedComponent } from '../../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { Html2CanvasService } from '../../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'agreement',
    templateUrl: './agreement.component.html',
    styleUrls: ['./agreement.component.scss'],
    standalone: false
})
export class AgreementComponent implements OnInit {
    agreementGapForm!: FormGroup;
    approvalStatusForm!: FormGroup;
    agreementRateForm!: FormGroup;
    placement!: Placement;
    disClosure!: GapDetails;
    guardianOneID: any;
    guardainTwoId: any;
    guardianoneprovidername: any;
    guardiantwoprovidername: any;
    guardianOneDob: any;
    guardianTwoDob: any;
    submitStatus!: RouteToSupervisor;
    agreementList: Agreement = new Agreement();
    id!: string;
    disableBtn =false;
    daNumber!: string;
    roleId!: AppUser;
    uploadedFile: any = [];
    isSupervisor = false;
    isExistRecord = false;
    isApproved = false;
    agreement: GapAgreement = new GapAgreement();
    maxDate = new Date();
    deleteAttachmentIndex!: number;
    isEnableComments = false;
    gapAlertMessage!: string;
    isShowAgreementForm = false;
    isShowRateForm = false;
    selectedRate!: Gapagreementrate;
    newBtnDisabled!: boolean;
    newApplication: boolean = true;
    agreementDetail: any;
    gapAgreementStartDate: any;
    agreementRate: any;
    store: DynamicObject;
    token: any;
    placementAgreementRateId: any;
    showRateOverride!: boolean;
    showRateApprovalStatus!: boolean;
    rateAction!: string;
    childHasActivePlacement!: boolean;
    iscaseworker!: boolean;
    childdob!: Date;
    paginationInfo: PaginationInfo  = new PaginationInfo();
    pageInfo: PaginationInfo  = new PaginationInfo();
    changehistory = [];
    adjustment!: any[];
    approvalCode: any;
    overpayments!: any[];
    placmentDetails: any;
    providerDetails: any;
    reportedChild: any;
    isSubmitted!: boolean;
    gapAlternateID: any;
    annualReviewList: any;
    agreementenddate: any;
    agreementStartDate: any;
    isEnddateedited = 'no';
    isStartDateEdited = false;
    isedited!: boolean;
    agreementrateenddate: any;
    isRateEndDateEdited = 'no';
    isAgreementApproved = false;
    childInActiveSubsidy = false;
    gapAgreementSignatures: any;
    showTCAFields: boolean = false;
   
    // Upload Attachments
    fileToSave: any[] = [];
    attachmenttype= 'case';
    isAttachType = '';
    showInfo = true;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    attachmentClassificationtypelookup: any[] = [];
    attachmentClassificationtype: any[] = [];
    isCW!: boolean;
    isCate = '';
    issubCate= '';
    personid= '';
    curDate!: Date;
    attachmentResponse!: AttachmentUpload;
    isAdoptionCase: boolean;
    uploadedFiles: any = [];

    //AssistanceAgreementType
    //AssistanceAgreementType
    assistanceAgreementTypeDropdown!: any[];
    isReadonly!: boolean;
    mandatoryfieldcheck!: boolean;
    @ViewChild(DocumentUploadListSharedComponent)
    documentuploaded!: DocumentUploadListSharedComponent;
    objectId: any = '';
    dtformat = 'MM/DD/YYYY';
    gapplacementpopupid = '#gap-placement';
    deleteattachmentpopupid = '#delete-attachment-popup';

    private route: ActivatedRoute;
    private _dataStoreService: DataStoreService;
    private _formBuilder: FormBuilder;
    private _commonHttpService: CommonHttpService;
    private _alertService: AlertService;
    private _authService: AuthService;
    private _route: Router;
    private _session: SessionStorageService;
    private _placementService: PlacementGapService;
    private _uploadService: NgxfUploaderService;
    private _scPlacementService: ServiceCasePlacementsService;
    private _financeService: FinanceService;
    retrydoc: boolean = false;
    retryagreementid: any;

    constructor(private injector : Injector,private html2canvas:Html2CanvasService){
        this.route = injector.get<ActivatedRoute>(ActivatedRoute);
        this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
        this._formBuilder = injector.get<FormBuilder>(FormBuilder);
        this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = injector.get<AlertService>(AlertService);
        this._authService = injector.get<AuthService>(AuthService);
        this._route = injector.get<Router>(Router);
        this._session = injector.get<SessionStorageService>(SessionStorageService);
        this._placementService = injector.get<PlacementGapService>(PlacementGapService);
        this._uploadService = injector.get<NgxfUploaderService>(NgxfUploaderService);
        this._scPlacementService = injector.get<ServiceCasePlacementsService>(ServiceCasePlacementsService);
        this._financeService = injector.get<FinanceService>(FinanceService);
        if (this.route.snapshot.params) {
            this.attachmenttype = this.route.snapshot.params['attachmenttype'] || 'case';
            this.personid = this.route.snapshot.params['personid'] || '';
        }
        this.store = this._dataStoreService.getCurrentStore();
        const caseType = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
        if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
            this.isAdoptionCase = true;
        } else {
            this.isAdoptionCase = false;
        }
    }

    ngOnInit() {
        this.route.queryParams.subscribe(params => {
            if(params['retrydocument'] == 'true') {
              this.retrydoc = true;   
              this.retryagreementid = params['retryid'];
            }
        });
        this._placementService.checkDataAvailability();
        this.roleId = this._authService.getCurrentUser();
        this.iscaseworker = this._authService.selectedRoleIs('field');
        this.isCW = this._authService.isCW();
        this.curDate = new Date();
        if (this.roleId.role.name === 'apcs' || this.retrydoc) {
            if(this.roleId.role.name === 'apcs') {
                this.isSupervisor = true;
            }
            this.placementAgreementRateId = this._session.getItem('Placement-Agreement-Rate-Id');
            this.approvalCode = this._session.getItem(CASE_STORE_CONSTANTS.APPROVAL_EVENT_CODE);
            const ppid = this._session.getItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
            this._session.setItem('Placement-Agreement-Rate-Id', null);
            this._session.setItem(CASE_STORE_CONSTANTS.APPROVAL_EVENT_CODE, null);
            if (ppid) {
             this.getPage(ppid);
            }
        }
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.token = this._authService.getCurrentUser();
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.loadAttachmentDropdown()
        this.agreementInitialform();

        //load agreement from reference
        this.loadAgreementTypeDropdown();

        if (this.store['placement_child']) {
            this.placement = this.store['placement_child'];
            const child = this.checkIfPlacementFn();
            this.childdob = new Date(child.dob);
            const dob = moment(child.dob);
            
            const targetDate = moment(this.childdob).subtract(1, 'day').toDate();

            const getYearOfdob = Number (moment(targetDate).format('YYYY'));
            const monthDateOfdob = moment(targetDate).format('MM/DD');

            const getMinYear = Number(getYearOfdob) + Number(18);
            const getMaxYear = Number(getYearOfdob) + Number(21);
            const agreement18EndDateminusOneDay = monthDateOfdob + '/' + getMinYear;
            const agreementEndDateminusOneDay = monthDateOfdob + '/' + getMaxYear;
            dob.add(21, 'years');
            this.agreementGapForm.patchValue({
                enddate: new Date(agreement18EndDateminusOneDay),
                maxenddate: new Date(agreementEndDateminusOneDay)
            });
        }
        this.checkIfPlacedChildFn();
        const activeModuleRole = this._session.getItem('activeModuleRole');
        if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
            this.isReadonly = false;
        } else {
        this.isReadonly =this._authService.readonlyButton('read_only_access','caseworker-service-plan-add-new');}
        this.loadAttachmentDropDown();
    }
    // Assosiated with ngOnInit function
    private checkIfPlacedChildFn() {
        if (this.store['placed_child']) {
            const removalInfo = this.store['placed_child'].removalList;
            const placements = this.store['placed_child'].placements;
            removalInfo?.filter((item: { exitdate: any; }) => item?.exitdate);
            placements?.filter((item: { enddate: any; }) => item?.enddate);
            if (placements && placements.length) {
                this.childHasActivePlacement = this._scPlacementService.checkForChildHasActivePlacements(placements);
            } else {
                this.childHasActivePlacement = false;
            }
        }
    }
    // Assosiated with ngOnInit function
    private checkIfPlacementFn() {
        if (this.placement) {
            this.agreementRateForm.patchValue({
                providerid: this.placement.providerinfo ? this.placement.providerinfo.providercode : null
            });
            this.getPage(null);
        }
        this.agreementRateForm.controls['providerid'].disable();
        const child = this._dataStoreService.getData('placed_child');
        const req = Object.assign(
            { cjamspid: child.cjamspid }
        );
        this._commonHttpService.create(req, 'gapagreement/checkForActiveSubsidy').subscribe(res => {
            this.childInActiveSubsidy = (res > 0) ? true : false;
        },
            _err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
        return child;
    }

    generatePDF_html() {
        const doc = new jsPDF('p', 'mm', 'a4');
        const formIdDataFn: any = document.getElementById('agreement-GapForm');
        this.html2canvas.capture(formIdDataFn).then(function(canvas: any) {
            const imgData = canvas.toDataURL('image/png');
            const pageHeight = 300;
            const imgWidth = 205;
            const imgHeight = (canvas.height * imgWidth) / canvas.width;
            let heightLeft = imgHeight;
            let position = 0;
    
            doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;
    
            while (heightLeft >= 0) {
                position = heightLeft - imgHeight;
                doc.addPage();
                doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                heightLeft -= pageHeight;
            }
    
            doc.save('GAP-agreement.pdf');
        });
      }
    
      generatePDF() { 
        const req = {
            ...this.store  
        };
  
        const payload = {
            method: 'post',
            count: -1,
            page: 1,
            limit: 20,
            where: req,
            documntkey: [
                    'gapagreement'
                ]
          };
  
        this._commonHttpService.create(payload, 'gapapplication/getgappdftoprint').subscribe(
            response => {
                if (response) {
                    setTimeout(() => {
                        window.open(response.data.documentpath);
                    }, 2000);
                } else {
                    this._alertService.error('Error in processing, please try again later.');
                }
        });
   
    }

    dateAt21year(childdob: any) {
        const dob = moment(childdob);
        return dob?.add(21, 'years')?.format(this.dtformat);
    }

    agreementInitialform() {
        this.agreementGapForm = this._formBuilder.group({
            ischildreceivetca: ['', Validators.required],
            startdate: [null],
            enddate: [null],
            maxenddate: [null],
            signaturedate: [null],
            guardianonedate: [new Date(), Validators.required],
            guardiantwodate: [null],
            ldssdate: [new Date()],
            guardian1signature: [null],
            guardian2signature: [null],
            ldssdirectorsignature: [null],
            tcaamount: [''],
            iscsnotifiedtocustody: [''],
            isfianotified: [''],
            fianotifieddate: [null],
            isrcnotifiedcontact: [''],
            attachment: [''],
            signaturecheck: [null],
            agreementtyperefid: [null], 
        });
        this.agreementRateForm = this._formBuilder.group({
            providerid: [''],
            ratestartdate: [''],
            minratestartdate: [''],
            rateenddate: [''],
            oldenddate: [null],
            maxrateenddate: [''],
            rateapprovaldate: [null],
            updatedon: [null],
            paymentamout: [''],
            negotiateddate: [null],
            isoverride: [null],
            notes: [''],
            status: [''],
            paymenttypekey : [''],
            gapagreementrateid: [null],
            gapagreementid: [null]
        });
        this.approvalStatusForm = this._formBuilder.group({
            routingstatus: [''],
            comments: ['']
        });

        this.gapAgreementSignatures = {
            guardian1signature : null,
            guardian2signature : null,
            ldssdirectorsignature : null
        }
    }

    resetSignatureCapture(value: any) {
        if (value == 1) {
            this.gapAgreementSignatures.guardian1signature = null;
            this.agreementGapForm.get('guardian1signature')?.reset();
        } 
        if (value == 2) {
          this.gapAgreementSignatures.guardian2signature = null;
          this.agreementGapForm.get('guardian2signature')?.reset();
        } 
        if (value == 3) {
            this.gapAgreementSignatures.ldssdirectorsignature = null;
            this.agreementGapForm.get('ldssdirectorsignature')?.reset();
        }
    }
  

    getPageforSupervisor(pid: any) {


        this._commonHttpService
        .getArrayList(
            {
                page: 1,
                limit: 10,
               where: {
                 objectid: this.placementAgreementRateId,
                 objecttype: 'agreement'
               },
               method: 'get'
            },
            'gapagreement/list?filter'
        )
        .subscribe(res => {
            if (res && (res instanceof Array)) {
                this.agreementDetail = res[0];
                this.objectId = this.agreementDetail ? this.agreementDetail.gapagreementid : '';
                this.patchAgreement(this.agreementDetail);
            } else {
                this.getPage(pid);
            }
        });

    }

    getPage(permanencplanid: any) {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        intakeserviceid: this.id,
                        // placementid: this.placement.placement_id,
                        permanencyplanid: (permanencplanid) ? permanencplanid : this.placement.permanencyplanid
                    },
                    method: 'get'
                }),
                'gapdisclosure/getguardianship' + '?filter'
            )
            .subscribe(res => {
                if (res.data && res.data.length) {
                   this.handleGuardianshipResponseFn(res);
                } else {
                    this.gapAlertMessage = 'Please complete Gap Application';
                    ($(this.gapplacementpopupid)).modal('show');
                }
            });
    }
    // Assosiated with getPage function
    private handleGuardianshipResponseFn(res: any) {
        if (res.data[0].gapapplication && res.data[0].gapapplication[0].routingstatus === 'Approved') {
            this.disClosure = res.data[0];
            this.guardianOneID = res.data[0].guardianoneproviderid;
            this.patchGuardians(res.data[0].guardianoneproviderid);
            this.guardianoneprovidername = res.data[0].guardianoneprovidername;
            this.guardiantwoprovidername = res.data[0].guardiantwoprovidername;
            this.guardianOneDob = res.data[0].one_dob_dt ? moment(res.data[0].one_dob_dt).format(this.dtformat) : null;
            this.guardianTwoDob = res.data[0].two_dob_dt ? moment(res.data[0].two_dob_dt).format(this.dtformat) : null;
            this.getAgreement(res.data[0].gapid);
            this.gapAlternateID = res.data[0].alternateid ? res.data[0].alternateid : null;
            this.getReviews(res.data[0].gapid);
        } else {
            this.gapAlertMessage = 'Please complete Gap Application';
            ($(this.gapplacementpopupid)).modal('show');
        }
    }

    rateenddateedit() {
        this.conditionValidation();
        if (this.isEnddateedited === 'no') {
            const enddate = this.agreementRateForm.getRawValue().rateenddate;
            const newenddate = new Date(enddate);
            const currEnddate = new Date(this.agreementrateenddate);
            if (newenddate && currEnddate) {
                newenddate.setHours(0, 0, 0, 0);
                currEnddate.setHours(0, 0, 0, 0);
                this.isRateEndDateEdited = (newenddate.valueOf() === currEnddate.valueOf()) ? 'no' : 'yes';
            }
        } else {
            this._alertService.warn('Agreement end date is edited. Please save to proceed.');
            this.agreementRateForm.patchValue({ rateenddate: new Date(this.agreementrateenddate) });
            this.isRateEndDateEdited = 'no';
        }
    }

    agreementenddatechange() {
        if (this.isRateEndDateEdited === 'no') {
            const enddate = this.agreementGapForm.getRawValue().enddate;
            const newenddate = new Date(enddate);
            const currEnddate = new Date(this.agreementenddate);
            if (newenddate && currEnddate) {
                newenddate.setHours(0, 0, 0, 0);
                currEnddate.setHours(0, 0, 0, 0);
                this.isEnddateedited = (newenddate.valueOf() === currEnddate.valueOf()) ? 'no' : 'yes';
            }
            if (Array.isArray(this.agreementDetail.agreementrate) && this.agreementDetail.agreementrate.length) {
                const approvedRate = this.agreementDetail.agreementrate.filter((item: { status: string; }) => item.status !== 'Rejected');
                const rate = approvedRate[approvedRate.length - 1];
                const rateenddate = new Date(rate.rateenddate);
                rateenddate.setHours(0, 0, 0, 0);
                if (newenddate < rateenddate) {
                    this._alertService.warn('New end date cannot be less than rate end date');
                    this.agreementGapForm.patchValue({ enddate: new Date(this.agreementenddate) });
                    this.isEnddateedited = 'no';
                }
            }
        } else {
            this._alertService.warn('Agreement Rate end date is edited. please save to proceed.');
            this.agreementGapForm.patchValue({ enddate: this.agreementenddate });
            this.isEnddateedited = 'no';
        }
    }

    patchAgreement(modal: any): void {
        if (modal) {
            this.agreementList = modal;
            this.agreementenddate = modal.enddate;
            this.agreementStartDate = modal.startdate;
            this.newBtnDisabled = true;
            this.isExistRecord = (['Approved', 'Rejected'].includes(modal.routingstatus)) ? false : true;
            this.agreementList.ischildreceivetca = String(this.agreementList.ischildreceivetca);
            this.isedited = ((modal.routingstatus === 'Review') && ((modal.newenddate && (modal.newenddate !== modal.enddate))||(modal.newstartdate && (modal.newstartdate !== modal.startdate))) ) ? true : false;

           if(modal.ischildreceivetca && modal.ischildreceivetca !== 'false' ) { 
               this.showTCAFields = true;
            } 

           this.agreementGapForm.patchValue(this.patchAgreementGapFormValuesFn(modal));

            this.gapAgreementSignatures = {
                guardian1signature : modal.guardian1signature,
                guardian2signature : modal.guardian2signature,
                ldssdirectorsignature : modal.ldssdirectorsignature
            }
           
            this.handleIfAgreementrateFn();
            this.approvalStatusForm.patchValue({
                // routingstatus: this.agreementList.routingstatus ? this.agreementList.routingstatus : '',
                comments: this.agreementList.comments ? this.agreementList.comments : ''
            });
            this.handleRoutingstatus_Approved_RejectedFn();
            this.agreementList = Object.assign({});
        }
    }
    // Assosiated with patchAgreement function
    private handleRoutingstatus_Approved_RejectedFn() {
        if (['Approved', 'Rejected'].includes(this.agreementList.routingstatus)) {
            let rateList = this.agreementList['agreementrate'];
            rateList = rateList ? rateList : [];
            const pending = rateList.some(item => item.status === 'Review');
            this.isApproved = (pending) ? false : true;
            if (this.isApproved) {
                this.approvalStatusForm.patchValue({
                    routingstatus: this.agreementList.routingstatus ? this.agreementList.routingstatus : ''
                });
                this.isSubmitted = true;
            }
            this.rejectComments(this.agreementList.routingstatus);
        }
    }
    // Assosiated with patchAgreement function
    private handleIfAgreementrateFn() {
        if (this.agreementList.agreementrate && this.agreementList.agreementrate.length > 0) {
            const latestgaprate = this.agreementList.agreementrate[this.agreementList.agreementrate.length - 1];
            this.agreementrateenddate = latestgaprate['rateenddate'];
            const gapRate = this.agreementList.agreementrate[0];
            this.agreementRateForm.patchValue({
                providerid: gapRate.providercode,
                ratestartdate: gapRate.ratestartdate,
                minratestartdate: gapRate.ratestartdate,
                rateenddate: gapRate.rateenddate,
                rateapprovaldate: gapRate.rateapprovaldate,
                paymentamout: gapRate.paymentamout,
                isoverride: gapRate.isoverride,
                oldenddate: gapRate.rateenddate,
                status: gapRate.status
            });

            if (gapRate.status == 'Review') {
                this.agreementRateForm.disable();
            }
        }
    }
    // Assosiated with patchAgreement function
    private patchAgreementGapFormValuesFn(modal: any) {
        return {
            enddate: (this.isedited) ? modal.newenddate : modal.enddate,
            startdate: (this.isedited) ? modal.newstartdate : modal.startdate,
            maxenddate: new Date(this.dateAt21year(modal.childdob)),
            ischildreceivetca: modal.ischildreceivetca,
            signaturedate: modal.signaturedate,
            guardianonedate: modal.guardianonedate,
            guardiantwodate: modal.guardiantwodate,
            ldssdate: modal.ldssdate,
            guardian1signature: modal.guardian1signature,
            guardian2signature: modal.guardian2signature,
            signaturecheck: modal.signaturecheck,
            ldssdirectorsignature: modal.ldssdirectorsignature,
            tcaamount: modal.tcaamount,
            iscsnotifiedtocustody: modal.iscsnotifiedtocustody,
            isfianotified: modal.isfianotified,
            fianotifieddate: modal.fianotifieddate,
            isrcnotifiedcontact: modal.isrcnotifiedcontact,
            attachment: modal.attachment,
            agreementtyperefid: modal.agreementtyperefid
        };
    }

    isSameDateAs(date1: any, date2: any) {
       date1 = new Date(date1);
       date2 = new Date(date2);
        return (
          date1.getFullYear() === date2.getFullYear() &&
          date1.getMonth() === date2.getMonth() &&
          date1.getDate() === date2.getDate()
        );
    }

    conditionValidation(): boolean {
        if(!this.isAgreementApproved){
            if (this.agreementGapForm.getRawValue().enddate !== null && this.agreementGapForm.getRawValue().enddate < this.agreementGapForm.getRawValue().startdate) {
                this._alertService.error('Agreement end date should be greater than start date');
                return false;
            }
            if (this.agreementGapForm.getRawValue().ldssdate !== null && this.agreementGapForm.getRawValue().ldssdate <= this.agreementGapForm.getRawValue().startdate) {
                this.isSameDateAs(this.agreementGapForm.getRawValue().startdate, this.agreementGapForm.getRawValue().ldssdate);

            }
        }
        if (this.returnEnddateCondFn()) {
            this._alertService.error('Rate start date should not be greater than Agreement end date');
            return false;
        }

        if (this.returnStartDateCondFn())  {
            const isSameDate = this.isSameDateAs(this.agreementRateForm.getRawValue().ratestartdate, this.agreementGapForm.getRawValue().startdate);
            if (!isSameDate) {
            this._alertService.error('Rate start date cannot be prior to Agreement start date');
            return false;
            }
        }
        if (this.agreementRateForm.value.ratestartdate && this.agreementRateForm.value.rateenddate) {
            let date = this.agreementRateForm.getRawValue().ratestartdate;
            date = new Date(date);
            date.setFullYear(date.getFullYear() + 1);
            date.setDate(date.getDate() - 1);
            this.agreementRateForm.patchValue({
                maxrateenddate: date
            });
            if (new Date(this.agreementRateForm.value.rateenddate).setHours(0,0,0,0) > new Date(date).setHours(0,0,0,0)) {
                this._alertService.error('Rate end date cannot be greater than 364 days from rate begin date');
                this.agreementRateForm.patchValue({
                    rateenddate: new Date(date)
                });
                return false;
            }
        }
        return true;
    }
    // Assosiated with conditionValidation function
    private returnStartDateCondFn() {
        return this.agreementRateForm.value.ratestartdate && this.agreementGapForm.getRawValue().startdate
            && this.agreementRateForm.getRawValue().ratestartdate < this.agreementGapForm.getRawValue().startdate;
    }
    // Assosiated with conditionValidation function
    private returnEnddateCondFn() {
        return this.agreementGapForm.getRawValue().enddate !== null &&
            (this.agreementGapForm.getRawValue().enddate < this.agreementRateForm.getRawValue().ratestartdate);
    }

    rejectComments(status: any) {
        if (status === 'Rejected') {
            this.isEnableComments = true;
        } else {
            this.isEnableComments = false;
            this.approvalStatusForm.patchValue({ comments: '' });
            this.agreementGapForm.disable();
            this.agreementGapForm.get('enddate')?.enable();
            this.agreementGapForm.get('signaturecheck')?.enable();
            this.agreementGapForm.get('guardianonedate')?.enable();
            this.agreementGapForm.get('guardiantwodate')?.enable();
            this.agreementGapForm.get('agreementtyperefid')?.enable();
            this.agreementGapForm.get('ldssdate')?.enable();
        }
    }

    addAgreement() {
        this.mandatoryfieldcheck = true;
        if (!this.agreementGapForm.valid) {
            this._alertService.warn('Please fill mandatory fields');
            return false;
        }
        if (this.agreementGapForm.getRawValue().agreementtyperefid === 'NOAGR') {
            this._alertService.warn('Please enter new value for Assistance Agreement Type');
            return false;
        }

        if ((!this.agreementDetail || (this.agreementDetail && !this.agreementDetail.gapagreementid)) && this.childInActiveSubsidy) {
            this._alertService.error('Child has an active GAP Subsidy');
            return false;
        }

        if (this.isShowRateForm && this.agreementDetail && this.agreementDetail.agreementrate) {
            ($('#rate-change-alert')).modal('show');
            return false;
        }
        if (!this.handleSignaturecheckFn()) {
            return false;
        }

        if (this.showTCAFields && !this.agreementGapForm['controls'].tcaamount.value) {
            this._alertService.error('Enter TCA Amount');
            return false;
        }

        const agreeement = this.agreementGapForm.getRawValue();
        try {
            agreeement.tcaamount = parseInt(agreeement.tcaamount, 10);
        } catch (error) {
            agreeement.tcaamount = 0;
        }
        if ((this.agreementGapForm.valid && this.agreementGapForm.enabled) || this.agreementGapForm.disabled) {
            this.checkAgreementGapFormFn(agreeement);
        }
    }
    // Assosiated with addAgreement function
    private checkAgreementGapFormFn(agreeement: any) {
        const validation = this.conditionValidation();
        this.agreement = Object.assign(
            {
                gapid: (this.disClosure && this.disClosure.gapid) ? this.disClosure.gapid : null,
                servicecaseid: this.id,
                gapagreementid: (this.agreementDetail) ? this.agreementDetail.gapagreementid : null,
                userrole: this.roleId?.role?.key
            },
            agreeement
        );
        this.agreement.status = 'Review';
        if (this.isStartDateEdited || (this.agreementDetail && this.agreementDetail.gapagreementid)) {
            this.agreement.isagreementedit = 'yes';
        } else {
            this.agreement.isagreementedit = this.isEnddateedited;
        }
        if (validation) {
            this.handleIfValidationFn();
        }
    }
    // Assosiated with addAgreement function
    private handleIfValidationFn() {
        this.disableBtn = true;
        this._commonHttpService.create(this.agreement, 'gapagreement/add').subscribe(
            _res => {
                this._alertService.success('Agreement Submitted for Supervisor Approval');
                if (!this.agreementDetail?.gapagreementid) {
                    this.disableBtn = false;
                }
                setTimeout(() => {
                    this.getPage(null);
                }, 3000);
            },
            _err => {
                this.disableBtn = false;
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    // Assosiated with addAgreement function
    private handleSignaturecheckFn() {
        if (!this.agreementGapForm['controls'].signaturecheck.value) {
            if (!this.agreementGapForm['controls'].guardian1signature.value) {
                this._alertService.error('Enter Guardian One Signature');
                return false;
            }
            if (!this.agreementGapForm['controls'].ldssdirectorsignature.value) {
                this._alertService.error('Enter LDSS Signature');
                return false;
            }
            if (this.guardainTwoId) {
                if (this.agreementGapForm.value.guardiantwodate && !this.agreementGapForm['controls'].guardian2signature.value) {
                    this._alertService.error('Enter Guardian two Signature');
                    return false;
                }
                if (!this.agreementGapForm['controls'].guardiantwodate.value) {
                    this._alertService.error('Enter Guardian two Date');
                    return false;
                }
            }
            return true;
        }
        return true;
    }

    routingUpdate() {
        this.isSubmitted = true;
        let comment = 'Guardianship Submitted for review';

        if (this.approvalStatusForm.value.routingstatus === 'Rejected') {
          comment = 'Guardianship Application Rejected ';
          if(!this.approvalStatusForm.value.comments) {
            this._alertService.error('Enter Comments');
            return false;
          }
        } else if (this.approvalStatusForm.value.routingstatus === 'Approved') {
          comment = 'Guardianship Application Approved '
        }
        if(!this.placementAgreementRateId && this.roleId?.role?.key.toLowerCase() !== 'cwcw'){
            this.isSubmitted = false;
            this._alertService.warn('Please change the role from supervisor approval to case worker.');
            
        }
        this.submitStatus = Object.assign({
            objectid: this.placementAgreementRateId ? this.placementAgreementRateId : '',
            eventcode: this.approvalCode,
            status: this.approvalStatusForm.value.routingstatus,
            comments: this.approvalStatusForm.value.comments,
            notifymsg: comment,
            routeddescription: comment,
            servicecaseid: this.id
        });
        if (this.roleId.role.name === 'apcs' && this.approvalStatusForm.value.routingstatus === '') {
            this.isSubmitted = false;
            return this._alertService.error('Please select review status!');
        } else {
            this.handleRoutingupdateApiFn();
        }
    }
    // Assosiated with routingUpdate function
    private handleRoutingupdateApiFn() {
        this._commonHttpService.create(this.submitStatus, 'routing/routingupdate').subscribe(
            _res => {
                this._alertService.success('Agreement updated successfully!');
                this.isApproved = true;
                const ppid = this._session.getItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
                if (ppid) {
                    setTimeout(() => {
                        this.getPage(ppid);
                    }, 3000);
                }
                if (this.approvalStatusForm.value.routingstatus === 'Approved') {
                    this.approvalStatusForm.disable();
                }
            },
            _err => {
                this.isSubmitted = false;
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    navigateTo() {
        ($(this.gapplacementpopupid)).modal('hide');
        const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/application';
        this._route.navigate([currentUrl]);
    }

    showCriteria() {
        ($('#gap-complete-criteria')).modal('show');
    }

    selectRate(action: any, gapRate?: any, _event?: any) {
        this.isShowRateForm = true;
        if (action === 'Update') {
            this.rateAction = 'Update';
            this.showRateApprovalStatus = true;
            this.showRateOverride = true;
            this.selectedRate = gapRate;
            this.agreementRateForm.patchValue(gapRate);
            this.agreementRateForm.patchValue({
                oldenddate: new Date(gapRate.rateenddate)
            });
            this.handleAgreementrateInUpdateActionFn();
            if (!['New', 'Rejected'].includes(gapRate.status)) {    //this restriction to be removed once SSA approves the code change
                this.agreementRateForm.disable();
                this.agreementRateForm.get('rateenddate')?.enable();
                this.agreementRateForm.get('notes')?.enable();
            } else {
                this.agreementRateForm.enable();
                this.agreementRateForm.get('ratestartdate')?.disable();
            }
            this.ratestartdatechange();
        } else if (action === 'Add') {
            if (this.agreementDetail && this.agreementDetail.agreementrate.length &&  this.agreementDetail.agreementrate.filter((item: { status: string; }) => item.status === 'Review').length) {
                this._alertService.error('Approval Status Is Pending For Existing Rate');
                this.isShowRateForm = false;
                return;
            }
            this.rateAction = 'Add';
            this.showRateApprovalStatus = false;
            this.showRateOverride = false;
                this.isShowRateForm = true;
                this.selectedRate = Object.assign({}, new Gapagreementrate());
                this.agreementRateForm.reset();
            this.agreementRateForm.enable();
            this.handleAgreementrateInAddActionFn();
            this.ratestartdatechange();
            this.agreementRateForm.valueChanges.subscribe((item) => {
                // No content to add or call
            });
        } else if (action === 'View') {
            this.rateAction = 'View';
            this.showRateApprovalStatus = true;
            this.showRateOverride = true;
            this.selectedRate = gapRate;
            this.agreementRateForm.patchValue(gapRate);
            this.agreementRateForm.disable();
        } else {
            this.isShowRateForm = false;
        }
    }
    // Assosiated with selectRate function
    private handleAgreementrateInAddActionFn() {
        if (this.agreementDetail && this.agreementDetail.agreementrate.length) {
            const validRates = this.agreementDetail.agreementrate.filter((item: { status: string; }) => item.status !== 'Rejected');
            if (validRates && validRates.length) {
                const length = validRates.length;
                const lastrate = validRates[length - 1];
                const startdate = new Date(lastrate.rateenddate);
                startdate.setDate(startdate.getDate() + 1);
                this.agreementRateForm.patchValue({
                    ratestartdate: startdate,
                    minratestartdate: startdate,
                    gapagreementid: this.agreementDetail.gapagreementid
                });
            } else {
                this.agreementRateForm.patchValue({
                    ratestartdate: this.agreementGapForm.getRawValue().startdate,
                    minratestartdate: this.agreementGapForm.getRawValue().startdate,
                    gapagreementid: this.agreementDetail.gapagreementid
                });
            }
        } else {
            this.agreementRateForm.patchValue({
                ratestartdate: this.agreementGapForm.getRawValue().startdate,
                minratestartdate: this.agreementGapForm.getRawValue().startdate,
                gapagreementid: this.agreementDetail.gapagreementid
            });
        }
    }
    // Assosiated with selectRate function
    private handleAgreementrateInUpdateActionFn() {
        if (this.agreementDetail && this.agreementDetail.agreementrate.length) {
            const validRates = this.agreementDetail.agreementrate.filter((item: { status: string; }) => item.status !== 'Rejected');
            if (validRates && validRates.length && validRates.length > 1) {
                const lastrate = validRates[validRates.length - 2];
                const startdate = new Date(lastrate.rateenddate);
                startdate.setDate(startdate.getDate() + 1);
                this.agreementRateForm.patchValue({
                    minratestartdate: startdate
                });
            } else {
                this.agreementRateForm.patchValue({
                    minratestartdate: this.agreementGapForm.getRawValue().startdate
                });
            }
        }
    }

    addedittorate() {
        const rateInput = this.agreementRateForm.getRawValue();
        if (rateInput.gapagreementrateid) {
            this.handleGapagreementrateidFn(rateInput);
        } else {
            rateInput.providerid = this.disClosure.guardianoneproviderid;
            rateInput.status = 'New';
            this.agreementDetail.agreementrate = Array.isArray(this.agreementDetail.agreementrate) ? this.agreementDetail.agreementrate : [];
            let exist = false;
            this.agreementDetail.agreementrate = this.agreementDetail.agreementrate.map((item: { status: string; }) => {
                if (item.status === 'New') {
                    exist = true;
                    item = rateInput;
                }
                return item;
            });
            if (!exist) {
                this.agreementDetail.agreementrate.push(rateInput);
            }
        }
        this.isShowRateForm = false;
    }
    // Assosiated with addedittorate function
    private handleGapagreementrateidFn(rateInput: any) {
        this.agreementDetail.agreementrate = Array.isArray(this.agreementDetail.agreementrate) ? this.agreementDetail.agreementrate : [];
        this.agreementDetail.agreementrate.forEach((element: { gapagreementrateid: any; rateenddate: Date; oldenddate: any; status: string; }) => {
            if (element.gapagreementrateid === rateInput.gapagreementrateid) {
                if (rateInput.status === 'Rejected') {
                    element = rateInput;
                } else {
                    element.rateenddate = new Date(rateInput.rateenddate);
                    element.oldenddate = rateInput.oldenddate;
                }
                element.status = 'Review';
            }
        });
    }

    saveRate() {
        const rateInput = this.agreementRateForm.value;
        rateInput.intakeserviceid = this.id;
        rateInput.providerid = this.disClosure.guardianoneproviderid;
        rateInput.startdate = new Date(rateInput.ratestartdate);
        rateInput.enddate = new Date(rateInput.rateenddate);
        rateInput.rateapprovaldate = new Date(rateInput.rateapprovaldate);
        rateInput.status = 'Review';

        const reqparam = {
            gapagreementid: rateInput.gapagreementid,
            servicecaseid: this.id,
            gapagreementrate: [rateInput]

        };
        this._commonHttpService.create(reqparam, 'gapagreementrate/add').subscribe(
            _res => {
                this._alertService.success('Rate Saved Successfully');
                this.agreementRateForm.reset();
            },
            _err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    showAgreementForm(mode: any, agreement: any) {
        if (!this.newBtnDisabled || mode === 'edit') {
            this.isShowAgreementForm = true;
            if ((agreement && agreement.routingstatus === 'Approved') || (!this.isSupervisor && agreement.routingstatus === 'Review')) {
                this.agreementGapForm.disable();
                this.agreementGapForm.get('enddate')?.enable();
                this.agreementGapForm.get('agreementtyperefid')?.enable();
                this.agreementGapForm.get('signaturecheck')?.enable();
                this.agreementGapForm.get('guardianonedate')?.enable();
                this.agreementGapForm.get('guardiantwodate')?.enable();
                this.agreementGapForm.get('agreementtyperefid')?.enable();
                this.agreementGapForm.get('ldssdate')?.enable();
                this.agreementGapForm.get('agreementtyperefid')?.enable();
                this.isAgreementApproved = true; //added to ignore checks for date validations on approved agreement in conditionValidation()
            } else {
                this.isAgreementApproved = false;
                this.agreementGapForm.disable();
                this.agreementGapForm.get('enddate')?.enable();
                this.agreementGapForm.get('signaturecheck')?.enable();
                this.agreementGapForm.get('guardianonedate')?.enable();
                this.agreementGapForm.get('guardiantwodate')?.enable();
                this.agreementGapForm.get('agreementtyperefid')?.enable();
                this.agreementGapForm.get('ldssdate')?.enable();
                this.agreementGapForm.get('agreementtyperefid')?.enable();
            }
        } else if (mode === 'view') {
            this.isShowAgreementForm = true;
            this.agreementGapForm.disable();
        }
        this.agreementDetail = agreement;
        this.uploadedFiles = ( agreement && agreement.attachments  ) ? agreement.attachments : [];
        this.objectId = this.agreementDetail ? this.agreementDetail.gapagreementid : '';
        this.patchAgreement(agreement);
    }

    showTCA(event: any) {
        if (event === 'true') {
            this.agreementGapForm.get('tcaamount')?.setValidators([Validators.required]);
            this.agreementGapForm.get('tcaamount')?.updateValueAndValidity();
            this.showTCAFields = true;
        } else {
            this.agreementGapForm.get('tcaamount')?.clearValidators();
            this.agreementGapForm.get('tcaamount')?.updateValueAndValidity();
            this.showTCAFields = false
        }
    }

    private getAgreement(gapId: any) {
        const storedgapid = this._placementService.getGapId();
        this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    page: 1,
                    limit: 10,
                    where: { gapid: (storedgapid) ? storedgapid : gapId }
                },
                'gapagreement/list?filter'
            )
            .subscribe(res => {
                if (res && (res instanceof Array)) {
                    this.agreementDetail = res[0];
                    this.objectId = this.agreementDetail ? this.agreementDetail.gapagreementid : '';
                    this.newApplication = false;
                    this.agreementRate = this.agreementDetail.agreementrate;
                    this.getCourtInformation();
                    this.patchAgreement(this.agreementDetail);
                    if (res[0] && res[0].attachments && res[0].attachments.length != 0) {
                        this.uploadedFiles = []
                        this.uploadedFiles = res[0].attachments
                    }
                    if (this.retryagreementid) {
                        this.showAgreementForm('edit',this.agreementDetail);
                        this.retryagreementid = null;
                    }
                } else {
                    this.isShowAgreementForm = true;
                    this.agreementGapForm.enable();
                    this.isShowRateForm = true;
                    this.getCourtInformation();
                    // const startdate = new Date();
                    // const enddate = new Date();
                    // enddate.setFullYear(enddate.getFullYear() + 1);
                    // enddate.setDate(enddate.getDate() - 1);
                    // this.agreementRateForm.patchValue({
                    // ratestartdate: startdate,
                    // minratestartdate: startdate,
                    // });
                    // Fix : When user redirects "Agreement" tab first time, it is showing incorrect date.
                    // rateenddate: enddate
                    // this.ratestartdatechange();
                }
                this.agreementGapForm.get('startdate')?.disable();
            });
    }

    patchGuardians(provider_id: any) {
        this._commonHttpService.getArrayList(
          {
            where: { provider_id: provider_id },
            method: 'get'
          },
          'tb_provider/getproviderguardians?filter'
        ).subscribe(res => {
          if (res[0]) {
            const getproviderguardians = res[0].getadoptiveparents;
            if (getproviderguardians.length) {
               const guardiandetails = getproviderguardians[0];
               this.guardainTwoId = guardiandetails.provider2id;
               this.guardianOneDob = guardiandetails.adoptiveparent1dob ? guardiandetails.adoptiveparent1dob  : null ;
               this.guardianTwoDob = guardiandetails.adoptiveparent2dob ? guardiandetails.adoptiveparent2dob : null;
                    
            }
          }
        });
      }

  
    // onDateChange(event) {
    //     var currentDate = moment(event).format(this.dtformat);
    //     const endDate = moment(currentDate).add(1, 'year');
    //     this.agreementGapForm.patchValue({enddate: endDate.subtract(1, 'days').format('YYYY-MM-DD')});
    // }

    aggStartDateChange() {
        const startdate = this.agreementGapForm.getRawValue().startdate;
        this.agreementGapForm.patchValue({
            guardianonedate: startdate,
            ldssdate: startdate
        });
        this.agreementRateForm.patchValue({
            ratestartdate: startdate,
            minratestartdate: startdate
        });
        setTimeout(() => {
            this.ratestartdatechange(true);
        }, 500);

        const newStartDate = new Date(startdate);
        const currStartDate = this.agreementStartDate ? new Date(this.agreementStartDate) : new Date();
        if (newStartDate && currStartDate) {
            newStartDate.setHours(0, 0, 0, 0);
            currStartDate.setHours(0, 0, 0, 0);
            this.isStartDateEdited = (newStartDate.valueOf() !== currStartDate.valueOf());
        }
    }
    ratestartdatechange(force?: boolean) {
        let startdate = this.agreementRateForm.getRawValue().ratestartdate;
        const enddate = this.agreementRateForm.getRawValue().rateenddate;
        startdate = new Date(startdate);
        const agenddate = this.agreementGapForm.getRawValue().enddate;
        if(new Date(startdate).setHours(0,0,0,0) > new Date(agenddate).setHours(0,0,0,0)) {
            this.isShowRateForm = false;
            this._alertService.error("Agreement Rate start date should not be greater than agreement end date.");
            return;
        }
        startdate.setFullYear(startdate.getFullYear() + 1);
        startdate.setDate(startdate.getDate() - 1);
        this.handleIfAnnualReviewListFn();
        const rateEndDate = startdate && new Date(startdate).setHours(0,0,0,0) < new Date(agenddate).setHours(0,0,0,0) ? startdate : agenddate;
        let _rateenddate: any;
        if(force) {
            _rateenddate = rateEndDate;
        } else {
            _rateenddate = enddate;
            if(!enddate) {
                _rateenddate = rateEndDate;
            }
        }

        this.agreementRateForm.patchValue({
            rateenddate: _rateenddate,
            maxrateenddate: rateEndDate,
        });

        this.rateenddateChange();
    }
    // Assosiated with ratestartdatechange function
    private handleIfAnnualReviewListFn() {
        let upcomingReviewDate, upcomingReview, completedReview, completedReviewDate;
        if (this.annualReviewList && this.annualReviewList.length) {
            upcomingReview = this.annualReviewList.filter((review: { status: string; }) => review.status === 'Review');
            completedReview = this.annualReviewList.filter((review: { status: string; }) => review.status === 'Approved');
            upcomingReviewDate = upcomingReview && upcomingReview.length ? upcomingReview[0].reviewdate : null;
            completedReviewDate = completedReview && completedReview.length ? completedReview[completedReview.length - 1].reviewdate : null;
        }
        if (!upcomingReviewDate && !completedReviewDate) {
            let agstartdate = this.agreementDetail && this.agreementDetail.startdate ? this.agreementDetail.startdate : this.agreementGapForm.getRawValue().startdate;
            agstartdate = new Date(agstartdate);
            agstartdate.setFullYear(agstartdate.getFullYear() + 1);
            agstartdate.setDate(agstartdate.getDate() - 1);
        }
    }

    rateenddateChange() {
        const startdate = this.agreementRateForm.getRawValue().ratestartdate;
        const enddate = this.agreementRateForm.getRawValue().rateenddate;
        let upcomingReviewDate, upcomingReview, completedReview, completedReviewDate;
        if (this.annualReviewList && this.annualReviewList.length) {
          upcomingReview = this.annualReviewList.filter((review: { status: string; }) => review.status === 'Review');
          completedReview = this.annualReviewList.filter((review: { status: string; }) => review.status === 'Approved');
          upcomingReviewDate = upcomingReview && upcomingReview.length ? upcomingReview[0].reviewdate : null;
          completedReviewDate = completedReview && completedReview.length ? completedReview[completedReview.length - 1].reviewdate : null;
        }
        upcomingReviewDate = this.handleCompletedReviewDateFn(upcomingReviewDate, completedReviewDate);
        if (new Date(startdate) < new Date(upcomingReviewDate)) {
            this.agreementRateForm.patchValue({
                rateenddate: enddate && new Date(enddate) < new Date(upcomingReviewDate) ? new Date(enddate) : upcomingReviewDate,
            });
        } else {
          this.agreementRateForm.patchValue({
            rateenddate: null,
          });
         setTimeout(() => {
           this.isShowRateForm = false;
        } , 500 );
        }
    }
    // Assosiated with rateenddateChange function
    private handleCompletedReviewDateFn(upcomingReviewDate: any, completedReviewDate: any) {
        if (!upcomingReviewDate && !completedReviewDate) {
            let agstartdate = this.agreementDetail && this.agreementDetail.startdate ? this.agreementDetail.startdate : this.agreementGapForm.getRawValue().startdate;
            agstartdate = new Date(agstartdate);
            agstartdate.setFullYear(agstartdate.getFullYear() + 1);
            agstartdate.setDate(agstartdate.getDate() - 1);
            upcomingReviewDate = agstartdate;
        } else if (!upcomingReviewDate && completedReviewDate) {
            let cmstartdate;
            cmstartdate = completedReviewDate;
            cmstartdate = new Date(cmstartdate);
            cmstartdate.setFullYear(cmstartdate.getFullYear() + 1);
            cmstartdate.setDate(cmstartdate.getDate() - 1);
            upcomingReviewDate = cmstartdate;
        }
        return upcomingReviewDate;
    }

    uploadFile(file: any): void {
        if (!(file instanceof Array)) {
            return;
        }
        if(this.newApplication){
            this._alertService.error("Please click on 'Submit for Approval' before uploading a file");
            return; 
        }
        file.map((item, index) => {
            const size = this.humanizeBytes(item.size);
            const fileExt = item.name.toLowerCase().split('.').pop();
            if (this.returnFileExtFn(fileExt)) {
                if (item.size <= config.uploadMaxSizeLimit) {
                    this.uploadedFile.push(item);
                index = this.uploadedFile.length - 1;
                this.uploadAttachment(index);
                const audio_ext = ['mp3', 'ogg' , 'wav', 'acc', 'flac', 'aiff'];
                const video_ext = ['mp4', 'avi' , 'mov', '3gp', 'wmv', 'mpeg-4'];
                if ( audio_ext.indexOf(fileExt) >= 0) {
                    this.uploadedFile[index].attachmenttypekey = 'Audio'
                } else if ( video_ext.indexOf(fileExt) >= 0) {
                    this.uploadedFile[index].attachmenttypekey = 'Video';
                } else {
                    this.uploadedFile[index].attachmenttypekey = 'Document';
                }
                this.isAttachType = this.uploadedFile[index].attachmenttypekey;
                }
                else{
                    this._alertService.error("Uploaded file size "+ size+ " exceeds the maximum file size limit of "+Math.floor(config.uploadMaxSizeLimit/1048576)+"MB.");
                }
            } else {
                // tslint:disable-next-line:quotemark
                this._alertService.error(fileExt + " format can't be uploaded. Accepted file formats are mp3, ogg, wav, acc, flac, aiff, mp4, mov, avi, 3gp, wmv, mpeg-4, pdf, txt, docx, doc, xls, xlsx, jpeg, jpg, png, ppt, pptx, gif, cr2, rtf.");
            }
        });
    }
    // Assosiated with uploadFile function
    private returnFileExtFn(fileExt: any) {
        return fileExt === 'mp3' ||
            fileExt === 'ogg' ||
            fileExt === 'wav' ||
            fileExt === 'acc' ||
            fileExt === 'flac' ||
            fileExt === 'aiff' ||
            fileExt === 'mp4' ||
            fileExt === 'mov' ||
            fileExt === 'avi' ||
            fileExt === '3gp' ||
            fileExt === 'wmv' ||
            fileExt === 'mpeg-4' ||
            fileExt === 'pdf' ||
            fileExt === 'txt' ||
            fileExt === 'docx' ||
            fileExt === 'doc' ||
            fileExt === 'xls' ||
            fileExt === 'xlsx' ||
            fileExt === 'jpeg' ||
            fileExt === 'jpg' ||
            fileExt === 'png' ||
            fileExt === 'ppt' ||
            fileExt === 'pptx' ||
            fileExt === 'gif' ||
            fileExt === 'cr2' ||
            fileExt === 'rtf';
    }

    humanizeBytes(bytes: number): string {
        if (bytes === 0) {
            return '0 Byte';
        }
        const k = 1024;
        const sizes: string[] = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
        const i: number = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    uploadclosed(event: any){
        if(event){
            this.documentuploaded.closeupload();
        }
    }

    uploadAttachment(index: any) {
    let uploadUrl = '';
    const gapagreementid = this.agreementDetail ? this.agreementDetail.gapagreementid : '';
    uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.daNumber+ '&objecttypekey=' + 'gapagreement' + '&objectid=' +gapagreementid + '&servicecaseid=' + this.id;
    this._uploadService
        .upload({
            url: uploadUrl,
            headers: new HttpHeaders().set('ctype', 'file'),
            filesKey: ['file'],
            files: this.uploadedFile[index],
            process: true,
        })
        .subscribe(
            (response) => {
                if (response.status) {
                    this.uploadedFile[index].percentage = response.percent;
                }
                if (response.status === 1 && response.data) {
                    const doucumentInfo = response.data;
                    doucumentInfo.documentdate = doucumentInfo.date;
                    doucumentInfo.title = doucumentInfo.originalfilename;
                    doucumentInfo.name = doucumentInfo.originalfilename;
                    doucumentInfo.objecttypekey = 'gapagreement';
                    doucumentInfo.rootobjecttypekey = 'gapagreement';
                    doucumentInfo.servicerequestid = null;
                    this.uploadedFile[index] = { ...this.uploadedFile[index], ...doucumentInfo };
                    this.fileToSave[index] = this.uploadedFile[index];
                    this._alertService.success('File Upload successful.');
                }
            }, (err) => {
                this._alertService.error('Upload failed due to Server error, please try again later.');
                this.uploadedFile.splice(index, 1);
            }
        );
    }

    deleteAttachment() {


        const workEnv = config.workEnvironment;
        const documentPropertiesId = this.uploadedFiles[this.deleteAttachmentIndex].documentpropertiesid;
        const documentId = this.uploadedFiles[this.deleteAttachmentIndex].filename;
        if (!documentPropertiesId || documentPropertiesId == undefined) {
            this.uploadedFiles.splice(this.deleteAttachmentIndex, 1);
            ($(this.deleteattachmentpopupid)).modal('hide');
            return;
        }
        if (workEnv === 'state') {
            this._deleteattachmentpopupid(documentPropertiesId + '&' + documentId);
        } else {
            this._deleteattachmentpopupid(documentPropertiesId);
        }
    }

    _deleteattachmentpopupid(_id: any) {
        this._commonHttpService.endpointUrl =
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteAttachmentUrl;
        this._commonHttpService.remove(_id).subscribe(
            _result => {
                this._alertService.success('Attachment Deleted successfully!');
                this.uploadedFiles.splice(this.deleteAttachmentIndex, 1);
                ($(this.deleteattachmentpopupid)).modal('hide');
            },
            _err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    downloadFile(s3bucketpathname: any) {
        s3bucketpathname = s3bucketpathname.replace(/,/g, '');
        const downldSrcURL =  '/api' + s3bucketpathname;

        window.open(downldSrcURL, '_blank');
    }

    confirmDeleteAttachment(index: number) {
        ($(this.deleteattachmentpopupid)).modal('show');
        this.deleteAttachmentIndex = index;
    }

    fiscalAudit() {
        this._financeService.getChangeHistory(1, this.gapAlternateID, 'gaprate');
    }

    getReviews(gapid: any) {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        gapid: gapid
                    },
                    method: 'get'
                }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Gap.AnnualReview + '?filter'
            ).subscribe((resp) => {
                this.annualReviewList = resp;
            });
    }

    getCourtInformation() {
      const persondetails =  this._dataStoreService.getData('placed_child');
      if (persondetails) {
        this._commonHttpService
            .getSingle(
                {
                    where: {
                        objectid: this.id,
                        objecttype:'servicecase'
                    },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.GetCourtOrderUrl + '?filter'
            ).subscribe(response => {
                if (response?.length>0) {
                    
                   const filterPerson = response.filter((element: { personid: any; }) => element.personid == persondetails.personid);
                   filterPerson.sort(function(a: any, b: any) {
                    return new Date(moment(b.courtorderdate).format("YYYY-MM-DD")).getTime() - new Date(moment(a.courtorderdate).format("YYYY-MM-DD")).getTime();
                   });
                   const latestHearing = filterPerson.find((element: any) => (element.hearingoutcome && element.hearingoutcome.length && element.courtorderdate 
                    && element.hearingoutcome.filter((e: { hearingoutcometypekey: string; }) => e.hearingoutcometypekey === 'CUSGUA').length > 0  && !this.gapAgreementStartDate));
                   if (latestHearing) {
                        this.agreementGapForm.patchValue({ startdate: new Date(latestHearing.courtorderdate) });
                        this.gapAgreementStartDate = latestHearing.courtorderdate;
                    } else {
                        this.agreementGapForm.patchValue({ startdate: null });
                        this.gapAgreementStartDate = '';
                    }
                }
            });
       } else {
           return;
       }
    }

    // upload attachment 
  clearAllUpload() {
    ($('#upload-attachment-gapagreement')).modal('hide');
    this.uploadedFile = [];
    this.fileToSave = [];
  }

  switchInfo() {
      this.showInfo = !this.showInfo;
  }

  titleUpdate(event: any, index: any) {
      this.uploadedFile[index].title = event.target.value;
      if (event.target.value) {
          this.uploadedFile[index].invalidTitle = false;
      } else {
          this.uploadedFile[index].invalidTitle = true;
      }
  }

  typeUpdate(event: any, index: any) {
      if (event.target.value !== '')  {
          this.isAttachType  = event.target.value;
      }
      this.uploadedFile[index].attachmenttypekey = event.target.value;
      if (event.target.value) {
          this.uploadedFile[index].invalidAttachmentType = false;
      } else {
          this.uploadedFile[index].invalidAttachmentType = true;
      }
  }

  private loadAttachmentDropdown() {
      this._commonHttpService
      .getSingle(
          {},
          CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
      )
      .subscribe(data => {
          const dp_att_arr: any[] = [];
          if (data && data.length > 0) {
              this.attachmentClassificationtypelookup = data;
              this?.attachmentClassificationtypelookup?.forEach(e => {
                this.returnAttachmentClassificationtypelookupLoopFn(e, dp_att_arr);
              });
          }
      });
      const source = forkJoin([
          this._commonHttpService.getArrayList(
              {
                  nolimit: true
              },
              CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl + '?filter={"nolimit": true}'
          )]
          ).pipe(map((result) => {
              return {
                  attachmentType: result[0].map(
                      (res) =>
                          new DropdownModel({
                              text: res.typedescription,
                              value: res.attachmenttypekey
                          })
                  ),
              };
          }),share(), );
      this.attachmentTypeDropdown$ = source.pipe(pluck('attachmentType'));
  }
  // Assosiated with loadAttachmentDropdown function
    private returnAttachmentClassificationtypelookupLoopFn(e: any, dp_att_arr: any[]) {
        if (e?.typedescription && dp_att_arr.indexOf(e?.typedescription) < 0) {
            if (this.isCW) {
                if (e?.typedescription.startsWith('CW-')) {
                    this.attachmentClassificationtype.push({ typedescription: e?.typedescription });
                    dp_att_arr.push(e?.typedescription);
                }
            } else {
                this.attachmentClassificationtype.push({ typedescription: e?.typedescription });
                dp_att_arr.push(e?.typedescription);
            }
        }
    }

  private loadAgreementTypeDropdown() {
    this._commonHttpService
    .getArrayList(
      {
        method: 'get',
        where: {
          referencetypeid: 5465,
          teamtypekey: 'CW'
        }
      },
      'referencetype/gettypes' + '?filter'
    )
    .subscribe((item) => {
      this.assistanceAgreementTypeDropdown = item;
      var index: any;
      var isExist;
      if(this.agreementGapForm.getRawValue().agreementtyperefid == 'NOAGR'){

   isExist = this.assistanceAgreementTypeDropdown.filter(i => (i.ref_key == 'TIAAA' || i.ref_key == 'STAAA' || i.ref_key == 'ATIAN' || i.ref_key == 'ATIAM'));
      }
      else{
   isExist = this.assistanceAgreementTypeDropdown.filter(i => (i.ref_key == 'TIAAA' || i.ref_key == 'STAAA' || i.ref_key == 'ATIAN' || i.ref_key == 'ATIAM' || i.ref_key == 'NOAGR' ));
      }

      isExist?.forEach(e => {
        index = this?.assistanceAgreementTypeDropdown?.findIndex(i =>(i?.ref_key == e?.ref_key));
        if (index > -1) {
            this?.assistanceAgreementTypeDropdown?.splice(index, 1);
        }
      });
    });
  }

  categoryUpdate(event: any, index: any) {
      if (event.target.value !== '')  {
          this.isCate  = event.target.value;
      }
      this.issubCate  = '';
      this.uploadedFile[index].attachmentclassificationsubtypekey = '';
      this.uploadedFile[index].attachmentClassificationsubtype = [];
      this.uploadedFile[index].attachmentclassificationtypekey = event.target.value;
      if (event.target.value) {
          this.uploadedFile[index].invalidAttachmentClassify = false;
          this?.attachmentClassificationtypelookup?.forEach(e => {
            if (e?.typedescription === this?.uploadedFile[index]?.attachmentclassificationtypekey) {
                this?.uploadedFile[index]?.attachmentClassificationsubtype?.push({subcategory: e?.subcategory});
            }
          });
      } else {
          this.uploadedFile[index].invalidAttachmentClassify = true;
      }
  }

  subcategoryUpdate(event: any, index: any) {
      if (event.target.value !== '')  {
          this.issubCate  = event.target.value;
      }
      this.uploadedFile[index].attachmentclassificationsubtypekey = event.target.value;
      if (event.target.value) {
          this.uploadedFile[index].invalidAttachmentsubClassify = false;
      } else {
          this.uploadedFile[index].invalidAttachmentsubClassify = true;
      }
  }

  descUpdate(event: any, index: any) {
      this.uploadedFile[index].description = event.target.value;
  }

  otherUpdate(event: any, index: any) {
    this.uploadedFile[index].other = event.target.value;
  }

  docDateUpdate(event: any, index: any) {
      this.uploadedFile[index].docDate = event.target.value;
  }

  docDateAddUpdate(event: any, index: any) {
      this.uploadedFile[index].actualdocumentdate = event;
  }

  deleteUpload(index: any) {
      this.uploadedFile.splice(index, 1);
      this.fileToSave.splice(index, 1);
  }

  saveAttachmentDetails() {
    if (this.uploadedFile.length !== this.fileToSave.length) {
        this._alertService.error('Please wait till files get uploaded');
    } else {
        const checkMandatory = this.uploadedFile.filter((item: any) => (!item.other && item.enableOtherTxt) || !item.actualdocumentdate ||  !item.attachmentclassificationsubtypekey ||  !item.attachmentclassificationtypekey)
        if(checkMandatory.length > 0) {
            this._alertService.error('Please fill all mandatory fields');
        } else {
            const attachment = Object.assign({
                servicecaseid: this.id,
                gapagreementid: (this.agreementDetail) ? this.agreementDetail.gapagreementid : null,
                attachment: this.uploadedFile
            });
            this._commonHttpService.create(attachment, 'gapagreement/addAttachment').subscribe(
              _res => {
                this.getPageforSupervisor(null);

                this.uploadedFile.map((element: any) => {
                  this.uploadedFiles.push(element);
                })
                this.uploadedFile = [];
                this.fileToSave = [];
                this._alertService.success('Attachment Uploaded Successfully');
              },
              _err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
              }
            );
            ($('#upload-attachment-gapagreement')).modal('hide');
        }
    }
  }

  attachmentDropDownList_parent: any[] = [];
  attachmentDropDownList_child: any[] = [];
  loadAttachmentDropDown() {
      this._commonHttpService.getArrayList(
              {
                  method: 'get',
                  where: {
                      referencetypeid: 1000,
                      teamtypekey: 'CW',
                      order: 'displayorder ASC'
                  }
              },
              'referencetype/gettypes' + '?filter'
          )
          .subscribe((item) => {
            item?.forEach(e => {
                if(e?.parentkey) {
                    this.attachmentDropDownList_child.push(e);
                } else {
                    this.attachmentDropDownList_parent.push(e);
                }
            });
          });
  }

  childArray: any[] = [];
  parentVal = '';
  seletedVal = ''
  enablOtherTxt = false;
  openChildMenu(parentVal: any, ref_key: any) {
      this.parentVal = parentVal;
      this.childArray = [];
      const isExist = this.attachmentDropDownList_child.filter(item => (item.parentkey === ref_key));
      if (isExist) {
          this.childArray = [...isExist];
      }
  }
  
  selectChildMenu(childVal: any, index: any) {
      this.enablOtherTxt = false;
      this.uploadedFile[index].enableOtherTxt = false;
      const parentEvent = {
          'target': {
              'value': this.parentVal
          }
      }
      this.categoryUpdate(parentEvent, index);
      const childEvent = {
          'target': {
              'value': childVal
          }
      }
      this.subcategoryUpdate(childEvent, index);
      this.uploadedFile[index].title = this.uploadedFile[index].attachmentclassificationsubtypekey;
      if(childVal.includes('Other','other')){
          this.enablOtherTxt = true;
          this.uploadedFile[index].enableOtherTxt = true;
      }
  }

  selectedItem(index: any) {
      if (!this.uploadedFile[index].attachmentclassificationtypekey) {
          this.seletedVal = 'Title';
      } else {
          this.seletedVal = this.uploadedFile[index].attachmentclassificationsubtypekey;
      }
      return this.seletedVal
  }

  onNativeDrop(event: DragEvent) {
        event.preventDefault();
        if (event.dataTransfer?.files) {
            const droppedFiles: File[] = Array.from(event.dataTransfer.files);
            this.uploadFile(droppedFiles); 
        }
    }
}