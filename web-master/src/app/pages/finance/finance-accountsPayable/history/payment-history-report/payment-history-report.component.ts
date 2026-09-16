import { Component, OnInit, ViewChild } from '@angular/core';
import { CommonHttpService, AlertService, AuthService } from '../../../../../@core/services';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Observable } from 'rxjs';
import { MatAutocompleteTrigger } from '@angular/material/autocomplete';

const DocumentTemplateName :any= [
  {key: '111', value: 'child111report', desc: 'DHS_111_Client_Expenditure_Report', text: 'DHS 111 Client Expenditure Report' },
  {key: '113', value: 'child113report', desc: 'DHS_113_Provider_Payment_History_Summary_Report', text: 'DHS 113 Provider Payment History Summary Report' },
  {key: '114', value: 'child114report', desc: 'DHS_114_Provider_Payment_History_Detail_Report', text: 'DHS 114 Provider Payment History Detail Report' },
  {key: '115', value: 'child115report', desc: 'DHS_115_Provider_AR_History_Report', text: 'DHS 115 Provider AR History Report' },
];
@Component({
    selector: 'payment-history-report',
    templateUrl: './payment-history-report.component.html',
    styleUrls: ['./payment-history-report.component.scss'],
    standalone: false
})
export class PaymentHistoryReportComponent implements OnInit {
  documentTeplateKey: any;
  reportForm!: FormGroup;
  clientList$!: Observable<any>;
  clientList:any = [];
  providerList: any=[];
  selectedClientId: any=[];
  selectedproviderId: any;
  headerText: string='';
  isnorecord:boolean=false;
  @ViewChild('trigger') trigger!: MatAutocompleteTrigger;
  showBusy:boolean=false;
  moduleview: any=[];
  listclientpaymentsearchurl = 'tb_client_account/listClientPaymentSearch';
  
  constructor(private _commonService: CommonHttpService, private _alertService: AlertService,
    private formBuilder: FormBuilder, private _authService: AuthService) { }

  ngOnInit() {
    this.moduleview = this._authService.isModuleAccessable('finance', 'finance.finance.historypaymentreport');
    this.initReportForm();
  }

  initReportForm() {
    this.reportForm = this.formBuilder.group({
      date_sw: ['D'],
      date_from: [null],
      date_to: [null],
      clientid: [null],
      clientfirstname: null,
      clientlastname: null,
      paymenttype: [null],
      providerid: [null],
      client_filter: 'I',
      provider_filter: 'I',
      providername: null,
      taxid: null
    });
  }

  downloadReport(templatekey:any) {
    this.isDocumentGenerateBtnClicked = false;
    this.showBusy = false;
    this.documentTeplateKey = templatekey;
    this.reportForm.reset();
    this.reportForm.patchValue({
      date_sw: ['D'],
      client_filter: 'I',
      provider_filter: 'I'
    });
    this.headerText = DocumentTemplateName.find((data:any) => data.key === this.documentTeplateKey).text;
  }

  changePaymentDate() {
    this.reportForm?.get('date_to')?.reset();
  }

  clearForm() {
    this.reportForm.reset();
    this.reportForm.patchValue({
      date_sw: 'D',
      client_filter: 'I',
      provider_filter: 'I'
    });
    this.documentTeplateKey = null;
    this.selectedClientId = null;
    this.selectedproviderId = null;
  }

  loadClientList(index:any) {
    if (index === 1) {
      if (this.reportForm?.get('clientid')?.value && this.reportForm?.get('clientid')?.value.length > 3) {
        if (isNaN(this.reportForm?.get('clientid')?.value)) {
          this._alertService.error('Client ID search should not contain any string');
          return false;
        }
        this._commonService.getPagedArrayList({
          nolimit: true,
          where: { clientid: this.reportForm?.get('clientid')?.value },
          method: 'post'
        }, this.listclientpaymentsearchurl).subscribe((result) => {
          this.clientList = result.data;
        });
      }
    } else if (index === 2) {
      if (this.reportForm?.get('clientfirstname')?.value && this.reportForm?.get('clientfirstname')?.value.length > 3) {
        this._commonService.getPagedArrayList({
          nolimit: true,
          where: { v_firstname: this.reportForm?.get('clientfirstname')?.value },
          method: 'post'
        }, this.listclientpaymentsearchurl).subscribe((result) => {
          this.clientList = result.data;
        });
      }
    } else {
      if (this.reportForm?.get('clientlastname')?.value && this.reportForm?.get('clientlastname')?.value.length > 3) {
        this._commonService.getPagedArrayList({
          nolimit: true,
          where: { v_lastname: this.reportForm?.get('clientlastname')?.value },
          method: 'post'
        }, this.listclientpaymentsearchurl).subscribe((result) => {
          this.clientList = result.data;
        });
      }
    }
  }

  loadProviderList(index:any) {
    if (index === 1) {
      if (this.returnProvideridConditionFn()) {
        if (isNaN(this.reportForm?.get('providerid')?.value)) {
          this._alertService.error('Provier ID search should not contain any string');
          return false;
        }
        this.reusableGetproviderDetailsforReportFn({ providerid: this.reportForm?.get('providerid')?.value }, 'tb_provider/getproviderDetailsforReport');
      }
    } else if (index === 2) {
      if (this.returnProvidernameConditionFn()) {
        this.reusableGetproviderDetailsforReportFn({providername: this.reportForm?.get('providername')?.value}, 'tb_provider/getproviderDetailsforReport');
      }
    } else {
      if (this.returnTaxidConditionFn()) {
        if (isNaN(this.reportForm?.get('taxid')?.value)) {
          this._alertService.error('Tax ID search should not contain any string');
          return false;
        }
        this.reusableGetproviderDetailsforReportFn({taxid: this.reportForm?.get('taxid')?.value}, 'tb_provider/getproviderMaintainancesearch');
      }
    }
  }
  // Associated with loadProviderList function
  private returnTaxidConditionFn() {
    return this.reportForm?.get('taxid')?.value && this.reportForm?.get('taxid')?.value.length > 3 && this.reportForm?.get('taxid')?.value.trim() != '';
  }
  // Associated with loadProviderList function
  private returnProvidernameConditionFn() {
    return this.reportForm?.get('providername')?.value && this.reportForm?.get('providername')?.value.length > 3 && this.reportForm?.get('providername')?.value.trim() != '';
  }
  // Associated with loadProviderList function
  private reusableGetproviderDetailsforReportFn(whereCondition: any, routePath: any) {
    this._commonService.getPagedArrayList({
      nolimit: true,
      where: whereCondition,
      method: 'post'
    }, routePath).subscribe((res: any) => {
      if (res) {
        this.providerList = res;
      }
    });
  }
  // Associated with loadProviderList function
  private returnProvideridConditionFn() {
    return this.reportForm?.get('providerid')?.value && this.reportForm?.get('providerid')?.value.length > 3 && this.reportForm?.get('providerid')?.value.trim() != '';
  }

  changeFilter() {
    this.clientList = [];
    this.providerList = [];
    this.reportForm.patchValue({
      clientid: null,
      clientfirstname: null,
      clientlastname: null,
      providerid: null,
      providername: null,
      taxid: null
    });
  }

isDocumentGenerateBtnClicked = false;
  documentGenerate(Reportform:any, type:any) {
    this.isDocumentGenerateBtnClicked = true;
    if (!(this.reportForm?.get('date_from')?.value  && this.reportForm?.get('date_to')?.value)) {
      return false
    }
    if (this.documentTeplateKey === '111' && !this.selectedClientId) {
      this._alertService.warn('Please select Client!');
      return false;
    }
    if (this.documentTeplateKey !== '111' && !this.selectedproviderId) {
      this._alertService.warn('Please select Provider!');
      return false;
    }
    const modal = {
      count: -1,
      limit: null,
      page: 1,
      where: {
        documenttemplatekey: [DocumentTemplateName.find((data:any) => data.key === this.documentTeplateKey).value],
        date_sw: this.documentTeplateKey === '115' ? null : 'D',
        date_from: Reportform.date_from,
        date_to: Reportform.date_to,
        format: type,
        clientid: this.selectedClientId,
        providerid: this.selectedproviderId
      },
      method: 'post'
    };
    this.isnorecord = false;
    this.showBusy = true;
    this._commonService.create(modal, 'evaluationdocument/generateintakedocument').subscribe((result:any) => {
      if (this.generateintakedocumentResultCondFn(result)) {
        this.showBusy = false;
        this._alertService.warn('No records found');
        this.isnorecord = true;
      }
    });
    setTimeout(() => {
      if (!this.isnorecord) {
        this._commonService.download('evaluationdocument/generateintakedocument', modal)
        .subscribe(res => {
          this.showBusy = false;
          const blob = new Blob([new Uint8Array(res)]);
          const link = document.createElement('a');
          link.href = window.URL.createObjectURL(blob);
          this.checkPdfOrExcelFn(type, link);
          document.body.appendChild(link);
          link.click();
          document.body.removeChild(link);
          this.clearForm();
          (<any>$('#downloadReport')).modal('hide');
        });
      }
    }, 5000);
  }

  private checkPdfOrExcelFn(type: any, link: HTMLAnchorElement) {
    if (type === 'pdf') {
      link.download = `${DocumentTemplateName.find((data:any) => data.key === this.documentTeplateKey).desc}.pdf`;
    } else if (type === 'excel') {
      link.download = `${DocumentTemplateName.find((data:any) => data.key === this.documentTeplateKey).desc}.xlsx`;
    }
  }

  private generateintakedocumentResultCondFn(result: any) {
    return result && result.data && result.data.length > 0 && result.data[0].is_norecord;
  }

  onselected() {
    $('#downloadReport .modal-body').css('min-height', '240px');
  }

  changeClient(clientId:any) {
    this.selectedClientId = clientId;
    this.clientList = [];
  }

  changeProvider(providerId:any) {
    this.selectedproviderId = providerId;
    this.providerList = [];
  }

openThatPanel() {
  setTimeout((_:any) => this.trigger.openPanel());
}

}
