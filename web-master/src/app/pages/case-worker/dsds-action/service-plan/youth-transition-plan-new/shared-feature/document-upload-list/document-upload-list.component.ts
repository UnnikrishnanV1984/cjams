import { Component, OnInit, Input } from '@angular/core';
import { AppConfig } from '../../../../../../../app.config';
import { GLOBAL_MESSAGES } from '../../../../../../../@core/entities/constants';
import { HttpHeaders } from '@angular/common/http';
import { CaseWorkerUrlConfig } from '../../../../../case-worker-url.config';
import { FileError, NgxfUploaderService } from 'ngxf-uploader';
import { AlertService, AuthService, DataStoreService } from '../../../../../../../@core/services';
import { AppUser } from '../../../../../../../@core/entities/authDataModel';
import { CASE_STORE_CONSTANTS } from '../../../../../_entities/caseworker.data.constants';

@Component({
    selector: 'document-upload-list',
    templateUrl: './document-upload-list.component.html',
    styleUrls: ['./document-upload-list.component.scss'],
    standalone: false
})
export class DocumentUploadListComponent implements OnInit {

  @Input() uploadedDocuments: any[] = [];
  deleteAttachmentIndex!: number;
  token!: AppUser;
  caseNumber!: string;
  constructor(private _alertService: AlertService,
    private _uploadService: NgxfUploaderService,
    private _authService: AuthService,
    private _dataStoreService: DataStoreService) { }

  ngOnInit() {
    this.token = this._authService.getCurrentUser();
    this.caseNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
  }

  uploadFile(file: any): void {
    if (!(file instanceof Array)) {
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
            this.uploadedDocuments.push(item);
            const uindex = this.uploadedDocuments.length - 1;
            if (!this.uploadedDocuments[uindex].hasOwnProperty('percentage')) {
                this.uploadedDocuments[uindex].percentage = 1;
            }

            this.uploadAttachment(uindex);
            const audio_ext = ['mp3', 'ogg', 'wav', 'acc', 'flac', 'aiff'];
            const video_ext = ['mp4', 'avi', 'mov', '3gp', 'wmv', 'mpeg-4'];
            if (audio_ext.indexOf(fileExt) >= 0) {
                this.uploadedDocuments[uindex].attachmenttypekey = 'Audio';
            } else if (video_ext.indexOf(fileExt) >= 0) {
                this.uploadedDocuments[uindex].attachmenttypekey = 'Video';
            } else {
                this.uploadedDocuments[uindex].attachmenttypekey = 'Document';
            }
        } else {
            // tslint:disable-next-line:quotemark
            this._alertService.error(fileExt + " format can't be uploaded");
        }
    });
}
uploadAttachment(index: any) {
    let uploadUrl = '';
   
        uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.caseNumber+ '&objecttypekey=' + 'YTP';
    

    this._uploadService
        .upload({
            url: uploadUrl,
            headers: new HttpHeaders().set('ctype', 'file'),
            filesKey: ['file'],
            files: this.uploadedDocuments[index],
            process: true,
        })
        .subscribe(
            (response) => {
                if (response.status) {
                    this.uploadedDocuments[index].percentage = response.percent;
                }
                if (response.status === 1 && response.data) {
                    const doucumentInfo = response.data;
                    doucumentInfo.documentdate = doucumentInfo.date;
                    doucumentInfo.title = doucumentInfo.originalfilename;
                    doucumentInfo.objecttypekey = 'YTP';
                    doucumentInfo.rootobjecttypekey = 'YTP';
                    doucumentInfo.activeflag = 1;
                    doucumentInfo.servicerequestid = null;
                    this.uploadedDocuments[index] = { ...this.uploadedDocuments[index], ...doucumentInfo };
                }

            }, (err) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                this.uploadedDocuments.splice(index, 1);
            }
        );
}
deleteAttachment() {
    this.uploadedDocuments.splice(this.deleteAttachmentIndex, 1);
    (<any>$('#delete-attachment-popup')).modal('hide');
}

downloadFile(s3bucketpathname: any) {
   
        // 4200
        s3bucketpathname = s3bucketpathname.replace(/,/g, '');
    const downldSrcURL =  '/api' + s3bucketpathname;
    
    window.open(downldSrcURL, '_blank');
}

confirmDeleteAttachment(index: number) {
    (<any>$('#delete-attachment-popup')).modal('show');
    this.deleteAttachmentIndex = index;
}

}
