import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService, DataStoreService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';

@Component({
    selector: 'ytp-housing',
    templateUrl: './ytp-housing.component.html',
    styleUrls: ['./ytp-housing.component.scss'],
    standalone: false
})
export class YtpHousingComponent implements OnInit {
  housingFormGroup!: FormGroup;
  housingShortTermGoals: any[] = [];
  housingDoYouKnowItems: any;
  ytpData: any;
  store: any;

  constructor(private formBuilder: FormBuilder,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService) {
    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.housingFormGroup = this.formBuilder.group({
      currentlivingsituation: [null, Validators.required],
      futuregoals: [null, Validators.required],
      planforhousing: [null, Validators.required]
    });

    this.housingDoYouKnowItems = [{
      question: 'All your housing options?',
      value: null,
      comments: ''
    },
    {
      question: 'How to secure funding for housing?',
      value: null,
      comments: ''
    },
    {
      question: 'How to apply for section 8 housing?',
      value: null,
      comments: ''
    },
    {
      question: 'Or, how to find information for low income housing in the area, if needed? ',
      value: null,
      comments: ''
    },
    // {
    //   question: 'How to secure funding for housing? How to apply for section 8 housing? Or, how to find information for low income housing in the area, if needed? ',
    //   value: null,
    //   comments: ''
    // },
    {
      question: 'About SILA (Semi-independent living program)?',
      value: null,
      comments: ''
    },
    {
      question: 'How to get on the HUD list?',
      value: null,
      comments: ''
    },
    {
      question: 'What’s needed to get housing (i.e. criminal background, leasing agreement)?',
      value: null,
      comments: ''
    },
    {
      question: 'About the Family Reunification Program (FUP)?',
      value: null,
      comments: ''
    },
    ];

    this.housingFormGroup.disable();

    this.ytpData = this.store['YTPDATA'];

    if (this.ytpData && this.ytpData.housing_json) {
      this.housingFormGroup.patchValue(this.ytpData.housing_json);
      this.checkYtpGoalsFn();
      if (this.ytpData.housing_json.doyouknow) {
        this.checkYtpDoyouknowFn(); 
      }
    }
  }
  // Associated with ngOnInit function
  private checkYtpDoyouknowFn() {
    var housingDoYouKnowItems = this.ytpData.housing_json.doyouknow;
    var oldQuestion = housingDoYouKnowItems.find((t: { question: string; }) => t.question == 'How to secure funding for housing? How to apply for section 8 housing? Or, how to find information for low income housing in the area, if needed? ');
    housingDoYouKnowItems = housingDoYouKnowItems.filter((t: { question: string; }) => t.question !== 'How to secure funding for housing? How to apply for section 8 housing? Or, how to find information for low income housing in the area, if needed? ');
    housingDoYouKnowItems = housingDoYouKnowItems.concat(this.housingDoYouKnowItems.filter((x: { question: any; }) => housingDoYouKnowItems.every((y: { question: any; }) => y.question !== x.question)));
    if (oldQuestion) {
      housingDoYouKnowItems.forEach((element: { question: any; value: any; comments: any; }) => {
        if (oldQuestion.question.indexOf(element.question) > -1) {
          element.value = oldQuestion.value;
          element.comments = oldQuestion.comments;
        }
      });
    }
    this.housingDoYouKnowItems = housingDoYouKnowItems;
  }
  // Associated with ngOnInit function
  private checkYtpGoalsFn() {
    if (this.ytpData.housing_json.goals) {
      this.housingShortTermGoals = this.ytpData.housing_json.goals;
      if (Array.isArray(this.housingShortTermGoals) && this.housingShortTermGoals.length) {
        this.housingShortTermGoals.forEach(item => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }

  save() {
    const data = this.housingFormGroup.getRawValue();
    data.goals = this.housingShortTermGoals;
    data.doyouknow = this.housingDoYouKnowItems;

    let isCompleted = false;
    if (this.housingFormGroup.valid) {
      const filledQuestionsLength = this.housingDoYouKnowItems.filter((question: { value: null; }) => question.value !== null).length;
      if (filledQuestionsLength === this.housingDoYouKnowItems.length && data.goals.length > 0) {
        isCompleted = true;
      }
    }
    data.isCompleted = isCompleted;

    this._ytpService.patchData('housing_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].housing_json = data;
          this._alertservice.success('Housing details entered successfully!');
        },
        error => {
          this._alertservice.error('Error in entering housing details!');
        }
      );
  }

  clear() {
    this.housingFormGroup.reset();
    this.housingShortTermGoals = [];
  }

}
