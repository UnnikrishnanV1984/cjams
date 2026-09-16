import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder} from '@angular/forms';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import { DataStoreService } from '../../../../../../@core/services';
import { catchError, tap } from 'rxjs/operators';

@Component({
    selector: 'ytp-health',
    templateUrl: './ytp-health.component.html',
    styleUrls: ['./ytp-health.component.scss'],
    standalone: false
})
export class YtpHealthComponent implements OnInit {

  healthShortTermGoals = [];
  healthForm!: FormGroup;
  healthIssuesList: any[] = [];
  providerData: any;
  mandatoryFields=false;
  selectedIndex: any;
  healthList: any;
  addEditLabel!: string;
  ytpData: any;
  store: any;
  healthActions = [];
  isDisabled: boolean = false;

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
    this.ytpData = this.store['YTPDATA'];
    this.isDisabled = this.ytpData?.approvalstatuskey == 'Pending' || this.ytpData?.approvalstatuskey == 'Approved';  
    this.getHealthDetails();
    if (this.ytpData && this.ytpData.new_health_json) {
      this.healthForm.patchValue(this.ytpData.new_health_json);
      this.healthForm.patchValue({
        visionLastDate: this.ytpData.new_health_json.visionLastDate ? new Date(this.ytpData.new_health_json.visionLastDate) : '',
        dentalEndDate:  this.ytpData.new_health_json.dentalEndDate ? new Date(this.ytpData.new_health_json.dentalEndDate) : '',
        lastAppointDt:  this.ytpData.new_health_json.lastAppointDt ? new Date(this.ytpData.new_health_json.lastAppointDt) : '',
        behaviorCoverageEndDate:  this.ytpData.new_health_json.behaviorCoverageEndDate ? new Date(this.ytpData.new_health_json.behaviorCoverageEndDate) : '',
      });
      this.checkYtpGoalsFn();
      this.checkYtpActionsFn();
    }
    if (this.ytpData.approvalstatuskey == 'Draft') { 
       this.getProviderDetails();
    }
  }
  // Associated with ngOninit method
  private checkYtpActionsFn() {
    if (this.ytpData.new_health_json.actions) {
      this.healthActions = this.ytpData.new_health_json.actions;
      if (Array.isArray(this.healthActions) && this.healthActions.length) {
        this.healthActions.forEach((item: any) => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
          item.start_date = item.start_date ? new Date(item.start_date) : '';
        });
      }
    }
  }
  // Associated with ngOninit method
  private checkYtpGoalsFn() {
    if (this.ytpData.new_health_json.goals) {
      this.healthShortTermGoals = this.ytpData.new_health_json.goals;
      if (Array.isArray(this.healthShortTermGoals) && this.healthShortTermGoals.length) {
        this.healthShortTermGoals.forEach((item: any) => {
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }

  initializeHealthForms() {
    this.healthForm = this.formBuilder.group({
      selfCareHealth: [null],
      insuranceCompany: [{value: null,disabled:true}],
      policyNumber: [{value: null,disabled:true}],
      currentPlan: [null],
      coverageEndDate: [{value: null,disabled:true}],
      primaryDoctor: [null],
      clinicAddress: [null],
      clinicphoneNumber: [null],
      allergySpecialist: [null],
      knownAllergies: [null],
      prescriptions: [null],
      otherProviders: [null],
      providerAddress: [null],
      healthNeeds: [null],
      immunizationsUpToDate: [null],
      scheduleImmunization: [null],
      lastAppointDt: [null],
      visionInsurance: [{value: null,disabled:true}],
      visionpolicyNumber: [{value: null,disabled:true}],
      visioncurrentPlan: [null],
      visionCoverageEndDate: [{value: null,disabled:true}],
      eyeDoctor: [null],
      visionCenter: [null],
      visionPhoneNumber: [null],
      otherNeeds: [null],
      eyeMedicine: [null],
      visionLastDate: [null],
      behaviorInsurance: [null],
      behaviorpolicyNumber: [null],
      behaviorcurrentPlan: [null],
      behaviorCoverageEndDate: [null],
      currentCounselor: [null],
      behaviorAddress: [null],
      behaviorPhoneNumber: [null],
      behaviorNeeds: [null],
      behaviorPrescriptions: [null],
      dentalInsurance: [{value: null,disabled:true}],
      dentalpolicyNumber: [{value: null,disabled:true}],
      dentalcurrentPlan: [null],
      dentalCoverageEndDate: [{value: null,disabled:true}],
      currentDentist: [null],
      dentistAddress: [null],
      dentistPhoneNumber: [null],
      dentalNeeds: [null],
      dentalEndDate: [null],
      healthGoals: [null],
      notes: [null],
    });
  }


  getHealthDetails() {
    this._ytpService.getYTPPlanHealtList(this.ytpData.clientid).subscribe((data) => {
      if(data) { 
       this.healthList = data;
        const medicalData = this.healthList.data.filter((menu: { insurancetype: string; }) => menu.insurancetype !== 'VC' &&  menu.insurancetype !== 'DEN');
        const dentallist = this.healthList.data.filter((menu: { insurancetype: string; }) => menu.insurancetype == 'DEN');
        const vision = this.healthList.data.filter((menu: { insurancetype: string; }) => menu.insurancetype == 'VC');
      if (medicalData && medicalData.length) {
        this.healthForm.patchValue({
        insuranceCompany: medicalData[0].medicalinsuranceprovider,
        policyNumber: medicalData[0].policynumber,
        coverageEndDate: medicalData[0].expirationdate,
        });
      }
      if (dentallist && dentallist.length) {
        this.healthForm.patchValue({
        dentalInsurance: dentallist[0].medicalinsuranceprovider,
        dentalpolicyNumber: dentallist[0].policynumber,
        dentalCoverageEndDate: dentallist[0].expirationdate,
        });
      }
      if (vision && vision.length) {
        this.healthForm.patchValue({
        visionInsurance: vision[0].medicalinsuranceprovider,
        visionpolicyNumber: vision[0].policynumber,
        visionCoverageEndDate: vision[0].expirationdate,
        });
      }
       
      }
    });
  }

  saveMethod = () => this.saveObservable();

  save() {
    this.mandatoryFields=true;
    const data = this.healthForm.getRawValue();
    data.goals = this.healthShortTermGoals;
    data.actions = this.healthActions;
    
    const isCompleted = false;
    data.isCompleted = isCompleted;
    if(this.healthForm.status=='INVALID'){
       return;
     }
    this._ytpService.patchData('new_health_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].new_health_json = data;
          this._alertservice.success('Health details entered successfully!');
        },
        error => {
          this._alertservice.error('Error in entering health details!');
        }
      );
  }

  saveObservable() {
    this.mandatoryFields = true;
    const data = this.healthForm.getRawValue();
    data.goals = this.healthShortTermGoals;
    data.actions = this.healthActions;
  
    const isCompleted = false;
    data.isCompleted = isCompleted;

    return this._ytpService.patchData('new_health_json', data).pipe(
      tap(response => {
        this.store['YTPDATA'].new_health_json = data;
        this._alertservice.success('Health details entered successfully!');
      }),
      catchError(error => {
        this._alertservice.error('Error in entering health details!');
        throw error;
      })
    );
  }

  
  clearHealthForm() {
    this.healthForm.reset();
  }

  getProviderDetails() {
    this._ytpService.getYTPPlanProviderList(this.ytpData.clientid).subscribe((res: any) => {
      if(res) { 
       this.providerData = res.data;
       const dentalList = this.providerData.filter((item: { physician_speciality: string; }) => item.physician_speciality == 'DP');
       const familyDoctor = this.providerData.filter((item: { physician_speciality: string; }) => item.physician_speciality == 'FP');
       
      if(dentalList && dentalList.length) {
        const addresscheck = this._ytpService.getYTPAddress(dentalList[0].address1, dentalList[0].address2, dentalList[0].city, dentalList[0].state , dentalList[0].zipcode);
        this.healthForm.patchValue({
          currentDentist: dentalList[0].physician_name,
          dentistAddress: addresscheck ? addresscheck : null,
          dentistPhoneNumber: dentalList[0].physician_phone
         });
      }

      if(familyDoctor && familyDoctor.length) {
        const addresscheck = this._ytpService.getYTPAddress(familyDoctor[0]?.address1, familyDoctor[0]?.address2 , familyDoctor[0]?.city ,familyDoctor[0]?.state , familyDoctor[0]?.zipcode);
      
        this.healthForm.patchValue({
          primaryDoctor: familyDoctor[0].physician_name,
          clinicAddress: addresscheck ? addresscheck : null,
          clinicphoneNumber: familyDoctor[0].physician_phone
         });
      }
       
      }
    });
  }

}