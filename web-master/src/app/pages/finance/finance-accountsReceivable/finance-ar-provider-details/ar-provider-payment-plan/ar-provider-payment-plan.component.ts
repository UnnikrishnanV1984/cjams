import { Component, OnInit } from '@angular/core';
import { FinanceArProviderDetailsService } from '../finance-ar-provider-details.service';
import { CommonHttpService, AlertService, AuthService } from '../../../../../@core/services';
import { PaginationInfo } from '../../../../../@core/entities/common.entities';
import { FinanceUrlConfig } from '../../../finance.url.config';
import { FormGroup, FormBuilder } from '@angular/forms';
import { ManualPayment } from '../../../_entities/finance-entity.module';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import moment from 'moment';

declare let $: any;

@Component({
    selector: 'ar-provider-payment-plan',
    templateUrl: './ar-provider-payment-plan.component.html',
    styleUrls: ['./ar-provider-payment-plan.component.scss'],
    standalone: false
})
export class ArProviderPaymentPlanComponent implements OnInit {
  paymentPlans: any[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  pageInfo: PaginationInfo = new PaginationInfo();
  selectedPaymentPlan: any;
  paymentPlanForm!: FormGroup;
  totalcount!: number;
  totalAmount!: number;
  receivedAmount!: number;
  percentage!: number;
  percentageOffset!: number;
  noOfMonth!: number;
  placementexists:boolean=false;
  manualPaymentStore!: ManualPayment;
  payment_option_sw: string='';
  percentage_check: any;
  amount_check:boolean=false;
  month_check:boolean=false;
  isEdit:boolean=false;
  isValid: boolean = true;
  isButtonClicked = false;
  totalcountHistory: any;
  paymentPlansHistory: any[] = [];
  isVissbleButton:boolean=false;
  paymentplandetailspopupid = '#paymentplan-details';
  constructor(
    private _providerService: FinanceArProviderDetailsService,
    private _commonHttpService: CommonHttpService,
    private _formBuilder: FormBuilder,
    private _alertService: AlertService,
    public _authService: AuthService
  ) { }

  ngOnInit() {
    this.isVissbleButton = this._authService.isVissbleButton('read_only_access', '');
    this.getPaymentPlans();
    this.getPaymentPlansHistory();
    this.initPaymentPlanForm();
  }

  initPaymentPlanForm() {
    this.paymentPlanForm = this._formBuilder.group({
      entered_by: [null],
      start_dt: [null],
      amount_no: [null],
      end_dt: [null],
      current_receivable_amount: [null],
      percentage_no: [null],
      monthly_amount_active: [null],
      no_month_active: [null],
      months_no: [null],
      months_amount: [null],
      payment_option_sw: [null],
      offset_percentage: [null],
      month_check: [null],
      amount_check: [null],
      percentage_check: [null],
      reasons_tx: ['']
    });
    this.paymentPlanForm?.get('months_no')?.valueChanges.subscribe(data => {
      this.onChangeStartDate();
    });
  }
  getPaymentPlansHistory() {
    this._commonHttpService.getPagedArrayList({
      method: 'get',
      page: this.pageInfo.pageNumber,
      limit: this.pageInfo.pageSize,
      where: {
        providerid: this._providerService.providerid,
        is_history: 'Y'
      }
    },
    FinanceUrlConfig.EndPoint.accountsReceivable.paymentplan.list).subscribe((res: any) => {
      this.paymentPlansHistory = res;
      this.totalcountHistory = (this.paymentPlans && this.paymentPlans.length) ? this.paymentPlans[0].totalcount : 0;
    });
  }
  getPaymentPlans() {
    this._commonHttpService.getPagedArrayList({
      method: 'get',
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize,
      where: {
        providerid: this._providerService.providerid,
        is_history: 'N'
      }
    },
    FinanceUrlConfig.EndPoint.accountsReceivable.paymentplan.list).subscribe((res: any) => {
      this.paymentPlans = res;
      this.totalcount = (this.paymentPlans && this.paymentPlans.length) ? this.paymentPlans[0].totalcount : 0;
    });
  }

  viewPaymentPlan(paymentPlan: any) {
    this.isValid = true;
    this.isEdit = false;
    this.selectedPaymentPlan = paymentPlan;
    this.paymentPlanForm.reset();
    this.paymentPlanForm.patchValue(this.selectedPaymentPlan);
    this.paymentPlanForm.patchValue({
      months_amount : paymentPlan.amount_no ? paymentPlan.amount_no : '0.00'
    });
    if (!this.paymentPlanForm?.get('payment_option_sw')?.value && !paymentPlan.payment_option_sw) {
      this.paymentPlanForm.patchValue({
        payment_option_sw: 'A'
      });
      paymentPlan.payment_option_sw = 'A';
    }
    this.paymentPlanForm.disable();
    this.paymentPlanForm.disable();
    if (paymentPlan.placementexists) {
      this.placementexists = true;
       this.paymentPlanForm.disable();
       this.percentage = paymentPlan.percentage_no;
       this.receivedAmount = this.paymentPlanForm?.get('current_receivable_amount')?.value;
        this.totalAmount = +(this.receivedAmount * (this.percentage / 100)).toFixed(2);
        this.noOfMonth =  Math.round(this.receivedAmount / this.totalAmount);
        setTimeout(() => {
          this.paymentPlanForm.patchValue ({
            months_amount: this.totalAmount,
            months_no: this.noOfMonth
          });
          const startDate = moment(this.paymentPlanForm?.get('start_dt')?.value);
          const endDate = moment(startDate);
          endDate.add(this.paymentPlanForm?.get('months_no')?.value, 'months');
          this.paymentPlanForm.patchValue({
            end_dt: endDate
          });
        }, 100);
    }
    $(this.paymentplandetailspopupid).modal('show');
  }
  editPaymentPlan(paymentPlan: any) {
    this.isValid = true;
    this.isEdit = true;
    this.selectedPaymentPlan = paymentPlan;
    this.paymentPlanForm.reset();
    this.paymentPlanForm.patchValue(this.selectedPaymentPlan);
    this.paymentPlanForm.patchValue({
      months_amount : paymentPlan.amount_no ? paymentPlan.amount_no : '0.00'
    });
    this.paymentPlanForm.disable();
    if (!this.paymentPlanForm?.get('payment_option_sw')?.value && !paymentPlan.payment_option_sw) {
      this.paymentPlanForm.patchValue({
        payment_option_sw: 'A'
      });
      paymentPlan.payment_option_sw = 'A';
    }
    if (paymentPlan.placementexists) {
      this.placementexists = true;
       this.paymentPlanForm.disable();
       this.paymentPlanForm?.get('offset_percentage')?.setValue(paymentPlan.percentage_no);
       this.paymentPlanForm?.get('months_amount')?.setValue(0);
       this.paymentPlanForm?.get('percentage_no')?.setValue(0);
    } else if (paymentPlan.approvalstatus == '3047') {
      this.placementexists = false;
      if (paymentPlan.payment_option_sw === 'A') {
        this.percentage_check = true;
        this.onSelectPercentage();
      } else if (paymentPlan.payment_option_sw === 'B') {
          this.amount_check = true;
          this.onMonthlyAmount();
      } else if (paymentPlan.payment_option_sw === 'C') {
        this.month_check = true;
        this.onSelectNumberOfMonths();
      }
      this.paymentPlanForm?.get('payment_option_sw')?.enable();
      this.paymentPlanForm?.get('reasons_tx')?.enable();
    } else {
      this.paymentPlanForm.disable();
      this.placementexists = true;
    }
    if (this.paymentPlanForm?.get('payment_option_sw')?.value) {
      if (this.paymentPlanForm?.get('payment_option_sw')?.value === 'A') {
        this.calPercentage(this.paymentPlanForm?.get('percentage_no')?.value);
      } else if (this.paymentPlanForm?.get('payment_option_sw')?.value === 'B') {
        this.calMonthlyAmount(this.paymentPlanForm?.get('months_amount')?.value);
      } else if (this.paymentPlanForm?.get('payment_option_sw')?.value === 'C') {
        this.calNumberOfMonths(this.paymentPlanForm?.get('months_no')?.value);
      }
    }
    this.paymentPlanForm?.get('start_dt')?.enable();
    $(this.paymentplandetailspopupid).modal('show');
  }

  onChangeStartDate() {
    const startdate = this.paymentPlanForm?.get('start_dt')?.value;
    const month = this.paymentPlanForm?.get('months_no')?.value;
    if (startdate) {
      const enddate = moment(startdate).add(month, 'M');
      this.paymentPlanForm.patchValue({
        end_dt: enddate
      });
    }
  }

  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page;
    this.getPaymentPlans();
  }

  pageHistoryChanged(page: any) {
    this.pageInfo.pageNumber = page;
    this.getPaymentPlansHistory();
  }

  onSelectNumberOfMonths() {
    this.paymentPlanForm?.get('percentage_no')?.disable();
    this.paymentPlanForm?.get('months_no')?.enable();
    this.paymentPlanForm?.get('months_amount')?.disable();
    this.payment_option_sw = 'C';
  }

  calNumberOfMonths(events: any) {
    const event:any = events.target.value;
    this.noOfMonth = +event;
    this.receivedAmount = this.paymentPlanForm?.get('current_receivable_amount')?.value;
    this.totalAmount = +(this.receivedAmount / this.noOfMonth).toFixed(2);
    this.percentage = +((this.totalAmount / this.receivedAmount) * 100).toFixed(2);
    setTimeout(() => {
      this.handlePaymentPlanPatchFn();
    }, 100);
    this.validate();
  }

  calOffsetPercentage(event: any) {
    this.percentageOffset = +event;

    this.validate();
  }

  onSelectPercentage() {
    this.paymentPlanForm?.get('percentage_no')?.enable();
    this.paymentPlanForm?.get('months_no')?.disable();
    this.paymentPlanForm?.get('months_amount')?.disable();
    this.payment_option_sw = 'A';
  }

  calPercentage(events: any) {
    const event:any =events;
    this.percentage = +event;
    this.receivedAmount = this.paymentPlanForm?.get('current_receivable_amount')?.value;
    this.totalAmount = +(this.receivedAmount * (this.percentage / 100)).toFixed(2);
    this.noOfMonth =  Math.round(this.receivedAmount / this.totalAmount);
    setTimeout(() => {
      this.handlePaymentPlanPatchFn();
    }, 100);
    this.validate();
  }

  private handlePaymentPlanPatchFn() {
    this.paymentPlanForm.patchValue({
      amount_no: this.totalAmount,
      months_amount: this.totalAmount,
      percentage_no: this.percentage,
      months_no: this.noOfMonth
    });
  }

  private validate() {
    if (this.percentage < 2.78) {
      this.isValid = false;
      return this._alertService.warn('Minimum Inactive / Active status Percentage should be greater than 2.78%');
    } else if (this.percentage > 100) {
      this.isValid = false;
      return this._alertService.warn('Maximum Inactive / Active status Percentage should be lesser than 100%');
    } else if (this.noOfMonth > 36) {
      this.isValid = false;
      return this._alertService.warn('Maximum number months should be less than 36 months.');
    } else if (this.percentageOffset < 25) {
      return this._alertService.warn('Minimum Active status Percentage should be greater than 25%');
    } else if (this.percentageOffset > 100) {
      return this._alertService.warn('Maximum Active status Percentage should be lesser than 25%');
    }
    this.isValid = true;
  }

  onMonthlyAmount() {
    this.paymentPlanForm?.get('percentage_no')?.disable();
    this.paymentPlanForm?.get('months_no')?.disable();
    this.paymentPlanForm?.get('months_amount')?.enable();
    this.payment_option_sw = 'B';
  }

  calMonthlyAmount(events: any) {
    const event:any =events.target.value

    this.totalAmount = +event;
    this.receivedAmount = this.paymentPlanForm?.get('current_receivable_amount')?.value;
    this.noOfMonth = +Math.round(this.receivedAmount / this.totalAmount);
    this.percentage = +((this.totalAmount / this.receivedAmount) * 100).toFixed(2);
    setTimeout(() => {
      this.handlePaymentPlanPatchFn();
    }, 100);
  }

  savePayment() {
    this.isButtonClicked = true;
    this.validate();
    if (this.isValid) {
      setTimeout(() => {
        this._commonHttpService.endpointUrl = 'tb_payment_plan/paymentplanedit';
        this.manualPaymentStore = this.paymentPlanForm.getRawValue();
        this.manualPaymentStore.payment_option_sw = this.payment_option_sw;
        this.manualPaymentStore.placementexists = this.placementexists;
        this.manualPaymentStore.payment_plan_id = this.selectedPaymentPlan.payment_plan_id;
        this.manualPaymentStore.plan_dt = this.selectedPaymentPlan.plan_dt;
        this.manualPaymentStore.receivable_id = this.selectedPaymentPlan.receivable_id;
        this.manualPaymentStore.amount_no = this.totalAmount ? this.totalAmount : this.selectedPaymentPlan.amount_no;
        this.manualPaymentStore.offset_sw = this.selectedPaymentPlan.offset_sw;
        this.manualPaymentStore.offset_option_sw = this.selectedPaymentPlan.offset_option_sw;
        this.manualPaymentStore.securityusersid = this.selectedPaymentPlan.securityusersid;
        this._commonHttpService.create(this.manualPaymentStore).subscribe(
            (response:any) => {
              this._alertService.success('Payment Saved Successfully');
              $(this.paymentplandetailspopupid).modal('hide');
              this.getPaymentPlans();
              this.isButtonClicked = false;
            },
            (error) => {
              this.isButtonClicked = false;
              $(this.paymentplandetailspopupid).modal('hide');
              this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
          );
      }, 100);
    }
  }

}
