import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ChildRemovalService } from '../../../child-removal/child-removal.service';
import { AlertService, DataStoreService, CommonHttpService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import moment from 'moment';

@Component({
    selector: 'ytp-transport',
    templateUrl: './ytp-transport.component.html',
    styleUrls: ['./ytp-transport.component.scss'],
    standalone: false
})
export class YtpTransportComponent implements OnInit {
  transportFormGroup!: FormGroup;
  persons: any[] = [];
  ytpData: any;
  ytpSummary: any = {};
  followUpOneYearOrNot: boolean = false;
  communityShortTermGoals = [];
  communityActions = [];
  store: any;
  isDisabled: boolean = false;

  constructor(private formBuilder: FormBuilder,
    private childRemovalService: ChildRemovalService,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService ,
    private _commonHttpService: CommonHttpService,
    ) {
      this.store = this._dataStoreService.getCurrentStore();
     }

  ngOnInit() {
    this.transportFormGroup = this.formBuilder.group({
      transportGoal: [null],
      ownVechicle: [null],
      famProvides: [null],
      publicTrans: [null],
      bicycle: [null],
      walking: [null],
      otherTrans: [null],
      otherModeDesc: [null],
      transportResources: [null],
      transportNeeds: [null],
      havingDL: [null],
      dlState: [null],
      dlExpireDt: [null],
      toGetLicense: [null],
      permitExpireDt: [null],
      completedDriverEdu: [null],
      realIDcompliant: [null],
      completionDt: [null],
      loggedDrivingHours: [null],
      policyNumber: [null],
      autoInsurance: [null],
      progessGoals: [null],
      notes: [null],
    });
    this.ytpData = this._dataStoreService.getData('YTPDATA');
    this.ytpSummary = this.ytpData.new_transportation_json;
    this.isDisabled = this.ytpData.approvalstatuskey == 'Pending' || this.ytpData.approvalstatuskey == 'Approved';  
    if(this.ytpData.new_transportation_json) {
      this.getSummaryDetails();
    }
    this.childRemovalService.getPersonsList().subscribe(persons => {
      if (persons && persons.data) {
        this.persons = persons.data;
      }
    }
    );
  }
  getFullName(person: any) {
      const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
      let name = '';
      nameKeys.forEach(key => {
      if(person && person.hasOwnProperty(key)){
        if ( (person[key] !== null) && (person[key] !== 'null') && (person[key] !== '') ) {
          name = name + person[key] + ' ';
      }}
      });
      return name;
  }
  formatDateToString(date: Date): any {
    const convertedDate = moment(date);
    if (convertedDate.isValid()) {
      return convertedDate.format('MM/DD/YYYY');
    } else {
      return null;
    }
  }
  
  saveSummary() {
    const summary = this.transportFormGroup.getRawValue();
    summary.goals = this.communityShortTermGoals;
    summary.actions = this.communityActions;
    this._ytpService.patchData('new_transportation_json', summary)
    .subscribe(
      response => {
        this.store['YTPDATA'].new_transportation_json = summary;
        this._alertservice.success('Transportation entered successfully!');
        this.getSummaryDetails();
      },
      error => {
        this._alertservice.error('Error in entering Transportation details!');
      }
    );
  }

  getSummaryDetails() {
    this.ytpData = this._dataStoreService.getData('YTPDATA');
    this.transportFormGroup.patchValue(this.ytpData.new_transportation_json);
    if (this.ytpData.new_transportation_json.actions) {
      this.communityActions = this.ytpData.new_transportation_json.actions;
      this.checkCommunityActionsFn();
    } 
    if(this.ytpData.new_transportation_json.goals) {
      this.communityShortTermGoals =  this.ytpData.new_transportation_json.goals;
      if (Array.isArray(this.communityShortTermGoals) && this.communityShortTermGoals.length) {
        this.communityShortTermGoals.forEach((item: any) => {
        item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
      });
     }
    }
  }// Associated with getSummaryDetails function
  private checkCommunityActionsFn() {
    if (this.communityActions.length) {
      this.communityActions.forEach((item: any) => {
        item.start_date = item.start_date ? new Date(item.start_date) : '';
        item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
      });
    }
  }

  clearSummary() {
    this.transportFormGroup.reset();
  }


}