import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService, DataStoreService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
@Component({
    selector: 'ytp-supportive-relationships',
    templateUrl: './ytp-supportive-relationships.component.html',
    styleUrls: ['./ytp-supportive-relationships.component.scss'],
    standalone: false
})
export class YtpSupportiveRelationshipsComponent implements OnInit {

  supportiveFormGroup!: FormGroup;
  supportiveShortTermGoals: any[] = [];
  ytpData: any;
  store: any;

  constructor(private formBuilder: FormBuilder,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService) {
    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.supportiveFormGroup = this.formBuilder.group({
      currentSystemSupport: [null, Validators.required],
      effortstoIdentify: [null, Validators.required],
      involvedinCommunity: [null, Validators.required],
      involvedinCommunityDesc: [null],
      spiritualSupport: [null, Validators.required],
      longTermGoals: [null, Validators.required]
    });

    this.supportiveFormGroup.disable();

    this.ytpData = this.store['YTPDATA'];

    if (this.ytpData && this.ytpData.sracc_json) {
      this.supportiveFormGroup.patchValue(this.ytpData.sracc_json);
      if (this.ytpData.sracc_json.goals) {
        this.supportiveShortTermGoals = this.ytpData.sracc_json.goals;
        if (Array.isArray(this.supportiveShortTermGoals) && this.supportiveShortTermGoals.length) {
          this.supportiveShortTermGoals.forEach((item: any) => {
            item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
          });
        }
      }
    }
  }

  save() {
    const data = this.supportiveFormGroup.getRawValue();
    data.goals = this.supportiveShortTermGoals;

    let isCompleted = false;
    if (this.supportiveFormGroup.valid) {
      if (data.goals.length > 0) {
        isCompleted = true;
      }
    }
    data.isCompleted = isCompleted;

    this._ytpService.patchData('sracc_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].sracc_json = data;
          this._alertservice.success('Supportive relationship details entered successfully!');
        },
        error => {
          this._alertservice.error('Error in entering supportive relationship details!');
        }
      );
  }


  clear() {
    this.supportiveFormGroup.reset();
  }


}
