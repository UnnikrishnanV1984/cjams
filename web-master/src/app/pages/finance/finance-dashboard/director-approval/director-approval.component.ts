import { Component, Injector, OnInit } from '@angular/core';
import { CommonHttpService, CommonDropdownsService, AlertService, AuthService, DataStoreService, SessionStorageService } from '../../../../@core/services';
import { PaginationRequest, PaginationInfo, DropdownModel } from '../../../../@core/entities/common.entities';
import { FinanceUrlConfig } from '../../finance.url.config';
import { ActivatedRoute, Router } from '@angular/router';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { PurchaseAuthorization } from '../../_entities/finance-entity.module';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Observable } from 'rxjs';
import { PurchaseAuthorizationParams } from '../../finance.constants';
import { AppUser } from '../../../../@core/entities/authDataModel';

@Component({
    selector: 'director-approval',
    templateUrl: './director-approval.component.html',
    styleUrls: ['./director-approval.component.scss'],
    standalone: false
})
export class DirectorApprovalComponent implements OnInit {
  payableApproval!: any[];
  authorization_id: any;
  fiscal_category_cd: any;
  cost_no: any;
  provider_id: any;
  intakeserviceid: any;
  startDate: any;
  endDate: any;
  payment_method_cd: any;
  payableApprovalHistory!: any[];
  assignedTo: any;
  selectedPerson: any;
  getUsersList!: any[];
  originalUserList!: any[];
  isapproved: any;
  child_account_no: any;
  client_id: any;
  dob!: number;
  gender!: string;
  justification_tx!: string;
  service_log_id!: number;
  service_start_dt!: number;
  provider_nm!: string;
  service_nm!: number;
  service_end_dt!: number;
  adr_street_nm!: string;
  adr_city_nm!: string;
  adr_state_cd!: string;
  adr_zip5_no!: string;
  client_name!: string;
  client_account_id!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalcount!: number;
  totalPage!: number;
  pageInfo: PaginationInfo = new PaginationInfo();
  approval: any;
  purchaseAuthData!: PurchaseAuthorization;
  purchaseServiceForm!: FormGroup;
  remarks: any;
  fiscalCode$!: Observable<DropdownModel[]>;
  reason_tx: any;
  childAccountReject = true;
  purchaseRequestForm!: FormGroup;
  statusDropDownList = [
    {
      'text': 'All',
      'value': 'All'
    },
    {
      'text': 'Approved',
      'value': 'A'
    },
    {
    'text': 'Pending',
    'value': 'P'
    },
    {
      'text': 'Denied',
      'value': 'R'
    },
  ];
  directorStatus: any;
  status: any;
  fiscalCodes!: any[];
  activeModule: any;
  user!: AppUser;
  isFiscalCategory4181: boolean = false;
  cfeDurationList!: any[];

  columns = [
    'Authorization ID',
    'Service Request ID',
    'Category Code',
    'Request Date',
    'Payee Name',
    'Cost Not To Exceed',
    'Status',
    'Action'
  ]
  keys = [
    'authorization_id',
    'service_log_id',
    'fiscal_category_code',
    'request_date',
    'payee',
    'cost_no',
    'remarks',
    'action'
  ]
  minwidthstyle = 'min-width-175';
  rejectapprovalpopupid = '#reject-approval';
  styles: any = {
    "Authorization ID": {'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'},
     "Service Request ID":{'thStyleClassName': 'min-width-170','tdStyleClassName':'min-width-170','filterIconClassName':'top-10'},
     "Category Code":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'},
     "Request Date":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'},
     "Payee Name":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'},
     "Cost Not To Exceed":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'},
     "Status":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'},
     "Action":{'thStyleClassName': '','tdStyleClassName':'','filterIconClassName':''},
  }

  tableData: any[] = [];
  isSupervisor:boolean=false;

  private _commonService: CommonHttpService;
  private _alertService: AlertService;
  private _commonDropdownService: CommonDropdownsService;
  private _route: ActivatedRoute;
  private _authService: AuthService;
  private _router: Router;
  private _formBuilder: FormBuilder;
  private _dataStoreService: DataStoreService;

  constructor(private readonly injector : Injector, private _sessionStorage: SessionStorageService) {
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._router = this.injector.get<Router>(Router);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
  }

  ngOnInit() {
    this.paginationInfo.sortBy = null;
    this.paginationInfo.sortColumn = null;
    this.loadInfo();
    this._authService.dashboardConfig$.subscribe(_ => {
      this.loadInfo();
    });
    this.user = this._authService.getCurrentUser();

  }

  loadInfo() {
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.directorStatus = 'P';
    this.getPayableApproval();
    this.buildForm();
  }

  buildForm() {
    this.purchaseRequestForm = this._formBuilder.group({
      payment_start_dt: [null],
      payment_end_dt: [null],
      payment_method_cd: [null, Validators.required],
      type_1099_cd: [null, Validators.required],
      amount_no: [null],
      store_receipt_id: [null],
      actualAmount: [null],
      payment_id: [null]
    });
    this.purchaseServiceForm = this._formBuilder.group(
      {
          fiscalCode: ['', Validators.required],
          voucherRequested: ['', Validators.required],
          costnottoexceed: '',
          cfeCareDuration: '',
          justificationCode: '',
          startDt: [null, Validators.required],
          endDt: [null, Validators.required],
          fundingstatus: '',
          authorization_id: '',
          paymentstatus: '',
          final_amount_no: '',
          actualAmount: '',
          client_account_no: ''
      });

  }

  statusDirectorDropDown(status: any) {
    this.directorStatus = status;
    this.getPayableApproval();
  }

  getPayableApproval(query: any = {}) {
    this.payableApproval = [];
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        where: {approveltype: 'direcort', 
        status: this.directorStatus,
        roletypekey: 'FNSDF', 
        assigned_pa: true,
        sortcolumn: this.paginationInfo.sortColumn,
        sortorder: this.paginationInfo.sortBy,
        payee_nm:  query.payee ? query.payee : null,
        ...query
        },
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        method: 'get',

      }), FinanceUrlConfig.EndPoint.accountsPayable.listPayableApproval + '?filter'
    ).subscribe((result: any) => {
      this.tableData = [];
      this.payableApproval = result;
      this.payableApproval.forEach((data)=> { 
        this.tableData.push({
          authorization_id:data.authorization_id,
          service_log_id:data.service_log_id,
          fiscal_category_code:data.fiscal_category_desc + "" + data.fiscal_category_cd,
          request_date:data.request_date,
          payee:data.payee,
          cost_no:data.cost_no,
          remarks:data.remarks,
          action:'action',
          ...data
        })
      }) 


      this.totalcount = (this.payableApproval && this.payableApproval.length > 0) ? this.payableApproval[0].totalcount : 0;
    });

  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.pageInfo.sortColumn =  pageInfo.query.sortColumn;
    this.pageInfo.sortBy  =  pageInfo.query.sortDirection;
    this.getPayableApproval(pageInfo.query);
  }
  onAuthID(authid: any) {
    this.getFiscalCategoryCode(authid.programkey);
    if (authid && (authid.fiscal_category_cd === '7502' ||
    authid.fiscal_category_cd === '7503')) {
      this.childAccountReject = true;
    } else {
      this.childAccountReject = false;
    }
    this.purchaseRequestForm.patchValue(authid);
    this.authorization_id = authid.authorization_id;
    this.fiscal_category_cd = authid.fiscal_category_cd;
    this.cost_no = authid.cost_no ? authid.cost_no : '0.00';
    this.provider_id = authid.provider_id;
    this.intakeserviceid = authid.intakeserviceid;
    this.startDate = authid.payment_start_dt;
    this.endDate = authid.payment_end_dt;
    this.payment_method_cd = authid.payment_method_cd;
    this.isapproved = authid.isapproved;
    this.client_account_id = authid.client_account_id;
    this.client_id = authid.client_id;
    this.client_name = authid.client_name;
    this.dob = authid.dob;
    this.gender = authid.gender;
    this.service_nm = authid.service_nm;
    this.justification_tx = authid.justification_tx;
    this.service_log_id = authid.service_log_id;
    this.service_start_dt = authid.service_start_dt;
    this.provider_nm = authid.provider_nm;
    this.service_end_dt = authid.service_end_dt;
    this.adr_street_nm = authid.adr_street_nm;
    this.adr_city_nm = authid.adr_city_nm;
    this.adr_state_cd = authid.adr_state_cd;
    this.adr_zip5_no = authid.adr_zip5_no;
    this.remarks = authid.remarks;
    this.getApproveHistory(authid.authorization_id);
    this.viewPurchaseAuthorization(authid);
  }

  getApproveHistory(authid: any) {
    this.payableApprovalHistory = [];
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        where: {authorization_id: authid},
        limit : this.pageInfo.pageSize,
        page: this.pageInfo.pageNumber,
        method: 'get'
      }), FinanceUrlConfig.EndPoint.accountsPayable.listPayableApprovalHistory + '?filter'
    ).subscribe((result: any) => {
      this.payableApprovalHistory = result;
      this.totalPage = (this.payableApprovalHistory && this.payableApprovalHistory.length > 0) ? this.payableApprovalHistory[0].totalPage : 0;
    });
  }

  viewPurchaseAuthorization(purchaseDetail: any) {
    this._commonService.getArrayList(
      new PaginationRequest({
          page: 1,
          limit: 20,
          where: { service_log_id: purchaseDetail.service_log_id },
          method: 'get'
      }),
      FinanceUrlConfig.EndPoint.accountsPayable.approval.purchaseAuthorizationGet + '?filter'
      ).subscribe((result: any) => {
        if (result['data'] && result['data'].length > 0) {
            const paDetails = result['data'];
            this.purchaseAuthData = this.returnPurchaseAuthDataFn(paDetails);
            if (this.purchaseAuthData.fiscal_category_cd == '4181') {
              this._commonDropdownService.getPickList(11001).subscribe(resp => {
              this.cfeDurationList = resp;
             });
             this.purchaseServiceForm.patchValue({
                  cfeCareDuration: this.purchaseAuthData.cfecareduration
             });
              this.isFiscalCategory4181 = true;
          }
            const model = this.returnViewPurchaseAuthorizationModelDataFn();
          this.purchaseServiceForm.setValue(model, { emitEvent: true, onlySelf: false });
          this.purchaseServiceForm.disable();
          if (this.remarks === 'Pending') {
            this.purchaseServiceForm.get('justificationCode')?.enable();
            this.purchaseServiceForm.get('fiscalCode')?.enable();
          }
      }
      });
    }

  private returnPurchaseAuthDataFn(paDetails: any) {
    return paDetails.length > 0 ? paDetails[0] : {};
  }

  private returnViewPurchaseAuthorizationModelDataFn() {
    return {
      fiscalCode: this.purchaseAuthData.fiscal_category_cd,
      voucherRequested: this.purchaseAuthData.voucher_requested,
      cfeCareDuration: this.purchaseAuthData.cfecareduration,
      costnottoexceed: this.purchaseAuthData.cost_no ? this.purchaseAuthData.cost_no : '0.00',
      justificationCode: this.purchaseAuthData.justification_text,
      fundingstatus: this.purchaseAuthData.fundingstatus,
      authorization_id: this.purchaseAuthData.authorization_id ? this.purchaseAuthData.authorization_id : '',
      startDt: this.purchaseAuthData.startdt,
      endDt: this.purchaseAuthData.enddt,
      actualAmount: this.purchaseAuthData.final_amount_no,
      paymentstatus: this.purchaseAuthData.paymentstatus,
      final_amount_no: this.purchaseAuthData.final_amount_no ? this.purchaseAuthData.final_amount_no : '0.00',
      client_account_no: this.purchaseAuthData.client_account_no ? this.purchaseAuthData.client_account_no : ''
    };
  }

    getFiscalCategoryCode(vendorprogramid: any) {
      this._commonService.getArrayList({
              where: {agencyprogramareaid: vendorprogramid},
              method: 'get'
            }, FinanceUrlConfig.EndPoint.accountsPayable.approval.fiscalCodes + '?filter',
          ).subscribe( result => {
              this.fiscalCodes = result;
          });
  }

    updateAuthoriz() {
      this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.accountsPayable.history.updatePurchaseAuthorizationGet;
      const modal = {
        authorization_id: this.authorization_id,
        fiscal_category_cd: this.purchaseServiceForm.get('fiscalCode')?.value,
        justification_tx: this.purchaseServiceForm.get('justificationCode')?.value
      };
      this._commonService.create(modal).subscribe(
        (response) => {
          this._alertService.success('Fiscal category has been Updated');
          this.getPayableApproval();
        },
        (error) => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
    }

 pageNumberChanged(pageInfo: any) {
    this.pageInfo.pageNumber = pageInfo.page;
    this.paginationInfo.sortColumn =  pageInfo.query.sortColumn;
    this.paginationInfo.sortBy  =  pageInfo.query.sortDirection;
    this.getApproveHistory(this.authorization_id);
  }

  public assignUser() {
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.accountsPayable.ServiceLogApproval;
        const modal = {
           'fiscalcategorycd' : this.fiscal_category_cd,
           'costno' : this.cost_no ? this.cost_no : '0.00',
           'authorization_id' : this.authorization_id,
           'provider_id' : this.provider_id,
           'intakeserviceid' : this.intakeserviceid,
           'assignedtoid' : this.assignedTo,
           'eventcode' : 'PCAUTH',
           'status' : 44,
           'startDt': this.startDate,
           'endDt': this.endDate,
           'payment_method_cd': this.payment_method_cd,
           'client_id': this.client_id,
           'client_account_id': this.client_account_id,
           'v_securityusersid': this.user.user.userprofile.securityusersid
        };
    this._commonService.create(modal).subscribe(
        (response) => {
            this._alertService.success('Approval sent successfully!');
            (<any>$('#payment-approval')).modal('hide');
            this.getPayableApproval();
        },
        (error) => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
    );

  }

  selectPerson(row: any) {
    if (row) {
      this.selectedPerson = row;
      this.assignedTo = row.userid;
    }
  }

  getRoutingUser() {
    (<any>$('#approval-history')).modal('hide');
    this._commonService
        .getPagedArrayList(
            new PaginationRequest({
                where: { appevent: 'PCAUTH' },
                method: 'post'
            }),
            'Intakedastagings/getroutingusers'
        )
        .subscribe((result) => {
            this.getUsersList = result.data;
            this.originalUserList = this.getUsersList;
            this.listUser('TOBEASSIGNED');
        });
 }

 listUser(assigned: string) {
  this.selectedPerson = '';
  this.getUsersList = [];
  this.getUsersList = this.originalUserList;
    if (assigned === 'TOBEASSIGNED') {
      this.getUsersList = this.getUsersList.filter((res) => {
        if (res.userrole === 'LDSS Fiscal Supervisor') {
            return res;
        }
    });
    }
  }
  confirmReject() {
    (<any>$('#approval-history')).modal('hide');
    (<any>$('#payment-approval')).modal('hide');
    (<any>$(this.rejectapprovalpopupid)).modal('show');
    this.reason_tx = '';
  }

  rejectApproval() {
    this._commonService.endpointUrl = 'tb_account_transaction/deleteClientTransactionbyAuthId' + '/' + this.authorization_id;
    const modal = {
      client_account_id: this.client_account_id,
      fiscal_category_cd: this.fiscal_category_cd,
      cost_no: this.cost_no
    };
    this._commonService.create(modal).subscribe(
    (response) => {
      this._alertService.success('Approval has been Rejected!');
      (<any>$(this.rejectapprovalpopupid)).modal('hide');
      this.getPayableApproval();
    },
    (error) => {
      this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });

  }

  rejectOtherApproval() {
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.accountsPayable.approval.PurchaseAuthorizationReject + this.authorization_id;
    const modal = {
      reason_tx: this.reason_tx
    };
    this._commonService.create(modal).subscribe(
      (response) => {
        this._alertService.success('Purchase Authorization has been rejected!');
        (<any>$(this.rejectapprovalpopupid)).modal('hide');
        this.getPayableApproval();
      },
      (error) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  reDirectToDirector(fundingData: any) {
    this._router.navigate(['/pages/finance/finance-accountsPayable/approval/director']);
    this._dataStoreService.setData(PurchaseAuthorizationParams.DirectorParms, fundingData);
  }

  
  callApi(query: any) {
    query = JSON.parse(query);
    this.getPayableApproval(query)
  }

  onSortedPayment(event:any) {
    event = JSON.parse(event);
    this.paginationInfo.sortBy = event.sortDirection;
    this.paginationInfo.sortColumn = event.sortColumn;
    this.getPayableApproval(event);
  }

  callReDirectToDirectorMethod(event: any) {
    const data  = JSON.parse(event);
    this.reDirectToDirector(data)
  }
  cfechange(event:any){
    //Function was not initiall defined empty function  added as part of angular upgrade fix
  }
}