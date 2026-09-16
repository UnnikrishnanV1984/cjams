import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ChildRemovalService } from '../../../child-removal/child-removal.service';
import { AlertService, DataStoreService, CommonHttpService, SessionStorageService, AuthService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import moment from 'moment';

@Component({
    selector: 'ytp-summary',
    templateUrl: './ytp-summary.component.html',
    styleUrls: ['./ytp-summary.component.scss'],
    standalone: false
})
export class YtpSummaryComponent implements OnInit {
  summaryFormGroup!: FormGroup;
  persons: any[] = [];
  ytpData: any;
  ytpSummary: any = {};
  followUpOneYearOrNot: boolean = false;
  participants: any[] = [];
  assessments: any[] = [];
  participantTypes: any[] = [];
  assessment = { name: '', completionDate: null };
  isReadonly!: boolean;

   private formBuilder: FormBuilder;
    private childRemovalService: ChildRemovalService;
    private _alertservice: AlertService;
    private _ytpService: YouthTransitionPlanService;
    private _dataStoreService: DataStoreService;
    private _commonHttpService: CommonHttpService;
    private _authService: AuthService;
    private storage: SessionStorageService;

    constructor(private injector:Injector) {
      this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
      this.childRemovalService = this.injector.get<ChildRemovalService>(ChildRemovalService);
      this._alertservice = this.injector.get<AlertService>(AlertService);
      this._ytpService = this.injector.get<YouthTransitionPlanService>(YouthTransitionPlanService);
      this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
      this._authService = this.injector.get<AuthService>(AuthService);
      this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
      this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);    
     }
    
  ngOnInit() {
    this.summaryFormGroup = this.formBuilder.group({
      name: [null],
      dob: [null],
      dateenteredfostercare: [null],
      caseno: [null],
      permanencyplangoal: [null],
      caseworkername: [null],
      completiondate: [null],
      transplancompleted: [null],
      planfollowupdate: [null],
      participantsinvolved: [null],
      participants: [],
      assessments: []
    });

    this.summaryFormGroup.disable();
    
    this.ytpData = this._dataStoreService.getData('YTPDATA');
    this.ytpSummary = this.ytpData.summary_json;
    if (this.ytpData.summary_json && this.ytpData.summary_json.planfollowupdate && this.ytpData.summary_json.transplancompleted){
      const followUpDateCheck = moment(this.ytpData.summary_json.planfollowupdate);
      const caseCreationDate = moment(this.ytpData.summary_json.transplancompleted);
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
    this.loadParticipantTypes();
    const activeModuleRole = this.storage.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
    this.isReadonly =  this._authService.readonlyButton('read_only_access','readonly-ytpsummary');}
  }
  getFullName(person: any) {
      const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
      let name = '';
      nameKeys.forEach(key => {
      if(person && person.hasOwnProperty(key)){
        if ( (person[key] != null) && (person[key] != 'null') && (person[key] != '') ) {
          name = name + person[key] + ' ';
      }}
      });
      return name;
  }
  formatDateToString(date: Date): string | null {
    const convertedDate = moment(date);
    if (convertedDate.isValid()) {
      return convertedDate.format('MM/DD/YYYY');
    } else {
      return null;
    }
  }
  
  saveSummary() {
    const summary = this.ytpSummary;
    summary.assessments = this.assessments;
    summary.participants = this.participants;
    this._ytpService.patchData('summary_json', summary)
    .subscribe(
      response => {
        this._alertservice.success('Summary entered successfully!');
      },
      error => {
        this._alertservice.error('Error in entering Summary details!');
      }
    );
  }

  getSummaryDetails() {
    this.ytpData = this._dataStoreService.getData('YTPDATA');
    if(this.ytpData && this.ytpData.summary_json){
      this.participants = this.ytpData.summary_json.participants ? this.ytpData.summary_json.participants : [];
      
      this.assessments = [];    //@TM: Convert date to enable patching and display on UI
      if(this.ytpData.summary_json.assessments && this.ytpData.summary_json.assessments.length > 0) {
        for(const assessment of this.ytpData.summary_json.assessments) {
          assessment.completionDate = new Date(assessment.completionDate);
          this.assessments.push(assessment);
        }
      }
    }
  }

  clearSummary() {
    this.summaryFormGroup.reset();
  }

  loadParticipantTypes() {
    this._commonHttpService.getArrayList(
      {
        method: 'get'
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.Fim.ParticipantTypesUrl + '?filter'
    ).subscribe(response => {
      if (response && Array.isArray(response)) {
        this.participantTypes = response;
      }
    });
  }

  onInvolvedPersonChanged() {
  }

  changeParticipants(event: any) {
    const person = event.source.value
    const newParticipant = {
      type: 'Involved person',
      firstname: person.firstname,
      lastname: person.lastname,
      relationship: person.relationship
    };
    this.participants.push(newParticipant);
  }

  deleteParticipant(index: any) {
    this.participants.splice(index, 1);
  }

  addOtherParticipant() {
    const newParticipant = {
      type: '',
      firstname: '',
      lastname: '',
      relationship: ''
    };
    this.participants.push(newParticipant);
  }

  addAssessment() {
    this.assessments.push({ name: '', completionDate: null });
  }

  deleteAssessment(index: any) {
    this.assessments.splice(index, 1);
  }

}
