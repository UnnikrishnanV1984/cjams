import { Component, OnInit} from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService, DataStoreService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';

@Component({
    selector: 'ytp-education',
    templateUrl: './ytp-education.component.html',
    styleUrls: ['./ytp-education.component.scss'],
    standalone: false
})
export class YtpEducationComponent implements OnInit {
  educationDoYouKnowItems: any[] = [];
  educationShortTermGoals: any[] = [];
  educationForm!: FormGroup;
  ytpData: any;
  store: any;

  constructor(private formBuilder: FormBuilder,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService) {
    this.store = this._dataStoreService.getCurrentStore();
  }


  ngOnInit() {

    this.initializeForms();
    this.educationDoYouKnowItems = [{
      question: 'About your High School Assessment?',
      value: null,
      comments: ''
    },
    {
      question: 'Your educational requirements to graduate?',
      value: null,
      comments: ''
    },
    {
      question: 'Is your worker aware of what you need to graduate?',
      value: null,
      comments: ''
    },
    {
      question: 'Whether transportation is in place to remain in your same school if you change placements? ',
      value: null,
      comments: ''
    },
    {
      // tslint:disable-next-line: max-line-length
      question: 'When you need to take the SATs?',
      value: null,
      comments: ''
    },
    {
      // tslint:disable-next-line: max-line-length
      question: ' Have you already registered?',
      value: null,
      comments: ''
    },
    {
      // tslint:disable-next-line: max-line-length
      question: 'If your worker is aware of funding and resources for higher education (college and vocational)?',
      value: null,
      comments: ''
    },
    {
      // tslint:disable-next-line: max-line-length
      question: 'Where to find assistance in applying for college and working through the admissions process',
      value: null,
      comments: ''
    },
    {
      // tslint:disable-next-line: max-line-length
      question: 'About D.O.R.S (Division of Rehabilitation Services)?',
      value: null,
      comments: ''
    },
    {
      // tslint:disable-next-line: max-line-length
      question: 'The education requirements needed to obtain a Drivers License?',
      value: null,
      comments: ''
    }
    ];

    this.educationForm.disable();
    
    this.ytpData = this.store['YTPDATA'];

    if (this.ytpData && this.ytpData.education_json) {
      this.educationForm.patchValue(this.ytpData.education_json);
      if (this.ytpData.education_json.goals) {
        this.educationShortTermGoals = this.ytpData.education_json.goals;
      }
      if (Array.isArray(this.educationShortTermGoals) && this.educationShortTermGoals.length) {
        this.educationShortTermGoals.forEach(item => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
      if (this.ytpData.education_json.doyouknow) {
        this.checkYtpDoyouknowFn();
      }
    }

  }
  // Associated with ngOnInit function
  private checkYtpDoyouknowFn() {
    var educationDoYouKnowItems = this.ytpData.education_json.doyouknow;
    var oldQuestion = educationDoYouKnowItems.find((t: { question: string; }) => t.question == 'Your educational requirements to graduate? Is your worker aware of what you need to graduate?');
    educationDoYouKnowItems = educationDoYouKnowItems.filter((t: { question: string; }) => t.question !== 'Your educational requirements to graduate? Is your worker aware of what you need to graduate?');
    educationDoYouKnowItems = educationDoYouKnowItems.concat(this.educationDoYouKnowItems.filter(x => educationDoYouKnowItems.every((y: { question: any; }) => y.question !== x.question)));
    if (oldQuestion) {
      educationDoYouKnowItems.forEach((element: { question: any; value: any; comments: any; }) => {
        if (oldQuestion.question.indexOf(element.question) > -1) {
          element.value = oldQuestion.value;
          element.comments = oldQuestion.comments;
        }
      });
    }
    this.educationDoYouKnowItems = educationDoYouKnowItems;
  }

  initializeForms() {
    this.educationForm = this.formBuilder.group({
      educational_status: [null, Validators.required],
      future_goals: [null, Validators.required],
      is_familiar_edu_training_voucher: [null, Validators.required],
      familiar_edu_training_voucher_desc: [null],
      is_exploring_fin_res: [null, Validators.required],
      is_exploring_fin_res_desc: [null]
    });
  }

  save() {
    const data = this.educationForm.getRawValue();

    data.goals = this.educationShortTermGoals;
    data.doyouknow = this.educationDoYouKnowItems;
    let isCompleted = false;
    if (this.educationForm.valid) {
      const filledQuestionsLength = this.educationDoYouKnowItems.filter(question => question.value !== null).length;
      if (filledQuestionsLength === this.educationDoYouKnowItems.length && data.goals.length > 0) {
        isCompleted = true;
      }
    }
    data.isCompleted = isCompleted;
    this._ytpService.patchData('education_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].education_json = data;
          this._alertservice.success('Education details entered successfully!');
        },
        error => {
          this._alertservice.error('Error in entering education details!');
        }
      );
  }

  clear() {
    this.educationForm.reset();
    this.educationShortTermGoals = [];
  }

}
