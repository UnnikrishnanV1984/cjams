import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService, DataStoreService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';

@Component({
    selector: 'ytp-thoughts-and-ideas',
    templateUrl: './ytp-thoughts-and-ideas.component.html',
    styleUrls: ['./ytp-thoughts-and-ideas.component.scss'],
    standalone: false
})
export class YtpThoughtsAndIdeasComponent implements OnInit {
  youthFormGroup!: FormGroup;
  youthDoYouKnowItems: any;
  ytpData: any;
  store: any;

  constructor(private formBuilder: FormBuilder,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService) {
    this.store = this._dataStoreService.getCurrentStore();
  }


  ngOnInit() {

    this.youthFormGroup = this.formBuilder.group({
      youthstrength: [null, Validators.required],
      issues: [null, Validators.required],
      deliveryneeds: [null, Validators.required]
    });

    this.youthDoYouKnowItems = [{
      question: 'What information is needed for medical coverage after foster care? (Coverage plans, etc.)',
      value: null,
      comments: ''
    },
    {
      question: 'Which clinics/doctor offices you can access with your insurance?',
      value: null,
      comments: ''
    },
    {
      question: 'You  must  inform  your  caseworker  of  any  address  changes  to  receive  health  coverage  after  care.',
      value: null,
      comments: ''
    },
    {
      // tslint:disable-next-line: max-line-length
      question: 'The State of Maryland has a benchmark policy that outlines all the information & tools you should receive by age 14, 15, 16, 17 and 18? (Ask your social worker for a copy of the Benchmark Policy)2',
      value: null,
      comments: ''
    }
    ];

    this.youthFormGroup.disable();

    this.ytpData = this.store['YTPDATA'];

    if (this.ytpData && this.ytpData.youththoughts_json) {
      this.youthFormGroup.patchValue(this.ytpData.youththoughts_json);
      if (this.ytpData.youththoughts_json.doyouknow) {
        this.youthDoYouKnowItems = this.ytpData.youththoughts_json.doyouknow;
      }
    }
  }

  save() {
    let isCompleted = false;
    const data = this.youthFormGroup.getRawValue();
    data.doyouknow = this.youthDoYouKnowItems;

    if (this.youthFormGroup.valid) {
      const filledQuestionsLength = this.youthDoYouKnowItems.filter((question: { value: null; }) => question.value !== null).length;
      if (filledQuestionsLength === this.youthDoYouKnowItems.length) {
        isCompleted = true;
      }
    }
    
    data.isCompleted = isCompleted;

    this._ytpService.patchData('youththoughts_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].youththoughts_json = data;
          this._alertservice.success('Thoughts and ideas entered successfully!');
        },
        error => {
          this._alertservice.error('Error in entering thoughts and ideas!');
        }
      );
  }

  clear() {
    this.youthFormGroup.reset();
  }

  setValidator(formControl: any, selectedOpt: any) {
    if (selectedOpt) {
      this.youthFormGroup.controls[formControl].setValidators(Validators.required);
    } else {
      this.youthFormGroup.controls[formControl].clearValidators();
    }
    this.youthFormGroup.get(formControl)?.updateValueAndValidity();
  }

}
