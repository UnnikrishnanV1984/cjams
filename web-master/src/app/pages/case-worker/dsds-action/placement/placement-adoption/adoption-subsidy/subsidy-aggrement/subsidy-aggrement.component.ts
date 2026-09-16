
import {map, pluck, share} from 'rxjs/operators';
import { Component, OnInit, OnDestroy, ViewChild, Injector } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { DynamicObject, PaginationRequest, PaginationInfo, DropdownModel } from '../../../../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, DataStoreService, AuthService, SessionStorageService, GenericService } from '../../../../../../../@core/services';
import {ActivatedRoute, Router } from '@angular/router';
import { PlacementAdoptionService } from '../../placement-adoption.service';
import { GLOBAL_MESSAGES } from '../../../../../../../@core/entities/constants';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../../../../_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../../../../case-worker-url.config';
import { AppUser } from '../../../../../../../@core/entities/authDataModel';
import { Observable, forkJoin} from 'rxjs';
import { SpeechRecognitionService } from '../../../../../../../@core/services/speech-recognition.service';
import { SpeechRecognizerService } from '../../../../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { config } from '../../../../../../../../environments/config';
import { AppConfig } from '../../../../../../../app.config';
import { FileError, NgxfUploaderService } from 'ngxf-uploader';
import { HttpHeaders } from '@angular/common/http';
import { InvolvedPerson } from '../../../../../../../@core/common/models/involvedperson.data.model';
import { Attachment } from '../../_entities/adoption.model';
import moment from 'moment';

import { FinanceService } from '../../../../../../finance/finance.service';
import { FinanceUrlConfig } from '../../../../../../finance/finance.url.config';
import { AppConstants } from '../../../../../../../@core/common/constants';
import { AttachmentUpload } from '../../../../../_entities/caseworker.data.model';
import { DocumentUploadListSharedComponent } from '../../../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
declare let google: any;
declare var $: any;

@Component({
    selector: 'subsidy-aggrement',
    host: {
        class: 'subsidy-aggrement'
    },
    templateUrl: './subsidy-aggrement.component.html',
    styleUrls: ['./subsidy-aggrement.component.scss'],
    standalone: false
})
export class SubsidyAggrementComponent implements OnInit, OnDestroy {
  subsidyAgreementForm!: FormGroup;
  providerSearchForm!: FormGroup;
  routingForm!: FormGroup;
  currProcess!: string;
  id: string;
  speechData!: string;
  selectedViewProvider: any;
  selectedparent: any;
  adoptiveparent1!: string;
  parent1providerid!: string | null;
  parent2providerid!: string | null;
  adoptiveparent1id!: string;
  adoptiveparent2id!: string | null;
  isActivePlacement!: boolean;
  placementStrType: any;
  adoptiveparent2!: string;
  notification!: string;
  daNumber: string;
  fcpaginationInfo: PaginationInfo = new PaginationInfo();
  store: DynamicObject;
  selectedProvider: any;
  permanencyplanid!: string;
  agreementRate!: any[];
  fcProviderSearch: any;
  parent1providername!: string | null;
  parent2providername!: string | null;
  markersLocation : Array<any> = [];
  zoom!: number;
  defaultLat = 39.29044;
  defaultLng = -76.61233;
  paginationInfo: PaginationInfo = new PaginationInfo();
  fcTotal: any;
  childPlacement: any;
  breakLink: any;
  isView!: boolean;
  specialNeedsDropDown!: any[];
  relationshipDropDown!: any[];
  childCharacteristics!: any[];
  otherLocalDeptmntType!: any[];

  agreementTypeDropDown!: any[];
  disableSubmitforApproval=false;
  childPlacedfromDropDown!: any[];
  childPlacedbyDropDown!: any[];
  bundledPlcmntServicesType!: any[];
  involvedPersons$!: Observable<any[]>;
  involvedPersons: any[] = [];
  selectedIndex!: number;
  adoptionagreementrateid: any;
  genderDropdownItems!: any[];
  isEdit!: boolean;
  isSentForApproval: boolean = true;
  minAge!: number;
  maxAge!: number;
  gender!: string;
  lat = 51.678418;
  lng = 7.809007;
  showMap!: boolean;
  agreement: any;
  child: any;
  isSupervisor: boolean;
  approvalStatus!: string;
  recognizing = false;
  currentLanguage!: string;
  oldproviderid!: string | null;
  newproviderid!: string | null;
  speechRecogninitionOn!: boolean;
  token!: AppUser;
  uploadedFile: any = [];
  currentUploadedFile: any = [];
  deleteAttachmentIndex!: number;
  reportedChild!: InvolvedPerson;
  isAdoptionCase: boolean;
  childremoval: any;
  ratemaxDate: any;
  agreementMinDate: any;
  rateMinDate: any;
  disableaddrate = false;
  isAdoptionCreated!: boolean;
  agreementsignedDate: any;
  isRequired!: boolean;
  medicalAssistanceOnlyGetChecked = false;
  paymentAmountPattern = '^[1-9][0-9]*([.][0-9]{2}|)$';
  annualReviewList: any;
  isServiceCase: any;
  serviceCase!: boolean;
  overpayments!: any[];
  placmentDetails: any;
  providerDetails: any;
  provider_id: any;
  isPrivateAdoption!: boolean;
  providerid: any;

  quillToolbar = AppConstants.NARRATIVE.TOOLBAR_CONFIG;
  adoptionAlternateId: any;
  isEnddateedited!: string;
  isedited!: boolean;
  maxEndDate!: Date;
  ssaApproved!: boolean;
  initialAgreementRate= [];
  isDeleteDisabled = false;

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
  agreementCaseRoutingList!: any[];
  showSwitchAdoptiveParentReason: boolean = false;
  objectId:any = '';

  deleteattachmentpopupid = '#delete-attachment-popup';
  gettypesurl = 'referencetype/gettypes';
  searchprovider = '#searchProvider';
  effectiveSwitchMinDate : any;

  //AssistanceAgreementType
  //AssistanceAgreementType
  assistanceAgreementTypeDropdown!: any[];
  @ViewChild(DocumentUploadListSharedComponent)
  documentuploaded!: DocumentUploadListSharedComponent;

  marker = {
    position: {lat: this.lat, lng: this.lng}
  }

  mapOptions: google.maps.MapOptions = {
    center: {lat: this.lat, lng: this.lng},
    zoom : 12
  }
  
  private readonly _commonHttp: CommonHttpService;
  private readonly _formBuilder: FormBuilder;
  private readonly _alert: AlertService;
  private readonly _store: DataStoreService;
  private readonly _router: Router;
  private readonly _PlacementAdoptionService: PlacementAdoptionService;
  public _authService: AuthService;
  private readonly _alertService: AlertService;
  private readonly _session: SessionStorageService;
  private readonly _speechRecognitionService: SpeechRecognitionService;
  private readonly speechRecognizer: SpeechRecognizerService;
  private readonly _uploadService: NgxfUploaderService;
  private readonly _dataStoreService: DataStoreService;
  private readonly _financeService: FinanceService;

  placedPersonId: any;
  _bioClientId: any;
  agreementExcludeOverlapDate: any;
  private _oldServiceCaseId: any;
  private _oldPersonId: any;
  oldPlacementExitDate: any;
  placementExitDate: any;
  currentCjamsPid: any;
  maxDocumentDate: any;
  expandSubsidyDocumentCrd: boolean = false;

  constructor(
    private readonly injector : Injector,
    private readonly route: ActivatedRoute,
    private _service: GenericService<Attachment>)  {

      this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
      this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
      this._alert = this.injector.get<AlertService>(AlertService);
      this._store = this.injector.get<DataStoreService>(DataStoreService);
      this._router = this.injector.get<Router>(Router);
      this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);
      this._authService = this.injector.get<AuthService>(AuthService);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this._session = this.injector.get<SessionStorageService>(SessionStorageService);
      this._speechRecognitionService = this.injector.get<SpeechRecognitionService>(SpeechRecognitionService);
      this.speechRecognizer = this.injector.get<SpeechRecognizerService>(SpeechRecognizerService);
      this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
      this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
      this._financeService = this.injector.get<FinanceService>(FinanceService);
     
    if (route.snapshot.params) {
        this.attachmenttype = route.snapshot.params['attachmenttype'] || 'case';
        this.personid = route.snapshot.params['personid'] || '';
    }
      
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.store = this._store.getCurrentStore();
    this.id = this.store['CASEUID'];
    this.daNumber = this.store['DANUMBER'];
    this.breakLink = this.store['adoptionBreakLink'];
    if (this.store['placement_child']) {
      this.childPlacement = this.store['placement_child'];
      this.permanencyplanid = this.store['placement_child'].permanencyplanid;

      this.child = this.store[CASE_STORE_CONSTANTS.PLACED_CHILD];
      const childdob = new Date(this.child.dob);
      const dob = moment(childdob);
      this.maxEndDate = dob.add(21, 'years').toDate();
    }
    const caseType = this._store.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);

    if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
        this.isAdoptionCase = true;
    } else {
      this.isAdoptionCase = false;
    }
  }

  ngOnInit() {
    this.isDeleteDisabled = this._authService.isDisabled('adoptionplanning','adoptionplanning.subsidy.agreementdocumentdelete');
    this.isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    this.isPrivateAdoption = this._dataStoreService.getData('ISPRIVATEADOPTION');
    if (this.isServiceCase === 'true') {
      this.serviceCase = true;
    } else {
        this.serviceCase = false;
    }
    this.formInitialize();
    this.currProcess = 'search';
    this.token = this._authService.getCurrentUser();
    if (this.token.role.name === 'apcs') {
      this.isSupervisor = true;
      this.subsidyAgreementForm.disable();
    }
    this.isCW = this._authService.isCW();
    this.curDate = new Date();
    this.loadAttachmentDropdown()
    this.getAgreementListing();
    this.getDropDownList();
    this.getPlacementStrType(null);
    this.loadGenderDropdownItems();
    this.getChildCharacteristics();
    this.getOtherLocalDeptmntType();
    this.getBundledPlcmntServicesType();
    this.getReviews();
    this.getInvolvedPerson();
    this.getProgramAssignmentList();
    this.getExcludeOverlapDates();
    
    const pid = (this.child && this.child.personid) ? this.child.personid : null;
    this.getReportedChild(pid);
    if (this.childPlacement && this.childPlacement.providerdetails) {
      const providerOneId = this.childPlacement.providerdetails.provider_id ? this.childPlacement.providerdetails.provider_id : null;
      if((this.parent1providerid == null || this.parent1providerid == undefined) && providerOneId) {
         this.selectProvider(providerOneId);
      }
    }
    this.planListing();
    this.getBreaklink();
    this.subsidyAgreementForm.get('startdate')?.valueChanges.subscribe(data => {
      this._PlacementAdoptionService.setSubsidyStartDate(data);
      this._dataStoreService.setData('subsidyStartDate', data);
      this.onchangeAgreementstartdate();
    });
    this.isRequired = true;
    if (this.serviceCase) {
      this.childPlacementList();
    }
    this.currentLanguage = 'en-US';
    this.speechRecognizer.initialize(this.currentLanguage);
    this.getChildPlacedDropdown();
    this.loadAttachmentDropDown();
    this.retryDocumentFn();
  }

  private retryDocumentFn() {
    this.route.queryParams.subscribe(params => {
      if (params['retrydocument']) {
        this.expandSubsidyDocumentCrd = true;
      }
    });
  }

  onchangeAgreementstartdate() {
    const agreementDate = this.subsidyAgreementForm.getRawValue().startdate;
    if (agreementDate && this.subsidyAgreementForm.enabled) {
    this.agreementsignedDate = agreementDate;
    }
  }

  getReviews() {
    this._commonHttp.getArrayList(
        new PaginationRequest({
            page: 1,
            limit: 10,
            where: {
                adoptioncaseid: this.id },
            method: 'get'
        }),
        'adoptioniverenewal/list' + '?filter'
    ).subscribe(
        (resp) => {
            this.annualReviewList = resp;
        }
    );
  }

  printFun() {
    window.print();
  }

  formInitialize() {
    const childDOB = (this.child) ? this.child.dob : null;
    let childat18 = null;
    if (childDOB) {
      this.agreementMinDate = new Date(childDOB);
      childat18 = new Date(childDOB);
      childat18.setFullYear(childat18.getFullYear() + 18);
    }
    const enddate = new Date();
    enddate.setFullYear(enddate.getFullYear() + 1);
    enddate.setDate(enddate.getDate() - 1);

    this.subsidyAgreementForm = this._formBuilder.group({
      adoptionagreementid: [null],
      adoptionplanningid: [null],
      servicecaseid: [null],
      isofferedsubsidy: [null],
      offeraccepteddate: [null],
      startdate: [new Date()],
      enddate: [childat18],
      newenddate: [null],
      isunderappeal: [null],
      parent1signdate: [null],
      parent2signdate: [null],
      ldssdate: [null],
      issubsidypaid: [null],
      adoptionagreementrate: [null],
      ismedassist: [null],
      parent1providerid: [null],
      parent2providerid: [null],
      parent1providername: [{value:null,disabled:true}, Validators.required],
      parent2providername: [{value:null,disabled:true}],
      singleparentadoptioncheck: [null],
      adoptiveparent1signature: [null],
      adoptiveparent2signature: [null],
      ldssdirectorsignature: [null],
      agreementcomments: [null],
      childplacedby: [null],
      childplacedfrom: [null],
      switchproviderreason :[null],
      effectiveswitchdate:[null],
      switchprovider: [null],
      agreementtyperefid: [null], 
    });
    this.onchangeAgreementstartdate();
    this.providerSearchForm = this._formBuilder.group({
      childcharacteristics: [null],
      bundledplacementservices: [null],
      otherLocalDeptmntTypeId: [null],
      placementstructures: [null],
      zipcode: [null],
      isLocalDpt: [true],
      firstname: [null],
      middlename: [null],
      lastname: [null],
      isgender: [false],
      isAge: [false],
      providerid: [null],
      agemin: [null],
      agemax: [null],
      gender: [null]
    });
  }

  private getAge(dateValue: any) {
    if (dateValue && moment(new Date(dateValue), 'MM/DD/YYYY', true).isValid()) {
      const rCDob = moment(new Date(dateValue), 'MM/DD/YYYY').toDate();
      return moment().diff(rCDob, 'years');
    } else {
      return 0;
    }
  }

  resetAgreementForm() {
    this.subsidyAgreementForm.enable();
    this.subsidyAgreementForm.reset();
    this.parent1providerid = null;
    this.parent1providername = null;
    this.parent2providername = null;
    this.parent2providerid = null;
  }

  ngOnDestroy() {
    this._speechRecognitionService.destroySpeechObject();
  }

  activateSpeechToText(): void {
    this.recognizing = true;
    this.speechRecogninitionOn = !this.speechRecogninitionOn;
    if (this.speechRecogninitionOn) {
      this._speechRecognitionService.record().subscribe(
        // listener
        value => {
          this.speechData = value;
          this.subsidyAgreementForm.patchValue({ description: this.speechData });
        },
        // errror
        err => {
          this.recognizing = false;
          if (err.error === 'no-speech') {
              this.notification = `No speech has been detected. Please try again.`;
              this._alertService.warn(this.notification);
              this.activateSpeechToText();
          } else if (err.error === 'not-allowed') {
              this.notification = `Your browser is not authorized to access your microphone. Verify that your browser has access to your microphone and try again.`;
              this._alertService.warn(this.notification);
          } else if (err.error === 'not-microphone') {
              this.notification = `Microphone is not available. Plese verify the connection of your microphone and try again.`;
              this._alertService.warn(this.notification);
          }
        },
        // completion
        () => {
          this.speechRecogninitionOn = true;
          this.activateSpeechToText();
        }
      );
    } else {
      this.recognizing = false;
      this.deActivateSpeechRecognition();
    }
  }

  deActivateSpeechRecognition() {
    this.speechRecogninitionOn = false;
    this._speechRecognitionService.destroySpeechObject();
  }

  uploadclosed(event: any){
    if(event){
        this.documentuploaded.closeupload();
    }
}

  uploadFile(file: any): void {
    if (!(file instanceof Array)) {
        return;
    }
    file.map((item, index) => {
        const size = this.humanizeBytes(item.size);
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
          if (item.size <= config.uploadMaxSizeLimit) {
            this.currentUploadedFile.push(item);
            index = this.currentUploadedFile.length - 1;
            this.uploadAttachment(index);
            const audio_ext = ['mp3', 'ogg' , 'wav', 'acc', 'flac', 'aiff'];
            const video_ext = ['mp4', 'avi' , 'mov', '3gp', 'wmv', 'mpeg-4'];
            if ( audio_ext.indexOf(fileExt) >= 0) {
                this.currentUploadedFile[index].attachmenttypekey = 'Audio'
            } else if ( video_ext.indexOf(fileExt) >= 0) {
                this.currentUploadedFile[index].attachmenttypekey = 'Video';
            } else {
                this.currentUploadedFile[index].attachmenttypekey = 'Document';
            }
            this.isAttachType = this.currentUploadedFile[index].attachmenttypekey;
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

  humanizeBytes(bytes: number): string {
    if (bytes === 0) {
        return '0 Byte';
    }
    const k = 1024;
    const sizes: string[] = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
    const i: number = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  }
  uploadAttachment(index: any) {
    const adoptionagreementid = this.agreement ? this.agreement.adoptionagreementid :'';
    let uploadUrl = '';
    uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.daNumber+ '&objecttypekey=' + 'AdoptionSubsidy'   +'&objectid=' +  adoptionagreementid + '&servicecaseid=' + this.id;
    this._uploadService
        .upload({
            url: uploadUrl,
            headers: new HttpHeaders().set('ctype', 'file'),
            filesKey: ['file'],
            files: this.currentUploadedFile[index],
            process: true,
        })
        .subscribe(
            (response) => {
                if (response.status) {
                    this.currentUploadedFile[index].percentage = response.percent;
                }
                if (response.status === 1 && response.data) {
                    const doucumentInfo = response.data;
                    doucumentInfo.documentdate = doucumentInfo.date;
                    doucumentInfo.title = doucumentInfo.originalfilename;
                    doucumentInfo.name = doucumentInfo.originalfilename;
                    doucumentInfo.objecttypekey = 'AdoptionSubsidy';
                    doucumentInfo.rootobjecttypekey = 'AdoptionSubsidy';
                    doucumentInfo.servicerequestid = null;
                    this.currentUploadedFile[index] = { ...this.currentUploadedFile[index], ...doucumentInfo };
                    this.fileToSave[index] = this.currentUploadedFile[index];
                    this._alertService.success('File Upload successful.');
                }
            }, (err) => {
                this._alertService.error('Upload failed due to Server error, please try again later.');
                this.currentUploadedFile.splice(index, 1);
            }
        );
  }

  deleteAttachment() { 
    const workEnv = config.workEnvironment;
    const documentPropertiesId = this.uploadedFile[this.deleteAttachmentIndex].documentpropertiesid;
    const documentId = this.uploadedFile[this.deleteAttachmentIndex].filename;
    if(!documentPropertiesId || documentPropertiesId == undefined) {
        this.uploadedFile.splice(this.deleteAttachmentIndex, 1);
        $(this.deleteattachmentpopupid).modal('hide');
        return;
    } 
    if (workEnv === 'state') {
        const id = documentPropertiesId + '&' + documentId;
        this.handleRemoveServiceFn(id);
    } else {
        this.handleRemoveServiceFn(documentPropertiesId);
    }
  }
  // Assosiated with deleteAttachment method
  private handleRemoveServiceFn(id: string) {
    this._service.endpointUrl =
    CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteAttachmentUrl;
    this._service.remove(id).subscribe(
      result => {
        this._alertService.success('Attachment Deleted successfully!');
        this.uploadedFile.splice(this.deleteAttachmentIndex, 1);
        $(this.deleteattachmentpopupid).modal('hide');
      },
      err => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      });
  }

  confirmDeleteAttachment(index: number) {
    $(this.deleteattachmentpopupid).modal('show');
    this.deleteAttachmentIndex = index;
  }

  saveAgreementFromAdoption() { //@TM: if approval is not required then update agreement directly; call approval method
    this.saveAgreement(false);
  }

  getProgramAssignmentList() {
    const _personId = this._dataStoreService.getObj('da_personid');
    const navigationInfoData: any = localStorage.getItem('navigationInfo');
    const personinfo = JSON.parse(navigationInfoData);
    const personIdFromSession = this._session.getItem(CASE_STORE_CONSTANTS.ADOPTED_PERSON_ID);
    if(_personId) {
      this._session.setItem('ADOPTED_PERSON_ID',_personId)
    }

    //CIDM-10777 Added check to get personid from session storage when data is lost in store during page refresh.
    this.placedPersonId = _personId ?? personinfo?.personId ?? personIdFromSession;

    this. _commonHttp
        .getPagedArrayList(
            new PaginationRequest({
                where: { objectid: this.id, personid: this.placedPersonId },
                method: 'get',
                nolimit: true
            }),
            'Personprogramareas/getpersonprogramarea?filter'
        )
        .subscribe((result) => {
            if (result && Array.isArray(result) && result.length) {
              const personProgramArea = result[0]['personprogramarea'];
              this.placementExitDate = personProgramArea
                  ?.find((e: { objecttypekey: string; }) => e.objecttypekey === 'servicecase')
                  ?.startdate || null;            
              const persondetails = result[0]['persondetails'];
              this.currentCjamsPid = persondetails?.cjamspid;
              if(this.currentCjamsPid) {
                this.getBioClientId(this.currentCjamsPid)
              }
            }
        });
  }

  confirmUpdate() {
    $('#maintenance-payment-check-dialog-e').modal('show');
  }
  
  toMidnight(date: any) {
    if (!date) return null;
    const d = new Date(date);
    d.setHours(0, 0, 0, 0);
    return d;
  }

  getBioClientId(currentCjamsPid: any) {
      if(!currentCjamsPid) {
        return;
      }
      this._commonHttp.getById(currentCjamsPid, CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.GetBioClientID).subscribe(
          async (response) => {
            if(response.length === 0) {
              this.oldPlacementExitDate = null;
              return;
            }
              this._bioClientId = response?.[0].bioclientid
              this._oldServiceCaseId = response?.[0].servicecaseid
              this._oldPersonId = response?.[0].old_personid
              this.oldPlacementExitDate = await this.getPlacementDataByPerson(this._oldServiceCaseId);
          },
          _error => {
              this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          }
      );
  }

  getPlacementDataByServiceCase(id: any) {
    return this._commonHttp
    .getPagedArrayList(
      new PaginationRequest({
        page: 1,
        limit: 10,
        method: 'get',
        where: { servicecaseid:id },
      }),
      'placement/getplacementbyservicecase?filter'
    )
  }

  async getPlacementDataByPerson(servicecaseId: string){
    const result = await this.getPlacementDataByServiceCase(servicecaseId)?.toPromise();
    if (result && result.data) {
      const targetPerson = result.data.find(person => person.personid === this._oldPersonId);

      if (targetPerson && targetPerson.placements) {
          const data = targetPerson.placements;
          
          const targetPlacements = data?.filter((placement: any) =>
              placement.placementtypekey === 'PRPL' 
              && placement.isvoided === 0 &&
              (!placement.placementrevision ||
                placement.placementrevision.some((e: { status: string; approvedby: null; }) => e.status === 'Approved' && e.approvedby !== null)
              )
            );
            
          return targetPlacements.map((e: any) => new Date(e.livingenddate)).reduce((curr: any, latest: any) => curr > latest ? curr : latest, new Date(0));
          }
      }

  }

  getExcludeOverlapDates() {
    this._commonHttp.getSettings(['agreement_overlap_date']).subscribe((result)=> {
        this.agreementExcludeOverlapDate = result.settings[0].settingvalue
    })
  }

  saveAndSendAgreementForApproval() {
    const agreementStartDateRaw = this.subsidyAgreementForm.getRawValue().startdate;
    const mostRecentPlacementEndDate = this.store['placed_child']?.placements
                      ?.filter((e: { placementtypekey: string; routingstatus: string; isvoided: number; }) => e.placementtypekey === 'PRPL' && e.routingstatus === 'Approved' && e.isvoided === 0)
                      ?.map((e: any) => new Date(e.enddate))
                      ?.reduce((latest: any, current: any) => current > latest ? current : latest, new Date(0));
    const oldPlacementExitDate = this.oldPlacementExitDate ? this.toMidnight(this.oldPlacementExitDate) : null

    const agreementStartDate = agreementStartDateRaw ? this.toMidnight(agreementStartDateRaw) : null;
    const placementExitDate = mostRecentPlacementEndDate ? this.toMidnight(mostRecentPlacementEndDate) : null;

    if (agreementStartDate && placementExitDate && agreementStartDate < placementExitDate) {
        this.confirmUpdate();
        return;
    }

    if (agreementStartDate && oldPlacementExitDate && this.agreementExcludeOverlapDate && agreementStartDate < oldPlacementExitDate && oldPlacementExitDate >= new Date(this.agreementExcludeOverlapDate)) {
      this.confirmUpdate();
      return;
    }

    if(this.subsidyAgreementForm.invalid){
      this.subsidyAgreementForm.markAllAsTouched();
      this._alert.warn('Please enter all required fields')
    return;
    }
    
    if(!this.subsidyAgreementForm.getRawValue().parent1providerid && !this.providerid ){
      this._alert.error('Please Select Provider to proceed further !!')
      return;
    }
    if (this._authService.hasSupervisor()) {
      this.saveAgreement(true);
    }
  }

  saveAgreementDraft() {
    this.saveAgreement(false);
  }

  saveAgreementReq(){
    if(this.subsidyAgreementForm.getRawValue().agreementtyperefid === 'NOAGR'){
      this._alert.warn('Please enter new value for Assistance Agreement Type');
      return false;
    }
    if (!this.subsidyAgreementForm.valid) {
      this._alert.warn('Please enter all required fields');
      this.subsidyAgreementForm.markAllAsTouched();
      
      return false;
    }
    const agreementInput = Object.assign(this.subsidyAgreementForm.getRawValue());
    agreementInput.servicerequestnumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    agreementInput.servicecaseid = this.id ? this.id : null;
    agreementInput.adoptionagreementid = this.agreement ? this.agreement.adoptionagreementid : null;
    agreementInput.oldproviderid = this.oldproviderid ? this.oldproviderid : null;
    agreementInput.newproviderid = this.newproviderid ? this.newproviderid : null;
    if (this.isAdoptionCase) {
      agreementInput.adoptioncaseagreementid = this.agreement?.adoptionagreementid;
    }
    agreementInput.adoptionplanningid = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;
    agreementInput.providerid = this.providerid ? this.providerid : agreementInput.parent1providerid;
    agreementInput.attachment = this.uploadedFile;
    agreementInput.isPrivateAdoption = this.isPrivateAdoption;
    agreementInput.adoptiveparent1id = this.adoptiveparent1id;
    agreementInput.adoptiveparent2id = this.adoptiveparent2id;
    agreementInput.isagreementedit = this.isEnddateedited;
    return agreementInput;
  }

  saveAgreement(isSubmit: any) {
    
    const agreementInput = this.saveAgreementReq();
    if(agreementInput.childplacedby == 'pubagy' || agreementInput.childplacedby == 'triagy' ||
    agreementInput.childplacedby == 'priagy' || agreementInput.childplacedby == 'legargrd' ||
    agreementInput.childplacedby == 'indtsr' ||  agreementInput.childplacedby == 'bipar') {
      this._alert.error('Child Placed By needs to be Changed')
      return;
    }
    
    if(this.checkAgreementStartDateFn(agreementInput)) {
      $('#agreement-validation').modal('show');
      return;
    }
    if(agreementInput) {
    let url = '';
    let msg = '';
    url = this.isAdoptionCase ? 'adoptioncaseagreementrevision/createagreementrevision' : 'adoptionagreementrevision/createagreementrevision';
    msg = isSubmit ? 'submitted' : 'saved';
    this.disableSubmitforApproval=true;
    this._commonHttp.create(agreementInput, url).subscribe(res => {
      this.handleCreateagreementrevisionResponseFn(res, msg, isSubmit);
    },
    err => {
      this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      this.disableSubmitforApproval=false;
    });
  }
  }
  // Assosiated with saveAgreement method
  private handleCreateagreementrevisionResponseFn(res: any, msg: string, isSubmit: any) {
    if (res) {
      this._alert.success('Subsidy Agreement ' + msg + ' successfully');
      if (isSubmit) {
        this.sendAgreementForReview(res.adoptionagreementid);
      }
    } else {
      this._alert.error('Unable to process request');
      this.disableSubmitforApproval = false;
    }
    this.getAgreementListing();
  }

  private checkAgreementStartDateFn(agreementInput: any) {
    return agreementInput.startdate && this.agreement && Array.isArray(this.agreement.agreementrate) && this.agreement.agreementrate.length && this.agreement.agreementrate[0].typedescription == 'Approved' && (agreementInput.startdate > moment(this.agreement.agreementrate[0].startdate));
  }

  sendAgreementForReview (adoptionagreementid: any) {
    let url = '';
    url = this.isAdoptionCase ? 'adoptioncaseagreement/routeagreement' : 'adoptionagreement/routeagreement';

    const submitStatus = Object.assign({
      servicerequestnumber: this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER),
      adoptionagreementid: adoptionagreementid ? adoptionagreementid : this.agreement.adoptionagreementid,
      adoptioncaseagreementid: this.isAdoptionCase ? adoptionagreementid : null,
      statustypeid: 15,
      servicecaseid: this.id,
      adoptioncaseid: this.isAdoptionCase ? this.id : null
    });
    this._commonHttp.create(submitStatus, url).subscribe(res => {
        this._alert.success('Subsidy agreement submitted successfully');
        this.getAgreementListing();
      },
      err => {
        console.error(err);
      }
    );    
  }

  supervisorDecision(status: any) {
    let url = '';
    url = this.isAdoptionCase ? 'adoptioncaseagreement/add' : 'adoptionagreement/add';
    const statustypeid = (status == 'Approved') ? 16 : 17;

    const submitStatus = Object.assign({
      servicerequestnumber: this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER),
      adoptionagreementid: this.agreement.adoptionagreementid,
      adoptioncaseagreementid: this.isAdoptionCase ? this.agreement.adoptionagreementid : null,
      statustypeid: statustypeid,
      servicecaseid: this.id,
      adoptioncaseid: this.isAdoptionCase ? this.id : null
    });
    this._commonHttp.create(submitStatus, url).subscribe(
      res => {
        this.approvalStatus = status;
        this.getChildPlacedDropdown();
        this._alert.success('Subsidy Agreement '+ status +' successfully');
        this.getAgreementListing();
      },
      err => { 
        this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  downloadFile(s3bucketpathname: any) {
    s3bucketpathname = s3bucketpathname.replace(/,/g, '');
    const downldSrcURL =  '/api' + s3bucketpathname;
    window.open(downldSrcURL, '_blank');
  }

  getInvolvedPerson() {
    let reqObj = {};
      reqObj = {
        objectid: this.id,
        objecttypekey: 'servicecase'
      };
    this.involvedPersons$ = this._commonHttp
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: reqObj
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
      ).pipe(
        share(),
        pluck('data'),);
    this.involvedPersons$.subscribe((items) => {
      if (items) {
        this.handleInvolvedPersonListApiResponseFn(items);
      }
    });
  }
  // Associated with getInvolvedPerson method
  private handleInvolvedPersonListApiResponseFn(items: any[]) {
    const person = items.filter((item) => {
      if (!item.rolename || item.rolename === '') {
        if (item.roles && item.roles.length && item.roles[0].intakeservicerequestpersontypekey) {
          item.rolename = item.roles[0].intakeservicerequestpersontypekey;
        }
      }
      if (item.rolename === 'ADOPTPARNT') {
        if (!item.intakeservicerequestactorid) {
          if (item.roles && item.roles.length && item.roles[0].intakeservicerequestactorid) {
            item.intakeservicerequestactorid = item.roles[0].intakeservicerequestactorid;
          }
        }
        return item;
      }
    });
    this.involvedPersons = person.map((res) => res);
  }

  getAgreementListing() {
    const planningid = this.returnPlanningIdFn();
    let url = '';
    let obj;

    if (this.isAdoptionCase) {
      url = 'adoptioncaseagreement/list?filter';
      obj = { adoptioncaseid: this.id };
    } else {
      url = 'adoptionagreement/list?filter';
      obj = { adoptionplanningid: planningid };
    }

    this._commonHttp
      .getSingle(
        new PaginationRequest({
          where: obj,
          method: 'get',
          page: 1,
          limit: 10
        }),
        url
      )
      .subscribe(res => {
        if (res && res.length && Array.isArray(res)) {
          const obcj = res[0];
          const agreementList = this.isAdoptionCase ? obcj.getadoptioncaseagreementlist : obcj.getadoptionagreementlist;
          if (agreementList && agreementList.length) {
            this.handleIfAgreementListFn(agreementList);
          }
        }
      });
  }
  // Assosiated with getAgreementListing methods
  private returnPlanningIdFn() {
    let planningid = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;
    if (this.isSupervisor && this.isAdoptionCase) {
      planningid = this.store[CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID];
    }
    if (!planningid) {
      planningid = this.store[CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID];
    }
    if (!planningid) {
      planningid = this.store['adoptionAgreement'] ? this.store['adoptionAgreement'].adoptionplanningid : null;
    }
    if (!this.isSupervisor && this.isAdoptionCase) {
      planningid = this._session.getItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID);
    }
    return planningid;
  }
  // Assosiated with getAgreementListing method
  private handleIfAgreementListFn(agreementList: any) {
    const length = agreementList.length - 1;
    this.agreement = agreementList[length];
    const adoptionagreementid = this.agreement.adoptionagreementid ? this.agreement.adoptionagreementid : '';
    this.objectId = adoptionagreementid;
    this.adoptionAlternateId = agreementList[length].alternateid;
    this._dataStoreService.setData('adoptionAlternateID', this.adoptionAlternateId);
    this.permanencyplanid = agreementList[length].permanencyplanid;
    this.uploadedFile = agreementList[length].attachments ? agreementList[length].attachments : [];
    if (this.agreement.enddate == undefined || this.agreement.enddate == null) {
      this.agreement.enddate = this.getEndDate();
    }
    if (agreementList[0].switchprovider) {
      this.showSwitchAdoptiveParentReason = true;
      this.effectiveSwitchMinDate = this.getRateStartDate();
    }
    this.subsidyAgreementForm.patchValue(this.agreement, { emitEvent: false });

    this.parent1providerid = this.subsidyAgreementForm.getRawValue().parent1providerid;
    this.parent2providerid = this.subsidyAgreementForm.getRawValue().parent2providerid;
    this.parent1providername = this.subsidyAgreementForm.getRawValue().parent1providername;

    if (this.parent1providerid && this.agreement.parent2providerid && this.parent1providerid == this.agreement.parent2providerid && this.agreement.routingstatus !== 'Approved') {
      this.selectProvider(this.parent1providerid);
    } else if (this.parent1providerid && this.agreement.parent2providerid && this.parent1providerid == this.agreement.parent2providerid && this.agreement.provider_id_check) {
      this.parent2providerid = this.agreement.provider_id_check;
      this.subsidyAgreementForm.patchValue({
        parent2providerid: this.agreement.provider_id_check
      });
    }
    if (this.agreement.auditinfo) {
      this.agreementCaseRoutingList = this.agreement.auditinfo;
    }
    this._store.setData('adoptionAgreement', this.agreement);
    this.approvalStatus = this.agreement.routingstatus;
    this.getChildPlacedDropdown();
  }

  getEndDate(){
    let enddate = this.agreement.enddate;
    if(this.store && this.store['CHILD']){
      const childdob = new Date(this.store['CHILD'].dob);
      const dob = moment(childdob);
      enddate = dob.add(18, 'years').toDate(); // Default value =18th bday if nothing set.
      if (Array.isArray(this.agreement.agreementrate) && this.agreement.agreementrate.length) {
        const rate = this.agreement.agreementrate[this.agreement.agreementrate.length - 1];
        const rateenddate = new Date(rate.enddate);
        rateenddate.setHours(0, 0, 0, 0);
        if(enddate < rateenddate){
          const cDob = moment(childdob);
          enddate = cDob.add(21, 'years').toDate(); //If enddate of latest rate agreement is after 18th bday, then 21st
        }
      }
    }
    return enddate;
  }

  getDropDownList() {

    this._commonHttp
      .getArrayList(
        {
          method: 'get',
          where: {
            referencetypeid: 5465,
            teamtypekey: 'CW'
          }
        },
        this.gettypesurl + '?filter'
      )
      .subscribe((items) => {
        this.assistanceAgreementTypeDropdown = items;
        let index;
        let isExist = [];
        if(this.agreement && this.agreement.agreementtyperefid && this.agreement.agreementtyperefid == 'NOAGR'){
          isExist = this.assistanceAgreementTypeDropdown.filter((itemRef: any) => (itemRef.ref_key == 'ATGAA' || itemRef.ref_key == 'TIGAA'));
        } else{
          isExist = this.assistanceAgreementTypeDropdown.filter((itemRefKey: any) => (itemRefKey.ref_key == 'ATGAA' || itemRefKey.ref_key == 'TIGAA' || itemRefKey.ref_key == 'NOAGR'));
        }
        for (const element of isExist) {
            index = this.assistanceAgreementTypeDropdown.findIndex((item:any)=>(item.ref_key == element.ref_key));
            if (index > -1) {
                this.assistanceAgreementTypeDropdown.splice(index, 1);
            }
        }
      });

    this._commonHttp
      .getArrayList(
        {
          method: 'get',
          where: {
            referencetypeid: 110,
            teamtypekey: 'CW'
          }
        },
        this.gettypesurl + '?filter'
      )
      .subscribe((item) => {
        this.specialNeedsDropDown = item;
      });

    this._commonHttp
      .getArrayList(
        {
          method: 'get',
          where: {
            referencetypeid: 900,
            teamtypekey: 'CW'
          }
        },
        this.gettypesurl + '?filter'
      )
      .subscribe((item) => {
        this.childPlacedfromDropDown = item;
      });
    this._commonHttp
      .getArrayList(
        {
          method: 'get',
          where: {
            referencetypeid: 109,
            teamtypekey: 'cw'
          }
        },
        this.gettypesurl + '?filter'
      )
      .subscribe((item) => {
        this.relationshipDropDown = item;
      });
  }

  getChildPlacedDropdown(){
    this.childPlacedbyDropDown = [];
    this._commonHttp
    .getArrayList(
      {
        method: 'get',
        where: {
          referencetypeid: 901,
          teamtypekey: 'CW'
        }
      },
      this.gettypesurl + '?filter'
    )
    .subscribe((items) => {
      const removeList = ['bipar','indtsr','legargrd','priagy','pubagy','triagy'];
     if(this.approvalStatus &&this.agreement && this.agreement.childplacedby) {
       if(this.agreement.childplacedby == 'priaug' || this.agreement.childplacedby == 'iveag') {
         this.childPlacedbyDropDown = items.filter(itemRef => !removeList.includes(itemRef.ref_key));
       } else {
       const selectedRecord =  items.filter(itemRefKey => itemRefKey.ref_key == this.agreement.childplacedby);
        this.childPlacedbyDropDown = items.filter(itemKey => !removeList.includes(itemKey.ref_key));
        this.childPlacedbyDropDown.push(selectedRecord[0]);
       }
     } else {
      this.childPlacedbyDropDown = items.filter(itemKeyRef => !removeList.includes(itemKeyRef.ref_key));
     }
    });
  }

  onSearchParents() {
    const child = this.store['placed_child'];
    if (child) {
      const childage = this.getAge(child.dob);
      const min = 0;
      const max = childage;
      this.providerSearchForm.patchValue({
        isgender: false,
        isAge: false,
        agemin: min,
        agemax: max,
        gender: child.gender
      });
    }
    $(this.searchprovider).modal('show');
  }

  getChildCharacteristics() {
    this._commonHttp.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '43'
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.childCharacteristicsUrl).subscribe(result => {
      this.childCharacteristics = result;
    });
  }

  getOtherLocalDeptmntType() {
    this._commonHttp.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '104'
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.otherLocalDeptmntTypeUrl).subscribe(result => {
      this.otherLocalDeptmntType = result;
    });
  }

  getBundledPlcmntServicesType() {
    this._commonHttp.getArrayList(new PaginationRequest({
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.bundledPlcmntServicesTypeUrl).subscribe(result => {
      this.bundledPlcmntServicesType = result;
    });
  }

  fcPageChanged(pageEvent: any) {
    this.paginationInfo.pageNumber = pageEvent.page;
    this.getFcProviderSearch();
  }

  resetproviderSearchForm() {
    this.providerSearchForm.reset();
    this.currProcess = 'search';
  }

  onSearchParent1() {
    const child = this.store['placed_child'];
    if (child) {
      const childage = this.getAge(child.dob);
      const min = 0;
      const max = childage;
      this.providerSearchForm.patchValue({
        isgender: true,
        isAge: true,
        agemin: min,
        agemax: max,
        gender: child.gender
      });
    }
    $(this.searchprovider).modal('show');
    this.selectedparent = 'parent1';
  }

  selectProvider(providerid: any) {
    const srcProviderId = providerid ? providerid : this.returnProviderIdFn();
    if (srcProviderId) {
      this._commonHttp.getArrayList(
        {
          where: { providerid: srcProviderId },
          method: 'get'
        },
        'adoptionagreement/getparentnames?filter'
      ).subscribe(res => {
        if (res[0]) {
          this.handleParentnamesResponseFn(res);
        }
      });
    }

    $(this.searchprovider).modal('hide');
    this.resetproviderSearchForm();
  }
  // Assosiated with selectProvider method
  private returnProviderIdFn() {
    return ((this.selectedProvider && this.selectedProvider.provider_id) ? this.selectedProvider.provider_id : null);
  }
  // Assosiated with selectProvider method
  private handleParentnamesResponseFn(res: any[]) {
    const getadoptiveparents = res[0].getadoptiveparents;
    if (getadoptiveparents.length) {
      const parent1 = getadoptiveparents.find((parent: { adoptiveparent1: any; }) => parent.adoptiveparent1);
      const parent2 = getadoptiveparents.find((parent: { adoptiveparent2: any; }) => parent.adoptiveparent2);

      this.patchSubsidyAgreementFormProviderDataFn(parent1, parent2);

      this.adoptiveparent1id = (parent1 && parent1.adoptiveparent1id) ? parent1.adoptiveparent1id : null;
      this.adoptiveparent2id = (parent2 && parent2.adoptiveparent2id) ? parent2.adoptiveparent2id : null;
      this.providerid = (parent1 && parent1.providerid) ? parent1.providerid : null;
    }
  }
  // Assosiated with selectProvider method
  private patchSubsidyAgreementFormProviderDataFn(parent1: any, parent2: any) {
    this.parent1providerid = this.returnParent1provideridFn(parent1);
    this.parent1providername = (parent1 && parent1.adoptiveparent1) ? parent1.adoptiveparent1 : null;
    this.parent2providerid = (parent2 && parent2.provider2id) ? parent2.provider2id : null;
    this.parent2providername = parent2 ? parent2.adoptiveparent2 : null;
    this.subsidyAgreementForm.patchValue({
      parent1providername: (parent1 && parent1.adoptiveparent1) ? parent1.adoptiveparent1 : this.parent1providername,
      parent1providerid: (parent1 && parent1.providerid) ? parent1.providerid : null,
      parent2providername: parent2 ? parent2.adoptiveparent2 : null,
      parent2providerid: (parent2 && parent2.providerid) ? parent2.providerid : null,
    });
  }
  // Assosiated with selectProvider method
  private returnParent1provideridFn(parent1: any): string | null {
    return ((parent1 && parent1.providerid) ? parent1.providerid : this.returnParent1ProvideridFn());
  }
  // Assosiated with selectProvider method
  private returnParent1ProvideridFn(): string | null {
    return (this.subsidyAgreementForm.getRawValue().parent1providerid ? this.subsidyAgreementForm.getRawValue().parent1providerid : null);
  }

  select2ndProvider(providerid: any) {
    const srcProviderId = providerid ? providerid : this.returnProviderIdFn();
    if (srcProviderId) {
        this._commonHttp.getArrayList(
            {
                where: { providerid: srcProviderId },
                method: 'get'
            },
            'adoptionagreement/getparentnames?filter'
        ).subscribe(res => {
          if (res[0]) {
            this.handleSelect2ndProviderResponseFn(res);
          }
        });
    }

    $(this.searchprovider).modal('hide');
    this.resetproviderSearchForm();
  }
  // Assosiated with select2ndProvider method
  private handleSelect2ndProviderResponseFn(res: any[]) {
    const getadoptiveparents = res[0].getadoptiveparents;
    if (getadoptiveparents.length) {
      const parent1 = getadoptiveparents.find((parent: { adoptiveparent1: any; }) => parent.adoptiveparent1);
      this.parent1providerid = (parent1 && parent1.providerid) ? parent1.providerid : null;
      this.parent1providername = this.subsidyAgreementForm.getRawValue().parent1providername;

      this.subsidyAgreementForm.patchValue({
        parent1providername: (parent1) ? parent1.adoptiveparent1 : null,
        parent1providerid: (parent1 && parent1.providerid) ? parent1.providerid : null,
        parent2providername: null,
        parent2providerid: null,
        parent2signdate: null,
        switchprovider: true
      });
      this.parent2providerid = null;
      this.parent2providername = null;
      this.adoptiveparent2id = null;
      this.subsidyAgreementForm.get('adoptiveparent2signature')?.reset();
    }
  }

  CheckFormControlValue(formControl: any) {
    return (formControl && formControl !== '') ? formControl : null;
  }

  getFcProviderSearch() {
    if (this.providerSearchForm.invalid) {
      this._alertService.error('Please fill required fields');
      return false;
    }

    if (this.child) {
      const childage = this.getAge(this.child.dob);
      const isAgeChecked = this.providerSearchForm.get('isAge')?.value;
      const isGenderChecked = this.providerSearchForm.get('isgender')?.value;

      this.providerSearchForm.patchValue({
        agemin: isAgeChecked ? 0 : null,
        agemax: isAgeChecked ? childage : null,
        gender: isGenderChecked ? this.child.gender : null
      });
    }
    const formValues = this.providerSearchForm.getRawValue();
    if (formValues.isgender && !formValues.gender) {
      this._alertService.error('Please select gender');
      return false;
    }
    formValues.gender = formValues.isgender ? this.returnGenderFn(formValues) : null;

    Object.keys(this.providerSearchForm.controls).forEach(key => {
      formValues[key] = this.CheckFormControlValue(formValues[key]);
    });
    const body: any = {};
    Object.assign(body, formValues);
    body['isLocalDpt'] = true;
    body['localdepartmenthomecaregiver'] = true;
    body['childcharacteristics'] = formValues.childcharacteristics ? formValues.childcharacteristics[0] : null;
    body['otherLocalDeptmntTypeId'] = formValues.otherLocalDeptmntTypeId ? formValues.otherLocalDeptmntTypeId[0] : null;
    body['placementstructures'] = formValues.placementstructures ? formValues.placementstructures[0] : null;
    body['bundledplacementservices'] = formValues.bundledplacementservices ? formValues.bundledplacementservices[0] : null;
    body['adoption'] = true;

    this._commonHttp.getPagedArrayList(new PaginationRequest({
      where: body,
      page: this.paginationInfo.pageNumber,
      limit: 10,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fcProviderSearchUrl).subscribe(result => {
      this.fcProviderSearch = result.data;
      this.fcTotal = result.count;
      $('#fc_list').click();
      this.currProcess = 'select';
    });
  }
  // Assosiated with getFcProviderSearch method
  private returnGenderFn(formValues: any): any {
    return (formValues.gender ? formValues.gender : null);
  }

  backToSearchList() {
    this.currProcess = 'select';
    this.selectedProvider = null;
  }

  backToSearch() {
    const child = this.store['placed_child'];
    if (child) {
      const childage = this.getAge(child.dob);
      const min = 0;
      const max = childage;
      this.providerSearchForm.patchValue({
        isgender: false,
        isAge: false,
        agemin: min,
        agemax: max,
        gender: child.gender
      });
    }
    this.currProcess = 'search';
    this.selectedProvider = null;
  }

  getRangeArray(n: number): any[] {
    return Array(n);
  }

  listMap(provider: any) {
    this.zoom = 13;
    this.defaultLat = 39.29044;
    this.defaultLng = -76.61233;
    this.markersLocation = [];
    const geocoder = new google.maps.Geocoder();
    if (geocoder) {
      geocoder.geocode({ 'address': provider.providerdetails[0].address },  (results: any, status: any) => {
        if (status === google.maps.GeocoderStatus.OK) {
          this.markersLocation = [];
          const marker = { lat: results[0].geometry.location.lat(), lng: results[0].geometry.location.lng() };
          this.lat = marker.lat;
          this.lng = marker.lng;
          this.markersLocation.push(marker);
          this.defaultLat = marker.lat;
          this.defaultLng = marker.lng;
          $('#map-popup').modal('show');
          setTimeout(() => {
            this.showMap = true;
          }, 300);

        }
      });
    }
  }

  selectedViewProv(provId: any) {
    this.selectedViewProvider = provId;
  }

  selectedProv(provId: any) {
    this.selectedProvider = provId;
  }

  getPlacementStrType(providerId: any) {
    this._commonHttp.getArrayList(new PaginationRequest({
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

  loadGenderDropdownItems() {
    this._commonHttp.create(
      {
        where: { activeflag: 1 },
        method: 'post'
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.GenderTypeUrl + '/genderlist'
    ).subscribe((genderList) => {
      this.genderDropdownItems = genderList;
    });
  }

  closeMap() {
    this.markersLocation = [];
    this.showMap = false;
    $('#map-popup').modal('hide');
  }

  private planListing() {
    this._commonHttp.getSingle(
      {
        method: 'get',
        page: 1,
        limit: 10,
        where: { objectid: this.id }
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PermanencyPlan.PermanencyPlanList + '?filter'
    ).subscribe(res => {
      if (res.data && res.data.length) {
        res.data.map((plan: any) => {
          if (plan.status === 'Approved') {
            if (plan.primarypermanency.length) {
                this._store.setData('permanencyPlan', plan, true);
            }
          }
        });
      }
    });
  }

  private getReportedChild(childActorId?: any) {
     const reqObj = this.serviceCase 
        ? { objectid: this.id, objecttypekey: 'servicecase' } 
        : { intakeserviceid: this.id };

    this._commonHttp
      .getSingle(
          {
              method: 'get',
              where: reqObj
          },
          CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
      )
      .subscribe(res => {
          if (res && res.data) {
            this.handleChildActorIdFn(childActorId, res);
            if (this.child && this.child.cjamspid) {
            this.getOverPaymentList(this.parent1providerid, this.child.cjamspid);
            }
            if (this.child) {
              const childdob = new Date(this.child.dob);
              const dob = moment(childdob);
              this.maxEndDate = dob.add(21, 'years').toDate();
            }
           }
      });
  }
  // Assosiated with getReportedChild method
  private handleChildActorIdFn(childActorId: any, res: any) {
    if (childActorId) {
      const repChild = res.data.filter((child: { personid: any; }) => child.personid === childActorId);
      if (repChild && repChild.length) {
        this.reportedChild = repChild[0];
        this.child = repChild[0];
      }
    } else {
      this.child = res.data.find((item: { rolename: string; }) => item.rolename === 'CHILD');
    }
  }

  private getBreaklink() {
    this._commonHttp
      .getArrayList({
        method: 'get', where: {
          adoptionplanningid: this._PlacementAdoptionService.getAdoptionPlanning().adoptionplanningid
        }
      }, 'adoptionbreakthelink/getadoptionbreakthelink?filter')
      .subscribe(res => {
        if (res && res.length) {
          res.forEach((item) => {
            if(item && item.getadoptionbreakthelink){
              this.returnBreakLineFn(item);
            }
          });
        }
      });
  }
  // Assosiated with getBreaklink method
  private returnBreakLineFn(item: any) {
    return item.getadoptionbreakthelink.map((breaklink: { adoptioncasenumber: any; }) => {
      this.isAdoptionCreated = (breaklink.adoptioncasenumber) ? true : false;
      return breaklink;
    });
  }

  onChange() {
    const getchecked = this.subsidyAgreementForm.getRawValue().singleparentadoptioncheck;
    if (getchecked === true) {
      this.subsidyAgreementForm.controls['parent2providername'].clearValidators();
      this.subsidyAgreementForm.controls['parent2providername'].updateValueAndValidity();
    } else {
      this.subsidyAgreementForm.controls['parent2providername'].setValidators([Validators.required]);
      this.subsidyAgreementForm.controls['parent2providername'].updateValueAndValidity();
    }
  }

  medicalAssistanceOnly() {
    this.medicalAssistanceOnlyGetChecked = this.subsidyAgreementForm.getRawValue().ismedassist;
    if (this.medicalAssistanceOnlyGetChecked === true) {
      this.paymentAmountPattern = '^[1-9][0-9]*([.][0-9]{2}|)$';
    } else {
      this.paymentAmountPattern = '^[0-9][0-9]*([.][0-9]{2}|)$';
    }
  }

  childPlacementList() {
    this._commonHttp
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 10,
          method: 'get',
          where: { servicecaseid: this._store.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        }),
        'placement/getplacementbyservicecase?filter'
      ).subscribe(result => {
        if (result && result.data) {
          this.handleChildPlacementListAPiRespFn(result);
        }
    });
  }
  // Assosiated with childPlacementList method
  private handleChildPlacementListAPiRespFn(result: any) {
    if (this.serviceCase && this.store['placed_child']) {
      this.reusablePlacedChildFn(result, this.store['placed_child'].cjamspid);
    } else {
      if (this.child && this.child.cjamspid) {
        this.reusablePlacedChildFn(result, this.child.cjamspid);
      }
    }
  }
  // Assosiated with childPlacementList method
  private reusablePlacedChildFn(result: any, placedChildId: any) {
    this.placmentDetails = result.data.find((item: { cjamspid: any; }) => item.cjamspid === placedChildId);
    this.providerDetails = (this.placmentDetails && this.placmentDetails.placements && this.placmentDetails.placements.length && this.placmentDetails.placements[0].providerdetails) ?
      this.placmentDetails.placements[0].providerdetails : null;
    if (this.providerDetails) {
      this.getOverPaymentList(this.providerDetails.provider_id, placedChildId);
    }
  }

  getOverPaymentList(providerID: any, clientid: any) {
    this._commonHttp.getPagedArrayList({
        where: {
          providerid: providerID,
          client_id: clientid
        },
        page: 1,
        limit: null,
        nolimt: true,
        method: 'get'
      }, FinanceUrlConfig.EndPoint.accountsReceivable.overpayments.list).subscribe((res: any) => {
        if (res && res.data && res.data.length) {
          this.overpayments = res.data;
        }
      });
  }

  fiscalAudit() {
    this._financeService.getChangeHistory(1, this.adoptionAlternateId, 'adoptionrate');
  }

  agreementenddatechange() {
    const enddate = this.subsidyAgreementForm.getRawValue().enddate;
    const newenddate = new Date(enddate);
    const currEnddate = new Date(this.agreement.enddate);
    if (newenddate && currEnddate) {
      newenddate.setHours(0, 0, 0, 0);
      currEnddate.setHours(0, 0, 0, 0);
      this.isEnddateedited = (newenddate.valueOf() === currEnddate.valueOf()) ? 'no' : 'yes';
    }
    if (Array.isArray(this.agreement.agreementrate) && this.agreement.agreementrate.length) {
      const rate = this.agreement.agreementrate[this.agreement.agreementrate.length - 1];
      const rateenddate = new Date(rate.enddate);
      rateenddate.setHours(0, 0, 0, 0);
      if (newenddate < rateenddate) {
        this._alertService.warn('New end date cannot be less than the last rate end date.');
        this.subsidyAgreementForm.patchValue({ enddate: this.agreement.enddate });
      }
    }
  }

  goTotheAnnualReviewPage(){
    const currentUrl = '/pages/case-worker/' +  this.id + '/'
    + this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER)
    + '/dsds-action/placement/adoption/adoption-subsidy/adoption-annual-reviews';
    this._router.navigate([currentUrl]);
  }
  getErrorsMessage(ControlName: any, displayName: any){
    if(this.subsidyAgreementForm.controls[ControlName].status =='INVALID' ){
    return 'Please enter valid ' + displayName
    }
    }
  // upload attachment 
  clearAllUpload() {
    $('#upload-attachment').modal('hide');
    this.currentUploadedFile = [];
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
      this._commonHttp
      .getSingle(
          {},
          CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
      )
      .subscribe(data => {
          const dp_att_arr: any[] = [];
        if (data && data.length > 0) {
          this.attachmentClassificationtypelookup = data;
          for (let i = 0; i < this.attachmentClassificationtypelookup.length; i++) {
            if (this.attachmentClassificationtypelookup[i].typedescription && dp_att_arr.indexOf(this.attachmentClassificationtypelookup[i].typedescription) < 0) {
              this.handleTypedescriptionUsingRoleFn(i, dp_att_arr);
            }
          }
        }
      });
      const source = forkJoin([
          this._commonHttp.getArrayList(
              {
                  nolimit: true
              },
              CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl + '?filter={"nolimit": true}'
          )
      ]).pipe(
        map((result) => {
              return {
                  attachmentType: result[0].map(
                      (res) =>
                          new DropdownModel({
                              text: res.typedescription,
                              value: res.attachmenttypekey
                          })
                  ),
              };
          }),
          share(),);
      this.attachmentTypeDropdown$ = source.pipe(pluck('attachmentType'));
  }
  // Assosiated with loadAttachmentDropdown method
  private handleTypedescriptionUsingRoleFn(i: number, dp_att_arr: any[]) {
    if (this.isCW) {
      if (this.attachmentClassificationtypelookup[i].typedescription.startsWith('CW-')) {
        this.attachmentClassificationtype.push({ typedescription: this.attachmentClassificationtypelookup[i].typedescription });
        dp_att_arr.push(this.attachmentClassificationtypelookup[i].typedescription);
      }
    } else {
      this.attachmentClassificationtype.push({ typedescription: this.attachmentClassificationtypelookup[i].typedescription });
      dp_att_arr.push(this.attachmentClassificationtypelookup[i].typedescription);
    }
  }

  categoryUpdate(event: any, index: any) {
      if (event.target.value !== '')  {
          this.isCate  = event.target.value;
      }
      this.issubCate  = '';
      this.currentUploadedFile[index].attachmentclassificationsubtypekey = '';
      this.currentUploadedFile[index].attachmentClassificationsubtype = [];
      this.currentUploadedFile[index].attachmentclassificationtypekey = event.target.value;
      if (event.target.value) {
          this.currentUploadedFile[index].invalidAttachmentClassify = false;
          for (const element of this.attachmentClassificationtypelookup) {
              if (element.typedescription === this.currentUploadedFile[index].attachmentclassificationtypekey) {
                  this.currentUploadedFile[index].attachmentClassificationsubtype.push({subcategory: element.subcategory});
              }
          }
      } else {
          this.currentUploadedFile[index].invalidAttachmentClassify = true;
      }
  }

  subcategoryUpdate(event: any, index: any) {
      if (event.target.value !== '')  {
          this.issubCate  = event.target.value;
      }
      this.currentUploadedFile[index].attachmentclassificationsubtypekey = event.target.value;
      if (event.target.value) {
          this.currentUploadedFile[index].invalidAttachmentsubClassify = false;
      } else {
          this.currentUploadedFile[index].invalidAttachmentsubClassify = true;
      }
  }

  
  descUpdate(event: any, index: any) {
      this.uploadedFile[index].description = event.target.value;
  }

  otherUpdate(event: any, index: any) {
    this.currentUploadedFile[index].other = event.target.value;
  }

  docDateUpdate(event: any, index: any) {
      this.currentUploadedFile[index].docDate = event.target.value;
  }

  docDateAddUpdate(event: any, index: any) {
      this.currentUploadedFile[index].actualdocumentdate = event;
  }

  deleteUpload(index: any) {
      this.uploadedFile.splice(index, 1);
      this.fileToSave.splice(index, 1);
  }

  saveAttachmentDetails() {
    if (this.currentUploadedFile.length !== this.fileToSave.length) {
        this._alertService.error('Please wait till files get uploaded');
    } else {
        const checkMandatory = this.currentUploadedFile.filter((item: any) => (!item.other && item.enableOtherTxt) || !item.actualdocumentdate ||  !item.attachmentclassificationsubtypekey ||  !item.attachmentclassificationtypekey || !item.title)
        if(checkMandatory.length > 0) {
            this._alertService.error('Please fill all mandatory fields');
        } else {
            $('#upload-attachment').modal('hide');
            this.currentUploadedFile.map((data: any)=>{
              this.uploadedFile.push(data)
            }  ) 
            this.currentUploadedFile =[];
            
        }
    }
  }

  
  switchAdoptiveParent() {
    this.showSwitchAdoptiveParentReason = true;
    this.oldproviderid = this.parent1providerid;
    this.newproviderid = this.parent2providerid; 
    if(this.parent2providerid) {
      this.select2ndProvider(this.parent2providerid);
    }
  }

  
  attachmentDropDownList_parent: any[] = [];
  attachmentDropDownList_child: any[] = [];
  loadAttachmentDropDown() {
      this._commonHttp.getArrayList(
              {
                  method: 'get',
                  where: {
                      referencetypeid: 1000,
                      teamtypekey: 'CW',
                      order: 'displayorder ASC'
                  }
              },
              this.gettypesurl + '?filter'
          )
          .subscribe((item) => {
              for (const element of item) {
                  if(element.parentkey === null ){
                      this.attachmentDropDownList_parent.push(element);
                  }else{
                      this.attachmentDropDownList_child.push(element);
                  }
              }
          });
  }

  childArray: any[] = [];
  parentVal = '';
  seletedVal = ''
  enablOtherTxt = false;
  openChildMenu(parentVal: any, ref_key: any) {
      this.parentVal = parentVal;
      this.childArray = [];
      const isExist = this.attachmentDropDownList_child.filter((item: any) => (item.parentkey === ref_key));
      if (isExist) {
          this.childArray = [...isExist];
      }
  }
  
  selectChildMenu(childVal: any, index: any) {
      this.enablOtherTxt = false;
      this.currentUploadedFile[index].enableOtherTxt = false;
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
      this.currentUploadedFile[index].title = this.currentUploadedFile[index].attachmentclassificationsubtypekey;
      if(childVal.includes('Other','other')){
          this.enablOtherTxt = true;
          this.currentUploadedFile[index].enableOtherTxt = true;
      }
  }
  
  selectedItem(index: any) {
      if (!this.currentUploadedFile[index].attachmentclassificationtypekey) {
          this.seletedVal = 'Title';
      } else {
          this.seletedVal = this.currentUploadedFile[index].attachmentclassificationsubtypekey;
      }
      return this.seletedVal
  }

  getRateStartDate() {
    if (Array.isArray(this.agreement.agreementrate) && this.agreement.agreementrate.length) {
      const rate = this.agreement.agreementrate[this.agreement.agreementrate.length - 1];
      return new Date(rate.startdate);
    }
}

  switchDateValidation(){
    if (this.effectiveSwitchMinDate && (new Date(this.subsidyAgreementForm.value.effectiveswitchdate).setHours(0,0,0,0) < this.effectiveSwitchMinDate.setHours(0, 0, 0, 0))) {
      this._alertService.error('Effective Date can not be selected prior to the Current Subsidy Rate Slab Start Date. Please raise a contact support ticket if the Switch Effective Date is prior to Current Subsidy Rate Slab Start Date for Data fix');
      return false;
    }
  }

  get returnFullnameFn() {
    return this.reportedChild?.firstname + ' ' + this.reportedChild?.lastname
  }

  onNativeDrop(event: DragEvent) {
    event.preventDefault();
    if (event.dataTransfer?.files) {
      const droppedFiles: File[] = Array.from(event.dataTransfer.files);
      this.uploadFile(droppedFiles); 
    }
  }
}