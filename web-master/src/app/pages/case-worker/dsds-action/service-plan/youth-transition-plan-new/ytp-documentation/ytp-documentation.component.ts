import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import { AlertService, DataStoreService } from '../../../../../../@core/services';
@Component({
    selector: 'ytp-documentation',
    templateUrl: './ytp-documentation.component.html',
    styleUrls: ['./ytp-documentation.component.scss'],
    standalone: false
})
export class YtpDocumentationComponent implements OnInit {

  documentationFormGroup!: FormGroup;
  documentationShortTermGoals = [];
  docActions= [];
  ytpData: any;
  store: any;
  uploadedDocuments = [];
  isDisabled: boolean = false;

  constructor(private formBuilder: FormBuilder,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService) {
    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.documentationFormGroup = this.formBuilder.group(this.returnFormGroupDefaultDataFn());

    this.ytpData = this.store['YTPDATA'];

    if (this.ytpData && this.ytpData.new_documentation_json) {
      setTimeout(() => {
        this.documentationFormGroup.patchValue(this.ytpData.new_documentation_json);
      }, 1000);

      if (this.ytpData.new_documentation_json.uploadedDocuments) {
        this.uploadedDocuments = this.ytpData.new_documentation_json.uploadedDocuments;
      }
      this.checkYtpGoalsFn();
      this.checkYtpActionsFn();
    }
    this.isDisabled = this.ytpData.approvalstatuskey == 'Pending' || this.ytpData.approvalstatuskey == 'Approved';  
  }
  // Associated with ngOnInit method
  private returnFormGroupDefaultDataFn() {
    return {
      birthDesc: [null],
      birthDate: [null],
      certificate1: [null],
      replaceCert1: [null],
      certificate2: [null],
      replaceCert2: [null],
      date2: [null],
      location2: [null],
      certificate3: [null],
      replaceCert3: [null],
      date3: [null],
      location3: [null],
      certificate4: [null],
      replaceCert4: [null],
      date4: [null],
      location4: [null],
      certificate5: [null],
      replaceCert5: [null],
      date5: [null],
      location5: [null],
      certificate6: [null],
      replaceCert6: [null],
      date6: [null],
      location6: [null],
      certificate7: [null],
      replaceCert7: [null],
      date7: [null],
      location7: [null],
      certificate8: [null],
      replaceCert8: [null],
      date8: [null],
      location8: [null],
      certificate9: [null],
      replaceCert9: [null],
      date9: [null],
      location9: [null],
      certificate10: [null],
      replaceCert10: [null],
      date10: [null],
      location10: [null],
      certificate11: [null],
      desc1: [null],
      date11: [null],
      location11: [null],
      certificate12: [null],
      certificate13: [null],
      desc2: [null],
      notes: [null],
      docGoals: [null],
    };
  }
  // Associated with ngOnInit method
  private checkYtpGoalsFn() {
    if (this.ytpData.new_documentation_json.goals) {
      this.documentationShortTermGoals = this.ytpData.new_documentation_json.goals;
      if (Array.isArray(this.documentationShortTermGoals) && this.documentationShortTermGoals.length) {
        this.documentationShortTermGoals.forEach((item: any) => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }
  // Associated with ngOnInit method
  private checkYtpActionsFn() {
    if (this.ytpData.new_documentation_json.actions) {
      this.docActions = this.ytpData.new_documentation_json.actions;
      if (Array.isArray(this.docActions) && this.docActions.length) {
        this.docActions.forEach((item: any) => {
          item.start_date = item.start_date ? new Date(item.start_date) : '';
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }

  save() {
    const data = this.documentationFormGroup.getRawValue();
    data.goals = this.documentationShortTermGoals;
    data.actions = this.docActions;
    data.uploadedDocuments = this.uploadedDocuments;
    data.uploadedDocuments.forEach((document: any) => {
      if (document.percentage) {
        delete document.percentage;
      }
    });
    let isCompleted = false;
    if (this.documentationFormGroup.valid) {
      if (data.goals.length > 0) {
        isCompleted = true;
      }
    }
    data.isCompleted = isCompleted;
    this._ytpService.patchData('new_documentation_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].new_documentation_json = data;
          this._alertservice.success('Documentation details entered successfully!');
        },
        error => {
          this._alertservice.error('Error in entering documentation details!');
        }
      );
  }

  clear() {
    this.documentationFormGroup.reset();
  }
}