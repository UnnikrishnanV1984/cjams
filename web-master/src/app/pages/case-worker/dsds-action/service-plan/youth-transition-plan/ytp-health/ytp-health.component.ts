import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import { DataStoreService } from '../../../../../../@core/services';

@Component({
    selector: 'ytp-health',
    templateUrl: './ytp-health.component.html',
    styleUrls: ['./ytp-health.component.scss'],
    standalone: false
})
export class YtpHealthComponent implements OnInit {

  healthShortTermGoals: any[] = [];
  healthForm!: FormGroup;
  healthDoYouKnowItems: any;
  // healthIssuesForm: FormGroup;
  healthIssuesList: any[] = [];
  selectedIndex: any;
  addEditLabel!: string;
  ytpData: any;
  store: any;

  constructor(
    private formBuilder: FormBuilder,
    private _alertService: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService,
    private _alertservice: AlertService) {
    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.initializeHealthForms();
    this.healthDoYouKnowItems = [{
      question: 'Regular exams and annual physicals are important to maintain good health.',
      value: null,
      comments: ''
    },
    {
      question: 'The purpose of each medication you’ve been prescribed?',
      value: null,
      comments: ''
    }
    ];

    this.healthForm.disable();

    this.ytpData = this.store['YTPDATA'];

    if (this.ytpData && this.ytpData.health_json) {
      this.healthForm.patchValue(this.ytpData.health_json);
      this.checkYtpGoalsFn();
      if (this.ytpData.health_json.doyouknow) {
        this.healthDoYouKnowItems = this.ytpData.health_json.doyouknow;
      }
      this.checkYtpHealthissuesFn();
    }
  }
  // Associated with ngOnInit function
  private checkYtpHealthissuesFn() {
    if (this.ytpData.health_json.healthissues) {
      this.healthIssuesList = this.ytpData.health_json.healthissues;
      if (Array.isArray(this.healthIssuesList) && this.healthIssuesList.length) {
        this.healthIssuesList.forEach(item => {
          item.date_last_exam = item.date_last_exam ? new Date(item.date_last_exam) : '';
        });
      }
    }
  }
  // Associated with ngOnInit function
  private checkYtpGoalsFn() {
    if (this.ytpData.health_json.goals) {
      this.healthShortTermGoals = this.ytpData.health_json.goals;

      if (Array.isArray(this.healthShortTermGoals) && this.healthShortTermGoals.length) {
        this.healthShortTermGoals.forEach(item => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }

  initializeHealthForms() {
    this.healthForm = this.formBuilder.group({
      health_status: [null, Validators.required],
      health_goals: [null, Validators.required],
      medical_plan: [null, Validators.required],
      make_decision: [null, Validators.required],
      health_care_agent: [null],
      advance_directive_health: [null]
    });
  }

  addHealthIssues() {
    this.healthIssuesList.push({
      health_issues: '',
      concern: '',
      date_last_exam: null,
      doctor_info: ''
    });
  }

  save() {
    const data = this.healthForm.getRawValue();
    data.goals = this.healthShortTermGoals;
    data.doyouknow = this.healthDoYouKnowItems;
    data.healthissues = this.healthIssuesList;

    let isCompleted = false;
    if (this.healthForm.valid) {
      const filledQuestionsLength = this.healthDoYouKnowItems.filter((question: { value: null; }) => question.value !== null).length;
      if (filledQuestionsLength === this.healthDoYouKnowItems.length && data.goals.length > 0) {
        isCompleted = true;
      }
    }
    data.isCompleted = isCompleted;
    this._ytpService.patchData('health_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].health_json = data;
          this._alertservice.success('Health details entered successfully!');
        },
        error => {
          this._alertservice.error('Error in entering health details!');
        }
      );
  }

  /* saveOrUpdate() {
    const healthIssuesForm = this.healthIssuesForm.getRawValue();
    if (this.addEditLabel === 'Add') {
      if (this.isHealthIssuesExist(healthIssuesForm.health_issues)) {
        this._alertService.error('Goal already added');
        return false;
      }
      this.healthIssuesList.push(healthIssuesForm);
    } else {
      this.healthIssuesList[this.selectedIndex] = healthIssuesForm;
    }
    (<any>$('#add-health-issues-modal')).modal('hide');
  } */

  /* isHealthIssuesExist(healthIssueNm: string) {
    const healthIssue = this.healthIssuesList.find(item => item.health_issues === healthIssueNm);
    if (healthIssue) {
      return true;
    } else {
      return false;
    }
  }


  editHealthIssues(healthIssuesData, index) {
    this.healthIssuesForm.patchValue(healthIssuesData);
    this.selectedIndex = index;
    this.addEditLabel = 'Edit';
    (<any>$('#add-health-issues-modal')).modal('show');
  }

  deleteHealthIssues(index) {
    // this.selectedIndex = index;
    // if we need confirmation message then we will make use of the selected index;
    this.healthIssuesList.splice(index, 1);
  } */

  clearHealthForm() {
    this.healthForm.reset();
  }

  /* clearForm() {
    this.healthIssuesForm.reset();
  } */
}
