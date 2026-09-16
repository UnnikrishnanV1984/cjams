
import {pluck, share, map} from 'rxjs/operators';
import { Component, OnInit, AfterContentInit, Injector } from '@angular/core';
import { CommonHttpService, DataStoreService, AlertService, AuthService, SessionStorageService } from '../../../../@core/services';
import _ from 'lodash';
import { PaginationRequest, DropdownModel, PaginationInfo } from '../../../../@core/entities/common.entities';
import { FinanceAdjustment } from '../../finance.constants';
import { ActivatedRoute, Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { FinanceUrlConfig } from '../../finance.url.config';
import { Observable } from 'rxjs';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { CaseWorkerUrlConfig } from '../../../case-worker/case-worker-url.config';
import { AppUser } from '../../../../@core/entities/authDataModel';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'placement-adjustment',
    templateUrl: './placement-adjustment.component.html',
    styleUrls: ['./placement-adjustment.component.scss'],
    standalone: false
})
export class PlacementAdjustmentComponent implements OnInit, AfterContentInit {
  selectedPayment!: any[];
  selectedProvider = [];
  providerList!: any[];
  selectedProviderId!: number;
  paymentDetailsForm!: FormGroup;
  editAncillaryForm!: FormGroup;
  providerId: any;
  providerName: any;
  taxType: any;
  taxID: any;
  paymentMethod$!: Observable<DropdownModel[]>;
  paymentType$!: Observable<DropdownModel[]>;
  reasonChange$!: Observable<any[]>;
  clientFirstName: any;
  clientLastName: any;
  vendorServices$!: Observable<DropdownModel[]>;
  paginationInfo: PaginationInfo = new PaginationInfo();
  pageInfo: PaginationInfo = new PaginationInfo();
  pageNumberInfo: PaginationInfo = new PaginationInfo();
  reportableCheck = [
    { text: 'Yes', report_1099_sw: 'Y' },
    { text: 'No', report_1099_sw: 'N' },
  ];
  selectedPerson!: any[];
  assignedTo: any;
  originalUserList: any;
  getUsersList!: any[];
  paymentDetails!: any[];
  totalcount!: number;
  isFinanceSupervisor!: boolean;
  user!: AppUser;
  url!: string;
  intakeServiceId: any;
  grossAmount!: number;
  enableSave!: boolean;
  paymentDetailId!: number;
  caseId: any;
  paymentMethod: any;
  userID!: string;
  countyId: any;
  paymentType: any;
  disablePaymentSave = false;
  actualCost: any;
  originalPayment!: boolean;
  totalpagecount!: number;
  authorization_id!: number;
  categoryCode: any;
  paymentStatusCode: any;
  reason_tx: any;
  payementID: any;
  selectedProviderDetails :any= [];
  totalRecords: any;
  fiscalCodes!: any[];
  ancillaryview: any;
  paymentId: any;
  payment_status: any;
  paymentInterface!: any[];
  purchaseRequestForm!: FormGroup;
  payableApprovalHistory!: any[];
  totalPage: any;
  viewPurchaseDetails: any;
  purchaseAuthData: any;
  purchaseServiceForm!: FormGroup;
  payment: any;
  checkPaymentStatus: any;
  statuscheck: any;
  notes: any;
  oldnotes: any;
  checkStatus$!: Observable<DropdownModel[]>;
  paymentinterfaceStatuses!: string;
  oldcheckPaymentStatus: any;
  isButtonClicked!: boolean;
  providerDetails: any;
  clientAccountID: any;
  activeModule: any;
  isCountyUser!: boolean;
  mandatoryField: boolean =false;
  isVissbleButton!: boolean;
  paymentdetailspopupid = '#payment-details';
  paymentdetailseditpopupid = '#payment-details-edit';
  paymentapprovalpopupid = '#payment-approval';
  ssnEye = 'fa-eye';
  showSsnMask:boolean =true;
  isSsnHidden = true;
  private _commonService: CommonHttpService;
  private _datastoreService: DataStoreService;
  private _route: ActivatedRoute;
  private _router: Router;
  private _formBuilder: FormBuilder;
  private _alertService: AlertService;
  private _authService: AuthService;

  constructor(private readonly injector : Injector, private _sessionStorage: SessionStorageService) {
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._datastoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._router = this.injector.get<Router>(Router);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._authService = this.injector.get<AuthService>(AuthService);
  }

  ngOnInit() {
    this.buildPaymentForm();
    this.disablePaymentSave = false;
    this.user = this._authService.getCurrentUser();
    this.userID = this.user.user.securityusersid;
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.isVissbleButton = this._authService.isVissbleButton('read_only_access', '');
    if (this.activeModule === 'Finance') {
      this.activeModuleIsFinanceFn();
    } else {
      this.activeModuleElseConditionFn();
    }
    this.paginationInfo.pageNumber = 1;
    this.pageInfo.pageNumber = 1;
    this.pageNumberInfo.pageNumber = 1;

    this._datastoreService.currentStore.subscribe(store => {
      const selectedProvider = store[FinanceAdjustment.Selectedpayment];
      const providerDetails = store[FinanceAdjustment.SelectedpaymentFromDashboard];
      if (selectedProvider) {
        this.ifselectedProviderFn(selectedProvider);
      } else {
        this.ifProviderDetailsFn(providerDetails);
      }
    });
    this.getChangedReason();
    this.getPaymentMethod();
    this.getPaymentType();
    this.getServiceType();
    this.paymentDetailsForm.disable();
    this.paymentDetailsForm.get('gross_amount_no')?.enable();
    this.paymentDetailsForm.get('notes_tx')?.enable();
  }

  toggleSsn = () => {
    this.isSsnHidden =  !this.isSsnHidden;
    if (this.isSsnHidden) {
      this.ssnEye = 'fa-eye';
      this.showSsnMask = true;
    } else {
      this.ssnEye = 'fa-eye-slash';
      this.showSsnMask = false;
    }
  }

  private updateDropdownModel(value: any) {
    return new DropdownModel({
      text: value.description_tx,
      value: value.picklist_value_cd
    })
  }

  // Associated with ngOnInit function
  private ifProviderDetailsFn(providerDetails: any) {
    if (providerDetails) {
      (<any>$('#payAdjustment')).removeClass('active');
      (<any>$(`#payAdjustmentDetails`)).addClass('active');
      (<any>$('#adjustment')).removeClass('active');
      (<any>$(`#adjustmentDetails`)).addClass('active');
      this.selectedProviderId = providerDetails.provider_id;
      this.providerName = providerDetails.provider_nm ? providerDetails.provider_nm : '';
      this.taxID = providerDetails.tax_id_no ? providerDetails.tax_id_no : '';
      this.taxType = providerDetails.taxidtype ? providerDetails.taxidtype : '';
    }
  }
  // Associated with ngOnInit function
  private ifselectedProviderFn(selectedProvider: any) {
    this.selectedProviderId = selectedProvider.provider_id;
    this.providerName = selectedProvider.provider_nm ? selectedProvider.provider_nm : '';
    this.taxID = selectedProvider.tax_id_no ? selectedProvider.tax_id_no : '';
    this.taxType = selectedProvider.taxidtype ? selectedProvider.taxidtype : '';
  }
  // Associated with ngOnInit function
  private activeModuleElseConditionFn() {
    if (this.user.role.name.trim().toLowerCase() === 'central office fiscal staff' ||
      this.user.role.name.trim().toLowerCase() === 'central office fiscal supervisor') {
      this.isCountyUser = false;
    } else {
      this.isCountyUser = true;
      this.isFinanceSupervisor = true;
    }
  }
  // Associated with ngOnInit function
  private activeModuleIsFinanceFn() {
    if (this.user.role.name.trim().toLowerCase() === 'central office fiscal staff' ||
      this.user.role.name.trim().toLowerCase() === 'central office fiscal supervisor') {
      this.isCountyUser = false;
    } else {
      this.isCountyUser = true;
      this.isFinanceSupervisor = false;
    }
  }

  ngAfterContentInit(): void {
    if (this.selectedProviderId) {
      this.getSelectedProvider();
      this.getSelectedProviderDetails();
      this._datastoreService.setData(FinanceAdjustment.Selectedpayment, null);
      this._datastoreService.setData(FinanceAdjustment.SelectedpaymentFromDashboard, null);
    }
}

  private getFilteredProviders(providerid: any) {
    const searchParams = { providerid : providerid} ;
    this._commonService.getPagedArrayList({
      limit: this.paginationInfo.pageSize,
      page: this.paginationInfo.pageNumber,
      where: searchParams,
      method: 'post'
    }, 'tb_payment_header/getancillaryadjustmentsearch')
      .subscribe((res: any) => {
        if (res) {
          if (res.data && res.data.length > 0) {
            this.providerList = res.data;
            const selectedProvider = this.providerList[0];
            this.selectedProviderId = selectedProvider.provider_id;
            this.providerName = selectedProvider.provider_nm ? selectedProvider.provider_nm : '';
            this.taxID = selectedProvider.tax_id_no ? selectedProvider.tax_id_no : '';
            this.taxType = selectedProvider.taxidtype ? selectedProvider.taxidtype : '';

          }
          this.totalcount = this.returnTotalcountFn();
        }
      });
  }
  // Associated with getFilteredProviders function
  private returnTotalcountFn(): number {
    return (this.providerList && this.providerList.length > 0) ? this.providerList[0].totalcount : 0;
  }

  buildPaymentForm() {
    this.paymentDetailsForm = this._formBuilder.group({
      payment_id: [null],
      client_id: [null],
      final_fiscal_category_cd: [null],
      final_service_nm: [null],
      change_reason_cd: [null, Validators.required],
      final_service_start_dt: [null],
      gross_amount_no: [null],
      client_name: [null],
      cis_client_id: [null],
      countyname: [null],
      type1099nm: [null],
      final_service_end_dt: [null],
      notes_tx: [null],
      payment_method_cd: [null],
      type_1099_cd: [null],
      final_service_id: [null],
      report_1099_sw: [null],
      original_payment_amount: [null],
      payment_date: [null],
      original_payment_id: [null],
      paymentstatus: [null],
      payment_amount: [null],
      original_payment_date: [null]
    });
  this.editAncillaryForm = this._formBuilder.group({
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

  getProviderDataFn(url: string, paginationRequest: PaginationRequest, selectedProviderProperty: string, totalRecords: string) {
    this._commonService.getPagedArrayList(paginationRequest, url + '?filter')
      .subscribe((response:any) => {
        (this as any)[selectedProviderProperty] = response.data;
        for (const element of (this as any)[selectedProviderProperty]) {
          this.providerId = element.provider_id ? element.provider_id : '';
          this.providerName = element.provider_nm ? element.provider_nm : '';
          this.taxID = element.tax_id_no ? element.tax_id_no : '';
          this.taxType = element.taxidtype ? element.taxidtype : ''; 
        }
        (this as any)[totalRecords] = ((this as any)[selectedProviderProperty] && (this as any)[selectedProviderProperty].length > 0) ? (this as any)[selectedProviderProperty][0].totalcount : 0;
      });
  }

  getSelectedProvider() {
    const url = this.isFinanceSupervisor ? 'tb_payment_header/getancillarysupervisorlist' : 'tb_payment_header/getancillaryadjustmentlist';
    const paginationRequest = new PaginationRequest({
      where: { providerid: this.selectedProviderId },
      limit: this.pageInfo.pageSize,
      page: this.pageInfo.pageNumber,
      method: 'get'
    });
    this.getProviderDataFn(url, paginationRequest, 'selectedProvider', 'totalpagecount');
  }

  getSelectedProviderDetails() {
    const url = this.isFinanceSupervisor ? 'tb_payment_header/getancillarysupervisorlist' : 'tb_payment_header/getancillaryadjustmentlist';
    const paginationRequest = new PaginationRequest({
      where: { providerid: this.selectedProviderId },
      limit: this.pageNumberInfo.pageSize,
      page: this.pageNumberInfo.pageNumber,
      method: 'get'
    });
    this.getProviderDataFn(url, paginationRequest, 'selectedProviderDetails', 'totalRecords');
  }

  pageNumberChanged(page: number) {
    this.pageInfo.pageNumber = page;
    this.getSelectedProvider();
  }

  pageInfoChanged(page: number) {
    this.pageNumberInfo.pageNumber = page;
    this.getSelectedProviderDetails();
  }


  selectPaymentDetails() {
    this.disablePaymentSave = false;
    (<any>$(this.paymentdetailspopupid)).modal('hide');
    let countycd = (this.user && this.user.user && this.user.user.userprofile && this.user.user.userprofile.primarycountycd !== '3824') ? this.user.user.userprofile.primarycountycd : null;
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        where: {providerid: this.selectedProviderId,countycd: countycd},
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        method: 'get'
    }), 'tb_payment_header/getpaymentdetail' + '?filter'
    ).subscribe(response => {
      this.selectedPayment = response.data;
      this.totalcount = (this.selectedPayment && this.selectedPayment.length > 0) ? this.selectedPayment[0].totalcount : 0;
    });
  }

  pageChanged(page: number) {
    this.paginationInfo.pageNumber = page;
    this.selectPaymentDetails();
  }

  selectOriginalPayment(payment: any) {
    this.categoryCode = '';
    this.paymentStatusCode = '';
    this.paymentDetailsForm.get('change_reason_cd')?.reset();
    this.paymentDetailsForm.get('notes_tx')?.reset();
    this.grossAmount = parseFloat(payment.gross_amount_no);
    this.authorization_id = payment.authorization_id ? payment.authorization_id : '';
    this.clientAccountID = payment.client_account_id ? payment.client_account_id : null;
    this.intakeServiceId = payment.intakeserviceid;
    this.paymentDetailId = payment.payment_detail_id;
    this.clientFirstName = payment.clientfirstname ? payment.clientfirstname : '';
    this.clientLastName = payment.clientlastname ? payment.clientlastname : '';
    this.caseId = payment.case_id ? payment.case_id : '';
    this.countyId = payment.county_cd ? payment.county_cd : '';
    this.paymentMethod = payment.payment_method_cd ? payment.payment_method_cd : '';
    this.paymentType = payment.payment_type_cd ? payment.payment_type_cd : '';
    this.categoryCode = payment.final_fiscal_category_cd ? payment.final_fiscal_category_cd : '';
    this.paymentStatusCode = payment.payment_status_cd;
    this.actualCost = payment.gross_amount_no;
    this.paymentDetailsForm.patchValue(payment);
    this.paymentDetailsForm.patchValue({
      client_name : this.clientFirstName + ' ' + this.clientLastName,
      final_service_start_dt: payment.final_service_start_dt,
      final_service_end_dt: payment.final_service_end_dt,
      payment_date: payment.payment_date,
      final_fiscal_category_cd: payment.final_fiscal_category + ' (' + payment.final_fiscal_category_cd + ')',
      gross_amount_no: '', // D-15287 - Don't set default value
     // original_payment_id :original_payment.originalpaymentid,
     // payment_amount : payment.payment_amount
    });
  }

  grossAmountChange(event: Event): void {
    const inputElement = event.target as HTMLInputElement;
    const amount = inputElement?.value;
    if (parseFloat(amount) === this.grossAmount) {
      this.enableSave = false;
    } else {
      this.enableSave = true;
    }
    const actual_cost = this.actualCost;
    const percentage = actual_cost * 0.15;
    if (!_.isNaN(_.toNumber(amount))) {
      this.paymentDetailsForm.patchValue ({
        gross_amount_no : _.toNumber(amount).toFixed(2)
      });
    }
    if (parseFloat(amount) > percentage) {
      this._alertService.warn('Not allowed to approve more than 15% from the actual cost');
      this.paymentDetailsForm.get('gross_amount_no')?.reset();
      return;
    }
  }

  displaySelectedPayment() {
    this.paymentDetailsForm.get('change_reason_cd')?.enable();
    this.paymentDetailsForm.get('gross_amount_no')?.enable();
    this.paymentDetailsForm.get('notes_tx')?.enable();

    (<any>$('#original-payment')).modal('hide');

  }

  clearForm() {
    this.paymentDetailsForm.reset();
    this.paymentDetailsForm.controls['final_service_start_dt'].disable();
    this.paymentDetailsForm.controls['final_service_end_dt'].disable();
  }

  addAncillaryAdjustment() {
    this.isButtonClicked = true;
    const paymentDetails = this.paymentDetailsForm.getRawValue();

    paymentDetails.payment_status_cd = this.paymentStatusCode;
    paymentDetails.final_fiscal_category_cd = this.categoryCode;
    paymentDetails.client_first_nm = this.clientFirstName;
    paymentDetails.client_last_nm = this.clientLastName;
    paymentDetails.provider_id = this.selectedProviderId;
    paymentDetails.status = '51';
    paymentDetails.assignedtoid = this.assignedTo;
    paymentDetails.intakeserviceid = this.intakeServiceId;
    paymentDetails.payment_detail_id = this.paymentDetailId;
    paymentDetails.case_id = this.caseId;
    paymentDetails.county_cd = this.countyId;
    paymentDetails.payment_method_cd = this.paymentMethod;
    paymentDetails.payment_type_cd = this.paymentType;
    paymentDetails.authorization_id = this.authorization_id;
    paymentDetails.client_account_id = this.clientAccountID;

    this._commonService.endpointUrl = 'tb_payment_header/ancillaryadd';
    this._commonService.create(paymentDetails).subscribe((response) => {
      if (response && response.isexceed) {
        if (response.isexceed === 3) {
          (<any>$('#payment-approval')).modal('hide');
          this._alertService.success('Ancillary Adjustment Saved!');
          this.getSelectedProvider();
          this.getSelectedProviderDetails();
          this.clearForm();
          this.isButtonClicked = false;
        } else if (response.isexceed === 2) {
          this._alertService.error(`Insufficient Client Account balance, please raise a request at lower cost`);
        } else if (response.isexceed === 1) {
          this._alertService.error(`Account is not available, kindly please add account for the selected client`);
        } else if (response.isexceed === 5) {
          this._alertService.error(`Finanl Disbursement is in progress for the selected client`);
        }
      }
    },
    (error) => {
      this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  getChangedReason() {
    this.reasonChange$ = this._commonService.getArrayList({
      where: {picklist_type_id : '277'},
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe( map((result) => {
      const list= result.filter(listVal => listVal.picklist_value_cd === '3035' || listVal.picklist_value_cd === '4242');
      return list.map(res => this.updateDropdownModel(res));
  }));
  }

  getPaymentType() {
    this.paymentType$ = this._commonService.getArrayList({
      where: { picklist_type_id: '308' },
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe(map((result) => {
      return result.map(res => this.updateDropdownModel(res));
    }));
  }

  getServiceType() {
    const source = this._commonService.getArrayList({
      order: 'service_nm'
    },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.AllVendorServices
  ).pipe(map((result: any) => {
    return {
      servicetypeid: result['UserToken'].map(
        (res: any) =>
            new DropdownModel({
                text: res.service_nm,
                value: res.service_id
            })
    )

    };
  }),share(),);
  this.vendorServices$ = source.pipe(pluck('servicetypeid'));
  }

  getPaymentMethod() {
    this.paymentMethod$ = this._commonService.getArrayList({
      where: {picklist_type_id : '1'},
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe( map((result) => {
      return result.map(res => this.updateDropdownModel(res));
  }));
  }

  selectPerson(row: any) {
    if (row) {
      this.selectedPerson = row;
      this.assignedTo = row.userid;
    }
  }

  getRoutingUser(paymentDetails: any) {
    this.mandatoryField=true;
    this.paymentDetailsForm.markAllAsTouched();
    if(this.paymentDetailsForm.invalid){
     return null;
    }
    (<any>$(this.paymentdetailspopupid)).modal('hide');
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
            this.originalUserList = this.getUsersList.filter(
              (item, index, self) =>
                index === self.findIndex((t) => t.userid === item.userid) // CIDM-10713 avoiding duplicates
            );
            this.listUser('TOBEASSIGNED');
            (<any>$(this.paymentapprovalpopupid)).modal('show');
        });
 }

 listUser(assigned: string) {
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

  adjustmentApproval(providerDetails: any) {
    this._commonService.endpointUrl = 'tb_payment_status/ancillarysupervisorapprove';
    const modal = {
      payment_id: providerDetails.payment_id,
      fromsecurityusersid: providerDetails.fromsecurityusersid,
      intakeserviceid: providerDetails.intakeserviceid,
      gross_amount_no:  providerDetails.gross_amount_no,
      fiscal_category_cd : providerDetails.fiscal_category_cd,
      client_account_id : providerDetails.client_account_id,
      authorization_id: providerDetails.authorization_id,
      final_service_end_dt: providerDetails.final_service_end_dt,
      final_service_start_dt: providerDetails.final_service_start_dt
    };
    this._commonService.create(modal).subscribe(
      (response:any) => {
        if (response) {
          this._alertService.success('Approved Successfully');
          this.getSelectedProvider();
          this.getSelectedProviderDetails();
        }
      },
      (error:any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
      );

  }
  confirmReject(providerDetails: any) {
    this.providerDetails = providerDetails;
    this.payementID = providerDetails.payment_id;
    this.reason_tx = '';
  }

  rejectApproval() {
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.accountsPayable.AncillaryAdjustment.reject + this.payementID;
    const modal = {
      gross_amount_no: this.providerDetails.gross_amount_no,
      fiscal_category_cd: this.providerDetails.fiscal_category_cd,
      client_account_id: this.providerDetails.client_account_id,
      authorization_id: this.providerDetails.authorization_id,
      reason_tx: this.reason_tx,
    };
    this._commonService.create(modal).subscribe(
      (response:any) => {
        (<any>$('#reject-approval')).modal('hide');
        this._alertService.success('Approval request has been Denied successfully');
        this.getSelectedProviderDetails();
      },
      (error:any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  paymentDetailsView(payment: any) {
    this.originalPayment = true;
    this.paymentDetailsForm.get('change_reason_cd')?.disable();
    this.paymentDetailsForm.get('gross_amount_no')?.disable();
    this.paymentDetailsForm.get('notes_tx')?.disable();
    this.disablePaymentSave = true;
    this.clientFirstName = payment.clientfirstname ? payment.clientfirstname : '';
    this.clientLastName = payment.clientlastname ? payment.clientlastname : '';
    this.paymentDetailsForm.patchValue(payment);
    const original_payment = (payment && payment.originaldetails && payment.originaldetails.length) ? payment.originaldetails[0] : null;
    (<any>$(this.paymentdetailspopupid)).modal('show');
    this.paymentDetailsForm.patchValue({
      client_name : this.clientFirstName + ' ' + this.clientLastName,
      countyname: payment.localdepartment,
      final_service_start_dt: payment.final_service_start_dt,
      final_service_end_dt: payment.final_service_end_dt,
      payment_date : payment.payment_dt,
      final_fiscal_category_cd: (payment.fiscal_category_cd) ? payment.fiscal_category_desc + ' (' + payment.fiscal_category_cd.trim() + ') ' : payment.fiscal_category_desc
    });
    this.paymentDetailsForm.patchValue({
      original_payment_id : (original_payment && original_payment.originalpaymentid) ? original_payment.originalpaymentid : null,
      original_payment_amount : (original_payment.originalpaymentamount) ? _.toNumber(original_payment.originalpaymentamount).toFixed(2) : '0.00',
      payment_amount: (original_payment.originalpaymentamount) ? parseFloat(original_payment.originalpaymentamount) : '0.00',
      original_payment_date: original_payment.originalpaymentdate 
    });
  }

  addPayment() {
    this.paymentDetailsForm.get('change_reason_cd')?.enable();
    this.originalPayment = false;
    this.disablePaymentSave = false;
  }

  backToSearch() {
    this._router.navigate(['../adjustment-result'], { relativeTo: this._route });
  }

  /* checkDec(el) {
    if (el.target.value !== '') {
      return el.target.value = isNaN(el.target.value) ? '' : el.target.value.replace(/[^0-9.]{0,2}/g, '');
    }
    return '';
  } */

paymentInterfaceStatus(paymentID: any, paymentinterfaceStatus: any) {
  this._commonService.getArrayList({
      where: {
          payment_id: paymentID
      },
      method: 'get'
  }, 'tb_payment_status/paymentafsfmis?filter'
  ).subscribe(response => {
      this.paymentInterface = response;
  });
  this.paymentId = paymentID;
  this.paymentinterfaceStatuses = paymentinterfaceStatus;
  this.loadcheckStatus();
}

editPayment(paymentDetails: any) {
  this.payment = paymentDetails;
  this.checkPaymentStatus = paymentDetails.check_status_cd ? paymentDetails.check_status_cd : null;
  this.statuscheck = paymentDetails.check_status_cd ? paymentDetails.check_status_cd : null;
  this.notes = paymentDetails.notes_tx ? paymentDetails.notes_tx : '';
  this.oldcheckPaymentStatus = this.checkPaymentStatus;
  this.oldnotes = this.notes;
  (<any>$('#payment-interface')).modal('hide');
  (<any>$(this.paymentdetailseditpopupid)).modal('show');
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
            (<any>$(this.paymentdetailseditpopupid)).modal('hide');
            this.paymentInterfaceStatus(this.payment.payment_id, this.paymentinterfaceStatuses);
            (<any>$('#payment-interface')).modal('show');
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

changeReasonValue() {
  if (this.paymentDetailsForm.controls['change_reason_cd'].value === '3035') {
    this.paymentDetailsForm.controls['final_service_start_dt'].enable();
    this.paymentDetailsForm.controls['final_service_end_dt'].enable();
  } else {
    this.paymentDetailsForm.controls['final_service_start_dt'].disable();
    this.paymentDetailsForm.controls['final_service_end_dt'].disable();
  }  
}

// Validation of Service Start date and end date 
validateDates(){
  const startDt = this.paymentDetailsForm.getRawValue().final_service_start_dt;
  const endDt = this.paymentDetailsForm.getRawValue().final_service_end_dt;
  if (startDt  && endDt && new Date(endDt) < new Date(startDt)) {
      this._alertService.error('Service Start date should not  be greater than end date');
      this.paymentDetailsForm.controls['final_service_end_dt'].setValue('');  
  }
}
checkStatusChange(value: string) {
  if (value == '4849') {
    (<any>$(this.paymentdetailseditpopupid)).modal('hide');
    (<any>$('#confirm-checkstatus')).modal('show');
  } else {
    this.oldcheckPaymentStatus = this.checkPaymentStatus;
  }
}
ConfirmPopup(index: number) {
  (<any>$('#confirm-checkstatus')).modal('hide');
  (<any>$(this.paymentdetailseditpopupid)).modal('show');
  if (index === 1) {
    this.checkPaymentStatus = this.oldcheckPaymentStatus;
  }
}

printProvider() {
  window.print();
}
}
