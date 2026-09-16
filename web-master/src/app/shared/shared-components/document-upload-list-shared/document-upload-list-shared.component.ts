import { Component, OnInit, Input, ViewChild, Output, EventEmitter, Injector } from '@angular/core';
import { config } from '../../../../environments/config';
import { CaseWorkerUrlConfig } from '../../../pages/case-worker/case-worker-url.config';
import { AlertService, AuthService, CommonHttpService, GenericService, DataStoreService } from '../../../@core/services';
import { AppUser } from '../../../@core/entities/authDataModel';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';//'../../person-info.service';
import { PersonInfoService } from '../../../pages/shared-pages/person-info/person-info.service';
import { Attachment } from '../../../pages/case-worker/dsds-action/attachment/_entities/attachment.data.models';
import { EditAttachmentSharedComponent } from '../edit-attachment-shared/edit-attachment-shared.component';
import { PaginationRequest, PaginationInfo } from '../../../../../src/app/@core/entities/common.entities';
import { CASE_STORE_CONSTANTS } from '../../../../../src/app/pages/case-worker/_entities/caseworker.data.constants';
import { UploadSharedService } from '../../../@core/services/upload-shared.service';
import { ActivatedRoute, Router } from '@angular/router';
import moment from 'moment';
import { apiResourcePath } from '../../../@core/common/initializer';

declare var $: any;
@Component({
    selector: 'document-upload-list-shared',
    templateUrl: './document-upload-list-shared.component.html',
    styleUrls: ['./document-upload-list-shared.component.scss'],
    standalone: false
})
export class DocumentUploadListSharedComponent implements OnInit {

  @Input() isEdit: boolean = false;
  @Input() componentName!: string;
  @Input() tab_type!: string;
  @Input() uploadedFiles?:any;
  @Input() showedit?:any;
  @Input() uploadType = 'person';
  @Input() uploadNumber?:any;
  @Input() colSize = 'col-md-12 col-lg-6 col-sm-12';
  @Input() titleCol = true;
  @Input() categoryCol = true;
  @Input() subCategoryCol = true;
  @Input() uploadByCol = true;
  @Input() uploadhealth?:any;
  @Input() updatedByCol = true;
  @Input() docDateCol = true;
  @Input() docNameCol = true;
  @Input() pageType?:any;
  @Input() ivePersonId?:any;
  @Input() additionalobjecttype?:any;
  @Input() additionalobjecttypevalue: any;
  @Input() modalId="upload-attachment";
  @Input() deleteId="delete-attachment-popup";
  @Input() isDisable = false;
  @Input() hideUploadButton = false;
  @Input() paginationRecorsds: any = 0;
  @Input() paginationInfoperson: PaginationInfo = new PaginationInfo();
  @Input() isApproved!: boolean;
  @Input() isView: boolean = true;
  @Input() isDownload: boolean = false;
  @Input() isDelete: boolean = false;
  @Input() sortColumns: boolean = false;
  @Input() intakeNumber!: string;
  @ViewChild(EditAttachmentSharedComponent) editAttach!: EditAttachmentSharedComponent;
  @Output() FileEdited = new EventEmitter<any>();
  @Output()loadEvent = new EventEmitter<any>();
  @Output() pageChangedEvent = new EventEmitter<any>();
  @Output() sortedEvent =  new EventEmitter<any>();
  @Output() downloadEvent = new EventEmitter<any>();
  @Output() addtoCaseEmit = new EventEmitter<any>();
  personid: any;
  token?: AppUser;
  deleteAttachmentIndex!: number;
  attachment_type!: string;
  caseNumber!: string;
  unsavedattachmentscount!: number;
  id: string;
  isServiceCase = false;
  isAdoptionCase = false;
  isClosed = false;
  filesInProgress: any = [];
  daNumber: string;
  selectedPerson: any;
  private uploadService: UploadSharedService;
  private route: ActivatedRoute;
  private _authService: AuthService;
  public _personInfoService: PersonInfoService;
  private _alertService: AlertService;   
  private _dropDownService: CommonHttpService;
  private _dataStoreService: DataStoreService;
  personinfo: any;
  personname: any;
  personcjamspid: any;
  deletetype: any;
  maxlargefilesize: any;

  constructor(private injector : Injector,   
    private _service: GenericService<Attachment>,   
    private router: Router) { 
      this.uploadService = this.injector.get<UploadSharedService>(UploadSharedService);
      this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
      this._authService = this.injector.get<AuthService>(AuthService);
      this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this._dropDownService = this.injector.get<CommonHttpService>(CommonHttpService);
      this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
      this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
      this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
      this.selectedPerson = this._dataStoreService.getData('personIdSelectedOnDocumentsTab');
    }

  ngOnInit() {
    this.maxlargefilesize = this.humanizeBytes(config.largeUploadMaxSizeLimit);
    this.isClosed = this._authService.iscaseclosed(this.pageType);
    this.token = this._authService.getCurrentUser();
    this._dataStoreService.setData('attachmenttype', 'person');
    this.personid = this._personInfoService.getPersonId();
    this.personinfo = this._personInfoService.getPersonInfo();
    if((this.pageType == 'ivefc' || this.pageType == 'ivegap' || this.pageType == 'iveadoption' || this.pageType === 'YTP') && this.ivePersonId) {
      this.personid = this.ivePersonId;
    } else {
      this.personname = this.personinfo?.personbasicdetails?.firstname + ' ' + this.personinfo?.personbasicdetails?.lastname;
      this.personcjamspid = this.personinfo?.personbasicdetails?.cjamspid;
      this._dataStoreService.setData('personnameselected',this.personname);
      this._dataStoreService.setData('personcjamspidselected', this.personcjamspid);
    }
    this.loadUnsavedAttachmentList();
    this.uploadService.uploadFileProgress$.subscribe(uploadprogress => {
      this.filesInProgress = uploadprogress;
    });
    this.route.queryParams.subscribe(params => {
      if(params['retrydocument'] == "true") {
        setTimeout(() => {
        this._dataStoreService.setData('deletedocid', params['deletedocid']);
        this.uploadLargeFileDocOnRetry();
        this.router.navigate(
          [], 
          {
            relativeTo: this.route,
            queryParams: { retrydocument:false},
            queryParamsHandling: 'merge'
          }
        );
        },2000);
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

  closeupload(personid?:any){
    let clsUpldprsn = this.personid ? this.personid : this._dataStoreService.getData('personid');
    this.personid = personid ? personid : clsUpldprsn;
    this.loadUnsavedAttachmentList();
  }

  private loadUnsavedAttachmentList() {
    this.unsavedattachmentscount = 0;
    let inputreq;
    if(this.pageType==='courtOrderNew' || this.pageType==='referServiceNew'){
      this.isServiceCase = true;
    }
    if(this.personid) {
      inputreq = {
        personid: this.personid ,
        objecttypekey: 'Person',
        sortcolumn: 'updatedon' ,
        sortby: 'desc',
        activeflag: 2
      };
    } else{
      inputreq = this.inputreqElseCondition();
    }
    
    this.searchcaseworkerattachmentsFn(inputreq);
}

  private searchcaseworkerattachmentsFn(inputreq: any) {
    if(inputreq.personid || inputreq.servicerequestid || inputreq.servicecaseid || inputreq.adoptioncaseid) {
      this._dropDownService
        .getPagedArrayList(
          new PaginationRequest({
            where: inputreq,
            method: 'get',
            page: 1,
            nolimit: true
          }),
          CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentGridUrl + '?filter')
        .subscribe((response: any) => {
          if (response && Array.isArray(response) && response.length) {
            this._dropDownServiceResponse(response);
          }
        });
    }
  }

  private inputreqElseCondition() {
    let objtyKey = (this.isServiceCase ? 'Servicecase' : 'ServiceRequest');
    return {
      personid: null,
      servicerequestid: (this.isServiceCase || this.isAdoptionCase || this.pageType === 'subsidyAgreement') ? null : this.id,
      servicecaseid: (this.isServiceCase || this.pageType === 'subsidyAgreement') ? this.id : null,
      adoptioncaseid: this.isAdoptionCase ? this.id : null,
      objecttypekey: this.isAdoptionCase ? 'Adoptioncase' : objtyKey,
      sortcolumn: 'updatedon',
      sortby: 'desc',
      activeflag: 2
    };
  }

  private _dropDownServiceResponse(response: any[]) {
    const searchcaseworkerattachments = response[0].searchcaseworkerattachments ?
      response[0].searchcaseworkerattachments?.filter((attachement:any[string]) => attachement['insertedby'] === this.token?.user['securityusersid']
        || attachement['insertedby'] === this.token?.user.userprofile.displayname
        || attachement['displayname'] === this.token?.user.userprofile.displayname)
      : [];
    const result = searchcaseworkerattachments;
    if (result) {
      this.unsavedattachmentscount = result.length;
    }
  }

  uploadFile() {
    this.loadEvent.emit(true);
    this._dataStoreService.setData('largefileupload', false);
    if(this.personid) {
      this._dataStoreService.setData('personid', this.personid);
    } 
    this._dataStoreService.setData('openupload', true);   
    this._dataStoreService.setData('uploadNumber', this.uploadNumber);   
    $('#'+this.modalId).modal('show');
  }

  uploadLargeFileDoc() {
    this.loadEvent.emit(true);
    this._dataStoreService.setData('largefileupload', true); 
    if(this.personid) {
      this._dataStoreService.setData('personid', this.personid);
    } 
    this._dataStoreService.setData('openupload', true);   
    this._dataStoreService.setData('uploadNumber', this.uploadNumber);
    $('#'+this.modalId).modal('show');
    $('div.modal-backdrop.fade.show').hide();
  }

  // retrydocument reaches every instance of this component on the page (education renders
  // four, one per quarter), so only the instance for the selected quarter may auto-open -
  // otherwise four modals stack. A direct UPLOAD click is never gated: each instance
  // already carries its own modalId and its own additionalobjecttype.
  private uploadLargeFileDocOnRetry() {
    if (!this.additionalobjecttype || this.additionalobjecttype === this.additionalobjecttypevalue) {
      this.uploadLargeFileDoc();
    }
  }

  FileUploaded(event:any) {
    this.FileEdited.emit(event);
  }

  editAttachment(modal: any,filetype?: any) {
    modal.activeflag = 1;
    modal.editfiletype = filetype;
    this.editAttach.editForm(JSON.parse(JSON.stringify(modal)), true);
    $('#edit-attachment').modal('show');
  }
 
  deleteAttachment() { 
    const workEnv = config.workEnvironment;
    const documentPropertiesId = this.uploadedFiles[this.deleteAttachmentIndex].documentpropertiesid;
    const documentId = this.uploadedFiles[this.deleteAttachmentIndex].ecmsdocumentid;
    if(!documentPropertiesId || documentPropertiesId == undefined) {
        this.uploadedFiles.splice(this.deleteAttachmentIndex, 1);
        $('#'+this.deleteId).modal('hide');
        return;
    } 
    if (workEnv === 'state') {
      const id = documentPropertiesId + '&' + documentId;
      this.handleDeleteAttachmentFn(id);
    } else {
        this.handleDeleteAttachmentFn(documentPropertiesId);
    }
}
  private handleDeleteAttachmentFn(id: any) {
    if(this.deletetype == "largefiledelete") {
      this._service.endpointUrl =
      CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteLargeFileAttachmentUrl;
    } else {
      this._service.endpointUrl =
      CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteAttachmentUrl;
    }
    this._service.remove(id).subscribe(
      result5 => {
        this._alertService.success('Attachment Deleted successfully!');
        this.uploadedFiles.splice(this.deleteAttachmentIndex, 1);
        $('#' + this.deleteId).modal('hide');
      },
      err => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  downloadFile(s3bucketpathname: any) { 
    s3bucketpathname = s3bucketpathname.replace(/,/g, '');
    const downldSrcURL =  '/api' + apiResourcePath(s3bucketpathname);    
    window.open(downldSrcURL, '_blank');
  }

  confirmDeleteAttachment(index: number, type?: any) {
    $('#'+this.deleteId).modal('show');
    this.deleteAttachmentIndex = index;
    this.deletetype = type;
  }

  pdpageChanged(pageNumber: any) {
    this.paginationInfoperson.pageNumber = pageNumber;
    this.pageChangedEvent.emit(pageNumber);
  }

  onSorted($event: any) {
    let sortObj = {
      sortDirection : $event.sortDirection,
      sortColumn : $event.sortColumn
    }

    this.sortedEvent.emit(sortObj)
}

  isArray(element: any) {
    return element && typeof element === "object" && Array.isArray(element) && element.length > 0
  }

  downloadAttachment(attachment: any) {
    this.downloadEvent.emit(attachment)
  }

  addtoCase(event: any, fileDetails: any) {
    const params = {event, fileDetails};
    this.addtoCaseEmit.emit(params)
  }

  downloadLargeAttachment(source: any) {
    this._dropDownService
      .downloadXml(
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.downloadFileFromEDMS + '?docId=' + source.ecmsdocumentid + '&filename=' + source.originalfilename
      ).subscribe((result: any) => {
        const blob = new Blob([result]);
        const link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        link.download = source.originalfilename;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
      });
  }

  downloadLargeFileView(source: any) {
    if (source.ecmsdocumentid !== '' )
     {
      const where = {
        "docId": source.ecmsdocumentid ,
        "filename":  source.originalfilename
      }
      const endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.downloadFileViewFromEDMS;
      this._dropDownService
      .create(
        {
          method: 'post',
          where
        },
        endpointUrl + '?filter'
      ).subscribe(
          (response) => {
            const result = (typeof response === 'string') ? JSON.parse(response) : response;
            const s3bucketpathname = result?.downloadUrl?.replace(/,/g, '');
            if (!s3bucketpathname) {
              this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
              return;
            }
            window.open(s3bucketpathname, '_blank');
          },
          (_error) => {
              this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          }
      );
    }     
  }

  checkfileprogress(filesInProgress: any, attachment: any) {
    return filesInProgress && filesInProgress.filter((fileitem: any) => fileitem.ecmsdocumentid === attachment.ecmsdocumentid).length > 0;
  }

  retrythefile(attachment: any) {
    this._dataStoreService.setData('deletedocid',attachment.ecmsdocumentid);
    if(this.hideUploadButton) {
      let returnUrl: any;
      switch (this.pageType) {
        case 'caseattachments':
          returnUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment/attachment-upload/largefileupload';
          break;
        case 'intakeattachments':
          returnUrl = '/pages/newintake/my-newintake/' + this.intakeNumber + '/edit/attachment';
          break;
        case 'casepersonattachments':
          returnUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment/attachment-upload/largefileupload/person/' + this.selectedPerson;
          break;
        case 'meeting':
          this._dataStoreService.setData('largefileretrymeeting', true);
          break;
        case 'note':
          this._dataStoreService.setData('largefileretrynotes', true);
            break;
      }
      this.router.navigate([returnUrl],{queryParams: {retrydocument: true,deletedocid: attachment.ecmsdocumentid}});
     
    } else {
      this.uploadLargeFileDoc();
    }
    
  }

  removewidgetnotification(file: any) {
    const uploadprogress = this.uploadService.getUploadFileProgress(); 
    if(uploadprogress && uploadprogress.length > 0) {
        const uprogress = uploadprogress.filter((up: any) => up.ecmsdocumentid != file.ecmsdocumentid);
        this.uploadService.setUploadFileProgress(uprogress);                   
    }            
  }
  deletetheretryfile(file: any, deleteindex: any) {
      const workEnv = config.workEnvironment;
      this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteLargeFileAttachmentUrl;
      let id : any;
      if (workEnv === 'state') {
          id = file.documentpropertiesid + '&' + file.ecmsdocumentid;
      } else {
          id = file.documentpropertiesid;
      }
      this._service.remove(id).subscribe(
          _result3 => {
              this.removewidgetnotification(file);
              this.uploadedFiles.splice(deleteindex, 1);
              this._alertService.success('Attachment Deleted successfully!');
          },
          _err => {
              this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      });
  }


}