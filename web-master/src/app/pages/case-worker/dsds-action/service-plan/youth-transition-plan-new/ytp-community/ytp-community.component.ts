import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ChildRemovalService } from '../../../child-removal/child-removal.service';
import { AlertService, DataStoreService, CommonHttpService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import moment from 'moment';

@Component({
    selector: 'ytp-community',
    templateUrl: './ytp-community.component.html',
    styleUrls: ['./ytp-community.component.scss'],
    standalone: false
})
export class YtpCommunityComponent implements OnInit {
  communtiyFormGroup!: FormGroup;
  persons: any[] = [];
  ytpData: any;
  ytpSummary: any = {};
  followUpOneYearOrNot: boolean = false;
  assessments: any[] = [];
  strengths: any[] = [];
  communityShortTermGoals = [];
  communityActions = [];
  isDisabled: boolean = false;
  assessment = { name: '', contactPerson: null, phone: '' };

  constructor(private formBuilder: FormBuilder,
    private childRemovalService: ChildRemovalService,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService) { }

  ngOnInit() {
    this.communtiyFormGroup = this.formBuilder.group({
      communityGoal: [null],
      churchSupport: [null],
      heritageCheck: [null],
      churchPhone: [null],
      assessments: [],
      strengths: [],
      ethnicHeritageList: [null],
      registerToVote: [null],
      registeredDraft: [null],
      progessGoals: [null],
      notes: [null],

    });
    this.ytpData = this._dataStoreService.getData('YTPDATA');
    this.ytpSummary = this.ytpData.new_community_json;
    if (this.ytpData.new_community_json && this.ytpData.new_community_json.planfollowupdate && this.ytpData.new_community_json.transplancompleted){
      const followUpDateCheck = moment(this.ytpData.new_community_json.planfollowupdate);
      const caseCreationDate = moment(this.ytpData.new_community_json.transplancompleted);
      const currentCheck = followUpDateCheck.diff(caseCreationDate, 'days');
      if (currentCheck > 181) {
        this.followUpOneYearOrNot = false;
      } else {
        this.followUpOneYearOrNot = true;
      }
    }
    this.getSummaryDetails();
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
        if (person[key] != null && person[key] != 'null' && person[key] != '') {
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
    const summary = this.communtiyFormGroup.getRawValue();
    summary.assessments = this.assessments;
    summary.strengths = this.strengths;
    summary.goals = this.communityShortTermGoals;
    summary.actions = this.communityActions;
    this.ytpData.new_community_json= summary;
    this._ytpService.patchData('new_community_json', summary)
    .subscribe(
      response => {
        this._alertservice.success('Community entered successfully!');
        this._dataStoreService.setData('YTPDATA', this.ytpData);
      },
      error => {
        this._alertservice.error('Error in entering Community details!');
      }
    );
  }

  getSummaryDetails() {
    this.ytpData = this._dataStoreService.getData('YTPDATA');
    this.isDisabled = this.ytpData.approvalstatuskey == 'Pending' || this.ytpData.approvalstatuskey == 'Approved';  
    if(this.ytpData && this.ytpData.new_community_json){
      this.communtiyFormGroup.patchValue(this.ytpData.new_community_json);
      this.assessments = [];    //@TM: Convert date to enable patching and display on UI
      this.strengths = [];
      if(this.ytpData.new_community_json.assessments && this.ytpData.new_community_json.assessments.length > 0) {
        for(const assessment of this.ytpData.new_community_json.assessments) {
          this.assessments.push(assessment);
        }
      }
      if(this.ytpData.new_community_json.strengths && this.ytpData.new_community_json.strengths.length > 0) {
        for(const strength of this.ytpData.new_community_json.strengths) {
          this.strengths.push(strength);
        }
      }
      this.checkYtpActionsFn();
      this.checkYtpGoalsFn();
    }
  }
  // Associated with getSummaryDetails method
  private checkYtpActionsFn() {
    if (this.ytpData.new_community_json.actions) {
      this.communityActions = this.ytpData.new_community_json.actions;
      if (Array.isArray(this.communityActions) && this.communityActions.length) {
        this.communityActions.forEach((item: any) => {
          item.start_date = item.start_date ? new Date(item.start_date) : '';
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }
  // Associated with getSummaryDetails method
  private checkYtpGoalsFn() {
    if (this.ytpData.new_community_json.goals) {
      this.communityShortTermGoals = this.ytpData.new_community_json.goals;
      if (Array.isArray(this.communityShortTermGoals) && this.communityShortTermGoals.length) {
        this.communityShortTermGoals.forEach((item: any) => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }

  clearSummary() {
    this.communtiyFormGroup.reset();
  }


  addAssessment() {
    this.assessments.push({ name: '', contactPerson: null, phone: null });
  }

  deleteAssessment(index: any) {
    this.assessments.splice(index, 1);
  }

  addStrength() {
    this.strengths.push({ name: '', contactPerson: null, phone: null });
  }

  deleteStrength(index: any) {
    this.strengths.splice(index, 1);
  }

}