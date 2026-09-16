import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { Router, ActivatedRoute } from '@angular/router';
import { AuthService, AlertService, DataStoreService } from '../../../@core/services';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { FinanceService } from '../finance.service';
import { FinanceEmailConfig } from '../finance.email.config';

@Component({
    selector: 'provider-info-popup',
    host: {
        class: 'provider-info-popup'
    },
    templateUrl: './provider-info-popup.component.html',
    styleUrls: ['./provider-info-popup.component.scss'],
    standalone: false
})
export class ProviderInfoPopupComponent implements OnInit {
  alertTxt: string='';
  headerTxt: string='';
  currentvalue: any;
  userInfo: any;
  agency: any;
  checkAlertTxt: string='';
  reasonwithhold: string = '';
  providerHistory: any[]=[];
  quesWithhold:string = '';
  quesWithholdDisabled: boolean = false;
  confirmwithholdpaymentchangepopupid = '#confirm-withhold-payment-change';
  providerinfopopupid = '#provider-info-popup';
  withholdpayment = 'Withhold Payment (Returned Check)';
  electronicfundstransfer = 'Electronic Funds Transfer (EFT)';
  isTaxidHidden: boolean = true;
  ssnEye = 'fa-eye';
  showSsnMask = true;
  constructor(
    private _commonHttpService: CommonHttpService, private _router: Router,
    private _authService: AuthService, private _alertService: AlertService,
    private route: ActivatedRoute,
    private _dataStoreService: DataStoreService,
    public service: FinanceService
  ) { }

  ngOnInit() {

    this.userInfo = this._authService.getCurrentUser();
    this.service.userRoleKey = this.userInfo.role.key;
    this.service.userdescription =  this.userInfo.role.description;
    this.agency = this.userInfo.user.userprofile.teamtypekey;
  }

  toggleTax = () => {
    this.isTaxidHidden = !this.isTaxidHidden;
    if (this.isTaxidHidden) {
      this.ssnEye = 'fa-eye';
      this.showSsnMask = true;
    } else {
      this.ssnEye = 'fa-eye-slash';
      this.showSsnMask = false;
    }
  }

  quesWithholdChng() {
    if (this.service.isPaymentWithhold !== true) {
      if (this.quesWithhold === 'N' || this.reasonwithhold === '') {
        this.quesWithholdDisabled = true;
      }
      else {
        this.quesWithholdDisabled = false;
      }
    }
    else{
      if (this.reasonwithhold === '') {
        this.quesWithholdDisabled = true;
      }
      else {
        this.quesWithholdDisabled = false;
      }
    }
  }

  closePopup() {
    (<any>$(this.confirmwithholdpaymentchangepopupid)).modal('hide');
    (<any>$(this.providerinfopopupid)).modal('show');
  }
  changePaymentWithholding() {
    const payload :{[key:string]:any}= {};
    payload['provider_id'] = this.service.providerInfoDetails ? this.service.providerInfoDetails.provider_id : null;
    if (this.currentvalue === false) {
      // Reverse to the desired value
      payload['withhold_payment_sw'] = 'N';
    } else {
      payload['withhold_payment_sw'] = 'Y';
    }
    payload['withhold_reason'] = this.reasonwithhold;
    payload['withhold_question'] = this.quesWithhold ? this.quesWithhold : '';
    this._commonHttpService.create(
      payload,
      'tb_provider/updatepaymentwithold'
    ).subscribe(
      (response:any) => {
        this.triggerReleasePaymentSP();
        this._alertService.success('Payment withhold changed');
        this.service.markCheckStatus = this.service.markCheckStatus ? false : true;
        this.reasonwithhold = '';
        this.quesWithhold = 'N';
        (<any>$(this.confirmwithholdpaymentchangepopupid)).modal('hide');
        (<any>$(this.providerinfopopupid)).modal('show');
        this.service.getChangeLogList(this.service.providerInfoDetails ? this.service.providerInfoDetails.provider_id : null, { pageSize: 10, pageNumber: 1 });
        this.service.setPaymentWithholdCheckBox();
      },
      (error) => {
        this.service.isPaymentWithhold = this.currentvalue;
        this.reasonwithhold ='';
        this.quesWithhold = 'N';
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.confirmwithholdpaymentchangepopupid)).modal('hide');
        (<any>$(this.providerinfopopupid)).modal('show');
        this.service.setPaymentWithholdCheckBox();
      }
    );
  }
  triggerReleasePaymentSP() {
    this._commonHttpService.getArrayList(
      {
        where: { provider_id: this.service.providerInfoDetails.provider_id },
        method: 'get',
        nolimit: true
      },
      'tb_provider/updateReleasePayment?filter'
    ).subscribe();
  }

  changeEFT() {
    const modal = {
      provider_id: this.service.providerInfoDetails ? this.service.providerInfoDetails.provider_id : null,
      eft_sw: this.currentvalue ? 'Y' : 'N',
    };
    this._commonHttpService.create(
      modal,
      'tb_provider/updatepaymentwithold'
    ).subscribe(
      (response:any) => {
        this._alertService.success(this.checkAlertTxt);
        this.service.markEFT = this.service.markEFT ? true : false;
        (<any>$(this.confirmwithholdpaymentchangepopupid)).modal('hide');
        (<any>$(this.providerinfopopupid)).modal('show');
        this.service.getChangeLogList(this.service.providerInfoDetails ? this.service.providerInfoDetails.provider_id : null, { pageSize: 10, pageNumber: 1 });
      },
      (error) => {
        this.service.electronicfundtransfer = this.currentvalue;
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.confirmwithholdpaymentchangepopupid)).modal('hide');
        (<any>$(this.providerinfopopupid)).modal('show');
      }
    );
  }

  cancelConfirm() {
    if (this.headerTxt === this.withholdpayment) {
      this.service.isPaymentWithhold = !this.currentvalue;
    } else if (this.headerTxt === this.electronicfundstransfer) {
      this.service.electronicfundtransfer = !this.currentvalue;
    } else if (this.headerTxt === 'Electronic Funds Transfer (EFT) Change Alert') {
      this.service.electronicfundtransfer = !this.currentvalue;
      (<any>$(this.confirmwithholdpaymentchangepopupid)).modal('hide');
    }
    (<any>$(this.providerinfopopupid)).modal('show');
  }

  showConfirmPopup(index:any, value:any) {
    this.currentvalue = value;
    if (index === 1) {
      this.headerTxt = this.withholdpayment;
      this.checkAlertTxt = 'Payment Withhold updated';
      if (value === false) {
        this.alertTxt = 'Are you sure want to Release the payment? Please confirm.';
      } else {
        this.alertTxt = 'Are you sure want to Stop the payment? Please confirm.';
      }

      if (this.agency === 'FNS' || FinanceEmailConfig.EmailList_Private.includes(this.userInfo.user.email)) {
        (<any>$(this.providerinfopopupid)).modal('hide');
        (<any>$(this.confirmwithholdpaymentchangepopupid)).modal('show');
      } else {
        this.service.isPaymentWithhold = this.currentvalue;
      }
    }
    if (index === 2) {
      this.headerTxt = this.electronicfundstransfer;
      this.checkAlertTxt = 'Electronic Funds Transfer (EFT) updated';
      if (value === false) {
        this.alertTxt = 'Are you sure want to remove EFT check? Please confirm.';
      } else {
        this.alertTxt = 'Are you sure want to do EFT Check? Please confirm.';
      }
      this.IfFNSAgencyFn();
    }
    this.quesWithholdChng();
  }

  private IfFNSAgencyFn() {
    if (this.agency === 'FNS') {
      if (this.service.isPaymentWithhold && !this.currentvalue) {
        this.headerTxt = 'Electronic Funds Transfer (EFT) Change Alert';
        this.alertTxt = 'Please release Withhold Payment (Returned Check) before changing Electronic Funds Transfer (EFT)';
        (<any>$(this.providerinfopopupid)).modal('hide');
        (<any>$(this.confirmwithholdpaymentchangepopupid)).modal('show');
      } else {
        (<any>$(this.providerinfopopupid)).modal('hide');
        (<any>$(this.confirmwithholdpaymentchangepopupid)).modal('show');
      }
    }
  }

  saveConfirmPopup() {
    if (this.headerTxt === this.withholdpayment) {
      if (this.currentvalue) {
        this.changePaymentWithholding();
      } else {
        if (this.reasonwithhold) {
          this.changePaymentWithholding();
        } else {
          this._alertService.warn('Please Add reason!');
          return false;
        }
      }
    } else if (this.headerTxt === this.electronicfundstransfer) {
      this.changeEFT();
    }
  }

  navigateMaintenance(index:any) {
    (<any>$(this.providerinfopopupid)).modal('hide');
    if (index === 1) {
      this._router.navigate(['/pages/finance/finance-accountsPayable']);
    } else if (index === 2) {
      this._router.navigate(['/pages/finance/finance-accountsPayable/ancillary']);
    } else if (index === 3) {
      this._router.navigate(['/pages/finance/finance-accountsReceivable']);
    }
    this._dataStoreService.setData('FinanceProviderSearch', { providerId: this.service.providerInfoDetails ? this.service.providerInfoDetails.provider_id : null, page: this.service.page });
  }

  clearCache() {
    this.headerTxt = '';
    this.alertTxt = '';
    this.currentvalue = null;
    this.service.changeLogList = [];
    this.service.providerInfoDetails = '';
  }

  closeAddress() {
    (<any>$(this.providerinfopopupid)).modal('show');
    (<any>$('#address-history')).modal('hide');
  }

  addressHistory(providerid:any) { //provider-info-popup
    (<any>$(this.providerinfopopupid)).modal('hide');
    (<any>$('#address-history')).modal('show');
    this.providerHistory = [];
    this._commonHttpService.getArrayList({
      where: {
        provider_id: +providerid
      },
      method: 'get',
      nolimit: true,
  }, 'providerinfo/addresshistorydetails?filter'
  ).subscribe(response => {
    if (response) {
      this.providerHistory = response;
    }

  });

  }

  printProvider() {
    this.printElement(document.getElementById("printThis"));
  }
  printElement(elem:any) {

    var em = '<!DOCTYPE html><html><head><link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet"><link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"><link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">' +

      '<style>provider-info-popup .modal label { text-align: left; font-size: 13px; display: block; } .catagory-box mat-checkbox { display: block; } .modal .clsProviderPopup{ label{ text-align: left; font-size: 13px; } h5{ color: #000000 !important; } .sep-left{ border-left: 1px solid #d8d8d8; } .pl-20{ padding-left: 20px !important; } } .print-btn { outline: none; background: none; position: absolute; top: 13px; right: 40px; border: none; i { font-size: 22px; } }</style>'

      + '</head><body>';

    var innerHtml = elem.innerHTML;
    if(this.service.placement){
      innerHtml = innerHtml.replace('id="checkPla"','checked');}
    if(this.service.vendor){
      innerHtml = innerHtml.replace('id="checkVen"','checked');}
    if(this.service.community){
      innerHtml = innerHtml.replace('id="checkCom"','checked');}
    if(this.service.isPaymentWithhold){
      innerHtml = innerHtml.replace('id="checkIPW"','checked');}
    if(this.service.electronicfundtransfer){
      innerHtml = innerHtml.replace('id="checkEFT"','checked');}
    em = em + innerHtml;
    em = em + '</body><html>';
    var WindowObject = window.open("", "PrintWindow",
      "width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes");
    WindowObject?.document.write(em);
    WindowObject?.document.close();
    setTimeout(function () {
      WindowObject?.focus();
      WindowObject?.print();
      WindowObject?.close();
    }, 500);
  }
}

