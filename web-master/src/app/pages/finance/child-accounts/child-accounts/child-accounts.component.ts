
import {of as observableOf,  Observable } from 'rxjs';

import {map} from 'rxjs/operators';
import { Component, OnInit, AfterContentInit, Injector, ChangeDetectorRef, ChangeDetectionStrategy, SimpleChanges, OnChanges } from '@angular/core';
import { FinanceUrlConfig } from '../../finance.url.config';
import { CommonHttpService, AlertService, AuthService, DataStoreService,CommonDropdownsService } from '../../../../@core/services';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { FileUtils } from '../../../../@core/common/file-utils';
import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { SessionStorageService } from '../../../../@core/services/storage.service';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { FinalDisturbance } from '../../_entities/finance-entity.module';
import { ActivatedRoute } from '@angular/router';
import moment from 'moment';
import { HttpClient } from '@angular/common/http';
import { AppConfig } from '../../../../app.config';
import { AccountDisbursement } from '../../finance.constants';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'child-accounts-tab',
    templateUrl: './child-accounts.component.html',
    styleUrls: ['./child-accounts.component.scss'],    
    changeDetection: ChangeDetectionStrategy.OnPush,
    standalone: false
})
export class ChildAccountsTabComponent implements OnInit, AfterContentInit {
  childAccountsList: any[] = [];
  childDetails: any[]=[];
  format:string='';
  selectedAccount: any;
  accountForm!: FormGroup;
  editAccountForm!: FormGroup;
  childReportForm!: FormGroup;
  childId: any;
  clientName: any;
  accountExistOptions = [
    { text: 'Yes', value: 'Y' },
    { text: 'No', value: 'N' },
  ];
  accountType: any[]=[];
  accountStatus: any[]=[];
  localDept: any[]=[];
  commingledAccountLists: any[]=[];
  totalRecords = 0;
  paginationInfo: PaginationInfo = new PaginationInfo();
  isExists: boolean=false;
  accountId: any;
  disableAccount: boolean=false;
  finalDisbursementForm!: FormGroup;
  clientId: any;
  fundingStatus: any;
  paymentStatus: any;
  isApprovalSent!: number;
  selectedPerson: any;
  assignedTo: any;
  getUsersList: any[]=[];
  originalUserList: any[]=[];
  userProfile!: AppUser;
  finalDisbursementData!: FinalDisturbance;
  status!: number;
  taxIDType$!: Observable<DropdownModel[]>;
  paymentId!: number;
  isPaymentView:boolean=false;
  disableApprove:boolean=false;
  url: string='';
  paymentType$!: Observable<DropdownModel[]>;
  paymentMethod$!: Observable<DropdownModel[]>;
  reportCk:string=' ';
  alertText:string=' ';
  disbursementDt: any;
  payment_id: any;
  client_name: any;
  client_id: any;
  client_account: any;
  client_account_id: any;
  intakeserviceid: any;
  searchClientID: any;
  servicerequest:boolean=false;
  approveTxt:string=' ';
  rejectDis:boolean=false;
  stateList$!: Observable<DropdownModel[]>;
  countyList$!: Observable<DropdownModel[]>;
  serviceList$!: Observable<DropdownModel[]>;
  serviceList!: DropdownModel[];
  accountClosed: boolean=false;
  disbursementTxt: string='';
  routeTxt: string='';
  reportEnable: boolean=false;
  paymentType: any[]=[];
  comAccount: any;
  clientAccountId: any;
  localDepartment: any;
  childNameList: any;
  disbursement_id: string='';
  reason_tx: any;
  editStatus: string='';
  totalClientRecords: any='';
  selectedClientDetails: any='';
  toggleId: any;
  searchString: string='';
  searchByClientId: string='';
  searchByClientName: string='';
  selectedRow: any;
  account_no_tx: any;
  closeStatus = true;
  client_sw: string='';
  minDate:Date=new Date();
  baseUrl: string='';
  fundingParams: any='';
  disbursementHistory: any[] = [];
  totalPage!: number;
  pageInfo: PaginationInfo = new PaginationInfo();
  rejectType: string='';
  requested_by: any;
  assigned_to: any;
  reDirect:boolean=false;
  childAccountsDisplay: any;
  pageChange:boolean=false;
  maxDate:Date=new Date();
  sortedData: any;
  isSsnHidden = true;
  ssnEye = 'fa-eye';
  showSsnMask :boolean= true;
  user!: AppUser;
  userName:string='';
  maxOpenDate:Date=new Date();
  alertMsg:string=' ';
  childAccountPage: any;
  selectedClient: any;
  selectedDept: any;
  selectedDeptName: any;
  disbursementValidation: any;
  isdisableButton:boolean=false;
  clientLastName: any;
  clientFirstName: any;
  searchByClientLastName: any;
  finalDisbursementFlag : boolean = false;
  showBusy:boolean=false;
  activeModule: any;
  caseCountyCode: any;
  isCountMismatch:boolean=false;
  isVissbleButton:boolean=false;
  isCommitmentStateCounty: boolean = false;
  checkformandatory: boolean =false;
  checkforrequired: boolean =false;
  isSupervisor:boolean=false;

  public _sessionStorage: SessionStorageService;
  private _commonService: CommonHttpService;
  private _alertService: AlertService;
  private formBuilder: FormBuilder;
  public _authService: AuthService;
  private _route: ActivatedRoute;
  private http: HttpClient;
  public cdr: ChangeDetectorRef;

  constructor(private readonly injector : Injector, private _datastoreService: DataStoreService, private _commonDropDownService: CommonDropdownsService) {
    this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.http = this.injector.get<HttpClient>(HttpClient);
    this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);

    this.baseUrl = AppConfig.baseUrl;
  }
  dtformat = 'YYYY-MM-DD';
  validationmsg = 'Close Date should be greater than or equal to Open Date';
  finaldisbursementpopupid = '#final-disbursement';
  finaldisbursement = 'Final Disbursement';
  otherdisbursement = 'Other Disbursement';
  finaldisbursementapprovalpopupid = '#final-disbursement-approval';
  ngOnInit() {
    this.isVissbleButton = this._authService.isVissbleButton('read_only_access', '');
    if(this._authService.getCurrentUser()?.user?.userprofile?.primarycountycd === '3827'){
      this.isCommitmentStateCounty = true;
    }
    this.pageChange = false;
    this.paginationInfo.sortColumn = 'paymentid';
    this.paginationInfo.sortBy = 'desc';
    this.maxOpenDate = new Date();
    this.user = this._authService.getCurrentUser();
    if (this.user &&  this.user.user && this.user.user.userprofile) {
      this.userName = this.user.user.userprofile.fullname;
    }
    this.searchClientID = this._route.snapshot.params['id'];
    if (this.selectedDept) {
      this.selectedDept = this._datastoreService.getData('selectedFinanceDept');
    }
    this.getDropdown();
    this.initAccountForm();
    this.initEditAccountForm();
    this.buildFinalDisbursementForm();
    this.childReport();
    if (this.searchClientID) {
      this._datastoreService.currentStore.subscribe((store :any)=> {
        this.fundingParams = store[AccountDisbursement.FundingParms];
      });
      this.childId = this.searchClientID;
      this._sessionStorage.setItem('searchByClientId', this.searchByClientId);
      this.getchilddetailslist('clientId', true);
      this.reDirect = true;
    } else {
      this.searchClientIDElseConditionFn();
      this.selectedRow = (this._sessionStorage.getObj('selectedClientId')) ? this._sessionStorage.getObj('selectedClientId') : '';
    }
    this.editStatus = 'Update';
    this.getLocalDept();
    this.ac_validator();
    this.userProfile = this._authService.getCurrentUser();
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Finance') {
      this.rejectDis = true;
      this.routeTxt = 'Route Disbursement to Supervisor Approval';
    } else {
      if (this.activeModule === 'Finance Approval') {
        this.isVissbleButton = true;
      }
      this.approveTxt = 'Approve';
      this.rejectDis = false;
      this.routeTxt = 'Route Disbursement to Payment Approval';
    }
    this.getTaxIdType();
    this.getPaymentMethod();
    this.getPaymentType();
    this.getState();
    this.getService();
  }
  // Associated with ngOnInit function
  private searchClientIDElseConditionFn() {
    this.reDirect = false;
    let searchByClientId = this._sessionStorage.getItem('searchByClientId') === 'all' ? null : this._sessionStorage.getItem('searchByClientId');
    let searchByClientFirstName = this._sessionStorage.getItem('searchByClientFirstName') === 'all' ? null : this._sessionStorage.getItem('searchByClientFirstName');
    let searchByClientLastName = this._sessionStorage.getItem('searchByClientLastName') === 'all' ? null : this._sessionStorage.getItem('searchByClientLastName');
    this.childId = this._sessionStorage.getItem('searchByClientId') ? searchByClientId : null;
    this.clientFirstName = this._sessionStorage.getItem('searchByClientFirstName') ? searchByClientFirstName : null;
    this.clientLastName = this._sessionStorage.getItem('searchByClientLastName') ? searchByClientLastName : null;
    if (this._sessionStorage.getItem('searchByClientId')) {
      this.getchilddetailslist('clientId', false);
    } else if (this._sessionStorage.getItem('searchByClientFirstName') || this._sessionStorage.getItem('searchByClientLastName')) {
      this.getchilddetailslist('clientName', false);
    }
  }

  ngAfterContentInit(): void {
    // No data or function to call or add
  }
  buildFinalDisbursementForm() {
    this.finalDisbursementForm = this.formBuilder.group({
      service_id: [null],
      payee_nm: [null, Validators.required],
      tax_id_no: [null],
      address: [null],
      disbursement_id: [null],
      amount: [null],
      tax_type_cd: [null],
      payment_method_cd: [null],
      type_1099_cd: [null],
      fiscal_category_cd: [null],
      report_1099_sw: [null],
      adr_street_no: [null],
      adr_street_nm: [null, Validators.required],
      adr_city_nm: [null, Validators.required],
      adr_county_cd: [null],
      adr_state_cd: [null, Validators.required],
      adr_zip5_no: [null, Validators.required],
      adr_zip4_no: [null]
    });
  }

  initAccountForm() {
    this.accountForm = this.formBuilder.group({
      open_dt: [{ value: '' }, Validators.required],
      close_dt: [{ value: '', disabled: true }],
      account_type_cd: ['', Validators.required],
      bank_nm: ['', Validators.required],
      comm_account_id: [''],
      status_cd: [{ value: '592', disabled: true }, Validators.required],
      local_dept: [{ value: '', disabled: true }, Validators.required],
      account_exist: [''],
      account_no_tx: ['', Validators.required]
    });
  }

  initEditAccountForm() {
    this.editAccountForm = this.formBuilder.group({
      open_dt: [{ value: '', disabled: true }, Validators.required],
      close_dt: [null],
      account_type_cd: [{ value: '', disabled: true }, Validators.required],
      bank_nm: [null],
      comm_account_id: [''],
      status_cd: ['', Validators.required],
      local_dept: [{ value: '', disabled: true }, Validators.required],
      // county_cd: ['', Validators.required],
      account_exist: [''],
      account_no_tx: [null],
      account_exists_sw: ['Y']
    });
  }

  childReport() {
    this.childReportForm = this.formBuilder.group({
      date_sw: ['Y'],
      date_from: [null],
      date_to: [null]
    });
  }


  getchilddetailslist(searchBy: string, searchType:any) {
    this.searchString = searchBy;
    if (searchType) {
      this._datastoreService.setData('childAccountPage', null);
      this._datastoreService.setData('clientSearch', null);
      this.paginationInfo.pageNumber = 1;
      if (searchBy === 'clientId') {
        this.clientFirstName = null;
        this.clientLastName = null;
        this.searchByClientId = (this.childId) ? this.childId : 'all';
        this._sessionStorage.setItem('searchByClientId', this.searchByClientId);
        this._sessionStorage.setItem('searchByClientFirstName', '');
        this._sessionStorage.setItem('searchByClientLastName', '');
        this.alertMsg = 'Please enter the Client Id';
      } else if (searchBy === 'clientName') {

        this.childId = null;
        if(!this.returnClientNameValue()){
          return false;
        }
        this._sessionStorage.setItem('searchByClientLastName', this.searchByClientLastName);
        this._sessionStorage.setItem('searchByClientFirstName', this.searchByClientFirstName);
        this._sessionStorage.setItem('searchByClientId', '');
        this.alertMsg = 'Please enter the Client Name';
      }
    } else {
      const Cid = this._datastoreService.getData('clientSearch');
      if (Cid) {
        this.clientFirstName = null;
        this.clientLastName = null;
        this.childId = Cid;
        this._sessionStorage.setItem('searchByClientId', Cid);
        this._sessionStorage.setItem('searchByClientFirstName', '');
        this._sessionStorage.setItem('searchByClientLastName', '');
      }
    }
    this.cdr.markForCheck();

    this.getchilddetailslistTempDataFn(searchType);
  }

  private getchilddetailslistTempDataFn(searchType: any) { 
    let tempClientId = this._sessionStorage.getItem('searchByClientId');
    let tempClientFirstName = this._sessionStorage.getItem('searchByClientFirstName');
    let tempClientLastName = this._sessionStorage.getItem('searchByClientLastName');

    tempClientId = this.returnTempClientIdFn(tempClientId);
    tempClientFirstName = this.returnTempClientFirstNameFn(tempClientFirstName);
    tempClientLastName = this.returnTempClientLastNameFn(tempClientLastName);

    if (searchType) {
      this._sessionStorage.setObj('selectedClientId', '');
      this._sessionStorage.setObj('selectedClientDetails', '');
      this.selectedRow = '';
    }
    if (tempClientId || tempClientLastName || tempClientFirstName) {
      this._commonService.getPagedArrayList(new PaginationRequest({
        where: {
          client_id: tempClientId, v_firstname: tempClientFirstName, v_lastname: tempClientLastName, sortcolumn: this.paginationInfo.sortColumn,
          sortorder: this.paginationInfo.sortBy
        },
        page: this.paginationInfo.pageNumber,
        limit: 5,
        method: 'get'
      }), FinanceUrlConfig.EndPoint.childAccounts.getchilddetailslistUrl + '?filter').subscribe((result:any) => {
        if (result && result.data && result.data.length > 0) {
          this.childDetails = result.data;
          this.sortedData = this.childDetails?.slice();
          this.totalClientRecords = result.count;
          this.selectedClientDetails = {};
          this.childAccountsList = [];
          this.totalRecords = 0;
        } else {
          this.childDetails = [];
          this.totalClientRecords = 0;
          this.childAccountsList = [];
          this.totalRecords = 0;
        }
        setTimeout(() => {
          
          this.toggleTable('accordion-tables0', 0, this.childDetails[0]);
          this.cdr.markForCheck();
        }, 100);
      });
    } else {
      this._alertService.warn(this.alertMsg);
    }
    
    this.cdr.detectChanges();
  }

  private returnTempClientLastNameFn(tempClientLastName: any): any {
    return !tempClientLastName || tempClientLastName === 'all' ? null : tempClientLastName;
  }

  private returnTempClientFirstNameFn(tempClientFirstName: any): any {
    return !tempClientFirstName || tempClientFirstName === 'all' ? null : tempClientFirstName;
  }

  private returnTempClientIdFn(tempClientId: any): any {
    return !tempClientId || tempClientId === 'all' ? null : tempClientId;
  }

  private returnClientNameValue() {
    this.searchByClientFirstName = (this.clientFirstName) ? this.clientFirstName : 'all';
    this.searchByClientLastName = (this.clientLastName) ? this.clientLastName : 'all';
    if (this.searchByClientFirstName.length < 3 || this.searchByClientLastName.length < 3) {
      this._alertService.warn('Please enter at least three characters on Client Name')
      return false;
    }
    return true;
  }

  searchByClientFirstName(arg0: string, searchByClientFirstName: any) {
    throw new Error("Method not implemented.");
  }


  toggleTable(id:any , index:number, client:any) {
    this.toggleId = id;
    $('.collapse.in').collapse('hide');
    $('#' + id).collapse('toggle');

    $('.client-details tr').removeClass('selected-bg');
    $(`#client-details-${index}`).addClass('selected-bg');
    this.selectedClientDetails = client;
    
    this._sessionStorage.setObj('selectedClientDetails', this.selectedClientDetails);
    if (client && client.client_id) {
      this.selectedClient = client.client_id;
      this._sessionStorage.setObj('selectedClientId', this.selectedClientDetails.client_id);
    }
    this._datastoreService.setData('clientSearch', this.selectedClient);
    this.getchildaccountslist();
    this.isCountMismatch = true;
    this.selectedClientDetails?.caseworker?.forEach((item:any) => {
      if(this.selectedDept == item.county_cd) {
        this.isCountMismatch = false;
      }
    });
    this.cdr.markForCheck();   
  }

  // selectClientId(client) {
  //   this.selectedClientDetails = client;
  //   this._sessionStorage.setObj('selectedClientId', this.selectedClientDetails.client_id);
  //   this._sessionStorage.setObj('selectedClientDetails', this.selectedClientDetails);
  //   this.getchildaccountslist();
  // }

  addChildAccount() {
    this.checkformandatory = true
    if (this.accountForm.valid) {
      if (!this.accountForm?.get('local_dept')?.value) {
        this._alertService.error('You have to be mapped with any county or local department');
        return false;
      }
      this.selectedClientDetails = (this._sessionStorage.getItem('selectedClientDetails')) ? JSON.parse(this._sessionStorage.getItem('selectedClientDetails')) : {};
      const data = this.accountForm?.getRawValue();

 

      if (this.accountForm?.getRawValue().open_dt && this.accountForm?.getRawValue().close_dt) {
        const openDate = moment(new Date(this.accountForm?.getRawValue().open_dt)).format(this.dtformat);
        const closeDate = moment(new Date(this.accountForm?.getRawValue().close_dt)).format(this.dtformat);
        if (new Date(openDate).getTime() > new Date(closeDate).getTime()) {
          this._alertService.error(this.validationmsg);
          return false;
        }
      }

      this._commonService.create(this.returnAddChildAccountDataFn(data)
        , FinanceUrlConfig.EndPoint.childAccounts.addChildAccountUrl).subscribe((result:any) => {
          this.addChildAccountUrlApiResponseFn(result);
        });
    } else {
      this._alertService.warn('Please fill the mandatory details.');
    }
  }
  // Associated with addChildAccount function
  private returnAddChildAccountDataFn(data: any): any {
    return {
      'client_id': this.selectedClientDetails.client_id,
      'account_type_cd': data.account_type_cd,
      'account_exists_sw': data.account_exist,
      'bank_nm': data.bank_nm,
      'account_no_tx': data.account_no_tx ? data.account_no_tx : FileUtils.generateAccountNumber(),
      // 'account_no_tx': data.account_no_tx?data.account_no_tx: .generateAccountNo(),
      'open_dt': (data.open_dt) ? data.open_dt : null,
      'close_dt': (data.close_dt) ? data.close_dt : null,
      'status_cd': data.status_cd,
      'county_cd': data.local_dept,
      'create_ts': new Date(),
      'update_ts': new Date(),
      'bank_info_approval_status_cd': null,
      'comm_account_id': data.comm_account_id ? data.comm_account_id : '',
      'case_id': this.selectedClientDetails.case_id,
      'data_valid_sw': null,
      'client_merge_id': null,
      'obligated_for_anc': null,
      'obligated_for_coc': null
    };
  }
  // Associated with addChildAccount function
  private addChildAccountUrlApiResponseFn(result: any) {
    if (result) {
      if (!result.insertstatus) {
        this._alertService.error('A Child already has the selected account type.');
      } else {
        this._alertService.success('Child Account added successfully');
        this.getchildaccountslist();
        $('#addNewAccount').modal('hide');
      }
    }
  }

  UpdateCase() {
    if (this.editAccountForm.valid) {
      this.selectedClientDetails = (this._sessionStorage.getItem('selectedClientDetails')) ? JSON.parse(this._sessionStorage.getItem('selectedClientDetails')) : {};
      const data = this.editAccountForm?.getRawValue();
      if (data.status_cd === '593' && !data.close_dt) {
        this._alertService.error('Please fill the Close date');
      } else {
        if(!this.returnUpdateCaseElseConditionFn(data)) {
          return false;
        }

        this._commonService.update(this.selectedAccount.client_account_id, this.returnUpdateCaseDataFn(data)
          , FinanceUrlConfig.EndPoint.childAccounts.updateAccountUrl).subscribe((result:any) => {
            if (result) {
              this._alertService.success('Child Account updated successfully');
              this.getchildaccountslist();
            }
            $('#editAccount').modal('hide');
          });
      }
    } else {
      this._alertService.warn('Please fill the mandatory details.');
    }

  }
  // Associated with UpdateCase function
  private returnUpdateCaseDataFn(data: any): any {
    return {
      'client_id': this.selectedClientDetails.client_id,
      'account_type_cd': data.account_type_cd,
      'account_exists_sw': data.account_exists_sw,
      'bank_nm': data.bank_nm,
      'account_no_tx': data.account_no_tx ? data.account_no_tx : FileUtils.generateAccountNumber(),
      'open_dt': (data.open_dt) ? data.open_dt : null,
      'close_dt': (data.close_dt) ? data.close_dt : null,
      'status_cd': data.status_cd,
      'county_cd': data.county_cd,
      'update_ts': new Date(),
      'bank_info_approval_status_cd': null,
      'comm_account_id': data.comm_account_id,
      'case_id': this.selectedClientDetails.case_id,
      'data_valid_sw': null,
      'client_merge_id': null,
      'obligated_for_anc': null,
      'obligated_for_coc': null,
      'total_balance_no': (this.selectedAccount && this.selectedAccount.total_balance_no) ? this.selectedAccount.total_balance_no : '0.00'
    };
  }
  // Associated with UpdateCase function
  private returnUpdateCaseElseConditionFn(data: any) {
    if (this.editAccountForm?.get('comm_account_id')?.enabled) {
      if (this.commingledAccountLists && this.commingledAccountLists.length === 0) {
        this._alertService.error('Please create commingled account to link with child account');
        return false;
      } else if (this.commingledAccountLists && this.commingledAccountLists.length > 0 && !data.comm_account_id) {
        this._alertService.error('Please select commingled account');
        return false;
      }
    }

    if (this.editAccountForm?.getRawValue().open_dt && this.editAccountForm?.getRawValue().close_dt) {
      const openDate = moment(new Date(this.editAccountForm?.getRawValue().open_dt)).format(this.dtformat);
      const closeDate = moment(new Date(this.editAccountForm?.getRawValue().close_dt)).format(this.dtformat);
      if (new Date(openDate).getTime() > new Date(closeDate).getTime()) {
        this._alertService.error(this.validationmsg);
        return false;
      }
    }
    return true;
  }

  getchildaccountslist(page = 1) {
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: { sortcolumn: this.paginationInfo.sortColumn,
        sortorder: this.paginationInfo.sortBy, client_id: (this._sessionStorage.getObj('selectedClientId')) ? this._sessionStorage.getObj('selectedClientId') : null,
        istransaction: false },
      page: this.pageInfo.pageNumber,
      limit: this.pageInfo.pageSize,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.getchildaccountslistUrl + '?filter').subscribe((result:any) => {
      this.handleChildAccountListNullValues(result.data);

      this.totalRecords = result.count;
      if (this.reDirect) {
        this.childAccountsDisplay = this.childAccountsList?.find(account => account?.account_no_tx === this.fundingParams?.account_no_tx);
        if (this.childAccountsDisplay) {
        this.linkDisbursement(this.childAccountsDisplay);
        this.cdr.markForCheck();
        }
      }
      $('#fc_list').click();
    });
  }

  handleChildAccountListNullValues(childAccountList:any){
    this.childAccountsList = childAccountList.map((account:any)=>{

      account.availcoc = account.availcoc ? Number(account.availcoc) : 0;
      account.obligated_for_ancillary = account.obligated_for_ancillary ? Number(account.obligated_for_ancillary) : 0;
      account.total_balance_no = account.total_balance_no ? Number(account.total_balance_no) : 0;
      return account;
    })
    this.cdr.markForCheck();
  }

  pageChanged(page:any) {
    this.pageInfo.pageNumber = page;
    this.getchildaccountslist(page);
  }

  pageClientChanged(page:any) {
    this.paginationInfo.pageNumber = page;
    this._datastoreService.setData('childAccountPage', page);
    this._datastoreService.setData('clientSearch', null);
    this.childAccountsList = [];
    this.pageChange = true;
    this.getchilddetailslist(this.searchString, false);
  }

getAccountType() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '40'
      },
      nolimit: true,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.pickListUrl).subscribe((result:any) => {
      this.accountType = result;
    });
  }

  getAccountStatus() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '41'
      },
      nolimit: true,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.pickListUrl).subscribe((result:any) => {
      this.accountStatus = result;
    });
  }

  getLocalDept() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '104'
      },
      nolimit: true,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.pickListUrl).subscribe((result:any) => {
      this.localDept = result;
    });
  }

  getCommingledDropdown() {
    this._commonService.getArrayList(new PaginationRequest({
      where: { comm_ac_id: null, county_cd: this.selectedDept },
      page: 1,
      limit: 100,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.getCommingledAccountsUrl + '?filter').subscribe((result:any) => {
      this.commingledAccountLists = result['data'];
    });
  }

  viewAccount(account:any) {
    this.selectedClientDetails = (this._sessionStorage.getItem('selectedClientDetails')) ? JSON.parse(this._sessionStorage.getItem('selectedClientDetails')) : {};
    this.disbursementHistory = (account && account.disbursment_history) ? account.disbursment_history : [];
    if (Array.isArray(this.disbursementHistory)) {
      this.totalPage = this.disbursementHistory.length;
    }
    this.selectedAccount = account;
  }

  pageNumberChanged(page:any) {
    this.pageInfo.pageNumber = page;
    this.viewAccount(this.selectedAccount);
  }

  editAccount(account:any) {
    this.minDate = new Date(account.open_dt);
    this.maxDate = new Date();
    this.selectedClientDetails = (this._sessionStorage.getItem('selectedClientDetails')) ? JSON.parse(this._sessionStorage.getItem('selectedClientDetails')) : {};
    this.selectedAccount = account;
    this.getCommingledDropdown();
    this.getAccountStatus();
    this.getAccountType();
    this.editAccountForm.patchValue({
      open_dt: account.open_dt,
      close_dt: account.close_dt,
      account_type_cd: account.account_type_cd,
      account_exists_sw: account.account_exists_sw,
      status_cd: account.status_cd,
      bank_nm: account.bank_nm,
      account_no_tx: account.account_no_tx,
      comm_account_id: account.comm_account_id,
      local_dept:  account?.county_cd,
    });


    if (account.status_cd === '592') {
      this.editAccountForm?.get('close_dt')?.disable();
    }

    if ((account.account_type_cd === '590' || account.account_type_cd === '592') && account.account_exists_sw === 'N') {
      this.editAccountForm?.get('bank_nm')?.disable();
      this.editAccountForm?.get('account_no_tx')?.disable();
      this.editAccountForm?.get('account_exists_sw')?.enable();
      this.editAccountForm?.get('comm_account_id')?.disable();

    }

    if ((account.account_type_cd === '590' || account.account_type_cd === '592') && account.account_exists_sw === 'Y') {
      this.editAccountForm?.get('bank_nm')?.disable();
      this.editAccountForm?.get('account_no_tx')?.disable();
      this.editAccountForm?.get('account_exists_sw')?.disable();
      this.editAccountForm?.get('comm_account_id')?.reset();
      this.editAccountForm?.get('comm_account_id')?.disable();
      this.editAccountForm?.get('comm_account_id')?.clearValidators();
    }

    if (account.account_type_cd === '591') {
      this.editAccountForm?.get('account_exists_sw')?.disable();
      this.editAccountForm?.get('account_no_tx')?.enable();
      this.editAccountForm?.get('bank_nm')?.enable();
      this.editAccountForm?.get('bank_nm')?.setValidators([Validators.required]);
      this.editAccountForm?.get('account_no_tx')?.setValidators([Validators.required]);
      this.editAccountForm?.get('comm_account_id')?.reset();
      this.editAccountForm?.get('comm_account_id')?.disable();
      this.editAccountForm?.get('comm_account_id')?.clearValidators();
    }
 
    this.editAccountForm?.get('status_cd')?.enable();

    this.comAccount = account.comm_account_id;
    this.account_no_tx = account?.account_no_tx;

  }

  deleteAccount(account:any) {
    this.selectedAccount = account;
  }

  openAddModal() {
    this.selectedClientDetails = (this._sessionStorage.getItem('selectedClientDetails')) ? JSON.parse(this._sessionStorage.getItem('selectedClientDetails')) : {};
    if (this.selectedClientDetails) {
      this.getLocalDept();
      this.getAccountStatus();
      this.getAccountType();
      this.accountForm.reset();
      this.getCommingledDropdown();
      this.accountForm.patchValue({
        open_dt: new Date(),
        local_dept: this.selectedDept,
        status_cd: '592'
      });
      $('#addNewAccount').modal('show');
      this.accountTypeSelected(null, this.accountForm);
      this.accountNoChanged(null, this.accountForm);
    } else {
      this._alertService.warn('Please search the child.');
    }
  }

  accountTypeSelected(event:any, accountForm:any) {
    const accountFormValue = accountForm?.getRawValue();
    // 591 dedicated

    if (accountFormValue.account_type_cd === '591') {
      accountForm?.get('account_exist')?.setValue('Y');
      accountForm?.get('account_exist')?.disable();
      accountForm?.get('account_no_tx')?.reset();
      accountForm?.get('account_no_tx')?.enable();
      accountForm?.get('bank_nm')?.enable();
      accountForm?.get('bank_nm')?.setValidators([Validators.required]);
      accountForm?.get('account_no_tx')?.setValidators([Validators.required]);
      accountForm?.get('comm_account_id')?.reset();
      accountForm?.get('comm_account_id')?.disable();
      accountForm?.get('comm_account_id')?.clearValidators();
    } else {
      accountForm?.get('account_exist')?.reset();
      accountForm?.get('account_exist')?.enable();
      accountForm?.get('comm_account_id')?.enable();
      accountForm?.get('comm_account_id')?.reset();
      accountForm?.get('account_no_tx')?.reset();
      accountForm?.get('account_no_tx')?.enable();
    }

   

    if (accountFormValue.account_type_cd === '590' && accountFormValue.account_exist === 'Y') {
      accountForm?.get('comm_account_id')?.reset();
      accountForm?.get('comm_account_id')?.disable();
      accountForm?.get('comm_account_id')?.clearValidators();
      accountForm?.get('account_no_tx')?.reset();
      accountForm?.get('bank_nm')?.setValidators([Validators.required]);
      accountForm?.get('account_no_tx')?.setValidators([Validators.required]);
    }

    if (accountFormValue.account_type_cd === '590' && accountFormValue.account_exist === 'N') {
      accountForm?.get('bank_nm')?.disable();
      accountForm?.get('account_no_tx')?.disable();
      accountForm?.get('comm_account_id')?.enable();
     
    }

    if ((accountFormValue.account_type_cd === '592' || accountFormValue.account_type_cd === '590') &&
      accountForm.value.account_exist === 'Y') {
      accountForm?.get('comm_account_id')?.disable();
      accountForm?.get('comm_account_id')?.reset();
      accountForm?.get('comm_account_id')?.clearValidators();
    }
    if (accountFormValue.account_type_cd === '592') {
      if (this.selectedClientDetails.client_age >= 14 && this.selectedClientDetails.client_age <= 21 ) {
        // No content or function to call or add
       } else {
         this._alertService.warn('Child age must be between 14 to 21.');
         accountForm?.get('account_type_cd')?.reset();
       }
   }
  }

  statusChange(id:any, mode:any) {
    const formNm = (mode === 'add') ? this.accountForm : this.editAccountForm;

    if (id === '592') {
      formNm?.get('close_dt')?.setValue(null);
      formNm?.get('close_dt')?.disable();
      this.closeStatus = true;
    } else if (id === '593') {
      formNm?.get('close_dt')?.enable();
      if (this.selectedAccount && +this.selectedAccount.total_balance_no <= 0) {
        this.closeStatus = true;
        this.disableAccount = false;
      } else {
        this.closeStatus = false;
        this.disableAccount = false;
      }
    } else if (id === '594') {
      this.closeStatus = true;
      if (this.selectedAccount && +this.selectedAccount.total_balance_no > 0) {
        this.disableAccount = true;
        this._alertService.warn(`The account you are trying to inactive is having some balance. To inactivate an account Balance should be $0.00`);
      } else {
        this.disableAccount = false;
      }
    }
  }

  ac_editvalidator() {
    const check = /^\d*$/;
    this.accountId = this.editAccountForm?.get('account_no_tx')?.value;
    if (this.editAccountForm.value.account_exists_sw === 'Y') {
      if (!check.test(this.accountId) && this.editAccountForm.value.account_no_tx) {
        this._alertService.error('Please Enter Numbers Only');
        this.disableAccount = true;
      } else {
        this.disableAccount = false;
      }
      return false;
    }

  }

  ac_validator() {
    const check = /^\d*$/;
    this.accountId = this.accountForm?.get('account_no_tx')?.value;
    if (this.accountForm.value.account_type_cd === '590' && this.accountForm.value.account_exist === 'Y') {
      if (!check.test(this.accountId) && this.accountForm.value.account_no_tx) {
        this._alertService.error('Please Enter Numbers Only');
        this.disableAccount = true;
      } else {
        this.disableAccount = false;
      }
      return false;
    }

  }
  clearAccountForm() {
    this.accountForm.reset();
  }

  accountExistsSelected(event:any, accountForm:any) {
    const accountFormData = accountForm?.getRawValue();
    if (event.value === 'N') {
      this.accountForm?.get('bank_nm')?.setValue('');
    }

    if (accountFormData.account_type_cd === '590' && accountFormData.account_exist === 'N') {
      this.accountForm?.get('bank_nm')?.disable();
      this.accountForm.patchValue({ account_no_tx: ('C' + FileUtils.generateAccountNumber()) });
      this.accountForm?.get('account_no_tx')?.disable();
    } else if (accountFormData.account_type_cd === '592' && accountFormData.account_exist === 'N') {
      this.accountForm?.get('comm_account_id')?.enable();
      this.accountForm?.get('bank_nm')?.disable();
      this.accountForm.patchValue({ account_no_tx: ('F' + FileUtils.generateAccountNumber()) });
      accountForm.controls['bank_nm'].clearValidators();
      this.accountForm?.get('account_no_tx')?.disable();
    } else {
      this.accountForm?.get('bank_nm')?.enable();
      this.accountForm.patchValue({ account_no_tx: null });
      this.accountForm?.get('account_no_tx')?.enable();
    }

    if ((accountFormData.account_type_cd === '590' || accountFormData.account_type_cd === '592')
     && accountFormData.account_exist === 'Y') {
      accountForm?.get('comm_account_id')?.reset();
      accountForm?.get('comm_account_id')?.disable();
      accountForm?.get('account_no_tx')?.reset();
      accountForm?.get('bank_nm')?.enable();
      accountForm?.get('account_no_tx')?.enable();
      accountForm?.get('bank_nm')?.setValidators([Validators.required]);
      accountForm?.get('account_no_tx')?.setValidators([Validators.required]);
      accountForm?.get('account_no_tx')?.updateValueAndValidity();
      accountForm?.get('bank_nm')?.updateValueAndValidity();
    }

    if (accountFormData.account_type_cd === '590' && accountFormData.account_exist === 'N') {
      accountForm?.get('bank_nm')?.disable();
      accountForm?.get('account_no_tx')?.disable();
      accountForm?.get('comm_account_id')?.enable();
    }
  }

  editaccountExistsSelected(event:any, editaccountForm:any) {
    const accountForm = editaccountForm?.getRawValue();

    if (accountForm.account_type_cd === '590' && accountForm.account_exists_sw === 'N') {
      this.editAccountForm?.get('bank_nm')?.disable();
      this.editAccountForm.patchValue({ account_no_tx: ('C' + FileUtils.generateAccountNumber()) });
      this.editAccountForm?.get('account_no_tx')?.disable();
    } else if (accountForm.account_type_cd === '592' && accountForm.account_exists_sw === 'N') {
      this.editAccountForm?.get('comm_account_id')?.enable();
      this.editAccountForm?.get('bank_nm')?.disable();
      this.editAccountForm.patchValue({ account_no_tx: ('F' + FileUtils.generateAccountNumber()) });
      editaccountForm.controls['bank_nm'].clearValidators();
      this.editAccountForm?.get('account_no_tx')?.disable();
    } else {
      this.editAccountForm?.get('bank_nm')?.enable();
      this.editAccountForm?.get('account_no_tx')?.enable();
    }

    if ((accountForm.account_type_cd === '590' || accountForm.account_type_cd === '592') && accountForm.account_exists_sw === 'Y') {
      editaccountForm?.get('comm_account_id')?.reset();
      editaccountForm?.get('comm_account_id')?.disable();
      editaccountForm?.get('account_exists_sw')?.enable();
      editaccountForm?.get('comm_account_id')?.clearValidators();
      editaccountForm?.get('bank_nm')?.enable();
      editaccountForm?.get('account_no_tx')?.enable();
      editaccountForm?.get('bank_nm')?.setValidators([Validators.required]);
      editaccountForm?.get('account_no_tx')?.setValidators([Validators.required]);
      editaccountForm?.get('account_no_tx')?.updateValueAndValidity();
      editaccountForm?.get('bank_nm')?.updateValueAndValidity();
      if (this.selectedAccount.bank_nm) {
        this.editAccountForm?.get('bank_nm')?.setValue(this.selectedAccount.bank_nm);
      }
      editaccountForm?.get('comm_account_id')?.reset();
      editaccountForm?.get('comm_account_id')?.disable();
      editaccountForm.value.comm_account_id = null;
    }

    if ((accountForm.account_type_cd === '590' || accountForm.account_type_cd === '592') && accountForm.account_exists_sw === 'N') {
      editaccountForm?.get('bank_nm')?.disable();
      editaccountForm?.get('account_no_tx')?.disable();
      editaccountForm?.get('comm_account_id')?.disable();
      editaccountForm?.get('account_exists_sw')?.enable();
      editaccountForm?.get('bank_nm')?.setValue('');
      editaccountForm?.patchValue({
        comm_account_id: this.comAccount,
      });
      this.accountExistsSwIfNFn(accountForm);
    }
  }
  // Associated wiith editaccountExistsSelected function
  private accountExistsSwIfNFn(accountForm: any) {
    if (this.selectedAccount.account_exists_sw === 'N') {
      if (this.account_no_tx) {
        this.editAccountForm.patchValue({ account_no_tx: this.account_no_tx });
      } else if (accountForm.account_type_cd === '590') {
        this.editAccountForm.patchValue({ account_no_tx: ('C' + FileUtils.generateAccountNumber()) });
      } else if (accountForm.account_type_cd === '592') {
        this.editAccountForm.patchValue({ account_no_tx: ('F' + FileUtils.generateAccountNumber()) });
      }
    }
  }

  accountNoChanged(event:any, accountForm:any) {
    const accountFormValue = accountForm?.getRawValue();
    if (!accountFormValue?.account_no_tx) {
      accountForm?.get('comm_account_id')?.disable();
      accountForm?.get('comm_account_id')?.clearValidators();
    }
    if (accountFormValue.account_type_cd === '591') {
      accountForm?.get('comm_account_id')?.disable();
    }
  }

  onChangeDate(form:any) {
    this.minDate = new Date(form.value.open_dt);
    form?.get('close_dt')?.reset();
  }

  onChanges(): void {
    this.accountForm.valueChanges.subscribe((val:any) => {
      if (val.account_type_cd === '590' && val.account_exists_sw === 'N') {
        this.accountForm?.get('bank_nm')?.disable();
        this.accountForm?.get('account_no_tx')?.disable();
      } else {
        this.accountForm?.get('bank_nm')?.enable();
        this.accountForm?.get('account_no_tx')?.enable();
      }
    });
  }

  refreshList() {
    this.getchildaccountslist();
    this.checkforrequired = false;
  }

  linkDisbursement(account:any) {
    if (account.disbursement_validation && account.disbursement_validation.length) {
      this.disbursementValidation = account.disbursement_validation[0];
    }
    if (this.reDirect) {
      $(this.finaldisbursementpopupid).modal('show');
      this.reDirect = false;
    }

    if(!this.commingledAccountListsFn(account)){
      return false;
    }

    this.isApprovalSent = account.issent;
    this.finalDisbursementForm.patchValue(account);
    this.finalDisbursementData = account;
    account = this.returnStatusCdFn(account);
    if (!account.client_acc_sw) {
      this.finalDisbursementData.client_acc_sw = this.client_sw;
    }
    if (account.status_nm === 'Closed') {
      this.finalDisbursementData.client_acc_sw = 'N';
    }
    if (this.finalDisbursementData && this.finalDisbursementData.disbursement_id == null) {
      this.finalDisbursementForm?.get('disbursement_id')?.disable();
    } else {
      this.disbursement_id = account.disbursement_id;
    }
    this.finalDisbursementData.fiscal_category_cd = account.category_code_cd;
    this.finalDisbursementData.amount = account.available_balance_no;
    this.client_account = account?.account_no_tx;
    this.disbursementDt = account.disbursement_dt;
    this.payment_id = account.payment_id;
    this.client_account_id = account.client_account_id;
    if (this.activeModule === 'Finance') {
      this.url = 'tb_child_account_disbursement/add';
      this.status = 56;
      this.ifActiveModuleIsFinanceFn(account);
    } else if (this.activeModule === 'Finance Approval') {
      this.finalDisbursementForm.disable();
      this.finalDisbursementForm?.get('payee_nm')?.enable();
      this.finalDisbursementForm?.get('adr_street_no')?.enable();
      this.finalDisbursementForm?.get('adr_street_nm')?.enable();
      this.finalDisbursementForm?.get('adr_city_nm')?.enable();
      this.finalDisbursementForm?.get('adr_county_cd')?.enable();
      this.finalDisbursementForm?.get('adr_state_cd')?.enable();
      this.finalDisbursementForm?.get('adr_zip5_no')?.enable();
      this.finalDisbursementForm?.get('adr_zip4_no')?.enable();
      this.url = 'tb_child_account_disbursement/updateapprovals';
      this.ifActiveModuleFinanceApprovalFn(account);
    }
    this.client_name = account.client_name;
    this.client_id = account.client_id;
    this.fundingStatus = account.fundingstatus;
    this.paymentStatus = account.paymentstatus;
    this.requested_by = this.returnRequestedByFn(account);
    this.assigned_to = account.assigned_to;
    this.isApprovalSent = account.issent ? account.issent : '0';
    this.disbursementHistory = this.returnDisbursementHistoryFn(account);
    this.patchFormdatalinkDisbursementFn(account);
      if (account && account.adr_state_cd) {
        this.loadCounty();
      }
    // Service patch in disbursement approval
    if (this.finalDisbursementData.client_acc_sw === 'N') {
      this.accountClosed = true;
    }
    this.cdr.markForCheck();
  }
  private returnRequestedByFn(account: any) {
    return account.requested_by ? account.requested_by : this.userName;
  }
  // Assosiated with linkDisbursement function
  private returnDisbursementHistoryFn(account: any): any[] {
    return (account && account.disbursment_history) ? account.disbursment_history : [];
  }
  // Assosiated with linkDisbursement function
  private patchFormdatalinkDisbursementFn(account: any) {
    this.finalDisbursementForm.patchValue({
      disbursement_id: account.disbursement_id,
      tax_id_no: account.tax_id_no ? account.tax_id_no : '',
      tax_type_cd: account.tax_type_cd ? account.tax_type_cd : '',
      payee_nm: account.payee_nm ? account.payee_nm : '',
      fiscal_category_cd: account.category_code ? account.category_code : '',
      service_id: account.service_id ? account.service_id.toString() : ''
    });
    if (account.issent && account.issent !== 61 && account.amount) {
      this.finalDisbursementForm.patchValue({
        amount: account.available_balance_no ? account.available_balance_no : '0.00'
      });
    } else if (this.finalDisbursementData.client_acc_sw === 'N') {
      this.finalDisbursementForm.patchValue({
        amount: account.total_balance_no
      });
    } else {
      this.finalDisbursementForm.patchValue({
        amount: '0.00'
      });
    }
  }
  // Assosiated with linkDisbursement function
  private commingledAccountListsFn(account: any) {
    const control = this.editAccountForm?.get('comm_account_id');
    if (!control?.disabled && control?.value != null && control?.value !== '') {
      if (this.commingledAccountLists && this.commingledAccountLists.length === 0) {
        this._alertService.error('Please create commingled account to link with child account');
        return false;
      } else if (this.commingledAccountLists && this.commingledAccountLists.length > 0 && !account.comm_account_id) {
        this._alertService.error('Please select commingled account');
        return false;
      }
    }

    if (account.open_dt && account.close_dt) {
      const openDate = moment(new Date(account.open_dt)).format(this.dtformat);
      const closeDate = moment(new Date(account.close_dt)).format(this.dtformat);
      if (new Date(openDate).getTime() > new Date(closeDate).getTime()) {
        this._alertService.error(this.validationmsg);
        return false;
      }
    }

    return true;
  }
  // Assosiated with linkDisbursement function
  private returnStatusCdFn(account: any) {
    if (account.status_cd === '593') {
      $('#editAccount').modal('hide');
      this.selectedAccount.close_dt = moment(new Date(account.close_dt)).format(this.dtformat);
      account = this.selectedAccount;
      if (this.selectedAccount.disbursement_validation.length) {
        this.disbursementValidation = this.selectedAccount.disbursement_validation[0];
      }
      if (this.disbursementValidation.current_coc > 0 || this.disbursementValidation.obligation_no > 0 || this.disbursementValidation.pending_error_no > 0) {
        $('#final-disbursement-error').modal('show');
      } else {
        $(this.finaldisbursementpopupid).modal('show');
      }
      account.status_nm = 'Closed';
      this.client_sw = 'N';
      this.isApprovalSent = account.issent;
      this.finalDisbursementData = this.selectedAccount;
      this.finalDisbursementForm.patchValue(account);
    } else if (account.status_cd === '592') {
      this.client_sw = 'Y';
      this.finalDisbursementFlag = false;
    }
    return account;
  }
  // Assosiated with linkDisbursement function
  private ifActiveModuleFinanceApprovalFn(account: any) {
    if (this.isApprovalSent === 56) {
      if (this.userProfile.user.securityusersid === account.tosecurityusersid) {
        this.rejectType = 'Funding';
        this.status = 57;
        this.disableApprove = false;
        this.isPaymentView = false;
        this.ifIsApprovalSentIs56Fn(account);
      } else {
        this.disableApprove = true;
        this.finalDisbursementForm.disable();
      }
    } else if (this.isApprovalSent === 57) {
      if (this.userProfile.user.securityusersid === account.tosecurityusersid) {
        this.finalDisbursementForm.controls['payment_method_cd'].setValidators(Validators.required);
        this.finalDisbursementForm.controls['payment_method_cd'].updateValueAndValidity();
        this.rejectType = 'Payment';
        this.ifIsApprovalSent57Fn(account);
        this.status = 58;
        this.disableApprove = false;
        this.isPaymentView = true;
        this.finalDisbursementForm?.get('payment_method_cd')?.enable();
        this.finalDisbursementForm?.get('fiscal_category_cd')?.disable();
        this.finalDisbursementForm?.get('report_1099_sw')?.enable();
        this.finalDisbursementForm.patchValue({ type_1099_cd: '3158' });
        this.finalDisbursementForm?.get('type_1099_cd')?.disable();
      } else {
        this.finalDisbursementForm.controls['payment_method_cd'].clearValidators();
        this.finalDisbursementForm.controls['payment_method_cd'].updateValueAndValidity();
        this.disableApprove = true;
        this.finalDisbursementForm.disable();
      }
    } else {
      this.isPaymentView = true;
      this.disableApprove = true;
      this.finalDisbursementForm.disable();
    }
    this.cdr.markForCheck();
  }
  // Assosiated with linkDisbursement function
  private ifIsApprovalSent57Fn(account: any) {
    if (account.status_nm === 'Closed') {
      this.accountClosed = true;
      this.finalDisbursementForm.patchValue({ service_id: '101' });
      this.finalDisbursementData.service_id = 101;
      this.disbursementTxt = this.finaldisbursement;
    } else {
      this.accountClosed = false;
      this.disbursementTxt = this.otherdisbursement;
      if (account.service_id) {
        this.finalDisbursementData.service_id = +account.service_id;
      }
    }
  }
  // Assosiated with linkDisbursement function
  private ifIsApprovalSentIs56Fn(account: any) {
    if (account.status_nm === 'Closed') {
      this.finalDisbursementForm?.get('amount')?.disable();
      this.accountClosed = true;
      this.finalDisbursementForm.patchValue({ service_id: '101' });
      this.finalDisbursementData.service_id = 101;
      this.finalDisbursementForm?.get('service_id')?.disable();
      this.disbursementTxt = this.finaldisbursement;
    } else {
      this.accountClosed = false;
      this.disbursementTxt = this.otherdisbursement;
      if (account.service_id) {
        this.finalDisbursementData.service_id = +account.service_id;
      }
    }
  }
  // Assosiated with linkDisbursement function
  private ifActiveModuleIsFinanceFn(account: any) {
    if (!this.isApprovalSent || this.isApprovalSent === 61) {
      if (this.isApprovalSent === 61) {
        this.approveTxt = 'Resend For Approval';
      } else {
        this.approveTxt = 'Send For Approval';
      }
      this.disableApprove = false;
      this.isPaymentView = false;
      this.finalDisbursementForm.enable();
      if (account.status_nm === 'Closed') {
        this.finalDisbursementForm?.get('amount')?.disable();
        this.accountClosed = true;
        this.finalDisbursementForm.patchValue({ service_id: '101' });
        this.finalDisbursementData.service_id = 101;
        this.finalDisbursementForm?.get('service_id')?.disable();
        this.disbursementTxt = this.finaldisbursement;
      } else {
        this.accountClosed = false;
        this.finalDisbursementForm?.get('service_id')?.enable();
        this.finalDisbursementForm?.get('amount')?.enable();
        this.disbursementTxt = this.otherdisbursement;
        if (account.service_id) {
          this.finalDisbursementData.service_id = +account.service_id;
        }
      }
      this.finalDisbursementForm?.get('disbursement_id')?.disable();
    } else {
      if (this.isApprovalSent === 58) {
        this.isPaymentView = true;
      } else {
        this.isPaymentView = false;
      }
      this.disableApprove = true;
      this.finalDisbursementForm.disable();
    }
    this.cdr.markForCheck();
  }

  selectPerson(row:any) {
    if (row) {
      this.selectedPerson = row;
      this.assignedTo = row.userid;
      this.isdisableButton = false;
    }
  }

  getRoutingUser(finalDisbursementForm:any) {
    this.checkforrequired = true;
    if(this.finalDisbursementForm.valid){
    const finalDisbursement = this.finalDisbursementForm?.getRawValue();
        if (finalDisbursement && finalDisbursement.amount) {
      if (parseFloat(finalDisbursement.amount) <= 0) {
        this._alertService.error(`Disbursement amount should be greater than '0.00'`);
        this.isdisableButton = false;
        return false;
      } else if (this.finalDisbursementData.client_acc_sw === 'Y' && parseFloat(finalDisbursement.amount) > this.disbursementValidation.overall_no) {
        this._alertService.error(`Other Disbursement amount should be less than available amount`);
        this.isdisableButton = false;
        return false;
      } else if (this.finalDisbursementData.client_acc_sw === 'N' && this.disbursementValidation.v_err_count > 0) {
        this._alertService.error(`Error Correction is pending for this account`);
        this.isdisableButton = false;
        return false;
      }
    }
    $(this.finaldisbursementapprovalpopupid).modal('show');
    this.alertText = 'Approval Request sent successfully';
    this.updateFinalDisbursement(finalDisbursement);
    this.finalDisbursementData.tax_id_no = finalDisbursement.tax_id_no;
    this.finalDisbursementData.tax_type_cd = finalDisbursement.tax_type_cd;
    this.finalDisbursementData.adr_street_no = finalDisbursement.adr_street_no;
    this.finalDisbursementData.adr_street_nm = finalDisbursement.adr_street_nm;
    this.finalDisbursementData.adr_city_nm = finalDisbursement.adr_city_nm;
    this.finalDisbursementData.adr_county_cd = finalDisbursement.adr_county_cd;
    this.finalDisbursementData.adr_state_cd = finalDisbursement.adr_state_cd;
    this.finalDisbursementData.adr_zip5_no = finalDisbursement.adr_zip5_no;
    this.finalDisbursementData.adr_zip4_no = finalDisbursement.adr_zip4_no;
    this.finalDisbursementData.payee_nm = finalDisbursement.payee_nm;
    this.finalDisbursementData.client_account_id = this.client_account_id;
    $(this.finaldisbursementpopupid).modal('hide');
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'FINALDIS' },
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe((result:any) => {
        this.getUsersList = result.data;
        this.originalUserList = this.getUsersList;
        this.listUser('TOBEASSIGNED');
      });
  }
  else{
    this._alertService.warn('Please fill required fields');
  }  
}

updateFinalDisbursement(finalDisbursement: any) {
  if (finalDisbursement.service_id) {
    this.finalDisbursementData.service_id = +finalDisbursement.service_id;
  }
  if (finalDisbursement.amount) {
    this.finalDisbursementData.amount = finalDisbursement.amount;
  }
}

  listUser(assigned: string) {
    this.selectedPerson = '';
    this.getUsersList = [];
    this.getUsersList = this.originalUserList;
    if (assigned === 'TOBEASSIGNED') {
      this.getUsersList = this.getUsersList.filter((res) => {
        if (this.isApprovalSent == null) {
            $(this.finaldisbursementapprovalpopupid).modal('show');
            return res;
         // }
        } else {
          if (res.userid !== this.userProfile.user.securityusersid) {
            $(this.finaldisbursementapprovalpopupid).modal('show');
            return res;
          }
        }
      });
    }
    this.cdr.markForCheck();
  }

  supervisorApproval() {
    this.isdisableButton = true;
    this._commonService.endpointUrl = this.url;
    this.paymentId = 0;
    this.finalDisbursementData.payment_id = this.paymentId;
    this.finalDisbursementData.eventcode = 'FINALDIS';
    this.finalDisbursementData.status = this.status;
    this.finalDisbursementData.assignedtoid = this.assignedTo ? this.assignedTo : this.userProfile.user.securityusersid;
    this.finalDisbursementData['create_user_name'] = this.userName;
    this.finalDisbursementData['create_user_id'] = this.userProfile.user.securityusersid;
    this.finalDisbursementData['update_user_id'] = this.userProfile.user.securityusersid;
    this.finalDisbursementData.disbursement_dt = new Date();
    this.finalDisbursementData.client_account = this.client_account;
    this._commonService.create(this.finalDisbursementData).subscribe(
      (response:any) => {
        if (response) {
          this._alertService.success(this.alertText);
          $(this.finaldisbursementpopupid).modal('hide');
          $(this.finaldisbursementapprovalpopupid).modal('hide');
          this.getchildaccountslist(1);
        }
        this.isdisableButton = false;
      },
      (error:any) => {
        this.isdisableButton = false;
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      });
  }

  reportCheck(event:any) {
    if (event) {
      this.reportCk = 'Y';
      this.reportEnable = true;
      this.finalDisbursementForm?.get('type_1099_cd')?.enable();
      this.paymentType$ = observableOf(this.paymentType);
    } else {
      this.getPaymentType();
      this.reportCk = 'N';
      this.reportEnable = false;
      this.finalDisbursementForm?.get('type_1099_cd')?.reset();
      setTimeout(() => {
        this.finalDisbursementForm.patchValue({ type_1099_cd: '3158' });
        this.finalDisbursementForm?.get('type_1099_cd')?.disable();
      }, 100);
    }
  }

  checkAmount(event:any) {

    const amount:any=event?.target.value
    if (parseFloat(amount) > this.disbursementValidation.overall_no) {
      this._alertService.warn('Not allowed to approve more than the actual amount');
      this.finalDisbursementForm.patchValue({
        'amount' : '0.00'
      });
      return false;
    }
  }

  finalApproval(finalDisbursementForm:any) {
    this.isdisableButton = true;
    this.checkforrequired =true;
    if(this.finalDisbursementForm.valid){
    const finalDisbursement = this.finalDisbursementForm?.getRawValue();
    if (finalDisbursement) {
      this.alertText = 'Payment Approval is successfully done';
      this.finalDisbursementData.tax_id_no = finalDisbursement.tax_id_no;
      this.finalDisbursementData.tax_type_cd = finalDisbursement.tax_type_cd;
      this.finalDisbursementData.amount = finalDisbursement.amount;
      this.finalDisbursementData.disbursement_id = finalDisbursement.disbursement_id;
      this.finalDisbursementData.report_1099_sw = this.reportCk;
      this.finalDisbursementData.type_1099_cd = finalDisbursement.type_1099_cd;
      this.finalDisbursementData.payment_method_cd = finalDisbursement.payment_method_cd;
      this.finalDisbursementData.adr_street_no = finalDisbursement.adr_street_no;
      this.finalDisbursementData.adr_street_nm = finalDisbursement.adr_street_nm;
      this.finalDisbursementData.adr_city_nm = finalDisbursement.adr_city_nm;
      this.finalDisbursementData.adr_county_cd = finalDisbursement.adr_county_cd;
      this.finalDisbursementData.adr_state_cd = finalDisbursement.adr_state_cd;
      this.finalDisbursementData.adr_zip5_no = finalDisbursement.adr_zip5_no;
      this.finalDisbursementData.adr_zip4_no = finalDisbursement.adr_zip4_no;
      this.supervisorApproval();
    }
  }
  else{
    this._alertService.error("Please fill all mandatory fields");
  }
  }

  rejectDisbursement() {
    this.isdisableButton = true;
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.childAccounts.disbursementReject + this.disbursement_id;
    const modal = {
      reason_tx: this.reason_tx,
      rejecttype: this.rejectType
    };
    this._commonService.create(modal).subscribe(
      (response:any) => {
        this._alertService.success('Disbursement Denied successfully');
        $('#reject-disbursement').modal('hide');
        this.isdisableButton = false;
        this.getchildaccountslist();
      },
      (error:any) => {
        this.isdisableButton = false;
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }
  
  updateDropdownModel(value: any) {
    return new DropdownModel({
      text: value.description_tx,
      value: value.picklist_value_cd
    })
  }

  getTaxIdType() {
    this.taxIDType$ = this._commonService.getArrayList({
      where: { picklist_type_id: '216' },
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe(map((result:any) => {
      var taxArray =  result.map((res: any) => this.updateDropdownModel(res));
      let i = taxArray.findIndex((item:any)=>(item.value == '4970'));
      taxArray.splice(i,1);
      return taxArray;
    }));
  }

  tax_id_No_Chng(){
    const tax_id = this.finalDisbursementForm?.getRawValue();
    if (tax_id.tax_id_no) {
      const taxidValidator = tax_id.tax_id_no !== "000000000"  ? true  : false;
      if(!taxidValidator){
        this.finalDisbursementForm?.get('tax_id_no')?.reset();
      }
    }
  }
  
  onChangeTax(changes: any){
    if(changes==='2518'){
      this.finalDisbursementForm?.get('tax_id_no')?.reset();
      this.format="000-00-0000";
    }else if(changes==='2517'){
      this.finalDisbursementForm?.get('tax_id_no')?.reset();
      this.format="00-0000000";
    }else{
      this.finalDisbursementForm?.get('tax_id_no')?.reset();
      this.format="000000000";
    }
  }

  getPaymentType() {
    this.paymentType = [];
    this.paymentType$ = this._commonService.getArrayList({
      where: { picklist_type_id: '308' },
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe(map((result:any) => {
      return result.map((res:any) =>this.updateDropdownModel(res));
    }));
    this.paymentType$.subscribe((response:any) => {
      for (let item of response) {
        if(item.value !== '3158') {
          this.paymentType.push(item);
        }
      }
    });
  }

  getPaymentMethod() {
    this.paymentMethod$ = this._commonService.getArrayList({
      where: { picklist_type_id: '1' },
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe(map((result:any) => {
      return result.map( (res:any) => this.updateDropdownModel(res));
    }));
  }

  documentPopup(clientaccount_id:any) {
    this.showBusy = false;
    this.clientAccountId = clientaccount_id;
  }

  clearchildForm() {
    this.childReportForm.reset();
    this.childReportForm.patchValue({
      date_sw: 'M'
    });
  }

  documentGenerate(childReport:any, type:any) {
    this.showBusy = true;
    const modal = {
      count: -1,
      limit: null,
      page: 1,
      where: {
        documenttemplatekey: ['child116report'],
        clientaccountid: this.clientAccountId,
        date_sw: childReport.date_sw,
        date_from: childReport.date_from,
        date_to: childReport.date_to,
        format: type
      },
      method: 'post'
    };

      this._commonService.download('evaluationdocument/generateintakedocument', modal)
        .subscribe((res:any) => {
          this.showBusy = false;
          const blob = new Blob([new Uint8Array(res)]);
          const link = document.createElement('a');
          link.href = window.URL.createObjectURL(blob);
          if (type === 'pdf') {
            link.download = 'DHS_116_Child_Account_History_Report.pdf';
          } else if (type === 'excel') {
            link.download = 'DHS_116_Child_Account_History_Report.xlsx';
          }

          document.body.appendChild(link);

          link.click();

          document.body.removeChild(link);
          this.clearchildForm();
          $('#downloadReport').modal('hide');
        });
  }

  loadCounty(change?:any) {
    this.finalDisbursementForm?.get('adr_county_cd')?.enable();
    if (change === 'state') {
      this.finalDisbursementForm?.get('adr_county_cd')?.reset();
    }
    const stateKey = this.finalDisbursementForm?.getRawValue().adr_state_cd;
    this._commonDropDownService.getPickListByMdmcode(stateKey).subscribe((countyList:any) => {
      this.countyList$ = observableOf(countyList);
    });
  }
  getState() {
    this.stateList$ = this._commonDropDownService.getPickListByName('state');
  }

  getService() {
    this.serviceList$ = this._commonService.getArrayList({
      where: { picklist_type_id: '10044' },
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe(map((result:any) => {
      return result.map((res:any) => this.updateDropdownModel(res));
    }));
    this.serviceList$.subscribe((res:any) => {
      this.serviceList = [];
      for(let item of res) {
        if (item.value === '102' || item.value === '103') {
          this.serviceList.push(item);
        }
      }
    });
  }
  toggleSsn = () => {
    this.isSsnHidden = !this.isSsnHidden;
    if (this.isSsnHidden) {
      this.ssnEye = 'fa-eye';
      this.showSsnMask = true;
    } else {
      this.ssnEye = 'fa-eye-slash';
      this.showSsnMask = false;
    }
  }

  getDropdown() {
    this._commonService.getArrayList({ method: 'get', where : {}}, FinanceUrlConfig.EndPoint.general.userCounty + '?filter').subscribe((result:any) => {
      if (result && result.length) {
          this.localDept = result;
          this.selectedDept = result[0].statecountycode;
          this.selectedDeptName = result[0].countyname;
          this._datastoreService.setData('selectedFinanceDept', this.selectedDept);
      }
    });
  }

  onChildListSort($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.getchilddetailslist(this.searchString, true);
}

clearRouting() {
  this.isdisableButton = false;
}
checkDec(el:any) {
  let value = el.target.value;
  if (value !== '') {
    el.target.value = isNaN(value) ? '' : value.replace(/[^0-9.]{0,2}/g, '');
    return el.target.value;
  }
  return '';
}

}

