import { Component, OnDestroy, OnInit } from '@angular/core';
import { UploadSharedService } from '../../../@core/services/upload-shared.service';
import { AlertService, AuthService, CommonHttpService, GenericService } from '../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../pages/case-worker/case-worker-url.config';
import { Attachment } from '../../../pages/case-worker/dsds-action/attachment/_entities/attachment.data.models';
import { config } from '../../../../environments/config';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { environment } from '../../../../environments/environment';

declare let $: any;
@Component({
  selector: 'upload-progress-widget',
  templateUrl: './upload-progress-widget.component.html',
  styleUrls: ['./upload-progress-widget.component.scss'],
  standalone: false
})
export class UploadProgressWidgetComponent implements OnInit, OnDestroy {
  uploadFileProgressSubscription: any;
  filepending = 0;
  fileuploadpending = 0;
  fileuploadcomplete = 0;
  fileuploadfailed = 0;
  filesInProgress: any = [];
  filestatuspendingcount = 0;
  filestatuspendinglist: any = [];
  showProgress: boolean = false;
  showProgressDirection : boolean = false;
  retryfile: any;
  openDownward: boolean = false;
  constructor(
    private uploadService: UploadSharedService, 
    private _authService: AuthService,private _commonService: CommonHttpService,
    private _service: GenericService<Attachment>,
    private _alertService: AlertService) { 
      setInterval(() => {  
        if(this.filestatuspendingcount > 0) {
          this.fileuploadstatusrefresh();
        }
      }, environment.FileUploadRefreshTime);
   }

  ngOnInit(): void {
    this.uploadFileProgressSubscription = this.uploadService.uploadFileProgress$.subscribe(uploadprogress => {
      if(uploadprogress && uploadprogress.length > 0) {
        const upprogress = uploadprogress.filter((up: any) => (up.uploadsuccesschecked === undefined));
        const upstatuspending = uploadprogress.filter((up: any) => (up.uploadstatus === 'Pending' && up.finalstatus === undefined))?.map((up1: any) => up1.ecmsdocumentid);
        this.fileuploadpending = upprogress.filter((up: any) => ((up.uploadstatus === 'Pending' || up.uploadstatus === 'SUCCESS') && up.finalstatus === undefined)).length;
        this.fileuploadcomplete = upprogress.filter((up: any) => (up.uploadstatus === 'SUCCESS' && up.finalstatus === 'SUCCESS')).length;
        this.fileuploadfailed = upprogress.filter((up: any) => (up.uploadstatus === 'FAILED' || up.finalstatus === 'FAILED')).length;
        this.filepending = upprogress.length;
        this.filesInProgress = upprogress;
        this.filestatuspendingcount = upstatuspending.length;
        this.filestatuspendinglist = upstatuspending;
      } else {
        this.filepending = 0;
        this.filesInProgress = [];
      }
    });
  }

  fileuploadstatusrefresh() {
    const inputreq = {
      userid: this._authService.getCurrentUser().user.securityusersid,
      filestatuspendinglist: this.filestatuspendinglist
    };
    this._commonService
    .getArrayList(
      {
        where: inputreq,
        method: 'get'
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.GetFileUploadStatusUrl
  )
  .subscribe((response: any) => {            
      const fileUploadStatusupdaterecords = response[0].getfileuploadstatusupdate;
      if(fileUploadStatusupdaterecords && fileUploadStatusupdaterecords.length > 0) {        
        this.filesInProgressResponseFn(fileUploadStatusupdaterecords);        
      }
    });    
  }

  private filesInProgressResponseFn(fileUploadStatusupdaterecords: any) {
    this.filesInProgress.map((fip: any) => {
      if (fip.uploadstatus === 'Pending' && fip.finalstatus === undefined && this.filestatuspendingcount > 0) {
        fileUploadStatusupdaterecords.forEach((element: any) => {
          if (fip.ecmsdocumentid === element.ecmsdocumentid) {
            fip.finalstatus = element.finalstatus;
            fip.uploadstatus = element.uploadstatus;
            const upstatuspending = this.filesInProgress.filter((up: any) => (up.uploadstatus === 'Pending' && up.finalstatus === undefined))?.map((up1: any) => up1.ecmsdocumentid);
            this.filestatuspendingcount = upstatuspending.length;
            this.filestatuspendinglist = upstatuspending;
            this.fileuploadpending = this.filesInProgress.filter((up: any) => ((up.uploadstatus === 'Pending' || up.uploadstatus === 'SUCCESS') && up.finalstatus === undefined)).length;
            this.fileuploadcomplete = this.filesInProgress.filter((up: any) => (up.uploadstatus === 'SUCCESS' && up.finalstatus === 'SUCCESS')).length;
            this.fileuploadfailed = this.filesInProgress.filter((up: any) => (up.uploadstatus === 'FAILED' || up.finalstatus === 'FAILED')).length;
          }
        });
      }
    });
  }

  showuploadingprogress(event: MouseEvent) {
    const y= event.clientY;
    this.openDownward = y < window.innerHeight / 2; 
    if (this.showProgress) {
      this.showProgress = false;
    } else {
      this.showProgress = true;
    }
    this.showProgressDirection = this.openDownward ? this.showProgress : !this.showProgress;
  }
  retrythefile(file: any) {
    this.retryfile = file;
    $('#confirm-retry').modal('show');
  }
  removewidgetnotification(file: any) {
    const uploadprogress = this.uploadService.getUploadFileProgress(); 
    if(uploadprogress && uploadprogress.length > 0) {
      const uprogress = uploadprogress.filter((up: any) => up.ecmsdocumentid == file.ecmsdocumentid);
      if(uprogress && uprogress.length > 0) {            
        uprogress[0].uploadsuccesschecked = true;
      }     
      this.uploadService.setUploadFileProgress(uploadprogress);                    
    }     
  }

  deletetheretryfile(file: any) {
    const workEnv = config.workEnvironment;
    this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteAttachmentUrl;
    let id : any;
    if (workEnv === 'state') {
        id = file.documentpropertiesid + '&' + file.ecmsdocumentid;
    } else {
        id = file.documentpropertiesid;
    }
    this._service.remove(id).subscribe(
        _result3 => {
            this.removewidgetnotification(file);
            this._alertService.success('Attachment Deleted successfully!');
        },
        _err => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }
  
  routetodocumentstab() {
    $('#confirm-retry').modal('hide');
    if(this.retryfile.casetype) {
      this.uploadService.routetodocumentsupload(this.retryfile);
    } else {
      const inputreq = {
        userid: this._authService.getCurrentUser().user.securityusersid,
        ecmsdocumentid: this.retryfile.ecmsdocumentid
      };
      this._commonService
      .getArrayList(
        {
          where: inputreq,
          method: 'get',
          page: 1,
          limit: 10
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.FailedAttachmentGridUrl
    )
    .subscribe((response: any) => {            
        const uploadfailedfile = response[0].getuploadfailedattachments;
        if(uploadfailedfile && uploadfailedfile.length > 0) {
          this.uploadService.routetodocumentsupload(uploadfailedfile[0]);
        }
      });    
    }
  }

  ngOnDestroy(): void {
    if (this.uploadFileProgressSubscription) {
      this.uploadFileProgressSubscription.unsubscribe();
    }
  }
}