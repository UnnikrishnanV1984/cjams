import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService, DataStoreService, CommonDropdownsService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import { DropdownModel } from '../../../../../../@core/entities/common.entities';
import { Observable } from 'rxjs';

@Component({
    selector: 'ytp-money-management',
    templateUrl: './ytp-money-management.component.html',
    styleUrls: ['./ytp-money-management.component.scss'],
    standalone: false
})
export class YtpMoneyManagementComponent implements OnInit {
  moneyManagementFormGroup!: FormGroup;
  moneymanagementShortTermGoals = [];
  actionToDoItems = [];
  moneyDoYouKnowItems: any;
  ytpData: any;
  mandatoryFields=false;
  store: any;
  IncomeFrequencyDropDownItem$!: Observable<DropdownModel[]>;
  isDisabled: boolean = false;
  IncomeFrequencyDropDownItem: any;
  frequencyMap: Map<string, string> = new Map();
  reverseFrequencyMap: Map<string, string> = new Map();

  constructor(private formBuilder: FormBuilder,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _commonDropdownService: CommonDropdownsService,
    private _dataStoreService: DataStoreService) {
    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.moneyManagementFormGroup = this.formBuilder.group({
      financeGoal: [null],
      allowanceAmount: [null],
      allowanceWeekly: [null], 
      allowanceSelection: [null],
      partTimeAmount: [null], 
      partTimeWeekly: [null], 
      benefitsAmount: [null], 
      benefitsWeekly: [null], 
      silaAmount: [null], 
      silaWeekly: [null], 
      inheritanceAmount: [null], 
      inheritanceWeekly: [null], 
      otherAmount: [null], 
      otherWeekly: [null], 
      ableAccount: [null], 
      withCareGiver: [null], 
      atHome: [null], 
      atBank: [null], 
      atSntTrust: [null], 
      ischeckingAccount: [null], // we need to change that to list checking or savings account.
      isSavingsAccount: [null],
      isNoAccount: [null],
      isDebitCard: [null],
      accountDesc: [null],
      otherDesc: [null],
      currentAmountSaved: [null, Validators.required],
      goalAmount: [null],
      savingMoney: [null],
      keepingMonthlyBudget: [null],
      creditReviewed: [null],
      dtCreditReviewd: [null],
      debtOwed: [null],
      notes: [null],
      financialGoals: [null],
    });
    this.IncomeFrequencyDropDownItem$ = this._commonDropdownService.getPickListByName('frequencyofincomereceipt');
    this.IncomeFrequencyDropDownItem$.subscribe((data: any) => {
      this.IncomeFrequencyDropDownItem = data;
      
      data.forEach((item: { description: string; ref_key: string; }) => {
        this.frequencyMap.set(item.description, item.ref_key);
        this.reverseFrequencyMap.set(item.ref_key, item.description);
      });
      
      this.loadYtpData();
    });
  }
  
  private loadYtpData() {
    this.ytpData = this.store['YTPDATA'];
    this.isDisabled = this.ytpData.approvalstatuskey == 'Pending' || this.ytpData.approvalstatuskey == 'Approved';
    
    if (this.ytpData && this.ytpData.new_financial_empowerment_json) {
      const rawData = {...this.ytpData.new_financial_empowerment_json};
      
      // Convert string descriptions to ref_keys for dropdown binding
      const frequencyFields = [
        'allowanceWeekly', 'partTimeWeekly', 'benefitsWeekly', 
        'silaWeekly', 'inheritanceWeekly', 'otherWeekly'
      ];
      
      frequencyFields.forEach(field => {
        const descValue = rawData[field];
        if (descValue && this.frequencyMap.has(descValue)) {
          rawData[field] = this.frequencyMap.get(descValue);
        }
      });
      
      this.moneyManagementFormGroup.patchValue(rawData);
      
      this.toggleValidationForAccountDesc();
      this.checkYtpGoalsFn();
      this.checkYtpActionToDoItemsFn();
 
      
      if (this.ytpData.new_financial_empowerment_json.doyouknow) {
        this.checkYtpDoyouknowFn();
      }
    }
  }
  // Associated with ngOninit method
  private checkYtpDoyouknowFn() {
    var moneyDoYouKnowItems = this.ytpData.new_financial_empowerment_json.doyouknow;
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
  // Associated with ngOninit method
  private checkYtpActionToDoItemsFn() {
    if (this.ytpData.new_financial_empowerment_json.actionToDoItems) {
      this.actionToDoItems = this.ytpData.new_financial_empowerment_json.actionToDoItems;
      if (Array.isArray(this.actionToDoItems) && this.actionToDoItems.length) {
        this.actionToDoItems.forEach((item: any) => {
          item.start_date = item.start_date ? new Date(item.start_date) : '';
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }
  // Associated with ngOninit method
  private checkYtpGoalsFn() {
    if (this.ytpData.new_financial_empowerment_json.goals) {
      this.moneymanagementShortTermGoals = this.ytpData.new_financial_empowerment_json.goals;
      if (Array.isArray(this.moneymanagementShortTermGoals) && this.moneymanagementShortTermGoals.length) {
        this.moneymanagementShortTermGoals.forEach((item: any) => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }

  changeValidationForAccountDesc(event: any) {
    this.toggleValidationForAccountDesc();
  }

  toggleValidationForAccountDesc() {
    const checked = ["ischeckingAccount", "isSavingsAccount", "isDebitCard"].some(field => this.moneyManagementFormGroup.controls[field].value);
    this.moneyManagementFormGroup.controls['accountDesc'].setValidators(checked ? [Validators.required] : []);
    this.moneyManagementFormGroup.controls['accountDesc'].updateValueAndValidity();
  }


  save() {
    this.mandatoryFields=true;
    const formData = this.moneyManagementFormGroup.getRawValue();
    
    const frequencyFields = [
      'allowanceWeekly', 'partTimeWeekly', 'benefitsWeekly', 
      'silaWeekly', 'inheritanceWeekly', 'otherWeekly'
    ];
    
    frequencyFields.forEach(field => {
      const refKey = formData[field];
      if (refKey && this.reverseFrequencyMap.has(refKey)) {
        formData[field] = this.reverseFrequencyMap.get(refKey);
      }
    });
    
    const data = {
      ...formData,
      goals: this.moneymanagementShortTermGoals,
      actionToDoItems: this.actionToDoItems
    };
  
    if(this.moneyManagementFormGroup.status=='INVALID'){
      return;
    }
    this._ytpService.patchData('new_financial_empowerment_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].new_financial_empowerment_json = data;
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