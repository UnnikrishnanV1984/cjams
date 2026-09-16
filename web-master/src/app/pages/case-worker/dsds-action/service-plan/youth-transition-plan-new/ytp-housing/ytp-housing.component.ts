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
  housingActions: any[] = [];
  ytpData: any;
  store: any;
  isDisabled: boolean = false;
  mandatoryFields: boolean = false; 

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
      plannedEndDate: [null],
      tempHousingPlan: [null],
      tempPlannedEndDate: [null],
      rentalApplicationDate: [null],
      housingPlan: [null],
      familyUnification: [null],
      familyUnificationDate: [null],
      fyiProgramDate: [null],
      fyiProgram: [null],
      propertyOwner: [null],
      emailOrPhone: [null],
      backUpPlan: [null],
      notes: [null],
      financialGoals: [null],
    });

    this.ytpData = this.store['YTPDATA'];
    this.isDisabled = this.ytpData.approvalstatuskey == 'Pending' || this.ytpData.approvalstatuskey == 'Approved';  

    if (this.ytpData && this.ytpData.new_housing_json) {
      this.housingFormGroup.patchValue(this.ytpData.new_housing_json);
      this.checkYtpGoalsFn();
      this.checkYtpActionsFn();
    }
  }// Associated with ngOnInit method
  private checkYtpActionsFn() {
    if (this.ytpData.new_housing_json.actions) {
      this.housingActions = this.ytpData.new_housing_json.actions;
      if (Array.isArray(this.housingActions) && this.housingActions.length) {
        this.housingActions.forEach((item: any) => {
          item.start_date = item.start_date ? new Date(item.start_date) : '';
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }
  // Associated with ngOnInit method
  private checkYtpGoalsFn() {
    if (this.ytpData.new_housing_json.goals) {
      this.housingShortTermGoals = this.ytpData.new_housing_json.goals;
      if (Array.isArray(this.housingShortTermGoals) && this.housingShortTermGoals.length) {
        this.housingShortTermGoals.forEach((item: any) => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }

  save() {
    const data = this.housingFormGroup.getRawValue();
    data.goals = this.housingShortTermGoals;
    data.actions = this.housingActions;
    this.mandatoryFields = true;

    if(this.housingFormGroup.status=='INVALID'){
    return;
  }

    this._ytpService.patchData('new_housing_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].new_housing_json = data;
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