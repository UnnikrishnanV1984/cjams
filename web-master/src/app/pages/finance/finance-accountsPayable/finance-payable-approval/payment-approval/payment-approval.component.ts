
import {of as observableOf,  Observable } from 'rxjs';

import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { CommonHttpService, CommonDropdownsService, AlertService, DataStoreService, SessionStorageService, AuthService } from '../../../../../@core/services';
import { PaginationRequest, DropdownModel, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { FinanceUrlConfig } from '../../../finance.url.config';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import moment from 'moment';
import { PurchaseAuthorization } from '../../../_entities/finance-entity.module';
import { PurchaseAuthorizationParams } from '../../../finance.constants';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { AppUser } from '../../../../../@core/entities/authDataModel';
const FISCAL_CODE_DISABLE = ['2126', '2127', '7126', '7127'];
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'payment-approval',
    templateUrl: './payment-approval.component.html',
    styleUrls: ['./payment-approval.component.scss'],
    standalone: false
})
export class PaymentApprovalComponent implements OnInit {
  uploadedFile: any = [];
  payableApproval:any[] = [];
  payableApprovalHistory: any[]=[];
  authorization_id: any =[];
  fiscal_category_cd: any =[];
  cost_no: any =[];
  provider_id: any =[];
  intakeserviceid: any =[];
  startDate: any =[];
  endDate: any =[];
  payment_method_cd: any =[];
  paymentType$!: Observable<any[]>;
  paymentType: any[]=[];
  purchaseRequestForm!: FormGroup;
  reportCheck: string='';
  paymentMethod$!: Observable<DropdownModel[]>;
  isapproved: any =[];
  client_account_id!: number;
  purchaseServiceForm!: FormGroup;
  purchaseAuthData!: PurchaseAuthorization;
  fiscalCode$!: Observable<DropdownModel[]>;
  actualAmount!: number;
  viewPurchaseDetails: any =[];
  authorizationID: any =[];
  actualCost: any =[];
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalcount!: number;
  totalPage!: number;
  pageInfo: PaginationInfo = new PaginationInfo();
  remarks: any =[];
  street: string='';
  city: string='';
  county: string='';
  state: string='';
  zipCode: string='';
  paymentAddress: string='';
  reason_tx: any =[];
  childAccountReject:boolean=false;
  isRejected:boolean=false;
  disableApprove:boolean=false;
  timestamp:Date=new Date();
  statusDropDownList = [
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
  supervisorDropdownList:any = [];
  paymentStatus: any=[];
  reasonDesc:boolean=false;
  otherCase:boolean=false;
  fiscalCodes: any[]=[];
  persondob:Date=new Date();
  isapprovedFlag:boolean=false;
  reportableCheck:boolean=false;
  paymentPayee: any=[];
  paymentPayeeName: any=[];
  streetNo: string='';
  disableupdateButton:boolean=false;
  service_id: any =[];
  clientEligibility: any =[];
  clientEligibilityStatus: any =[];
  childAccountsList: any[]=[];
  client_id: any =[];
  streetDir: string='';
  suit: string='';
  adrUnitType: string='';
  adrUnitNo: string='';
  stateandZip: string='';
  isButtonClicked:boolean=false;
  caseID: any =[];
  updateAuth:boolean=false;
  payableApprovalID: any =[];
  activeModule: any =[];
  roletype: any =[];
  mandatoryField: boolean=false;
  ispaymentapproved:boolean=false;
  isAssigned!: number;
  supervisoruserid: any =[];
  visibleCheck:boolean=false;
  user!: AppUser;
  isFiscalCategory4181: boolean = false;
  cfeDurationList: any[]=[];
  tableData :any= [];
  dtformat = 'MM/DD/YYYY';
  validateMessage: string = '';
  columns = [
    'Auth ID',
    'Service Request ID',
    'Request Date',
    'Category Code',
    'Payee Name',
    'Cost Not To Exceed',
    'Payment Approved Date',
    'Status',
     ''
  ]
  keys = [
    'authorization_id',
    'service_log_id',
    'request_date',
    'fiscal_category_code',
    'payee',
    'cost_no',
    'payment_approval_dt',
    'remarks',
    ''
  ]
  minwidthstyle = 'min-width-220';
  approvalhistorypopupid = '#approval-history';
  invalidfiscalcodemsg = 'Invalid Fiscal Category Code due to Client age';
  rejectapprovalpopupid = '#reject-approval';
  styles: any = {
    "Auth ID": {'thStyleClassName': '','tdStyleClassName':'','filterIconClassName':''},
     "Service Request ID":{'thStyleClassName': 'min-width-170','tdStyleClassName':'','filterIconClassName':''},
     "Category Code":{'thStyleClassName': '','tdStyleClassName':'','filterIconClassName':''},
     "Request Date":{'thStyleClassName': '','tdStyleClassName':'','filterIconClassName':''},
     "Payee Name":{'thStyleClassName': 'min-width-205','tdStyleClassName':'min-width-205','filterIconClassName':''},
     "Cost Not To Exceed":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'},
     "Status":{'thStyleClassName': 'max-width-85','tdStyleClassName':'','filterIconClassName':''},
     "Payment Approved Date":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.minwidthstyle,'filterIconClassName':'top-10'}
  }

  constructor(
    private _commonService: CommonHttpService,
    private _alertService: AlertService,
    private _commonDropdownService: CommonDropdownsService,
    private _authService: AuthService,
    private _formBuilder: FormBuilder,
    private _datastoreService: DataStoreService,
    private _sessionStorage: SessionStorageService
    ) { }

  ngOnInit() {
    this.isAssigned = 1;
    const role = this._authService.getCurrentUser();
    this.supervisoruserid = role.user.userprofile.securityusersid;
    this.getRoutingUsers();
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Finance') {
      this.roletype = 'FNSFW';
    } else if (this.activeModule === 'Finance Approval') {
      this.roletype = 'FNSFS';
    }
    this.paymentStatus = 'P';
    this.timestamp = new Date();
    this.paginationInfo.pageNumber = 1;
    this.paymentPayeeName = null;
    this.pageInfo.sortBy = null;
      this.paginationInfo.sortColumn = null;
    this.getPayableApproval();
    this.buildForm();
    this.getPaymentMethod();
    this.purchaseRequestForm?.get('payment_id')?.disable();
    this.purchaseRequestForm?.get('payment_start_dt')?.disable();
    this.purchaseRequestForm?.get('payment_end_dt')?.disable();
    this._datastoreService.currentStore.subscribe((store:any) => {
      const searchParams = store[PurchaseAuthorizationParams.PaymentParms];
      if (searchParams) {
        this.onAuthId(searchParams);
      }
    });
    this.user = this._authService.getCurrentUser();
  }

  selectAssigned(value:any) {
    this.isAssigned = +value;
      this.getPayableApproval();
    }

  statusPaymentDropDown(status:any) {
    this.pageInfo.pageNumber = 1;
    this.paymentStatus = status;
    if (status === 'A') {
      this.isAssigned = 1;
      this.visibleCheck = true;
    } else {
      this.isAssigned = 1;
      this.visibleCheck = false;
    }
    this.getPayableApproval();
  }
  supervisorDropdown(user:any) {
    this.pageInfo.pageNumber = 1;
    this.supervisoruserid = user;
    this.getPayableApproval();
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

  viewPurchaseAuthorization(purchaseDetail:any) {
    this.disableApprove = true;
    this.authorizationID = purchaseDetail.authorization_id;
    this.persondob = purchaseDetail.dob;
    this.viewPurchaseDetails = purchaseDetail;
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
            this.checkPurchaseDetailsFn(paDetails, purchaseDetail);
            const model = this.returnModelDataFn();
          this.purchaseServiceForm.setValue(model, { emitEvent: true, onlySelf: false });
          this.purchaseServiceForm.disable();
          if (this.remarks === 'Pending') {
            this.purchaseServiceForm?.get('justificationCode')?.enable();
            this.ifPendingRemarksFn();
            this.purchaseRequestForm?.get('amount_no')?.enable();
            this.purchaseRequestForm?.get('payment_method_cd')?.enable();
            this.purchaseRequestForm?.get('store_receipt_id')?.enable();
            this.purchaseRequestForm.patchValue({
              amount_no: this.purchaseAuthData.cost_no ? this.purchaseAuthData.cost_no : '0.00'
            });
          } else if ( this.remarks === 'Denied' ) {
            this.purchaseServiceForm?.get('justificationCode')?.disable();
            this.purchaseServiceForm?.get('fiscalCode')?.disable();
            this.purchaseRequestForm?.get('amount_no')?.disable();
            this.purchaseRequestForm?.get('payment_method_cd')?.disable();
            this.purchaseRequestForm?.get('store_receipt_id')?.disable();
            this.purchaseServiceForm?.get('reason_tx')?.disable();
            this.purchaseRequestForm.patchValue({
              amount_no: this.purchaseAuthData.cost_no ? this.purchaseAuthData.cost_no : '0.00'
            });
          } else if (this.ispaymentapproved) {
            this.purchaseRequestForm.disable();
          }
      }
      });
      }
  // Associated with viewPurchaseAuthorization function
  private ifPendingRemarksFn() {
    if (!FISCAL_CODE_DISABLE.includes(this.purchaseAuthData.fiscal_category_cd)) {
      this.purchaseServiceForm?.get('fiscalCode')?.enable();
      this.disableupdateButton = false;
    } else {
      this.disableupdateButton = true;
    }
  }
  // Associated with viewPurchaseAuthorization function
  private returnModelDataFn() {
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
      client_account_no: this.purchaseAuthData.client_account_no ? this.purchaseAuthData.client_account_no : '',
      reason_tx: this.purchaseAuthData.reason_tx ? this.purchaseAuthData.reason_tx : ''
    };
  }
  // Associated with viewPurchaseAuthorization function
  private checkPurchaseDetailsFn(paDetails: any, purchaseDetail: any) {
    this.purchaseAuthData = (paDetails.length > 0) ? paDetails.find((item:any) => item.authorization_id === this.authorizationID) : {};
    if (this.purchaseAuthData && Object.keys(this.purchaseAuthData).length > 0) {
      this.uploadedFile = this.purchaseAuthData.attachments ? this.purchaseAuthData.attachments : [];
    }
    if (this.purchaseAuthData && this.purchaseAuthData.status) {
      this.ifPurchaseAuthDataStatusFn(purchaseDetail);
    } else {
      this.disableApprove = true;
      this.purchaseServiceForm.disable();
    }
  }
  // Associated with viewPurchaseAuthorization function
  private ifPurchaseAuthDataStatusFn(purchaseDetail: any) {
    if (this.purchaseAuthData.fiscal_category_cd == '4181') {
      this._commonDropdownService.getPickList(11001).subscribe((resp:any) => {
        this.cfeDurationList = resp;
      });
      this.purchaseServiceForm.patchValue({
        cfeCareDuration: this.purchaseAuthData.cfecareduration
      });
      this.isFiscalCategory4181 = true;
    }
    if (this.purchaseAuthData.status === 41 || purchaseDetail.routingstatustypeid === 41) {
      this.disableApprove = true;
      this.purchaseServiceForm.disable();
    } else {
      this.disableApprove = false;
    }
  }

      actualCostChange(amount:any) {
        let actual_cost = this.actualCost;
        const percentage = actual_cost * 0.15;
        actual_cost = percentage + (+actual_cost);
        if (parseFloat(amount) <= 0) {
          this._alertService.warn('Actual cost should be more than $0.00.');
        } else if (parseFloat(amount) > actual_cost) {
          this._alertService.warn('Not allowed to approve more than 15% from the actual cost');
          this.purchaseRequestForm.patchValue({
            cost_no : this.actualCost
          });
        }
      }

      checkDec(el:any) {
        if (el.target.value !== '') {
          el.target.value = isNaN(el.target.value)
          return el.target.value ? '' : el.target.value.replace(/[^0-9.]{0,2}/g, '');
        }
        return '';
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
              authorizationid: this.authorizationID,
              isapproved: this.isapprovedFlag
          },
          method: 'post'
        };
        this._commonService.download('evaluationdocument/generateintakedocument', modal)
        .subscribe((res :any)=> {
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
      if (this.paymentPayee) {
        this.paymentPayeeName = this.paymentPayee.replace(/'/g, `''`);
      } else {
        this.paymentPayeeName = null;
      }
      this.getPayableApproval();
    }
    onSortedPayment(event:any) {
      event = JSON.parse(event);
      this.paginationInfo.sortBy = event.sortDirection;
      this.paginationInfo.sortColumn = event.sortColumn;
      this.getPayableApproval(event);
    }
    callPaymentApi(query:any) {
      query = JSON.parse(query);
      this.paginationInfo.pageNumber = 1;
      this.getPayableApproval(query)
    }
  getPayableApproval(query: any ={}) {
    this.payableApproval = [];
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        where: {approveltype: 'payment', status: this.paymentStatus,
        payee_nm:  query.payee ? query.payee : null, //this.paymentPayeeName ? this.paymentPayeeName : null,
        sortcolumn: this.paginationInfo.sortColumn,
        sortorder: this.paginationInfo.sortBy,
        roletypekey: this.roletype,
        assigned_pa: true,
        user_id: this.supervisoruserid,
        ...query
      },
        limit : this.pageInfo.pageSize,
        page: this.pageInfo.pageNumber,
        method: 'get'
      }), FinanceUrlConfig.EndPoint.accountsPayable.listPayableApproval + '?filter'
    ).subscribe((result: any) => {
      this.tableData = [];     
       this.payableApproval = result;
      this.payableApproval.forEach((data:any)=> { 
        this.tableData.push({
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
      if (this.payableApproval && this.updateAuth) {
         this.payableApprovalID = this.payableApproval.find((item:any) => item.authorization_id === this.authorizationID);
         this.onAuthId(this.payableApprovalID);
      }
      this.totalPage = (this.payableApproval && this.payableApproval.length > 0) ? this.payableApproval[0].totalcount : 0;
    });

  }

  pageNumberChanged(pageInfo:any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.pageInfo.pageNumber = pageInfo.page;
    this.paginationInfo.sortColumn =  pageInfo.query.sortColumn;
    this.paginationInfo.sortBy  =  pageInfo.query.sortDirection;
    this.getPayableApproval(pageInfo.query);
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

  getPaymentDetail(authorizationId:any) {
    this._commonService.getArrayList(
      new PaginationRequest({
        where: {authorization_id: authorizationId},
        method: 'get'
      }), FinanceUrlConfig.EndPoint.accountsPayable.listPaymentDetail + '?filter'
    ).subscribe((result: any) => {
      if (result && result.length) {
        var report_1099_sw_result = false;
        if(result[0].report_1099_sw && result[0].report_1099_sw == 'Y' ) {
            report_1099_sw_result = true;
        }
        this.purchaseRequestForm.patchValue({
          payment_method_cd: result[0].payment_method_cd,
          report_1099_sw: report_1099_sw_result ,
          amount_no: result[0].gross_amount_no,
          type_1099_cd: result[0].type_1099_cd,
          payment_id: result[0].payment_id,
          store_receipt_id: result[0].store_receipt_id
        });
      }
    });
  }

  onAuthId(authid:any) {
    this.purchaseRequestForm.reset();
    this.purchaseRequestForm.patchValue({report_1099_sw: null});
    this.getPaymentDetail(authid.authorization_id);
    this.caseID = authid.case_id ? authid.case_id : null;
    this.service_id = authid.service_id;
    this.fiscal_category_cd = authid.fiscal_category_cd;
    this.getClientEligibility(authid.client_id, authid.case_id, authid.programkey);
    this.client_id = authid.client_id;
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
    this.purchaseRequestForm.patchValue(authid);
    if (authid.remarks === 'Denied') {
      this.reasonDesc = true;
    } else {
      this.reasonDesc = false;
    }
    this.service_id = authid.service_id;
    this.isapproved = authid.isapproved;
    this.otherCase = authid.bmanualrouting;
    this.authorization_id = authid.authorization_id;
    this.fiscal_category_cd = authid.fiscal_category_cd;
    this.cost_no = authid.cost_no ? authid.cost_no : '0.00';
    this.provider_id = authid.provider_id;
    this.intakeserviceid = authid.intakeserviceid;
    this.startDate = authid.payment_start_dt;
    this.endDate = authid.payment_end_dt;
    this.remarks = authid.remarks;
    this.ispaymentapproved = authid.ispaymentapproved;
    this.payment_method_cd = authid.payment_method_cd;
    this.client_account_id = authid.client_account_id;
    this.actualCost = authid.cost_no;
    this.paymentAddress = authid.paymentaddress;
    this.getApproveHistory(authid.authorization_id);
    this.getPaymentType();
    this.purchaseRequestForm.patchValue({
      payment_start_dt: authid.payment_start_dt,
      payment_end_dt: authid.payment_end_dt,
      payment_id: authid.payment_id ? authid.payment_id : ''
    });
    this.checkAuthidRemarksFn(authid);
    this.viewPurchaseAuthorization(authid);
    setTimeout(() => {
      this._datastoreService.clearStore();
    }, 100);
  }

  private checkAuthidRemarksFn(authid: any) {
    if (authid.remarks !== 'Approved' && authid.remarks !== 'Denied') {
      this.purchaseRequestForm.patchValue({
        amount_no: authid.amount_no ? authid.amount_no : '0.00',
        payment_start_dt: authid.payment_start_dt,
        payment_end_dt: authid.payment_end_dt,
        payment_id: authid.payment_id ? authid.payment_id : '',
        type_1099_cd: '3158'
      });
      this.purchaseRequestForm?.get('type_1099_cd')?.disable();
    } else {
      if (authid.report_1099_sw === 'Y') {
        this.purchaseRequestForm.patchValue({ report_1099_sw: 'Y' });
      } else {
        this.purchaseRequestForm.patchValue({ report_1099_sw: false });
      }
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
      } else if (this.purchaseServiceForm?.get('fiscalCode')?.value === '7110' ||
        this.purchaseServiceForm?.get('fiscalCode')?.value === '2110') {
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
      if (mode === 'update') {
        // (<any>$(this.approvalhistorypopupid)).modal('show');
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
            this.supervisorDropdownList = this.supervisorDropdownList.filter((res:any) => {
              if (res.rolecode === 'DF' || res.rolecode === 'FS')  {
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
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        method: 'get'
      }), FinanceUrlConfig.EndPoint.accountsPayable.listPayableApprovalHistory + '?filter'
    ).subscribe((result: any) => {
      this.payableApprovalHistory = result;
      this.totalcount = (this.payableApprovalHistory && this.payableApprovalHistory.length > 0) ? this.payableApprovalHistory[0].totalcount : 0;
      this.paginationInfo.sortBy = null;
      this.paginationInfo.sortColumn = null;
    });
  }

  pageChanged(page:any) {
    this.paginationInfo.pageNumber = page;
    this.getApproveHistory(this.authorization_id);
  }

  repotCheck(event:any) {
    if (event) {
      this.reportCheck = 'Y';
      this.purchaseRequestForm?.get('type_1099_cd')?.reset();
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

  finalApproval() {
    this.mandatoryField=true;
    this.purchaseRequestForm.markAllAsTouched();
    this.isButtonClicked = true;
    if (this.purchaseRequestForm.invalid) {
      this.isButtonClicked = false;
      return false;
    } else {

      let actual_cost = this.actualCost;
      const percentage = actual_cost * 0.15;
      actual_cost = percentage + (+actual_cost);
      if (parseFloat(this.purchaseRequestForm?.get('amount_no')?.value) <= 0) {
        this._alertService.warn('Actual cost should be more than $0.00.');
        this.purchaseRequestForm?.get('amount_no')?.reset();
        this.purchaseRequestForm.patchValue({
          amount_no : this.actualCost
        });
        this.isButtonClicked = false;
        return false;
      } else if (parseFloat(this.purchaseRequestForm?.get('amount_no')?.value) > actual_cost) {
        this._alertService.warn('Not allowed to approve more than 15% from the actual cost');
        this.purchaseRequestForm?.get('amount_no')?.reset();
        this.purchaseRequestForm.patchValue({
          amount_no : this.actualCost
        });
        this.isButtonClicked = false;
        return false;
      }

      this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.accountsPayable.ServiceLogApproval;
        const modal = {
           'case_id' : this.caseID,
           'fiscalcategorycd' : this.fiscal_category_cd,
           'costno' : this.purchaseRequestForm?.get('amount_no')?.value ? this.purchaseRequestForm?.get('amount_no')?.value : '0.00',
           'authorization_id' : this.authorization_id,
           'provider_id' : this.provider_id,
           'intakeserviceid' : this.intakeserviceid,
           'eventcode' : 'PCAUTH',
           'status' : 43,
           'startDt': this.startDate,
           'endDt': this.endDate,
           'payment_method_cd': this.purchaseRequestForm?.get('payment_method_cd')?.value,
           'type_1099_cd': this.purchaseRequestForm?.get('type_1099_cd')?.value,
           'store_receipt_id': this.purchaseRequestForm?.get('store_receipt_id')?.value,
           'report_1099_sw': this.reportCheck,
           'client_account_id': this.client_account_id,
           'bmanualrouting': this.otherCase,
           'v_securityusersid': this.user.user.userprofile.securityusersid

        };
      this._commonService.create(modal).subscribe(
          (response:any) => {
            if(response?.message === 'PAYMENT_EXISTS' && response?.code === 409) {
              this._alertService.info('Approval record already exists for this case. Please reload and try again!');
              return;
            }
              this._alertService.success('Approved successfully!');
              //(<any>$(this.approvalhistorypopupid)).modal('hide');
              this.purchaseRequestForm.reset();
              this.getPayableApproval();
              this.isButtonClicked = false;
              this.reportCheck = '';
              this.disableApprove = false;
              this.getPaymentDetail(this.authorization_id);
          },
          (error:any) => {
              this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
              this.isButtonClicked = false;
              this.reportCheck = '';
          }
      );
    }
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
  }

  downloadFile(s3bucketpathname:any) {
    s3bucketpathname = s3bucketpathname.replace(/,/g, '');
    const downldSrcURL =  '/api' + s3bucketpathname;
    window.open(downldSrcURL, '_blank');
  }

  handleAuthIdEvent(data:any){
    data = JSON.parse(data)
    this.onAuthId(data)
  }
  cfechange(value:any){
  // function was not added initial added the empty function during angular upgrade issue fix
  }
}