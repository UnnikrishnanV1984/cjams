import {map} from 'rxjs/operators';
import { Component, OnInit, Injector } from '@angular/core';
import { CommonHttpService, AlertService, CommonDropdownsService, AuthService, SessionStorageService, DataStoreService } from '../../../../../@core/services';
import { FinanceArProviderDetailsService } from '../finance-ar-provider-details.service';
import { PaginationInfo, PaginationRequest, DropdownModel } from '../../../../../@core/entities/common.entities';
import { FinanceUrlConfig } from '../../../finance.url.config';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import moment from 'moment';
import { Observable } from 'rxjs';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import _ from 'lodash';
import { FileError, NgxfUploaderService } from 'ngxf-uploader';
import { AppConfig } from '../../../../../app.config';
import { HttpHeaders } from '@angular/common/http';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import FileSaver from 'file-saver';
import { HttpService } from '../../../../../@core/services/http.service';
import { FinanceService } from '../../../finance.service';
import { AccountReceivable } from '../../../finance.constants';

@Component({
    selector: 'ar-provider-overpayments',
    templateUrl: './ar-provider-overpayments.component.html',
    styleUrls: ['./ar-provider-overpayments.component.scss'],
    standalone: false
})
export class ArProviderOverpaymentsComponent implements OnInit {
  overpayments: any[] = [];
  overpaymentvalue: any;
  changehistory = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalcount!: number;
  collectionStatus: any[] = [];
  arStatus: any[] = [];
  selectedOverPayment: any = {};
  overpaymentsForm!: FormGroup;
  isEdit: boolean=false;
  buttonText: string='';
  totalAmount: string='';
  totalReceivableAmount: string='';
  isFW: boolean=false;
  isSupervisor: boolean=false;
  isApproved: boolean=false;
  isPendingWithSupervisor: boolean=false;
  getUsersList:any[]=[];
  originalUserList:any[]=[];
  selectedPerson: any;
  assignedTo: any;
  isWriteOff:boolean=false;
  initialBalance!: number;
  overpaymentId: any;
  adjustment: any[]=[];
  receivableid: any;
  receivable_detail_id: any;
  arstatus: any;
  prevWriteOffAmount: any;
  manualpaymentsForm!: FormGroup;
  selectedPayment: any[]=[];
  totalpagecount!: number;
  pageInfo: PaginationInfo = new PaginationInfo();
  paymentMethod$!: Observable<DropdownModel[]>;
  selectedOriginalPayment: any;
  overPayment:boolean=false;
  mandatoryField: boolean=false;
  intakeserviceid: any;
  paymentDetailID: any;
  receivableType: any;
  buttonVisible:boolean=false;
  isAncillary:boolean=false;
  alertTxt: string='';
  manualOverPayment: any;
  approveStatus!: number;
  arStatusOriginal: any[]=[];
  maxDate = new Date();
  startDate = new Date();
  overpaymentFlag: boolean=false;
  receivableHistoryList:any[]=[];
  isButtonClicked = false;
  underPayment: any;
  approveTxt: string='';
  is_resend: boolean=false;
  disablePaymentSave: boolean=false;
  receivableColletionStatusList:any[]=[];
  restitutionupload: any;
  restitutionuploadedFile: any;
  private token!: AppUser;
  clientID: any;
  activeModule: any;
  userProfile!: AppUser;
  assignedUser:boolean=false;
  manualassignedUser:boolean=false;
  screenName: string='';
  writeOffRedirect: any;
  isVissbleButton:boolean=false;
  disableAssignButton = false;
  updateoverpayments = 'Update Overpayments';
  financeapproval = 'Finance Approval';
  overpaymentdetailspopupid = '#overpayment-details';
  editnotallowednotifymsg = "Edit not allowed due to County specific restrictions";
  manualpaymentdetailspopupid = '#manual-payment-details';
  dtformat = 'YYYY-MM-DD';
  dtformatMDY = 'MM/DD/YYYY';
  overpaymentupdatenotifymsg = 'Overpayment updated successfully';
  balancenotifymsg = 'Balance cannot be greater than overpayment';
  paymentapprovalopoupid = '#payment-approval';
  collection_status_dt: string='';

  private _commonHttpService: CommonHttpService;
  private _providerService: FinanceArProviderDetailsService;
  private _formBuilder: FormBuilder;
  private _alertService: AlertService;
  private _commonDropdownService: CommonDropdownsService;
  private _uploadService: NgxfUploaderService;
  private _authService: AuthService;
  private _sessionStorage: SessionStorageService;
  private http: HttpService;
  private _financeService: FinanceService;
  private _dataStore: DataStoreService;

  constructor(private injector:Injector){
    this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
    this._providerService = injector.get<FinanceArProviderDetailsService>(FinanceArProviderDetailsService);
    this._formBuilder = injector.get<FormBuilder>(FormBuilder);
    this._alertService = injector.get<AlertService>(AlertService);
    this._commonDropdownService = injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._uploadService = injector.get<NgxfUploaderService>(NgxfUploaderService);
    this._authService = injector.get<AuthService>(AuthService);
    this._sessionStorage = injector.get<SessionStorageService>(SessionStorageService);
    this.http = injector.get<HttpService>(HttpService);
    this._financeService = injector.get<FinanceService>(FinanceService);
    this._dataStore = injector.get<DataStoreService>(DataStoreService);

    this.token = this._authService.getCurrentUser(); 
  }

  ngOnInit() {
    this.isVissbleButton = this._authService.isVissbleButton('read_only_access', '');
    this.getOverPayments();
    this.loadDropdowns();
    this.initFormGroup();
    this.userProfile = this._authService.getCurrentUser();
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.isFW = this._providerService.isFW();
    this.isSupervisor = this._providerService.isSupervisor();
    if (this.activeModule === 'Finance') {
      this.isSupervisor = false;
      this.isFW = true;
      this.buttonText = this.updateoverpayments;
    } else if (this.activeModule === this.financeapproval) {
      this.isVissbleButton = true;
      this.isSupervisor = true;
      this.isFW = false;
    }
    this.overpaymentsForm?.get('receivable_balance_no')?.disable();
    this.overpaymentsForm?.get('written_off_request_amount_no')?.disable();
    this.writeOffRedirect = this._dataStore.getData(AccountReceivable.WriteOff);
    if (this.writeOffRedirect) {
      this.getOVerPaymentRedirect();
    }
  }

  initFormGroup() {
    this.overpaymentsForm = this._formBuilder.group({
      write_off_approval_status: [null],
      receivable_status_cd: [null, Validators.required],
      write_off_action_date: [null],
      comments_tx: [null, Validators.required],
      notes_tx: [null],
      collection_status_cd: [{ value: null, disabled: false }],
      start_dt: [{ value: null, disabled: true }],
      end_dt: [{ value: null, disabled: true }],
      amount_no: [{ value: null, disabled: true }],
      receivable_balance_no: [{ value: null, disabled: true }],
      intakeserviceid: [null],
      writeOffAmount: [null],
      written_off_request_amount_no: [null]
    });
    this.manualpaymentsForm = this._formBuilder.group({
      receivable_status_cd: [null, Validators.required],
      comments_tx: [null, Validators.required],
      notes_tx: [null],
      collection_status_cd: [{ value: null, disabled: false }],
      // start_dt: [null, Validators.required],
      // end_dt: [null, Validators.required],
      start_dt: [null],
      end_dt: [null],
      amount_no: [null, Validators.required],
      receivable_balance_no: [{ value: null, disabled: true }],
      payment_id: [null],
      payment_method_cd: '',
      payment_date: [null],
      payment_amount: [null]
      });
  }

  loadDropdowns() {
    this._commonHttpService.getArrayList({
      where: {
        picklist_type_id: '7'
      },
      nolimit: 'true',
      method: 'get'
    }, FinanceUrlConfig.EndPoint.general.dropdownURL).subscribe(res => {
     this.arStatusOriginal = res;
     this.arStatus = [];
     res.forEach((element: any) => {
        if (this.activeModule === this.financeapproval) {
          if ((this.isEdit === true && (element.description_tx !== 'Write-Off Request' && element.description_tx !== 'PIF')) || (this.isEdit !== true && element.description_tx !== 'PIF')) {
            this.arStatus.push(element);
          }
        } else {
          if ((this.isEdit === true && (element.description_tx !== 'Write-Off' && element.description_tx !== 'PIF')) || (this.isEdit !== true && element.description_tx !== 'PIF')) {
            this.arStatus.push(element);
          }
        }
      });
    });
    this._commonHttpService.getArrayList({
      where: {
        picklist_type_id: '52'
      },
      nolimit: 'true',
      method: 'get'
    }, FinanceUrlConfig.EndPoint.general.dropdownURL).subscribe(res => {
      this.collectionStatus = res;
    });
  }

  private getOVerPaymentRedirect() {
    this._commonHttpService.getPagedArrayList({
      where: {
        providerid: this._providerService.providerid,
        client_id: null
      },
      page: 1,
      limit: null,
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsReceivable.overpayments.list).subscribe((res: any) => {
      if (res && res.data && res.data.length) {
        if (this.writeOffRedirect) {
          const receivable = res.data.find((item: any) => item.receivable_detail_id === this.writeOffRedirect.receivable_detail_id);
          if (this.activeModule === 'Finance') {
            this.viewOverPayment(receivable);
          } else if (this.activeModule === this.financeapproval) {
            this.editOverPayment(receivable);
          }
          this.clearStore();
        }
      }
    });
  }

  private getOverPayments() {
    this.overpaymentFlag = false;
    this._commonHttpService.getPagedArrayList({
      where: {
        providerid: this._providerService.providerid,
        client_id: null
      },
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsReceivable.overpayments.list).subscribe((res: any) => {
      if (res && res.data && res.data.length) {
        this.handleOverpaymentslistFn(res);
      } else {
        this.isAncillary = true;
        this.overpaymentFlag = true;
      }
    });
  }
  // Assosiated to getOverPayments method
  private handleOverpaymentslistFn(res: any) {
    this.overpayments = res.data;
    if (this.overpayments && this.overpayments.length > 0) {
      this.overpayments.forEach(op => {
        op.ageing = op.receivable_balance_no === '0.00' ? 'N/A' : moment().diff(moment(op.receivable_ts).format(this.dtformatMDY), 'days');
      });
    }
    this.receivableid = res.data.receivable_detail_id;
    this.totalAmount = res.totalamount;
    this.totalReceivableAmount = res.totalreceivable_balance_no;
    this.underPayment = res.under_payment;
    if (res.data[0].isancillary === true) {
      this.isAncillary = true;
    } else {
      this.isAncillary = false;
    }
    this.totalcount = (this.overpayments && this.overpayments.length > 0) ? this.overpayments[0].totalcount : 0;
  }

  clearStore() {
    this._dataStore.setData(AccountReceivable.WriteOff, null);
  }

  fiscalAudit() {
    for(let payment of this.overpayments){
      if(payment.receivable_detail_id == this.overpaymentId){
        this.overpaymentvalue = payment;
      }
    }

    this._financeService.getChangeHistory(1, this.overpaymentId, this.screenName, this.overpaymentvalue);
  }

  onARStatusChange(statusCode: string) {
    this.isWriteOff = ['21', '22'].includes(statusCode);
    this.overpaymentsForm?.get('writeOffAmount')?.updateValueAndValidity();
    if (this.activeModule === 'Finance') {
      this.buttonText = (statusCode === '22') ? 'Send For Approval' : this.updateoverpayments;
    } else if (this.activeModule === this.financeapproval) {
      this.buttonText = (this.approveStatus === 30 && (statusCode === '21' || statusCode === '22')) ? 'Approve' : this.updateoverpayments;
    }
  }

  pageChanged(page: number) {
    this.paginationInfo.pageNumber = page;
    this.getOverPayments();
  }

  viewOverPayment(overpayment: any) {
    this.loadDropdowns();
    if(overpayment?.collection_status_dt){
      this.collection_status_dt = moment(overpayment?.collection_status_dt).format(this.dtformatMDY);
    }
    this.setScreenNameFn(overpayment);
    this.selectedOverPayment = overpayment;
    
    this.overpaymentId = overpayment.receivable_detail_id;
    this.clientID = overpayment.client_id;
    this.getReceivableHistory(this.overpaymentId);
    this.overpaymentsForm.patchValue(overpayment);
    this.initialBalance = parseFloat(this.overpaymentsForm?.get('receivable_balance_no')?.value ? this.overpaymentsForm?.get('receivable_balance_no')?.value : 0);
    if (this.activeModule === this.financeapproval && overpayment.receivable_status_cd === '22') { //CIDM-9406 - Sonarqube issues
      this.overpaymentsForm.patchValue({
      receivable_status_cd: (this.initialBalance) ? overpayment.receivable_status_cd : '20'
      });
  } else {
      this.receivableStatusCdCheckFn(overpayment);
  }
    setTimeout(() => {
    this.overpaymentsForm.patchValue({
     written_off_request_amount_no: overpayment.written_off_request_amount_no ? overpayment.written_off_request_amount_no : '0.00',
     writeOffAmount : overpayment.written_off_amount_no ? overpayment.written_off_amount_no : '0.00'
    });
  }, 100);
    this.overpaymentsForm.disable();
    this.isEdit = false;
    this.isApproved = (overpayment.write_off_approval_status === '3047');
    this.overpaymentsForm?.get('writeOffAmount')?.setValue(overpayment.written_off_amount_no);
    this.approveStatus = overpayment.status_cd;
    if (overpayment.write_off_approval_status === '3045' && overpayment.receivable_status_cd === '20') {
      this.overpaymentsForm.patchValue({ receivable_status_cd: '21'});
      this.onARStatusChange('21');
    } else { this.onARStatusChange(overpayment.receivable_status_cd); }
    (<any>$(this.overpaymentdetailspopupid)).modal('show');
    
  }
  // Associated with viewOverPayment function
  private receivableStatusCdCheckFn(overpayment: any) {
    if (overpayment && overpayment.receivable_status_cd === '21') {
      this.overpaymentsForm.patchValue({
        receivable_status_cd: overpayment.receivable_status_cd,
      });
    } else {
      this.overpaymentsForm.patchValue({
        receivable_status_cd: (this.initialBalance) ? overpayment.receivable_status_cd : '20',
      });
    }
  }
  // Associated with viewOverPayment function
  private setScreenNameFn(overpayment: any) {
    if (overpayment && overpayment.fiscal_change_type) {
      if (!(overpayment.fiscal_change_type) || overpayment.fiscal_change_type === '1001' ||
        overpayment.fiscal_change_type === '1004') {
        this.screenName = 'placement';
      } else if (overpayment.fiscal_change_type === '1011' || overpayment.fiscal_change_type === '1013') {
        this.screenName = 'gaprate';
      } else if (overpayment.fiscal_change_type === '1012' || overpayment.fiscal_change_type === '1014') {
        this.screenName = 'gapsuspension';
      }
    } else {
      this.screenName = 'accountReceivable';
    }
  }

  isEditAllowed(overpayment: any) {
    return !(this.activeModule === 'Finance' && (overpayment.receivable_status === 'Pending' || overpayment.receivable_status === 'Approved')) &&
      !(this.activeModule === this.financeapproval && (overpayment.receivable_status === 'Approved'));
  }

  editOverPayment(overpayment: any) {
    if (this.userProfile.user.userprofile.primarycountycd !== '3824' && overpayment.county_cd && this.userProfile.user.userprofile.primarycountycd !== overpayment.county_cd) {
      this._alertService.error(this.editnotallowednotifymsg);
      return
    }
    this.isEdit = true;
    if(overpayment?.collection_status_dt){
      this.collection_status_dt = moment(overpayment?.collection_status_dt).format(this.dtformatMDY);
    }
    this.loadDropdowns();
    this.setScreenNameFn(overpayment);

    this.disablePaymentSave = true;
    this.overpaymentId = overpayment.receivable_detail_id;
    this.clientID = overpayment.client_id;
    this.paymentDetailID = overpayment.payment_detail_id;
    this.getReceivableHistory(this.overpaymentId);
    this.receivable_detail_id = overpayment.receivable_detail_id;
    this.intakeserviceid = overpayment.intakeserviceid;
    this.routingstatustypeIdFn(overpayment);
    this.selectedOverPayment = overpayment;
    this.initFormGroup();
    this.overpaymentsForm.patchValue(overpayment);
    this.isApproved = (overpayment.write_off_approval_status === '3047');
    this.isPendingWithSupervisor = (this.activeModule === this.financeapproval && (overpayment.write_off_approval_status === '3045'));

    if (this.activeModule === 'Finance' && ['3045', '3047'].includes(overpayment.write_off_approval_status)) {
      this.overpaymentsForm?.get('receivable_status_cd')?.disable();
    }
  
    this.initialBalance = parseFloat(this.overpaymentsForm?.get('receivable_balance_no')?.value ? this.overpaymentsForm?.get('receivable_balance_no')?.value : 0);
    this.editOverPaymentFinanceApprovalFn(overpayment);
    const arStatusBal = ['19, 21, 22'];
    if (this.initialBalance) {
      this.arStatus =  this.arStatus.filter(status => status.picklist_value_cd !== '20');
    } else {
      this.arStatus =  this.arStatus.filter(status => {
        return ( arStatusBal.indexOf(status.picklist_value_cd) > -1);
      });
    }
    this.prevWriteOffAmount = overpayment.written_off_amount_no;
    this.overpaymentsForm?.get('writeOffAmount')?.setValue(overpayment.written_off_amount_no);
    this.approveStatus = overpayment.status_cd;
    if (this.activeModule === this.financeapproval && overpayment.write_off_approval_status === '3045' && overpayment.receivable_status_cd === '20') {
      this.overpaymentsForm.patchValue({ receivable_status_cd: '21'});
      this.onARStatusChange('21');
    } else { this.onARStatusChange(overpayment.receivable_status_cd); }
    this.editFnReceivableStatusCdFn(overpayment);
    this.editOverpaymentValidators(overpayment);
    this.ifIsFWFn(overpayment);
  }

  private editOverpaymentValidators(overpayment: any){
    setTimeout(() => {
      this.overpaymentsForm.patchValue({
        written_off_request_amount_no: this.returnRequestAmountNoFn(overpayment),
        writeOffAmount: this.returnWriteOffAmountFn(overpayment)
      });
      this.overpaymentsForm?.get('writeOffAmount')?.setValidators(Validators.required);
      this.overpaymentsForm?.get('receivable_status_cd')?.enable();
      this.overpaymentsForm?.get('collection_status_cd')?.enable();
      this.overpaymentsForm?.get('written_off_request_amount_no')?.disable();
      if (this.initialBalance === 0) {
        this.overpaymentsForm?.get('receivable_status_cd')?.disable();
      }
      if (this.activeModule === this.financeapproval) {
        this.overpaymentsForm?.get('writeOffAmount')?.disable();
        this.overpaymentsForm?.get('receivable_status_cd')?.disable(); //CIDM-9406 - (additional requirement) Supervisors cannot edit AR Status
      }
    }, 100);
  }
  // Associated with editOverPayment function
  private ifIsFWFn(overpayment: any) {
    if (this.isFW && overpayment.routingstatustypeid === 75) {
      this.is_resend = true;
      this.approveTxt = 'Resend for approval';
      this.manualpaymentsForm.patchValue(overpayment);
      this.manualpaymentsForm.disable();
      this.manualpaymentsForm?.get('amount_no')?.enable();
      this.manualpaymentsForm?.get('comments_tx')?.enable();
      this.manualpaymentsForm?.get('notes_tx')?.enable();
      (<any>$(this.manualpaymentdetailspopupid)).modal('show');
    } else {
      (<any>$(this.overpaymentdetailspopupid)).modal('show');
    }
  }
  // Associated with editOverPayment function
  private returnWriteOffAmountFn(overpayment: any): any {
    let writeOffAmt = Number(overpayment.receivable_balance_no) > 0 ? overpayment.receivable_balance_no : '0.00';
    return overpayment.written_off_amount_no ? overpayment.written_off_amount_no : writeOffAmt;
  }
  // Associated with editOverPayment function
  private returnRequestAmountNoFn(overpayment: any): any {
    return overpayment.written_off_request_amount_no ? overpayment.written_off_request_amount_no : '0.00';
  }
  // Associated with editOverPayment function
  private editFnReceivableStatusCdFn(overpayment: any) {
    if (this.activeModule === 'Finance' && (overpayment.receivable_status === 'Approved' || overpayment.receivable_status === 'Denied') && overpayment.receivable_status_cd == '21') {
      if (this.arStatus && !this.arStatus.find(ele => ele.picklist_value_cd == '22')) {
        this.arStatus.push(this.arStatusOriginal.find(ele => ele.picklist_value_cd == '22'));
      }
      this.overpaymentsForm.patchValue({
        receivable_status_cd: '22'
      });
      this.onARStatusChange('22');
    }
  }
  // Associated with editOverPayment function
  private editOverPaymentFinanceApprovalFn(overpayment: any) {
    if (this.activeModule === this.financeapproval) {
      if (overpayment.receivable_status_cd === '22') {
        this.arstatus = 'Write-Off';
        this.overpaymentsForm.patchValue({
          receivable_status_cd: (this.initialBalance) ? '21' : '20',
        });
      }
    } else {
      this.overpaymentsForm.patchValue({
        receivable_status_cd: (this.initialBalance) ? overpayment.receivable_status_cd : '20',
      });
      this.arstatus = overpayment.arstatus;
    }
  }
  // Associated with editOverPayment function
  private routingstatustypeIdFn(overpayment: any) {
    if (overpayment.routingstatustypeid === 73) {
      this.buttonVisible = true;
    } else {
      this.buttonVisible = false;
      this.getPaymentMethod();
    }
    if (this.userProfile.user.securityusersid === overpayment.writeoffassigneduser) {
      this.assignedUser = true;
    } else {
      if (overpayment.receivable_status === 'Pending') {
        this.overpaymentsForm.disable();
      }
      this.assignedUser = false;
    }
    if (this.userProfile.user.securityusersid === overpayment.manualassigneduser) {
      this.manualassignedUser = true;
    } else {
      if (overpayment.receivable_status === 'Pending') {
        this.overpaymentsForm.disable();
      }
      this.manualassignedUser = false;
    }
  }

  addManual() {
    this.manualpaymentsForm.disable();
    this.disablePaymentSave = false;
    this.is_resend = false;
    this.approveTxt = 'send for approval';
  }

  updateOverPayments() {
    this.isButtonClicked = true;
    if (this.userProfile.user.userprofile.primarycountycd !== '3824' && 
        (this.selectedOverPayment && this.selectedOverPayment.county_cd && this.userProfile.user.userprofile.primarycountycd !== this.selectedOverPayment.county_cd)
        ) {
      this._alertService.error(this.editnotallowednotifymsg);
      return
    }
    const overpayment = this.overpaymentsForm.getRawValue();
    if (this.activeModule === this.financeapproval && overpayment.receivable_status_cd === '21') {
      overpayment.eventcode = 'FNSWO';
      overpayment.write_off_approval_status = '3047';
      overpayment.write_off_action_date = moment().format(this.dtformat);
    } else if (this.activeModule === 'Finance' && overpayment.receivable_status_cd !== '21' && overpayment.receivable_status_cd !== '22') {
      delete overpayment.write_off_action_date;
      delete overpayment.write_off_approval_status;
    }

    overpayment.payment_id = this.selectedOverPayment.payment_id;
    overpayment.update_ts = moment(new Date());

    overpayment.receivable_balance_amount = parseFloat(this.isWriteOff ? overpayment.writeOffAmount : overpayment.receivable_balance_no);
    overpayment.provider_id = this._providerService.providerid;
    if (overpayment.receivable_balance_amount <= parseFloat(this.selectedOverPayment.receivable_balance_no)) {
      delete overpayment.receivable_balance_no;
      this._commonHttpService.patch(this.selectedOverPayment.receivable_detail_id, overpayment, FinanceUrlConfig.EndPoint.accountsReceivable.overpayments.update)
        .subscribe(res => {
          const message = this.updateOverPaymentsActiveModuleFn();
          this._alertService.success(message);
          this.isButtonClicked = false;
          (<any>$(this.overpaymentdetailspopupid)).modal('hide');
          this.getOverPayments();
        });
    } else {
      this.isButtonClicked = false;
      this._alertService.warn(this.balancenotifymsg);
    }
  }
  // Assosiated to updateOverPayments method
  private updateOverPaymentsActiveModuleFn() {
    let message = '';
    if (this.activeModule === 'Finance') {
      message = (this.buttonText === this.updateoverpayments)
        ? this.overpaymentupdatenotifymsg : 'Write off send for approval';
    } else if (this.activeModule === this.financeapproval) {
      message = (this.buttonText === this.updateoverpayments)
        ? this.overpaymentupdatenotifymsg : 'Write off approved Successfully';
    }
    return message;
  }

  public assignUser() {
    this.disableAssignButton = true;
    const overpayment = this.overpaymentsForm.getRawValue();
    if (this.activeModule === 'Finance' && overpayment.receivable_status_cd === '22') {
      overpayment.eventcode = 'FNSWO';
      overpayment.write_off_approval_status = '3045';
      overpayment.write_off_request_date = moment().format(this.dtformat);
      overpayment.assignedtoid = this.assignedTo;
    }
    overpayment.update_ts = moment(new Date());
    overpayment.payment_id = this.selectedOverPayment.payment_id;
    overpayment.receivable_balance_amount = parseFloat(this.isWriteOff ? overpayment.writeOffAmount : overpayment.receivable_balance_no);
    overpayment.provider_id = this._providerService.providerid;
    if (overpayment.receivable_balance_amount <= parseFloat(this.selectedOverPayment.receivable_balance_no)) {
      delete overpayment.receivable_balance_no;
      this._commonHttpService.patch(this.selectedOverPayment.receivable_detail_id, overpayment, FinanceUrlConfig.EndPoint.accountsReceivable.overpayments.update)
        .subscribe(res => {
          const message = (this.buttonText === this.updateoverpayments)
            ? this.overpaymentupdatenotifymsg : 'Write off sent for approval';
          this._alertService.success(message);
          this.isButtonClicked = false;
          this.disableAssignButton = false;
          (<any>$(this.paymentapprovalopoupid)).modal('hide');
          this.getOverPayments();
        });
    } else {
      this.isButtonClicked = false;
      this.disableAssignButton = false;
      this._alertService.warn(this.balancenotifymsg);
    }
  }

  selectPerson(row: any) {
    if (row) {
      this.selectedPerson = row;
      this.assignedTo = row.userid;
      this.disableAssignButton = false;
    }
  }

  getRoutingUser(type: string) {
    this.mandatoryField=true;
    this.isButtonClicked = true;
    this.disableAssignButton = true;
    if (type === 'overPayment') {
      const overpayment = this.overpaymentsForm.getRawValue();
      this.overPayment = true;
      if (overpayment.receivable_balance_no < parseFloat(overpayment.writeOffAmount)) {
        this._alertService.warn(this.balancenotifymsg);
        this.isButtonClicked = false;
        return false;
      }
      (<any>$(this.overpaymentdetailspopupid)).modal('hide');
      (<any>$(this.paymentapprovalopoupid)).modal('show');
    } else {
      this.manualpaymentsForm.markAllAsTouched();
      if(this.manualpaymentsForm.invalid){
        return;
      }
      const manualpaymentsForm = this.manualpaymentsForm.getRawValue();
      if (!manualpaymentsForm.amount_no || manualpaymentsForm.amount_no == '0.00') {
        this._alertService.warn('Please enter Overpayment Amount');
        this.isButtonClicked = false;
        return false;
      }
      this.overPayment = false;
      (<any>$(this.manualpaymentdetailspopupid)).modal('hide');
      (<any>$(this.paymentapprovalopoupid)).modal('show');
    }
    this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'FNSWO' },
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe((result) => {
        this.setUserList(result);
      });
  }

  listUser(assigned: string) {
    this.getUsersList = [];
    this.getUsersList = this.originalUserList;
    if (assigned === 'TOBEASSIGNED') {
      this.getUsersList = this.getUsersList.filter((res) => {
        if (res.userid !== this.token.user.securityusersid) {
          return res;
        }
      });
    }
  }

  checkDec(el: any) {
    if (el.target.value !== '') {
      const resultValue = isNaN(el.target.value) ? '' : el.target.value.replace(/[^0-9.]{0,2}/g, '');
      el.target.value = resultValue ? resultValue : '';
      return el.target.value; 
    }
    return '';
  }

  selectPaymentDetails() {
    (<any>$(this.manualpaymentdetailspopupid)).modal('hide');
    this.getPaymentMethod();
    let countycd = (this.userProfile && this.userProfile.user && this.userProfile.user.userprofile && this.userProfile.user.userprofile.primarycountycd !== '3824') ? this.userProfile.user.userprofile.primarycountycd : null;
      this._commonHttpService.getPagedArrayList(
        new PaginationRequest({
          where: {
            providerid: this._providerService.providerid,
            countycd: countycd
          },
          limit: this.pageInfo.pageSize,
          page: this.pageInfo.pageNumber,
          method: 'get'
      }), 'tb_payment_header/getpaymentdetail' + '?filter'
      ).subscribe(response => {
        this.selectedPayment = response.data;
        for(let payment of this.selectedPayment){
          payment.payment_date = this._commonDropdownService.getValidDate(payment.payment_date);
          payment.final_service_start_dt = this._commonDropdownService.getValidDate(payment.final_service_start_dt);
          payment.final_service_end_dt = this._commonDropdownService.getValidDate(payment.final_service_end_dt);
        }

        this.totalpagecount = (this.selectedPayment && this.selectedPayment.length > 0) ? this.selectedPayment[0].totalcount : 0;
      });
  }

  pageNumberChanged(page: number) {
    this.pageInfo.pageNumber = page;
    this.selectPaymentDetails();
  }

  selectOriginalPayment(payment: any) {
    this.intakeserviceid = payment.intakeserviceid;
    this.paymentDetailID = payment.payment_detail_id;
    this.receivableType = payment.receivable_type;
    this.selectedOriginalPayment = payment;
    this.manualpaymentsForm.patchValue(payment);
    this.manualpaymentsForm.patchValue({
      receivable_status_cd: payment.arstatus,
      collection_status_cd: payment.colletion_status,
      receivable_balance_no: '0.00'
    });
    this.manualpaymentsForm.disable();
    this.manualpaymentsForm?.get('start_dt')?.enable();
    this.manualpaymentsForm?.get('end_dt')?.enable();
    this.manualpaymentsForm?.get('amount_no')?.enable();
    this.manualpaymentsForm?.get('comments_tx')?.enable();
    this.manualpaymentsForm?.get('notes_tx')?.enable();

  }

  getPaymentMethod() {
    this.paymentMethod$ = this._commonHttpService.getArrayList({
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

  getRoutingForManualUser() {
    this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'FNSWO' },
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe((result) => {
        this.setUserList(result);
      });
  }

  setUserList(result: any){
    this.getUsersList = result.data;
    this.originalUserList = this.getUsersList;
    this.listUser('TOBEASSIGNED');
  }

  paymentAmount(event: any) {
    const amount:any =event.target.value;
    if (parseFloat(amount) > this.manualpaymentsForm?.get('payment_amount')?.value) {
      this._alertService.warn('Not allowed to send approve more than the payment amount');
      this.manualpaymentsForm?.get('amount_no')?.reset();
      return false;
    } else {
      this.manualpaymentsForm.patchValue({
        amount_no: _.toNumber(amount).toFixed(2),
        receivable_balance_no: _.toNumber(amount).toFixed(2)
      });
    }
  }

  manualPaymentApproval(type: string) {
    this.disableAssignButton = true;
    this.isButtonClicked = true;
    if (this.userProfile.user.userprofile.primarycountycd !== '3824' && 
        (this.selectedOverPayment && this.selectedOverPayment.county_cd && this.userProfile.user.userprofile.primarycountycd !== this.selectedOverPayment.county_cd)
        ) {
      this._alertService.error(this.editnotallowednotifymsg);
      return
    }
    if (type === 'approve') {
      if (this.activeModule === this.financeapproval) {
        this.manualOverPayment = this.overpaymentsForm.getRawValue();
        this._commonHttpService.endpointUrl = FinanceUrlConfig.EndPoint.accountsReceivable.manualOverPayment.approve;
        this.manualOverPayment.status = 74;
        this.manualOverPayment.receivable_detail_id = this.receivable_detail_id;
        this.alertTxt = 'Manual AR request Approved successfully!';
      } else {
        this.manualOverPayment = this.manualpaymentsForm.getRawValue();
        this._commonHttpService.endpointUrl = FinanceUrlConfig.EndPoint.accountsReceivable.manualOverPayment.request;
        this.manualOverPayment.status = 73;
        this.alertTxt = 'Manual AR Approval Request sent successfully!';
      }
    } else {
      if (this.activeModule === this.financeapproval) {
        // Reject - Manual Payment
        this.manualOverPayment = this.overpaymentsForm.getRawValue();
        this._commonHttpService.endpointUrl = FinanceUrlConfig.EndPoint.accountsReceivable.manualOverPayment.approve;
        this.manualOverPayment.status = 75;
        this.manualOverPayment.receivable_detail_id = this.receivable_detail_id;
        this.alertTxt = 'Manual Payment request Denied successfully!';
      }
    }
    if (this.is_resend) {
      this.manualOverPayment.receivable_detail_id = this.receivable_detail_id;
    }
    this.manualOverPayment.is_resend = this.is_resend;
    this.manualOverPayment.balance_no = this.manualOverPayment.amount_no;
    this.manualOverPayment.receivable_balance_no = this.manualOverPayment.amount_no;
    this.manualOverPayment.eventcode = 'MANREC';
    this.manualOverPayment.intakeserviceid = this.intakeserviceid;
    this.manualOverPayment.assignedtoid = this.assignedTo;
    this.manualOverPayment.provider_id = this._providerService.providerid;
    this.manualOverPayment.payment_detail_id = this.paymentDetailID;
    this.manualOverPayment.receivable_type = this.receivableType;
    this._commonHttpService.create(this.manualOverPayment).subscribe(
      (response:any) => {
        this.disableAssignButton = false;
        this.isButtonClicked = false;
        (<any>$(this.paymentapprovalopoupid)).modal('hide');
        (<any>$(this.overpaymentdetailspopupid)).modal('hide');
        this.getOverPayments();
        this._alertService.success(this.alertTxt);
        this.clearManualForm();
      },
      (error) => {
        this.disableAssignButton = false;
        this.isButtonClicked = false;
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  clearManualForm() {
    this.manualpaymentsForm.reset();
  }

  getManualStatus(statuskey: number) {
    if (statuskey) {
      if (statuskey === 73) {
        return 'Pending';
      } else if (statuskey === 74) {
        return 'Approved';
      } else if (statuskey === 75) {
        return 'Denied';
      } else {
        return null;
      }
    } else {
      return null;
    }

  }

  getManualStatus1(statuskey: string) {
    if (statuskey) {
      if (statuskey === '3045' ) {
        return 'Pending';
      } else if (statuskey === '3047') {
        return 'Approved';
      } else if (statuskey === '3281' ) {
        return 'Denied';
      } else if (statuskey === '6550' ) {
        return 'Closed';
     } else if (statuskey === '3046' ) {
        return 'Un-Requested';
    } else {
      return null;
    }
  }
}

  // Validation of Manual payment Start date and end date
  addManualPaymentDays(){
    if (this.manualpaymentsForm.getRawValue().start_dt !== null &&
        this.manualpaymentsForm.getRawValue().end_dt !== null &&
        (this.manualpaymentsForm.getRawValue().end_dt < this.manualpaymentsForm.getRawValue().start_dt)) {
            this._alertService.error('From date should not  be greater than To date');
            this.manualpaymentsForm.controls['end_dt'].setValue('');
    }
  }

  rejectOverPayments() {
    this.isButtonClicked = true;
    if (this.userProfile.user.userprofile.primarycountycd !== '3824' && 
        (this.selectedOverPayment && this.selectedOverPayment.county_cd && this.userProfile.user.userprofile.primarycountycd !== this.selectedOverPayment.county_cd)
        ) {
      this._alertService.error(this.editnotallowednotifymsg);
      return
    }
    const overpayment = this.overpaymentsForm.getRawValue();
    overpayment.eventcode = 'FNSWO';
    overpayment.write_off_approval_status = '3281';
    overpayment.write_off_action_date = moment().format(this.dtformat);
    overpayment.write_off_request_date = moment().format(this.dtformat);
    overpayment.payment_id = this.selectedOverPayment.payment_id;
    overpayment.update_ts = moment(new Date());
    overpayment.receivable_balance_amount = parseFloat(this.isWriteOff ? overpayment.writeOffAmount : overpayment.receivable_balance_no);
    overpayment.provider_id = this._providerService.providerid;
    delete overpayment.receivable_balance_no;
    this._commonHttpService.patch(this.selectedOverPayment.receivable_detail_id, overpayment, FinanceUrlConfig.EndPoint.accountsReceivable.overpayments.update)
        .subscribe(res => {
          this._alertService.success('Write off Denied Successfully');
          this.isButtonClicked = false;
          (<any>$(this.overpaymentdetailspopupid)).modal('hide');
          this.getOverPayments();
       });
  }

  getReceivableHistory(receivableDetailid: any) {
    this.receivableHistoryList =[];
    this._commonHttpService.getPagedArrayList({
      where: {
        receivable_detail_id: receivableDetailid
      },
      page: 1,
      limit: 10,
      method: 'get'
    }, 'tb_receivable_detail/list?filter').subscribe((res: any) => {
      if (res && res.data && res.data.length) {
        this.receivableHistoryList = res.data;

      }
    });
  }

  nofticationDetails() {
    this.receivableColletionStatusList =[];
    this._commonHttpService.getPagedArrayList({
      where: {
        receivable_detail_id: this.overpaymentId
      },
      method: 'get'
    }, 'tb_receivable_detail/receivableColletionStatusList?filter').subscribe((res: any) => {
      if (res && res.data && res.data.length) {
        this.receivableColletionStatusList = res.data;

      }
    });
  }

  uploadFile(file: any, overpayment: any): void {
    if (!(file instanceof Array)) {
      this._alertService.error('Invalid File!');
    } else {
      this.restitutionupload = file;
      this.upload(overpayment);
    }
  }

  private upload(overpayment: any) {
    let uploadUrl = '';
   
      uploadUrl= AppConfig.baseUrl + '/' + CommonUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + '&' + 'docsInfo=Document|CW-Finance|CW-Finance-Receipt'+ '&attachmenttype=Client' + '&additionalobjectid=' + overpayment.client_id
    
    this._uploadService
      .upload({
        url: uploadUrl,
        headers: new HttpHeaders().set('ctype', 'file'),
        filesKey: ['file'],
        files: this.restitutionupload,
        process: true
      })
      .subscribe(
        (response:any) => {
          if (response.status === 1 && response.data) {
            this.restitutionuploadedFile = response.data;
            this.uploadDocumnet(overpayment, this.restitutionuploadedFile);
          }
        },
        (err) => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
  }

  private uploadDocumnet(overpayment: any, uploadfile: any) {
    const data ={
      "providerid": this._providerService.providerid,
      "receivableid": overpayment.receivable_id,
      "receivabledetailid": overpayment.receivable_detail_id,
      "receivablebalance": overpayment.receivable_balance_no,
      "collectionstatus": overpayment.collection_status,
      "uploadpath":uploadfile.s3bucketpathname,
      "filename":uploadfile.originalfilename,
      "ecmsdocumentid":uploadfile.ecmsdocumentid
    }
    this._commonHttpService.create(data, 'accountreceivabledocuments/addupdate').subscribe((res: any) => {
      if (res) {
        this._alertService.success('File Uploaded Succesfully');

      }
    });
  }

  downloadStautsDocumentPDF (key: string) {
    let notice_type;
    if (key === 'Notice 1 Sent') {
      notice_type = '1';
    } else if (key === 'Notice 2 Sent') {
      notice_type = '2';
    }  else if (key === 'Notice 3 Sent') {
      notice_type = '3';
    } else {
      notice_type = key;
    }
    const modal = {
      "count": -1,
      "where": {
          "documenttemplatekey": [
              "overpaymentnotice"
          ],
          "provider_id": this._providerService.providerid,
          "receivable_detail_id": this.overpaymentId,
          "notice_type": notice_type,
          "format": 'PDF'
      },
      "method": "post"
    };
    this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
    .subscribe((result) => {
      const blob = new Blob([new Uint8Array(result)]);
      FileSaver.saveAs(blob,  key+'.pdf');
    });
  }

  downloadStautsDocument (key: string) {
    let notice_type;
    if (key === 'Notice 1 Sent') {
      notice_type = '1';
    } else if (key === 'Notice 2 Sent') {
      notice_type = '2';
    }  else if (key ==='Notice 3 Sent') {
      notice_type = '3';
    } else {
      notice_type = key;
    }
    const modal = {
      "count": -1,
      "where": {
          "documenttemplatekey": [
              "overpaymentnotice"
          ],
          "provider_id": this._providerService.providerid,
          "receivable_detail_id": this.overpaymentId,
          "notice_type": notice_type,
          "format": 'DOCX'
      },
      "method": "post"
    };
    this.http.download('evaluationdocument/generateintakedocument', modal, {}, 'buffer')
    .subscribe((result) => {
      const blob = new Blob([new Uint8Array(JSON.parse(result).data[0].data)]);
      FileSaver.saveAs(blob,  key+'.docx');
    });
  }
}