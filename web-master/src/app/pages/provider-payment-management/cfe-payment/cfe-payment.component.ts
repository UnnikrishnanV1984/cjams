import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms'
import { of as observableOf, Observable } from 'rxjs';
import { map, tap } from 'rxjs/operators';
import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { AlertService, AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../@core/services';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { FinanceAdjustment } from '../../finance/finance.constants';
import { FinanceUrlConfig } from '../../finance/finance.url.config';
import moment from 'moment';

@Component({
    selector: 'cfe-payment',
    templateUrl: './cfe-payment.component.html',
    styleUrls: ['./cfe-payment.component.scss'],
    standalone: false
})
export class CfePaymentComponent implements OnInit {

  paginationInfo: PaginationInfo = new PaginationInfo();
  pagination: PaginationInfo = new PaginationInfo();
  providerscount!: number;
  cfePaymentForm !: FormGroup;
  providerSearchForm !: FormGroup;
  searchProviderData: boolean = false;
  providersList!: any
  private token!: AppUser;
  searchPlan!: any;
  saveService?: boolean;
  addAncillaryServicesForm!: FormGroup;
  ReferredServices$!: Observable<any[]>;
  approvalHistory!: any;
  isSupervisor!: boolean;
  isCaseWorker!: boolean;
  ancillaryServicesList: any = [];
  disableSave: boolean = false;
  supervisorsList!: any[];
  approveBtnTxt!: string;
  ancillaryServicesId!: string;
  purchaseRequestForm!: FormGroup;
  paymentMethod$!: Observable<DropdownModel[]>;
  paymentType$!: Observable<DropdownModel[]>;
  paymentType: any[] = [];
  reportCheck!: string;
  user!: AppUser;
  userID!: string;
  isFinanceSupervisor!: boolean;
  isFinanceWorker!: boolean;
  activeModule!: any;
  roletype!: string;
  requestSubmited: boolean = false;
  approvalHistoryList!: any[];
  fundingunderreview = 'Funding Under Review';
  paymentunderreview = 'Payment Under Review';
  paymentapproved = 'Payment Approved';
  constructor( 
    private formBuilder: FormBuilder,
    private _commonHttpService: CommonHttpService,
    private _authService: AuthService,
    private _alert: AlertService,
    private _datastoreService: DataStoreService,
    private _sessionStorage: SessionStorageService
  ) { 
      
  }

  ngOnInit() {
    this.paginationInfo.pageNumber = 1;
    this.token = this._authService.getCurrentUser();
    this.ancillaryServicesId = this._datastoreService.getData(FinanceAdjustment.AncillaryServicesId);
    this.isSupervisor = (this.token.role.name === AppConstants.ROLES.SUPERVISOR) ? true !: false;
    this.isCaseWorker = (this.token.role.name === AppConstants.ROLES.CASE_WORKER) ? true !: false;
    this.pagination.pageNumber = 1;
    this.loadInfo();
    this.formInitialize();
    this.getPaymentMethod();
    this.getPaymentType();
  }

  loadInfo() {
    this.userID = this.token.user.securityusersid;
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.paginationInfo.pageNumber = 1;
    if (this.activeModule === 'Finance Approval') {
      this.roletype = 'FNSFS';
      this.isFinanceSupervisor = true;
      this.isFinanceWorker = false;
    } else if (this.activeModule === 'Finance') {
      this.roletype = 'FNSFW';
      this.isFinanceSupervisor = false;
      this.isFinanceWorker = true;
    } else {
      this.roletype = 'FNSDF';
      this.isFinanceSupervisor = false;
      this.isFinanceWorker = false;
    }
    this.listAncillaryServices();
  }

  private formInitialize() {
    this.purchaseRequestForm = this.formBuilder.group({
      payment_method_cd: [null, Validators.required],
      type_1099_cd: [null, Validators.required],
      // amount_no!: [null],
      store_receipt_id: [null],
      actualAmount: [null],
      payment_id: [{value: null, disabled:true}],
      report_1099_sw: ['']
    });

    this.purchaseRequestForm?.get('payment_id')?.disable();

    this.providerSearchForm = this.formBuilder.group({
        providerid: '',
        providername: ['', Validators.pattern(/^[A-Za-z][A-Za-z0-9 ]*$/)],
        taxid: '',
        zipcode: ''
    });

    this.addAncillaryServicesForm = this.formBuilder.group({
          ancillaryservicesid: [null],
          paymenttype : [null],
          startdate: [{value: null}],
          enddate: [{value: null}],
          noofbeds: [null],
          providerserviceid: [null],
          alternateid: [{value: null, disabled:true}],
          comments: [null],
          financecategorydescriptionwithcode: [{value: null, disabled:true}],
          costnotexceed: [{value:null, disabled:true}],
          approvalstatus: [{value: null, disabled:true}],
          approvedby: [null],
    });
  }

  listAncillaryServices() {
    this._commonHttpService.getPagedArrayList(
        new PaginationRequest({
            where: { 
              securityuserid: this.token.user.securityusersid,
              userrole: this.isFinanceSupervisor ? 'FS' !: 'FW',
              status: null,
              pagenumber : this.paginationInfo.pageNumber,
              pagesize : this.paginationInfo.pageSize,
            },
            method: 'post'
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.AncillaryServices.list
    )
    .subscribe(result => {
        this.ancillaryServicesList = (result.data) ? result.data : [];
        const list = this.ancillaryServicesList.filter((item: any) => item.ancillaryservicesid === this.ancillaryServicesId)
        if(list?.length && !this.requestSubmited) {
          this.editPurchase(list[0], 'Edit')
        }
    });
  }

  loadSupervisor() {
    this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
                where: { appevent: 'CWIF'
            },
                method: 'post'
            }),
            'Intakedastagings/getroutingusers'
        )
        .subscribe(result => {
            this.supervisorsList = result.data;
            this.supervisorsList = this.supervisorsList.filter(
                users => users.rolecode === 'SP'
            );
        });
  }

  searchProviders() {
    if(this.providerSearchForm.invalid){
      return;
    }
    this.providerscount = 0;
    this.searchProviderData = true;
    const providerId = this.providerSearchForm?.get('providerid')?.value ?? '';
    const providerName = this.providerSearchForm?.get('providername')?.value ?? '';
    const taxid = this.providerSearchForm?.get('taxid')?.value ?? '';
    const zipcode = this.providerSearchForm?.get('zipcode')?.value ?? '';

    this.ReferredServices$ = this._commonHttpService
            .getArrayList(
                {
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.VendorServiceSearch + '?providerId=' + providerId +
                '&providerName=' + providerName +
                '&taxId=' + taxid +
                '&zipCd=' + zipcode +
                '&page=' + this.pagination.pageNumber +
                '&limit=' + this.pagination.pageSize +
                '&filtertype=cfe'
            ).pipe(
              map((res :any) => {
                  if (res && res['UserToken'].length > 0) {
                      this.providerscount = (res['UserToken'] && res['UserToken'].length > 0) ? res['UserToken'][0].totalcount !: 0;
                      return res['UserToken'];
                  }
              }));
     
  }

  clearProviders() {
    this.providerSearchForm.reset();
    this.searchProviderData = false;
    this.searchPlan = null;
  }

  selectedProv(searchPlan:any) {
    this.searchPlan = searchPlan;
    this.addAncillaryServicesForm.patchValue({
      providerserviceid: searchPlan.provider_service_id,
    })
  }

  openAddNewPopup() {
    this.providerSearchForm.reset();
    this.clearProviders();
    (<any>$('#create-new-service')).modal('show');
  }

  pageChanged(pageNumber: number) {
    this.paginationInfo.pageNumber = pageNumber;
    this.listAncillaryServices();
  }

  providerPageChanged(pageNumber: number) {
    this.paginationInfo.pageNumber = pageNumber;
    this.listAncillaryServices();
  }
  
  resetServiceDetail() {
    this.saveService = false;
    this.addAncillaryServicesForm.reset();
    this.addAncillaryServicesForm.enable();
  }

  selectPurchase(isNew:any){
    this.loadSupervisor();
    if(isNew) {
      this.disableSave = false;
      this.approvalHistory = null;
    }
    (<any>$('#add-ancillary-services')).modal('show');
  }

  closeAncillaryFormPopup(popup:any) {
    (<any>$(popup)).modal('hide');
  }

  changeSupervisor($event:any) {
    if ($event && $event.value) {
        this.addAncillaryServicesForm.patchValue({approvedby: $event.value});
    }
  }

  submitPurchase(approvalStatus:any) {
    
    const formData = this.addAncillaryServicesForm.getRawValue();
    formData.approvalstatus = approvalStatus;
    formData.securityuserid = this.token.user.securityusersid;
    if(formData.approvalstatus === 111) {
      formData.approvedby = formData.securityuserid;
    } else if(approvalStatus === 113) {
      formData.purchaserequest = this.purchaseRequestForm.getRawValue();
      formData.purchaserequest.authorizationid = formData.alternateid
      formData.purchaserequest.securityuserid = formData.securityuserid
    }

    this._commonHttpService.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.AncillaryServices.AddUpdate).subscribe(
        (response) => {
            if (response.success) {
              this._alert.success(response.message);
              if(approvalStatus !== 113) {
                (<any>$('#add-ancillary-services')).modal('hide');
              } else {
                this.purchaseRequestForm.patchValue({
                  payment_id: response.paymentid
                }) 
                this.purchaseRequestForm.disable();
                this.disableSave = true;
              }
              this.requestSubmited = true;
              this.listAncillaryServices();
            } else {
              this._alert.warn(response.message);
            }
        },
        (error) => {
            this._alert.warn('Please try again later');
        }
    );
  }

  editPurchase(modal:any, type:any) {
    this.selectedProv({
      "NAME": modal.providerinfo?.providername,
      "ID": modal.providerinfo?.providerid,
      "address": modal.providerinfo?.provider_adr,
      "taxid": modal.providerinfo?.taxid
    });
    if(type === 'view') {
      this.disableSave = true;
      this.addAncillaryServicesForm.disable();
      this.purchaseRequestForm.disable();
    } else {
      this.addAncillaryServicesForm.enable();
      this.purchaseRequestForm.enable();
      this.addAncillaryServicesForm.controls.financecategorydescriptionwithcode.disable();
      this.addAncillaryServicesForm.controls.alternateid.disable();
      this.addAncillaryServicesForm.controls.approvalstatus.disable();
      this.disableSave = false;
      this.repotCheck(false);
    }
    this.approveBtnTxt = (this.isSupervisor) ? 'Send for Finance Approval' !: '' 
    if(modal?.routinginfo?.length) {
      this.modalRoutingFn(modal);
    }

    if(modal.purchasedetails) {
      this.purchaseRequestForm.patchValue(modal.purchasedetails)
    }
    this.purchaseRequestForm.patchValue({
      payment_id: modal.paymentid
    }); 
    this.purchaseRequestForm?.get('payment_id')?.disable();
    this.addAncillaryServicesForm.patchValue(modal);
    this.selectPurchase(false);
    
    if(this.addAncillaryServicesForm.get('paymenttype')?.value === '27') {
      this.addAncillaryServicesForm.get('paymenttype')?.disable();
      this.addAncillaryServicesForm.get('startdate')?.disable();
      this.addAncillaryServicesForm.get('enddate')?.disable();
      this.addAncillaryServicesForm.get('noofbeds')?.disable();
      this.addAncillaryServicesForm.get('costnotexceed')?.disable();
      if(this.isFinanceSupervisor ) {
        this.purchaseRequestForm.get('report_1099_sw')?.setValue(true);
        this.purchaseRequestForm?.patchValue({type_1099_cd: '3159'});
        this.purchaseRequestForm.get('report_1099_sw')?.disable();
        this.purchaseRequestForm.get('type_1099_cd')?.disable();
      }
    }
  }

  private modalRoutingFn(modal: any) {
    this.approvalHistory = modal.routinginfo;
    this.addAncillaryServicesForm.patchValue({
      approvedby: this.approvalHistory[0].fromsecurityusersid
    });
    if (this.approvalHistory[0].routingstatustypeid === 62) {
      this.approvalHistory.splice(0, 1);
    }
    this.approvalHistoryList = [];
    this.approvalHistory.forEach((item:any, i:any) => {
      if (i !== this.approvalHistory.length - 1) {
        this.approveHistoryIfConditionFn(item, i);
      }
      item.statustext = this.getHistoryStatus(item);
      item.approvername = (item.statustext === this.fundingunderreview || item.statustext === this.paymentunderreview) ? '' !: item.approvername;
      item.torole = (item.statustext === this.fundingunderreview || item.statustext === this.paymentunderreview) ? '' !: item.torole;
      if (item.routingstatustypeid !== 113) {
        this.approvalHistoryList.push(item);
      }
    });
  }

  private approveHistoryIfConditionFn(item: any, i: any) {
    item.requestorname = this.approvalHistory[i + 1].approvername;
    if (item.routingstatustypeid !== 112 && item.routingstatustypeid !== 113) {
      item.fromrole = this.approvalHistory[i + 1].torole;
    } else {
      this.approvalHistory[i + 1].torole = item.fromrole;
    }
  }

  getStatusFromList(modal:any) {
    let status = 'Draft';
    if(modal && modal.length > 0) {
      status = this.getStatus(modal[0])
    }
    return status; 
  }

  getHistoryStatus(modal:any) {
    let status = 'Draft';
    const typid = modal?.routingstatustypeid;
    if(typid === 62) {
      status = 'Rejected';
    } else if(typid === 113) {
      status = this.paymentapproved;
    } else if(typid === 112) {
      status = (modal?.nextroutingstatustypeid === 113) ? this.paymentapproved !: this.paymentunderreview;
    } else if(typid === 111) {
      status = (modal?.nextroutingstatustypeid === 112) ? 'Funding Approved' !: this.fundingunderreview;
    }else if(typid === 110) {
      status = (modal?.nextroutingstatustypeid === 111) ? 'Approved' !: 'Review';
    } 
    return status;
  }

  getStatus(modal:any) {
    let status = 'Draft';
    const typid = (modal?.nextroutingstatustypeid) ? modal?.nextroutingstatustypeid !: modal?.routingstatustypeid;
    if(typid === 62) {
      status = 'Rejected';
    } else if(typid === 113) {
      status = this.paymentapproved;
    } else if(typid === 112) {
      status = (modal?.routingstatustypeid === 112) ? this.paymentunderreview !: 'Approved';
    } else if(typid === 111) {
      status = this.fundingunderreview;
    }else if(typid === 110) {
      status = 'Review';
    } 
    return status;
  }

  costNotExceedCalc(val: Event) {
    const modal: any = (val.target as HTMLInputElement).value;
    this.addAncillaryServicesForm.patchValue({
      costnotexceed: modal * 100
    })
  }

  getPaymentMethod() {
    this.paymentMethod$ = this._commonHttpService.getArrayList({
      where: {picklist_type_id: '1'},
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe( map((result: any) => {
      return result.map(
          (res: { description_tx: any; picklist_value_cd: any; }) =>
              new DropdownModel({
                  text: res.description_tx,
                  value: res.picklist_value_cd
              })
      );
    }));
  }

  getPaymentType() {
    if(this.paymentType?.length === 0) {
      this.paymentType$ = this._commonHttpService.getArrayList({
        where: { picklist_type_id: '308' },
        nolimit: true,
        method: 'get'
      }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
      ).pipe(
        map((result: any[]) => result
          .filter((res: any) => !(res.value_tx === 'N/A' && res.picklist_value_cd === '3158'))
          .map(res =>
            new DropdownModel({
              text: res.value_tx,
              value: res.picklist_value_cd
            })
          )
        ),
        tap((paymentTypes: DropdownModel[]) => {
          this.paymentType = paymentTypes;
          const paymentTypeValue = this.addAncillaryServicesForm?.get('paymenttype')?.value;
          const type1099Control = this.purchaseRequestForm.get('type_1099_cd');
          if (paymentTypeValue === '27' && this.isFinanceSupervisor) {
            this.purchaseRequestForm.get('report_1099_sw')?.setValue(true);
            this.purchaseRequestForm.get('report_1099_sw')?.disable();
            type1099Control?.setValue('3159');
            type1099Control?.disable();
          } else {
            type1099Control?.enable();
          }
        })
      );
    }
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
    }
  }

  documentGenerate(ancillaryservicesid:any, authorization_id:any) {
      const modal = {
        count: -1,
        where: {
            documenttemplatekey: ['cfebedretainerpayment'],
            ancillaryservicesid: ancillaryservicesid
        },
        method: 'post'
      };
      this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
    .subscribe(res => {
      const blob = new Blob([new Uint8Array(res)]);
      const link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob);
      const timestamp = moment(new Date()).format('MM/DD/YYYY HH!:mm!:ss');
      link.download = 'Provider-Ancillary-Payments-Form-' + authorization_id + '.' + timestamp + '.pdf';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
  }


}