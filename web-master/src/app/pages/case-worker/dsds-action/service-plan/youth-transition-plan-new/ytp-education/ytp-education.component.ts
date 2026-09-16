import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonHttpService, AlertService, DataStoreService,CommonDropdownsService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import { DropdownModel } from '../../../../../../@core/entities/common.entities';
import _ from 'lodash';
import { Observable } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';

@Component({
    selector: 'ytp-education',
    templateUrl: './ytp-education.component.html',
    styleUrls: ['./ytp-education.component.scss'],
    standalone: false
})
export class YtpEducationComponent implements OnInit {
  educationShortTermGoals = [];
  educationDetailGoals = [];
  educationForm!: FormGroup;
  ytpData: any;
  mandatoryFields=false;
  educationData: any;
  store: any;
  gradeDropdownItems$!: Observable<DropdownModel[]>;
  gradeDropdownItems: any[] = [];
  eduActions = [];
  eduLength: any;
  isDisabled: boolean = false;

  constructor(private formBuilder: FormBuilder,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _commonDropdownService: CommonDropdownsService,
    private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService) {
    this.store = this._dataStoreService.getCurrentStore();
  }


  ngOnInit() {

    this.initializeForms();
    this.ytpData = this.store['YTPDATA']
    this.gradeDropdownItems$ = this._commonDropdownService.getPickListByName('gradelevel');
    this.gradeDropdownItems$.subscribe((data: any) => {
      const list = ['GDO', 'GDTW', 'GDTH', 'GDFO', 'GDFI', 'GDSI',
        'GDSE', 'GDEI', 'GDNI', 'GDTE', 'GDEL', 'GDTWL', 'COL', 'KDGN',
        'NIS', 'PSET', 'PSHS', 'UNK'];
      this.gradeDropdownItems = [];
      list.forEach(item => {
        const obj = data.find((ele: { ref_key: string; }) => ele.ref_key === item);
        this.gradeDropdownItems.push(obj);
      });
    });

    if (this.ytpData && this.ytpData.new_education_json) {
      this.educationForm.patchValue(this.ytpData.new_education_json);
      this.checkYtpGoalsFn();
      this.checkYtpDetailsFn();
      this.checkYtpEduActionsFn();
      if (Array.isArray(this.educationShortTermGoals) && this.educationShortTermGoals.length) {
        this.educationShortTermGoals.forEach((item: any) => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
    this.isDisabled = this.ytpData.approvalstatuskey == 'Pending' || this.ytpData.approvalstatuskey == 'Approved';
    if (this.ytpData.approvalstatuskey == 'Draft') {
      this.getEducationDetails();
    }

  }
  // Associated with ngOnInit method
  private checkYtpGoalsFn() {
    if (this.ytpData.new_education_json.goals) {
      this.educationShortTermGoals = this.ytpData.new_education_json.goals;
    }
  }
  // Associated with ngOnInit method
  private checkYtpDetailsFn() {
    if (this.ytpData.new_education_json.details) {
      this.educationDetailGoals = this.ytpData.new_education_json.details;
    }
  }
  // Associated with ngOnInit method
  private checkYtpEduActionsFn() {
    if (this.ytpData.new_education_json.eduActions) {
      this.eduActions = this.ytpData.new_education_json.eduActions;
      if (this.eduActions.length) {
        this.eduActions.forEach((item: any) => {
          item.start_date = item.start_date ? new Date(item.start_date) : '';
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }

getEducationDetails() {
  this._ytpService.getYTPPlanEduList(this.ytpData.clientid).subscribe((data) => {
    if(data) { 
     this.educationData = data;
     if(this.educationData.personEducation) {
     
     const eduDetails =  _.sortBy(this.educationData.personEducation, 'startdate').reverse();
       this.educationForm.patchValue({
         lastgradetypekey: eduDetails[0].highestgradetypekey,
         mostRecentSchool: eduDetails[0].educationname
       });
    }
     
    }
  });
}


  initializeForms() {
    this.educationForm = this.formBuilder.group({
      lastgradetypekey: [{value: null, disabled: true}],
      current_edu_status: [null, Validators.required],
      other_edu_desc: [null],
      future_goals: [null, Validators.required],
      mostRecentSchool: [{value: null, disabled: true}],
      othercheck: [null],
      othercheckdesc: [null],
      highSchool: [null],
      isGED: [null],
      alternateProgram: [null],
      isOther: [null],
      alternateProgramName: [null],
      otherDesc: [null],
      completionDate: [null],
      loggedHours: [null],
      progressForOthers: [null],
      gpaGrades: [null],
      iepSupports: [null],
      postSecondaryGoals: [null],
      transitionServices: [null],
      esoloresl: [null],
      interestMeetingDt: [null],
      aidDDA: [null],
      aidDORS: [null],
      aidOthers: [null],
      aidotherDesc: [null],
      incentivePaymentDate: [null],
      gradcompletionDate: [null],
      attendingMoreSchool: [null],
      attendingJobProgram: [null],
      attendingVocationalSchool: [null],
      appliedSchoolarship: [null],
      appliedInternship: [null],
      appliedFAFSA: [null],
      appliedETV: [null],
      appliedFosterCare: [null],
      appliedOtherPrograms: [null],
      currentUse: [null],
      supportServices: [null],
      eduGoals: [null],
      notes: [null],
    });
  }

  saveMethod = () => this.saveObservable();

  saveObservable() {
    this.mandatoryFields = true;
    const data = this.educationForm.getRawValue();
    data.goals = this.educationShortTermGoals;
    data.details = this.educationDetailGoals;
    data.eduActions = this.eduActions;
  
    const isCompleted = false;
    data.isCompleted = isCompleted;
  
    return this._ytpService.patchData('new_education_json', data).pipe(
      tap(response => {
        this.store['YTPDATA'].new_education_json = data;
        this._alertservice.success('Education details entered successfully!');
      }),
      catchError(error => {
        this._alertservice.error('Error in entering education details!');
        throw error;
      })
    );
  }
  

  save() {
    this.mandatoryFields =true;
    const data = this.educationForm.getRawValue();

    data.goals = this.educationShortTermGoals;
    data.details =  this.educationDetailGoals;
    data.eduActions = this.eduActions;
    const isCompleted = false;
    data.isCompleted = isCompleted;
  if(this.educationForm.status=='INVALID'){
    return;
  }
    this._ytpService.patchData('new_education_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].new_education_json = data;
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