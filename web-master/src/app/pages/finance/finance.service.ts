import { Injectable } from '@angular/core';
import { CommonHttpService } from '../../@core/services/common-http.service';
import { Router, ActivatedRoute } from '@angular/router';
import { AuthService, AlertService } from '../../@core/services';
import { PaginationRequest } from '../../@core/entities/common.entities';
import { FinanceUrlConfig } from './finance.url.config';
import { FinanceEmailConfig } from './finance.email.config';
import { AppUser } from '../../@core/entities/authDataModel';
import { RoleGuard } from '../../@core/guard';

declare let $: any;

@Injectable()
export class FinanceService {
  providerInfoDetails: any;
  paymentAddress: any;
  businessAddress: any;
  providerId:any;
  isPaymentWithhold:boolean=false;
  withholdPaymntDisabled:boolean=false;
  electronicfundtransfer:boolean=false;
  userRoleKey:any;
  placement:boolean=false;
  vendor:boolean=false;
  community:boolean=false;
  _page: string='';
  changeLogList: any;
  totalcount: any;
  changeHistory:any[] = [];
  adjustment: any[]=[];
  overPayments: any;
  overpaymentvalue: any[]=[];
  userInfo!: AppUser;
  markCheckStatus:boolean=false;
  markEFT:boolean=false;
  validationMonth: any[]=[];
  screenid: any;
  screen: any;
  historyCount!: number;
  validationCount!: number;
  overpaymentCount!: number;
  adjustmentcount!: number;
  gaprate:boolean=false;
  gapsuspension:boolean=false;
  accountReceivable:boolean=false;
  placements:boolean=false;
  screenName: string='';
  userdescription: any;
  centralofficefiscalstaffrole = 'central office fiscal staff';
  centralofficefiscalsupervisorrole = 'central office fiscal supervisor';
  constructor(
    private _commonHttpService: CommonHttpService, private _router: Router,
    private _authService: AuthService, private _alertService: AlertService,
    private route: ActivatedRoute,
    private _roleGuard: RoleGuard
  ) { }

  getProviderDetails(providerID:any) {
    this.providerId = providerID;
    this._commonHttpService.getArrayList(new PaginationRequest({
    where: {
      provider_id: providerID
    },
    nolimit: true,
    method: 'get'
    }), 'providerinfo/financeproviderreport?filter').subscribe((result:any) => {
      if (result && result.length && result[0].financeproviderreport && result[0].financeproviderreport.length ) {
        this.providerInfoDetails = result[0].financeproviderreport[0];
        this.paymentAddress = this.returnPaymentAddressFn();
        this.businessAddress = this.returnBusinessAddressFn();
        this.isPaymentWithhold = this.returnIsPaymentWithholdFn();
        const resourcePermission = this._roleGuard.getPermissionsList();
        let checkStatus:boolean=false;
        if (resourcePermission) {
          checkStatus = (resourcePermission.filter((data:any) => data.name === 'manage_interfacestatus_update').length > 0);
        }
        this.userInfo = this._authService.getCurrentUser();
        this.setPaymentWithholdCheckBox();
        if (this.isPaymentWithhold) {
          this.reusableMarkCheckStatusFn(checkStatus, true, false);
        } else {
          this.reusableMarkCheckStatusFn(checkStatus, false, true);
        }
        this.electronicfundtransfer = this.providerInfoDetails.eft_sw === 'Y' ? true : false;
        if (this.electronicfundtransfer) {
          this.reusableMarkEFTFn(checkStatus, true, false);
        } else {
          this.reusableMarkEFTFn(checkStatus, false, true);
        }
        this.providerCategoryCdValidationFn();
      }
    });
  }

  private returnIsPaymentWithholdFn(): boolean {
    return this.providerInfoDetails.withhold_payment_sw === 'Y' ? true : false;
  }

  private returnBusinessAddressFn(): any {
    return this.providerInfoDetails.businessaddress ? this.providerInfoDetails.businessaddress[0].businessaddress : null;
  }

  private returnPaymentAddressFn(): any {
    return this.providerInfoDetails.paymentaddress ? this.providerInfoDetails.paymentaddress[0].paymentaddress : null;
  }

  private reusableMarkCheckStatusFn(checkStatus: boolean, condition1: boolean, condition2: boolean) {
    if (this.userInfo.role.name.trim().toLowerCase() === this.centralofficefiscalstaffrole ||
      this.userInfo.role.name.trim().toLowerCase() === this.centralofficefiscalsupervisorrole ||
      checkStatus) {
      this.markCheckStatus = condition1;
    } else {
      this.markCheckStatus = condition2;
    }
  }

  private reusableMarkEFTFn(checkStatus: boolean, condition1: boolean, condition2: boolean) {
    if (this.userInfo.role.name.trim().toLowerCase() === this.centralofficefiscalstaffrole ||
      this.userInfo.role.name.trim().toLowerCase() === this.centralofficefiscalsupervisorrole ||
      checkStatus) {
      this.markEFT = condition1;
    } else {
      this.markEFT = condition2;
    }
  }

  private providerCategoryCdValidationFn() {
    this.placement = false;
    this.vendor = false;
    this.community = false;
    this.providerInfoDetails.provider_category_cd.forEach((code:any) => {
      if (['1782', '1783', '3049', '3274', '3794', '3302'].includes(code.picklist_value_cd)) {
        this.placement = true;
      }
      if (code.picklist_value_cd === '3304') {
        this.vendor = true;
      }
      if (code.picklist_value_cd === '3305') {
        this.community = true;
      }
    });
    this.getChangeLogList(this.providerInfoDetails.provider_id, { pageSize: 10, pageNumber: 1 });
  }

  setPaymentWithholdCheckBox(){
    if (!this.isPaymentWithhold) {
      this.isPaymentWithholdIfCondFn();
    } else {
      for(var i = 0, len = this.providerInfoDetails.provider_category_cd.length; i < len; i++){
        if (['3302', '3274', '3049', '1782', '3794'].includes(this.providerInfoDetails.provider_category_cd[i].picklist_value_cd))
         {
          this.emailListPrivateFn();
          break;
         } else{
          this.emailListPublicFn();
        }
      }
    }
  }

  private emailListPublicFn() {
    if (this.userRoleKey == 'FNSFS' || FinanceEmailConfig.EmailList_Public.includes(this.userInfo.user.email)) {
      this.withholdPaymntDisabled = false;
    } else {
      this.withholdPaymntDisabled = true;
    }
  }

  private emailListPrivateFn() {
    if (FinanceEmailConfig.EmailList_Private.includes(this.userInfo.user.email)) {
      this.withholdPaymntDisabled = false;
    } else {
      this.withholdPaymntDisabled = true;
    }
  }

  private isPaymentWithholdIfCondFn() {
    if (this.checkUserDescriptionFn()) {
      this.withholdPaymntDisabled = false;
    } else {
      this.withholdPaymntDisabled = true;
    }
  }

  private checkUserDescriptionFn() {
    return this.userdescription == 'Central Office Fiscal Staff ,CW' || this.userdescription == 'Central Office Fiscal Supervisor' || FinanceEmailConfig.EmailList_Public.includes(this.userInfo.user.email);
  }

  getChangeLogList(providerid:any, paginationInfo:any) {
    this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
        limit: paginationInfo.pageSize,
        page: paginationInfo.pageNumber,
        method: 'get',
        where: {provider_id : providerid}
        }), 'withhold_eft_config/getwithholdchangelog?filter'
    ).subscribe((result: any) => {
      if (result) {
        this.changeLogList = result;
        this.totalcount = (this.changeLogList && this.changeLogList.length > 0) ? this.changeLogList[0].totalcount : 0;
      }
    });
  }

  public get page(): string {
    return this._page;
  }

  public set page(value: string) {
    this._page = value;
  }

  getChangeHistory(page:any, screenid:any, screen:any, overpayment?:any) {
    this.overpaymentvalue = [];
    this.screen = 'accountReceivable'; // As of now only in AR
    if (overpayment) {
      this.overpaymentvalue.push(overpayment);
    }
    this.changeHistory = [];
    this.historyCount = 0;
    this.screenid = screenid;
    this.screen = screen;
    this.screenName = 'accountReceivable';
    if (this.screen) {
      if (this.screen === 'gaprate' || this.screen === 'adoptionrate') {
       this.gaprate = true;
       this.placements = false;
       this.gapsuspension = false;
       this.accountReceivable = false;
      } else if (this.screen === 'gapsuspension' || this.screen === 'adoptionsuspension') {
        this.gaprate = false;
        this.placements = false;
        this.gapsuspension = true;
        this.accountReceivable = false;
      } else if (this.screen === 'accountReceivable') {
        this.gaprate = false;
        this.placements = false;
        this.gapsuspension = false;
        this.accountReceivable = true;
      } else if (this.screen === 'placement') {
        this.gaprate = false;
        this.placements = true;
        this.gapsuspension = false;
        this.accountReceivable = false;
      }
   }
    this._commonHttpService.getPagedArrayList({
      where: {
        screenid: screenid,
        screen: this.screenName
      },
      page: page,
      limit: 10,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsReceivable.audit.auditList).subscribe((res: any) => {
      if (this.returnspAuditLogChangeHistory(res)) {
        this.screenCheckFn(res, screen);
        this.historyCount = (this.changeHistory && this.changeHistory.length > 0) ? this.changeHistory[0]?.total_count : 0;
        $('#historyPlacement').modal('hide');
        $('#overpayment-details').modal('hide');
        $('#fiscal-audit').modal('show');
        this.getSelectedFiscalDetails(this.changeHistory[0], 0);
      }
    });
  }
  //Associated with getChangeHistory function
  private returnspAuditLogChangeHistory(res: any) {
    return res && res.data && res.data.length && res.data[0].sp_audit_log_change_history && res.data[0].sp_audit_log_change_history.length;
  }
  //Associated with getChangeHistory function
  private screenCheckFn(res: any, screen: any) {
    if (this.screenName === 'accountReceivable') {
      this.auditLogChangeHistoryReceivableCondFn(res);
    } else if (screen === 'placement') {
      this.placementScreenConditionFn(res);
    } else if (screen === 'gaprate') {
      this.gaprateScreenConditionFn(res);
    } else if (screen === 'gapsuspension') {
      this.gapsuspensionScreenConditionFn(res);
    } else if (screen === 'adoptionrate') {
      this.adoptionrateScreenConditionFn(res);
    } else if (screen === 'adoptionsuspension') {
      this.adoptionsuspensionScreenConditionFn(res);
    } else if (screen === 'accountReceivable') {
      this.auditLogChangeHistoryReceivableCondFn(res);
    }
  }
  //Associated with getChangeHistory function
  private adoptionsuspensionScreenConditionFn(res: any) {
    if (res.data[0].sp_audit_log_change_history[0].sp_audit_log_adoptionsuspension_changes && res.data[0].sp_audit_log_change_history[0].sp_audit_log_adoptionsuspension_changes.length) {
      this.changeHistory = res.data[0].sp_audit_log_change_history[0].sp_audit_log_adoptionsuspension_changes;
    }
  }
  //Associated with getChangeHistory function
  private adoptionrateScreenConditionFn(res: any) {
    if (res.data[0].sp_audit_log_change_history[0].sp_audit_log_adoptionrate_changes && res.data[0].sp_audit_log_change_history[0].sp_audit_log_adoptionrate_changes.length) {
      this.changeHistory = res.data[0].sp_audit_log_change_history[0].sp_audit_log_adoptionrate_changes;
    }
  }
  //Associated with getChangeHistory function
  private gapsuspensionScreenConditionFn(res: any) {
    if (res.data[0].sp_audit_log_change_history[0].sp_audit_log_gapsuspension_changes && res.data[0].sp_audit_log_change_history[0].sp_audit_log_gapsuspension_changes.length) {
      this.changeHistory = res.data[0].sp_audit_log_change_history[0].sp_audit_log_gapsuspension_changes;
    }
  }
  //Associated with getChangeHistory function
  private gaprateScreenConditionFn(res: any) {
    if (res.data[0].sp_audit_log_change_history[0].sp_audit_log_gaprate_changes && res.data[0].sp_audit_log_change_history[0].sp_audit_log_gaprate_changes.length) {
      this.changeHistory = res.data[0].sp_audit_log_change_history[0].sp_audit_log_gaprate_changes;
    }
  }
  //Associated with getChangeHistory function
  private placementScreenConditionFn(res: any) {
    if (res.data[0].sp_audit_log_change_history[0].sp_audit_log_placement_changes && res.data[0].sp_audit_log_change_history[0].sp_audit_log_placement_changes.length) {
      this.changeHistory = res.data[0].sp_audit_log_change_history[0].sp_audit_log_placement_changes;
    }
  }
  //Associated with getChangeHistory function
  private auditLogChangeHistoryReceivableCondFn(res: any) {
    if (res.data[0].sp_audit_log_change_history[0].sp_audit_log_change_history_account_receivable &&
      res.data[0].sp_audit_log_change_history[0].sp_audit_log_change_history_account_receivable.length) {
      this.changeHistory = res.data[0].sp_audit_log_change_history[0].sp_audit_log_change_history_account_receivable;
    }
  }

  getSelectedFiscalDetails(changeHistory:any, index:any) {
    if (changeHistory) {
      setTimeout(() => {
        $('.fiscal-details-view tr').removeClass('selected-bg');
        $(`#fiscal-details-view-${index}`).addClass('selected-bg');
      }, 100);
      this.getFiscalAuditAdjustment(1, changeHistory.revision_id, changeHistory.change_type_cd);
      this.getFiscalAudit(null, 1, changeHistory.revision_id, changeHistory.change_type_cd);
    }
  }

  getFiscalAudit(clientID:any, page:number, eventID:any, eventType:any) {
    this.validationMonth = [];
    this.validationCount = 0;
    this._commonHttpService.getPagedArrayList({
      where: {
        event_type_cd: eventType ? eventType : null,
        event_id: eventID ? eventID : null
      },
      page: page,
      limit: 10,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsReceivable.audit.placement_validation).subscribe((result: any) => {
        if (result && result.data && result.data.length > 0) {
          this.validationMonth = result.data;
          this.validationCount = this.validationMonth ? this.validationMonth[0].totalcount : 0;
        }
    });
  }

  getFiscalAuditOverPayment(page:number, eventID:any, eventType:any) {
    this.overpaymentvalue = [];
    this.overpaymentCount = 0;
    this._commonHttpService.getPagedArrayList({
      where: {
        event_type_cd: eventType ? eventType : null,
        event_id: eventID ? eventID : null
      },
      page: page,
      limit: 10,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsReceivable.audit.overpayments).subscribe((result: any) => {
        if (result && result.data && result.data.length > 0) {
          this.overpaymentvalue = result.data;
          this.overpaymentCount = this.overpaymentvalue ? this.overpaymentvalue[0].totalcount : 0;
        }
    });
  }
  getFiscalAuditAdjustment(page:number, eventID:any, eventType:any) {
    this.adjustment = [];
    this.adjustmentcount = 0;
    this._commonHttpService.getPagedArrayList({
      where: {
        event_type_cd: eventType ? eventType : null,
        event_id: eventID ? eventID : null
      },
      page: page,
      limit: 10,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsReceivable.audit.adjustment).subscribe((result: any) => {
        if (result && result.data && result.data.length > 0) {
          this.adjustment = result.data;
          this.adjustmentcount = this.adjustment ? this.adjustment[0].totalcount : 0;
        }
    });
  }
}
