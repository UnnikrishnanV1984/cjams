
import {of as observableOf,  Observable } from 'rxjs';

import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { DataStoreService, CommonHttpService, AlertService, AuthService } from '../../../../@core/services';
import { FinanceUrlConfig } from '../../finance.url.config';
import { FinanceStoreConstants } from '../../finance.constants';
import { PaginationRequest, PaginationInfo, DropdownModel } from '../../../../@core/entities/common.entities';
import moment from 'moment';
import { PurchaseAuthorization } from '../../_entities/finance-entity.module';
import { FinanceService } from '../../finance.service';

declare let $: any;
@Component({
    selector: 'payable-ancillary',
    templateUrl: './payable-ancillary.component.html',
    styleUrls: ['./payable-ancillary.component.scss'],
    standalone: false
})
export class PayableAncillaryComponent implements OnInit {
  calculate=false;
  stateandZip: any;
  payableApproval = [];
  ancillarySearchForm!: FormGroup;
  ancillarySearchResult :any[]= [];
  payableApprovalHistory: any[]=[];
  paginationInfo: PaginationInfo = new PaginationInfo();
  editAncillaryForm!: FormGroup;
  authorizationID: any;
  totalcount!: number;
  ancillaryPaymentList :any[]= [];
  viewPurchaseDetails: any;
  paymentAddress: string='';
  isRejected:boolean=false;
  workerid: any;
  workerphone: any;
  localdept: any;
  authorization_id: any;
  workername: any;
  clientName: any;
  catagoryCode: any;
  purchaseRequestForm!: FormGroup;
  street: any;
  city: any;
  purchaseServiceForm!: FormGroup;
  county: any;
  state: any;
  zipCode: any;
  payment_status: any;
  paymentInterface: any[]=[];
  checkStatus$!: Observable<DropdownModel[]>;
  paymentId: any;
  actualCost: any;
  amount2!: number;
  amount1!: number;
  amount_no!: number;
  gross_amount_no!: number;
  childAccountReject:boolean=false;
  fiscal_category_cd: any;
  paymentType: any[]=[];
  cost_no: any;
  provider_id: any;
  intakeserviceid: any;
  startDate:Date=new Date();
  endDate:Date=new Date();
  payment_method_cd: any;
  paymentType$!: Observable<any[]>;
  isapproved: any;
  remarks: any;
  client_id: any;
  client_account_id!: number;
  totalPage!: number;
  reportCheck: string='';
  pageInfo: PaginationInfo = new PaginationInfo();
  purchaseAuthData!: PurchaseAuthorization;
  ancillaryview: any;
  fiscalCode$!: Observable<DropdownModel[]>;
  paymentMethod$!: Observable<DropdownModel[]>;
  timestamp:Date=new Date();
  totalpagecount: number[] = new Array(10).fill(0);
  providerID: any;
  selectedIndex: any;
  pagination: PaginationInfo[] = new Array(10).fill(new PaginationInfo());
  isapprovedFlag:boolean=false;
  fiscalCodes: any[]=[];
  notes: any;
  oldnotes: any;
  statuscheck: any;
  checkPaymentStatus: any;
  payment: any;
  streetNo: string='';
  oldcheckPaymentStatus: any;
  streetDir: string='';
  suit: string='';
  adrUnitType: string='';
  adrUnitNo: string='';
  providerName:boolean=false;
  providerIDFlag: boolean = true;
  taxIDFlag:boolean=false;
  clientNameFlag: boolean = false;
  providerpaymentAddress: any;
  moduleview: any;
  checkmandatory: boolean = false;
  isTaxidHidden: boolean = true;
  ssnEye = 'fa-eye';
  showSsnMask = true;
  expandedIndex: number | null = null;

  constructor(
      private formBuilder: FormBuilder,
      private _datatoreService: DataStoreService,
      private _commonService: CommonHttpService,
      private _alertService: AlertService,
      private _formBuilder: FormBuilder, private _providerpopup: FinanceService,
      private _authService: AuthService
      ) { }
  paymentdetailspopupid = '#payment-details';
  ngOnInit() {
      this.moduleview = this._authService.isModuleAccessable('finance', 'finance.finance.accountspayableancillary');
      this.timestamp = new Date();
      this.buildForm();
      this.loadcheckStatus();
      this.paginationInfo.pageNumber = 1;
     this.pagination[0].pageNumber = 1;
      this.getFiscalCategory();
      this.purchaseRequestForm?.get('payment_id')?.disable();
      this.purchaseRequestForm?.get('payment_start_dt')?.disable();
      this.purchaseRequestForm?.get('payment_end_dt')?.disable();
      this.getPaymentMethod();
      this.getPaymentType();
      const getSearchdata = this._datatoreService.getData('FinanceProviderSearch');
      if (getSearchdata && (getSearchdata.page === 'Both' || getSearchdata.page === 'Maintenance')) {
        this.ancillarySearchForm.reset();
        this.ancillarySearchForm.patchValue({
          providerid: getSearchdata.providerId
        });
        this.searchProviders();
        this._datatoreService.setData('FinanceProviderSearch', null);
      }
  }

  toggleSsn = (row:any) => {
    row.isSsnHidden = (row.isSsnHidden !== null && row.isSsnHidden !== undefined ? !row.isSsnHidden : !this.isTaxidHidden);
    if (row.isSsnHidden) {
      row.ssnEye = 'fa-eye';
      row.showSsnMask = true;
    } else {
      row.ssnEye = 'fa-eye-slash';
      row.showSsnMask = false;
    }
  }

  buildForm() {
    this.ancillarySearchForm = this.formBuilder.group({
      providerid: [null],
      paymentid: [null],
      providername: [null],
      clientid: [null],
      taxid: [null],
      clientname: [null],
      daterangeto: [null],
      daterangefrom: [null],
      dobdaterangefrom: [null],
      dobdaterangeto: [null],
      ayear: ['Y'],
      providerfirstnm: [''],
      providerlastnm: [''],
      prid: ['pid'],
      pname: [null],
      pmnid: [null],
      cnm: [null],
      clId: ['cid'],
      clientfirstnm: [null],
      clientlastnm: [null]
  });
  this.ancillarySearchForm.controls['taxid'].disable();
  this.purchaseRequestForm = this._formBuilder.group({
    payment_start_dt: [null],
    payment_end_dt: [null],
    payment_method_cd: [null, Validators.required],
    type_1099_cd: [null, Validators.required],
    amount_no: [null],
    gross_amount_no: [null],
    store_receipt_id: [null],
    actualAmount: [null],
    payment_id: [null],
    report_1099_sw: [null]
  });
  this.editAncillaryForm = this.formBuilder.group({
    provider_nm: [null],
    tax_id_no: [null],
    ads_approval_dt: [null],
    payment_dt: [null],
    payment_type_nm: [null],
    payment_status_nm: [null],
    provider_id: [null],
    prov_tax_type_cd: [null],
    payment_id: [null],
    payment_method_nm: [null],
    check_status: [null],
    caseworker_name: [null],
    localdepartment: [null],
    payment_address: [null],
    worker_id: [null],
    service_log_id: [null],
    worker_phone: [null],
    client_name: [null],
    final_service_nm: [null],
    final_service_start_dt: [null],
    amountnottoexceed: [null],
    justification_tx: [null],
    client_id: [null],
    final_fiscal_category_cd: [null],
    final_service_end_dt: [null],
    cost: [null]
  });
  this.purchaseServiceForm = this._formBuilder.group(
    {
        fiscalCode: ['', Validators.required],
        voucherRequested: ['', Validators.required],
        costnottoexceed: '',
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

  searchAncilaryProviders(modal:any) {
    this.checkmandatory = true;
    if (modal.valid) {
      if (this.providerName) {
        if (!(modal.value.providername || modal.value.providerfirstnm || modal.value.providerlastnm)) {
          this._alertService.error('Provider name should not be empty');
        } else {
          this.paginationInfo.pageNumber = 1;
          this.searchProviders();
          this.checkmandatory = false;
        }
      } else {
        this.paginationInfo.pageNumber = 1;
        this.searchProviders();
        this.checkmandatory = false;
      }
    } else {
       this._alertService.error('Please fill mandatory fields');
    }
  }

  searchProviders() {
      this._commonService.endpointUrl = 'tb_payment_header/getancillarypaymentHeader';
      const ancillaryValues = this.ancillarySearchForm.getRawValue();
      ancillaryValues.providerid = ancillaryValues.providerid ? ancillaryValues.providerid : null;
      ancillaryValues.paymentid = ancillaryValues.paymentid ? ancillaryValues.paymentid : null;
      ancillaryValues.clientid = ancillaryValues.clientid ? ancillaryValues.clientid : null;
      ancillaryValues.taxid = ancillaryValues.taxid ? ancillaryValues.taxid : null;
      this._commonService.getPagedArrayList(
          new PaginationRequest({
          limit: this.paginationInfo.pageSize,
          page: this.paginationInfo.pageNumber,
          where: ancillaryValues,
          count: -1,
          method: 'post'
        })).subscribe((response: any) => {
          if (response) {
          //change the format of taxid based on the tax type
          for (const item of response.data) {
          item.tax_id_no = this.formatTaxId(item.prov_tax_type_cd, item.tax_id_no);
          }
              this.ancillarySearchResult = response.data;
              this.totalcount = (this.ancillarySearchResult && this.ancillarySearchResult.length > 0) ? this.ancillarySearchResult[0].totalcount : 0;
          }
      });
  }

  paymentListByProviderId(id:any, provider_id:any, isPaginated:any, index?:any) {
    this._commonService.endpointUrl = 'tb_payment_header/getancillarypayment';
    const ancillaryValues = this.ancillarySearchForm.getRawValue();
    ancillaryValues.providerid = provider_id ? provider_id : null;
    ancillaryValues.paymentid = ancillaryValues.paymentid ? ancillaryValues.paymentid : null;
    ancillaryValues.clientid = ancillaryValues.clientid ? ancillaryValues.clientid : null;
    ancillaryValues.taxid = ancillaryValues.taxid ? ancillaryValues.taxid : null;
    this.providerID = provider_id;
    this.selectedIndex = id;
    this.pagination[index].pageNumber = isPaginated ? 1 : this.pagination[index].pageNumber;
    this._commonService.getPagedArrayList(
        new PaginationRequest({
        limit: 10,
        page: this.pagination[index].pageNumber,
        where: ancillaryValues,
        count: -1,
        method: 'post'
      })).subscribe((response: any) => {
        if (response) {
          this.ancillaryPaymentList = this.getAncillaryPaymentApiResponseFn(response, isPaginated, id, index);
          this.purchaseRequestForm.patchValue(this.ancillaryPaymentList);
          this.totalpagecount[index] = (this.ancillaryPaymentList && this.ancillaryPaymentList.length > 0) ? this.ancillaryPaymentList[0].totalcount : 0;
        }
    });
}
// Associated with paymentListByProviderId function
  private getAncillaryPaymentApiResponseFn(response: any, isPaginated: any, id: any, index: any) {
    if (isPaginated) {
      // $('.collapse.in').collapse('hide');
      // $('#' + id).collapse('toggle');
      this.expandedIndex = this.expandedIndex === index ? null : index;
    }
    return response.data.map((item:any) => {
      item.cost = (item.cost === null) ? item.final_amount_no : item.cost;
      item.amountnottoexceed = (item.amountnottoexceed === null) ? item.final_amount_no : item.amountnottoexceed;
      return item;
    });
  }

pageNumberChanged(page:any, index?:any) {
  this.pagination[index].pageNumber = page;
  this.paymentListByProviderId(this.selectedIndex, this.providerID, false, index);
}



  pageChanged(page:any) {
    this.paginationInfo.pageNumber = page;
    this.searchProviders();
    this.pageInfo.pageNumber = page;
    this.getApproveHistory(this.authorization_id);
  }

  clearSearch() {
      this.ancillarySearchForm.reset();
      this.ancillarySearchForm.patchValue({
        prid: ['pid'],
        clId: ['cid'],
        providerfirstnm: [''],
        providerlastnm: [''],
        pname: [null],
        pmnid: [null],
        providername: null,
        providerid: null
      });
      this.providerCheck('pid');
      this.ancillarySearchResult = [];
      this._datatoreService.setData(FinanceStoreConstants.AccountsReceivableSearchParams, null);
  }

  viewAncillaryPayment(ancillary:any) {
    this.ancillaryview = ancillary;
    this.getFiscalCategoryCode(ancillary.programkey);
    this.paymentId = ancillary.payment_id;
    this.payment_status = ancillary.payment_status_nm;
    this.authorization_id = ancillary.authorization_id;
    this.clientName = ancillary.client_first_nm + ' ' + ancillary.client_last_nm;
    this.workername = (ancillary && ancillary.case_worker) ? ancillary.case_worker.fullname : '';
    this.localdept = (ancillary && ancillary.case_worker) ? ancillary.case_worker.localdepartment : '';
    this.workerphone = (ancillary && ancillary.case_worker) ? ancillary.case_worker.phonenumber : '';
    this.workerid = (ancillary && ancillary.case_worker) ? ancillary.case_worker.workerid : '';
    this._providerpopup.getProviderDetails(ancillary.provider_id);
    this.providerpaymentAddress = this._providerpopup.paymentAddress;
    this.editAncillaryForm.disable();
    this.editAncillaryForm.patchValue(ancillary);
    setTimeout(() => {
    this.editAncillaryForm.patchValue({
      worker_id: this.workerid,
      worker_phone: this.workerphone,
      localdepartment: this.localdept,
      caseworker_name: this.workername,
     // payment_address: this.paymentAddress,
      client_name: this.clientName,
      final_fiscal_category_cd: ancillary.final_fiscal_category_nm + '' + '(' + ancillary.final_fiscal_category_cd + ')',
      final_service_start_dt: ancillary.final_service_start_dt,
      final_service_end_dt: ancillary.final_service_end_dt,
      ads_approval_dt: ancillary.ads_approval_dt,
      payment_dt: ancillary.payment_dt
    });
    }, 100);
  }

  actualCostChange(amount:any) {
    let actual_cost = this.actualCost;
    const percentage = actual_cost * 0.15;
    actual_cost = percentage + (+actual_cost);
    if (parseFloat(amount) > actual_cost) {
      this._alertService.warn('Not allowed to approve more than 15% from the actual cost');
      this.purchaseRequestForm.patchValue({
        cost_no : this.actualCost
      });
    }
  }

  documentGenerate(authorization_id:any) {
    if (this.remarks === 'Approved') {
      this.isapprovedFlag = true;
    } else {
        this.isapprovedFlag = false;
    }
    this._commonService.endpointUrl = 'evaluationdocument/generateintakedocument';
    const modal = {
      count: -1,
      where: {
        documenttemplatekey: ['purchaseauthorization'],
        authorizationid: authorization_id,
        isapproved: this.isapprovedFlag
      },
      method: 'post'
    };
    this._commonService.download('evaluationdocument/generateintakedocument', modal)
        .subscribe(res => {
          const blob = new Blob([new Uint8Array(res)]);
          const link = document.createElement('a');
          link.href = window.URL.createObjectURL(blob);
          const timestamp = moment(this.timestamp).format('MM/DD/YYYY HH:mm:ss');
          link.download = 'Purchase-authorization-Form-' + authorization_id + '.' + timestamp + '.pdf';
          document.body.appendChild(link);
          link.click();
          document.body.removeChild(link);
        });
  }

  getPaymentMethod() {
    this.paymentMethod$ = this._commonService.getArrayList({
      where: {picklist_type_id : '1'},
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe( map((result) => {
      return result.map(
          (res) =>
              new DropdownModel({
                  text: res.description_tx,
                  value: res.picklist_value_cd
              })
      );
  }));
  }

  paymentInterfaceStatus() {
    this._commonService.getArrayList({
        where: {
            payment_id: this.paymentId
        },
        method: 'get'
    }, 'tb_payment_status/paymentafsfmis?filter'
    ).subscribe(response => {
        this.paymentInterface = response;
    });
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

  editPayment(paymentDetails:any) {
    this.payment = paymentDetails;
    this.checkPaymentStatus = paymentDetails.check_status_cd ? paymentDetails.check_status_cd : null;
    this.statuscheck = paymentDetails.check_status_cd ? paymentDetails.check_status_cd : null;
    this.notes = paymentDetails.notes_tx ? paymentDetails.notes_tx : '';
    this.oldcheckPaymentStatus = this.checkPaymentStatus;
    this.oldnotes = this.notes;
    $(this.paymentdetailspopupid).modal('show');
    $('#payment-interface').modal('hide');
  }

  updateCheckStatus() {
    this.checkmandatory = true;
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
              $(this.paymentdetailspopupid).modal('hide');
              this.paymentInterfaceStatus();
              $('#payment-interface').modal('show');
              this.checkmandatory = false;
            }
          });
        }
    } else {
      this._alertService.error('Please fill the mandatory fields');
    }
  }

  onAuthID() {
    $('#payment-info').modal('hide');
    const authid = this.ancillaryview;
    if (authid && (authid.fiscal_category_cd === '7502' ||
    authid.fiscal_category_cd === '7503')) {
      this.childAccountReject = true;
    } else {
      this.childAccountReject = false;
    }
    this.purchaseRequestForm.patchValue(authid);
    this.purchaseRequestForm.disable();
    this.fiscal_category_cd = authid.fiscal_category_cd;
    this.cost_no = authid.cost_no ? authid.cost_no : '0.00';
    this.provider_id = authid.provider_id;
    this.intakeserviceid = authid.intakeserviceid;
    this.startDate = authid.payment_start_dt;
    this.endDate = authid.payment_end_dt;
    this.payment_method_cd = authid.payment_method_cd;
    this.isapproved = authid.isapproved;
    this.remarks = authid.remarks;
    this.client_id = authid.client_id;
    this.client_account_id = authid.client_account_id;
    this.payment_method_cd = authid.payment_method_cd;
    this.amount_no = authid.amount_no;
    this.getApproveHistory(this.authorization_id);
    this.viewPurchaseAuthorization(authid);
    this.purchaseRequestForm.patchValue({
      cost_no: authid.cost_no ? authid.cost_no : '0.00',
      payment_start_dt: authid.payment_start_dt,
      amount_no: authid.amount_no,
      store_receipt_id: authid.store_receipt_id,
      payment_end_dt: authid.payment_end_dt,
      payment_id: authid.payment_id ? authid.payment_id : ''
    });
        if (authid.report_1099_sw === 'Y') {
          this.purchaseRequestForm.patchValue({ report_1099_sw : 'Y'});
        } else {
          this.purchaseRequestForm.patchValue({ report_1099_sw : false});
        }
    this.purchaseRequestForm.disable();
  }

  viewPurchaseAuthorization(purchaseDetail:any) {
    this.authorizationID = purchaseDetail.authorization_id;
    this.viewPurchaseDetails = purchaseDetail;
    this.paymentAddress = (purchaseDetail.address_details && purchaseDetail.address_details.length ) ? purchaseDetail.address_details[0].paymentaddress : null;
    this._commonService.getArrayList(
      new PaginationRequest({
          page: 1,
          limit: 20,
          where: { service_log_id: purchaseDetail.service_log_id, authorization_id: this.authorizationID },
          method: 'get'
      }),
      FinanceUrlConfig.EndPoint.accountsPayable.approval.purchaseAuthorizationGet + '?filter'
      ).subscribe((result:any) => {
        if (result['data'] && result['data'].length > 0) {
          this.purchaseAuthorizationGetResultFn(result);
        }
    });
  }
  // Associated with viewPurchaseAuthorization function
  private purchaseAuthorizationGetResultFn(result: any) {
    const paDetails:any[] = result['data'];
    this.purchaseAuthData = paDetails.length > 0 ? paDetails[0] : {};
    const model = {
      fiscalCode: this.purchaseAuthData.fiscal_category_cd,
      voucherRequested: this.purchaseAuthData.voucher_requested,
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
    this.purchaseServiceForm.setValue(model, { emitEvent: true, onlySelf: false });
    this.purchaseServiceForm.disable();
    if (this.remarks === 'Pending') {
      this.purchaseServiceForm?.get('justificationCode')?.enable();
      this.purchaseServiceForm?.get('fiscalCode')?.enable();
    }
  }

  getApproveHistory(authid:any) {
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
      this.totalPage = (this.payableApprovalHistory && this.payableApprovalHistory.length > 0) ? this.payableApprovalHistory[0].totalcount : 0;
    });
  }

  repotCheck(event:any) {
    if (event) {
      this.reportCheck = 'Y';
      this.purchaseRequestForm?.get('type_1099_cd')?.enable();
      this.paymentType$ = observableOf(this.paymentType);
    } else {
      this.getPaymentType();
      this.reportCheck = 'N';
      this.purchaseRequestForm?.get('type_1099_cd')?.reset();
     setTimeout(() => {
      this.purchaseRequestForm.patchValue({type_1099_cd : '3158'});
      this.purchaseRequestForm?.get('type_1099_cd')?.disable();
     }, 50);
    }
  }

  getPaymentType() {
    this.paymentType = [];
    this.paymentType$ = this._commonService.getArrayList({
      where: {picklist_type_id : '308'},
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
      ).pipe( map((payload) => {
        return payload.map(
            (resp) =>
                new DropdownModel({
                    text: resp.value_tx,
                    value: resp.picklist_value_cd
                })
        );
    }));
    this.paymentType$.subscribe((response:any) => {
      for (const element of response) {
        if (element.value !== '3158') {
          this.paymentType.push(element);
        }
      }
    });
  }

  getNetAmount(gross_amount_no:any, offset_amount_no:any) {
    this.amount1 = (gross_amount_no) ? parseFloat(gross_amount_no) : 0;
    this.amount2 = (offset_amount_no) ? parseFloat(offset_amount_no) : 0;
    return (this.amount1 - this.amount2).toFixed(2);
    // (item.gross_amount_no || item.offset_amount_no) ? (parseFloat(item.gross_amount_no-(item.offset_amount_no ? item.offset_amount_no: 0 )).toFixed(2)) : '0.00'
  }

  getFiscalCategory() {
    const source = this._commonService.getAll(
      FinanceUrlConfig.EndPoint.accountsPayable.approval.fiscalCodes,
  ).pipe(map((result:any) => {
    return {
      fiscalCode: result['UserToken'].map(
        (res:any) =>
            new DropdownModel({
                text: (res.fiscalcategorydesc),
                value: (res.fiscalcateforycd),
            })
    )
    };
    }),share(),);
    this.fiscalCode$ = source.pipe(pluck('fiscalCode'));
  }

  getFiscalCategoryCode(vendorprogramid:any) {
    this._commonService.getArrayList({
            where: {agencyprogramareaid: vendorprogramid},
            method: 'get'
          }, FinanceUrlConfig.EndPoint.accountsPayable.approval.fiscalCodes + '?filter',
        ).subscribe( (result:any) => {
            this.fiscalCodes = result;
        });
}

  onChangeDate(form:any, field:any) {
    if ( field === 'startdate' && form?.get('daterangefrom')?.value ) {
      form?.get('daterangeto')?.enable();
      if (form?.get('daterangefrom')?.value > form?.get('daterangeto')?.value) {
        form?.get('daterangeto')?.reset();
      }
    } else if ( field === 'startdobdate' && form?.get('dobdaterangefrom')?.value) {
      form?.get('dobdaterangeto')?.enable();
    }
  }

showProviderPopup(providerID:any) {
  this._datatoreService.setData('paymentid', null);
  $('#modal-view-finace-accountsPayable').modal('hide');
  this._datatoreService.setData('ProviderInfoID', providerID);
  $('#provider-info-popup').modal('show');
  this._providerpopup.getProviderDetails(providerID);
  this._providerpopup.page = 'Ancillary';
}
checkStatusChange(value:any) {
  if (value == '4849') {
    $(this.paymentdetailspopupid).modal('hide');
    $('#confirm-checkstatus').modal('show');
  } else {
    this.oldcheckPaymentStatus = this.checkPaymentStatus;
  }
}
ConfirmPopup(index:any) {
  $('#confirm-checkstatus').modal('hide');
  $(this.paymentdetailspopupid).modal('show');
  if (index === 1) {
    this.checkPaymentStatus = this.oldcheckPaymentStatus;
  }
}

providerCheck(value:any) {
  if (value === 'pnm') {
    this.ancillarySearchForm.patchValue({
      prid: null,
      pmnid: null,
      taxid: null,
      providerid: null,
    });
    this.providerName = true;
    this.providerIDFlag = false;
    this.taxIDFlag = false;
    this.ancillarySearchForm.controls['taxid'].clearValidators();
    this.ancillarySearchForm.controls['providerid'].clearValidators();
    this.ancillarySearchForm.controls['taxid'].disable();
    this.ancillarySearchForm.controls['providerid'].disable();
  } else if (value === 'pid') {
    this.ancillarySearchForm.patchValue({
      pname: null,
      pmnid: null,
      providername: null,
      providerlastnm: null,
      providerfirstnm: null,
      taxid: null
    });
    this.providerName = false;
    this.providerIDFlag = true;
    this.taxIDFlag = false;
    this.ancillarySearchForm.controls['providerid'].enable();
    this.ancillarySearchForm.controls['providerid'].setValidators(Validators.required);
    this.ancillarySearchForm.controls['providerlastnm'].clearValidators();
    this.ancillarySearchForm.controls['providerid'].updateValueAndValidity();
    this.ancillarySearchForm.controls['providername'].clearValidators();
    this.ancillarySearchForm.controls['taxid'].clearValidators();
    this.ancillarySearchForm.controls['taxid'].disable();
  } else {
    this.ancillarySearchForm.patchValue({
      prid: null,
      pname: null,
      providername: null,
      providerlastnm: null,
      providerfirstnm: null,
      providerid: null
    });
    this.ancillarySearchForm.controls['taxid'].enable();
    this.ancillarySearchForm.controls['taxid'].setValidators(Validators.required);
    this.ancillarySearchForm.controls['providername'].clearValidators();
    this.ancillarySearchForm.controls['taxid'].updateValueAndValidity();
    this.ancillarySearchForm.controls['providerid'].clearValidators();
    this.ancillarySearchForm.controls['providerlastnm'].clearValidators();
    this.ancillarySearchForm.controls['providerid'].disable();
    this.providerName = false;
    this.providerIDFlag = false;
    this.taxIDFlag = true;
  }
}
clientCheck(value:any) {
  if (value === 'cid') {
    this.ancillarySearchForm.patchValue({
      cnm: null,
      clientfirstnm: null,
      clientlastnm: null
    });
    this.clientNameFlag = false;
    this.ancillarySearchForm.controls['clientid'].enable();
  } else {
    this.ancillarySearchForm.patchValue({
     clId: null
    });
    this.clientNameFlag = true;
    this.ancillarySearchForm.controls['clientid'].disable();
  }
}

printProvider() {
  window.print();
}

formatTaxId(taxType: string, taxId: string): string{
  let value;
  if(taxType==='SSN'){
   value=(String(taxId).substring(0, 3) + '-' + String(taxId).substring(3, 5) + '-' + String(taxId).substring(5, 9));
  }else{
    value=(String(taxId).substring(0, 2) + '-' + String(taxId).substring(2, 9));
  }
  return value;
}
toggleTax(){
  //initially udefined added empty function as part of angular upgrade fix
}
}
