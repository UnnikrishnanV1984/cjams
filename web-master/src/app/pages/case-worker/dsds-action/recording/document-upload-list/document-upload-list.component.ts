import { Component, OnInit, Input, Output,EventEmitter, Injector } from '@angular/core';
import { config } from '../../../../../../environments/config';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { FileError } from 'ngxf-uploader';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { Attachment } from '../../attachment/_entities/attachment.data.models';
import { AlertService, AuthService, DataStoreService, GenericService } from '../../../../../@core/services';
import { ActivatedRoute } from '@angular/router';
import { DsdsService } from '../../_services/dsds.service';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { IntakeStoreConstants } from '../../../../../pages/newintake/my-newintake/my-newintake.constants';
import moment from 'moment';

@Component({
    selector: 'document-upload-list',
    templateUrl: './document-upload-list.component.html',
    styleUrls: ['./document-upload-list.component.scss'],
    standalone: false
})
export class DocumentUploadListComponent implements OnInit {

  @Input() uploadedDocuments: any[] = [];
  @Input() uploadType!: any;
  deleteAttachmentIndex!: number;
  token!: AppUser;
  caseNumber!: string;
  enableUpload = false;
  attachment_type = '1';
  involvedPerson: any[]=[];
  id!: string;
  personid='';
  intakeNum: any;
  isServiceCase=false;
  unsavedattachmentscount!: number;
  private _alertService: AlertService;
  private _dropDownService: CommonHttpService;
  private _authService: AuthService;
  private _service: GenericService<Attachment>;
  private _dsdsService: DsdsService;
  private _dataStoreService: DataStoreService;
  private route: ActivatedRoute;
  @Output()loadEvent = new EventEmitter<any>();
  islargefileupload: boolean = false;
  retrydoc: any;
  personnameselected: any;
  personcjamspidselected: any;
  maxlargefilesize: any;

  constructor(private injector: Injector) {
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._dropDownService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._service = this.injector.get<GenericService<Attachment>>(GenericService);
    this._dsdsService = this.injector.get<DsdsService>(DsdsService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this.uploadedDocuments = [];
    this.route.queryParams.subscribe(params => {
        this.retrydoc = params['retrydocument'];
    });
    }
    confirmattachmentpopupid = '#confirm-attachment-popup';
    deleteattachmentpopupid = '#delete-attachment-popup';
  ngOnInit() {
    this.maxlargefilesize = this.humanizeBytes(config.largeUploadMaxSizeLimit);
    this.token = this._authService.getCurrentUser();
    this.caseNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.isServiceCase = this._dsdsService.isServiceCase();
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    const intakeNum = this._dataStoreService.getData(IntakeStoreConstants.intakenumber);
    this.intakeNum = (intakeNum) ? intakeNum : null;        
    this.getInvolvedPerson();
    this.onChange('1');
    if(this.retrydoc) {        
        this.attachment_type = this._dataStoreService.getData('uploadattachmenttype');
        if(this.attachment_type == '2') {
            this.personid = this._dataStoreService.getData('uploadpersonid');
        }
        this.islargefileupload = true;
        this.continueUpload();
    }
    this._dataStoreService.currentStore.subscribe((item) => {
        if (item.largefileretrymeeting === true || item.largefileretrynotes === true) {
            this.uploadLargeFile();
        }
    }); 
  }

  private humanizeBytes(bytes: number): string {
    if (bytes === 0) {
        return "0 Byte";
    }
    if (!bytes) {
        return "";
    }
    const k = 1024;
    const sizes: string[] = ["Bytes", "KB", "MB", "GB", "TB", "PB"];
    const i: number = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + " " + sizes[i];
   }

  continueUpload() {
    this.loadEvent.emit(true) 
    if(this.attachment_type == '1')  {
        this.personid = '';
        this.reusableAttachmentTypeFn('case', this.personid, 'personid');
    } else if(this.attachment_type == '2'){
        if(this.personid=='' || !this.personid) {
            this._alertService.error('Please choose a person');
            return;
        } else {
            this.reusableAttachmentTypeFn('person', this.personid, 'personid');
        }
    }
  }
  // Assosiated to continueUpload method
    private reusableAttachmentTypeFn(attachmenttype: any, idData: any, setId: any) {
        this._dsdsService.setField('attachmenttype', attachmenttype);
        this._dsdsService.setField(setId, idData);
        this._dataStoreService.setData('largefileupload',this.islargefileupload);
        this._dataStoreService.setData('openupload', true);
        (<any>$('#upload-attachment')).modal('show');
        if (this.uploadType == 'note') {
            (<any>$('#myModal-recordings')).modal('hide');
        } else if (this.uploadType == 'meeting') {
            (<any>$('#add-new-meeting')).modal('hide');
        }
        (<any>$(this.confirmattachmentpopupid)).modal('hide');
    }

  onChange(event: any){
    this.unsavedattachmentscount = 0;
      if(event == '1'){
        const inputreq = {
            intakenumber: this.intakeNum,
            personid: null ,
            servicerequestid: (this.isServiceCase) ? null : this.id,
            servicecaseid: this.isServiceCase ? this.id : null,
            objecttypekey: this.isServiceCase ? 'Servicecase' : 'ServiceRequest',
            sortcolumn: 'updatedon' ,
            sortby: 'desc',
            activeflag: 2
        };
          this.loadUnsavedAttachmentList(inputreq);
      }
  }
  onPersonChange(event: any){
    this.unsavedattachmentscount = 0;
    if(this.attachment_type == '2' && event.target.value){
        const inputreq = {
            intakenumber: this.intakeNum,
            personid: event.target.value ,
            servicerequestid: null,
            servicecaseid: null,
            objecttypekey: 'Person',
            sortcolumn: 'updatedon' ,
            sortby: 'desc',
            activeflag: 2
        };
        this.loadUnsavedAttachmentList(inputreq);
        const personinfo = this.involvedPerson.filter(person => person.personid == event.target.value);
        this._dsdsService.setField('personnameselected', personinfo[0].firstname + ' ' + personinfo[0].lastname);
        this._dsdsService.setField('personcjamspidselected', personinfo[0].cjamspid)
    }
}
    
private loadUnsavedAttachmentList(inputreq: any) {
    this._dropDownService
        .getPagedArrayList(
            new PaginationRequest({
                where: inputreq,
                method: 'get',
                page: 1,
                nolimit:true
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentGridUrl + '?filter')
            .subscribe((response: any) => {
                if (response && Array.isArray(response) && response.length) {
                    const searchcaseworkerattachments = response[0].searchcaseworkerattachments ?
                        response[0].searchcaseworkerattachments.filter((attachement: any) => attachement['insertedby'] === this.token.user['securityusersid'] 
                        || attachement['insertedby'] === this.token.user.userprofile.displayname
                        || attachement['displayname'] === this.token.user.userprofile.displayname)
                        : [];
                    const result = searchcaseworkerattachments;
                    if (result) {
                        this.unsavedattachmentscount = result.length;
                    } 
                 } 
            });
}

getInvolvedPerson() {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    let url = '';

    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    let inputRequest: Object;
    if (this.isServiceCase) {
        inputRequest = {
            objectid: this.id,
            objecttypekey: 'servicecase'
        };
    } else {
        inputRequest = {
            intakeserviceid: this.id,
            intakenumber: this.intakeNum,
            isExpungementSuperUser:isExpungementSuperUser,
            iscaseexpunged:iscaseexpunged
        };
    }
    this._dropDownService
        .getSingle(
            new PaginationRequest({
                page: 1,
                limit: 20,
                method: 'get',
                where: inputRequest
            }),
            url + '?filter'
        )
        .subscribe(data => {
            if (data && data.data.length > 0) {
                this.involvedPerson = data.data;
            }
        });
}

uploadFile(file: any): void {
    this.islargefileupload = false;
    const disableButton = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CONTACT_NOTES_SAVE_ENABLED);
    if(disableButton) {
        return;
    } else {
        (<any>$(this.confirmattachmentpopupid)).modal('show');
    }
}

uploadLargeFile(): void {
    this.islargefileupload = true;
    const disableButton = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CONTACT_NOTES_SAVE_ENABLED);
    if(disableButton) {
        return;
    } else {
        (<any>$(this.confirmattachmentpopupid)).modal('show');
    }
}

deleteAttachment() {
    const workEnv = config.workEnvironment;
    let documentPropertiesId = this.uploadedDocuments[this.deleteAttachmentIndex].documentpropertiesid;
    const documentId = this.uploadedDocuments[this.deleteAttachmentIndex].filename;
    if(!documentPropertiesId || documentPropertiesId == undefined) {
        this.uploadedDocuments.splice(this.deleteAttachmentIndex, 1);
        (<any>$(this.deleteattachmentpopupid)).modal('hide');
        return;
    }
    this._service.endpointUrl =
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteAttachmentUrl;
    if (workEnv === 'state') {
        documentPropertiesId = documentPropertiesId + '&' + documentId;
    }
    this._service.remove(documentPropertiesId).subscribe(
        result => {
            this._alertService.success('Attachment Deleted successfully!');
            this.uploadedDocuments.splice(this.deleteAttachmentIndex, 1);
            (<any>$(this.deleteattachmentpopupid)).modal('hide');
        },
        err => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
    );
}

closeAttachment() {
    (<any>$(this.deleteattachmentpopupid)).modal('hide');
}

closeattachmentConfirm() {
    (<any>$(this.confirmattachmentpopupid)).modal('hide');
}
downloadFile(s3bucketpathname: any) {

    s3bucketpathname = s3bucketpathname.replace(/,/g, '');
    const downldSrcURL =  '/api' +  s3bucketpathname;    
    window.open(downldSrcURL, '_blank');
}

confirmDeleteAttachment(index: number) {
    (<any>$(this.deleteattachmentpopupid)).modal('show');
    this.deleteAttachmentIndex = index;
}

}
