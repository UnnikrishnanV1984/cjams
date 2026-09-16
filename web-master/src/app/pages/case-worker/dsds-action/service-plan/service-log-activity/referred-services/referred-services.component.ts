
import {pluck, map, shareReplay, share} from 'rxjs/operators';
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Injector, Input, OnInit, signal, ViewChild } from '@angular/core';
import {  FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable ,  forkJoin } from 'rxjs';
import _ from 'lodash';
import { AlertService, AuthService, CommonDropdownsService, CommonHttpService,  DataStoreService, SessionStorageService } from '../../../../../../@core/services';
import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import jsPDF from 'jspdf';
import {  SearchPlan, SearchPlanRes,  PurchaseAuthorization, ServiceLogApproval } from '../../_entities/service-plan.model';
import { DatePipe } from '@angular/common';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { AppConstants } from '../../../../../../@core/common/constants';
import { InvolvedPerson } from '../../../involved-person/_entities/involvedperson.data.model';
import moment from 'moment';
import { MatDatepickerInputEvent } from '@angular/material/datepicker';
import { FinanceUrlConfig } from '../../../../../finance/finance.url.config';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { ColumnSortedEvent } from '../../../../../../shared/modules/sortable-table/sort.service';
import { NgxfUploaderService } from 'ngxf-uploader';
import { AppConfig } from '../../../../../../app.config';
import { HttpHeaders } from '@angular/common/http';
import { DocumentUploadListSharedComponent } from '../../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { Html2CanvasService } from '../../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';


@Component({
    selector: 'referred-services',
    templateUrl: './referred-services.component.html',
    styleUrls: ['./referred-services.component.scss'],
    providers: [DatePipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    standalone: false
})
export class ReferredServicesComponent implements OnInit {
    @Input() zoomControl: any;
    pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];

    referredServiceList$!: Observable<any[]>;
    referredServiceForm!: FormGroup;
    addNewPurchaseAuthorization!: FormGroup;
    EditreferredServiceForm!: FormGroup;
    purchaseServiceForm!: FormGroup;

    addNewReferredServiceSecondForm!: FormGroup;
    refrredSearchFormDiv!: boolean;
    searchData: boolean = false;
    selectedServicePlan: boolean = false;
    selectedCFEService: boolean = false;
    selectedProviderId: any;
    supervisorsList: any[] = [];
    assignmentListData: any;
    categoryTypes$!: Observable<DropdownModel[]>;
    categorySubTypes$!: Observable<DropdownModel[]>;
    paymentTypes$!: Observable<DropdownModel>;
    vendorServices$!: Observable<DropdownModel[]>;
    serviceEndReason$!: Observable<DropdownModel[]>;
    reasonServiceNotReceived$!: Observable<DropdownModel[]>;
    endReasonDropdown$!: Observable<any[]>;

    clientProgramNames$!: Observable<DropdownModel[]>;
    frequencyCds$!: Observable<DropdownModel[]>;
    durationCds$!: Observable<DropdownModel[]>;
    deleteAttachmentIndex!: number;
    uploadedFile: any = [];
    uploadNumber = '123434';
    reportMode = 'add';
    editMode = true;
    today: Date = new Date();
    isUploadDisabled: boolean = false;
    servicePlanForm!: FormGroup;
    addServicePlanForm!: FormGroup;
    timesInDayHide = false;
    id!: string;
    // D-06581
    // D-06581
    daNumber!: string;
    searchPlan: any;
    ReferredServices$!: Observable<any[]>;
    SearchPlan$!: Observable<SearchPlan[]>;
    SearchPlanRes$!: Observable<SearchPlanRes>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    servicePlanCountyValuesDropdownItems$!: Observable<DropdownModel[]>;
    displayfiscalcategoryCode4180: boolean = false;
    displayfiscalcategoryCode4184: boolean = false;
    providerId!: string;
    nextDisabled = true;
    isrepeatschecked!: boolean;
    isRepeats = 0;
    zoom!: number;
    defaultLat!: number;
    defaultLng!: number;
    mapBtn = false;
    markersLocation : Array<any> = [];
    minEstDate = new Date();
    endMinDate = new Date();
    referredService: any;
    purchaseAuthorizationGet!: PurchaseAuthorization[];
    singlePurchaseAuthorization!: PurchaseAuthorization | null;
    private token: AppUser;
    isSupervisor!: boolean;
    ssaPlacamentManager!: boolean;
    isFiscalCategory7108: boolean = false;
    isFiscalCategory4181: boolean = false;
    cfeDurationtype$!: Observable<any[]>;
    cfeDurationList!: any[];
    private headerSummary: any;
    serviceLogApproval!: ServiceLogApproval;
    getUsersList!: any[];
    enableSaveServiceLog = false;
    selectedPerson: any;
    assignedTo: any;
    originalUserList!: any[];
    status!: number;
    appEventCheck: boolean = false;
    authorizationCheck: any;
    involevedPerson$!: Observable<InvolvedPerson>;
    rcCjamsID!: number;
    authId!: string;
    sendApprovalEnable!: boolean;
    getSupervisorID!: string;
    isExceed!: number;
    referredServiceCP: any;
    resetForm = true;
    referredServiceList!: any[];
    reason_tx: any;
    isRejected!: boolean;
    serviceStartDate!: Date;
    fiscalcateforycdStartDate!: Date|null;
    serviceEndDate!: Date;
    disableApprove = true;
    minActDate!: Date;
    childList: any[] = [];
    clientGender!: string;
    clientDob!: Date;
    firstChild: any;
    clientAge: any;
    clientAgeAt26: any;
    clientAgeAt14: any;
    clientName!: string;
    timestamp!: Date;
    approveBtnTxt!: string;
    reasonDesc!: boolean;
    payableApprovalHistory!: any[];
    pageInfo: PaginationInfo = new PaginationInfo();
    pagination: PaginationInfo = new PaginationInfo();
    totalPage!: number;
    personid: any;
    activityService!: any[];
    activityServicePlan!: any[];
    livingArrangementTypeCheck: boolean = false;
    cfeHomeResourceChild: boolean = false;
    activePlacementProvider: any;
    servicePlan!: any[];
    serviceplanID: any;
    addNewService!: boolean;
    purchaseAuthEnable!: boolean;
    currentDate!: Date;
    serviceReceived!: boolean;
    serviceNotReceived!: boolean;
    clientProgramNames: any[] = [];
    clientSubProgramNames: any[] = [];
    isSubProgramMandatory = false;
    casestartdate: any;
    startdate: any;
    enddate: any;
    estimatedenddate: any;
    clientprogramselection: any;
    isServiceCase: any;
    serviceCase!: boolean;
    otherCase!: boolean;
    servicetypeid: any;
    fiscalCodes!: any[];
    directorApproval!: boolean;
    intakeserviceid = '';
    programManagerApproval: boolean = false;
    fileToSave = [];
    // CIDM-3416 county codes for 4180
    /*
Baltimore County -- 1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b,
Carrol County -- c3fa7975-4ee2-4c4f-90b7-e485e2da63a1,
Frederick County -- d0a6f218-4dee-45c3-b842-be7446a5ef41,
Prince George’s County and -- c81be790-a79d-40ac-a38d-abd4dd5a81f6
Montgomery County -- f6ab02d5-c386-4659-8810-687fc191a967
 */
    county_codes = ['1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'c3fa7975-4ee2-4c4f-90b7-e485e2da63a1', 'd0a6f218-4dee-45c3-b842-be7446a5ef41', 'c81be790-a79d-40ac-a38d-abd4dd5a81f6', 'f6ab02d5-c386-4659-8810-687fc191a967'];
    roleBased: boolean = true;
    userRole: string = 'role';
    eventCode: any;
    roletypekey!: string | null;
    role: any;
    rolename = signal<string | null>(null);
    defaultSupervisor!: string;
    clientEligibility!: any[];
    clientEligibilityStatus: any;
    totalcount: any;
    isapproved!: boolean;
    isApproved = true;
    purchaseAuthorization: any;
    isClosed = false;
    purchaseAuthorizationList: any = [];
    newAuthorization!: boolean;
    isExpired: boolean = false;
    dedicatedSelect: any;
    checkDedicated: any;
    showAttachementDetails: boolean = false;
    childAccountsList: any[] = [];
    listPageInfo: PaginationInfo = new PaginationInfo();
    listCount: any;
    purchaseAuthorizationServiceLog: any;
    referredServiceCheck: any;
    disbleService!: boolean;
    return_tx!: string;
    financeApprove!: string;
    isCaseWorker!: boolean;
    roletype!: string;
    savePurchase!: boolean;
    sendPurchase!: boolean;
    get_service_nm!: string;
    getProviderId!: string;
    financeApproval!: boolean;
    returnApprove!: boolean;
    rejectApprove!: boolean;
    saveService!: boolean;
    assign!: boolean;
    closed_date!: Date | null;
    disableAddService!: boolean;
    isReadonly = true;
    isBaltimoreCityUser: boolean = false;
    isEditDisabled = false;
    isDeleteDisabled = false;
    stateCountyCode: any;
    isAddPurchaseAuthEnabled: any;
    isAdoptionCase = false;
    isCpsIRorAR =false;
    authInitiator!: boolean;
    showEndReason: boolean = false;
    showEndReasonNotes: boolean = false;
    minAgeForfiscalCode: any;
    maxAgeForFiscalCode: any;
    days: any;
    uploadAttSaveUrl!: string;
    isEdit:boolean = false;
    @ViewChild(DocumentUploadListSharedComponent)
    documentuploaded!: DocumentUploadListSharedComponent;
    accesstokenpath = '?access_token=';
    selectservicepopupid = '#select-referredservice';
    addservicepopupid = '#add-newreferredservice';
    purchaseauthpopupid = '#purchase-autherization';
    dtformat = 'MM/DD/YYYY';
    dtformat1 = 'YYYY-MM-DD';
    dtformat2 = 'yyyy-MM-dd';
    purchaseauthlistpopupid = '#purchase-autherization-list';
    dedicatedcheckpopupid = '#dedicated-check';
    invalidfiscalcodemsg = 'Invalid Fiscal Category Code due to Client age';
    mandatorymsg = 'Please fill mandatory fields';
    actualStartEndDateAlertMessage = '';
    actualStartEndDateAlertMessageData='Please enter the dates correctly as selected dates are overlapping with other existing Service Log.';
    duplicateStartorEndDatesAlert = 'Requested purchase authorization already exists for the selected dates';
    servicelogminenddt!: Date | null;
    servicelogminenddate!: Date | null;

    twelvehour: boolean = true;
    timeInterval: number = 5;
    validateMessage:string = '';
    selectedTab: string = '';
    
   
        private formBuilder: FormBuilder;
        private _commonDropdownService: CommonDropdownsService;
        private _commonHttpService: CommonHttpService;
        private _authService: AuthService;
        private _alertService: AlertService;
        private datePipe: DatePipe;
        private _dataStoreService: DataStoreService;
        private _session: SessionStorageService;
        private _uploadService: NgxfUploaderService;
        private cdr: ChangeDetectorRef;

        constructor(private injector:Injector,private html2canvas:Html2CanvasService) {
            this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
            this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
            this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
            this._authService = this.injector.get<AuthService>(AuthService);
            this._alertService = this.injector.get<AlertService>(AlertService);
            this.datePipe = this.injector.get<DatePipe>(DatePipe);
            this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
            this._session = this.injector.get<SessionStorageService>(SessionStorageService);
            this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
            this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);

                this.formInitialize();
                this.token = this._authService.getCurrentUser();
        if (this.token.user.userprofile.teammemberassignment.teammember.team.countyid === '7665ca54-5374-4174-be07-a687b811a82c') {  
               this.isBaltimoreCityUser = true;   
           }
    }

    private formInitialize() {
        this.purchaseServiceForm = this.formBuilder.group(
            {
                fiscalCode: ['', Validators.required],
                voucherRequested: ['', Validators.required],
                cfeCareDuration: [''],
                costnottoexceed: ['', Validators.required],
                justificationCode: ['', Validators.required],
                startDt: [null, Validators.required],
                endDt: [null, Validators.required],
                dateofPreApproval: '',
                fundingstatus: '',
                authorization_id: '',
                paymentstatus: '',
                final_amount_no: '',
                client_account_no: '',
                reason_tx: '',
                supervisorid: [null]
            });

        this.referredServiceForm = this.formBuilder.group(
            {
                servicetypeid: [''],
                providerid: '',
                providername: ['', Validators.pattern(/^[A-Za-z][A-Za-z0-9 ]*$/)],
                taxid: '',
                zipcode: ''
            });

        this.EditreferredServiceForm = this.formBuilder.group(
            {
                servicetypeid: [{ value: '', disabled: true }],
                serviceNotReceivedReason: [''],
                serviceReceivedReason: [''],
                providerid: [{ value: '', disabled: true }],
                providername: [{ value: '', disabled: true }],
                taxid: [{ value: '', disabled: true }],
                zipcode: [{ value: '', disabled: true }],
                clientprogramnameid: [{ value: '', disabled: true }],
                clientsubprogramnameid: [''],
                estbegindate: [null, Validators.required],
                actbegindate: [null, Validators.required],
                estenddate: [null, Validators.required],
                actenddate: [null],
                actbegintime: [null, Validators.required],
                actendtime: [null, Validators.required],
                agencynotes: '',
                endReasonNotes: '',
                outcome: '',
                frequencyCdId: '',
                durationCdId: '',
                dateReffered: '',
                courtOrderedSw: '',
                serviceplanactionid: [null],
                serviceplanid: [null],
                serviceplanname: ''
            });

        this.addNewPurchaseAuthorization = this.formBuilder.group(
            {

            });

        this.addNewReferredServiceSecondForm = this.formBuilder.group(
            {
                clientprogramnameid: ['', Validators.required],
                clientsubprogramnameid: [''],
                servicetypeid: [''],
                frequencyCdId: ['', Validators.required],
                durationCdId: ['', Validators.required],
                estbegindate: ['', Validators.required],
                actbegindate: [''],
                estenddate: ['', Validators.required],
                actenddate: [''],
                dateReffered: ['', Validators.required],
                courtOrderedSw: '',
                actbegintime: '',
                actendtime: '',
                agencynotes: '',
                endReasonNotes: '',
                serviceplanactionid: [null],
                serviceplanid: [null],
                serviceplanname: '',
                endServiceReasonCd: [null],
                endReason: [null],
                outcome: '',
                noServiceReasonCd: [null],
                servicereceived: [null],
                servicenotreceived: [null],
                serviceReceivedReason: [null],
                // End D-06585
            });
    }
    uploadFile(data: any): void {
        const  file: File = data.file;
        const  category = data.category;
        const  subCategory = data.subCategory;
        const  date1 = data.date;
        if (!(file instanceof Array)) {
          return;
        }
        if(this.newAuthorization){
            this._alertService.error("Please click 'SAVE' to save the purchase authorization before uploading a file");
            return; 
        }
        file.map((item, index) => {
          const fileExt = item.name
            .toLowerCase()
            .split('.')
            .pop();
          if (
            fileExt === 'mp3' ||
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
              fileExt === 'rtf'
          ) {
            const isExist = this.uploadedFile.filter((data1: any) => (data1 === item));
              if (isExist.length === 0) {
                  this.uploadedFile.push(item);
              }
            const uindex = this.uploadedFile.length - 1;
            if (!this.uploadedFile[uindex].hasOwnProperty('percentage')) {
              this.uploadedFile[uindex].percentage = 1;
            }
            
            this.uploadAttachment(uindex,category,subCategory,date1);

            this.checkFileExtFn(fileExt, uindex);
          } else {
            // tslint:disable-next-line:quotemark
            this._alertService.error(fileExt + " format can't be uploaded");
          }
        });
      }
      //Assosiated with uploadFile method
    private checkFileExtFn(fileExt: any, uindex: number) {
        const audio_ext = ['mp3', 'ogg', 'wav', 'acc', 'flac', 'aiff'];
        const video_ext = ['mp4', 'avi', 'mov', '3gp', 'wmv', 'mpeg-4'];
        if (audio_ext.indexOf(fileExt) >= 0) {
            this.uploadedFile[uindex].attachmenttypekey = 'Audio';
        } else if (video_ext.indexOf(fileExt) >= 0) {
            this.uploadedFile[uindex].attachmenttypekey = 'Video';
        } else {
            this.uploadedFile[uindex].attachmenttypekey = 'Document';
        }
    }

      uploadAttachment(index: any,category: any,subCategory: any,date1: any) {
        let uploadUrl = '';
        uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.daNumber+ '&objecttypekey=' + 'purchaseAuthReceipt1';
        
        if(category !== ''&& subCategory !== '' && date1 !== ''){
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
                doucumentInfo.title = subCategory;
                doucumentInfo.objecttypekey = 'purchaseAuthReceipt1';
                doucumentInfo.rootobjecttypekey = 'purchaseAuthReceipt1';
                doucumentInfo.activeflag = 1;
                doucumentInfo.authId = this.authId;
                doucumentInfo.servicerequestid = null;
                this.uploadedFile[index] = { ...this.uploadedFile[index], ...doucumentInfo };

                  const attachment = Object.assign({
                    servicecaseid: this.id,
                    authorizationid:this.authId,
                    documentattachment: {
                    attachmentclassificationsubtypekey: subCategory,
                    attachmentclassificationtypekey: category,
                    attachmenttypekey: "Document",
                    actualdocumentdate: moment(date1).toDate()
                    },
                    attachment: [this.uploadedFile[index]]
                  });
      

                  this._commonHttpService.create(attachment, 'serviceLogs/addAttachment').subscribe(
                    res => {
                      this.uploadedFile[index]['documentpropertiesid'] = res[0].documentpropertiesid;
                      this.openpurchaseautherization(this.referredService);
                      this._alertService.success('Attachment Uploaded Successfully');
                    },
                    err => {
                      this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                  ); 
              }
            }, (err) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                this.uploadedFile.splice(index, 1);
            }
          ); 
        }
      }

    downloadFile(s3bucketpathname: any) {
          // 4200
          s3bucketpathname = s3bucketpathname.replace(/,/g, '');
          const downldSrcURL =  '/api' + s3bucketpathname;
        window.open(downldSrcURL, '_blank');
    }

    deleteAttachment() {
        const attachment = Object.assign({
          documentpropertiesid: this.uploadedFile[this.deleteAttachmentIndex]['documentpropertiesid']
        });
        (<any>$('#delete-attachment-popup')).modal('hide');
        this._commonHttpService.create(attachment, 'serviceLogs/deleteAttachment').subscribe(
          res => {
            this.uploadedFile.splice(this.deleteAttachmentIndex, 1);
            this._alertService.success('Attachment Deleted Successfully');
          },
          err => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          }
        );
      }
    
    confirmDeleteAttachment(index: number) {
        (<any>$('#delete-attachment-popup')).modal('show');
        this.deleteAttachmentIndex = index;
    }

    searchReferredServices(mode: any) {
        if(this.referredServiceForm.invalid){
            return;
        }
        const searchForm = this.referredServiceForm.getRawValue();
        if (!(searchForm.servicetypeid)) {
            this.servicetypeid = '';
        } else {
            this.servicetypeid = searchForm.servicetypeid.value;
        }
        if (mode === 'new') {
            this.pagination.pageNumber = 1;
            this.totalcount = 0;
        }
        this.searchData = true;
        const providerId = this.referredServiceForm.get('providerid')?.value ? this.referredServiceForm.get('providerid')?.value : '';
        const providerName = this.referredServiceForm.get('providername')?.value ? this.referredServiceForm.get('providername')?.value : '';
        const taxid = this.referredServiceForm.get('taxid')?.value ? this.referredServiceForm.get('taxid')?.value : '';
        const zipcode = this.referredServiceForm.get('zipcode')?.value ? this.referredServiceForm.get('zipcode')?.value : '';
        const services = this.servicetypeid ? this.servicetypeid : ''; 
        
        this.ReferredServices$ = this._commonHttpService.getArrayList(
            {
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.VendorServiceSearch + '?providerId=' + providerId +
            '&providerName=' + providerName +
            '&taxId=' + taxid +
            '&serviceId=' + services +
            '&zipCd=' + zipcode +
            '&page=' + this.pagination.pageNumber +
            '&limit=' + this.pagination.pageSize
        ).pipe(
            map((res: any) => {
                if (res && res['UserToken'].length > 0) {
                    this.totalcount = (res['UserToken'] && res['UserToken'].length > 0) ? res['UserToken'][0].totalcount : 0;
                    return res['UserToken'];
                }
            }),
            shareReplay(1));
    }

    pageChanged(page: any) {
        this.pagination.pageNumber = page;
        this.searchReferredServices('page');
    }

    ngOnInit() {
        this.isEditDisabled = this._authService.isDisabled('services','services.servicelog.editvendorservice');
        this.isDeleteDisabled = this._authService.isDisabled('services','services.servicelog.deletevendorservice');
        this.isAddPurchaseAuthEnabled = this._authService.isEnabled('services','services.servicelog.editvendorservice');
        this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.pagination.pageNumber = 1;
        this.pageInfo.pageNumber = 1;
        this.listPageInfo.sortBy = 'desc';
        this.listPageInfo.sortColumn = 'actual_start_date';
        this.isSupervisor = (this._authService.getCurrentUser().role.name === AppConstants.ROLES.SUPERVISOR) ? true : false;
        this.isCaseWorker = (this._authService.getCurrentUser().role.name === AppConstants.ROLES.CASE_WORKER) ? true : false;
        this.ssaPlacamentManager = (this._authService.getCurrentUser().role.name === AppConstants.ROLES.SSA_Placement_Manager) ? true : false;
        if (this.ssaPlacamentManager) {
            this.isSupervisor = true;
        }
        this.isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        const caseType = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
        if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
            this.isAdoptionCase = true;
        }
        this.checkUserRoleFn();
        this.timestamp = new Date();
        this.minActDate = new Date();
        this.minEstDate = new Date();
        this.currentDate = new Date();
        this.refrredSearchFormDiv = true;
        // D-06581
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.handleCaseInfoCheckFn();
        this.purchaseServiceForm.get('final_amount_no')?.disable();
        this.purchaseServiceForm.get('paymentstatus')?.disable();
        this.purchaseServiceForm.get('fundingstatus')?.disable();
        this.purchaseServiceForm.get('authorization_id')?.disable();
        this.purchaseServiceForm.get('client_account_no')?.disable();
        this.disableApprove = true;
        const da_status = this._session.getItem('da_status');
        if (da_status) {
        if (da_status === 'Closed' || da_status === 'Completed') {
            this.isClosed = true;
        } else {
            this.isClosed = false;
        }
        }
        const closed_date = this._session.getItem('case_closed');
        if(this.isClosed){
            this.closed_date = closed_date === 'null' ? null : closed_date;
        }else{
            this.closed_date = null;
        }
        this.handleUserDetailsFn();
        this.getCounty();
        this.getClientDropdown(null);
        this.uploadAttSaveUrl = "serviceLogs/addAttachment";
    }
    // Assosiated with ngOnInit method
    private checkUserRoleFn() {
        const activeModuleRole = this._session.getItem('activeModuleRole');
        if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
            this.isReadonly = false;
        } else {
            this.isReadonly = this._authService.readonlyButton('read_only_access', 'readonly-servicelog');
        }
        if (this.isSupervisor) {
            this.roletype = 'CWSP';
            this.purchaseAuthorization = this._session.getItem('PurchaseAuthorization');
            this.purchaseAuthorizationServiceLog = this._session.getItem('PurchaseAuthorizationServiceLog');
            this._session.setItem('PurchaseAuthorization', null);
            this._session.setItem('PurchaseAuthorizationServiceLog', null);
        } else if (this.isCaseWorker) {
            this.roletype = 'CWCW';
        }
        if (this.isServiceCase === 'true') {
            this.otherCase = false;
        } else {
            this.otherCase = true;
        }
    }
    // Assosiated with ngOnInit method
    private handleUserDetailsFn() {
        const userDetails = this._authService.getCurrentUser();
        const reviewer = this._session.getItem('da_assignedby');
        if (userDetails && userDetails.user && userDetails.user.username && reviewer) {
            if ((userDetails.user.username).toLowerCase().trim() === reviewer.toLowerCase().trim()) {
                this.disableAddService = true;
            } else {
                this.disableAddService = false;
            }
        } else {
            this.disableAddService = false;
        }
    }
    // Assosiated with ngOnInit method
    private handleCaseInfoCheckFn() {
        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        const reportSummaryData = this._dataStoreService.getData('reportSummaryData');
        if (caseInfo && caseInfo.da_intakedaterecieved && caseInfo.da_receiveddate && caseInfo.da_intakedaterecieved <= caseInfo.da_receiveddate) {
            this.casestartdate = caseInfo.da_intakedaterecieved;
        } else if (caseInfo && caseInfo.da_receiveddate && reportSummaryData && reportSummaryData.reporteddate && caseInfo.da_receiveddate <= reportSummaryData.reporteddate) {
            this.casestartdate = caseInfo.da_receiveddate;
        } else if (caseInfo && caseInfo.da_receiveddate && reportSummaryData && reportSummaryData.reporteddate && caseInfo.da_receiveddate > reportSummaryData.reporteddate) {
            this.casestartdate = reportSummaryData.reporteddate;
        } else {
            this.casestartdate = caseInfo.da_receiveddate;
        }
        if (this.daNumber.toLowerCase().indexOf('cw') !== -1) {
            this.daNumber = this.daNumber.slice(2);
        }
        if (caseInfo && (caseInfo.da_subtype === 'CPS-IR' || caseInfo.da_subtype === 'CPS-AR')) {
            this.isCpsIRorAR = true;
        }
        this.getInvolvedPerson();
        this.loadSupervisor();
        this.getAssignmentsList();
        if (caseInfo && caseInfo.da_assignedby) {
            this.defaultSupervisor = caseInfo.da_assignedby;
        }
    }

    onServiceSelect(service: any) {
        this.pagination.pageNumber = 1;
        this.servicetypeid = service.value;
        if (service.additionalProperty === '3335') {
            this.purchaseAuthEnable = false;
        } else if (service.additionalProperty === '3334') {
            this.purchaseAuthEnable = true;
        }
    }
    onActivity() {
        this.pagination.pageNumber = 1;
    }

   totalServicePlanCountLimit = 10; 
    // vendor GET list
    getList(pageNo = 1,checkExpectedCount?:boolean) {
        // get paged arraylist sample
        // D-06581
        
        this.referredServiceList$ = this._commonHttpService.getArrayList(
            {
                where: {
                    daNumber: this.daNumber, clientid: this.rcCjamsID, service_log_id: this.purchaseAuthorizationServiceLog ? +this.purchaseAuthorizationServiceLog : null,
                    sortcolumn: this.listPageInfo.sortColumn, sortorder: this.listPageInfo.sortBy
                },
                method: 'get',
                limit: 10,
                page: this.listPageInfo.pageNumber
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.vendorServiceLog + '?filter'
        ).pipe(
            map((res: any) => {
                if(checkExpectedCount && this.listCount >= res.length){
                    checkExpectedCount = false;
                    this._alertService.error('Unexpected List Count');                  
                }
                this.referredServiceList = res['servicelogData'];
                this.totalServicePlanCountLimit =  this.referredServiceList?.length > 0 ? this.referredServiceList[0]['totalcount'] : '0';
                this.referredServiceCheck = this.referredServiceList?.find(item => item.service_log_id === this.purchaseAuthorizationServiceLog);
                if (this.referredServiceCheck && this.purchaseAuthorizationServiceLog) {
                    this.openpurchaseautherization(this.referredServiceCheck);
                }
                this.listCount = (res && res['servicelogData'] && res['servicelogData'].length) ? res['servicelogData'][0].totalcount : 0;             
                return res['servicelogData'];
            }));
    }

    listPageChanged(page: any) {
        this.listPageInfo.pageNumber = page;
        this.getList();
    }

    intiReferredServiceForm() {
        this._commonHttpService.getArrayList(
                {
                    where: {
                        daNumber: this.daNumber, clientid: this.rcCjamsID, service_log_id: this.purchaseAuthorizationServiceLog ? +this.purchaseAuthorizationServiceLog : null,
                        sortcolumn: this.listPageInfo.sortColumn, sortorder: this.listPageInfo.sortBy
                    },
                    method: 'get',
                    limit: this.totalServicePlanCountLimit,
                    page: 1
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.vendorServiceLog + '?filter'
            ).pipe(
                map((res: any) => {
                   
                    this.referredServiceList = res['servicelogData'];
                })).subscribe(()=> {

                    this.saveService = false;
                    this.addNewService = true;
                    this.minActDate = new Date();
                    this.minEstDate = new Date();
                    this.searchData = false;
                    this.referredServiceForm.reset();
                    this.addNewReferredServiceSecondForm.reset();
                    this.addNewReferredServiceSecondForm.patchValue({
                        dateReffered : new Date()
                    });
                    if(this.clientprogramselection === 'IHSFP' && this.clientSubProgramNames && Array.isArray(this.clientSubProgramNames) && this.clientSubProgramNames.length > 0){
                        this.addNewReferredServiceSecondForm.controls['clientsubprogramnameid'].setValidators([Validators.required]);
                        this.addNewReferredServiceSecondForm.controls['clientsubprogramnameid'].updateValueAndValidity();
                        this.isSubProgramMandatory = true;
                    } else {
                        this.addNewReferredServiceSecondForm.controls['clientsubprogramnameid'].clearValidators();
                        this.addNewReferredServiceSecondForm.controls['clientsubprogramnameid'].updateValueAndValidity();
                        this.isSubProgramMandatory = false;
                    }
                    this.addNewReferredServiceSecondForm.patchValue({
                        clientprogramnameid: this.clientprogramselection ? this.clientprogramselection : null
                    });
                    this.getActivityService();
                    this.addNewReferredServiceSecondForm.controls['actenddate'].disable();
                    this.addNewReferredServiceSecondForm.controls['actbegindate'].disable();
                    this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].disable();

                })
        

    }

    listMap() {
        this.zoom = 11;
        this.defaultLat = 39.29044;
        this.defaultLng = -76.61233;
        this.ReferredServices$.subscribe(map1 => {
            this.markersLocation = [];
            if (map1.length > 0) {
                this.listMapLoopFn(map1);
                if (
                    !this.markersLocation[0].lat !== null &&
                    !this.markersLocation[0].lng !== null
                ) {
                    this.defaultLat = this.markersLocation[0].lat;
                    this.defaultLng = this.markersLocation[0].lng;
                } else {
                    this.defaultLat = 39.29044;
                    this.defaultLng = -76.61233;
                }
                (<any>$('#iframe-popup')).modal('show');
            }
        });
    }
    // Assosiated with listMap method
    private listMapLoopFn(map2: any[]) {
        map2.forEach(res => {
            if (res.latitude !== null && res.longitude !== null) {
                const mapLocation = {
                    lat: +res.latitude,
                    lng: +res.longitude,
                    draggable: +true,
                    providername: res.providername !== null ? res.providername : 'NA',
                    addressline1: res.addressline1 !== null ? res.addressline1 : 'NA',
                };
                this.markersLocation.push(mapLocation);
            } else {
                const mapLocation = {
                    lat: +this.defaultLat,
                    lng: +this.defaultLng,
                    draggable: +true,
                    providername: res.providername !== null ? res.providername : 'NA',
                    addressline1: res.addressline1 !== null ? res.addressline1 : 'NA',
                };
                this.markersLocation.push(mapLocation);
            }
        });
    }

    mapClose() {
        this.markersLocation = [];
    }

    closePopUp() {
        (<any>$('#view-referredservice')).modal('hide');
    }

    selectReferredService() {
        if (this.selectedCFEService && !this.displayfiscalcategoryCode4180) {
            this._alertService.warn('This Service Type is applicable Only for the pilot counties - Baltimore County, Carroll County, Frederick County, Prince George’s County and Montgomery County');
        } else if(this.selectedCFEService && !this.cfeHomeResourceChild) {
            this._alertService.warn('This Service Type is applicable Only for the child identified as CfE Resource Home Child AND the Child must be placed under the CfE Resource Home Provider Placement. (Current Placement).');
        } else {
           (<any>$(this.selectservicepopupid)).modal('show');
           this.addNewReferredServiceSecondForm.get('actenddate')?.clearValidators();
           this.addNewReferredServiceSecondForm.get('actenddate')?.updateValueAndValidity();
        }
    }

    previous() {
        this.saveService = false;
        this.searchData = false;
        this.referredServiceForm.reset();
        this.addNewReferredServiceSecondForm.reset();
        (<any>$(this.addservicepopupid)).modal('show');
    }

    openNewAuthorization() {
        if (this._authService.hasSupervisor()) {
            if (!this.isAddPurchaseAuthEnabled && this._authService.primaryRole.key && this._authService.primaryRole.key.toLowerCase() !== 'cwcw') {
                this._alertService.warn('Please change the role from supervisor approval to case worker.');
                (<any>$(this.purchaseauthpopupid)).modal('hide');
            } else {
                (<any>$(this.purchaseauthpopupid)).modal('show');
            }
        } else {
            this._alertService.warn('You do not have supervisor.Please contact admininstrator.');
        }
        this.isUploadDisabled = false;
        this.uploadedFile = [];
        this.dedicatedSelect = null;
        this.checkDedicated = null;
        this.newAuthorization = true;
        this.enableSaveServiceLog = true;
        this.purchaseServiceForm.reset();
        this.loadSupervisor();
        this.purchaseServiceForm.patchValue({
            voucherRequested: 'N'
        });
        this.payableApprovalHistory = [];
        this.getFiscalCategoryCode(this.referredService?.agency_program_area_id);
        this.disableApprove = true;
        this.serviceStartDate = this.referredService?.actual_start_date;
        this.serviceEndDate = this.referredService?.actual_end_date;
        if (this.closed_date && (!this.serviceEndDate || this.closed_date < this.serviceEndDate)) {
            this.serviceEndDate = this.closed_date;
        }
        // PurchaseAuthorizationGet
        this.approveBtnTxt = 'Send for approval';
        this.reasonDesc = false;
        this.purchaseServiceForm.enable();
        this.purchaseServiceForm.get('final_amount_no')?.disable();
        this.purchaseServiceForm.get('paymentstatus')?.disable();
        this.purchaseServiceForm.get('fundingstatus')?.disable();
        this.purchaseServiceForm.get('authorization_id')?.disable();
        this.purchaseServiceForm.get('client_account_no')?.disable();
        this.isRejected = false;
    }

    openPurchaseAutherizationList(purchaseDetail: any) {
        this.totalPage = 0;
        this.isUploadDisabled = false;
        this.newAuthorization = false;
        this.isFiscalCategory7108 = false;
        this.handleFinanceApproveStatusFn(purchaseDetail);
        if (purchaseDetail.fiscalcode === '4180') {
            this.purchaseServiceForm.patchValue({
                dateofPreApproval: purchaseDetail.dateofpreapproval
            });
            this.showAttachementDetails = true;
        }
        if (purchaseDetail.fiscalcode === '4181') {
            this._commonDropdownService.getPickList(11001).subscribe(resp => {
                this.cfeDurationList = resp;
            });
            this.isFiscalCategory4181 = true;
            this.purchaseServiceForm.patchValue({
                cfeCareDuration: purchaseDetail.cfecareduration
            });
        }
        if (purchaseDetail.fiscalcode === '7108') {
            this.isFiscalCategory7108 = true;
        } 
        this.uploadedFile = purchaseDetail.attachments ? purchaseDetail.attachments : [];
        this.singlePurchaseAuthorization = purchaseDetail ? purchaseDetail : {};
            if (this.singlePurchaseAuthorization?.fiscal_category_cd) {
                this.enableSaveServiceLog = false;
            }
            if (purchaseDetail && ((purchaseDetail.status === 'Returned' && this.isSupervisor) || (purchaseDetail.status === 'Denied'))) {
                this.isRejected = true;
                this.reasonDesc = true;
                this.purchaseServiceForm.disable();
                this.isUploadDisabled = true;
            } else {
                this.approveBtnTxt = 'Send for approval';
                this.reasonDesc = false;
                this.purchaseServiceForm.enable();
                this.purchaseServiceForm.get('final_amount_no')?.disable();
                this.purchaseServiceForm.get('paymentstatus')?.disable();
                this.purchaseServiceForm.get('fundingstatus')?.disable();
                this.purchaseServiceForm.get('authorization_id')?.disable();
                this.purchaseServiceForm.get('client_account_no')?.disable();
                this.isRejected = false;
            }
            this.loadSupervisor();
            this.handleIfAuthorizationidFn(purchaseDetail);

    }
    // Assosiated with openPurchaseAutherizationList method
    private handleFinanceApproveStatusFn(purchaseDetail: any) {
        if (purchaseDetail && (((+purchaseDetail.cost_no >= 1000 || purchaseDetail.fiscal_category_cd.trim() === '7502'
            || purchaseDetail.fiscal_category_cd.trim() === '7503') && !this.isBaltimoreCityUser) ||
            ((+purchaseDetail.cost_no >= 5000 || purchaseDetail.fiscal_category_cd.trim() === '7502'
                || purchaseDetail.fiscal_category_cd.trim() === '7503') && this.isBaltimoreCityUser))) {
            this.financeApprove = 'Send for Director Approval';
            this.selectedTab = 'Directors'
        } else if (purchaseDetail && +purchaseDetail.cost_no >= 1000 && +purchaseDetail.cost_no < 5000 && this.isBaltimoreCityUser) {
            this.financeApprove = 'Send for Program Manager Approval';
            this.selectedTab = 'Program Managers'
        } else {
            this.financeApprove = 'Send for Finance Approval';  
            this.selectedTab = 'Fiscal Worker'          
        }
    }
    // Assosiated with openPurchaseAutherizationList method
    private handleIfAuthorizationidFn(purchaseDetail: any) {
        if (this.singlePurchaseAuthorization?.authorization_id) {
            this.authId = this.singlePurchaseAuthorization.authorization_id;
            this.getApproveHistory(this.authId);
            this.handleUserApprovalFn();
            const model = this.handleIfAuthorizationidModelFn(purchaseDetail);
            this.purchaseServiceForm.setValue(model, { emitEvent: true, onlySelf: false });
            if (this.singlePurchaseAuthorization && !this.singlePurchaseAuthorization.status) {
                this.handleIfsinglePurchaseAuthorizationStatusFn();
            } else {
                if (this.isSupervisor) {
                    this.handleIfSupervisorInAuthidFn();
                } else if (!this.isSupervisor && this.singlePurchaseAuthorization.status === 850) {
                    this.serviceStartDate = this.singlePurchaseAuthorization.startdt;
                    this.approveBtnTxt = 'Resend for approval';
                    this.reasonDesc = true;
                    this.enableSaveServiceLog = true;
                    this.disableApprove = true;
                    this.purchaseServiceForm.enable();
                    this.purchaseServiceForm.get('final_amount_no')?.disable();
                    this.purchaseServiceForm.get('paymentstatus')?.disable();
                    this.purchaseServiceForm.get('fundingstatus')?.disable();
                    this.purchaseServiceForm.get('authorization_id')?.disable();
                    this.purchaseServiceForm.get('client_account_no')?.disable();
                    this.purchaseServiceForm.get('reason_tx')?.disable();
                    this.purchaseServiceForm.get('supervisorid')?.disable();
                } else {
                    this.disableApprove = false;
                    this.purchaseServiceForm.disable();
                    this.isUploadDisabled = true;
                }
            }
        }
    }
    // Assosiated with openPurchaseAutherizationList method
    private handleIfsinglePurchaseAuthorizationStatusFn() {
        if (!this.isSupervisor && !(this.totalPage && this.totalPage > 0)) {
            this.disableApprove = true;
        } else {
            this.disableApprove = false;
            this.purchaseServiceForm.disable();
            this.isUploadDisabled = true;
        }
    }
    // Assosiated with openPurchaseAutherizationList method
    private handleIfSupervisorInAuthidFn() {
        if (this.singlePurchaseAuthorization?.status === 39) {
            this.purchaseServiceForm.disable();
            this.isUploadDisabled = true;
            this.purchaseServiceForm.get('justificationCode')?.enable();
            this.disableApprove = true;
        } else {
            this.disableApprove = false;
            this.purchaseServiceForm.disable();
            this.isUploadDisabled = true;
        }
    }
    // Assosiated with openPurchaseAutherizationList method
    private handleIfAuthorizationidModelFn(purchaseDetail: any) {
        return {
            fiscalCode: this.singlePurchaseAuthorization?.fiscal_category_cd,
            voucherRequested: this.singlePurchaseAuthorization?.voucher_requested,
            costnottoexceed: this.singlePurchaseAuthorization?.cost_no ? this.singlePurchaseAuthorization.cost_no : '0.00',
            justificationCode: this.singlePurchaseAuthorization?.justification_text,
            fundingstatus: this.singlePurchaseAuthorization?.fundingstatus,
            authorization_id: this.singlePurchaseAuthorization?.authorization_id ? this.singlePurchaseAuthorization.authorization_id : '',
            startDt: this.singlePurchaseAuthorization?.startdt,
            endDt: this.singlePurchaseAuthorization?.enddt,
            paymentstatus: this.singlePurchaseAuthorization?.paymentstatus,
            final_amount_no: this.singlePurchaseAuthorization?.final_amount_no ? this.singlePurchaseAuthorization.final_amount_no : '0.00',
            client_account_no: this.singlePurchaseAuthorization?.client_account_no ? this.singlePurchaseAuthorization.client_account_no : '',
            dateofPreApproval: this.singlePurchaseAuthorization?.dateofpreapproval ? this.singlePurchaseAuthorization.dateofpreapproval : '',
            cfeCareDuration: purchaseDetail.cfecareduration ? purchaseDetail.cfecareduration : null,
            reason_tx: this.singlePurchaseAuthorization?.reason_tx ? this.singlePurchaseAuthorization.reason_tx : '',
            supervisorid: this.singlePurchaseAuthorization?.supervisorid ? this.singlePurchaseAuthorization.supervisorid : ''
        };
    }
    // Assosiated with openPurchaseAutherizationList method
    private handleUserApprovalFn() {
        if (((this.singlePurchaseAuthorization?.cost_no && this.singlePurchaseAuthorization?.cost_no >= 1000 || this.singlePurchaseAuthorization?.fiscal_category_cd.trim() === '7502'
            || this.singlePurchaseAuthorization?.fiscal_category_cd.trim() === '7503') && !this.isBaltimoreCityUser) ||
            ((this.singlePurchaseAuthorization?.cost_no && this.singlePurchaseAuthorization?.cost_no >= 5000 || this.singlePurchaseAuthorization?.fiscal_category_cd.trim() === '7502'
                || this.singlePurchaseAuthorization?.fiscal_category_cd.trim() === '7503') && this.isBaltimoreCityUser)) {
            this.directorApproval = true;
            this.programManagerApproval = false;
        } else if (this.singlePurchaseAuthorization?.cost_no && this.singlePurchaseAuthorization?.cost_no >= 1000
            && this.singlePurchaseAuthorization?.cost_no < 5000
            && this.isBaltimoreCityUser) {
            this.programManagerApproval = true;
        } else {
            this.directorApproval = false;
            this.programManagerApproval = false;
        }
    }

    sendApprove() {
        let eventcodecheck = 'PCAUTH'
        if (this.singlePurchaseAuthorization?.fiscal_category_cd === '7108') {
            this.purchaseServiceForm.value.supervisorid = ''; 
            eventcodecheck = 'PCAUTHR';
            this.getSupervisorID = '';
        }
        this._commonHttpService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.ServiceLogApproval;
            const modal = {
                'case_id': this.daNumber,
                'fiscalcategorycd' : this.singlePurchaseAuthorization?.fiscal_category_cd,
                'costno' : this.singlePurchaseAuthorization?.cost_no ? this.singlePurchaseAuthorization.cost_no : '0.00',
                'authorization_id' : this.singlePurchaseAuthorization?.authorization_id ? this.singlePurchaseAuthorization.authorization_id : null,
                'provider_id' : this.referredService.provider_id,
                'intakeserviceid' : this.id,
                'assignedtoid' : this.purchaseServiceForm.value.supervisorid ? this.purchaseServiceForm.value.supervisorid : this.getSupervisorID,
                'eventcode' : eventcodecheck,
                'status' : 39,
                'startDt' : this.singlePurchaseAuthorization?.startdt,
                'endDt' : this.singlePurchaseAuthorization?.enddt,
                'client_account_id': this.singlePurchaseAuthorization?.client_account_id,
                'client_id' : this.singlePurchaseAuthorization?.client_id,
                'bmanualrouting': this.otherCase,
                'v_securityusersid': this.token.user.userprofile.securityusersid
            };
        this._commonHttpService.create(modal).subscribe(
            (response) => {
                this._alertService.success('Approval sent successfully!');
                (<any>$(this.purchaseauthpopupid)).modal('hide');
                (<any>$(this.purchaseauthlistpopupid)).modal('show');
                this.sendApprovalEnable = false;
                this.openpurchaseautherization(this.referredService);
                this.getList(1);
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                this.sendApprovalEnable = false;
            }
        );
    }

    closeList() {
        this.getList();
    }

    openpurchaseautherization(referredService: any, mode?: string) {
        this.rejectApprove = false;
        this.returnApprove = false;
        this.sendPurchase = false;
        this.selectedCFEService = false;
        this.get_service_nm = referredService.service_name;
        this.validateServiceIdFn(referredService);
        this.payableApprovalHistory = [];
        this.isExpired = false;
        if (referredService && referredService.agency_program_area_id) {
            referredService['agency_sub_program_area_nm'] = 'N/A';
            this.getFiscalCategoryCode(referredService.agency_program_area_id);
            if(referredService.agency_sub_program_area_id){
            const clientProgram = this.clientProgramNames.find(clientid => clientid.agency_program_area_id === referredService.agency_program_area_id);
            if(clientProgram){
                const subprogramList = clientProgram['subprogram'];
                if(subprogramList && Array.isArray(subprogramList) && subprogramList.length > 0){
                    const subProgram = subprogramList.find(element => element.subprogramkey === referredService.agency_sub_program_area_id);
                    referredService['agency_sub_program_area_nm'] = subProgram?.subprogramname;
                }
            }

            }
        }
        this.disableApprove = true;
        this.serviceStartDate = referredService.actual_start_date;
        this.serviceEndDate = referredService.actual_end_date;
        if (this.closed_date && (!this.serviceEndDate || this.closed_date < this.serviceEndDate)) {
            this.serviceEndDate = this.closed_date;
        }
        this.referredService = referredService;
        this.validateDatedFn();
        // PurchaseAuthorizationGet
        this.ifModeIsNotNewFn(mode);
    }
    // Assosaited with openpurchaseautherization method
    private validateDatedFn() {
        const actualEndDate: any = this.referredService.actual_end_date ? new Date(this.referredService.actual_end_date) : null;
        const endDate: any = this.datePipe.transform(actualEndDate, 'dd/MM/yyyy');
        const today: any = this.datePipe.transform(new Date(), 'dd/MM/yyyy');
        if (endDate && endDate < today) {
            this.isExpired = true;
        }
    }
    // Assosaited with openpurchaseautherization method
    private validateServiceIdFn(referredService: any) {
        if (referredService.service_id == '526' || referredService.service_id == '527') {
            this.selectedCFEService = true;
        }
        this.getProviderId = referredService.provider_id;
        if (this.purchaseAuthorizationServiceLog && this.purchaseAuthorizationServiceLog !== 'null' && this.isSupervisor) {
            this.purchaseAuthorizationServiceLog = null;
            (<any>$(this.purchaseauthlistpopupid)).modal('show');
        }
    }
    // Assosiated with openpurchaseautherization method
    private ifModeIsNotNewFn(mode: any) {
        if (mode !== 'New') {
            this._commonHttpService.getArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    where: {
                        service_log_id: this.referredService.service_log_id,
                        roletypekey: this.roletype ? this.roletype : null
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.PurchaseAuthorizationGet + '?filter'
            ).subscribe((result: any) => {
                if (result && result['data'].length > 0) {
                    this.handlePurchaseAuthorizationGetRespFn(result);
                } else {
                    this.purchaseAuthorizationList = [];
                }
                this.cdr.markForCheck();
            });
        }
    }
    // Assosiated with openpurchaseautherization method
    private handlePurchaseAuthorizationGetRespFn(result: any) {
        this.purchaseAuthorizationList = result['data'];
        if (this.newAuthorization) {
            this.singlePurchaseAuthorization = result['data'][0];
            this.openPurchaseAutherizationList(result['data'][0]);
        }
        if (this.sendApprovalEnable) {
            if (!this.isSupervisor) {
                this.sendApprove();
            }
        }
    }

    serviceStartDateChange(startDate: MatDatepickerInputEvent<Date>) {
        if (this.purchaseServiceForm.get('endDt')?.value && this.purchaseServiceForm.get('endDt')?.value < startDate) {
            this.purchaseServiceForm.get('endDt')?.reset();
        }
        this.serviceEndtDateChange()
    }

    serviceEndtDateChange() {
        this.purchaseServiceForm.get('cfeCareDuration')?.reset();
        this.days = null;
        if(this.purchaseServiceForm.get('startDt')?.value && this.purchaseServiceForm.get('endDt')?.value){
            this.days = this.calculatedays(this.purchaseServiceForm.get('startDt')?.value, this.purchaseServiceForm.get('endDt')?.value)
        }
    }

    calculatedays(startDate: any, endDate: any) {
        const date2 = new Date(endDate);
        const date1 = new Date(startDate);
        const diff = Math.abs(date1.getTime() - date2.getTime());
        return Math.ceil(diff / (1000 * 3600 * 24));
    }

    print() {
        (<any>$('#view-log')).modal('show');
        (<any>$(this.purchaseauthpopupid)).modal('hide');
    }

    fiscalCodeChanges(category: any ) {
       let startdate = this.fiscalCodes.filter(item => item.fiscalcateforycd == category)[0].start_dt
        if(category=='7161' || category=='7160' || category=='7113'){
           this.fiscalcateforycdStartDate= (this.serviceStartDate > startdate) ? this.serviceStartDate : startdate;
        } else{
            this.fiscalcateforycdStartDate=null;
        }
        this.showAttachementDetails = false;
        this.isFiscalCategory7108 = false;
        this.isFiscalCategory4181 = false;
        if (category === '7503') {
            this.dedicatedSelect = null;
            this.checkDedicated = null;
            (<any>$(this.purchaseauthpopupid)).modal('hide');
            (<any>$(this.dedicatedcheckpopupid)).modal('show');
        } else if (category === '2110') {
            this.purchaseServiceForm.patchValue({
                client_account_no: null
            });
            this._alertService.warn('SSA approval is required for the fiscal category code Non Recurring OTO Subsidy Expenses');
        } else if (category == '4180') {
            this.showAttachementDetails = true;
        } else if (category === '7108') {
            this.isFiscalCategory7108 = true;
        } else if (category === '4181') {
            this.isFiscalCategory4181 = true;
            this._commonDropdownService.getPickList(11001).subscribe(resp => {
                this.cfeDurationList = resp;
            })
        }   else if (!(category === '7502' && category === '7503')) {
            this.purchaseServiceForm.patchValue({
                client_account_no: null
            });
        } 
        let additionalInfo : any =this.fiscalCodes.filter(item => item.fiscalcateforycd == category)[0].additional_description;
        if(this.fiscalcateforycdStartDate && additionalInfo){
            this.validateMessage = this.validateMessage = additionalInfo.replace(/\.+$/, "") + 
                        ' effective from ' + moment(new Date(startdate)).format(this.dtformat) +'.';
            (<any>$('#validate-fiscalDate')).modal('show');
        }
    }

    dedCheck(value: any) {
        if (value === '0') {
            (<any>$(this.purchaseauthpopupid)).modal('hide');
            (<any>$(this.dedicatedcheckpopupid)).modal('hide');
            (<any>$(this.purchaseauthlistpopupid)).modal('show');
        } else if (value === '1') {
            (<any>$(this.dedicatedcheckpopupid)).modal('hide');
            if (this._authService.hasSupervisor()) {
                (<any>$(this.purchaseauthpopupid)).modal('show');
            }
        }
    }


    private loadAttachmentList() {    
       const casetype =  this.isServiceCase ? 'Servicecase' : 'ServiceRequest';
        const inputreq = {
            personid: this.personid,
            intakenumber: null,
            servicerequestid: (this.isServiceCase || this.isAdoptionCase) ? null : this.id,
            servicecaseid: this.isServiceCase ? this.id : null,
            adoptioncaseid: this.isAdoptionCase ? this.id : null,
            objecttypekey: this.isAdoptionCase ? 'Adoptioncase' : casetype,
            category: "{\"CW-Finance\"}",
            subcategory: "{\"CfE Site Expenditure Proposal\"}",
            sortcolumn: this.paginationInfo.sortColumn ,
            sortby: this.paginationInfo.sortBy
        };

        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: inputreq,
                    method: 'get',
                    page: this.paginationInfo.pageNumber,
                    limit: 10
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentGridUrl + '?filter').subscribe((response: any) => {
                    if (response && Array.isArray(response) && response.length) {
                        const result = response[0].searchcaseworkerattachments;
                        if (result) {
                            this.uploadedFile = result;
                        } else {
                            this.uploadedFile = [];
                        }
                     } else {
                        this.uploadedFile = [];
                     }
                });
    }

calculateage(dob: any,date3: any){
    const pdob =new Date(dob);
    const datecheck =new Date(date3);
    let age = datecheck.getFullYear() -pdob.getFullYear();
    const check = datecheck.getMonth() - pdob.getMonth();
    if(age === 21) {
        if ((check > 0) || (check === 0 && datecheck.getDate() > pdob.getDate() )){
            age ++;
        }
    }
    if(age === 14){
        if ((check < 0) || (check === 0 && datecheck.getDate() < pdob.getDate() )){
            age --;
        }
    }
   return age;
}
    savePurchaseAuth(purchaseServiceForm: any, isSendForApproval?: any) {
        if(!this.purchaseServiceForm.valid) {
            this.purchaseServiceForm.markAllAsTouched();
            this._alertService.warn(this.mandatorymsg);
            return;
        }
        let duplicatedate = false; //CIDM-9815 - Purchase Authorization dates cannot overlap
        let serviceForm = isSendForApproval ? purchaseServiceForm : purchaseServiceForm.getRawValue();
        this.purchaseAuthorizationList.forEach((element: any) => {
            if ((new Date(serviceForm.startDt).getTime() <= new Date(element.enddt).getTime() && new Date(element.startdt).getTime() <= new Date(serviceForm.endDt).getTime())
                && element.routingstatus !== 'Denied' && serviceForm.authorization_id !== element.authorization_id) { //CDM-43997 - Additional logic for denied and returned purchase authorizations
                    duplicatedate = true;
                }
            });
        this.cdr.markForCheck();
        if (duplicatedate) {
            this.sendApprovalEnable = false;
            this._alertService.error(this.duplicateStartorEndDatesAlert);
            return;
        }
            this.savePurchase = true;
            this.referredServiceCP = this.referredService;
            // this.savePurchaseAuth(purchaseServiceForm);
            // Start D-06715, D-06716
            if(!this.checkFiscalCodeFn()) {
                return;
            }
            // End D-06715, D-06716

                if(!this.handleAllFiscalCodeConditionsFn(isSendForApproval)) {
                    return false;
                }
                    let method;
                   if (this.newAuthorization) {
                     method = 'purchaseAuthorize';
                     this.singlePurchaseAuthorization = null;
                   } else {
                     method = this.singlePurchaseAuthorization && this.singlePurchaseAuthorization.authorization_id ? 'updatePurchaseAuthorize' : 'purchaseAuthorize';
                     this.newAuthorization = false;
                   }
                    const url = 'purchaseAuthorizations/' + method + this.accesstokenpath + this.token.id;
                    const purchaseForm = this.purchaseServiceForm.getRawValue();
                    const model = this.returnPurchaseAuthorizationsPayloadFn(purchaseForm);

                    this.handlePromiseFnInSavePurchaseAuthFn(model, url, isSendForApproval);    
        
    }
    // Assosiated to savePurchaseAuth method
    private handlePromiseFnInSavePurchaseAuthFn(model: any, url: string, isSendForApproval: any) {
        const promise = this.singlePurchaseAuthorization && this.singlePurchaseAuthorization.authorization_id ?
            this._commonHttpService.updateWithoutid(model, url) : this._commonHttpService.create(model, url);
        promise.subscribe((response) => {
            if (!response) {
                this.sendPurchase = false;
                this.savePurchase = false;
            }
            this.savePurchase = false;
            this.isExceed = response.UserToken.isexceed;
            // (<any>$('#Edit-newreferredservice')).modal('hide');
            this.getList();
            // Start D-06715
            if (this.isExceed === 3) {
                if (isSendForApproval) {
                    (<any>$(this.purchaseauthpopupid)).modal('hide');
                    (<any>$(this.purchaseauthlistpopupid)).modal('show');
                }
                this._alertService.success('Purchase Authorization request saved successfully');
                this.authId = response.UserToken.authorization_id;
                this.getList(1);
                this.openpurchaseautherization(this.referredService);
                this.enableSaveServiceLog = false;
                this.resetForm = true;
            } else if (this.isExceed === 2) {
                this.sendPurchase = false;
                this.referredService = this.referredServiceCP;
                this._alertService.error(`Insufficient Client Account balance, please raise a request at lower cost`);
                this.sendApprovalEnable = false;
                this.resetForm = false;
                this.openpurchaseautherization(this.referredServiceCP, 'Edit');
            } else if (this.isExceed === 1) {
                this.sendPurchase = false;
                this.referredService = this.referredServiceCP;
                this._alertService.error(`Account is not available, kindly please add account for the selected client`);
                this.sendApprovalEnable = false;
                this.resetForm = false;
                this.openpurchaseautherization(this.referredServiceCP, 'Edit');
            } else if (this.isExceed === 4) {
                this.sendPurchase = false;
                this.referredService = this.referredServiceCP;
                this._alertService.error(`Requested purchase authorization is already available on the selected date`);
                this.sendApprovalEnable = false;
                this.resetForm = false;
                this.openpurchaseautherization(this.referredServiceCP, 'Edit');
            } else if (this.isExceed === 5) {
                this.sendPurchase = false;
                this.referredService = this.referredServiceCP;
                this._alertService.error(`Finanl Disbursement is inprogress for the selected client`);
                this.sendApprovalEnable = false;
                this.resetForm = false;
                this.openpurchaseautherization(this.referredServiceCP, 'Edit');
            }
            // End D-06715
        },
            (error) => {
                this.sendPurchase = false;
                this.savePurchase = false;
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }
    // Assosiated to savePurchaseAuth method
    private handleAllFiscalCodeConditionsFn(isSendForApproval: any) {
        if (+this.purchaseServiceForm.get('costnottoexceed')?.value <= 0) {
            this._alertService.error(`The amount should be greater than '$0.00' to proceed further`);
            this.savePurchase = false;
            return false;
        }

        const yearCheck1: any = this.purchaseServiceForm.value.startDt ? Number(moment(this.purchaseServiceForm.value.startDt).format('YYYY')) : null;
        const yearCheck2: any = this.purchaseServiceForm.value.endDt ? Number(moment(this.purchaseServiceForm.value.endDt).format('YYYY')) : null;
        
        if(yearCheck1 > 9999 || yearCheck2 > 9999) {
            this._alertService.warn('Please enter valid date');
            return false;                
        }

        let age = 0;
        let ageLimitCheck;
        const purchaseDate = moment(this.purchaseServiceForm.get('endDt')?.value);
        const startDate5121 = moment(new Date(this.purchaseServiceForm.get('startDt')?.value)).format(this.dtformat1);
        const endDate5121 = moment(new Date(this.purchaseServiceForm.get('endDt')?.value)).format(this.dtformat1);
        const fiscalcodevalue = this.purchaseServiceForm.get('fiscalCode')?.value;
        const fiscalCodesDate  = this.fiscalCodes.filter(
            users => users.fiscalcateforycd === fiscalcodevalue
        );

        if(fiscalcodevalue === '7108' && this.uploadedFile.length < 2 && isSendForApproval ) {
            this._alertService.error(`Two Attachments are Required`);
            this.savePurchase = false;
            this.sendApprovalEnable = false;
            return false;
        }
        
        if (this.clientDob && moment(new Date(this.clientDob), this.dtformat, true).isValid()) {
            const pDob = moment(new Date(this.clientDob), this.dtformat).toDate();
            age = Number(this.clientAge.split('Yrs')[0]);
            ageLimitCheck = purchaseDate.diff(pDob, 'years');
            if (age == 0) {
                age = purchaseDate.diff(pDob, 'years');
            }

            if(!this.checkAllFCConditionsFn(age, fiscalCodesDate, startDate5121, endDate5121,ageLimitCheck,pDob, isSendForApproval)) {
                return false;
            }

        }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private checkAllFCConditionsFn(age: any, fiscalCodesDate: any, startDate5121: any, endDate5121: any, ageLimitCheck: any, pDob: any, isSendForApproval: any) {
        if(!this.handleFiscalcode_2127_7127_Fn(age)) {
            return false;
        }

        if(!this.handleFiscalcode_4184_Fn(fiscalCodesDate, startDate5121, endDate5121)) {
            return false;
        }

        if(!this.handleFiscalcode_4185_Fn(age, fiscalCodesDate, startDate5121, endDate5121)) {
            return false;
        }

        if(!this.handleFiscalcode_5121_Fn(ageLimitCheck, fiscalCodesDate, startDate5121, endDate5121, pDob)) {
            return false;
        }

        if(!this.handleFiscalcode_4180_Fn(ageLimitCheck, fiscalCodesDate, startDate5121, endDate5121, pDob)) {
            return false;
        }

        if(!this.handleFiscalcode_4170_Fn(fiscalCodesDate, startDate5121, endDate5121)) {
            return false;
        }

        if(!this.handleFiscalcode_4181_Fn(fiscalCodesDate, startDate5121, endDate5121)) {
            return false;
        }

        if(!this.handleFiscalcode_11333_11334_Fn(age)) {
            return false;
        }

        if(!this.handleFiscalcode_5113_5114_5115_5116_5117_5118_7110_2110_4180_Fn(age, isSendForApproval)) {
            return false;
        }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private handleFiscalcode_5113_5114_5115_5116_5117_5118_7110_2110_4180_Fn(age: any, isSendForApproval: any) {
        if (this.purchaseServiceForm.get('fiscalCode')?.value === '5113') {
            if (age < 14 || age > 18) {
            this._alertService.error(this.invalidfiscalcodemsg);
            this.savePurchase = false;
            return false;
            }
        } else if (this.purchaseServiceForm.get('fiscalCode')?.value === '5114' ||
                   this.purchaseServiceForm.get('fiscalCode')?.value === '5115') {
            if (age < 18 || age > 21) {
                this._alertService.error(this.invalidfiscalcodemsg);
                this.savePurchase = false;
                return false;
            }
        } else if (this.purchaseServiceForm.get('fiscalCode')?.value === '5116') {
            if (age < 18) {
                this._alertService.error(this.invalidfiscalcodemsg);
                this.savePurchase = false;
                return false;
              }
          } else {
              if(!this.handleFiscalcode_5113_5114_5115_5116_5117_5118_7110_2110_4180_CondFn(age, isSendForApproval)) {
                  return false;
              }
          }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private handleFiscalcode_5113_5114_5115_5116_5117_5118_7110_2110_4180_CondFn(age: any, isSendForApproval: any) {
        if (this.purchaseServiceForm.get('fiscalCode')?.value === '5117') {
            if (age < 18 || age > 21) {
                this._alertService.error(this.invalidfiscalcodemsg);
                this.savePurchase = false;
                return false;
            }
        } else if (this.purchaseServiceForm.get('fiscalCode')?.value === '5118') {
            if (age < 16 || age > 21) {
                this._alertService.error(this.invalidfiscalcodemsg);
                this.savePurchase = false;
                return false;
            }
        } else if (this.return_If_7110_2110_Fn()) {
            if (+this.purchaseServiceForm.value.costnottoexceed > 2000) {
                this._alertService.error('Selected Fiscal Category will be not allowed if the amount is more than $2000.00');
                this.savePurchase = false;
                return false;
            }
        } else if (this.purchaseServiceForm.get('fiscalCode')?.value === '4180') {
           if  (this.returnDateofPreApprovalFn()) {
             this._alertService.error('Date of Pre-Approval by CfE Steering Committee is required');
             this.savePurchase = false;
             return false;
           } else if (this.checkUploadedFileAndSendForApprovalFn(isSendForApproval)) {
            this._alertService.error('Attachement with CfE Site Expenditure Proposal category is required');
            this.savePurchase = false;
            return false;
           }      
        }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private checkUploadedFileAndSendForApprovalFn(isSendForApproval: any) {
        return !this.uploadedFile.length && isSendForApproval;
    }
    // Assosiated to savePurchaseAuth method
    private return_If_7110_2110_Fn() {
        return this.purchaseServiceForm.get('fiscalCode')?.value === '7110' || this.purchaseServiceForm.get('fiscalCode')?.value === '2110';
    }
    // Assosiated to savePurchaseAuth method
    private returnDateofPreApprovalFn() {
        return (this.purchaseServiceForm.get('dateofPreApproval')?.value == null || this.purchaseServiceForm.get('dateofPreApproval')?.value == '');
    }
    // Assosiated to savePurchaseAuth method
    private handleFiscalcode_11333_11334_Fn(age: any) {
        if (this.referredServiceCP.service_id === 11333) {
            if(!this.handle_11333_CondFn(age)) {
                return false
            }
        } else if (this.referredServiceCP.service_id === 11334) {
            if(!this.handle_11334_CondFn(age)) {
                return false
            }
        }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private handle_11333_CondFn(age: any) {
        if (age <= 5) {
            if (+this.purchaseServiceForm.get('costnottoexceed')?.value > 60) {
                this._alertService.error(`The amount should be less than '$60.00' for Initial Clothing Allowance service`);
                this.savePurchase = false;
                return false;
            }
        } else if ( age > 5 && age <= 11) {
            if (+this.purchaseServiceForm.get('costnottoexceed')?.value > 75) {
                this._alertService.error(`The amount should be less than '$75.00' for Initial Clothing Allowance service`);
                this.savePurchase = false;
                return false;
            }
        } else {
            if (+this.purchaseServiceForm.get('costnottoexceed')?.value > 100) {
                this._alertService.error(`The amount should be less than '$100.00' for Initial Clothing Allowance service`);
                this.savePurchase = false;
                return false;
            }
        }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private handle_11334_CondFn(age: any) {
        if (age > 11) {
            if (+this.purchaseServiceForm.get('costnottoexceed')?.value > 75) {
                this._alertService.error(`The amount should be greater than '$75.00' for (Monthly Clothing Allowance service`);
                this.savePurchase = false;
                return false;
            }
        } else {
            if (+this.purchaseServiceForm.get('costnottoexceed')?.value > 60) {
                this._alertService.error(`The amount should be greater than '$60.00' for (Monthly Clothing Allowance service`);
                this.savePurchase = false;
                return false;
            }
        }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private handleFiscalcode_4181_Fn(fiscalCodesDate: any, startDate5121: any, endDate5121: any) {
        if (this.purchaseServiceForm.get('fiscalCode')?.value === '4181') {
            const { time1, time2 } = this.returnStartAndEndDateFn(fiscalCodesDate);
            if  (this.purchaseServiceForm.get('cfeCareDuration')?.value == null || this.purchaseServiceForm.get('cfeCareDuration')?.value == '' ) {
                this._alertService.error('Cfe Care Duration is required');
                this.savePurchase = false;
                return false;
              } 
            if (startDate5121 < time1 || startDate5121 > time2 || endDate5121 < time1 || endDate5121 > time2) {
                this._alertService.error(`The time frame for use of these funds (4181): May 15, 2022, thru September 30, 2023`);
                this.savePurchase = false;
                return false;
            }
            
        }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private handleFiscalcode_4170_Fn(fiscalCodesDate: any, startDate5121: any, endDate5121: any) {
        if (this.purchaseServiceForm.get('fiscalCode')?.value === '4170') {
            const { time1, time2 } = this.returnStartAndEndDateFn(fiscalCodesDate);
            // B-108432 date changes
            if (startDate5121 < time1 || startDate5121 >= time2 || endDate5121 < time1 || endDate5121 >= time2) {
                this._alertService.error(`The time frame for use of these funds (4170): Oct 1, 2020, thru September 30, 2022 Funds must be disbursed by Dec 30, 2022`);
                this.savePurchase = false;
                return false;
            }
        }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private handleFiscalcode_4180_Fn(ageLimitCheck: any, fiscalCodesDate: any, startDate5121: any, endDate5121: any, pDob: any) {
        if (this.purchaseServiceForm.get('fiscalCode')?.value === '4180') {
            const { time1, time2 } = this.returnStartAndEndDateFn(fiscalCodesDate);
            // B-107372 date changes
            this.ageCalculation(pDob, '4','21' );
            if (startDate5121 < time1 || startDate5121 >= time2 || endDate5121 < time1 || endDate5121 >= time2) {
                this._alertService.error(`The time frame for use of these funds (4180): October 1, 2020, thru September 30, 2023 only`);
                this.savePurchase = false;
                this.sendPurchase = false;
                return false;
            }
            if ((ageLimitCheck < 4) || ((ageLimitCheck <= 4) && (startDate5121 < this.minAgeForfiscalCode)) || ((ageLimitCheck >= 21) && (endDate5121 > this.maxAgeForFiscalCode)) || (ageLimitCheck > 21)) {
                this._alertService.error(`Fiscal Category Code: Title IV-B, Center for Excellence is available for age group 4 to 21`);
                this.savePurchase = false;
                this.sendPurchase = false;
                return false;
            }
            this.validateTotalAmountPerFiscalYear(startDate5121);
            if(this.purchaseServiceForm.get('costnottoexceed')?.value > 50000) {
                this._alertService.error('Maximum limit has been reached for this fiscal year ');
                this.savePurchase = false;
                this.sendPurchase = false;
                return false;   
            } 
        }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private handleFiscalcode_5121_Fn(ageLimitCheck: any, fiscalCodesDate: any, startDate5121: any, endDate5121: any, pDob: any) {
        if (this.purchaseServiceForm.get('fiscalCode')?.value === '5121') {
            const { time1, time2 } = this.returnStartAndEndDateFn(fiscalCodesDate);
            // B-107372 date changes
            this.ageCalculation(pDob, '4','14' );
            if (startDate5121 < time1 || startDate5121 > time2 || endDate5121 < time1 || endDate5121 > time2) {
                this._alertService.error(`The time frame for use of these funds (5121): April 1, 2020, thru September 30, 2021 only`);
                this.savePurchase = false;
                return false;
            }
            if ((ageLimitCheck < 14) || ((ageLimitCheck <= 14) && (startDate5121 < this.minAgeForfiscalCode)) || ((ageLimitCheck >= 26) && (endDate5121 > this.maxAgeForFiscalCode)) || (ageLimitCheck > 26)) {
                this._alertService.error(`Fiscal Category Code: Chafee Independent Living is available for age group 14 to 26`);
                this.savePurchase = false;
                return false;
            }
        }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private handleFiscalcode_4185_Fn(age: any, fiscalCodesDate: any, startDate5121: any, endDate5121: any) {
        if (this.purchaseServiceForm.get('fiscalCode')?.value === '4185') {
            const { time1, time2 } = this.returnStartAndEndDateFn(fiscalCodesDate);
            if (startDate5121 < time1 || startDate5121 > time2 || endDate5121 < time1 || endDate5121 > time2) {
                this._alertService.error(`The time frame for use of these funds (4185): October 1, 2021, thru September 30, 2023 only`);
                this.savePurchase = false;
                return false;
            }
            if (age <= 11) {
                if (+this.purchaseServiceForm.get('costnottoexceed')?.value > 1237) {
                    this._alertService.error(`The amount cannot exceed '1237' for ages 11 and less`);
                    this.savePurchase = false;
                    return false;
                }
            } else if ( age > 11) {
                if (+this.purchaseServiceForm.get('costnottoexceed')?.value > 1252) {
                    this._alertService.error(`The amount cannot exceed '1252' for ages 12 and more`);
                    this.savePurchase = false;
                    return false;
                }
            } 
        }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private handleFiscalcode_4184_Fn(fiscalCodesDate: any, startDate5121: any, endDate5121: any) {
        if (this.purchaseServiceForm.get('fiscalCode')?.value === '4184') {
            const { time1, time2 } = this.returnStartAndEndDateFn(fiscalCodesDate);
            //assuming that start date and end date for fiscalcode 4184 will retrieve from same fields as 5121
            if (startDate5121 < time1 || startDate5121 > time2 || endDate5121 < time1 || endDate5121 > time2) {
                this._alertService.error(`The time frame for use of these funds (4184): October 1, 2021, thru September 30, 2023 only`);
                this.savePurchase = false;
                return false;
            }
        }
        return true
    }
    // Assosiated to savePurchaseAuth method
    private handleFiscalcode_2127_7127_Fn(age: any) {
        if (this.validateCondition_2127_7127_Fn()) {
            // if (age <= 5) {
            //     if (+this.purchaseServiceForm.get('costnottoexceed')?.value > 60) {
            //         this._alertService.error(`The amount cannot exceed '$60.00' for ages 5 and less`);
            //         this.savePurchase = false;
            //         return false;
            //     }
            // } else 
            if ( age > 5 && age <= 11) {
                if (+this.purchaseServiceForm.get('costnottoexceed')?.value > 75) {
                    this._alertService.error(`The amount cannot exceed '$75.00' for ages is between 6 and 11`);
                    this.savePurchase = false;
                    return false;
                }
            } else if ( age >= 12) {
                if (+this.purchaseServiceForm.get('costnottoexceed')?.value > 100) {
                    this._alertService.error(`The amount cannot exceed '$100.00' for ages 12 and more`);
                    this.savePurchase = false;
                    return false;
                }
            } else {
                if (+this.purchaseServiceForm.get('costnottoexceed')?.value > 60) {
                    this._alertService.error(`The amount cannot exceed '$60.00' for ages 5 and less`);
                    this.savePurchase = false;
                    return false;
                }
            }
        }
        return true;
    }
    // Assosiated to savePurchaseAuth method
    private validateCondition_2127_7127_Fn() {
        return this.purchaseServiceForm.get('fiscalCode')?.value === '2127' || this.purchaseServiceForm.get('fiscalCode')?.value === '7127';
    }
    // Assosiated to savePurchaseAuth method
    private returnPurchaseAuthorizationsPayloadFn(purchaseForm: any) {
        return {
            'fiscalCategoryCd': this.purchaseServiceForm.value.fiscalCode,
            'voucherSw': this.purchaseServiceForm.value.voucherRequested,
            'justificationTx': this.purchaseServiceForm.value.justificationCode,
            'costNo': purchaseForm.costnottoexceed ? purchaseForm.costnottoexceed : '0.00',
            'startDt': moment(this.purchaseServiceForm.value.startDt).format(),
            'endDt': moment(this.purchaseServiceForm.value.endDt).format(),
            'dateofPreApproval': this.purchaseServiceForm.value.fiscalCode === '4180' ? moment(this.purchaseServiceForm.value.dateofPreApproval).format() : null,
            'cfecareduration': this.purchaseServiceForm.value.fiscalCode === '4181' ? this.purchaseServiceForm.value.cfeCareDuration : null,
            'assignedtoid': this.purchaseServiceForm.value.supervisorid ? this.purchaseServiceForm.value.supervisorid : null,
            // D-06581
            'daNumber': this.daNumber,
            'serviceLogId': this.referredService.service_log_id,
            'authorizationId': (this.singlePurchaseAuthorization && this.singlePurchaseAuthorization.authorization_id) ? this.singlePurchaseAuthorization.authorization_id : null,
            'client_id': this.rcCjamsID,
            'bmanualrouting': this.otherCase
        };
    }
    // Assosiated to savePurchaseAuth method
    private returnStartAndEndDateFn(fiscalCodesDate: any[]) {
        const time1 = moment(fiscalCodesDate[0].start_dt).format(this.dtformat1);
        const time2 = moment(fiscalCodesDate[0].end_dt).format(this.dtformat1);
        return { time1, time2 };
    }
    // Assosiated to savePurchaseAuth method
    private checkFiscalCodeFn() {
        if(this.purchaseServiceForm.get('fiscalCode')?.value === '7112' || this.purchaseServiceForm.get('fiscalCode')?.value === '7111' ){
            const ageatstartdate = (this.purchaseServiceForm.get('startDt')?.value);
            const ageatenddate = (this.purchaseServiceForm.get('endDt')?.value);
            const pDob = moment(new Date(this.clientDob), this.dtformat).toDate();
            if((this.calculateage(pDob,ageatstartdate)>=14) && (this.calculateage(pDob,ageatenddate) <=21)){
            this.savePurchase = true;
           } else { 
          
             this.savePurchase = false;
             this._alertService.warn('Age should be between 14 to 21 at the time of availing the service');
            return false;  
           }                 
        }
        if (this.purchaseServiceForm.get('fiscalCode')?.hasError('required')) {
            this._alertService.warn('Please select Fiscal category code!');
            this.savePurchase = false;
            return false;
        } else if (this.purchaseServiceForm.get('voucherRequested')?.hasError('required')) {
            this._alertService.warn('Please select Voucher requested!');
            this.savePurchase = false;
            return false;
        }
        return true;
    }

    ageCalculation(dob: any, minage: any, maxage: any){
        const getYearOfdob = Number (moment(dob).format('YYYY'));
        const monthDateOfdob = moment(dob).format('MM/DD');

        this.minAgeForfiscalCode = monthDateOfdob + getYearOfdob;
        const getMinYear = Number(getYearOfdob) + Number(minage);
        const getMaxYear = Number(getYearOfdob) + Number(maxage);
        this.minAgeForfiscalCode = monthDateOfdob + '/' + getMinYear;
        this.maxAgeForFiscalCode = monthDateOfdob + '/' + getMaxYear;
    }

    onServiceSorted($event: ColumnSortedEvent) {
            this.listPageInfo.sortBy = $event.sortDirection;
            this.listPageInfo.sortColumn = $event.sortColumn;
            this.getList();
    }

    sendForApproval(purchaseServiceFormData: any) {
        if(this.purchaseServiceForm.valid) {
            (<any>$('#li-fiscal')).removeClass('active');
            (<any>$('#li-supervisor')).removeClass('active');
            // (<any>$(`#li-supervisor`)).addClass('active');
            this.sendPurchase = true;
            this.financeApproval = true;
            const purchaseServiceForm = this.purchaseServiceForm.getRawValue();
            this.getSupervisorID = purchaseServiceForm.supervisorid ? purchaseServiceForm.supervisorid : null;
            if (this.isSupervisor) {
                if ((purchaseServiceForm.costnottoexceed >= 1000 || this.singlePurchaseAuthorization?.fiscal_category_cd.trim() === '7502'
                        || this.singlePurchaseAuthorization?.fiscal_category_cd.trim() === '7503') && this.singlePurchaseAuthorization?.fiscal_category_cd.trim() !== '7108') {
                    this.getRoutingUser();
                    this.status = 42;
                } else if (this.singlePurchaseAuthorization?.fiscal_category_cd.trim() === '7108')  {
                    this.status = 40;
                    this.eventCode = 'PCAUTHR'
                    this.appEventCheck = true;
                    this.authorizationCheck = purchaseServiceForm.authorization_id;
                    this.getRoutingUser();            
                } else {
                    this.status = 40;
                    this.getRoutingUser();
                }
            } else {
                    this.sendApprovalEnable = true;
                    this.sendPurchase = false;
                    this.savePurchaseAuth(purchaseServiceForm, true);
            }
        }
        else {
            this.purchaseServiceForm.markAllAsTouched();
            this._alertService.warn(this.mandatorymsg);
        }
    }
    // removed private for prod mode
    assignUser() {
        if (this.singlePurchaseAuthorization?.fiscal_category_cd === '7108') {
            this.eventCode = 'PCAUTHR';
        }
        this.assign = true;
        this._commonHttpService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.ServiceLogApproval;
            const modal = {
                'case_id': this.daNumber,
                'bmanualrouting': this.otherCase,
                'fiscalcategorycd' : this.singlePurchaseAuthorization?.fiscal_category_cd,
                'costno' : this.singlePurchaseAuthorization?.cost_no ? this.singlePurchaseAuthorization.cost_no : '0.00',
                'authorization_id' : this.singlePurchaseAuthorization?.authorization_id,
                'provider_id' : this.referredService.provider_id,
                'intakeserviceid' : this.id,
                'assignedtoid' : this.assignedTo ? this.assignedTo : null,
                'eventcode' : this.eventCode ? this.eventCode : 'PCAUTH',
                'status' : this.status,
                'startDt' : this.singlePurchaseAuthorization?.startdt,
                'endDt' : this.singlePurchaseAuthorization?.enddt,
                'client_account_id': this.singlePurchaseAuthorization?.client_account_id ? this.singlePurchaseAuthorization.client_account_id : 0,
                'roletypekey': this.roletypekey ? this.roletypekey : null,
                'v_securityusersid': this.token.user.userprofile.securityusersid
             //   'assignedToPM': this.assignedToPM
                // 'paymentstatus' : this.singlePurchaseAuthorization.paymentstatus
            };
        this._commonHttpService.create(modal).subscribe(
            (response) => {
                this.assign = false;
                this._alertService.success('Approval sent successfully!');
                (<any>$('#payment-approval')).modal('hide');
                (<any>$(this.purchaseauthlistpopupid)).modal('show');
                this.openpurchaseautherization(this.referredService);
                this.getList(1);
            },
            (error) => {
                this.assign = false;
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );

      }

      servicelogDocumentGenerate(service_log_id: any) {
        const modal = {
          count: -1,
          where: {
              documenttemplatekey: ['servicepurchaseauthorizations'],
              service_log_id: service_log_id,
              roletypekey: this.roletype ? this.roletype : null,
              daNumber: this.daNumber, 
              clientid: this.rcCjamsID
          },
          method: 'post'
        };
        this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
      .subscribe(res => {
        const blob = new Blob([new Uint8Array(res)]);
        const link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        const timestamp = moment(this.timestamp).format('MM/DD/YYYY HH:mm:ss');
        link.download = 'Service-Purchase-authorization-Forms-' + service_log_id + '.' + timestamp + '.pdf';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
      });
    }

      documentGenerate(authorization_id: any, status: any) {
          if (status === 'Approved') {
            this.isapproved = true;
          } else {
              this.isapproved = false;
          }
          const modal = {
            count: -1,
            where: {
                documenttemplatekey: ['purchaseauthorization'],
                authorizationid: authorization_id,
                isapproved: this.isapproved,
                status: status
            },
            method: 'post'
          };
          this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
        .subscribe(res => {
          const blob = new Blob([new Uint8Array(res)]);
          const link = document.createElement('a');
          link.href = window.URL.createObjectURL(blob);
          const timestamp = moment(this.timestamp).format('MM/DD/YYYY HH:mm:ss');
          link.download = 'Purchase-authorization-Form-' + authorization_id + '.' + timestamp + '.pdf';
          document.body.appendChild(link);
          link.click();
          document.body.removeChild(link);
        });
      }

      selectPerson(row: any) {
        if (row) {
          this.assign = false;
          this.selectedPerson = row;
          this.assignedTo = row.userid;
        }
      }

      getRoutingUser() {
        (<any>$(this.purchaseauthpopupid)).modal('hide');
        (<any>$('#payment-approval')).modal('show');
        const appEvent = this.appEventCheck ? 'PCAUTHR' : 'PCAUTH';
        const authorizationID = this.appEventCheck ? this.authorizationCheck : null;
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: appEvent, authId: authorizationID},
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe((result) => {
                this.financeApproval = false;
                this.getUsersList = result.data;
                this.originalUserList = this.getUsersList;

                this.listUser(this.returnAssignedForSelectedTabFn());
            });
     }
     // Assosiated to getRoutingUser method
     private returnAssignedForSelectedTabFn(): string {
        if (this.selectedTab === 'Fiscal Worker') {
            return 'ASSIGNEDCW';
        }
        if (this.selectedTab === 'Fiscal Supervisor') {
            return 'ASSIGNEDSP';
        }
        return 'TOBEASSIGNED';
     }

     uploadclosed(event: any){
        if(event){
            this.documentuploaded.closeupload();
        }
      }

     enableUserRole(type: any) {
         if (type === 'user') {
            this.assign = true;
            this.roleBased = false;
            this.eventCode = 'PCAUTH';
            if (!this.programManagerApproval) {
            this.roletypekey = null;
            } else {
            this.roletypekey = this.role;
            }
         } else {
            this.assign = false;
            this.roleBased = true;
            this.assignedTo = null;
            this.eventCode = 'PCAUTHR';
            if (!this.programManagerApproval) {
            this.roletypekey = 'FNS' + this.role;
            } else {
                this.roletypekey =  this.role;
            }
         }
     }

     getAssignmentsList() {
       this._commonHttpService.getArrayList(
            {
                where: { servicecaseid: this.id },
                method: 'get'
            },
            'Caseassignments/getworkload?filter'
        ).subscribe(data => {
            if (data) {
                this.assignmentListData = data;
                 const fam = data.filter(item => String(item.enddate == null));
                 const childCategory = this.county_codes.find(category => category === fam[0].countyid);
             if (childCategory) {
                this.displayfiscalcategoryCode4180 = true;
                this.displayfiscalcategoryCode4184 = true;
                return;
              }
            }
        });
    }


    validateTotalAmountPerFiscalYear(date4: any) {
        this._commonHttpService.getArrayList(
             {
                 where: { startDate: date4 },
                 method: 'get'
             },
             'purchaseAuthorizations/validatefiscalyearamount' + '?filter'
         ).subscribe(data => {
             if (data) {
                if(data[0].coalesce > '50000.00') {
                   this._alertService.error('Maximum limit has been reached for this fiscal year ');
                   this.savePurchase = false;
                   return true;   
                } 
             }
         });
     }
 

     loadSupervisor() {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'CWIF'
                    // teamid: this.token.user.userprofile.teammemberassignment.teammember.teamid
                },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe(result => {
                this.supervisorsList = result.data;
                this.supervisorsList = this.supervisorsList.filter(
                    users => users.rolecode === 'SP'
                );
                const supervisorid = this.singlePurchaseAuthorization?.supervisorid;
                const reviewer = this.defaultSupervisor;
                let selectedSupervisor = {userid:""};   // NOSONAR      // Assinging empty user id object to variable.
                if(supervisorid) {
                selectedSupervisor = this.supervisorsList.find(user => user.userid === supervisorid);

                } else{
                    selectedSupervisor = this.supervisorsList.find(user => user.username === reviewer);
                }
                if (selectedSupervisor) {
                    this.purchaseServiceForm.patchValue({supervisorid: selectedSupervisor?.userid });
                }
            });
    }

    
    changeSupervisor($event: any) {
        if ($event && $event.value) {
            this.purchaseServiceForm.patchValue({supervisorid: $event.value});
        }
    }

    cfechange($event: any) {
        let maxAmount  = null; 
        if ($event) {
            switch ($event) {
                case '110':
                    maxAmount = '50'
                    break;   
                case '111':
                    maxAmount = '100'
                    break;
                case '112':
                    maxAmount = '150'
                    break; 
                case '113':
                    maxAmount = '200'
                    break;   
                case '114':
                    maxAmount = '250'
                    break;
                case '115':
                    maxAmount = '300'
                    break;  
                case '116':
                    maxAmount = '350'
                    break;
                case '117':
                    maxAmount = '400'
                    break; 
                case '118':
                    maxAmount = '450'
                    break;   
                case '119':
                    maxAmount = '500'
                    break;
                case '120':
                    maxAmount = '550'
                    break; 
                case '121':
                    maxAmount = '600'
                    break; 
                case '122':
                    maxAmount = '30'
                    break;                                                
            }
          
        }
        if (maxAmount) {
            this.purchaseServiceForm.patchValue({costnottoexceed: maxAmount}); 
            this.purchaseServiceForm.get('costnottoexceed')?.disable();  
        }
    }

     listUser(assigned: string) {
      this.userRole = 'role';
      this.selectedPerson = '';
      this.getUsersList = [];
      this.rolename.set('role')
      this.role = null;
      this.getUsersList = this.originalUserList;
        if (assigned === 'TOBEASSIGNED') {
          this.getUsersList = this.returnUserListIfToBeAssignedFn();
    } else {
            this.getUsersList = this.returnUserListIfNotToBeAssignedFn(assigned);
        }
        this.enableUserRole('role');
      }
      // Assosiated to listuser method
    private returnUserListIfNotToBeAssignedFn(assigned:string): any[] {
        return this.getUsersList.filter((res) => {
            if (res.resourcename) {
                const isFW = res.resourcename.includes('manage_funding_approval');
                if (res.rolecode === 'FW' && isFW === true && assigned === 'ASSIGNEDCW') {
                    this.role = res.rolecode;
                    this.rolename.set('Fiscal Workers')
                    return res;
                }
                else if(res.rolecode === 'FS' && isFW === true && assigned === 'ASSIGNEDSP'){
                    this.role = res.rolecode;
                    this.rolename.set('Fiscal Supervisor')
                    return res;
                } 
                else {
                    if (!this.role) {
                        this.rolename.set(null);
                    }
                }
            }
        });
    }
    // Assosiated to listuser method
    private returnUserListIfToBeAssignedFn(): any[] {
        return this.getUsersList.filter((res) => {
            if (!res.resourcename) {
                return;
            }
                if (this.returnUserListIfToBeAssignedCond1Fn()) {
                    const isDF = res.resourcename.includes('manage_over1000_approval');
                    if (res.rolecode === 'DF' || isDF === true) {
                        return this.returnResIfDFFn(res);
                    } else {
                        this.reusableConFn();
                    }
                } else if (this.returnCostno_1000_to_5000_Fn()) {
                    const isPM = res.resourcename.includes('bc_approval_manage_over1000');
                    if (isPM === true) {
                        return this.returnResIfPMFn(res);
                    } else {
                        this.reusableConFn();
                    }
                } else {
                    const isFS = res.resourcename.includes('manage_payment_approval');
                    if (this.returnIfFSOrIVESVFn(res, isFS)) {
                        return this.returnResIfFSFn(res);
                    } else {
                        this.reusableConFn();
                    }
                }
            // }
        });
    }
    // Assosiated to listuser method
    private returnIfFSOrIVESVFn(res: any, isFS: any) {
        return (res.rolecode === 'FS' || res.rolecode === 'IVESV') && isFS === true;
    }
    // Assosiated to listuser method
    private returnCostno_1000_to_5000_Fn() {
        return this.singlePurchaseAuthorization?.cost_no && (+this.singlePurchaseAuthorization?.cost_no >= 1000 && +this.singlePurchaseAuthorization?.cost_no < 5000 &&
            this.isBaltimoreCityUser);
    }
    // Assosiated to listuser method
    private returnResIfFSFn(res: any) {
        this.role = res.rolecode;
        this.rolename.set('Fiscal Supervisor')
        return res;
    }
    // Assosiated to listuser method
    private returnResIfDFFn(res: any) {
        this.role = 'DF';
        this.rolename.set('LDSS Directors');
        return res;
    }
    // Assosiated to listuser method
    private returnResIfPMFn(res: any) {
        this.role = 'LDSSPM';
         this.rolename.set('Program Managers');
        return res;
    }

    // Assosiated to listuser method
    private reusableConFn() {
        if (!this.role) {
            this.rolename.set(null);
        }
    }
    // Assosiated to listuser method
    private returnUserListIfToBeAssignedCond1Fn() {
        return ((((this.singlePurchaseAuthorization?.cost_no && +this.singlePurchaseAuthorization?.cost_no >= 1000) || this.singlePurchaseAuthorization?.fiscal_category_cd.trim() === '7502'
            || this.singlePurchaseAuthorization?.fiscal_category_cd.trim() === '7503') && !this.isBaltimoreCityUser) ||
            ((this.singlePurchaseAuthorization?.cost_no && +this.singlePurchaseAuthorization?.cost_no >= 5000 || this.singlePurchaseAuthorization?.fiscal_category_cd.trim() === '7502'
                || this.singlePurchaseAuthorization?.fiscal_category_cd.trim() === '7503') && this.isBaltimoreCityUser));
    }

      confirmReject() {
          this.reason_tx = '';
      }
      confirmReturn() {
          this.return_tx = '';
      }

      rejectApproval() {
          this.rejectApprove = true;
          this._commonHttpService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.PurchaseAuthorizationReject + this.authId;
          const modal = {
            'case_id': this.daNumber,
              reason_tx : this.reason_tx
          };
          this._commonHttpService.create(modal).subscribe(
              (response) => {
                this.rejectApprove = true;
                this._alertService.success('Purchase Authorization Denied successfully');
                (<any>$('#reject-approval')).modal('hide');
                (<any>$(this.purchaseauthlistpopupid)).modal('show');
                this.getList(1);
                this.openpurchaseautherization(this.referredService);
              },
              (error) => {
                this.rejectApprove = true;
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
              });
      }
      returnApproval() {
        this.returnApprove = true;
        this._commonHttpService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.PurchaseAuthorizationReturn + this.authId;
        const modal = {
          'case_id': this.daNumber,
            return_tx : this.return_tx
        };
        this._commonHttpService.create(modal).subscribe(
            (response) => {            
                this.returnApprove = false;
                this._alertService.success('Purchase Authorization Returned to the worker successfully');
                (<any>$('#return-approval')).modal('hide');
                (<any>$(this.purchaseauthlistpopupid)).modal('show');
                this.getList(1);
                this.openpurchaseautherization(this.referredService);
            },
            (error) => {
              this.returnApprove = false;
              this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }

    getClientDropdown(programAreaId: any) {
        this.clientProgramNames = [];
        this._commonHttpService.getArrayList(
            {
            where: {intakeserviceid: this.id, person_id: this.personid},
            order: 'agency_program_nm',
            method: 'get'
          },
          CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.ClientProgramName + '?filter',

        ).subscribe(response => {
            // By Default Area program assignment has been mad disabled
            if (response && response.length) {
            this.clientProgramNames = [];
                    this.handleIfAlreadyExistFn(response);
                response = this.handleEnddateAndProgramAreaIdFn(response, programAreaId);
                this.handleClodesdateCondFn(response);
                this.getFiscalCategoryCode(this.clientprogramselection);
            } else {
                if(programAreaId) {
                  this.disbleService = true;
                  this.clientprogramselection = null;
                  this._alertService.warn('Please add required Program Service for the selected client');
                }
            }
        });
    }
    // Assosiated to getClientDropdown method
    private handleClodesdateCondFn(response: any[]) {
        if (this.closed_date && (!response[0].enddate || this.closed_date < response[0].enddate)) {
            this.enddate = this.closed_date;
        } else {
            this.enddate = response[0].enddate;
        }
        this.estimatedenddate = response[0].enddate;
        this.clientprogramselection = response[0].agency_program_area_id ? response[0].agency_program_area_id : null;
        this.handleIfReferredServiceFn(response);
        if (this.closed_date && (!this.estimatedenddate || this.closed_date < this.estimatedenddate)) {
            this.estimatedenddate = this.closed_date;
        }
    }
    // Assosiated to getClientDropdown method
    private handleIfReferredServiceFn(response: any[]) {
        if (this.referredService) {
            if (response[0].startdate && this.referredService.estbegindate > response[0].startdate) {
                this.startdate = this.referredService.estbegindate ? new Date(this.referredService.estbegindate) : response[0].startdate;
            }
            if (response[0].enddate && this.referredService.estimated_end_date > response[0].enddate) {
                this.estimatedenddate = this.referredService.estimated_end_date ? new Date(this.referredService.estimated_end_date) : response[0].enddate;
            }
        }
    }

    // Assosiated to getClientDropdown method
    private handleEnddateAndProgramAreaIdFn(response: any[], programAreaId: any) {
        const currDate = new Date();
        if (response[0].enddate) {
            if (new Date(response[0].enddate) < currDate) {
                this.disbleService = true;
                this._alertService.warn('Please add required Program Service for the selected client');
            } else {
                this.disbleService = false;
            }
        } else {
            this.disbleService = false;
        }
        if (programAreaId == null || programAreaId == undefined) {
            this.addNewReferredServiceSecondForm.patchValue({
                clientprogramnameid: response[0].agency_program_area_id ? response[0].agency_program_area_id : null
            });
            this.clientSubProgramNames = response[0].subprogram;
        } else {
            this.addNewReferredServiceSecondForm.patchValue({
                clientprogramnameid: programAreaId ? programAreaId : null
            });
            const clientProgram = this.clientProgramNames.filter(clientid => clientid.agency_program_area_id === programAreaId);
            this.clientSubProgramNames = clientProgram[0]['subprogram'];
            response = response.filter(resp => resp.agency_program_area_id === programAreaId);
        }
        this.startdate = response[0].startdate;
        return response;
    }

    private handleIfAlreadyExistFn(response: any[]) {
        response.forEach(program => {
            const alreadyExist = this.clientProgramNames.find(element => element.agencyprogramareaid === program.agencyprogramareaid);
            if (alreadyExist) {
                this.clientProgramNames.forEach(item => {
                    if (item.agencyprogramareaid === alreadyExist.agencyprogramareaid) {
                        item.subprogram = _.union(item.subprogram, program.subprogram);
                        item.subprogram = _.uniqWith(item.subprogram, _.isEqual);
                    }
                });
            } else {
                this.clientProgramNames.push(program);
            }

        });
    }

    changeClientProgram(clientProgramid: any) {
        const clientProgram = this.clientProgramNames.filter(clientid => clientid.agency_program_area_id === clientProgramid);
        this.clientSubProgramNames = clientProgram[0]['subprogram'];
        this.handleClientProgramidFn(clientProgramid);
        this.startdate = (clientProgram && clientProgram[0]) ? clientProgram[0].startdate : null;
        this.enddate = (clientProgram && clientProgram[0]) ? clientProgram[0].enddate : null;
        if (this.closed_date && (!this.enddate || this.closed_date < this.enddate)) {
            this.enddate = this.closed_date;
        }
        this.estimatedenddate = (clientProgram && clientProgram[0]) ? clientProgram[0].enddate : null;
        if (this.closed_date && (!this.estimatedenddate || this.closed_date < this.estimatedenddate)) {
            this.estimatedenddate = this.closed_date;
        }
        this.clientprogramselection = clientProgramid ? clientProgramid : null;
        this.getFiscalCategoryCode(this.clientprogramselection);
    }
    //Assosiated with changeClientProgram method
    private handleClientProgramidFn(clientProgramid: any) {
        if (clientProgramid === 'IHSFP' && this.clientSubProgramNames && Array.isArray(this.clientSubProgramNames) && this.clientSubProgramNames.length > 0) {
            this.addNewReferredServiceSecondForm.controls['clientsubprogramnameid'].setValidators([Validators.required]);
            this.addNewReferredServiceSecondForm.controls['clientsubprogramnameid'].updateValueAndValidity();
            this.isSubProgramMandatory = true;
        } else {
            this.addNewReferredServiceSecondForm.controls['clientsubprogramnameid'].clearValidators();
            this.addNewReferredServiceSecondForm.controls['clientsubprogramnameid'].updateValueAndValidity();
            this.isSubProgramMandatory = false;
        }
    }

    changeServiceEndReason(value: any) {
        if(value == '1821') {
            this.showEndReason = true;
        } else {
            this.showEndReason = false;
            this.showEndReasonNotes = false;
        }

    }

    changeSubEndReason(value: any) {
         if (value == '1840') {
            this.showEndReasonNotes = true;
        } else {
            this.showEndReasonNotes = false;
        }
   }

    onPurchaseAmount(val: Event) {
        const amount = (val.target as HTMLInputElement).value;
        if (!_.isNaN(_.toNumber(amount))) {
            this.purchaseServiceForm.patchValue ({
                costnottoexceed : _.toNumber(amount).toFixed(2)
            });
        }
    }

    checkDec(el: any) {
        if (el.target.value !== '') {
          el.target.value = el.target.value.replace(/[^0-9\d-/\/\\]/g, '');
          return el.target.value;
        }
        return '';
      }

    getFiscalCategoryCode(vendorprogramid: any) {
        const providerid = this.getProviderId ? this.getProviderId : null;
        if (!vendorprogramid) {
            return;
        }
        this._commonHttpService.getArrayList({
                where: {agencyprogramareaid: vendorprogramid, provideridCheck: providerid},
                method: 'get'
              }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.fiscalCodes + '?filter',
            ).subscribe( result => {
                this.fiscalCodes = result;
                const approvalcfe: any = result[0].approvalcfe ? result[0].approvalcfe : false ;
                // THIS RULE APPLICABLE FOR IV-E - Should not block service-log, Filter needs to be revisited
                // this.fiscalCodes = this.fiscalCodes.filter(item => item.eligibility_cd === this.clientEligibilityStatus);
                this.handleGetFiscalCategoryCodeServiceIdFn();
                if (vendorprogramid === 'OOH' && !this.livingArrangementTypeCheck && !('13041,13042,13043,13040'.includes(this.referredService?.service_id))) {
                    this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd !== '7108');
                }
                if (vendorprogramid === 'OOH'){
                    if(!this.isClosed){
                        this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd !== '7111');
                    } else {
                        this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd !== '7112');
                    }
                }
                this.validateFiscalcateforycdFn(approvalcfe);
            });
    }
    // Assosiated with getFiscalCategoryCode method
    private validateFiscalcateforycdFn(approvalcfe: any) {
        if (!this.cfeHomeResourceChild || !this.selectedCFEService) {
            this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd !== '4181');
        }
        if (!this.displayfiscalcategoryCode4180) {
            this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd !== '4180' && item.fiscalcateforycd !== '4181');
        }
        if (!this.displayfiscalcategoryCode4184) {
            this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd !== '4184' && item.fiscalcateforycd !== '4185');
        }
        if (!approvalcfe) {
            this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd !== '4185' && item.fiscalcateforycd !== '4184');
        }
    }
    // Assosiated with getFiscalCategoryCode method
    private handleGetFiscalCategoryCodeServiceIdFn() {
        if (this.referredService && this.referredService.service_id) {
            if (this.clientEligibilityStatus !== '2913') {
                this.fiscalCodes = this.fiscalCodes.filter(item => this.startsWith(item));
            }
            this.handleGetFiscalCategoryCodeServiceIdCondFn();
        }
    }
    // Assosiated with getFiscalCategoryCode method
    private handleGetFiscalCategoryCodeServiceIdCondFn() {
        if (this.referredService.service_id === 11333) {
            if (this.clientEligibilityStatus === '2913') {
                this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd === '2126');
            } else {
                this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd === '7126');
            }
        } else if (this.referredService.service_id === 11334) {
            if (this.clientEligibilityStatus === '2913') {
                this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd === '2127');
            } else {
                this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd === '7127');
            }
        } else if (!this.displayfiscalcategoryCode4180) {
            this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd !== '4180' && item.fiscalcateforycd !== '4185' && item.fiscalcateforycd !== '4181');
        } else {
            if (this.clientEligibilityStatus === '3951') {
                this.fiscalCodes = this.fiscalCodes.filter(item => item.fiscalcateforycd === '2126');
            }
        }
    }

    private VendorDropDown() {
       this.getClientDropdown(null);
        const source = forkJoin([
             this._commonHttpService.getArrayList({
                order: 'service_nm'
              },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.VendorServices ,

            ),
            this._commonHttpService.getArrayList({
                order: 'value_tx'
              }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.Frequency),
              this._commonHttpService.getArrayList({
                order: 'sort_order_no'
              }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.Duration),
            this._commonHttpService.getArrayList(
                {
                    order: 'service_end_reason'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.ServiceEndReason + this.accesstokenpath + this.token.id,
            ),
            this._commonHttpService.getArrayList(
                {
                    order: 'reason_service_not_received'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.ReasonServiceNotReceived + this.accesstokenpath + this.token.id,
            )
        ]).pipe(
            map((result: any) => {
                return {
                    servicetypeid: result[0]['UserToken'].map(
                        (res: { service_nm: any; service_id: any; service_type: any; }) =>
                            new DropdownModel({
                                text: res.service_nm,
                                value: res.service_id,
                                additionalProperty: res.service_type
                            })
                    ),
                    frequencyCdId: result[1]['UserToken'].map(
                        (res: { value_tx: any; picklist_value_cd: any; }) =>
                            new DropdownModel({
                                text: (res.value_tx),
                                value: (res.picklist_value_cd),
                            })
                    ),
                    durationCdId: result[2]['UserToken'].map(
                        (res1: { value_tx: any; picklist_value_cd: any; }) =>
                            new DropdownModel({
                                text: (res1.value_tx),
                                value: (res1.picklist_value_cd),
                            })
                    ),
                    serviceEndReason: result[3]['UserToken'].map(
                        (res: { service_end_reason: any; service_end_reason_cd: any; }) =>
                            new DropdownModel({
                                text: (res.service_end_reason),
                                value: (res.service_end_reason_cd),
                            })
                    ),
                    ReasonServiceNotReceived: result[4]['UserToken'].map(
                        (res: { reason_service_not_received: any; service_not_received_cd: any; }) =>
                            new DropdownModel({
                                text: (res.reason_service_not_received),
                                value: (res.service_not_received_cd),
                            })
                    )
                };
            }),
            share(),);

        this.vendorServices$ = source.pipe(pluck('servicetypeid'));
        this.frequencyCds$ = source.pipe(pluck('frequencyCdId'));
        this.durationCds$ = source.pipe(pluck('durationCdId'));
        this.serviceEndReason$ = source.pipe(pluck('serviceEndReason'));
        this.reasonServiceNotReceived$ = source.pipe(pluck('ReasonServiceNotReceived'));
        this.endReasonDropdown$ = this._commonDropdownService.getPickList('10046');
    }

    selectedProv(searchPlan: any) {
        this.selectedProviderId = null;
        if(searchPlan.service_id == '526' || searchPlan.service_id == '527'){
          this.selectedCFEService = true;
          this.selectedProviderId = searchPlan.ID;
        }
        if (searchPlan.service) {
            this.selectedServicePlan = true;
        }
        this.searchPlan = searchPlan;
    }

    pleaseSelectReferredService() {
        this._alertService.error('Please select a service');
    }

    getInvolvedPerson() {
        this.childList = [];
        let personDetail = {};
        if (this.isServiceCase === 'true') {
            this.serviceCase = true;
            personDetail = {
                objectid: this.id,
                objecttypekey: 'servicecase'
            };
        } else {
            this.serviceCase = false;
            personDetail = {
                intakeserviceid: this.id
            };
        }
        this._commonHttpService
            .getPagedArrayList( new PaginationRequest({
                method: 'get',
                page: 1, limit : 100,
                nolimit: true,
                where: personDetail
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
            )
           /* .map((res) => {
                console.log('res', res);
                return res['data'].filter((item) => item.intakeservicerequestpersontypekey === 'CHILD');
            })*/.subscribe((response: any) => {
                if (response && response.data.length) {
                    for (let i = 0; i < response.data.length; i++) {
                        if (response.data[i].roles) {
                            this.childList.push(response.data[i]);
                            this.checkIfSupervisorFn(response, i);
                        }
                    }
                    this.getClientEligibility(this.rcCjamsID, this.daNumber);
                    this.getPlacementHistoryByPerson(this.personid);
                    this.getList();
                    this.VendorDropDown();
                }
            });
    }
    // Assosiated with getInvolvedPerson method
    private checkIfSupervisorFn(response: any, i: number) {
        if (this.isSupervisor && this.purchaseAuthorization === response.data[i].cjamspid) {
            this.firstChild = response.data[i];
            this.rcCjamsID = response.data[i].cjamspid;
            this.clientDob = response.data[i].dob;
            this.clientGender = response.data[i].gender;
            this.clientAge = response.data[i].age;
            this.clientAgeAt26 = response.data[i].ageat26years;
            this.clientAgeAt14 = response.data[i].ageat14years;
            this.clientName = response.data[i].firstname + ' ' + response.data[i].lastname;
            this.personid = response.data[i].personid;
        } else if (!this.isSupervisor || (this.isSupervisor && (this.purchaseAuthorization == null || this.purchaseAuthorization === 'null'))) {    // NOSONAR
            this.firstChild = response.data[i];
            this.rcCjamsID = response.data[i].cjamspid;
            this.clientDob = response.data[i].dob;
            this.clientGender = response.data[i].gender;
            this.clientAge = response.data[i].age;
            this.clientAgeAt26 = response.data[i].ageat26years;
            this.clientAgeAt14 = response.data[i].ageat14years;
            this.clientName = response.data[i].firstname + ' ' + response.data[i].lastname;
            this.personid = response.data[i].personid;
        } 
    }

    getFullName(person: any) {
        const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
        let name = '';
        nameKeys.forEach(key => {
      if(person && person.hasOwnProperty(key)){
        if ( (person[key] !== null) && (person[key] !== 'null') && (person[key] !== '') ) {
          name = name + person[key] + ' ';
        }}
        });
        return name;
    }

    getClientEligibility(client_id: any, caseNumber: any) {
        this._commonHttpService.getArrayList({
            where: {
                client_id: client_id,
                case_id: caseNumber,
            },
            method: 'get'
        }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.ClientEligibility).subscribe((response: any) => {
            this.clientEligibility = response['data'];
            this.clientEligibilityStatus = this.clientEligibility[0].eligibility_status_cd;
        });
    }

    getPlacementHistoryByPerson(personid: any){
        this._commonHttpService
        .getSingle(
          {
            where: { personid: personid},
            method: 'get'
          },
    
          'placement/getplacementbyperson?filter'
        ).subscribe(data => {
            const placements = data;
            if(placements && placements.length) {
               placements.forEach((element: any) => {
              this.handleGetPlacementHistoryByPersonApiRespFn(element); 
               });
            }
        });
      }
    // Assosiated with getPlacementHistoryByPerson method
    private handleGetPlacementHistoryByPersonApiRespFn(element: any) {
        if (element.isvoided !== 1 && element.service_id == 525 && element.enddate === null) {
            const placementRevison = (element.placementrevision.length > 0) ? element.placementrevision[0] : null;
            if (element.routingstatus === 'Approved' || (placementRevison !== null && placementRevison.exitdate !== null)) {
                if (element.providerdetails.provider_id) {
                    this.activePlacementProvider = element.providerdetails.provider_id;
                }
                this.cfeHomeResourceChild = true;
            }
        }
        if (element.placementtypekey === 'LA' && (element.livingarrangementtypekey === 'ERM' || element.livingarrangementtypekey === 'PSYH' || element.livingarrangementtypekey === 'ERP')) {
            this.livingArrangementTypeCheck = true;
        }
    }

    childSelect(clientdetail: any) {
        this.clientName = clientdetail.firstname + ' ' + clientdetail.lastname;
        this.rcCjamsID = clientdetail.cjamspid;
        this.clientDob = clientdetail.dob;
        this. clientGender = clientdetail.gender;
        this.clientAge = clientdetail.age;
        this.clientAgeAt26 = clientdetail.ageat26years
        this.clientAgeAt14 = clientdetail.ageat14years;
        this.personid = clientdetail.personid;
        this.getPlacementHistoryByPerson(clientdetail.personid);
        this.getClientEligibility(this.rcCjamsID, this.daNumber);
        this.getList();
        this.VendorDropDown();
    }

    getActivityService() {
        this._commonHttpService.getPagedArrayList(
            new PaginationRequest({
              where: {personid: this.personid},
              limit : 10,
              page: 1,
              method: 'get'
            }), 'serviceLogs/getServicePlanActionList' + '?filter'
          ).subscribe((result: any) => {
            this.activityService = result.data;
          });
    }

    onActivityService(serviceplanactionid: any, form: any) {
        if (form === 'add') {
            if(serviceplanactionid) {
              this.addNewReferredServiceSecondForm.get('serviceplanid')?.reset();
              this.addNewReferredServiceSecondForm.get('estbegindate')?.disable(); 
              this.addNewReferredServiceSecondForm.get('estenddate')?.disable();
            }  else {
                this.addNewReferredServiceSecondForm.get('estbegindate')?.reset();
                this.addNewReferredServiceSecondForm.get('estenddate')?.reset();
                this.addNewReferredServiceSecondForm.get('serviceplanname')?.reset();
                this.addNewReferredServiceSecondForm.get('estbegindate')?.enable(); 
                this.addNewReferredServiceSecondForm.get('estenddate')?.enable();
            }           
        } else {
            this.addNewReferredServiceSecondForm.get('estbegindate')?.reset();
            this.EditreferredServiceForm.get('serviceplanid')?.reset();
        }
        this.getServicePlan(serviceplanactionid);
    }

    getServicePlan(serviceplanactionid: any) {
        this._commonHttpService.getPagedArrayList(
            new PaginationRequest({
              where: {serviceplanactionid: serviceplanactionid},
              limit : 10,
              page: 1,
              method: 'get'
            }), 'serviceLogs/getServicePlanList' + '?filter'
          ).subscribe((result: any) => {
            this.servicePlan = result.data;
            if  (this.servicePlan && this.servicePlan.length) {
                this.addNewReferredServiceSecondForm.patchValue({
                    serviceplanid: this.servicePlan[0].serviceplanid,
                    serviceplanname: this.servicePlan[0].serviceplanname,
                    estbegindate: this.servicePlan[0].effectivedate,
                    estenddate: this.servicePlan[0].targetenddate
                });
                this.addNewReferredServiceSecondForm.get('serviceplanname')?.disable();
            }
          });
    }

    saveReferredService() {
        this.saveService = true;
        this.servicetypeid = '';
        const actbeginDate =  this.addNewReferredServiceSecondForm.get('actbegindate')?.value;
        const estbeginDate =  this.addNewReferredServiceSecondForm.get('estbegindate')?.value;
        const estendDate =  this.addNewReferredServiceSecondForm.get('estenddate')?.value;
        const actenddate = this.addNewReferredServiceSecondForm.get('actenddate')?.value;

        if (!this.validateDateCond1Fn(actbeginDate, estbeginDate, 'Actual begin date cannot be prior to the estimated begin date.')) {
            return;
        }
    
        if (!this.validateDateCond2Fn(actbeginDate, actenddate, 'Actual end date cannot be prior to the actual start date.')) {
            return;
        }
        
        if (!this.validateDateCond3Fn(actbeginDate, this.enddate, 'Actual begin date cannot be greater than service program end date.')) {
            return;
        }
     
        if (!this.validateDateCond3Fn(actenddate, estendDate, 'Actual End date cannot be greater than the estimated end date.')) {
            return;
        }

        if (!this.validateDateCond1Fn(actenddate, this.servicelogminenddate, 'Actual End date cannot be prior to the purchase authorization end date.')) {
            return;
        }

        if(this.actualStartEndDateAlertMessage) {
            this._alertService.warn(this.actualStartEndDateAlertMessage);
            return;

        }
        if (this.addNewReferredServiceSecondForm.valid) {
            const { yearCheck1, yearCheck2, yearCheck3, yearCheck4 } = this.returnYearCheckFn();
            
            if(yearCheck1 > 9999 || yearCheck2 > 9999 ||  yearCheck3 > 9999 || yearCheck4 > 9999) {
                this._alertService.warn('Please enter valid date');
                return;                
            }
            
            this.handleVendorSaveServiceLogApiFn();
        }
        // Start D-06585
        else {
            this._alertService.warn(this.mandatorymsg);
        }
        // End D-06585
    }
    // Assosiated with saveReferredService method
    private returnYearCheckFn() {
        const yearCheck1: any = this.addNewReferredServiceSecondForm.value.actbegindate ? Number(moment(this.addNewReferredServiceSecondForm.value.actbegindate).format('YYYY')) : null;
        const yearCheck2: any = this.addNewReferredServiceSecondForm.value.actenddate ? Number(moment(this.addNewReferredServiceSecondForm.value.actenddate).format('YYYY')) : null;
        const yearCheck3: any = this.addNewReferredServiceSecondForm.value.estbegindate ? Number(moment(this.addNewReferredServiceSecondForm.value.estbegindate).format('YYYY')) : null;
        const yearCheck4: any = this.addNewReferredServiceSecondForm.value.estenddate ? Number(moment(this.addNewReferredServiceSecondForm.value.estenddate).format('YYYY')) : null;
        return { yearCheck1, yearCheck2, yearCheck3, yearCheck4 };
    }
    // Assosiated with saveReferredService method
    private handleVendorSaveServiceLogApiFn() {
        this._dataStoreService.currentStore.subscribe((store) => {
            if (store['dsdsActionsSummary']) {
                this.headerSummary = store['dsdsActionsSummary'];
            }
        });
        const referredForm = this.addNewReferredServiceSecondForm.getRawValue();
        const case_id = this.headerSummary.da_number;
        const url = 'serviceLogs/vendorSaveServiceLog';
        const model = this.returnSaveReferredServiceModelFn(referredForm, case_id);
        this._commonHttpService.create(model, url).subscribe((response) => {
            this.saveService = false;
            this._alertService.success('Service Added successfully');
            (<any>$('#Edit-newreferredservice')).modal('hide');
            this.getList(1, true);
            this.resetServiceDetail();
            if (response) {
                (<any>$(this.addservicepopupid)).modal('hide');
                (<any>$(this.selectservicepopupid)).modal('hide');
            }
        },
            (error) => {
                this.saveService = false;
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });

        (<any>$(this.addservicepopupid)).modal('hide');
        (<any>$(this.selectservicepopupid)).modal('hide');
    }
    // Assosiated with saveReferredService method
    private returnSaveReferredServiceModelFn(referredForm: any, case_id: any) {
        return {
            'providerServiceId': this.searchPlan.provider_service_id,
            'startDt': this.datePipe.transform(this.addNewReferredServiceSecondForm.value.actbegindate, this.dtformat2),
            'endDt': this.datePipe.transform(this.addNewReferredServiceSecondForm.value.actenddate, this.dtformat2),
            'descriptionTx': this.addNewReferredServiceSecondForm.value.agencynotes,
            // 'startTm': '9:10PM',
            // 'endTm': '9:10PM',
            'noServiceReasonCd': 'abcd',
            'estimatedStartDt': this.addNewReferredServiceSecondForm.value.estbegindate ? this.datePipe.transform(this.addNewReferredServiceSecondForm.value.estbegindate, this.dtformat2) : this.datePipe.transform(referredForm.estbegindate, this.dtformat2),
            'estimatedEndDt': this.addNewReferredServiceSecondForm.value.estenddate ? this.datePipe.transform(this.addNewReferredServiceSecondForm.value.estenddate, this.dtformat2) : this.datePipe.transform(referredForm.estenddate, this.dtformat2),
            'frequencyCd': this.addNewReferredServiceSecondForm.value.frequencyCdId,
            'durationCd': this.addNewReferredServiceSecondForm.value.durationCdId,
            'courtOrderedSw': this.addNewReferredServiceSecondForm.value.courtOrderedSw ? 'Y' : 'N',
            'agencyProgramAreaId': referredForm.clientprogramnameid,
            'agencysubprogramareaid': referredForm.clientsubprogramnameid,
            'endsubcategoryreason': referredForm.endReason,
            'referredDt': this.addNewReferredServiceSecondForm.value.dateReffered,
            'serviceLogId': this.addNewReferredServiceSecondForm ? this.addNewReferredServiceSecondForm.value.service_log_id : null,
            'case_id': case_id,
            // D-06581
            'daNumber': this.daNumber,
            'client_id': this.rcCjamsID ? this.rcCjamsID : null,
            serviceplanactionid: this.addNewReferredServiceSecondForm ? this.addNewReferredServiceSecondForm.value.serviceplanactionid : null,
            serviceplanname: referredForm ? referredForm.serviceplanname : null,
            serviceplanid: referredForm ? referredForm.serviceplanid : null,
            endServiceReasonCd: referredForm ? referredForm.endServiceReasonCd : null,
            outcome: referredForm ? referredForm.outcome : null,
            servicereceived: referredForm.servicereceived ? referredForm.servicereceived : null,
            servicenotreceived: referredForm.servicenotreceived ? referredForm.servicenotreceived : null,
            'ldss_cd': this.stateCountyCode
        };
    }

    getApproveHistory(authid: any) {
        this.payableApprovalHistory = [];
        const userDetails = this._authService.getCurrentUser();
        this._commonHttpService.getPagedArrayList(
          new PaginationRequest({
            where: {authorization_id: authid},
            limit : this.pageInfo.pageSize,
            page: this.pageInfo.pageNumber,
            method: 'get'
          }), FinanceUrlConfig.EndPoint.accountsPayable.listPayableApprovalHistory + '?filter'
        ).subscribe((result: any) => {
          if(this.checkStatusFn(result, userDetails)){
            this.authInitiator=true;
          }else{
            this.authInitiator=false;
          }
          result.forEach((element: { status: string; }) => { //CIDM-9973 - PR Update for denied and returned purchase authorizations
            if (element.status !== 'Approved') {
                this.isApproved = false;
            }
        });
          this.payableApprovalHistory = result;
          this.totalPage = (this.payableApprovalHistory && this.payableApprovalHistory.length > 0) ? this.payableApprovalHistory.length : 0;
          if(this.totalPage > 0 && this.singlePurchaseAuthorization && !this.singlePurchaseAuthorization.status) {            
            this.disableApprove = false;
            this.purchaseServiceForm.disable();
            this.isUploadDisabled = true;
          }
          this.cdr.markForCheck();
        });
      }


    private checkStatusFn(result: any, userDetails: AppUser) {
        return result && result.length > 0 && result[0].status === 'Pending' && result[0].fromuser === userDetails.user.userprofile.fullname;
    }

    edit(referredService: any) {
        this._commonHttpService.getArrayList(
            {
                where: {
                    daNumber: this.daNumber, clientid: this.rcCjamsID, service_log_id: this.purchaseAuthorizationServiceLog ? +this.purchaseAuthorizationServiceLog : null,
                    sortcolumn: this.listPageInfo.sortColumn, sortorder: this.listPageInfo.sortBy
                },
                method: 'get',
                limit: this.totalServicePlanCountLimit,
                page: 1
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.vendorServiceLog + '?filter'
        ).pipe(
            map((res: any) => {
                this.referredServiceList = res['servicelogData'];
            })).subscribe(()=> {
        this.saveService = false;
        this.addNewService = false;
        this.searchPlan = null;
        this.getActivityService();
        this.referredService = referredService;
        this.getClientDropdown(referredService.agency_program_area_id);
        this.getServicePlan(referredService.serviceplanactionid);
        this.startdate = new Date(referredService.estimated_start_date);
        this.servicelogminenddt = referredService.servicelogminenddt ? new Date(referredService.servicelogminenddt) : null;
        this.servicelogminenddate = this.servicelogminenddt;
        const model = this.returnEditModelDataFn(referredService);
       
        this.addNewReferredServiceSecondForm.patchValue(model, { emitEvent: true, onlySelf: false });
        if (!referredService.no_service_reason) {
            this.serviceNotReceived = false;
            this.addNewReferredServiceSecondForm.get('noServiceReasonCd')?.disable();      
        } else {
            this.serviceNotReceived = true;
            this.addNewReferredServiceSecondForm.patchValue({
                servicenotreceived: true,
                noServiceReasonCd: referredService.no_service_reason_cd
            });
        }

        if (referredService.authflag && referredService.actual_end_date) {
            this.addNewReferredServiceSecondForm.disable();
        } else if (referredService.authflag && (!(referredService.actual_end_date && referredService.ongoingtransflag))) {
            this.addNewReferredServiceSecondForm.disable();
            this.addNewReferredServiceSecondForm.get('actenddate')?.enable();
            this.addNewReferredServiceSecondForm.get('actbegindate')?.enable();
            this.addNewReferredServiceSecondForm.get('estbegindate')?.enable();
            this.addNewReferredServiceSecondForm.get('estenddate')?.enable();
            this.addNewReferredServiceSecondForm.get('endServiceReasonCd')?.disable();
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].clearValidators();
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].updateValueAndValidity();
        } else {
            this.handleIfNotActualEndDateFn(referredService);
        }
        this.minEstDate = new Date(this.addNewReferredServiceSecondForm.value.estbegindate);
        this.minActDate = new Date(this.addNewReferredServiceSecondForm.value.actbegindate);

        this.onChangeDate(this.addNewReferredServiceSecondForm, 'actbegindate')
        this.onChangeDate(this.addNewReferredServiceSecondForm, 'actenddate')
     })
    }
    // Assosiated with edit method
    private handleIfNotActualEndDateFn(referredService: any) {
        this.addNewReferredServiceSecondForm.enable();
        if (!referredService.actual_end_date) {
            this.addNewReferredServiceSecondForm.get('endServiceReasonCd')?.disable();
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].clearValidators();
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].updateValueAndValidity();
        }

        if (referredService.serviceplanactionid) {
            this.addNewReferredServiceSecondForm.get('estbegindate')?.disable();
            this.addNewReferredServiceSecondForm.get('estenddate')?.disable();
        }
        if (referredService.actual_start_date) {
            this.serviceReceived = true;
            this.addNewReferredServiceSecondForm.patchValue({
                servicereceived: true
            });
        } else {
            this.serviceReceived = false;
            this.addNewReferredServiceSecondForm.patchValue({
                servicereceived: false
            });
            this.addNewReferredServiceSecondForm.get('endServiceReasonCd')?.disable();
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].clearValidators();
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].updateValueAndValidity();
            this.addNewReferredServiceSecondForm.get('actbegindate')?.disable();

            this.addNewReferredServiceSecondForm.controls['actbegindate'].clearValidators();
            this.addNewReferredServiceSecondForm.controls['actbegindate'].updateValueAndValidity();
            this.addNewReferredServiceSecondForm.get('actenddate')?.disable();
        }
    }
    // Assosiated with edit method
    private returnEditModelDataFn(referredService: any) {
        return {
            clientprogramnameid: referredService.agency_program_area_id,
            clientsubprogramnameid: referredService.agency_sub_program_area_id,
            servicetypeid: referredService.service_id,
            frequencyCdId: referredService.frequency_cd,
            durationCdId: referredService.duration_cd,
            estbegindate: new Date(referredService.estimated_start_date),
            actbegindate: referredService.actual_start_date ? new Date(referredService.actual_start_date) : null,
            estenddate: new Date(referredService.estimated_end_date),
            actenddate: referredService.actual_end_date ? new Date(referredService.actual_end_date) : null,
            actbegintime: referredService.start_time,
            actendtime: referredService.end_time,
            agencynotes: referredService.notes,
            outcome: referredService.outcome,
            noServiceReasonCd: '',
            serviceReceivedReason: referredService.serviceReceivedReason ? referredService.serviceReceivedReason : null,
            // providerid: referredService.provider_id,
            // providername: referredService.provider_nm,
            // taxid: referredService.tax_id,
            // zipcode: referredService.zip,
            dateReffered: new Date(referredService.referred_date),
            courtOrderedSw: (referredService.courtorder === 'Y') ? true : false,
            serviceplanactionid: referredService.serviceplanactionid ? referredService.serviceplanactionid : null,
            serviceplanname: referredService.serviceplanname ? referredService.serviceplanname : null,
            serviceplanid: referredService.serviceplanid ? referredService.serviceplanid : null,
            servicenotreceived: referredService.servicenotreceived ? referredService.servicenotreceived : null,
            servicereceived: referredService.servicereceived ? referredService.servicereceived : null,
            endServiceReasonCd: referredService.service_end_reason_cd ? (referredService.service_end_reason_cd).trim() : null
        };
    }

    updateReferredService() {
        const actbeginDate =  this.addNewReferredServiceSecondForm.get('actbegindate')?.value;
        const estbeginDate =  this.addNewReferredServiceSecondForm.get('estbegindate')?.value;
        const actenddate = this.addNewReferredServiceSecondForm.get('actenddate')?.value;

        if (!this.validateDateCond1Fn(actbeginDate, estbeginDate, 'Actual begin date cannot be prior to the estimated begin date.')) {
            return;
        }

    
        if (!this.validateDateCond2Fn(actbeginDate, actenddate, 'Actual end date cannot be prior to the actual start date.')) {
            return;
        }

        if (!this.validateDateCond3Fn(actbeginDate, this.enddate, 'Actual begin date cannot be greater than service program end date.')) {
            return;
        }

        if (!this.validateDateCond1Fn(actenddate, this.servicelogminenddate, 'Actual End date cannot be prior to the purchase authorization end date.')) {
            return;
        }

        if(this.actualStartEndDateAlertMessage) {
            this._alertService.warn(this.actualStartEndDateAlertMessage);
            return;

        }

        if(!this.checkIfValidDatesEntered()){
            return;
        }
    }
    // Assosiated with updateReferredService method
    private checkIfValidDatesEntered() {
        if (this.addNewReferredServiceSecondForm.valid) {
            this.saveService = true;
            const referredForm = this.addNewReferredServiceSecondForm.getRawValue();
            const yearCheck1: any = this.addNewReferredServiceSecondForm.value.actbegindate ? Number(moment(this.addNewReferredServiceSecondForm.value.actbegindate).format('YYYY')) : null;
            const yearCheck2: any = this.addNewReferredServiceSecondForm.value.actenddate ? Number(moment(this.addNewReferredServiceSecondForm.value.actenddate).format('YYYY')) : null;
            const yearCheck3: any = this.addNewReferredServiceSecondForm.value.estbegindate ? Number(moment(this.addNewReferredServiceSecondForm.value.estbegindate).format('YYYY')) : null;
            const yearCheck4: any = this.addNewReferredServiceSecondForm.value.estenddate ? Number(moment(this.addNewReferredServiceSecondForm.value.estenddate).format('YYYY')) : null;
            
            if(yearCheck1 > 9999 || yearCheck2 > 9999 ||  yearCheck3 > 9999 || yearCheck4 > 9999) {
                this._alertService.warn('Please enter valid dates');
                return false;                
            }
            this.handleEditVendorServiceLogApiFn(referredForm);
        } else {
            this.handleIfAddNewReferredServiceSecondFormNotValidFn();
        }
        return true;
    }
    // Assosiated with updateReferredService method
    private handleIfAddNewReferredServiceSecondFormNotValidFn() {
        this.saveService = false;
        const minEstDate = moment(this.minEstDate).format(this.dtformat1);
        const casestartdate = new Date(this.casestartdate);
        if (minEstDate < moment(casestartdate).format(this.dtformat1)) {
            this._alertService.warn('Begin date cannot be less than the Case Start Date.');
        } else {
            this._alertService.warn(this.mandatorymsg);
        }
    }
    // Assosiated with updateReferredService method
    private handleEditVendorServiceLogApiFn(referredForm: any) {
        const url = 'serviceLogs/editVendorServiceLog'; 
        const model = this.returnAddNewReferredServiceSecondFormDataFn(referredForm);
        //This PUT remote method does not work on model entities so does not need an Id
        //It is actually calling a stored proc so removing the id and passing request payload
        this._commonHttpService.updateWithoutid(model, url).subscribe((response) => {
            this.saveService = false;
            this._alertService.success('Service Updated successfully');
            this.getList();
            this.resetServiceDetail();
            (<any>$(this.selectservicepopupid)).modal('hide');
        },
            (error) => {
                this.saveService = false;
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }
    // Assosiated with updateReferredService method
    private returnAddNewReferredServiceSecondFormDataFn(referredForm: any) {
        return {
            'providerServiceId': this.referredService.provider_service_id,
            'courtOrderedSw': referredForm.courtOrderedSw ? 'Y' : 'N',
            'endServiceReasonCd': referredForm.endServiceReasonCd,

            // D-06581
            'daNumber': this.daNumber,
            'client_id': this.rcCjamsID,
            // 'case_id': this.daNumber,
            'startDt': this.datePipe.transform(referredForm.actbegindate, this.dtformat2),
            'endDt': this.datePipe.transform(referredForm.actenddate, this.dtformat2),
            'descriptionTx': referredForm.agencynotes,
            'outcome': referredForm.outcome,
            // 'startTm': this.datePipe.transform(referredForm.actbegintime, 'hh-mm aa'),
            // 'endTm': this.datePipe.transform(referredForm.actendtime, 'hh-mm aa'),
            'estimatedStartDt': this.datePipe.transform(referredForm.estbegindate, this.dtformat2),
            'estimatedEndDt': this.datePipe.transform(referredForm.estenddate, this.dtformat2),
            'frequencyCd': referredForm.frequencyCdId,
            'durationCd': referredForm.durationCdId,
            'agencyProgramAreaId': referredForm.clientprogramnameid,
            'agencysubprogramareaid': referredForm.clientsubprogramnameid,
            'endsubcategoryreason': referredForm.endReason,
            'serviceLogId': this.referredService.service_log_id,
            'referredDt': this.datePipe.transform(referredForm.dateReffered, this.dtformat2),
            noServiceReasonCd: referredForm.noServiceReasonCd ? referredForm.noServiceReasonCd : null
        };
    }
    // Assosiated with updateReferredService method
    validateDateCond1Fn(date1: Date, date2: any, message: string): boolean {
        if (date1 && date2 && new Date(moment(date1).format(this.dtformat)).getTime() < new Date(moment(date2).format(this.dtformat)).getTime()) {
            this._alertService.warn(message);
            return false;
        }
        return true;
    }
    // Assosiated with updateReferredService method
    validateDateCond2Fn(date1: Date, date2: Date, message: string): boolean {
        if (date1 && date2 && (new Date(moment(date2).format(this.dtformat)).getTime() <  new Date(moment(date1).format(this.dtformat)).getTime())) {
            this._alertService.warn(message);
            return false;
        }
        return true;
    }
    // Assosiated with updateReferredService method
    validateDateCond3Fn(date1: Date, date2: Date, message: string): boolean {
        if (date1 && date2 && new Date(moment(date1).format(this.dtformat)).getTime() > new Date(moment(date2).format(this.dtformat)).getTime()) {
            this._alertService.warn(message);
            return false;
        }
        return true;
    }

    changeServiceReceived(val: Event) {
        const checked = (val.target as HTMLInputElement).checked;
        if (!checked) {
            this.serviceReceived = false;
            this.addNewReferredServiceSecondForm.controls['actenddate'].reset();
            this.addNewReferredServiceSecondForm.controls['actbegindate'].reset();
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].reset();
            this.addNewReferredServiceSecondForm.controls['actenddate'].disable();
            this.addNewReferredServiceSecondForm.controls['actbegindate'].disable();
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].disable();
            this.addNewReferredServiceSecondForm.controls['actbegindate'].clearValidators();
            this.addNewReferredServiceSecondForm.controls['actbegindate'].updateValueAndValidity();
        } else {
            this.serviceReceived = true;
            this.serviceNotReceived = false;
            this.addNewReferredServiceSecondForm.get('servicenotreceived')?.reset();
            
            if(!this.addNewService){
                this.addNewReferredServiceSecondForm.controls['noServiceReasonCd'].disable();
                this.addNewReferredServiceSecondForm.controls['noServiceReasonCd'].reset();
            }
            
            this.addNewReferredServiceSecondForm.controls['actenddate'].enable();
            this.addNewReferredServiceSecondForm.controls['actbegindate'].enable();
            this.addNewReferredServiceSecondForm.controls['actbegindate'].setValidators(Validators.required);
            this.addNewReferredServiceSecondForm.controls['actbegindate'].updateValueAndValidity();
        }
    }

    onChangeActualEndDate() {
        if (this.addNewReferredServiceSecondForm.get('actenddate')?.value) {
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].enable();
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].setValidators(Validators.required);
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].updateValueAndValidity();
        } else {
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].clearValidators();
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].updateValueAndValidity();
        }
      }

    changeServiceNotReceived(val: Event) {
        const checked = (val.target as HTMLInputElement).checked;
        if (!checked) {
            this.serviceNotReceived = false;
            this.addNewReferredServiceSecondForm.controls['noServiceReasonCd'].reset();
            this.addNewReferredServiceSecondForm.controls['noServiceReasonCd'].disable();
        } else {
            this.serviceReceived = false;
            this.serviceNotReceived = true;
            this.addNewReferredServiceSecondForm.get('servicereceived')?.reset();
            this.addNewReferredServiceSecondForm.controls['noServiceReasonCd'].setValidators(Validators.required);
            this.addNewReferredServiceSecondForm.controls['noServiceReasonCd'].updateValueAndValidity();
            this.addNewReferredServiceSecondForm.controls['noServiceReasonCd'].enable();
            this.addNewReferredServiceSecondForm.controls['actenddate'].reset();
            this.addNewReferredServiceSecondForm.controls['actbegindate'].reset();
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].reset();
            this.addNewReferredServiceSecondForm.controls['actenddate'].disable();
            this.addNewReferredServiceSecondForm.controls['actbegindate'].disable();
            this.addNewReferredServiceSecondForm.controls['endServiceReasonCd'].disable();
            this.addNewReferredServiceSecondForm.controls['actbegindate'].clearValidators();
            this.addNewReferredServiceSecondForm.controls['actbegindate'].updateValueAndValidity();
        }
    }

    delete(referredService: any) {
        this.referredService = referredService;
    }

    closeNoDelete() {
        (<any>$('#Delete-newreferredservice')).modal('hide');
    }

    resetFiscalCode(){
        (<any>$('#validate-fiscalDate')).modal('hide');
    }

    deleteItem() {
        this._commonHttpService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.DelectServiceLog;
        this._commonHttpService.update('',
        {
            service_log_id: this.referredService.service_log_id,
            case_id: this.daNumber,
            client_id: this.rcCjamsID
        }).subscribe(
            (response) => {
                this._alertService.success('Service has been deleted successfully');
                (<any>$('#Delete-newreferredservice')).modal('hide');
                this.getList(1);
            },
            (error) => {
                (<any>$('#Delete-newreferredservice')).modal('hide');
                this._alertService.error(error?.error?.error?.message ?? GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );

       /* this._commonHttpService.(this.referredService.service_log_id, { activeflag: 0 }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.DelectServiceLog).subscribe(
            res => {
                this._alertService.success('Service deleted successfully');
                (<any>$('#Delete-newreferredservice')).modal('hide');
                this.getList(1);
            },
            err => { }
        );*/
    }

    printpdf(): void {
        const serviceFormById: any = document.getElementById('serviceForm');
        const printContents = serviceFormById.innerHTML;
        const popupWin: any = window.open('', '_blank', 'top=0,left=0,height=100%,width=auto');
        popupWin.document.open();
        popupWin.document.write(`
      <html>
        <head>
          <title>Print tab</title>
          <style>
          //........Customized style.......
          </style>
        </head>
    <body onload="window.print();window.close()">${printContents}</body>
      </html>`
        );
        popupWin.document.close();
    }


    // pdfFiles:any;
    async downloadCasePdf(element: string) {
        const source: any = document.getElementById(element);
        const pages: any = source.getElementsByClassName('pdf-page');
        let pageImages: any[] = [];
        for (let i = 0; i < pages.length; i++) {

            await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas: any) => {
                const img = canvas.toDataURL('image/png');
                pageImages.push(img);
            });
        }
        const pageName = 'pageName';
        this.pdfFiles.push({ fileName: pageName, images: pageImages });
        pageImages = [];
        this.convertImageToPdf();
    }

    convertImageToPdf() {
        this.pdfFiles.forEach((pdfFile) => {
            const doc: any = new jsPDF();
            pdfFile.images.forEach((image, index) => {
                doc.addImage(image, 'JPEG', 0, 0);
                if (pdfFile.images.length > index + 1) {
                    doc.addPage();
                }
            });
            doc.save(pdfFile.fileName);
        });
        this.pdfFiles = [];
    }
    searchPlanBeginDate: any = null;
    actEndDateExist = true;
    testDate: Date = new Date();
    onChangeDate(form: any, field: any) {
        if (field == 'actenddate') {
            this.onChangeActualEndDate()
        }

        if (field === 'actbegindate' || field === 'actenddate') {
            const actBeginDate = new Date(form.value.actbegindate).getTime();
            const futur10YeDate = new Date().setFullYear(new Date().getFullYear() + 10);
            const actenddate = form.value.actenddate ? new Date(form.value.actenddate).getTime() : new Date(futur10YeDate).getTime();
            this.actEndDateExist = true;
            this.actualStartEndDateAlertMessage = '';
            const referredServiceStartEndDateList = this.handleReferredServiceStartEndDateListFilterFn()
            const referredServiceStartDateList = this.handleReferredServiceStartDateListFilterFn()

            this.handleReferredServiceStartEndDateListMapFn(referredServiceStartEndDateList, actBeginDate, actenddate, form);
            this.handlereferredServiceStartDateListMapFn(referredServiceStartDateList, actBeginDate, actenddate, form);

            if (this.actEndDateExist) {
                this.addNewReferredServiceSecondForm.get('actenddate')?.clearValidators();
            }

            this.addNewReferredServiceSecondForm.get('actenddate')?.updateValueAndValidity();
        }
        /* 
        * Case Start date is a datetime value and does contain time associated.
        * Calender picker gives only the date with out time. Converting the associated datetime fields to check with date only
        */
        const estimatedBeginDate = new Date(form.value.estbegindate);
        const estimatedEndDate = new Date(form.value.estenddate);
        const actBegindate = new Date(form.value.actbegindate);
        const caseStartDate = new Date(moment(this.casestartdate).format(this.dtformat1));

        if (field === 'estbegindate') {
            this.handleEstbegindateFn(estimatedBeginDate, caseStartDate, form, actBegindate, estimatedEndDate);
        } else if (field === 'estenddate') {
            if (estimatedEndDate < caseStartDate || estimatedEndDate < estimatedBeginDate) {
                form.get('estenddate').reset();
                this._alertService.warn('Invalid Date');
            }
        } else if (field === 'actbegindate') {
            this.minActDate = new Date(actBegindate);
            this.servicelogminenddate = this.servicelogminenddt ? this.servicelogminenddt : new Date(form.value.actbegindate)
        }
    }
    // Assosiated with onChangeDate method
    private handleEstbegindateFn(estimatedBeginDate: Date, caseStartDate: Date, form: any, actBegindate: Date, estimatedEndDate: Date) {
        if (estimatedBeginDate < caseStartDate) {
            form.get('estbegindate').reset();
            this._alertService.warn('Invalid Date');
        }
        if (actBegindate && estimatedBeginDate > actBegindate) {
            form.get('actbegindate').reset();
        }
        this.minEstDate = new Date(estimatedBeginDate);
        if (estimatedEndDate && estimatedBeginDate > estimatedEndDate) {
            form.get('estenddate').reset();
        }
    }
    // Assosiated with onChangeDate method
    private handlereferredServiceStartDateListMapFn(referredServiceStartDateList: any[], actBeginDate: number, actenddate: number, form: any) {
        referredServiceStartDateList.forEach((data) => {
            if (!this.actualStartEndDateAlertMessage) {
                const actualStartDate = new Date(data['actual_start_date']).getTime();
                const actualEndDate = new Date(data['actual_end_date']).getTime();
                this.searchPlanBeginDate = (this.searchPlanBeginDate && (new Date(this.searchPlanBeginDate).getTime() < actualStartDate)) ? new Date(data['actual_start_date']) : this.searchPlanBeginDate;
                this.searchPlanBeginDate && this.searchPlanBeginDate.setDate(this.searchPlanBeginDate.getDate() - 1);
                if (actualStartDate && !actualEndDate && actBeginDate >= actualStartDate) {
                    this.actualStartEndDateAlertMessage = 'Please enter the dates correctly as selected dates are overlapping with other existing Service Log.';
                } else if (actualStartDate && !actualEndDate && !actenddate && actBeginDate < actualStartDate) {
                    this.actEndDateExist = false;
                    this.addNewReferredServiceSecondForm.get('actenddate')?.setValidators([Validators.required]);
                } else if (actenddate >= actualStartDate) {
                    this.checkActenddateFn(form);
                } else if (actualStartDate && actualEndDate && actBeginDate && actenddate &&
                    (actBeginDate <= actualStartDate && actenddate <= actualEndDate)) {
                    this.actualStartEndDateAlertMessage = this.actualStartEndDateAlertMessageData;
                } else {
                    this.actualStartEndDateAlertMessage = '';
                }
            }
        });
    }
    // Assosiated with onChangeDate method
    private checkActenddateFn(form: any) {
        this.actualStartEndDateAlertMessage = this.actualStartEndDateAlertMessageData;
        if (!form.value.actenddate) {
            this.actualStartEndDateAlertMessage = 'Please enter the actual end date as this open end date overlaps with other existing Service Log';
            this.actEndDateExist = false;
            this.addNewReferredServiceSecondForm.get('actenddate')?.setValidators([Validators.required]);
        }
    }
    // Assosiated with onChangeDate method
    private handleReferredServiceStartEndDateListMapFn(referredServiceStartEndDateList: any[], actBeginDate: number, actenddate: number, form: any) {
        referredServiceStartEndDateList.forEach((data) => {
            if (!this.actualStartEndDateAlertMessage) {
                const actualStartDate = new Date(data['actual_start_date']).getTime();
                const actualEndDate = new Date(data['actual_end_date']).getTime();
                this.searchPlanBeginDate = (this.searchPlanBeginDate && (new Date(this.searchPlanBeginDate).getTime() < actualStartDate)) ? new Date(data['actual_start_date']) : this.searchPlanBeginDate;
                this.searchPlanBeginDate && this.searchPlanBeginDate.setDate(this.searchPlanBeginDate.getDate() - 1);
                this.handleReferredServiceStartEndDateListMapCondFn(actualStartDate, actualEndDate, actBeginDate, actenddate, form);
            }
        });
    }
    // Assosiated with onChangeDate method
    private handleReferredServiceStartEndDateListMapCondFn(actualStartDate: number, actualEndDate: number, actBeginDate: number, actenddate: number, form: any) {
        if (actualStartDate && actualEndDate && actBeginDate >= actualStartDate && actBeginDate <= actualEndDate && !actenddate) {
            if (actBeginDate >= actualStartDate || actBeginDate <= actualEndDate || actenddate >= actualStartDate) {
                this.actualStartEndDateAlertMessage = this.actualStartEndDateAlertMessageData;
            } 
        } else if (actualStartDate && actualEndDate && actBeginDate >= actualStartDate && actBeginDate <= actualEndDate && actenddate) {
            if (actenddate >= actualStartDate) {
                this.actualStartEndDateAlertMessage = this.actualStartEndDateAlertMessageData;
            }
        } else if (actualStartDate && actualEndDate && actBeginDate && actenddate && actBeginDate <= actualStartDate && actenddate >= actualEndDate) {
            this.checkActenddateFn(form);
        } else if (actualStartDate && actualEndDate && actBeginDate && actenddate && actBeginDate <= actualStartDate && actenddate >= actualStartDate && actenddate <= actualEndDate) {
            this.checkActenddateFn(form);
        } else {
            this.actualStartEndDateAlertMessage = '';
        }
    }

    private handleReferredServiceStartDateListFilterFn() {
        return this.referredServiceList.filter((data) => {
            if (this.searchPlan) {
                if ((data['provider_id'] == this.searchPlan['ID']) && (data['provider_service_id'] == this.searchPlan['provider_service_id'])) {
                    return data['actual_start_date'] && !data['actual_end_date'];
                } else {
                    return false;
                }
            } else {
                if (this.referredService['provider_id'] === data['provider_id'] &&
                    (data['provider_service_id'] == this.referredService['provider_service_id'])
                    && data['service_log_id'] != this.referredService['service_log_id']) {
                    return data['actual_start_date'] && !data['actual_end_date'];
                } else {
                    return false;
                }


            }
        });
    }

    private handleReferredServiceStartEndDateListFilterFn() {
        return this.referredServiceList?.filter((data) => {
            if (this.searchPlan) {
                if ((data['provider_id'] == this.searchPlan['ID']) && (data['provider_service_id'] == this.searchPlan['provider_service_id'])) {
                    return data['actual_start_date'] && data['actual_end_date'];
                } else {
                    return false;
                }
            } else {
                if (this.referredService['provider_id'] === data['provider_id'] &&
                    (data['provider_service_id'] == this.referredService['provider_service_id'])
                    && data['service_log_id'] != this.referredService['service_log_id']) {
                    return data['actual_start_date'] && data['actual_end_date'];
                } else {
                    return false;
                }

            }

        });
    }

    viewChildAccount(clientid: any, accno: any) {
        (<any>$(this.purchaseauthpopupid)).modal('hide');
        this._commonHttpService.getPagedArrayList(new PaginationRequest({
          where: {client_id: clientid, istransaction: false },
          nolimit: true,
          method: 'get'
        }), FinanceUrlConfig.EndPoint.childAccounts.getchildaccountslistUrl + '?filter').subscribe(result => {
          this.childAccountsList = result.data;
          if (accno && this.childAccountsList && this.childAccountsList.length > 0) {
            this.childAccountsList = this.childAccountsList.filter(data => data.account_no_tx == accno);
          }
          (<any>$('#view-child-account')).modal('show');
        });
      }

      showPrevious(id: any) {
        (<any>$(`#${id}`)).modal('show');
      }

      resetServiceDetail() {
          this.saveService = false;
          this.addNewReferredServiceSecondForm.reset();
          this.addNewReferredServiceSecondForm.enable();
      }

      startsWith = function (item: any) {
        if (item.fiscalcateforycd.indexOf('21') !== 0 || item.fiscalcateforycd === '2110') {
            return item;
        }
    }
    getCounty() {
        this._commonHttpService.getArrayList({ method: 'get', where : {}}, FinanceUrlConfig.EndPoint.general.userCounty + '?filter').subscribe((result) => {
          if (result !== null) {
              if (result && result.length > 0) {
                this.stateCountyCode = result[0].statecountycode;
              }
          }
        });
      }

      save() {
          // No data or function to call or add
      }
}
