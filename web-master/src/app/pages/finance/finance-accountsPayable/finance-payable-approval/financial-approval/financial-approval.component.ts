import { Component, Injector, OnInit } from '@angular/core';
import { CommonHttpService,CommonDropdownsService, AlertService, AuthService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { Observable } from 'rxjs';
import { FinanceUrlConfig } from '../../../finance.url.config';
import { PaginationRequest, DropdownModel, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { ActivatedRoute } from '@angular/router';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import moment from 'moment';
import { PurchaseAuthorization } from '../../../_entities/finance-entity.module';
import { PurchaseAuthorizationParams } from '../../../finance.constants';
import _ from 'lodash';
const FISCAL_CODE_DISABLE = ['2126', '2127', '7126', '7127'];
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'financial-approval',
    templateUrl: './financial-approval.component.html',
    styleUrls: ['./financial-approval.component.scss'],
    standalone: false
})
export class FinancialApprovalComponent implements OnInit {
  uploadedFile: any = [];
  stateandZip: string='';
  payableApproval :any= [];
  payableApprovalHistory: any[]=[];
  authId: any;
  authorization_id: any;
  fiscal_category_cd: any;
  cost_no: any;
  getUsersList: any[]=[];
  getUniqueUsersList: any[]=[];
  provider_id: any;
  intakeserviceid: any;
  originalUserList: any[]=[];
  selectedPerson: string='';
  mergeUsersList: any[]=[];
  userProfile!: AppUser;
  assignedTo: any;
  startDate:Date=new Date();
  endDate:Date=new Date();
  payment_method_cd: any;
  calculate:boolean=false;
  groupCategoryCodeData: any[]=[];
  fiscodeArr:any[] = [];
  isapproved: any;
  client_id: any;
  street: string='';
  city: string='';
  county: string='';
  state: string='';
  zipCode: string='';
  paymentAddress: string='';
  client_account_id!: number;
  purchaseAuthData!: PurchaseAuthorization;
  purchaseServiceForm!: FormGroup;
  fiscalCode$!: Observable<DropdownModel[]>;
  actualAmount!: number;
  viewPurchaseDetails: any;
  authorizationID: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalcount!: number;
  totalPage!: number;
  pageInfo: PaginationInfo = new PaginationInfo();
  remarks: any;
  reason_tx: string='';
  childAccountReject:boolean=false;
  isRejected:boolean=false;
  timestamp:Date=new Date();
  statusDropDownList = [
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
  fundingStatus: any;
  reasonDesc:boolean=false;
  otherCase: any;
  calculateDisable = true;
  roleBased:boolean=false;
  eventCode: string='';
  roletypekey: any;
  role: string='';
  rolename: string='';
  userRole: string='';
  fiscalCodes: any[]=[];
  statuskey: any;
  persondob:Date=new Date();
  isapprovedFlag: any;
  fundingPayee: any;
  fundingPayeeName: any;
  streetNo: string='';
  disableupdateButton:boolean=false;
  clientEligibility: any;
  clientEligibilityStatus: any;
  service_id: any;
  childAccountsList: any[]=[];
  streetDir: string='';
  suit: string='';
  adrUnitType: string='';
  adrUnitNo: string='';
  isButtonClicked:boolean=false;
  caseID: any;
  payableApprovalID: any;
  updateAuth:boolean=false;
  activeModule: any;
  roletype: any;
  ispaymentapproved:boolean=false;
  isAssigned!: number;
  visibleCheck:boolean=false;
  supervisorDropdownList: any[]=[];
  supervisoruserid: any;
  isVissbleButton:boolean=false;
  isVissbleFinanceApproval:boolean=false;
  assign:boolean=false;
  isFiscalCategory4181: boolean = false;
  cfeDurationList: any[]=[];
  tableData :any[]= [];
  isSupervisor:boolean=false;
  columns = [
    'Auth ID',
    'Service Request ID',
    'Category Code',
    'Request Date',
    'Payee Name',
    'Cost Not To Exceed',
    'Status',
    'Funding Approved Date',
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
    'funding_approval_dt',
    'voucher',
    ''
  ]

  styles: any = {
    "Auth ID": {'thStyleClassName': '', 'tdStyleClassName':'', 'filterIconClassName':'top-10'},
     "Service Request ID":{'thStyleClassName': 'min-width-170', 'tdStyleClassName':'','filterIconClassName':'top-10'},
     "Category Code":{'thStyleClassName': '','tdStyleClassName':'', 'filterIconClassName':'top-10'},
     "Request Date":{'thStyleClassName': '','tdStyleClassName':'','filterIconClassName':'top-10'},
     "Payee Name":{'thStyleClassName': '','tdStyleClassName':'','filterIconClassName':'top-10'},
     "Cost Not To Exceed":{'thStyleClassName': 'min-width-175','tdStyleClassName':'','filterIconClassName':'top-10'},
     "Status":{'thStyleClassName': 'max-width-85','tdStyleClassName':'','filterIconClassName':'top-10' },
     "Funding Approved Date":{'thStyleClassName': 'min-width-220','tdStyleClassName':'position-right-55','filterIconClassName':'top-10'},
     "Voucher":{'thStyleClassName': '','tdStyleClassName':'','filterIconClassName':'top-10'}
  }
  approvalhistorypopupid = '#approval-history';
  getroutingusersurl = 'Intakedastagings/getroutingusers';
  paymentapprovalpopupid = '#payment-approval';
  invalidfiscalcodemsg = 'Invalid Fiscal Category Code due to Client age';
  rejectapprovalpopupid = '#reject-approval';
  dtformat = 'MM/DD/YYYY';
  validateMessage: string = '';
  private _commonService: CommonHttpService;
  private readonly _alertService: AlertService;
  private readonly _route: ActivatedRoute;
  private readonly _commonDropdownService: CommonDropdownsService;

  constructor(
    private readonly injector: Injector,
    private readonly _authService: AuthService,
    private readonly _formBuilder: FormBuilder,
    private readonly _datastoreService: DataStoreService,
    private readonly _sessionStorage: SessionStorageService
    ) {
      this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this._route = this.injector.get<ActivatedRoute>(ActivatedRoute);
      this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    }

  ngOnInit() {
    this.userProfile = this._authService.getCurrentUser();
    this.isVissbleButton = this._authService.isVissbleButton('read_only_access', '');
    this.isVissbleFinanceApproval = this._authService.isVissbleButton('Finance Approval', '');


    // Enablling funding approval for case supervisor if they have finance approvals
    if (this.checkAndReturnRoleCondFn()){
      this.isVissbleButton = true;
    }



    this.visibleCheck = false;
    this.isAssigned = 1;
    this.fundingStatus = 'P';
    this.fundingPayeeName = null;
    this.paginationInfo.sortBy = null;
    this.paginationInfo.sortColumn = null;
    this.timestamp = new Date();
    this.paginationInfo.pageNumber = 1;
    this.supervisoruserid = this.userProfile.user.securityusersid;
    this.getRoutingUsers();
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Finance') {
      this.roletype = 'FNSFW';
    } else if (this.activeModule === 'Finance Approval') {
      this.roletype = 'FNSFS';
    }
    this.getPayableApproval();
    this.buildForm();
    this._datastoreService.currentStore.subscribe((store:any) => {
      const searchParams = store[PurchaseAuthorizationParams.FundingParms];
      if (searchParams) {
        this.onAuthID(searchParams);
      }
    });
  }

  private checkAndReturnRoleCondFn() {
    return (
      (this.userProfile &&
        this.userProfile.role &&
        +this.userProfile.role.id === 36 &&
        !this.isVissbleFinanceApproval) ||
      (this.userProfile &&
        this.userProfile.role &&
        +this.userProfile.role.id === 1051)
    );
  }

  buildForm() {
    this.purchaseServiceForm = this._formBuilder.group(
      {
          fiscalCode: ['', Validators.required],
          voucherRequested: ['', Validators.required],
          cfeCareDuration: '',
          costnottoexceed: '',
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

  statusFundingDropDown(status:any) {
    if (status === 'A') {
      this.isAssigned = 1;
      this.visibleCheck = true;
    } else {
      this.isAssigned = 1;
      this.visibleCheck = false;
    }
    this.paginationInfo.pageNumber = 1;
    this.fundingStatus = status;
    this.getPayableApproval();
  }

  viewPurchaseAuthorization(purchaseDetail:any) {
    this.authorizationID = purchaseDetail.authorization_id;
    this.viewPurchaseDetails = purchaseDetail;
    this.persondob = purchaseDetail.dob;

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
        // this.purchaseAuthData = paDetails.length > 0 ? paDetails[0] : {};
        //@Simar: D-22624 we should show details of the auth id that was selected instead of the 0th element
        this.checkPurchaseAuthDataFn(paDetails, purchaseDetail);

        const model = this.returnModelDataFn();
        this.purchaseServiceForm.setValue(model, { emitEvent: true, onlySelf: false });
        this.purchaseServiceForm.disable();
        if (this.remarks === 'Pending') {
          this.purchaseServiceForm?.get('justificationCode')?.enable();
          if (!FISCAL_CODE_DISABLE.includes(this.purchaseAuthData.fiscal_category_cd)) {
            this.purchaseServiceForm?.get('fiscalCode')?.enable();
            this.disableupdateButton = false;
          } else {
            this.disableupdateButton = true;
          }
          this.reasonDesc = false;
        } else if (this.remarks === 'Denied') {
          this.reasonDesc = true;
        } else {
          this.reasonDesc = false;
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
                if (!this.disableupdateButton) {
                  this.fiscalCodes = this.fiscalCodes.filter((item:any) => !(FISCAL_CODE_DISABLE.includes(item.fiscalcateforycd)));
                }
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

  // Associated with getFiscalCategoryCode function
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

  documentGenerate() {
    if (this.ispaymentapproved) {
      this.isapprovedFlag = true;
    } else {
        this.isapprovedFlag = false;
    }
    const modal = {
      count: -1,
      where: {
          documenttemplatekey: ['purchaseauthorization'],
          authorizationid: this.authorizationID,
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
      link.download = 'Purchase-authorization-Form-' + this.authorizationID + '.' + timestamp + '.pdf';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
  }

  onSearchPayee() {
    if (this.fundingPayee) {
      this.fundingPayeeName = this.fundingPayee.replace(/'/g, `''`);
    } else {
      this.fundingPayeeName = null;
    }
    this.getPayableApproval();
  }
  onSortedFunding(event: any) {
    event = JSON.parse(event);
    this.paginationInfo.sortBy = event.sortDirection;
    this.paginationInfo.sortColumn = event.sortColumn;
    this.getPayableApproval(event);
  }
 callApi(query:any) {
    query = JSON.parse(query);
    this.paginationInfo.pageNumber = 1;
    this.getPayableApproval(query)
  }
  getPayableApproval(query: any ={}) {
    this.payableApproval = [];
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        where: {approveltype: 'funding', status: this.fundingStatus,
        sortcolumn: this.paginationInfo.sortColumn,
        sortorder: this.paginationInfo.sortBy,
        payee_nm: query.payee ? query.payee : null, //this.fundingPayeeName ? this.fundingPayeeName : null,
        roletypekey: this.roletype,
        assigned_pa: true,
        user_id : this.supervisoruserid,
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
          funding_approval_dt:data.funding_approval_dt,
          voucher:data.voucher,
          ...data
        })
      }) 

      if (this.payableApproval && this.updateAuth) {
        this.payableApprovalID = this.payableApproval.find((item:any) => item.authorization_id === this.authorizationID);
        this.onAuthID(this.payableApprovalID);
      }
      this.totalcount = (this.payableApproval && this.payableApproval.length > 0) ? this.payableApproval[0]?.totalcount : 0;
      this.paginationInfo.sortBy = null;
      this.paginationInfo.sortColumn = null;
    });

  }

  pageChanged(page:any) {
    this.paginationInfo.pageNumber = page;
    this.getPayableApproval();
  }
  onAuthID(authid:any) {
    this.updateAuth = false;
    this.caseID = authid.case_id ? authid.case_id : null;
    this.service_id = authid.service_id;
    this.fiscal_category_cd = authid.fiscal_category_cd;
    this.getClientEligibility(authid.client_id, authid.case_id, authid.programkey);
    (<any>$(this.approvalhistorypopupid)).modal('show');
    if (authid && (authid.fiscal_category_cd === '7502' ||
    authid.fiscal_category_cd === '7503')) {
      this.childAccountReject = true;
    } else {
      this.childAccountReject = false;
    }
    if (authid && (authid.remarks === 'Denied')) {
      this.isRejected = true;
      this.purchaseServiceForm.disable();
    } else {
      this.isRejected = false;
    }
    this.otherCase = authid.bmanualrouting;
    this.authorization_id = authid.authorization_id;
    this.fiscal_category_cd = authid.fiscal_category_cd;
    this.cost_no = authid.cost_no ? authid.cost_no : '0.00';
    this.provider_id = authid.provider_id;
    this.intakeserviceid = authid.intakeserviceid;
    this.startDate = authid.payment_start_dt;
    this.endDate = authid.payment_end_dt;
    this.payment_method_cd = authid.payment_method_cd;
    this.isapproved = authid.isapproved;
    if (authid.routingstatustypeid === 62) {
      this.statuskey = false;
    } else {
      this.statuskey = true;
    }
    this.ispaymentapproved = authid.ispaymentapproved;
    this.remarks = authid.remarks;
    this.client_id = authid.client_id;
    this.client_account_id = authid.client_account_id;
    this.paymentAddress = authid.paymentaddress;
    this.getApproveHistory(authid.authorization_id);
    this.viewPurchaseAuthorization(authid);
    setTimeout(() => {
      this._datastoreService.clearStore();
    }, 100);
  }

  supervisorDropdown(user:any) {
    this.pageInfo.pageNumber = 1;
    this.supervisoruserid = user;
    this.getPayableApproval();
  }
  
  getRoutingUsers() {
    this._commonService
        .getPagedArrayList(
            new PaginationRequest({
                where: { appevent: 'PCAUTH' },
                method: 'post'
            }),
            this.getroutingusersurl
        )
        .subscribe((result:any) => {
            this.supervisorDropdownList = result.data;
            this.supervisorDropdownList = this.supervisorDropdownList.filter((res) => {
              if (res.rolecode === 'DF' || res.rolecode === 'FS' || res.rolecode === 'FW')  {
                return res;
              }
          });
        });
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

  pageNumberChanged(pageInfo:any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.pageInfo.pageNumber = pageInfo.page;
    this.paginationInfo.sortColumn =  pageInfo.query.sortColumn;
    this.paginationInfo.sortBy  =  pageInfo.query.sortDirection;
    this.getPayableApproval(pageInfo.query);
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
           'status' : 41,
           'startDt': this.startDate,
           'endDt': this.endDate,
           'payment_method_cd': this.payment_method_cd,
           'client_id': this.client_id,
           'client_account_id': this.client_account_id,
            bmanualrouting: this.otherCase,
           'roletypekey': this.roletypekey ? this.roletypekey : null,
           'v_securityusersid': this.userProfile.user.userprofile.securityusersid
        };
    this._commonService.create(modal).subscribe(
        (response:any) => {
            this._alertService.success('Approval sent successfully!');
            (<any>$(this.paymentapprovalpopupid)).modal('hide');
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

  getRoutingUser(mode:any) {
    if (mode === 'category') {
      this.handleRoutingUserUrlApiFn();
    } else {
      if (this.purchaseServiceForm.valid) {
        (<any>$(this.approvalhistorypopupid)).modal('hide'); // NOSONAR
        (<any>$('#category-calculation')).modal('hide'); // NOSOSNAR
        this.handleRoutingUserUrlApiFn();
      } else {
        this._alertService.error('Please fill the mandatory fields');
      }
    }
 }
 // Assosiated with getRoutingUser method
  private handleRoutingUserUrlApiFn() {
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'PCAUTH' },
          method: 'post'
        }),
        this.getroutingusersurl
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
        if (res.rolecode === 'FS' && res.userid !== this.userProfile.user.securityusersid) {
          this.role = res.rolecode;
          this.rolename = 'Fiscal Supervisor';
            return res;
        }
    });
    }
    this.enableUserRole('role');
  }

  enableCategoryCalculate(value:any) {
    if (value === 'category') {
      this.calculate = true;
    } else {
      this.calculate = false;
    }
  }
  changeFCC(value:any) {
    if (!(value === '7502' || value === '7503')) {
      this.purchaseServiceForm.patchValue({
        client_account_no: null
      });
    }
    let startdt = this.fiscalCodes.filter(item => item.fiscalcateforycd == value)[0].start_dt;
    if(startdt && this.startDate < startdt){
      let additionalInfo : any =this.fiscalCodes.filter(item => item.fiscalcateforycd == value)[0].additional_description;
      this.validateMessage = additionalInfo + ' effective from ' + moment(new Date(startdt)).format(this.dtformat) +'.';
      (<any>$('#validate-fiscalDate')).modal('show');
    }else{
      //future ebp referral code 
      (<any>$(this.approvalhistorypopupid)).modal('hide');
      (<any>$('#update-approval')).modal('show');
    }
  }

  resetFiscalCode(){
    (<any>$('#validate-fiscalDate')).modal('hide');
    this.revertUpdate();
  }

  revertUpdate() {
    this.purchaseServiceForm.patchValue({
      fiscalCode: this.fiscal_category_cd
    });
  }

  updateAuthoriz(mode?: any) {

    let age = 0;
    const purchaseDate = moment(this.purchaseServiceForm?.get('endDt')?.value);
    const fiscalCode = this.purchaseServiceForm?.get('fiscalCode')?.value;
    if (this.persondob && moment(new Date(this.persondob), 'MM/DD/YYYY', true).isValid()) {
        const pDob = moment(new Date(this.persondob), 'MM/DD/YYYY').toDate();
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
    this.updatePurchaseAuthorization(mode);
  }
  // Associated with updateAuthoriz function
  private updatePurchaseAuthorization(mode: any) {
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.accountsPayable.history.updatePurchaseAuthorizationGet;
    const modal = {
      roletypekey: this.roletype,
      authorization_id: this.authorization_id,
      fiscal_category_cd: this.purchaseServiceForm?.get('fiscalCode')?.value,
      justification_tx: this.purchaseServiceForm?.get('justificationCode')?.value,
      'costno': this.cost_no ? this.cost_no : '0.00',
      'client_id': this.client_id
    };
    this._commonService.create(modal).subscribe(
      (response:any) => {
        this.checkIsexceedFn(response, mode);
      },
      (error:any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }
  // Associated with updateAuthoriz function
  private checkIsexceedFn(response: any, mode: any) {
    if (response && response.isexceed) {
      if (mode === 'update' && !this.updateAuth) {
        //  (<any>$(this.approvalhistorypopupid)).modal('show');
        (<any>$('#update-approval')).modal('hide');
      }
      this.ifModeUpdateInresponseCondFn(response);
    }
  }
  // Associated with updateAuthoriz function
  private ifModeUpdateInresponseCondFn(response: any) {
    if (response.isexceed === 3) {
      if (this.purchaseServiceForm?.get('fiscalCode')?.value === '7502' ||
        this.purchaseServiceForm?.get('fiscalCode')?.value === '7503') {
        this.updateAuth = true;
      } else {
        (<any>$(this.approvalhistorypopupid)).modal('show');
        this.updateAuth = false;
      }
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

  groupFundingApproval() {
     this._commonService.getArrayList({
       method: 'get',
       where: {
        roletypekey: this.roletype
       }
     },
     FinanceUrlConfig.EndPoint.accountsPayable.approval.groupCategory + '?filter'
     ).subscribe((result:any) => {
       this.groupCategoryCodeData = result;
       if (this.groupCategoryCodeData && this.groupCategoryCodeData.length > 0) {
        this.calculateDisable = false;
       } else {
        this.calculateDisable = true;
       }
     });
  }
  categoryCheck(event:any, fiscalCode:any) {
    if (event) {
      this.fiscodeArr.push(fiscalCode);
    } else {
      this.fiscodeArr = this.fiscodeArr.filter(data => data !== fiscalCode);
    }
  }
  categoryApproval() {
    this.isButtonClicked = true;
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.accountsPayable.approval.categoryApproval;
    const modal = {
      'fiscalcategorycd' : '{' + this.fiscodeArr + '}',
      'costno' : this.cost_no ? this.cost_no : '0.00',
      'authorization_id' : this.authorization_id ? this.authorization_id : null,
      'provider_id' : this.provider_id ? this.provider_id : null,
      'intakeserviceid' : this.intakeserviceid ? this.intakeserviceid : null,
      'assignedtoid' : this.assignedTo ? this.assignedTo : null,
      'eventcode' : this.eventCode ? this.eventCode : 'PCAUTH',
      'status' : 41,
      'startDt': this.startDate ? this.startDate : null,
      'endDt': this.endDate ? this.endDate : null,
      'payment_method_cd': this.payment_method_cd ? this.payment_method_cd : null,
      'client_id': this.client_id,
      'client_account_id': this.client_account_id,
      'roletypekey': this.roletypekey ? this.roletypekey : null
   };

   this._commonService.create(modal).subscribe(
      (response:any) => {
          this._alertService.success('Approval sent successfully!');
          (<any>$(this.paymentapprovalpopupid)).modal('hide');
          (<any>$(this.approvalhistorypopupid)).modal('hide');
          this.fiscodeArr = [];
          this.getPayableApproval();
          this.isButtonClicked = false;
      },
      (error:any) => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          this.isButtonClicked = false;
      }
    );
  }
  confirmReject() {
    (<any>$(this.approvalhistorypopupid)).modal('hide');
    (<any>$(this.paymentapprovalpopupid)).modal('hide');
    (<any>$(this.rejectapprovalpopupid)).modal('show');
    this.reason_tx = '';
  }

  rejectApproval() {
    this.isButtonClicked = true;
    this._commonService.endpointUrl = 'tb_account_transaction/deleteClientTransactionbyAuthId' + '/' + this.authorization_id;
    const modal = {
      client_account_id: this.client_account_id,
      fiscal_category_cd: this.fiscal_category_cd,
      cost_no: this.cost_no,
      'case_id': this.caseID,
       reason_tx: this.reason_tx,
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


  viewChildAccount(clientid:any, accno:any) {
    (<any>$(this.approvalhistorypopupid)).modal('hide');
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: {client_id: clientid },
      nolimit: true,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.getchildaccountslistUrl + '?filter').subscribe((result:any) => {
      this.childAccountsList = result.data;
      if (accno && this.childAccountsList && this.childAccountsList.length > 0) {
        this.childAccountsList = this.childAccountsList.filter(data => data?.account_no_tx == accno);
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
  }

  downloadFile(s3bucketpathname:any) {
    s3bucketpathname = s3bucketpathname.replace(/,/g, '');
    const downldSrcURL =  '/api' + s3bucketpathname;
    window.open(downldSrcURL, '_blank');
  }

  handleAuthIdEvent(data:any){
    data = JSON.parse(data)
    this.onAuthID(data)
  }

  cfechange(event:any){

  }

}