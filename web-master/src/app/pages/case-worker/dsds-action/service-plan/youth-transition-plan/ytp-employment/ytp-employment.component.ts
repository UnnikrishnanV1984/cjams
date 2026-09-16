import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService, DataStoreService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
@Component({
    selector: 'ytp-employment',
    templateUrl: './ytp-employment.component.html',
    styleUrls: ['./ytp-employment.component.scss'],
    standalone: false
})
export class YtpEmploymentComponent implements OnInit {
  employmentFormGroup!: FormGroup;
  employmentShortTermGoals: any[] = [];
  employmentDoYouKnowItems: any;
  ytpData: any;
  store: any;

  constructor(private formBuilder: FormBuilder,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService) {
    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.employmentFormGroup = this.formBuilder.group({
      currentemploymentstatus: [null, Validators.required],
      futuregoals: [null, Validators.required]
    });

    this.employmentDoYouKnowItems = [{
      question: 'How to find assistance with applying for summer youth employment?',
      value: null,
      comments: ''
    },
    {
      question: 'About Maryland RISE workforce development program?',
      value: null,
      comments: ''
    },
    {
      question: 'About  the  career  assessment  at  your  school?',
      value: null,
      comments: ''
    },
    {
      question: 'Have  you  developed  a  career  development  framework?  Be sure to share this information with your worker.',
      value: null,
      comments: ''
    },
    {
      question: 'Where to find help with interviewing skills, resume building, appropriate dressing, and proper behavior in the workplace?',
      value: null,
      comments: ''
    },
    ];

    this.employmentFormGroup.disable();

    this.ytpData = this.store['YTPDATA'];
    if (this.ytpData && this.ytpData.employment_json) {
      this.employmentFormGroup.patchValue(this.ytpData.employment_json);
      this.checkYtpGoalsFn();
      if (this.ytpData.employment_json.doyouknow) {
        this.checkYtpDoyouknowFn();
      }
    }
  }
  // Associated with ngOnInit function
  private checkYtpDoyouknowFn() {
    var employmentDoYouKnowItems = this.ytpData.employment_json.doyouknow;
    var oldQuestion = employmentDoYouKnowItems.find((t: { question: string; }) => t.question == 'About  the  career  assessment  at  your  school?  Have  you  developed  a  career  development  framework?  Be sure to share this information with your worker. ');
    employmentDoYouKnowItems = employmentDoYouKnowItems.filter((t: { question: string; }) => t.question !== 'About  the  career  assessment  at  your  school?  Have  you  developed  a  career  development  framework?  Be sure to share this information with your worker.');
    employmentDoYouKnowItems = employmentDoYouKnowItems.concat(this.employmentDoYouKnowItems.filter((x: { question: any; }) => employmentDoYouKnowItems.every((y: { question: any; }) => y.question !== x.question)));
    if (oldQuestion) {
      employmentDoYouKnowItems.forEach((element: { question: any; value: any; comments: any; }) => {
        if (oldQuestion.question.indexOf(element.question) > -1) {
          element.value = oldQuestion.value;
          element.comments = oldQuestion.comments;
        }
      });
    }
    this.employmentDoYouKnowItems = employmentDoYouKnowItems;
  }
  // Associated with ngOnInit function
  private checkYtpGoalsFn() {
    if (this.ytpData.employment_json.goals) {
      this.employmentShortTermGoals = this.ytpData.employment_json.goals;
      if (Array.isArray(this.employmentShortTermGoals) && this.employmentShortTermGoals.length) {
        this.employmentShortTermGoals.forEach(item => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }

  save() {
    const data = this.employmentFormGroup.getRawValue();
    data.goals = this.employmentShortTermGoals;
    data.doyouknow = this.employmentDoYouKnowItems;

    let isCompleted = false;
    if (this.employmentFormGroup.valid) {
      const filledQuestionsLength = this.employmentDoYouKnowItems.filter((question: { value: null; }) => question.value !== null).length;
      if (filledQuestionsLength === this.employmentDoYouKnowItems.length && data.goals.length > 0) {
        isCompleted = true;
      }
    }
    data.isCompleted = isCompleted;

    this._ytpService.patchData('employment_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].employment_json = data;
          this._alertservice.success('Employment details entered successfully!');
        },
        error => {
          this._alertservice.error('Error in entering employment details!');
        }
      );
  }

  clear() {
    this.employmentFormGroup.reset();
    this.employmentShortTermGoals = [];
  }


}
