import { Component, OnInit } from '@angular/core';
import { PaginationRequest, PaginationInfo } from '../../../../@core/entities/common.entities';
import { FinanceUrlConfig } from '../../finance.url.config';
import { CommonHttpService, AlertService, DataStoreService, AuthService, SessionStorageService } from '../../../../@core/services';
import { Router } from '@angular/router';
import { PurchaseAuthorizationParams } from '../../finance.constants';
import { AppUser } from '../../../../@core/entities/authDataModel';

@Component({
    selector: 'purchase-authorization',
    templateUrl: './purchase-authorization.component.html',
    styleUrls: ['./purchase-authorization.component.scss'],
    standalone: false
})
export class PurchaseAuthorizationComponent implements OnInit {

  totalcount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  paymentData: any[] = [];
  payableApproval: any;
  fundingData: any[] = [];
  statusDropDownList = [
    {
      'text': 'All',
      'value': 'All'
    },
    {
      'text': 'Funding Approved',
      'value': 'A'
    },
    {
    'text': 'Pending Approval',
    'value': 'P'
    },
    {
      'text': 'Denied',
      'value': 'R'
    },
  ];
  paymentStatusDropDownList = [
    {
      'text': 'All',
      'value': 'All'
    },
    {
      'text': 'Payment Approved',
      'value': 'A'
    },
    {
    'text': 'Pending Approval',
    'value': 'P'
    },
    {
      'text': 'Denied',
      'value': 'R'
    },
  ];
  fundingStatus: any;
  paymentStatus: any;
  pageInfo: PaginationInfo = new PaginationInfo;
  totalpagecount!: number;
  user!: AppUser;
  financeSupervisor!: boolean;
  paymentPayee: any;
  fundingPayee: any;
  paymentPayeeName: any;
  fundingPayeeName: any;
  activeModule!: string;
  roletype!: string;
  columns = [
    'Authorization ID',
    'Service Request ID',
    'Category Code',
    'Request Date',
    'Payee Name',
    'Cost Not To Exceed',
    'Status',
    'Funding Approved Date',
    'Action',
  ]
  keys = [
    'authorization_id',
    'service_log_id',
    'fiscal_category_code',
    'request_date',
    'payee',
    'cost_no',
    'remarks',
    'funding_approval_dt',
    'action'
  ]
 pamentAprrovalColumns = [
    'Authorization ID',
    'Service Request ID',
    'Category Code',
    'Request Date',
    'Payee Name',
    'Cost Not To Exceed',
    'Status',
    'Payment Approved Date',
    'Action',
  ]
  pamentAprrovalKeys = [
    'authorization_id',
    'service_log_id',
    'fiscal_category_code',
    'request_date',
    'payee',
    'cost_no',
    'remarks',
    'payment_approval_dt',
    'action'
  ]

  styles: any = {
    "Authorization ID": {'thStyleClassName': 'width-150','tdStyleClassName':'','filterIconClassName':''},
     "Service Request ID":{'thStyleClassName': 'inherit','tdStyleClassName':'','filterIconClassName':''},
     "Category Code":{'thStyleClassName': 'inherit','tdStyleClassName':'','filterIconClassName':''},
     "Request Date":{'thStyleClassName': 'inherit','tdStyleClassName':'','filterIconClassName':''},
     "Payee Name":{'thStyleClassName': 'inherit','tdStyleClassName':'','filterIconClassName':''},
     "Cost Not To Exceed":{'thStyleClassName': 'inherit','tdStyleClassName':'','filterIconClassName':''},
     "Status":{'thStyleClassName': 'inherit','tdStyleClassName':'','filterIconClassName':''},
     "Payment Approved Date":{'thStyleClassName': 'inherit','tdStyleClassName':'','filterIconClassName':''},
     "Funding Approved Date":{'thStyleClassName': 'inherit','tdStyleClassName':'','filterIconClassName':''},
     "Action":{'thStyleClassName': 'max-width-80','tdStyleClassName':'','filterIconClassName':''},
  }

  tableData: any[] = [];
  pamentAprrovalTableData: any[] = [];
  isValue: any = 1;

  constructor(
    private _commonService: CommonHttpService,
    private _alertService: AlertService,
    private _router: Router,
    private _dataStoreService: DataStoreService,
    private _authService: AuthService,
    private _sessionStorage: SessionStorageService
  ) { }

  ngOnInit() {
    this.user = this._authService.getCurrentUser();
    this.pageInfo.sortBy = null;
    this.pageInfo.sortColumn = null;
    this.paginationInfo.sortBy = null;
    this.paginationInfo.sortColumn = null;
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.loadInfo();
    this._authService.dashboardConfig$.subscribe(_ => {
      this.loadInfo();
    });
  }
  loadInfo() {
    this.user = this._authService.getCurrentUser();
    this.pageInfo.sortBy = null;
    this.pageInfo.sortColumn = null;
    this.paginationInfo.sortBy = null;
    this.paginationInfo.sortColumn = null;
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Finance Approval') {
      this.roletype = 'FNSFS';
      this.financeSupervisor = true;
    } else if (this.activeModule === 'Finance') {
      this.roletype = 'FNSFW';
      this.financeSupervisor = false;
    } else {
      this.roletype = 'FNSDF';
      this.financeSupervisor = false;
    }
    this.fundingStatus = 'P';
    this.paymentStatus = 'P';
    if (this.financeSupervisor) {
      this.getPaymentApprove();
    }
    this.getFundingApprove();
  }
  statusFundingDropDown(status: any) {
    this.pageInfo.pageNumber = 1;
    this.fundingStatus = status;
    this.pageInfo.sortBy = null;
    this.pageInfo.sortColumn = null;
    this.getFundingApprove();
  }
  statusPaymentDropDown(status: any) {
    this.paginationInfo.pageNumber = 1;
    this.paymentStatus = status;
    this.paginationInfo.sortBy = null;
    this.paginationInfo.sortColumn = null;
    this.getPaymentApprove();
  }
  getFundingApprove(query:any = {}) {
    this.paymentPayee = null;
    this.paymentPayeeName = null;
    this._commonService.getPagedArrayList(
      new PaginationRequest({
      limit: this.pageInfo.pageSize,
      page: this.pageInfo.pageNumber,
      where: {approveltype: 'funding', status: this.fundingStatus,
      sortcolumn: this.pageInfo.sortColumn,
      sortorder: this.pageInfo.sortBy,
      payee_nm: query.payee ? query.payee : null,    //this.fundingPayeeName ? this.fundingPayeeName : null,
      roletypekey: this.roletype,
      assigned_pa: true,
      user_id: this.user.user.userprofile.securityusersid,
      ...query
     },
      method: 'get'
    }), FinanceUrlConfig.EndPoint.accountsPayable.listPayableApproval + '?filter')
      .subscribe((res: any) => {
        this.tableData = [];
        if (res) {
          this.fundingData = res;
          this.fundingData.forEach((data: any)=> { 
            this.tableData.push({
              authorization_id:data.authorization_id,
              service_log_id:data.service_log_id,
              fiscal_category_code:data.fiscal_category_desc + "" + data.fiscal_category_cd,
              request_date:data.request_date,
              payee:data.payee,
              cost_no:data.cost_no,
              remarks:data.remarks,
              funding_approval_dt:data.funding_approval_dt,
              action:'action',
              ...data
            })
          }) 

         
          this.totalpagecount = (this.fundingData && this.fundingData.length > 0) ? this.fundingData[0].totalcount : 0;
          this.pageInfo.sortBy = null;
          this.pageInfo.sortColumn = null;
        }
      });
  }
  getPaymentApprove(query: any = {}) {
    this.fundingPayee = null;
    this.fundingPayeeName = null;
      this.payableApproval = [];
      this._commonService.getPagedArrayList(
        new PaginationRequest({
          where: {
          approveltype: 'payment',
          status: this.paymentStatus,
          sortcolumn: this.paginationInfo.sortColumn,
          sortorder: this.paginationInfo.sortBy,
          payee_nm:  query.payee ? query.payee : null, 
          roletypekey: this.roletype,
          assigned_pa: true,
          user_id: this.user.user.userprofile.securityusersid,
          ...query
          },
          limit : this.paginationInfo.pageSize,
          page: this.paginationInfo.pageNumber,
          method: 'get'
        }), FinanceUrlConfig.EndPoint.accountsPayable.listPayableApproval + '?filter'
      ).subscribe((result: any) => {
        this.pamentAprrovalTableData = [];
        this.payableApproval = result;
        this.payableApproval.forEach((data: any)=> { 
          this.pamentAprrovalTableData.push({
            authorization_id:data.authorization_id,
            service_log_id:data.service_log_id,
            fiscal_category_code:data.fiscal_category_desc + "" + data.fiscal_category_cd,
            request_date:data.request_date,
            payee:data.payee,
            cost_no:data.cost_no,
            remarks:data.remarks,
            payment_approval_dt:data.payment_approval_dt,
            action:'action',
            ...data
          })
        }) 
        this.totalcount = (this.payableApproval && this.payableApproval.length > 0) ? this.payableApproval[0].totalcount : 0;
        this.paginationInfo.sortBy = null;
        this.paginationInfo.sortColumn = null;
      });
  }
  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.sortColumn =  pageInfo.query.sortColumn;
    this.paginationInfo.sortBy  =  pageInfo.query.sortDirection;
    this.getPaymentApprove(pageInfo.query);
  }

  onSearchPayee(mode: string) {
    if (mode === 'funding') {
      if (this.fundingPayee) {
        this.fundingPayeeName = this.fundingPayee.replace(/'/g, `''`);
      } else {
        this.fundingPayeeName = null;
      }
      this.getFundingApprove();
    } else {
      if (this.paymentPayee) {
        this.paymentPayeeName = this.paymentPayee.replace(/'/g, `''`);
      } else {
        this.paymentPayeeName = null;
      }
      this.getPaymentApprove();
    }
  }

  pageNumberChanged(pageInfo: any) {
    this.pageInfo.pageNumber = pageInfo.page;
    this.pageInfo.sortColumn =  pageInfo.query.sortColumn;
    this.pageInfo.sortBy  =  pageInfo.query.sortDirection;
    this.getFundingApprove(pageInfo.query);
  }

  reDirectToPayment(paymentData: any) {
    this._router.navigate(['/pages/finance/finance-accountsPayable/approval/payment']);
    this._dataStoreService.setData(PurchaseAuthorizationParams.PaymentParms, paymentData);
  }

  reDirectToFunding(fundingData: any) {
    this._router.navigate(['/pages/finance/finance-accountsPayable/approval/financial']);
    this._dataStoreService.setData(PurchaseAuthorizationParams.FundingParms, fundingData);
  }

  onSortedFunding(event: any) {
    event = JSON.parse(event);
    this.pageInfo.sortBy = event.sortDirection;
    this.pageInfo.sortColumn = event.sortColumn;
    this.getFundingApprove(event);
  }

  onSortedPayment(event:any) {
    event = JSON.parse(event);
    this.paginationInfo.sortBy = event.sortDirection;
    this.paginationInfo.sortColumn = event.sortColumn;
    this.getPaymentApprove(event);
  }

  callApi(query: any) {
    query = JSON.parse(query);
    this.getFundingApprove(query)
  }

  callReDirectToFundingMethod(event: any) {
    const data  = JSON.parse(event);
    this.reDirectToFunding(data)
  }

  callPaymentApi(query: any) {
    query = JSON.parse(query);
    this.getPaymentApprove(query)
  }

  callReDirectToPaymentMethod(event: any) {
    const data  = JSON.parse(event);
    this.reDirectToPayment(data)
  }


}