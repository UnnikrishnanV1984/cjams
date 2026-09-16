
import {map} from 'rxjs/operators';
import { Component, OnInit, AfterContentInit } from '@angular/core';
import { FinanceUrlConfig } from '../../../../finance.url.config';
import { CommonHttpService, DataStoreService, AlertService } from '../../../../../../@core/services';
import { PaginationRequest, PaginationInfo, DropdownModel } from '../../../../../../@core/entities/common.entities';
import { ActivatedRoute, Router } from '@angular/router';
import { ClientPayment } from '../../../../finance.constants';
import { ColumnSortedEvent } from '../../../../../../shared/modules/sortable-table/sort.service';
import { Observable } from 'rxjs';
import moment from 'moment';

@Component({
    selector: 'client-payment-details',
    templateUrl: './client-payment-details.component.html',
    styleUrls: ['./client-payment-details.component.scss'],
    standalone: false
})
export class ClientPaymentDetailsComponent implements OnInit, AfterContentInit {
  paymentHistoryResult:any[] = [];
  _providerService: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  pageInfo: PaginationInfo = new PaginationInfo();
  totalcount: any;
  paymentDetailView:boolean=false;
  paymentDetail: any[]=[];
  paymentDetailList: any[]=[];
  clientData: any;
  caseWorker: any;
  client_id: any;
  payment_id: any;
  totalRecords: any;
  paymentTypeList: any[]=[];
  paymenttype:any;
  paymentInterface: any[]=[];
  paymentId: any;
  paymentinterfaceStatuses: any=[];
  payment: any;
  checkPaymentStatus: any;
  statuscheck: any;
  notes: any;
  oldnotes: any;
  checkStatus$!: Observable<DropdownModel[]>;
  paymentdaterangefrom: any;
  paymentdaterangeto: any;
  date_sw: any;
  date_from: any;
  date_to: any;
  selectedClient: any;
  oldcheckPaymentStatus: any;
  //ssn masking
  showSsnMask = true;
  paymentdetailseditpopupid = '#payment-details-edit';
  showHistoryDetail: number | null = null;
  
  constructor(
    private _route: ActivatedRoute,
    private _router: Router,
    private _commonService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _alertService: AlertService
  ) { }

  ngOnInit() {
    this.clientData = this._dataStoreService.getCurrentStore();
    if (this.clientData && this.clientData.SelectedClientSource) {
      this.selectedClient = this.clientData.SelectedClientSource;
    }
    this.paginationInfo.sortColumn = 'paymentDate';
    this.paginationInfo.sortBy = 'desc';
    this.populatePaymentType();
    this.date_sw = 'D';
    const searchParams = this._dataStoreService.getData(ClientPayment.ClientPaymentSearchParams);
    if (searchParams) {
      this.paymentdaterangefrom = searchParams.daterangefrom;
      this.paymentdaterangeto = searchParams.daterangeto;
      if (this.paymentdaterangefrom) {
        this.date_sw = 'D';
      }
      this.date_from = this.paymentdaterangefrom ? new Date(this.paymentdaterangefrom) : null;
      this.date_to = this.paymentdaterangeto ? new Date(this.paymentdaterangeto) : null;
    }
  }

  ngAfterContentInit() {
    if (this.clientData && this.clientData.SelectedClientSource) {
        this.client_id = this.clientData.SelectedClientSource.client_id;
      this.paymentHistory(null);
      this._dataStoreService.setData(ClientPayment.SelectedClientSource, null);
    }
  }

  populatePaymentType(){
    this.paymentTypeList = [];
    this._commonService.getArrayList(new PaginationRequest({
        where: {
          'picklist_type_id': '2'
        },
        nolimit: true,
        method: 'get'
      }), FinanceUrlConfig.EndPoint.childAccounts.pickListUrl).subscribe((result) => {
        return result.filter((res) => {
          this.paymentTypeList.push(res);
        });
    });
  }


  populatePaymentTypeforDisbursement(){
    this._commonService.getArrayList(new PaginationRequest({
        where: {
          'picklist_type_id': '10044'
        },
        nolimit: true,
        method: 'get'
      }), FinanceUrlConfig.EndPoint.childAccounts.pickListUrl).subscribe((result) => {
        return result.filter((res) => {
          if (res.picklist_value_cd === '4' || res.picklist_value_cd === '5989') {
           // return res;
        } else {
          this.paymentTypeList.push(res);
        }
    });
    });
  }
  paymentHistory(paymenttype:any) {
   this.paymenttype = paymenttype;
   const searchParams = this._dataStoreService.getData(ClientPayment.ClientPaymentSearchParams);
     this._commonService.getPagedArrayList(
      new PaginationRequest({
      where: {
        client_id: this.client_id,
        sortcolumn: this.paginationInfo.sortColumn,
        sortorder: this.paginationInfo.sortBy,
        paymenttype: paymenttype,
        daterangefrom : searchParams.daterangefrom ? moment(searchParams.daterangefrom).format('YYYY-MM-DD') : null,
        daterangeto :  searchParams.daterangeto ? moment(searchParams.daterangeto).format('YYYY-MM-DD') : null
      },
      method: 'get',
      limit: 10,
      page: this.paginationInfo.pageNumber
    }), 'tb_receivable_detail/getpaymenthistorybyclientid?filter'
    ).subscribe((result: any) => {
      if (result && result.data) {
        this.paymentHistoryResult = result.data;
        if(result.data && result.data[0] && result.data[0].caseworker && result.data[0].caseworker[0]){
            this.caseWorker = result.data[0].caseworker[0];
        }

        this.totalcount = (this.paymentHistoryResult && this.paymentHistoryResult.length > 0) ? this.paymentHistoryResult[0].totalcount : 0;
      }
    });
  }

  pageChanged(page:any) {
    this.paginationInfo.pageNumber = page;
    this.paymentHistory(this.paymenttype);
  }

  viewPayment(mode:any, payment:any, id:any, index:any) {
    if (mode === 'add') {
      this.pageInfo.pageNumber = 1;
    }
    (<any>$('.collapse.in')).collapse('hide'); // NOSONAR
    (<any>$('#' + id)).collapse('toggle'); // // NOSONAR
    (<any>$('.client-details-view tr')).removeClass('selected-bg'); // NOSONAR
    (<any>$(`#client-details-view-${index}`)).addClass('selected-bg'); // NOSONAR
    this.paymentDetailHistory(payment.payment_id);
  }

  paymentDetailHistory(payment_id:any) {
    this.payment_id = payment_id;
     this._commonService.getPagedArrayList(
      new PaginationRequest({
      where: {
        paymentid: payment_id,
        clientid: this.client_id,
        sortorder: 'asc',
        sortcolumn: 'detailedId'
      },
      method: 'get',
      limit: 10,
      page: this.pageInfo.pageNumber
    }), 'tb_receivable_detail/getpaymentdetails?filter'
    ).subscribe((result: any) => {
      if (result && result.data && result.data[0]['getpaymentdetails'].length) {
        this.paymentDetail = result.data[0]['getpaymentdetails'];
        this.totalRecords = (this.paymentDetail && this.paymentDetail.length > 0) ? this.paymentDetail[0].totalcount : 0;
      } else {
        this.paymentDetail = [];
      }
    });
  }

  pageNumberChanged(page:any) {
    this.paymentDetailHistory(this.payment_id);
    this.pageInfo.pageNumber = page;
  }

  backToSearch() {
    this._router.navigate(['../client-payment-result'], { relativeTo: this._route });
  }

  onHistorySorted($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.paymentHistory(this.paymenttype);
}

paymentInterfaceStatus(paymentID:any, paymentinterfaceStatus:any, index: any) {
  this._commonService.getArrayList({
      where: {
          payment_id: paymentID
      },
      method: 'get',
      limit: 10,
      page: 1,
      fmslimit: 10,
      fmspage: 1
  }, 'tb_payment_status/paymentafsfmis?filter'
  ).subscribe(response => {
      this.paymentInterface = response;
  });
  this.paymentId = paymentID;
  this.paymentinterfaceStatuses = paymentinterfaceStatus;
  this.loadcheckStatus();
  if (this.showHistoryDetail === index) {
    this.showHistoryDetail = null;
  } else {
    this.showHistoryDetail = index;
  }
}

editPayment(paymentDetails:any) {
  this.payment = paymentDetails;
  this.checkPaymentStatus = paymentDetails.check_status_cd ? paymentDetails.check_status_cd : null;
  this.statuscheck = paymentDetails.check_status_cd ? paymentDetails.check_status_cd : null;
  this.notes = paymentDetails.notes_tx ? paymentDetails.notes_tx : '';
  this.oldcheckPaymentStatus = this.checkPaymentStatus;
  this.oldnotes = this.notes;
  (<any>$('#payment-interface')).modal('hide'); // NOSONAR
  (<any>$(this.paymentdetailseditpopupid)).modal('show'); // NOSONAR
}

updateCheckStatus() {
  if (this.notes && this.checkPaymentStatus) {
    if (this.checkPaymentStatus === this.statuscheck && this.notes === this.oldnotes) {
      this._alertService.warn('Check Status is already updated, Please update new one');
      return false;
    } else {
        this._commonService.endpointUrl = 'tb_payment_header/updatePaymentCheckStatus/' + this.paymentId;
        const model = {
          notes: this.notes,
          check_status: this.checkPaymentStatus
        };
        this._commonService.create(model).subscribe(res => {
          if (res) {
            this._alertService.success('Check Status updated Successfully');
            (<any>$(this.paymentdetailseditpopupid)).modal('hide'); // NOSONAR
            this.paymentInterfaceStatus(this.payment.payment_id, this.paymentinterfaceStatuses, null);
            (<any>$('#payment-interface')).modal('show'); // NOSONAR
          }
        });
      }
  } else {
    this._alertService.error('Please fill the mandatory fields');
  }
}

loadcheckStatus() {
  this.checkStatus$ = this._commonService.getArrayList({
    where: {picklist_type_id : '37'},
    nolimit: true,
    method: 'get'
  }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
  ).pipe( map((result) => {
    return result.map(
        (res) =>
            new DropdownModel({
                text: res.value_tx,
                value: res.picklist_value_cd
            })
    );
  }));
}


documentGenerate(type:any) {
  this.changeDate();
  if(!(this?.date_from) || !(this?.date_to)){
    return;
  }
  const modal = {
    count: -1,
    limit: null,
    page: 1,
    where: {
      documenttemplatekey: ['child111report'],
      clientid: this.client_id,
      date_sw: this.date_sw,
      date_from: this.date_from,
      date_to: this.date_to,
      paymenttype: this.paymenttype,
      format: type
    },
    method: 'post'
  };
    this._commonService.download('evaluationdocument/generateintakedocument', modal)
      .subscribe(res => {
        const blob = new Blob([new Uint8Array(res)]);
        const link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        if (type === 'pdf') {
          link.download = 'DHS_111_Client_Expenditure_Report.pdf';
        } else if (type === 'excel') {
          link.download = 'DHS_111_Client_Expenditure_Report.xlsx';
        }

        document.body.appendChild(link);

        link.click();

        document.body.removeChild(link);
        (<any>$('#downloadReport')).modal('hide'); // NOSONAR
        this.resetDownload();
        this.date_sw = 'D';
        this.date_from = null;
        this.date_to = null;
      });
}

resetDownload() {
  this.date_sw = 'D';
  this.date_from = this.paymentdaterangefrom ? new Date(this.paymentdaterangefrom) : null;
  this.date_to = this.paymentdaterangeto ? new Date(this.paymentdaterangeto) : null;
}
checkStatusChange(value:any) {
  if (value == '4849') {
    (<any>$(this.paymentdetailseditpopupid)).modal('hide'); // NOSONAR
    (<any>$('#confirm-checkstatus')).modal('show'); // NOSONAR
  } else {
    this.oldcheckPaymentStatus = this.checkPaymentStatus;
  }
}
ConfirmPopup(index:any) {
  (<any>$('#confirm-checkstatus')).modal('hide'); // NOSONAR
  (<any>$(this.paymentdetailseditpopupid)).modal('show'); // NOSONAR
  if (index === 1) {
    this.checkPaymentStatus = this.oldcheckPaymentStatus;
  }
}

printProvider() {
  window.print();
}

changeDate() {
  (document as any).getElementById('msg_date_from').innerHTML = (this?.date_from) ? '' : 'Please select From Date';
  (document as any).getElementById('msg_date_to').innerHTML = (this?.date_to) ? '' : 'Please select To Date';
}

  checkAccordionRow(id: string, value: any): boolean {
    return id.includes(value);
  }
}
