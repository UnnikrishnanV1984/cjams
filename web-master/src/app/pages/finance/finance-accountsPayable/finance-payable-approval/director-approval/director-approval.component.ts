
import {map} from 'rxjs/operators';
import { Component, OnInit, AfterContentInit, Injector } from '@angular/core';
import { CommonHttpService,CommonDropdownsService, AlertService, AuthService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { Observable } from 'rxjs';
import { FinanceUrlConfig } from '../../../finance.url.config';
import { PaginationRequest, DropdownModel, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { ActivatedRoute, Router } from '@angular/router';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import moment from 'moment';
import { PurchaseAuthorization } from '../../../_entities/finance-entity.module';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { PurchaseAuthorizationParams } from '../../../finance.constants';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import _ from 'lodash';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { RoleGuard } from '../../../../../@core/guard';
const FISCAL_CODE_DISABLE = ['2126', '2127', '7126', '7127'];
@Component({
    selector: 'director-approval',
    templateUrl: './director-approval.component.html',
    styleUrls: ['./director-approval.component.scss'],
    standalone: false
})
export class DirectorApprovalComponent implements OnInit, AfterContentInit {
  uploadedFile: any = [];
  payableApproval: any[]=[];
  authorization_id: any;
  fiscal_category_cd: any;
  cost_no: any;
  provider_id: any;
  intakeserviceid: any;
  startDate: any;
  endDate: any;
  payment_method_cd: any;
  payableApprovalHistory: any[]=[];
  assignedTo: any;
  selectedPerson: any;
  getUsersList: any[]=[];
  originalUserList: any[]=[];
  isapproved: any;
  child_account_no: any;
  client_id: any;
  dob:Date=new Date();
  gender: string='';
  justification_tx: string='';
  description_tx: string='';
  service_log_id!: number;
  service_start_dt!: number;
  provider_nm: string='';
  service_nm!: number;
  service_end_dt!: number;
  client_name: string='';
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
  reDirect = true;
  paymentType: any[]=[];
  paymentType$!: Observable<DropdownModel[]>;
  paymentMethod$!: Observable<DropdownModel[]>;
  enablePurchase:boolean=false;
  timestamp:Date=new Date();
  initSearchParams: any = null;
  getUniqueUsersList: any[]=[];
  statusDropDownList = [
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
  reasonDesc:boolean=false;
  otherCase:boolean=false;
  roleBased:boolean=false;
  eventCode: string='';
  roletypekey: any;
  role: string='';
  userRole: string='';
  rolename: string='';
  fiscalCodes: any[]=[];
  statuskey: any;
  age: any;
  isapprovedFlag:boolean=false;
  paymentAddress: string='';
  disableupdateButton:boolean=false;
  clientEligibility: any;
  clientEligibilityStatus: any;
  service_id: any;
  childAccountsList: any[]=[];
  isButtonClicked:boolean=false;
  caseID: any;
  activeModule: any;
  roletype: string='';
  ispaymentapproved:boolean=false;
  isAssigned!: number;
  visibleCheck:boolean=false;
  supervisorDropdownList: any[]=[];
  supervisoruserid: any;
  isVissbleButton:boolean=false;
  programManagerParams: any;
  isProgramManager: boolean = false;
  user!: AppUser;
  assign:boolean=false;
  directorApproval:boolean=false;
  programManagerApproval:boolean=false;
  isFiscalCategory4181: boolean = false;
  cfeDurationList: any[]=[];
  tableData:any[] = [];
  isSupervisor:boolean=false;
  columns = [
    'Auth ID',
    'Service Request ID',
    'Category Code',
    'Request Date',
    'Payee Name',
    'Cost Not To Exceed',
    'Status',
    'Voucher',
    ''
  ]
  keys = [
    'authorization_id',
    'service_log_id',
    'fiscal_category_code',
    'request_date',
    'payee',
    'cost_no',
    'remarks',
    'voucher',
    ''
  ]
  minwidthstyle = 'min-width-175';
  approvalhistorypopupid = '#approval-history';
  invalidfiscalcodemsg = 'Invalid Fiscal Category Code due to Client age';
  rejectapprovalpopupid = '#reject-approval';
  styles: any = {
    "Auth ID": {'thStyleClassName': this.minwidthstyle, 'tdStyleClassName':this.minwidthstyle, 'filterIconClassName':'top-10'},
     "Service Request ID":{'thStyleClassName': this.minwidthstyle, 'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'},
     "Category Code":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle, 'filterIconClassName':'top-10'},
     "Request Date":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'},
     "Payee Name":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'},
     "Cost Not To Exceed":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'},
     "Status":{'thStyleClassName': 'min-width-170','tdStyleClassName':'min-width-170','filterIconClassName':'top-10' },
     "Voucher":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'}
  };
  private _commonService: CommonHttpService;
  private readonly  _alertService: AlertService;
  private readonly _route: ActivatedRoute;
  private readonly _commonDropdownService: CommonDropdownsService;
  private readonly _authService: AuthService;
  private _roleGuard: RoleGuard;
  private readonly _sessionStorage: SessionStorageService
 
  constructor(
    private readonly injector: Injector,
    private readonly _router: Router,
    private readonly _datastoreService: DataStoreService,
    private readonly _formBuilder: FormBuilder) {
      this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this._route = this.injector.get<ActivatedRoute>(ActivatedRoute);
      this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
      this._authService = this.injector.get<AuthService>(AuthService);
      this._roleGuard = this.injector.get<RoleGuard>(RoleGuard);
      this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
    }

  ngOnInit() {
    const resourcePermission = this._roleGuard.getPermissionsList();
    this.user = this._authService.getCurrentUser();
    if (resourcePermission) {
      this.directorApproval = (resourcePermission.filter((data:any) => data.name === 'manage_over1000_approval').length > 0);
      this.programManagerApproval = (resourcePermission.filter((data:any )=> data.name === 'bc_approval_manage_over1000').length > 0);
    }
    this.isVissbleButton = this._authService.isVissbleButton('read_only_access', '');
    if ((this.user.role.name === 'DF' || this.directorApproval) || this.programManagerApproval) {
      this.isVissbleButton = true;
    }
    this.isAssigned = 1;
    this.visibleCheck = false
    const role = this._authService.getCurrentUser();
    this.supervisoruserid = role.user.securityusersid;
    this.getRoutingUsers();
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Finance') {
      this.roletype = 'FNSFW';
    } else if (this.activeModule === 'Finance Approval') {
      this.roletype = 'FNSFS';
    }
    this.directorStatus = 'P';
    this.timestamp = new Date();
    this._datastoreService.currentStore.subscribe((store :any)=> {
      this.programManagerParams = store[PurchaseAuthorizationParams.ProgManagerParms];
    });
    if (this.programManagerParams !== null && this.programManagerParams !== undefined && this.programManagerParams !== '') {
      this.isProgramManager = true;
    }
    this.paginationInfo.sortBy = null;
    this.paginationInfo.sortColumn = null;
    this.getPayableApproval();
    this.buildForm();
    this.getPaymentMethod();
    this.getPaymentType();
    this._datastoreService.currentStore.subscribe((store :any) => {
      this.initSearchParams = store[PurchaseAuthorizationParams.DirectorParms];
    });

   }

  ngAfterContentInit(): void {
      if (this.initSearchParams) {
        this.onAuthID(this.initSearchParams);
        this._datastoreService.setData(PurchaseAuthorizationParams.DirectorParms, null);
      } else if (this.programManagerParams) {
        this.onAuthID(this.programManagerParams);
        this._datastoreService.setData(PurchaseAuthorizationParams.ProgManagerParms, null);
      }
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
      payment_id: [null],
      report_1099_sw: ['']
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
          client_account_no: '',
          reason_tx: ''
      });

  }

  selectAssigned(value:any) {
  this.isAssigned = +value;
    this.getPayableApproval();
  }

  statusDirectorDropDown(status:any) {
    if (status === 'A') {
      this.isAssigned = 1;
      this.visibleCheck = true;
    } else {
      this.isAssigned = 1;
      this.visibleCheck = false;
    }
    this.directorStatus = status;
    this.getPayableApproval();
  }

  supervisorDropdown(user:any) {
    this.pageInfo.pageNumber = 1;
    this.supervisoruserid = user;
    this.getPayableApproval();
  }
  getPayableApproval(query: any ={}) {
    let approvalType : any;
    let roleType: any;
    if (this.isProgramManager) {
      approvalType = 'pmanager';
      roleType = 'LDSSPM'
    } else {
      approvalType = 'direcort';
      roleType = 'FNSDF'
    }
    this.payableApproval = [];
    query = {
      authorization_id: query.authorization_id ? query.authorization_id : null,
      cost_no: query.cost_no ? query.cost_no : null,
      fiscal_category_code: query.fiscal_category_code ? query.fiscal_category_code : null,
      payee: query.payee ? query.payee : null,
      remarks: query.remarks ? query.remarks : null,
      request_date: query.request_date ? query.request_date : null,
      service_log_id: query.service_log_id ? query.service_log_id : null,
      voucher: query.voucher ? query.voucher : null
    }
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        where: {approveltype: approvalType, status: this.directorStatus, roletypekey: roleType,
        assigned_pa: true,
        user_id: this.supervisoruserid,
        payee_nm: query.payee ? query.payee : null, 
        sortcolumn: this.paginationInfo.sortColumn,
        sortorder: this.paginationInfo.sortBy,
        ...query
      },
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        method: 'get'
      }), FinanceUrlConfig.EndPoint.accountsPayable.listPayableApproval + '?filter'
    ).subscribe((result: any) => {
      this.payableApproval = result;
      this.tableData = [];
      this.payableApproval.forEach((data:any)=> { 
        this.tableData.push({
          authorization_id:data.authorization_id,
          service_log_id:data.service_log_id,
          fiscal_category_code:data.fiscal_category_desc + "" + data.fiscal_category_cd,
          request_date:data.request_date,
          payee:data.payee,
          cost_no:data.cost_no,
          remarks:data.remarks,
          voucher:data.voucher,
          ...data
        })
      }) 
      this.totalcount = (this.payableApproval && this.payableApproval.length > 0) ? this.payableApproval[0].totalcount : 0;
    });

  }

  pageChanged(pageInfo:any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.pageInfo.sortColumn =  pageInfo.query.sortColumn;
    this.pageInfo.sortBy  =  pageInfo.query.sortDirection;
    this.getPayableApproval(pageInfo.query);
  }

  getRoutingUsers() {
    this._commonService
        .getPagedArrayList(
            new PaginationRequest({
                where: { appevent: 'PCAUTH' },
                method: 'post'
            }),
            'Intakedastagings/getroutingusers'
        )
        .subscribe((result:any) => {
            this.supervisorDropdownList = result.data;
            this.supervisorDropdownList = this.supervisorDropdownList.filter((res) => {
              if (res.rolecode === 'DF' || res.rolecode === 'FS')  {
                return res;
              }
          });
        });
 }


  getClientEligibility(client_id:any, caseNumber:any, programkey:any) {
    this._commonService.getArrayList({
        where: {
            client_id: client_id,
            case_id: caseNumber ? caseNumber : null,
        },
        method: 'get'
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.ClientEligibility).subscribe((response:any) => {
        this.clientEligibility = response['data'];
        this.clientEligibilityStatus = this.clientEligibility[0].eligibility_status_cd;
      this.getFiscalCategoryCode(programkey);
    });
}

  onAuthID(authid:any) {
    this.caseID = authid.case_id ? authid.case_id : null;
    this.service_id = authid.service_id;
    this.fiscal_category_cd = authid.fiscal_category_cd;
    this.getClientEligibility(authid.client_id, authid.case_id, authid.programkey);
    setTimeout(() => {
      (<any>$(this.approvalhistorypopupid)).modal('show');
    }, 10);
    if (authid && (authid.fiscal_category_cd === '7502' ||
    authid.fiscal_category_cd === '7503')) {
      this.childAccountReject = true;
    } else {
      this.childAccountReject = false;
    }
    this.otherCase = authid.bmanualrouting;
    this.authorization_id = authid.authorization_id;
    if (authid.routingstatustypeid === 62) {
      this.statuskey = false;
    } else {
      this.statuskey = true;
    }
    this.cost_no = authid.cost_no ? authid.cost_no : '0.00';
    this.provider_id = authid.provider_id;
    this.intakeserviceid = authid.intakeserviceid;
    this.startDate = authid.payment_start_dt;
    this.endDate = authid.payment_end_dt;
    this.payment_method_cd = authid.payment_method_cd;
    this.isapproved = authid.isapproved;
    this.ispaymentapproved = authid.ispaymentapproved;
    this.client_account_id = authid.client_account_id;
    this.client_id = authid.client_id;
    this.client_name = authid.client_name;
    this.dob = authid.dob;
    this.gender = authid.gender;
    this.age = authid.age;
    this.service_nm = authid.service_nm;
    this.justification_tx = authid.justification_tx;
    this.description_tx = authid.description_tx ? authid.description_tx : '';
    this.service_log_id = authid.service_log_id;
    this.service_start_dt = authid.service_start_dt;
    this.provider_nm = authid.provider_nm;
    this.service_end_dt = authid.service_end_dt;
    this.paymentAddress = authid.paymentaddress ? authid.paymentaddress : '';
    this.remarks = authid.remarks;
    this.getApproveHistory(authid.authorization_id);
    this.viewPurchaseAuthorization(authid);
    setTimeout(() => {
      this.purchaseRequestForm.patchValue(authid);
      this.onAuthIDSetTimeoutFn(authid);
      this.purchaseRequestForm.disable();
      this.initSearchParams = null;
    }, 10);
  }

  private onAuthIDSetTimeoutFn(authid: any) {
    if (!authid.type_1099_cd) {
      this.purchaseRequestForm.patchValue({ type_1099_cd: '3158' });
    }
    if (authid.report_1099_sw === 'Y') {
      this.purchaseRequestForm.patchValue({ report_1099_sw: 'Y' });
    } else {
      this.purchaseRequestForm.patchValue({ report_1099_sw: false });
    }
    if (authid.remarks === 'Denied') {
      this.reasonDesc = true;
    } else {
      this.reasonDesc = false;
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
      this.totalPage = (this.payableApprovalHistory && this.payableApprovalHistory.length > 0) ? this.payableApprovalHistory[0].totalPage : 0;
    });
  }

  viewPurchaseAuthorization(purchaseDetail:any) {
    this._commonService.getArrayList(
      new PaginationRequest({
          page: 1,
          limit: 20,
          where: { service_log_id: purchaseDetail.service_log_id },
          method: 'get'
      }),
      FinanceUrlConfig.EndPoint.accountsPayable.approval.purchaseAuthorizationGet + '?filter'
      ).subscribe((result:any) => {
        if (result['data'] && result['data'].length > 0) {
            const paDetails = result['data'];
            // this.purchaseAuthData = paDetails.length > 0 ?  paDetails[0] : {};
            //@Simar: D-22624 we should show details of the auth id that was selected instead of the 0th element
            this.checkPurchaseAuthDataFn(paDetails, purchaseDetail);
            const model = this.returnModelDataFn();
          if (this.purchaseAuthData.paymentstatus === 'Approved') {
            this.enablePurchase = true;
          } else {
            this.enablePurchase = false;
          }
          this.purchaseServiceForm.setValue(model, { emitEvent: true, onlySelf: false });
          this.purchaseServiceForm.disable();
          if (this.remarks === 'Pending') {
            this.purchaseServiceForm?.get('justificationCode')?.disable();
            if (!FISCAL_CODE_DISABLE.includes(this.purchaseAuthData.fiscal_category_cd)) {
              this.purchaseServiceForm?.get('fiscalCode')?.disable();
              this.disableupdateButton = false;
            } else {
              this.disableupdateButton = true;
            }
          }
      }
      });
    }
    // Associated with viewPurchaseAuthorization function
  private returnModelDataFn() {
    return {
      fiscalCode: this.purchaseAuthData.fiscal_category_cd,
      voucherRequested: this.purchaseAuthData.voucher_requested,
      costnottoexceed: this.purchaseAuthData.cost_no ? this.purchaseAuthData.cost_no : '0.00',
      cfeCareDuration: this.purchaseAuthData.cfecareduration,
      justificationCode: this.purchaseAuthData.justification_text,
      fundingstatus: this.purchaseAuthData.fundingstatus,
      authorization_id: this.purchaseAuthData.authorization_id ? this.purchaseAuthData.authorization_id : '',
      startDt: this.purchaseAuthData.startdt,
      endDt: this.purchaseAuthData.enddt,
      actualAmount: this.purchaseAuthData.final_amount_no,
      paymentstatus: this.purchaseAuthData.paymentstatus,
      final_amount_no: this.purchaseAuthData.final_amount_no ? this.purchaseAuthData.final_amount_no : '0.00',
      client_account_no: this.purchaseAuthData.client_account_no ? this.purchaseAuthData.client_account_no : '',
      reason_tx: this.purchaseAuthData.reason_tx ? this.purchaseAuthData.reason_tx : ''
    };
  }
  // Associated with viewPurchaseAuthorization function
  private checkPurchaseAuthDataFn(paDetails: any, purchaseDetail: any) {
    this.purchaseAuthData = (paDetails.length > 0) ? paDetails.find((x:any) => x.authorization_id === purchaseDetail.authorization_id) : {};
    if (this.purchaseAuthData && Object.keys(this.purchaseAuthData).length > 0) {
      this.uploadedFile = this.purchaseAuthData.attachments ? this.purchaseAuthData.attachments : [];
    }
    if (this.purchaseAuthData.fiscal_category_cd == '4181') {
      this._commonDropdownService.getPickList(11001).subscribe((resp:any) => {
        this.cfeDurationList = resp;
      });
      this.purchaseServiceForm.patchValue({
        cfeCareDuration: this.purchaseAuthData.cfecareduration
      });
      this.isFiscalCategory4181 = true;
    }
  }

    getFiscalCategoryCode(vendorprogramid:any) {
      this._commonService.getArrayList({
              where: {agencyprogramareaid: vendorprogramid},
              method: 'get'
            }, FinanceUrlConfig.EndPoint.accountsPayable.approval.fiscalCodes + '?filter',
          ).subscribe( (result:any) => {
            this.fiscalCodes = result;
            // THIS RULE APPLICABLE FOR IV-E - Should not block service-log, Filter needs to be revisited
            // this.fiscalCodes = this.fiscalCodes.filter((item:any) => item.eligibility_cd === this.clientEligibilityStatus);
            if (this.service_id) {
                if (this.clientEligibilityStatus !== '2913') {
                  this.fiscalCodes = this.fiscalCodes.filter((item:any) => this.startsWith(item));
                }
                this.checkServiceIdFn();
            }
            this.purchaseServiceForm.patchValue( {fiscalCode: this.fiscal_category_cd} );
          });
  }

  private checkServiceIdFn() {
    if (this.service_id === 11333) {
      if (this.clientEligibilityStatus === '2913') {
        this.fiscalCodes = this.fiscalCodes.filter((item:any) => item.fiscalcateforycd === '2126');
      } else {
        this.fiscalCodes = this.fiscalCodes.filter((item:any) => item.fiscalcateforycd === '7126');
      }
    } else if (this.service_id === 11334) {
      if (this.clientEligibilityStatus === '2913') {
        this.fiscalCodes = this.fiscalCodes.filter((item:any) => item.fiscalcateforycd === '2127');
      } else {
        this.fiscalCodes = this.fiscalCodes.filter((item:any) => item.fiscalcateforycd === '7127');
      }
    } else {
      if (this.clientEligibilityStatus === '3951') {
        this.fiscalCodes = this.fiscalCodes.filter((item:any) => item.fiscalcateforycd === '2126');
      }
    }
  }

  updateAuthoriz() {
    let age = 0;
    const purchaseDate = moment(this.purchaseServiceForm?.get('endDt')?.value);
    const fiscalCode = this.purchaseServiceForm?.get('fiscalCode')?.value;
    if (this.dob && moment(new Date(this.dob), 'MM/DD/YYYY', true).isValid()) {
      const pDob = moment(new Date(this.dob), 'MM/DD/YYYY').toDate();
      age = purchaseDate.diff(pDob, 'years');

      if (this.isValidAgeForFiscalCode(fiscalCode, age)) {
        this._alertService.error(this.invalidfiscalcodemsg);
        this.purchaseServiceForm.patchValue({
          fiscalCode: this.purchaseAuthData.fiscal_category_cd
        });
        return false;
      } else if (fiscalCode === '7110' || fiscalCode === '2110') {
        if (+this.cost_no > 2000) {
          this._alertService.error('Selected Fiscal Category will be not allowed if the amount is more than $2000.00');
          this.purchaseServiceForm.patchValue({
            fiscalCode: this.purchaseAuthData.fiscal_category_cd
          });
          return false;
        }
      }
    }
    this.updatePurchaseAuthorization();
  }
  // Associated with updateAuthoriz function
  private updatePurchaseAuthorization() {
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.accountsPayable.history.updatePurchaseAuthorizationGet;
    const modal = {
      authorization_id: this.authorization_id,
      fiscal_category_cd: this.purchaseServiceForm?.get('fiscalCode')?.value,
      justification_tx: this.purchaseServiceForm?.get('justificationCode')?.value,
      'costno': this.cost_no ? this.cost_no : '0.00',
      'client_id': this.client_id
    };
    this._commonService.create(modal).subscribe(
      (response:any) => {
        this.checkIsexceedFn(response);
      },
      (error:any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }
  // Associated with updateAuthoriz function
  private checkIsexceedFn(response: any) {
    if (response && response.isexceed) {
      if (response.isexceed === 3) {
        this.fiscal_category_cd = this.purchaseServiceForm?.get('fiscalCode')?.value;
        this._alertService.success('Fiscal category has been Updated');
        this.getPayableApproval();
      } else if (response.isexceed === 2) {
        this.purchaseServiceForm.patchValue({
          fiscalCode: this.fiscal_category_cd
        });
        this._alertService.error(`Insufficient Client Account balance, please raise a request at lower cost`);
      } else if (response.isexceed === 1) {
        this.purchaseServiceForm.patchValue({
          fiscalCode: this.fiscal_category_cd
        });
        this._alertService.error(`Account is not available, kindly please add account for the selected client`);
      }
    }
  }
  // Associated with updateAuthoriz function
  private isValidAgeForFiscalCode(fiscalCode: string, age: number): boolean {
    switch (fiscalCode) {
      case '5113':
        return this.isAgeWithinRange(age, 14, 18);
      case '5114':
      case '5115':
      case '5117':
        return this.isAgeWithinRange(age, 18, 21);
      case '5116':
        return age < 18;
      case '5118':
        return this.isAgeWithinRange(age, 16, 21);
      default:
        return false;
    }

  }
  // Associated with updateAuthoriz function
  private isAgeWithinRange(age: number, minAge: number, maxAge: number): boolean {
    return (age < minAge || age > maxAge);
  }

  pageNumberChanged(pageInfo:any) {
    this.pageInfo.pageNumber = pageInfo.page;
    this.paginationInfo.sortColumn =  pageInfo.query.sortColumn;
    this.paginationInfo.sortBy  =  pageInfo.query.sortDirection;
    this.getApproveHistory(this.authorization_id);
  }
  public assignUser() {
    this.assign = true;
    this.isButtonClicked = true;
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.accountsPayable.ServiceLogApproval;
        const modal = {
           'case_id' : this.caseID,
           'fiscalcategorycd' : this.fiscal_category_cd,
           'costno' : this.cost_no ? this.cost_no : '0.00',
           'authorization_id' : this.authorization_id,
           'provider_id' : this.provider_id,
           'intakeserviceid' : this.intakeserviceid,
           'assignedtoid' : this.assignedTo ? this.assignedTo : null,
            'eventcode' : this.eventCode ? this.eventCode : 'PCAUTH',
           'status' : 44,
           'startDt': this.startDate,
           'endDt': this.endDate,
           'payment_method_cd': this.payment_method_cd,
           'client_id': this.client_id,
           'client_account_id': this.client_account_id,
           bmanualrouting : this.otherCase,
           'roletypekey': this.roletypekey ? this.roletypekey : null,
           'v_securityusersid': this.user.user.userprofile.securityusersid
        };
    this._commonService.create(modal).subscribe(
        (response:any) => {
            this._alertService.success('Approval sent successfully!');
            (<any>$('#payment-approval')).modal('hide');
            this.assign = false;
            this.getPayableApproval();
            this.isButtonClicked = false;
        },
        (error:any) => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            this.isButtonClicked = false;
        }
    );

  }

  selectPerson(row:any) {
    if (row) {
      this.assign = false;
      this.selectedPerson = row;
      this.assignedTo = row.userid;
    }
  }

  getRoutingUser() {
    (<any>$('#li-fiscal')).removeClass('active');
    (<any>$('#li-supervisor')).removeClass('active');
    (<any>$(`#li-supervisor`)).addClass('active');
    (<any>$(this.approvalhistorypopupid)).modal('hide');
    this._commonService
        .getPagedArrayList(
            new PaginationRequest({
                where: { appevent: 'PCAUTH' },
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

 enableUserRole(type:any) {
  if (type === 'user') {
     this.assign = true;
     this.roleBased = false;
     this.eventCode = 'PCAUTH';
     this.roletypekey = null;
  } else {
     this.assign = false;
     this.roleBased = true;
     this.assignedTo = null;
     this.eventCode = 'PCAUTHR';
     this.roletypekey = 'FNS' + this.role;
  }
}

listUser(assigned: string) {
this.userRole = 'role';
this.selectedPerson = '';
this.getUsersList = [];
this.getUniqueUsersList = [];
this.getUsersList = this.originalUserList;
this.getUniqueUsersList = _.uniqBy(this.getUsersList, 'userid');

 if (assigned === 'TOBEASSIGNED') {
   this.getUsersList = this.getUniqueUsersList.filter((res) => {
         if (res.rolecode === 'FS') {
             this.role = res.rolecode;
             this.rolename = 'Fiscal Supervisor';
             return res;
         }
 });
 } else {
     this.getUsersList = this.getUsersList.filter((res) => {
             if (res.rolecode === 'FW') {
                 this.role = res.rolecode;
                 this.rolename = 'Fiscal Worker';
                 return res;
             }
     });
 }
 this.enableUserRole('role');
}
  confirmReject() {
    (<any>$(this.approvalhistorypopupid)).modal('hide');
    (<any>$('#payment-approval')).modal('hide');
    (<any>$(this.rejectapprovalpopupid)).modal('show');
    this.reason_tx = '';
  }

  rejectApproval() {
    this.isButtonClicked = true;
    this._commonService.endpointUrl = 'tb_account_transaction/deleteClientTransactionbyAuthId' + '/' + this.authorization_id;
    const modal = {
      client_account_id: this.client_account_id,
      fiscal_category_cd: this.fiscal_category_cd,
      'case_id': this.caseID,
      cost_no: this.cost_no
    };
    this._commonService.create(modal).subscribe(
    (response:any) => {
      this._alertService.success('Approval has been Denied!');
      (<any>$(this.rejectapprovalpopupid)).modal('hide');
      this.getPayableApproval();
      this.isButtonClicked = false;
    },
    (error:any) => {
      this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      this.isButtonClicked = false;
    });

  }

  rejectOtherApproval() {
    this.isButtonClicked = true;
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.accountsPayable.approval.PurchaseAuthorizationReject + this.authorization_id;
    const modal = {
      reason_tx: this.reason_tx,
      'case_id': this.caseID
    };
    this._commonService.create(modal).subscribe(
      (response:any) => {
        this._alertService.success('Purchase Authorization has been Denied!');
        (<any>$(this.rejectapprovalpopupid)).modal('hide');
        this.getPayableApproval();
        this.isButtonClicked = false;
      },
      (error:any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        this.isButtonClicked = false;
      }
    );
  }

  getPaymentType() {
    this.paymentType = [];
    this.paymentType$ = this._commonService.getArrayList({
      where: {picklist_type_id : '308'},
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe( map((result:any) => {
      return result.map(
          (res:any) =>
              new DropdownModel({
                  text: res.value_tx,
                  value: res.picklist_value_cd
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

  getPaymentMethod() {
    this.paymentMethod$ = this._commonService.getArrayList({
      where: {picklist_type_id : '1'},
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe( map((result:any) => {
      return result.map(
          (res:any) =>
              new DropdownModel({
                  text: res.description_tx,
                  value: res.picklist_value_cd
              })
      );
  }));
  }

  documentGenerate() {
    if (this.ispaymentapproved) {
      this.isapprovedFlag = true;
    } else {
        this.isapprovedFlag = false;
    }
    this._commonService.endpointUrl = 'evaluationdocument/generateintakedocument';
    const modal = {
      count: -1,
      where: {
          documenttemplatekey: ['purchaseauthorization'],
          authorizationid: this.authorization_id,
          isapproved: this.isapprovedFlag
      },
      method: 'post'
    };
    this._commonService.download('evaluationdocument/generateintakedocument', modal)
    .subscribe((res:any) => {
      const blob = new Blob([new Uint8Array(res)]);
      const link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob);
      const timestamp = moment(this.timestamp).format('MM/DD/YYYY HH:mm:ss');
      link.download = 'Purchase-authorization-Form-' + this.authorization_id + '.' + timestamp + '.pdf';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
  }
  viewPurchaseDetails = {
    client_id: ''
  };
  viewChildAccount(clientid:any, accno:any) {
    (<any>$(this.approvalhistorypopupid)).modal('hide');
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: {client_id: clientid },
      nolimit: true,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.getchildaccountslistUrl + '?filter').subscribe((result:any) => {
      this.childAccountsList = result.data;
      if (accno && this.childAccountsList && this.childAccountsList.length > 0) {
        this.childAccountsList = this.childAccountsList.filter(data => data.account_no_tx == accno);
      }
      (<any>$('#view-child-account')).modal('show');
    });
  }

  showPrevious(id:any) {
    (<any>$(`#${id}`)).modal('show');
  }

  startsWith = function (item:any) {
    if (item.fiscalcateforycd.indexOf('21') !== 0 || item.fiscalcateforycd === '2110') {
        return item;
    }
  };

  downloadFile(s3bucketpathname:any) {
    s3bucketpathname = s3bucketpathname.replace(/,/g, '');
    const downldSrcURL =  '/api' + s3bucketpathname;
    window.open(downldSrcURL, '_blank');
  }

  callApi(query:any) {
    query = JSON.parse(query)
    this.getPayableApproval(query)
  }

  onSortedFunding(event: any) {
    event = JSON.parse(event);
    this.paginationInfo.sortBy = event.sortDirection;
    this.paginationInfo.sortColumn = event.sortColumn;
    this.getPayableApproval(event);
  }

  handleAuthIdEvent(data:any){
    data = JSON.parse(data)
    this.onAuthID(data)
  }
  cfechange(event:any){

  }
}