import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService, DataStoreService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
@Component({
    selector: 'ytp-money-management',
    templateUrl: './ytp-money-management.component.html',
    styleUrls: ['./ytp-money-management.component.scss'],
    standalone: false
})
export class YtpMoneyManagementComponent implements OnInit {
  moneyManagementFormGroup!: FormGroup;
  moneymanagementShortTermGoals: any[] = [];
  moneyDoYouKnowItems: any;
  ytpData: any;
  store: any;

  constructor(private formBuilder: FormBuilder,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService) {
    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.moneyManagementFormGroup = this.formBuilder.group({
      ischeckingAccount: [null], // we need to change that to list checking or savings account.
      isSavingsAccount: [null],
      isNoAccount: [null],
      accountDesc: [null, Validators.required],
      receivedFreeCopy: [null, Validators.required],
      isInaccuracies: [null],
      sourceofIncome: [null, Validators.required],
      monthlyAmount: [null, Validators.required],
      keepingMonthlyBudget: [null, Validators.required],
      savingMoney: [null, Validators.required],
      currentAmountSaved: [null, Validators.required],
      goalAmount: [null, Validators.required]
    });

    this.moneyManagementFormGroup.disable();
    
    this.moneyManagementFormGroup.get('receivedFreeCopy')?.valueChanges.subscribe(val => {
      if(val === 1) {
        this.moneyManagementFormGroup.controls['isInaccuracies'].setValidators([Validators.required]);
        this.moneyManagementFormGroup.controls['isInaccuracies'].updateValueAndValidity();
      } else {
        this.moneyManagementFormGroup.controls['isInaccuracies'].clearValidators();
        this.moneyManagementFormGroup.controls['isInaccuracies'].updateValueAndValidity();
      }
    });
    
    this.moneyDoYouKnowItems = [{
      question: 'Your credit score?',
      value: null,
      comments: ''
    },
    {
      question: 'Why credit history is so important?',
      value: null,
      comments: ''
    },
    {
      question: 'The importance of having a bank account (i.e. savings/checking) and budgeting?',
      value: null,
      comments: ''
    }
    ];

    this.ytpData = this.store['YTPDATA'];
    if (this.ytpData && this.ytpData.moneymanagement_json) {
      this.moneyManagementFormGroup.patchValue(this.ytpData.moneymanagement_json);
      this.checkYtpGoalsFn();
      if (this.ytpData.moneymanagement_json.doyouknow) {
        this.checkYtpDoyouknowFn();
      }
    }
  }
  // Associated with ngOnInit function
  private checkYtpDoyouknowFn() {
    var moneyDoYouKnowItems = this.ytpData.moneymanagement_json.doyouknow;
    var oldQuestion = moneyDoYouKnowItems.find((t: { question: string; }) => t.question == 'Your credit score? Why credit history is so important?');
    moneyDoYouKnowItems = moneyDoYouKnowItems.filter((t: { question: string; }) => t.question !== 'Your credit score? Why credit history is so important?');
    moneyDoYouKnowItems = moneyDoYouKnowItems.concat(this.moneyDoYouKnowItems.filter((x: { question: any; }) => moneyDoYouKnowItems.every((y: { question: any; }) => y.question !== x.question)));
    if (oldQuestion) {
      moneyDoYouKnowItems.forEach((element: { question: any; value: any; comments: any; }) => {
        if (oldQuestion.question.indexOf(element.question) > -1) {
          element.value = oldQuestion.value;
          element.comments = oldQuestion.comments;
        }
      });
    }
    this.moneyDoYouKnowItems = moneyDoYouKnowItems;
  }
  // Associated with ngOnInit function
  private checkYtpGoalsFn() {
    if (this.ytpData.moneymanagement_json.goals) {
      this.moneymanagementShortTermGoals = this.ytpData.moneymanagement_json.goals;
      if (Array.isArray(this.moneymanagementShortTermGoals) && this.moneymanagementShortTermGoals.length) {
        this.moneymanagementShortTermGoals.forEach(item => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }

  save() {
    const data = this.moneyManagementFormGroup.getRawValue();
    data.goals = this.moneymanagementShortTermGoals;
    data.doyouknow = this.moneyDoYouKnowItems;

    let isCompleted = false;
    if (this.moneyManagementFormGroup.valid) {
      const filledQuestionsLength = this.moneyDoYouKnowItems.filter((question: { value: null; }) => question.value !== null).length;
      if (filledQuestionsLength === this.moneyDoYouKnowItems.length && data.goals.length > 0) {
        isCompleted = true;
      }
    }
    data.isCompleted = isCompleted;

    this._ytpService.patchData('moneymanagement_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].moneymanagement_json = data;
          this._alertservice.success('Money management details entered successfully!');
        },
        error => {
          this._alertservice.error('Error in entering money management details!');
        }
      );
  }

  clear() {
    this.moneyManagementFormGroup.reset();
  }

}
