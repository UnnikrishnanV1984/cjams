import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService, DataStoreService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import _ from 'lodash';
import { catchError, tap } from 'rxjs/operators';
@Component({
    selector: 'ytp-employment',
    templateUrl: './ytp-employment.component.html',
    styleUrls: ['./ytp-employment.component.scss'],
    standalone: false
})
export class YtpEmploymentComponent implements OnInit {
  employmentFormGroup!: FormGroup;
  employmentShortTermGoals = [];
  assessments: any[] = [];
  employmentActions = [];
  employmentData: any;
  ytpData: any;
  store: any;
  assessment = { name: '', start_date: null, position: '',address:'' };
  isDisabled: boolean = false;
  mandatoryFields: boolean = false;

  constructor(private formBuilder: FormBuilder,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService) {
    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.employmentFormGroup = this.formBuilder.group({
      employmentGoal: [null, Validators.required],
      resumeCompleted: [null],
      sampleCompleted: [null],
      assessmentCompleted: [null],
      employmentSkill: [null],
      specialCertification: [null],
      isFullTime: [{value: null,disabled:true}],
      isPartTime: [{value: null,disabled:true}],
      hoursPerWeek: [{value: null,disabled:true}],
      position: [{value: null,disabled:true}],
      employerName:[{value: null,disabled:true}],
      employerAddress: [{value: null,disabled:true}],
      employerPhone: [{value: null,disabled:true}],
      employerPay: [{value: null,disabled:true}],
      isAddFullTime: [null],
      isAddPartTime: [null],
      addhoursPerWeek: [null],
      addPosition: [null],
      addemployerName:[null],
      addemployerAddress:[null],
      addemployerPhone:[null],
      addemployerPay:[null],
      notes: [null],
      employmentGoals: [null],
    });

    this.ytpData = this.store['YTPDATA'];
    this.isDisabled = this.ytpData.approvalstatuskey == 'Pending' || this.ytpData.approvalstatuskey == 'Approved';  
    if (this.ytpData && this.ytpData.new_employ_json) {
      this.employmentFormGroup.patchValue(this.ytpData.new_employ_json);
      this.checkYtpGoalsFn();  
      this.checkYtpAssessmentsFn(); 
      this.checkYtpEmploymentActionsFn(); 
    }
    if (this.ytpData.approvalstatuskey == 'Draft'){
        this.getEmploymentDetails();
    }    

  }



  private checkYtpEmploymentActionsFn() {
    if (this.ytpData.new_employ_json.employmentActions) {
      this.employmentActions = this.ytpData.new_employ_json.employmentActions;
      if (this.employmentActions.length) {
        this.employmentActions.forEach((item: any) => {
          item.start_date = item.start_date ? new Date(item.start_date) : '';
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }

  private checkYtpAssessmentsFn() {
    if (this.ytpData.new_employ_json.assessments) {
      this.assessments = this.ytpData.new_employ_json.assessments;
      if (this.assessments.length) {
        this.assessments.forEach((item: any) => {
          item.start_date = item.start_date ? new Date(item.start_date) : '';
        });
      }
    }
  }

  private checkYtpGoalsFn() {
    if (this.ytpData.new_employ_json.goals) {
      this.employmentShortTermGoals = this.ytpData.new_employ_json.goals;
      if (Array.isArray(this.employmentShortTermGoals) && this.employmentShortTermGoals.length) {
        this.employmentShortTermGoals.forEach((item: any) => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }


  getEmploymentDetails() {
    this._ytpService.getYTPPlanEmploymentList(this.ytpData.clientid).subscribe((data) => {
      if (!data) return;
      const activeEmployment = data.filter(e => (e.enddate == null) || (e.enddate == '') || new Date(e.enddate) > new Date());
      const pastEmployment = data.filter(e => e.enddate && new Date(e.enddate) <= new Date());
      if (activeEmployment.length) {
        const sortedActive = _.sortBy(activeEmployment, 'startdate').reverse();
        const addresscheck = this._ytpService.getYTPAddress(
          sortedActive[0].address1,
          sortedActive[0].address2,
          sortedActive[0].cityname,
          sortedActive[0].statetypekey,
          sortedActive[0].zip5no
        );
        this.employmentFormGroup.patchValue(this.getEmploymentDetailsPatchFn(sortedActive, addresscheck));
      }

      if (pastEmployment.length) {
        this.assessments = [];
        pastEmployment.forEach(element => {
          const addresscheck1 = this._ytpService.getYTPAddress(
            element.address1,
            element.address2,
            element.cityname,
            element.statetypekey,
            element.zip5no
          );
          const pastEmploymentList = {
            name: element.employername,
            start_date: element.startdate,
            position: element.clienttitle,
            address: addresscheck1 || ''
          };
          this.assessments.push(pastEmploymentList);
        });
      }
    });
  }
  // Associated with getEmploymentDetails method
  private getEmploymentDetailsPatchFn(data: any[], addresscheck: string): { [key: string]: any; } {
    if (Array.isArray(data) && data.length > 0) {
      return {
        hoursPerWeek: data[0].noofhours || '',
        isFullTime: data[0].emplymenttypekey === '1' ? true : '',
        isPartTime: data[0].emplymenttypekey === '0' ? true : '',
        position: data[0].clienttitle || '',
        employerPay: data[0].income || '',
        employerName: data[0].employername || '',
        employerAddress: addresscheck || '',
        employerPhone: data[0].workphone?.[0]?.phonenumber || ''
      };
    } else {
      return {
        hoursPerWeek: '',
        isFullTime: '',
        isPartTime: '',
        position: '',
        employerPay: '',
        employerName: '',
        employerAddress: addresscheck || '',
        employerPhone: ''
      };
    }
  }

  saveMethod = () => this.saveObservable();

  saveObservable() {
    const data = this.employmentFormGroup.getRawValue();
    data.goals = this.employmentShortTermGoals;
    data.assessments = this.assessments;
    data.employmentActions = this.employmentActions;
  
    const isCompleted = false;
    data.isCompleted = isCompleted;
  
    return this._ytpService.patchData('new_employ_json', data).pipe(
      tap(response => {
        this.store['YTPDATA'].new_employ_json = data;
        this._alertservice.success('Employment details entered successfully!');
      }),
      catchError(error => {
        this._alertservice.error('Error in entering employment details!');
        throw error;
      })
    );
  }
  

  save() {
    const data = this.employmentFormGroup.getRawValue();
    data.goals = this.employmentShortTermGoals;
    data.assessments = this.assessments;
    data.employmentActions = this.employmentActions;
    this.mandatoryFields = true;

    const isCompleted = false;
    data.isCompleted = isCompleted;

    if(this.employmentFormGroup.status=='INVALID'){
    return;
  }

    this._ytpService.patchData('new_employ_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].new_employ_json = data;
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

  addAssessment() {
    this.assessments.push({ name: '', contactPerson: null, phone: null });
  }

  deleteAssessment(index: any) {
    this.assessments.splice(index, 1);
  }


}
