import {map, pluck, share, take} from 'rxjs/operators';
import { HttpHeaders } from '@angular/common/http';
import { Component, EventEmitter, OnInit,OnChanges, Output, ViewChild,Input, Optional,ElementRef,QueryList,ViewChildren, Injector, NgZone } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FileError, NgxfUploaderService } from 'ngxf-uploader';
import { forkJoin ,  Observable } from 'rxjs';

import { AppUser } from '../../../@core/entities/authDataModel';
import { DropdownModel, PaginationRequest } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, GenericService, DataStoreService, SessionStorageService } from '../../../@core/services';
import { AppConfig } from './../../../app.config';
import { config } from '../../../../environments/config';
import { AttachmentUpload } from '../../../pages/case-worker/_entities/caseworker.data.model';
import { Attachment } from '../../../pages/case-worker/dsds-action/attachment/_entities/attachment.data.models';
import { CASE_STORE_CONSTANTS } from '../../../pages/case-worker/_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../../pages/case-worker/case-worker-url.config';
import { DsdsService } from '../../../pages/case-worker/dsds-action/_services/dsds.service' //'../../../../_services/dsds.service';
import { MatMenuTrigger } from '@angular/material/menu';
import { NewUrlConfig } from '../../../pages/newintake/newintake-url.config';
import { HospitalizationService } from '../../services/hospitalization.service';
import { UploadSharedService } from '../../../@core/services/upload-shared.service';
declare let $: any;
@Component({
    selector: 'attachment-upload-shared',
    templateUrl: './attachment-upload-shared.component.html',
    styleUrls: ['./attachment-upload-shared.component.scss'],
    standalone: false
})
export class AttachmentUploadSharedComponent implements OnInit, OnChanges {
    curDate!: Date;
    fileToSave: any[]= [];
    fileToSaveContact: any[] = [];
    uploadedFile: any[] = [];
    docselect: any[] =[];
    tabActive = false;
    daNumber: string;
    id: string;
    attachmentResponse!: AttachmentUpload;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    token: AppUser;
    attachmentClassificationtypelookup: any[] = [];
    attachmentClassificationtype: any[] = [];
    isAttachType = '';
    isCate = '';
    issubCate= '';
    isactualDocDate = '';
    isdescription = '';
    isother = '';
    isServiceCase = false;
    @Input() uploadedDocuments: any[] = [];
    @Input() load = false;
    @Input() existingDocumentsList: any;
    @Input() displayExistingFiles: any;
    @Input() modalId="upload-attachment"; 
    @Input() uploadType: any;
    @Input() ftdmFormList: any[] = [];
    @Input() pageType: any;
    @Input() ivePersonId: any;
    _objectId: any;
    islargeattachmentupload: boolean = false;
    filetouploaded: any;
    filename: any;
    filesize : any;
    personname: AppUser;
    cjamspid: AppUser;
    isservcase: any = false;
    disablelargeadd: boolean = false;
    deletedocid: any;
    maxfilesize!: string;
    get objectId(): any {
       return this._objectId;
    }
    @Input() set objectId(value: any) {
      this._objectId = value;
    }
    @Input() authId: any;
    @Input() uploadRequired = true;
    @Output() saveAttachment = new EventEmitter<any>();
    @Output() FileUploaded = new EventEmitter<any>();
    @Output() ftdmUploadSelData = new EventEmitter<any>();
    @Input() intakeNumber!: string;
    @Input() componentName!: string;
    @Output() attachment = new EventEmitter();
    @Input() additionalobjectid!: string;
    @Input() additionalobjecttypevalidation!: boolean;
    @Input() additionalobjecttype: any;
    @Output() uploadclosed = new EventEmitter();
    @Output() doccheckedList= new EventEmitter<any>();
    @ViewChildren('inputMenuTrigger') inputMenuTrigger!:  QueryList<MatMenuTrigger>;
    @ViewChildren('inputElement') inputElement!:  QueryList<ElementRef>;  
    uploadNumber!: number;
    maxDocumentDate : any;
    isAdoptionCase!: boolean;
    noOfClicks: number=0;
    personid;
    attachmenttype;
    isDataFilled: any[] = [];
    s3SelectedDocs: any[] = [];
    docchecked=false;
    agency;
    isCW!: boolean;
    count = 0; 
    @ViewChild(MatMenuTrigger) trigger!: MatMenuTrigger;
    documentPropertiesId: any;
    documentId: any;
    showInfo = true;
    deleteindex: any;
    dsattachmentpath = 'dsds-action/attachment';
    dsrecordingnotespath = 'dsds-action/recording/notes';
    dsfamilymeetingpath = 'dsds-action/recording/family-involvement-meeting';
    newintakepath = 'newintake/my-newintake';
    addmeetingpopupid = '#add-new-meeting';
    fostercarestr = 'foster-care';
    livingArrangeMentPath = "dsds-action/sc-placements";
    uploadedIndex = 0;
    dslargeattachmentpath = 'attachment-upload/largefileupload';
    dsregularattachmentpath = 'attachment-upload/fileupload';
    uploadAttachmentUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl;
    regularUploadAttachmentUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl;
    mandatoryAlert_Title: boolean = false
    mandatoryAlert_DocumentDate: boolean = false
    mandatoryAlert_OtherTxt: boolean = false;
    largeUploadAttachmentUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.LargeFileUploadAttachmentUrl;
    baseurl = AppConfig.baseUrl + '/';
    maxfilezise : any = '104857600';
    fileSha256Hash: any;
  
    private router: Router;
    private _dropDownService: CommonHttpService;
    private route: ActivatedRoute;
    private _uploadService: NgxfUploaderService;
    private _authService: AuthService;
    private _alertService: AlertService;
    private _uploadSharedService : UploadSharedService;
    private _commonHttpService: CommonHttpService;
    @Optional() private _dsdsService: DsdsService;
    private _dataStoreService: DataStoreService;
    private storage: SessionStorageService;
    private hospitalizationService: HospitalizationService;

      constructor( private injector : Injector, private _service: GenericService<Attachment>,
        private ngZone: NgZone
      ) {

        this.router = this.injector.get<Router>(Router);
        this._dropDownService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._dsdsService = this.injector.get<DsdsService>(DsdsService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this.hospitalizationService = this.injector.get<HospitalizationService>(HospitalizationService);
        this._uploadSharedService = this.injector.get<UploadSharedService>(UploadSharedService);      
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.personname = this._dataStoreService.getData('personNameSelectedOnDocumentsTab');
        this.cjamspid = this._dataStoreService.getData('personcjamspidSelectedOnDocumentsTab');
        this.token = this._authService.getCurrentUser();
        this.agency = this._authService.getAgencyName();
        if (this.route.snapshot.params && (this.router.url.includes(this.dsattachmentpath) || this.router.url.includes(this.dsrecordingnotespath)
            || this.router.url.includes('dsds-action/court/court-order') || this.router.url.includes(this.dsfamilymeetingpath))) {
            this.attachmenttype = this.route.snapshot.params['attachmenttype'] || 'case';
            this.personid = this.route.snapshot.params['personid'] || '';   
            this.isServiceCase = this._dsdsService.isServiceCase();
        }
    }
  ngOnInit() {
    this.isservcase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    this.uploadedFile = [];
    this.fileToSave = [];
    this.maxfilesize = this.humanizeBytes(this.maxfilezise);
    this.fileToSaveContact = [];
    this.maxDocumentDate = new Date();
    this.isCW = this._authService.isCW();
    this.loadDropdown();
    this.curDate = new Date();
    this.id = this.id ? this.id : '';
    setTimeout(() => {
        if(this.router.url.includes(this.dsattachmentpath)){
            $('#'+this.modalId).modal('show');
            this.isAdoptionCase = this.storage.getItem('CASE_TYPE') === "ADOPTION";
            }
     })
    this.loadAttachmentDropDown();   
    this.loadAttachmentList();
    if(this.router.url.includes(this.dslargeattachmentpath)) {
        this.islargeattachmentupload = true;
        this.maxfilezise = config.largeUploadMaxSizeLimit;
        this.maxfilesize = this.humanizeBytes(this.maxfilezise);
        this._dataStoreService.setData('largefileupload', true);
    } 
    if(this.router.url.includes(this.dsregularattachmentpath)) {
        this.islargeattachmentupload = false;
        this.maxfilezise = config.uploadMaxSizeLimit;
        this.maxfilesize = this.humanizeBytes(this.maxfilezise);
        this._dataStoreService.setData('largefileupload', false);
    } 
    this._dataStoreService.currentStore.subscribe((item) => {
        if (item.openupload === true) {  
            this.islargeattachmentupload = item.largefileupload;
            if(this.islargeattachmentupload) {
                this.maxfilezise = config.largeUploadMaxSizeLimit;
            }else {
                this.maxfilezise = config.uploadMaxSizeLimit;
            }
            this.maxfilesize = this.humanizeBytes(this.maxfilezise);
            this.deletedocid = item.deletedocid;  
            if(this.count === 0) {
                this.loadAttachmentList();        
                this.count++
            }                          
        }
    }); 
  }

  ngOnChanges() {
    this.loadAttachmentList();
  }
  docChangeStatus($event:any,documentlist:any){
    if($event.checked){
      this.docselect.push(documentlist);
      this.docchecked=true;
    }else{
      const i =this.docselect.findIndex(document=>document==documentlist);
      this.docselect.splice(i,1);
      this.docchecked=false;
    }
  }

    postdocumentproperties(request?: any) {
        if (request && request.length > 0) {
            const req: any = {};
            req['data'] = request;
            this._commonHttpService
                ?.create(req, 'Documentproperties/copyexistingdocuments').subscribe(res => {
                    this.doccheckedList.emit(res[0]?.insertdocumentproperties);
                    if (res[0].insertdocumentproperties[0] !== null || this.uploadedFile.length == this.fileToSave.length) {
                        $('#' + this.modalId).modal('hide');
                        const doctemp = this.existingDocumentsList;
                        this.existingDocumentsList = [];
                        setTimeout(() => { this.existingDocumentsList = doctemp; }, 1000)

                        this.docselect = [];
                    }
                });
        }
    }
  private loadAttachmentList() {
    if(!this.islargeattachmentupload) {
        this.assigningPersonIdAndCaseFn();
        const inputreq = this.inputreqAssignment();
        this._dropDownServiceFn(inputreq);
    }
}
    private assigningPersonIdAndCaseFn() {
        if ((this.router.url.includes(this.dsrecordingnotespath))) {
            this.personid = this._dsdsService.getField('personid') || '';
        }
        else if (!(this.router.url.includes(this.dsattachmentpath) || (this.router.url.includes(this.newintakepath)))) {
            if (this.router.url.includes(this.livingArrangeMentPath)) {
                this.hospitalizationService.getSelectedPersonId()
                    .subscribe((personId: string) => this.personid = personId).unsubscribe();
            } else {
                this.personid = this._dataStoreService.getData('personid');
            }
        }
        if ((this.pageType === this.fostercarestr || this.pageType === 'adoption' || this.pageType === 'guardianship') && this.ivePersonId) {
            this.personid = this.ivePersonId;
        }
        if (this.pageType === 'gapapplication' || this.pageType === 'gapagreement') {
            this.isServiceCase = true;
        }
        if (this.pageType === 'YTP') {
            this.personid = this.ivePersonId;
        }
    }

    private inputreqAssignment() {
        let srvcsId = (this.isServiceCase || this.pageType==='subsidyAgreement' || this.pageType==='referServiceNew') ? this.id : null;
        let objKey = this.isAdoptionCase ? 'Adoptioncase' : this.returnObjKeyFn();
        return {
            personid: this.personid ,
            intakenumber: this.intakeNumber,
            servicerequestid: (this.personid || this.isServiceCase || this.isAdoptionCase || this.pageType==='subsidyAgreement' || this.pageType==='referServiceNew') ? null : this.id,
            servicecaseid: this.personid ? null : srvcsId ,
            adoptioncaseid: this.isAdoptionCase ? this.id : null,
            objecttypekey: this.personid ? 'Person' : objKey,
            category: null,
            subcategory: null,
            worker: null,
            title: null,
            actualdocumentdate: null,
            sortcolumn: 'updatedon' ,
            sortby: 'desc',
            activeflag: 2
        };
    }

    private returnObjKeyFn() {
        return (this.isServiceCase ? 'Servicecase' : 'ServiceRequest');
    }

    private returnIsServiceCaseId() {
        return (this.isServiceCase || this.pageType === 'subsidyAgreement' || this.pageType === 'referServiceNew') ? this.id : null;
    }

    private returnIsAdoptionCase() {
        return this.isAdoptionCase ? 'Adoptioncase' : this.returnIsServiceCase();
    }

    private _dropDownServiceFn(inputreq: any) {
        this._dropDownService
            .getPagedArrayList(
                new PaginationRequest({
                    where: inputreq,
                    method: 'get',
                    page: 1,
                    limit: 10
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentGridUrl + '?filter')
            .subscribe((response: any) => {
                this.uploadedFile = this.uploadedFile.filter(uploadfile => uploadfile.documentpropertiesid === undefined || uploadfile.documentpropertiesid == null);
                for (let i = 0; this.isDataFilled.length > i; i++) {
                    clearInterval(this.isDataFilled[i]);
                }
                this.isDataFilled = [];
                this.fileToSave = [];
                for (let i = 0; this.uploadedFile.length > i; i++) {
                    this.uploadAttachment(i);
                }
                if (response && Array.isArray(response) && response.length) {
                    this._dropDownServiceResponse(response);
                    //}
                }
            }
            );
    }

    private _dropDownServiceResponse(response: any[]) {
        const searchcaseworkerattachments = response[0].searchcaseworkerattachments ?
            response[0].searchcaseworkerattachments.filter((attachement:any) => attachement['insertedby'] === this.token.user['securityusersid']
                || attachement['insertedby'] === this.token.user.userprofile.displayname
                || attachement['displayname'] === this.token.user.userprofile.displayname)
            : [];
        const result1 = searchcaseworkerattachments;

        if (result1 && (result1[0]?.length > 0) || (result1[0]?.count > 0)) {
            result1.map((item :any, index:any) => {
                const uploadfilevalue = {
                    lastModified: 0,
                    name: item.originalfilename,
                    webkitRelativePath: '',
                    size: item.numberofbytes,
                    type: '',
                    attachmentclassificationsubtypekey: item.documentattachment[0].attachmentclassificationsubtypekey,
                    attachmentclassificationtypekey: item.documentattachment[0].attachmentclassificationtypekey,
                    attachmenttypekey: item.documentattachment[0].attachmenttypekey,
                    actualdocumentdate: item.actualdocumentdate,
                    description : item.description,
                    other : item.other,
                    invalidAttachmentClassify: false,
                    invalidAttachmentsubClassify: false,
                    percentage: 100,
                    documentpropertiesid: item.documentpropertiesid,
                    ecmsdocumentid: item.ecmsdocumentid,
                    enableOtherTxt: this.includes_Other(item.documentattachment[0].attachmentclassificationsubtypekey)
                };
                this.uploadedFile.push(uploadfilevalue);
                item.index = index;
                this.fileToSave.push(item);
            });
        }
        setTimeout(() => {
            ($('div.modal-backdrop')).hide();
        })
    }

includes_Other(data:any){
   return data.includes('Other','other')
}
confirmDelete(modal:any,index:any) {
    this.deleteindex = index;
    this.documentPropertiesId = modal.documentpropertiesid;
    this.documentId = modal.ecmsdocumentid;
    $('#delete-attachment').modal('show');
}

closeConfirm() {
    this.documentPropertiesId = '';
    this.documentId = '';
    $('#delete-attachment').modal('hide');
}

deleteAttachment() {
    if(!this.uploadRequired) {
        $('#delete-attachment').modal('hide');
        this.deleteUpload(this.deleteindex);
        return;
    }
    const workEnv = config.workEnvironment;
    this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteAttachmentUrl;
    let id : any;
    if (workEnv === 'state') {
        id = this.documentPropertiesId + '&' + this.documentId;
    } else {
        id = this.documentPropertiesId;
    }
    this._service.remove(id).subscribe(
        result3 => {
            $('#delete-attachment').modal('hide');
            this.deleteUpload(this.deleteindex);
            this._alertService.success('Attachment Deleted successfully!');
        },
        err => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
}

  fileData:any=[];
  catIndex:number = 0;
  uploadFile(file: any): void {
    if ((this.router.url.includes(this.dsrecordingnotespath) || (this.router.url.includes(this.dsfamilymeetingpath)))){
        this.attachmenttype = this._dsdsService.getField('attachmenttype') || 'case';
        this.personid = this._dsdsService.getField('personid') || '';
        this.personname = this._dsdsService.getField('personnameselected');
        this.cjamspid = this._dsdsService.getField('personcjamspidselected');
    }
   else if(! (this.router.url.includes(this.dsattachmentpath) || (this.router.url.includes(this.newintakepath) ))){
      this.uploadNumber = this._dataStoreService.getData('uploadNumber');
      this.attachmenttype = this._dataStoreService.getData('attachmenttype');
      if(this.router.url.includes(this.livingArrangeMentPath)) {
        this.hospitalizationService.getSelectedPersonId()
        .subscribe((personId:string) => this.personid= personId).unsubscribe();
      } else {
        this.personid = this._dataStoreService.getData('personid');
        this.personname = this._dataStoreService.getData('personnameselected');
        this.cjamspid = this._dataStoreService.getData('personcjamspidselected');
      }
      
    }

    if((this.pageType === this.fostercarestr || this.pageType === 'adoption' || this.pageType === 'guardianship') && this.ivePersonId) {
        this.personid = this.ivePersonId;
        this.personname = this._dataStoreService.getData('ivepersonnameselected');
        this.cjamspid = this._dataStoreService.getData('ivepersoncjamspidselected');
    }
    if(this.pageType === 'YTP'){
      this.personid = this.ivePersonId;
    }
      if (!(file instanceof Array)) {
          return;
      }
      this.fileMapFiltering(file);
  }
    private fileMapFiltering(file: any) {
        file.map((item: any, index: any) => {
            const size = this.humanizeBytes(item.size);
            item.filesize = size;
            const fileExt = item.name
                .toLowerCase()
                .split('.')
                .pop();
            if (fileExt === 'mp3' ||
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
                fileExt === 'rtf') {
                this.fileMapCondition(item, index, fileExt, size);
            }
            else {
                this._alertService.error(fileExt + " format can't be uploaded");
            }
        });
    }

    private async fileMapCondition(item: any, index: number, fileExt: any, size: string) {
        if ((item.size <= config.uploadMaxSizeLimit) || (this.islargeattachmentupload && item.size <= config.largeUploadMaxSizeLimit)) {
            this.uploadedFile.push(item);
            index = this.uploadedFile.length - 1;
            await this.hash256(item);
            this.uploadAttachment(index);
            const audio_ext = ['mp3', 'ogg', 'wav', 'acc', 'flac', 'aiff'];
            const video_ext = ['mp4', 'avi', 'mov', '3gp', 'wmv', 'mpeg-4'];
            if (audio_ext.indexOf(fileExt) >= 0) {
                this.uploadedFile[index].attachmenttypekey = 'Audio';
            } else if (video_ext.indexOf(fileExt) >= 0) {
                this.uploadedFile[index].attachmenttypekey = 'Video';
            } else {
                this.uploadedFile[index].attachmenttypekey = 'Document';
            }
            this.isAttachType = this.uploadedFile[index].attachmenttypekey;
        }
        else {
            this._alertService.error("Uploaded file size " + size + " exceeds the maximum file size limit of "+ this.maxfilesize);
        }
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
  uploadAttachment(index:any) {
      this.isAttachType = '';
      this.isCate = '';
      const _self = this;
      if(_self.additionalobjecttypevalidation){
        this.issubCate='Psychotropic Medication Request';
        this.isCate='Medical/Dental Health';
    }
    this.isDataFilled[index] =  setInterval(function() {
        if(_self.additionalobjecttypevalidation){
            _self.uploadedFile[index].attachmentclassificationsubtypekey='Psychotropic Medication Request';
            _self.uploadedFile[index].attachmentclassificationtypekey='Medical/Dental Health';
            _self.uploadedFile[index].enableOtherTxt = false;
            _self.uploadedFile[index].other = ""; 
        }
        if (_self.uploadedFile[index].attachmenttypekey !== undefined && _self.uploadedFile[index].attachmenttypekey !== '' 
        && _self.uploadedFile[index].attachmentclassificationtypekey !== undefined && _self.uploadedFile[index].attachmentclassificationtypekey !== ''  && 
        _self.uploadedFile[index].attachmentclassificationsubtypekey !== undefined && _self.uploadedFile[index].attachmentclassificationsubtypekey !== '' 
        && _self.uploadedFile[index].actualdocumentdate !== undefined && _self.uploadedFile[index].actualdocumentdate !== '') {
            _self.isAttachType =  _self.uploadedFile[index].attachmenttypekey;
            _self.isCate = _self.uploadedFile[index].attachmentclassificationtypekey;
            _self.issubCate = _self.uploadedFile[index].attachmentclassificationsubtypekey;             
            clearInterval(_self.isDataFilled[index]); 
            if(!_self.islargeattachmentupload) {
                _self.processResponseData(index);
            }
        }
    }, 1000);
  }
  
  processResponseData(index: any, uploadfilelength?: any) {
      let uploadParams: any = {};
      let objecttypekey;
      const _self = this;
      this.isactualDocDate = _self.uploadedFile[index].actualdocumentdate;
      this.isdescription = _self.uploadedFile[index].description ? _self.uploadedFile[index].description : '';
      this.isother = _self.uploadedFile[index].other;
      this.isAttachType =  _self.uploadedFile[index].attachmenttypekey;
      this.isCate = _self.uploadedFile[index].attachmentclassificationtypekey;
      this.issubCate = _self.uploadedFile[index].attachmentclassificationsubtypekey; 
      const dynam = this.isAttachType + '|' + this.isCate + '|' + this.issubCate;
      const securityuserid = this.token.user.userprofile.securityusersid;
      this.filename = _self.uploadedFile[index].name;
      this.filesize = _self.uploadedFile[index].filesize;
      const fn = this.filename?.toLowerCase();
      if(!fn || fn.startsWith('null.') || fn.startsWith('undefined.') || fn.startsWith('.')) {
        this._alertService.error('Please upload the correct file with proper name. File name cannot be null or undefined.');
        return;
      }
      if(this.isCate == null || this.isCate == undefined || this.isCate.trim() == '') {
        this._alertService.error('Please upload the correct file with correct category. Category cannot be null or undefined.');
        return;
      }
      if(this.issubCate == null || this.issubCate == undefined || this.issubCate.trim() == '') {
        this._alertService.error('Please upload the correct file with correct sub category. sub category cannot be null or undefined.');
        return;
      }
      if(this.islargeattachmentupload) {
        this.uploadAttachmentUrl = this.largeUploadAttachmentUrl;
        this.baseurl = "";
      } else {
        this.uploadAttachmentUrl = this.regularUploadAttachmentUrl;
        this.baseurl = AppConfig.baseUrl + '/';
      }
      if (this.router.url.includes(this.dsattachmentpath)) {
          objecttypekey = this.returnIsAdoptionCase();
          uploadParams = this.returnUploadParams1(dynam, objecttypekey, securityuserid);
      } else if (this.router.url.includes(this.newintakepath)) {
          uploadParams = this.returnUploadParams2(dynam, securityuserid);
      } else if (this.router.url.includes(this.dsrecordingnotespath) || (this.router.url.includes(this.dsfamilymeetingpath))) {
          objecttypekey = this.returnIsServiceCase();
          uploadParams = this.returnUploadParams1(dynam, objecttypekey, securityuserid);
      } else if (this.router.url.includes('person-info-cw/education')) {
          const additionalobjectid = this.nullCheck(this.additionalobjectid);
          const additionalobjecttype = this.nullCheck(this.additionalobjecttype);
          uploadParams = this.returnUploadParams3(dynam, additionalobjectid, additionalobjecttype, securityuserid);
          this.returnAdditionalobjectid(index);
      } else if (this.router.url.includes('person-info-cw/health')) {
        uploadParams = this.returnUploadParams17(dynam, securityuserid);
      } else if (this.pageType === 'guardianship' || this.pageType === 'adoption' || this.pageType === this.fostercarestr) {
          this.returnAdditionalobjectid(index);
          uploadParams = this.returnUploadParams4(dynam, securityuserid);
      } else if( this.router.url.includes('psychotropicprescription-review')){
        const additionalobjectid = this.nullCheck(this.additionalobjectid);
        const additionalobjecttype = this.nullCheck(this.additionalobjecttype);
        uploadParams = this.returnUploadParams3(dynam, additionalobjectid, additionalobjecttype, securityuserid);
        this.enablOtherTxt = false;
        this.mandatoryAlert_OtherTxt = false;
        this.uploadedFile[index].enableOtherTxt = false;
        this.uploadedFile[index].other = "";
      }
      else {
          this.returnAdditionalobjectid(index);
          uploadParams = this.processResponseDataElseCondition(dynam, securityuserid);
      }
      if(this.islargeattachmentupload) {
          this._uploadLargeServiceFn(uploadParams, index, uploadfilelength);
      } else {
          this._uploadServiceFn(this.baseurl + this.uploadAttachmentUrl + this.buildQueryString(uploadParams), index);
      }

  }

    // Serializes the upload parameters into the query string used by the regular upload endpoint
    private buildQueryString(params: any): string {
        return Object.keys(params)
            .map((key, position) => (position === 0 ? '?' : '&') + key + '=' + params[key])
            .join('');
    }

  private nullCheck(value: any){
    return value || null;
  }

    private returnAdditionalobjectid(index: any) {
        this.uploadedFile[index].additionalobjectid = this.additionalobjectid ? this.additionalobjectid : null;
    }
    // Assosiated to processResponseData method
    private returnIsServiceCase(): any {
        return this.isServiceCase ? 'Servicecase' : 'ServiceRequest';
    }

    private processResponseDataElseCondition(dynam: any, securityuserid: string) {
        let uploadParams: any;
        if (this.pageType === 'investigationFindings') {
            uploadParams = this.returnInvestigationFindingsParams(dynam, securityuserid);
        } else if (this.pageType === 'referServiceNew') {
            const objId: any = this.id ? this.id : null;
            const authId: any = this.authId ? this.authId : null;
            uploadParams = this.returnReferServiceNewParams(dynam, objId, authId, securityuserid);
        } else if (this.pageType === 'courtOrderNew') {
            uploadParams = this.returnCourtOrderNewParams(dynam, securityuserid);
        } else if (this.pageType === 'ebpreferral') {
            uploadParams = this.returnEbpreferralParams(dynam, securityuserid);
        } else if (this.pageType === 'subsidyAgreement') {
            uploadParams = this.returnUploadParams7(dynam, securityuserid);
        } else if(this.pageType === 'assessmentForm'){
            uploadParams = this.returnUploadParams8(dynam, securityuserid);
        } else if (this.pageType === 'gapapplication') {
            uploadParams = this.returnUploadParams5(dynam, securityuserid, 'gapapplication');
        } else if (this.pageType === 'gapagreement') {
            uploadParams = this.returnUploadParams5(dynam, securityuserid, 'gapagreement');
        } else {
            uploadParams = this.returnUploadParams6(dynam, securityuserid);
        }
        return uploadParams;
    }

    // Common document metadata sent with every upload
    private returnDocumentParams(securityuserid: string) {
        return {
            insertedby: securityuserid,
            filename: this.filename,
            filesize: this.filesize,
            actualdocumentdate: this.isactualDocDate,
            deletedocid: this.deletedocid,
            description: this.isdescription,
            other: this.isother
        };
    }

    private returnEbpreferralParams(dynam: any, securityuserid: string) {
        return {
            srno: this.daNumber,
            docsInfo: dynam,
            objecttypekey: 'Servicecase',
            objectid: this.objectId,
            ...(this.isServiceCase ? { servicecaseid: this.id } : { servicerequestid: this.id }),
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private returnCourtOrderNewParams(dynam: any, securityuserid: string) {
        return {
            srno: this.daNumber,
            docsInfo: dynam,
            objecttypekey: 'courtorder',
            objectid: this.objectId,
            ...(this.isServiceCase ? { servicecaseid: this.id } : { servicerequestid: this.id }),
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private returnReferServiceNewParams(dynam: any, objId: string, authId: any, securityuserid: string) {
        return {
            srno: this.daNumber,
            docsInfo: dynam,
            objecttypekey: 'purchaseAuthReceipt',
            objectid: objId,
            additionalobjectid: authId,
            additionalobjecttype: 'purchaseAuthReceipt',
            servicecaseid: this.id,
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private returnInvestigationFindingsParams(dynam: any, securityuserid: string) {
        return {
            srno: this.daNumber,
            docsInfo: dynam,
            objecttypekey: 'investigationappeal',
            objectid: this.objectId,
            servicerequestid: this.id,
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private returnUploadParams8(dynam: any, securityuserid: string) {
        return {
            srno: this.daNumber,
            docsInfo: dynam,
            objecttypekey: 'Person',
            additionalobjectid: this.additionalobjectid,
            objectid: this.objectId,
            servicecaseid: this.id,
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private returnUploadParams7(dynam: any, securityuserid: string) {
        return {
            srno: this.daNumber,
            docsInfo: dynam,
            objecttypekey: 'AdoptionSubsidy',
            additionalobjectid: this.id,
            objectid: this.objectId,
            servicecaseid: this.id,
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private returnUploadParams6(dynam: any, securityuserid: string) {
        const serreqid = this.isservcase ? '' : this.id;
        const servcaseid = this.isservcase ? this.id : '';
        return {
            srno: this.intakeNumber,
            docsInfo: dynam,
            attachmenttype: this.attachmenttype,
            personid: this.personid,
            servicerequestid: serreqid,
            servicecaseid: servcaseid,
            objecttypekey: 'YTP',
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private returnUploadParams17(dynam: any, securityuserid: string) {
        const caseid = this.id ? this.id : '';
        const serreqid = this.isservcase ? '' : caseid;
        const servcaseid = this.isservcase ? caseid : '';
        return {
            srno: this.intakeNumber,
            docsInfo: dynam,
            attachmenttype: this.attachmenttype,
            personid: this.personid,
            servicerequestid: serreqid,
            servicecaseid: servcaseid,
            objecttypekey: 'YTP',
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private returnUploadParams5(dynam: any, securityuserid: string, pageType: string) {
        return {
            srno: this.daNumber,
            docsInfo: dynam,
            objecttypekey: pageType,
            additionalobjectid: this.id,
            objectid: this.objectId,
            servicecaseid: this.id,
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private returnUploadParams4(dynam: any, securityuserid: string) {
        return {
            srno: this.uploadNumber,
            docsInfo: dynam,
            attachmenttype: this.attachmenttype,
            personid: this.personid,
            objecttypekey: 'person',
            additionalobjectid: this.additionalobjectid,
            additionalobjecttype: this.pageType,
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private returnUploadParams3(dynam: any, additionalobjectid: string, additionalobjecttype: any, securityuserid: string) {
        const serreqid = this.isservcase ? '' : this.id;
        const servcaseid = this.isservcase ? this.id : '';
        return {
            srno: this.intakeNumber,
            docsInfo: dynam,
            attachmenttype: this.attachmenttype,
            personid: this.personid,
            objecttypekey: 'YTP',
            servicerequestid: serreqid,
            servicecaseid: servcaseid,
            additionalobjectid: additionalobjectid,
            additionalobjecttype: additionalobjecttype,
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private returnUploadParams2(dynam: any, securityuserid: string) {
        return {
            srno: this.intakeNumber,
            docsInfo: dynam,
            objecttypekey: 'ServiceRequest',
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private returnUploadParams1(dynam: any, objecttypekey: any, securityuserid: string) {
        return {
            srno: this.daNumber,
            docsInfo: dynam,
            attachmenttype: this.attachmenttype,
            personid: this.personid,
            objecttypekey: objecttypekey,
            objectid: this.id,
            ...this.returnDocumentParams(securityuserid)
        };
    }

    private async hash256(file: any): Promise<string | null> {
        try {
            const buffer = await file.arrayBuffer();
            const hashBuffer = await crypto.subtle.digest('SHA-256', buffer);
            // Convert hash to Base64 (NOT hexadecimal)
            let binary = '';
            const bytes = new Uint8Array(hashBuffer);
            bytes.forEach(b => binary += String.fromCharCode(b));
            const fileSha256Hash = btoa(binary);
            // stamped on the file itself, so a deleted/reordered row cannot move the hash to another file
            file.fileSha256Hash = fileSha256Hash;
            return fileSha256Hash; // Base64-encoded hash string
        } catch (_err) {
            return null;
        }
    }

    private _uploadServiceFn(uploadUrl: string, index: any) {
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
                        this._uploadServiceResponse(response, index);
                    }                   
                }, (_err) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    this.uploadedFile.splice(index, 1);
                }
            );
    }
    private async _uploadLargeServiceFn(uploadParams: any, index: any, uploadfilelength?: any) {

        const files = this.uploadedFile[index];
        // the hash is normally stamped at file-select time, but recompute here when it is
        // still pending/failed (large files, retry flow, files re-hydrated from the grid)
        if (!files.fileSha256Hash) {
            await this.hash256(files);
        }
        if (!files.fileSha256Hash) {
            this.disablelargeadd = false;
            this._alertService.error('Unable to verify the file checksum. Please try uploading the file again.');
            this.FileUploaded.emit(false);
            return;
        }
        // the metadata goes in the request body as a JSON payload instead of the query string
        const payload = { ...uploadParams, fileSha256Hash: files.fileSha256Hash };
        this._commonHttpService
            .create(payload, this.largeUploadAttachmentUrl)
            .subscribe(
                (response) => {
                    if (response) {
                        this._uploadlargeServiceResponse(response, index);
                        response.casenumber = this.daNumber;
                        response.filesize = files.filesize;
                        response.deletedocid = this.deletedocid;
                        response.fileSha256Hash =  files.fileSha256Hash;
                        this.deletedocid = null;
                        if(this.personid) {
                            response.cjamspid = this.cjamspid;
                            response.personname = this.personname;
                        }              
                        if (response.Documentattachment) {
                            const attPos = index + 1;
                            this._alertService.error(response.Documentattachment + ' for Attachment ' + attPos);
                            this.FileUploaded.emit(false);
                        } else if (!response.documentpropertiesid && response.count === 0) {
                            this.disablelargeadd = false;
                            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                            this.FileUploaded.emit(false);
                        }
                        else if (!response.documentpropertiesid) { 
                            this.disablelargeadd = false;
                            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                        }
                        else {                                   
                            this._uploadSharedService.presignUrlcallupload(response, files);
                            const start =  this.uploadedDocuments.length;
                            this.uploadclosed.emit(true);
                            this.uploadedDocuments[start] = { ...this.uploadedDocuments[start], ...this.fileToSave[this.fileToSave.length - 1] };
                            this.checkUploadFileLength(uploadfilelength);
                        }

                        this.checkUploadfileAndLength(response, uploadfilelength);
                    }                   
                }, (_err) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    this.uploadedFile.splice(index, 1);
                }
            );
    }
    // Assosiated to _uploadLargeServiceFn method
    private checkUploadFileLength(uploadfilelength: any) {
        if (this.fileToSave.length == uploadfilelength) {
            this.FileUploaded.emit(true);
            this.saveAttachment.emit(this.fileToSave);
            this._alertService.success('Attachment(s) Uploaded successfully!');
            this.disablelargeadd = false;
            this.loadAttachmentList();
        }
    }
    // Assosiated to _uploadLargeServiceFn method
    private checkUploadfileAndLength(response: any, uploadfilelength: any) {
        if (!response.Documentattachment && this.fileToSave.length == uploadfilelength) {
            this.disablelargeadd = false;
            if (this.router.url.includes(this.newintakepath)) {
                this.attachment.emit('all');
            }
            $('#' + this.modalId).modal('hide');
            this.uploadedFile = [];
            this.fileToSave = [];
            this.fileToSaveContact = [];
            this.docPropIfElseCondition();
        }
    }

    private _uploadlargeServiceResponse(response: any, index: any) {
        this.attachmentResponse = response;
        const doucumentInfo = response;
        doucumentInfo.documentdate = doucumentInfo;
        doucumentInfo.objecttypekey = 'YTP';
        doucumentInfo.rootobjecttypekey = 'YTP';
        doucumentInfo.servicerequestid = null;
        this.fileToSaveContact[index] = { ...this.fileToSaveContact[index], ...doucumentInfo };
        //for saving to case
        this.fileToSave.push(response);
        this.uploadedFile[index].documentpropertiesid = response.documentpropertiesid;
        this.uploadedFile[index].ecmsdocumentid = response.ecmsdocumentid;
        this.fileToSave[this.fileToSave.length - 1].documentattachment = {
            attachmenttypekey: this.uploadedFile[index].attachmenttypekey,
            attachmentclassificationtypekey: this.uploadedFile[index].attachmentclassificationtypekey,
            attachmentclassificationsubtypekey: this.uploadedFile[index].attachmentclassificationsubtypekey,
            actualdocumentdate: this.isactualDocDate,
            description: this.isdescription,
            other: this.isother,
            attachmentdate: new Date(),
            sourceauthor: '',
            attachmentsubject: '',
            sourceposition: '',
            attachmentpurpose: '',
            sourcephonenumber: '',
            acquisitionmethod: '',
            sourceaddress: '',
            locationoforiginal: '',
            insertedby: this.token.user.userprofile.displayname,
            note: '',
            updatedby: this.token.user.userprofile.displayname
        };
        const objecttypekey = this.returnIsServiceCase();
        this.fileToSave[this.fileToSave.length - 1].description = '';
        this.fileToSave[this.fileToSave.length - 1].documentdate = new Date();
        this.fileToSave[this.fileToSave.length - 1].title = response.title;
        this.fileToSave[this.fileToSave.length - 1].daNumber = this.uploadNumber;
        this.fileToSave[this.fileToSave.length - 1].objecttypekey = objecttypekey;
        this.fileToSave[this.fileToSave.length - 1].rootobjecttypekey = objecttypekey;
        this.fileToSave[this.fileToSave.length - 1].intakenumber = this.intakeNumber;
        this.fileToSave[this.fileToSave.length - 1].daNumber = this.uploadNumber;
        this.fileToSave[this.fileToSave.length - 1].insertedby = this.token.user.userprofile.displayname;
        this.fileToSave[this.fileToSave.length - 1].updatedby = this.token.user.userprofile.displayname;
        this.fileToSave[this.fileToSave.length - 1].securityusersid = this.token.user.userprofile.securityusersid;
        this.fileToSave[this.fileToSave.length - 1].index = index;
        this.fileToSave[this.fileToSave.length - 1].documentpropertiesid = response.documentpropertiesid;
        this.fileToSave[this.fileToSave.length - 1].activeflag = response.activeflag;
    }

    private _uploadServiceResponse(response: any, index: any) {
        this.attachmentResponse = response.data;
        const doucumentInfo = response.data;
        doucumentInfo.documentdate = doucumentInfo.date;
        doucumentInfo.title = doucumentInfo.originalfilename;
        doucumentInfo.objecttypekey = 'YTP';
        doucumentInfo.rootobjecttypekey = 'YTP';
        doucumentInfo.servicerequestid = null;
        this.fileToSaveContact[index] = { ...this.fileToSaveContact[index], ...doucumentInfo };
        //for saving to case
        this.attachmentResponse = response.data;
        this.fileToSave.push(response.data);
        this.uploadedFile[index].documentpropertiesid = response.data.documentpropertiesid;
        this.uploadedFile[index].ecmsdocumentid = response.data.ecmsdocumentid;
        this.fileToSave[this.fileToSave.length - 1].documentattachment = {
            attachmenttypekey: this.isAttachType,
            attachmentclassificationtypekey: this.isCate,
            attachmentclassificationsubtypekey: this.issubCate,
            actualdocumentdate: this.isactualDocDate,
            description: this.isdescription,
            other: this.isother,
            attachmentdate: new Date(),
            sourceauthor: '',
            attachmentsubject: '',
            sourceposition: '',
            attachmentpurpose: '',
            sourcephonenumber: '',
            acquisitionmethod: '',
            sourceaddress: '',
            locationoforiginal: '',
            insertedby: this.token.user.userprofile.securityusersid,
            note: '',
            updatedby: this.token.user.userprofile.securityusersid
        };
        const objecttypekey = this.returnIsServiceCase();
        this.fileToSave[this.fileToSave.length - 1].description = '';
        this.fileToSave[this.fileToSave.length - 1].documentdate = new Date();
        this.fileToSave[this.fileToSave.length - 1].title = '';
        this.fileToSave[this.fileToSave.length - 1].daNumber = this.uploadNumber;
        this.fileToSave[this.fileToSave.length - 1].objecttypekey = objecttypekey;
        this.fileToSave[this.fileToSave.length - 1].rootobjecttypekey = objecttypekey;
        this.fileToSave[this.fileToSave.length - 1].intakenumber = this.intakeNumber;
        this.fileToSave[this.fileToSave.length - 1].daNumber = this.uploadNumber;
        this.fileToSave[this.fileToSave.length - 1].insertedby = this.token.user.userprofile;
        this.fileToSave[this.fileToSave.length - 1].updatedby = this.token.user.userprofile.securityusersid;
        this.fileToSave[this.fileToSave.length - 1].securityusersid = this.token.user.userprofile.securityusersid;
        this.fileToSave[this.fileToSave.length - 1].index = index;
    }

// Document tab ends
  deleteUpload(index: any) {
      if (this.ftdmFormList?.length) {
        this.ftdmFormList.forEach(ele => {
            if (ele.documentpropertiesid === this.uploadedFile[index].documentpropertiesid) {
                ele.checked = false;
            }
        })
        this.s3SelectedDocs = this.ftdmFormList.filter(ele => ele.checked);
      }
      clearInterval(this.isDataFilled[index]);
      this.uploadedFile.splice(index, 1);
      this.fileToSave.splice(index, 1);
      this.fileToSaveContact.splice(index, 1);
      if (!this.ftdmFormList?.length) {
          this.loadAttachmentList();
      }
  }
  clearAllUpload(event: Event) {
      this.disablelargeadd = false;
      this.count = 0;
      for (let i = 0; this.isDataFilled.length > i; i++) {
         clearInterval(this.isDataFilled[i]); 
      }

      if(this.uploadType === 'meeting') {
          ($(this.addmeetingpopupid)).modal('show');
      }
      this.ftdmFormList = this.ftdmFormList.map(item => ({
          ...item,
          checked: false
      }));
      this.uploadedFile = [];
      this.fileToSave = [];
      this.fileToSaveContact = [];
      //idientifying the component of dsds-action
      if(this.router.url.includes(this.dsattachmentpath)){
        let currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment';
        if (this.attachmenttype === 'person') {
            currentUrl = currentUrl + '/person';
        }
         this.router.navigate([currentUrl], {
           relativeTo: this.route
         })
        return;
      }

      event.stopPropagation();    
      ($('#' + this.modalId)).modal('hide');
    
      if(this.router.url.includes('my-newintake')){
        this.attachment.emit('all');
       }
       this.uploadclosed.emit(true);
  }
  descUpdate(event: any, index: any) {
      this.uploadedFile[index].description = event.target.value;
  }
  docDateUpdate(event:any, index:any) {
      this.uploadedFile[index].docDate = event.target.value;
  }
  otherUpdate(event:any, index:any) {
      this.uploadedFile[index].other = event.target.value;
      this.mandatoryAlert_OtherTxt = false;
  }
  docDateAddUpdate(event:any, index:any) {
    this.uploadedFile[index].actualdocumentdate = event;
    this.mandatoryAlert_DocumentDate = false;
    this.updatePercentage(index);
  }
  updatePercentage(index: any) {
      if(
          this.s3SelectedDocs.length > 0
          && this.uploadedFile[index].attachmentclassificationsubtypekey
          && this.uploadedFile[index].actualdocumentdate
        ) {
        this.uploadedFile[index].percentage = 100;
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
          for (const element of this.attachmentClassificationtypelookup) {
              if (element.typedescription === this.uploadedFile[index].attachmentclassificationtypekey) {
                  this.uploadedFile[index].attachmentClassificationsubtype.push({subcategory: element.subcategory});
              }
          }
      } else {
          this.uploadedFile[index].invalidAttachmentClassify = true;
      }
  }
  subcategoryUpdate(event: any, index: any) {
      if (event?.target?.value !== '')  {
          this.issubCate  = event?.target?.value;
      }
      this.uploadedFile[index].attachmentclassificationsubtypekey = event.target.value;
      if (event?.target?.value) {
          this.uploadedFile[index].invalidAttachmentsubClassify = false;
      } else {
          this.uploadedFile[index].invalidAttachmentsubClassify = true;
      }
  }

    saveLargeAttachmentDetails() {
        if (this.validation(this.uploadedFile) || this.docselect.length > 0)  {
            this.pushLargeDataFileToSave();
        }
    }

    private pushLargeDataFileToSave() {
        this.disablelargeadd = true;
        const _self = this;
        const uploadfilelength = this.uploadedFile.length;
        this.uploadedFile.forEach((item, index) => {
            const xindex = index;
            this.filetouploaded = item;
            const fileExt = item.name
                .toLowerCase()
                .split('.')
                .pop();
            if (fileExt === 'mp3' ||
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
                fileExt === 'rtf') {
                _self.processResponseData(xindex, uploadfilelength);    
            } else {
                this._alertService.error(fileExt + " format can't be uploaded");
            }               
        });  
    }


saveAttachmentDetails() {
    if (this.validation(this.uploadedFile)|| this.docselect.length > 0)  {
        if (this.uploadedFile.length !== this.fileToSave.length) {
            this._alertService.error('Please wait till files get uploaded');
        } else {
            this.pushDataFileToSave();
        }
    }
}

    private pushDataFileToSave() {
        this.uploadedFile.forEach((item, index) => {
            const xindex = index;
            this.fileToSave[xindex].servicerequestid = this.isServiceCase ? null : this.id;
            this.fileToSave[xindex].additionalobjectid = this.additionalobjectid ? this.additionalobjectid : null;
            this.fileToSave[xindex].servicecaseid = this.isServiceCase ? this.id : null;
            this.fileToSave[xindex].title = item.attachmentclassificationsubtypekey;
            this.fileToSave[xindex].attachmenttype = this.attachmenttype;
            this.fileToSave[xindex].personid = this.personid;
            this.fileToSave[xindex].description = item.description;
            this.fileToSave[xindex].other = item.other;
            this.fileToSave[xindex].enableOtherTxt = item.enableOtherTxt ? true : false;
            this.fileToSave[xindex].actualdocumentdate = item.actualdocumentdate;
            this.fileToSave[xindex].documentattachment.attachmenttypekey = item.attachmenttypekey;
            this.fileToSave[xindex].documentattachment.attachmentclassificationtypekey = item.attachmentclassificationtypekey;
            this.fileToSave[xindex].documentattachment.attachmentclassificationsubtypekey = item.attachmentclassificationsubtypekey;
        });
        this.saveAttachmentDetailsElseCond(this.fileToSave);
    }

    private saveAttachmentDetailsElseCond(fileToSave:any) {
        const AttachValidate = fileToSave.filter((wer:any) => (!wer.other && wer.enableOtherTxt) || !wer.documentattachment.attachmentclassificationtypekey || !wer.documentattachment.attachmenttypekey || !wer.actualdocumentdate || !wer.documentattachment.attachmentclassificationsubtypekey/*|| !wer.documentattachment.administration  || !wer.documentattachment.site */);
        if (AttachValidate.length === 0) {
            this.postdocumentproperties(this.docselect);
            if (this.router.url.includes('newintake/my-newintake') ) {
                this._service.endpointUrl = NewUrlConfig.EndPoint.Intake.SaveAttachmentUrl;
            } else {
                this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.SaveAttachmentUrl;
            }
            this._serviceCreateArrayListFn();
        } else {
            // tslint:disable-next-line:quotemark
            this._alertService.error('Please fill all mandatory fields');
            this.loopUploadedFile();
        }
    }

    private loopUploadedFile() {
        this.uploadedFile.forEach((item) => {
            if (!item.attachmentclassificationtypekey) {
                item.invalidAttachmentClassify = true;
            } else {
                item.invalidAttachmentClassify = false;
            }
            if (!item.attachmenttypekey) {
                item.invalidAttachmentType = true;
            } else {
                item.invalidAttachmentType = false;
            }
            if (!item.attachmentclassificationsubtypekey) {
                item.invalidAttachmentsubClassify = true;
            } else {
                item.invalidAttachmentsubClassify = false;
            }
        });
    }

    private _serviceCreateArrayListFn() {
        this._service.createArrayList(this.fileToSave).subscribe(
            (response:any) => {
                this._serviceCreateArrayListResponse(response, this.uploadedDocuments.length);
            },
            (erro:any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

  private _serviceCreateArrayListResponse(response: Attachment[], start: number) {
        response.forEach((item, index) => {
            if (item.documentpropertiesid) {
                this.uploadclosed.emit(true);
                if (this.router.url.includes(this.dsattachmentpath)) {
                    response.splice(index, 1);
                    this.fileToSave.splice(index, 1);
                    this.uploadedFile.splice(index, 1);
                } else {
                    this.fileToSave[index].documentpropertiesid = item.documentpropertiesid;
                    this.fileToSave[index].insertedby = item.insertedby;
                    this.fileToSave[index].activeflag = item.activeflag;
                    this.uploadedDocuments[start] = { ...this.uploadedDocuments[start], ...this.fileToSave[index] };
                    start++;
                }
            }
            const docProp = response.filter((docId) => docId.Documentattachment);
            if (docProp.length === 0) {
                this._alertService.success('Attachment(s) added successfully!');
                if (this.router.url.includes(this.newintakepath)) {
                    this.attachment.emit('all');
                }
                $('#' + this.modalId).modal('hide');
                this.docPropIfElseCondition();
            }
            if (item.Documentattachment) {
                const attPos = index + 1;
                this._alertService.error(item.Documentattachment + ' for Attachment ' + attPos);
                this.FileUploaded.emit(false);
            } else if (!item.documentpropertiesid && item.count === 0) {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                this.FileUploaded.emit(false);
            }
            else if (!item.documentpropertiesid) {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
            else {
                this.FileUploaded.emit(true);
                this.saveAttachment.emit(this.fileToSave)
                this._alertService.success('Attachment Uploaded successfully!');
                this.loadAttachmentList();
            }
        });
        // return start;
    }

    private docPropIfElseCondition() {
        if (this.router.url.includes(this.dsattachmentpath)) {
            this.fileToSave = [];
            this.uploadedFile = [];
            this.router.routeReuseStrategy.shouldReuseRoute = function () {
                return false;
            };
            let currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment';
            if (this.attachmenttype === 'person') {
                currentUrl = currentUrl + '/person';
            }
            this.router.navigate([currentUrl]);
        }
        else {
            if (this.uploadType === 'meeting') {
               $(this.addmeetingpopupid).modal('show');
            }
        }
    }

  validation(data: any) {
      if (data.length !== 0) {
          const attachmentclassificationtypekey = data[0]?.attachmentclassificationtypekey;
          const actualdocumentdate = data[0]?.actualdocumentdate;
          const other = data[0]?.other;
          this.mandatoryAlert_Title = (attachmentclassificationtypekey !== undefined && attachmentclassificationtypekey !== null) ?  false : true;
          this.mandatoryAlert_DocumentDate = (actualdocumentdate !== undefined && actualdocumentdate !== null && actualdocumentdate !== "") ? false : true;
          this.mandatoryAlert_OtherTxt = ((other !== undefined && other !== null && other !== "") || data[0].enableOtherTxt === false) ? false : true;
          if (this.mandatoryAlert_Title === true || this.mandatoryAlert_DocumentDate === true || this.mandatoryAlert_OtherTxt === true) {
              return false;
          } else {
              return true;
          }
      }
  }

  private loadDropdown() {
      this._dropDownService
      .getSingle(
          {},
          CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
      )
      .subscribe(data => {
          const dp_att_arr: any[] = [];
          if (data && data.length > 0) {
              this.attachmentClassificationtypelookup = data;
              this.loadDropdownResponse(dp_att_arr);
          }
      });
      const source = forkJoin([
          this._dropDownService.getArrayList(
              {
                  nolimit: true
              },
              CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl + '?filter={"nolimit": true}'
          ),
      ]).pipe(
          map((result4) => {
              return {
                  attachmentType: result4[0].map(
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

  attachmentDropDownList_parent: any[] = [];
  attachmentDropDownList_child: any[] = [];
  current_attachmentDropDownList_parent: any[] = [];
  current_attachmentDropDownList_child: any[] = [];
    private loadDropdownResponse(dp_att_arr: any[]) {
        for (const element of this.attachmentClassificationtypelookup) {
            if (element?.typedescription && dp_att_arr.indexOf(element.typedescription) < 0) {
                if (this.isCW) {
                    if (element.typedescription.startsWith('CW-')) {
                        this.attachmentClassificationtype.push({ typedescription: element.typedescription });
                        dp_att_arr.push(element.typedescription);
                    }
                } else {
                    this.attachmentClassificationtype.push({ typedescription: element.typedescription });
                    dp_att_arr.push(element.typedescription);
                }
            }
        }
    }

  loadAttachmentDropDown() {
      this._dropDownService.getArrayList(
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
              this.loadAttachmentDropDownResponse(item);
          });
  }

    private loadAttachmentDropDownResponse(item: any[]) {
            switch (this.componentName) {
                case 'education':
                    this.attachmentDropDownList_parent = item.filter(el => el.ref_key === 'edution' && el.parentkey===null);
                    this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent.slice()
                    this.attachmentDropDownList_child = item.filter(el => el.ref_key === "eduort" || el.ref_key === "repard");
                    break;
                case 'assessmentForm':
                    this.attachmentDropDownList_parent = item.filter(el => el.ref_key === 'placementprf' && el.parentkey===null);
                    this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent.slice()
                    this.attachmentDropDownList_child = item.filter(el => el.ref_key === 'prf');
                    break;
                case 'ytp':
                    this.attachmentDropDownList_parent = item.filter(el => el.ref_key === 'ytp' && el.parentkey===null);
                    this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent.slice()
                    this.attachmentDropDownList_child = item.filter(el => el.ref_key === "ytpmeeting");
                    break;
                default:
                    this.attachmentDropDownList_parent = item.filter(el => (el.ref_key !=='edution' || el.ref_key !== 'placementprf') && el.parentkey===null);
                    this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent.slice()
                    this.attachmentDropDownList_child = item.filter(el => (el.ref_key !== "eduort" || el.ref_key !== "repard" || el.ref_key !== 'prf') && el.parentkey);
                }
            }

  childArray: any[] = [];
  parentVal = '';
  seletedVal = ''
  enablOtherTxt = false;

  openChildMenu(parentVal: any, ref_key: any) {
      this.parentVal = parentVal;
      this.childArray = [];
      const isExist:any[] = this.attachmentDropDownList_child.filter((item: any) => (item.parentkey === ref_key));
      if (isExist) {
          const otherElements = isExist.filter((element)=>element['value_text'].substring(0,5).toLowerCase().includes('other'))
         
            otherElements.forEach((otherElement) => { 
                
            const index = isExist.findIndex((element)=>element['value_text'] === otherElement['value_text'])
                if(index > -1) {
                isExist.splice(index,1);
                }
            })
            this.childArray = [...isExist,...otherElements];
        }
  }

  selectChildMenu(childVal:any, index:any) {
      this.enablOtherTxt = false;
      this.mandatoryAlert_OtherTxt = false;
        this.uploadedFile[this.uploadedIndex].enableOtherTxt = false;
        this.uploadedFile[this.uploadedIndex].other = "";
      const parentEvent = {
          'target': {
              'value': this.parentVal
          }
      }
      this.categoryUpdate(parentEvent, this.uploadedIndex);
      const childEvent = {
          'target': {
              'value': childVal
          }
      }
      this.subcategoryUpdate(childEvent, this.uploadedIndex);
      if(childVal.includes('Other','other')){
          this.enablOtherTxt = true;
          this.uploadedFile[this.uploadedIndex].enableOtherTxt = true;
      }
      this.mandatoryAlert_Title = false;
      this.updatePercentage(index);
  }
  
  selectedItem(index:any) {
      if (!this.uploadedFile[index].attachmentclassificationtypekey) {
          this.seletedVal = '';
      } else {
          this.seletedVal = this.uploadedFile[index].attachmentclassificationsubtypekey;
      }
      return this.seletedVal
  }
  oPenParentMenuOnDoubleClick(i:any) {
    this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent.slice();
      this.uploadedIndex = i
      this.ngZone.onStable.pipe(take(1)).subscribe(() => {
        this.inputMenuTrigger.toArray()[i].openMenu();
  });
  }

  handleTouchStart(i:any){
      this.noOfClicks = this.noOfClicks +1;
      if(this.noOfClicks > 0 && this.noOfClicks % 2 == 0){
        this.oPenParentMenuOnDoubleClick(i);
      }
  }

  private openMenuWithAndFocus(i: number): void {
    const trigger = this.inputMenuTrigger.toArray()[i];
    const inputRef = this.inputElement.toArray()[i];

    if (!trigger || !inputRef) return;

    setTimeout(() => {
      if (!trigger.menuOpen) trigger.openMenu();
      setTimeout(() => inputRef.nativeElement.focus(), 0);
    });
  }
  
    triggerParentMenu(value:any,i:any) {
        this.uploadedIndex = i
        if (value && value.trim() && value.length > 1) {

            this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent
                .filter((list) => list?.value_text?.toLowerCase().includes(value.toLowerCase())).slice();
            const childDropDownValues:any[] = this.attachmentDropDownList_child.filter((item: any) => item.value_text.toLowerCase().includes(value.toLowerCase())).slice();
            if (this.current_attachmentDropDownList_parent.length > 0) {
                this.openMenuWithAndFocus(i);          
              }
            else if (childDropDownValues.length > 0 ) {
                const parentKeys:any[] = childDropDownValues.map((item: any) => item.parentkey);
                this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent
                .filter((list: any) => parentKeys.includes(list.ref_key)).slice();
                this.openMenuWithAndFocus(i);      
              }
            else {
                this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent.slice()
            }


        } else {
            this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent.slice()
        }

    }

  switchInfo() {
    this.showInfo = !this.showInfo;
}
fetchS3Doc(event: any,i: any) {
// No data or functiion to call
}
onNativeDrop(event: DragEvent) {
  event.preventDefault();
  if (event.dataTransfer?.files) {
    const droppedFiles: File[] = Array.from(event.dataTransfer.files);
    this.uploadFile(droppedFiles); 
  }
}
}