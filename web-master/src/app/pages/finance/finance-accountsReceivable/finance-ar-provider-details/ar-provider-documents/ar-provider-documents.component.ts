import { Component, OnInit } from '@angular/core';
import { CommonHttpService, GenericService, AlertService } from '../../../../../@core/services';
import { FinanceArProviderDetailsService } from '../finance-ar-provider-details.service';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { config } from '../../../../../../environments/config';
import { Attachment } from '../../../../case-worker/dsds-action/attachment/_entities/attachment.data.models';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

declare let $: any;
@Component({
    selector: 'documents',
    templateUrl: './ar-provider-documents.component.html',
    styleUrls: ['./ar-provider-documents.component.scss'],
    standalone: false
})
export class ArProviderDocumentsComponent implements OnInit {
  receivableDocumentList :any[]= [];
  doucmentFlag:boolean=false;
  documentPropertiesId: any;
  documentId: any;
  deleteattachmentpopupid = '#delete-attachment';
  constructor(
    private _commonHttpService: CommonHttpService,
    private _providerService: FinanceArProviderDetailsService,
    private _service: GenericService<Attachment>,
    private _alertService: AlertService
  ) { }

  ngOnInit() {
    this.receivableDocuments();
  }

  receivableDocuments() {
     this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
      where: {
        providerid: this._providerService.providerid
      },
      method: 'get',
    }), 'accountreceivabledocuments/getaccountreceivabledocuments?filter'
    ).subscribe((result: any) => {
      if (result && result[0] && result[0].getaccountreceivabledocuments) {
        this.receivableDocumentList = result[0].getaccountreceivabledocuments;
      } else {
        this.receivableDocumentList = [];
        this.doucmentFlag = true;
      }
    });
  }

  downloadFile(s3bucketpathname:any) {
    s3bucketpathname = s3bucketpathname.replace(/,/g, '');
    const downldSrcURL =  '/api' + s3bucketpathname;
    window.open(downldSrcURL, '_blank');
}
confirmDelete(modal:any) {
  this.documentPropertiesId = modal.accountreceivabledocumentsid;
  this.documentId = modal.ecmsdocumentid;
  $(this.deleteattachmentpopupid).modal('show');
}
deleteAttachment() {
  const workEnv = config.workEnvironment;
  if (workEnv === 'state') {
      const id = this.documentPropertiesId + '&' + this.documentId;
      this.handleDeleteDocumentFn(id);
  } else {
      this.handleDeleteDocumentFn(this.documentPropertiesId);
  }
}

// Assosiated with deleteAttachment method
  private handleDeleteDocumentFn(id: any) {
    this._service.endpointUrl = 'Accountreceivabledocuments/delete';
    this._service.remove(id).subscribe(
      (result:any) => {
        $(this.deleteattachmentpopupid).modal('hide');
        this.receivableDocuments();
        this._alertService.success('Attachment Deleted successfully!');
      },
      err => {
        this.receivableDocuments();
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }
}

