import { Component, OnInit, Input } from '@angular/core';
import { config } from '../../../../../../environments/config';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { AlertService, AuthService, GenericService, DataStoreService } from '../../../../../@core/services';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { PersonInfoService } from '../../person-info.service';
import { Attachment } from '../../../../case-worker/dsds-action/attachment/_entities/attachment.data.models';

declare var $: any;

@Component({
    selector: 'document-upload-list',
    host: {
        class: 'document-upload-list'
    },
    templateUrl: './document-upload-list.component.html',
    styleUrls: ['./document-upload-list.component.scss'],
    standalone: false
})
export class DocumentUploadListComponent implements OnInit {

  @Input() uploadedFiles:any;
  @Input() uploadType = 'person';
  @Input() uploadNumber:any;
  @Input() colSize = 'col-md-12 col-lg-6 col-sm-12';
  @Input() titleCol = true;
  @Input() categoryCol = true;
  @Input() subCategoryCol = true;
  @Input() uploadByCol = true;
  @Input() updatedByCol = true;
  @Input() pageType:any;
  @Input() isEdit: boolean = false;
  @Input() componentName: string='';
  @Input() modalId="upload-attachment";
  @Input() deleteId="delete-attachment-popup";
  personid: any;
  token!: AppUser;
  deleteAttachmentIndex!: number;
  attachment_type!: string;
  caseNumber!: string;

  constructor(private _alertService: AlertService,
    private _authService: AuthService,
    private _service: GenericService<Attachment>,
    private _dataStoreService: DataStoreService,
    public _personInfoService: PersonInfoService) { }

  ngOnInit() {
    this.token = this._authService.getCurrentUser();
    this._dataStoreService.setData('attachmenttype', 'person');
    this.personid = this._personInfoService.getPersonId();
  }

  uploadFile() {
    this._dataStoreService.setData('personid', this.personid);
    this._dataStoreService.setData('uploadNumber', this.uploadNumber);
    $('#'+this.modalId).modal('show');
  }
 
  deleteAttachment() { 
    const workEnv = config.workEnvironment;
    const documentPropertiesId = this.uploadedFiles[this.deleteAttachmentIndex].documentpropertiesid;
    const documentId = this.uploadedFiles[this.deleteAttachmentIndex].filename;
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
  // Assosiated with deleteAttachment method
  private handleDeleteAttachmentFn(documentPropertiesId: any) {
    this._service.endpointUrl =
      CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteAttachmentUrl;
    this._service.remove(documentPropertiesId).subscribe(
      () => {
        this._alertService.success('Attachment Deleted successfully!');
        this.uploadedFiles.splice(this.deleteAttachmentIndex, 1);
        $('#' + this.deleteId).modal('hide');
      },
      () => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  downloadFile(s3bucketpathname:any) {
    s3bucketpathname = s3bucketpathname.replace(/,/g, '');
    const downldSrcURL =  '/api' + s3bucketpathname;
    window.open(downldSrcURL, '_blank');
  }

  confirmDeleteAttachment(index: number) {
    $('#'+this.deleteId).modal('show');
    this.deleteAttachmentIndex = index;
  }

}