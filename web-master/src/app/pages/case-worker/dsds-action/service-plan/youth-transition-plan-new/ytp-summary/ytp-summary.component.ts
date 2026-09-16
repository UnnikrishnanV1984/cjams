import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ChildRemovalService } from '../../../child-removal/child-removal.service';
import { AlertService, DataStoreService, AuthService, CommonHttpService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import moment from 'moment';
import { MatRadioChange } from '@angular/material/radio';
import { addDays } from 'date-fns';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { catchError, tap } from 'rxjs/operators';


declare let $: any;
@Component({
    selector: 'ytp-summary',
    templateUrl: './ytp-summary.component.html',
    styleUrls: ['./ytp-summary.component.scss'],
    standalone: false
})
export class YtpSummaryComponent implements OnInit {
  summaryFormGroup?: FormGroup;
  persons: any[] = [];
  store: any;
  ytpData: any;
  roleId: any;
  isSupervisor!: boolean;
  ytpPersonData: any;
  ytpSummary?: any ;
  followUpOneYearOrNot: boolean = false;
  assessments: any[] = [];
  strengths: any[] = [];
  assessment = { name: ''};
  isReadonly: boolean = true;
  isDisabled: boolean = false;
  ytpDropdown: string = '';
  selectedFilterType!: string|null;
  snapshotVersions = [];
  selectedPeriod: any;
  selectedChild: any;
  selectedChildRemovalDate!: Date;
  selectedVersion: any;
  currentDate!: Date;
  periodList: any[] = [];
  snapshotFilterFormGroup!: FormGroup;

  private formBuilder: FormBuilder;
  private childRemovalService: ChildRemovalService;
  private _alertservice: AlertService;
  private _ytpService: YouthTransitionPlanService;
  private _dataStoreService: DataStoreService;
  private _commonhttp: CommonHttpService;
  private _authService: AuthService;

  constructor(private injector: Injector) {
    this.formBuilder = this.injector.get < FormBuilder > (FormBuilder);
    this.childRemovalService = this.injector.get < ChildRemovalService > (ChildRemovalService);
    this._alertservice = this.injector.get < AlertService > (AlertService);
    this._ytpService = this.injector.get < YouthTransitionPlanService > (YouthTransitionPlanService);
    this._dataStoreService = this.injector.get < DataStoreService > (DataStoreService);
    this._authService = this.injector.get < AuthService > (AuthService);
    this._commonhttp = this.injector.get < CommonHttpService > (CommonHttpService);
    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.summaryFormGroup = this.formBuilder.group({
      name: [null],
      legalname: [null],
      dateofmeeting: [null],
      pronouns: [null],
      clientName: [null],
      prefx: [null],
      age: [null],
      gender: [null],
      dob: [null],
      pregnantcheck: [null],
      parentingcheck: [null],
      parentcheck: [null],
      caseworkername: [null],
      supervisorname: [null],
      ytpdomain: [null],
      agendaitem: [null],
      permanencyplangoal: [null],
      assessments: [],
      strengths: [],
      educationdream: [null],
      employmentCareer: [null],
      transportation: [null],
      identity: [null],
      safeHousing: [null],
      financailMoney: [null],
      communityandculture: [null],
      selfCareHealth: [null],
      legalPermanence: [null],
      ytpdropdownvalue: [null],
    });
    this.ytpData = this._dataStoreService.getData('YTPDATA');
    this.roleId = this._authService.getCurrentUser();
    if (this._authService.selectedRoleIs('apcs')) {
      this.isSupervisor = true;
    }
    if (this.ytpData?.startdate && this.ytpData?.enddate) {
      const start = new Date(this.ytpData.startdate).toLocaleDateString();
      const end = new Date(this.ytpData.enddate).toLocaleDateString();
      this.ytpDropdown = `${start} - ${end}`;
    }
    
    this.ytpSummary = this.ytpData?.new_summary_json;
    this.getSummaryDetails();
    this.childRemovalService.getPersonsList().subscribe(persons => {
      if (persons && persons.data) {
        this.persons = persons.data;
      }
    }
    );
    this.isReadonly =  this._authService.readonlyButton('read_only_access','readonly-ytpsummary');
    this._ytpService.onGetYTPData.subscribe(data => {
      if (data) {
        this.fetchRemovalHistoryAndInitializePeriods(data?.clientid);
        this.getSummaryDetails(data);
      }
    });

    this.summaryFormGroup.patchValue({
      ytpdropdownvalue: this.ytpDropdown
    });
    this.currentDate = new Date();
    this.initSnapshotFilterFormGroup();
  }
  selectedClientId(selectedClientId: any) {
    throw new Error('Method not implemented.');
  }

  openSnapshotFilterModal(): void {
    $('#splan-snapshot-filter-summary').modal('show');
  
    const ytpDropdownValue = this.summaryFormGroup?.get('ytpdropdownvalue')?.value;
  
    if (!ytpDropdownValue) return;
  

    const parts = ytpDropdownValue.split('-');
    const startPart = parts[0]?.trim();
    const endPart = parts[1]?.trim();
  
    const parsedStartDate = startPart ? new Date(startPart) : null;
    const parsedEndDate = endPart ? new Date(endPart) : null;
  
    if (!parsedStartDate || isNaN(parsedStartDate.getTime())) {
      console.error('Invalid start date parsed from dropdown.');
      return;
    }
    if (!parsedEndDate || isNaN(parsedEndDate.getTime())) {
      console.error('Invalid end date parsed from dropdown.');
      return;
    }
  
    this.snapshotFilterFormGroup.patchValue({
      startdate: parsedStartDate,
      enddate: parsedEndDate
    });
  
    const matchedPeriod = this.periodList.find(period =>
      period?.fromdate &&
      period?.todate &&
      new Date(period.fromdate).toLocaleDateString() === parsedStartDate.toLocaleDateString() &&
      new Date(period.todate).toLocaleDateString() === parsedEndDate.toLocaleDateString()
    );    
  
    if (matchedPeriod) {
      this.selectedFilterType = 'PERIOD_RANGE';
      this.selectPeriod(matchedPeriod);
      this.selectedPeriod = matchedPeriod;
    } else {
      console.warn('No matching period found for start date.');
      this.selectedFilterType = 'DATE_RANGE';
      this.selectPeriod(null);
    }
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

  async fetchRemovalHistoryAndInitializePeriods(clientId: any) {
    if (!clientId) {
      this._alertservice.error('Failed to get removal history:');
      this.selectedChildRemovalDate = new Date(); // Removal date doesn't exist
      this.initPeriodList();
      this.setDefaultSnapshotFilterValues();
      return;
    }
    
    try {
      const removalData = await this.getRemovalHistoryOfPerson(clientId);
      if (removalData) {
        this.selectedChildRemovalDate = new Date(this._dataStoreService.getData('YTP_SEL_CHILD').removalInfo?.removaldate);
      } else {
        this._alertservice.error('Failed to get removal history:');      }
    } catch (error: any) {
      this._alertservice.error('Failed to get removal history:', error);
    }
    
    this.initPeriodList();
    this.setDefaultSnapshotFilterValues();
  }

  async getRemovalHistoryOfPerson(personid: any) {
    return new Promise((resolve, reject) => {
      this._commonhttp
        .getSingle(
          {
            where: { objectid: personid, 'objecttypekey': 'personid'},
            method: 'get'
          },
          `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetChildRemovalList}?filter`
        ).subscribe({
          next: (data) => {
            console.log('Removal history data:', data);
            resolve(data || null);
          },
          error: (error) => {
            console.error('Error fetching removal history:', error);
            reject(error);
          }
        });
    });
  }
  createSnapshot() {
    console.log('Creating snapshot with:', {
      filterType: this.selectedFilterType,
      period: this.selectedPeriod,
      dateRange: this.selectedFilterType === 'DATE_RANGE' ? {
        startDate: this.snapshotFilterFormGroup.get('startdate')?.value,
        endDate: this.snapshotFilterFormGroup.get('enddate')?.value
      } : null
    });
  }

  resetSelectedFilterType(): void {
    this.selectedFilterType = null;
  }

  setDefaultSnapshotFilterValues() {
    this.selectedFilterType = 'PERIOD_RANGE';
    this.snapshotFilterFormGroup?.patchValue({
      startdate: new Date(),
      enddate: new Date()
    });
    if(this.periodList?.length>0){
      this.selectPeriod(this.periodList[0]);
    }
  }
  getVersionFilterStartDate() {
    if (this.selectedFilterType === 'DATE_RANGE') {
      return this.snapshotFilterFormGroup.get('startdate')?.value;
    } else 
    if (this.selectedFilterType === 'PERIOD_RANGE') {
      return this.selectedPeriod['fromdate'];
    }
    return this.selectedPeriod['fromdate'];
  }
  resetSelectedChild() {
    this.selectedChild = null;
    }

    selectChild(child: any) {
      this.selectedVersion = null;
      this.viewChildInfo(child);
      this.getChildRemovalDate();
      this._dataStoreService.setData('SELECTED_CHILD_DATA', this.selectedChild);
    }

  viewChildInfo(child: any) {
    this.selectedChild = child;
  }
  
  getVersionFilterEndDate() {
    if (this.selectedFilterType === 'DATE_RANGE') {
      return this.snapshotFilterFormGroup.get('enddate')?.value;
    } else 
    if (this.selectedFilterType === 'PERIOD_RANGE') {
      return this.selectedPeriod['todate'];
    }
    return this.selectedPeriod['todate'];
  }
  getChildRemovalDate() {
    this.selectedChildRemovalDate = new Date(this.selectedChild?.removaldate);
  }

  changeSelectedFilterType(event: MatRadioChange): void {
    // No content to add or call
  }
  
  selectPeriod(item: any): void {
    this.selectedPeriod = item;
  }
  addDaysToRemovalDate(days: any){
    if(days == null){
      return null;
    }
    return addDays(this.selectedChildRemovalDate, days)
  }
  initPeriodList() {
    this.selectedPeriod = null;
    this.periodList = [
      this.initPeriod(1, 0, 60, '0-2', 60),
      this.initPeriod(2, 60, 180, '2-6', 120),
      this.initPeriod(3, 180, 360, '6-12', 180),
      this.initPeriod(4, 360, 540, '12-18', 180),
      this.initPeriod(5, 540, 720, '18-24', 180),
      this.initPeriod(6, 720, 900, '24-30', 180),
      this.initPeriod(7, 900, null, '30+', null)
    ];
  }
  initPeriod(key: any, periodstart: any, periodend: any, timeframe: any, numdays: any) {
    const _fromdate: any = this.addDaysToRemovalDate(periodstart);
    let _todate: any = this.addDaysToRemovalDate(periodend);
    if(!_todate && 
      ((this.currentDate >_fromdate && this.currentDate <=_todate) ||(this.currentDate >_fromdate && this.currentDate >=_todate)) && 
      _fromdate<=this.currentDate){
      _todate = this.currentDate; 
    }
    return {
      'fromdate': _fromdate,
      'todate': _todate,
      'key': key,
      'periodstart': periodstart,
      'periodend': periodend,
      'numdays': numdays,
      'timeframe': timeframe,
      'isPeriodPending': this.isPeriodPending(_fromdate, _todate) 
    };
  }
  initSnapshotFilterFormGroup() {
    this.snapshotFilterFormGroup = this.formBuilder.group({
      personlist: [null],
      startdate: [null],
      enddate: [null]
    });
  }

  createPlan(clientId: any, startdate: any = null, enddate: any = null, data: any = {}) {
      const summary = this.summaryFormGroup?.getRawValue();
      summary.assessments = this.assessments;
      summary.strengths = this.strengths;
      const formattedStart = new Date(startdate).toLocaleDateString();
      const formattedEnd = new Date(enddate).toLocaleDateString();

      summary.startdate = formattedStart;
      summary.enddate = formattedEnd;

      summary['new_summary_json'] = summary['new_summary_json'] || {};
      summary['new_summary_json'].ytpdropdownvalue = `${formattedStart} - ${formattedEnd}`;


      this._ytpService.patchData('new_summary_json', summary)
      .subscribe(
        response => {
          this._alertservice.success('YTP updated successfully!', true);
          this.store['YTPDATA'].new_summary_json = summary;
          setTimeout(() => {
          window.location.reload();
        }, 1000);
        },
        error => {
          this._alertservice.error('Error in saving dates!');
        }
      );
  }
  isPeriodPending(fromdate: any, todate: any){
    const f = this.snapshotVersions?.find((version: any)=>
      new Date(version.fromdate).setHours(0,0,0,0) == new Date(fromdate).setHours(0,0,0,0) &&
      (todate == version.todate || new Date(version.todate).setHours(0,0,0,0) == new Date(todate).setHours(0,0,0,0)) &&
      (version.approvalstatus == 'Pending' || version.approvalstatus== 'Draft' || version.approvalstatus == 'Approved')
    ) ;
    return f ? true : false;
  }
  checkforfuturedate(item: any){
    if((this.currentDate >item.fromdate && this.currentDate <=item.todate) ||(this.currentDate >item.fromdate && this.currentDate >=item.todate) ){
      return;
    } else {return 'disabledfield';}
   }
  formatDateToString(date: Date): any {
    const convertedDate = moment(date);
    if (convertedDate.isValid()) {
      return convertedDate.format('MM/DD/YYYY');
    } else {
      return null;
    }
  }

  saveMethod = () => this.saveSummaryObservable();
  
  saveSummaryObservable() {
    const summary = this.summaryFormGroup?.getRawValue();
    summary.assessments = this.assessments;
    summary.strengths = this.strengths;
    return this._ytpService.patchData('new_summary_json', summary)
      .pipe(
        tap(response => {
          this._alertservice.success('Summary entered successfully!');
          this.store['YTPDATA'].new_summary_json = summary;
        }),
        catchError(error => {
          this._alertservice.error('Error in entering Summary details!');
          throw error;
        })
      );
  }

  saveSummary() {
    const summary = this.summaryFormGroup?.getRawValue();
    summary.assessments = this.assessments;
    summary.strengths = this.strengths;
    this._ytpService.patchData('new_summary_json', summary)
    .subscribe(
      response => {
        this._alertservice.success('Summary entered successfully!');
        this.store['YTPDATA'].new_summary_json = summary;
      },
      error => {
        this._alertservice.error('Error in entering Summary details!');
      }
    );
  }

  getSummaryDetails(data? : any) {
    this.ytpData = data ? data : this._dataStoreService.getData('YTPDATA');
    this.isDisabled = this.ytpData?.approvalstatuskey == 'Pending' || this.ytpData?.approvalstatuskey == 'Approved';  
    this.ytpPersonData = this._dataStoreService.getData('YTP_SEL_CHILD');
    if(this.ytpData && this.ytpData?.new_summary_json){
      this.summaryFormGroup?.patchValue(this.ytpData?.new_summary_json);
      this.assessments = [];    //@TM: Convert date to enable patching and display on UI
      this.strengths = [];
      this.checkSummaryJsonFn();
    } else {
      this.summaryFormGroup?.reset();
    }
    if (this.roleId.user.username && (!this.ytpData?.new_summary_json || !this.ytpData?.new_summary_json.caseworkername)) {
      if (this.isSupervisor) {
        this.summaryFormGroup?.patchValue({supervisorname: this.roleId.user.userprofile.fullname});
      } else {
        this.summaryFormGroup?.patchValue({caseworkername: this.roleId.user.userprofile.fullname});
      }
    } else {
      this.summaryFormGroup?.patchValue({supervisorname: null, caseworkername: null});
    }
  }

  private checkSummaryJsonFn() {
    if (this.ytpData?.new_summary_json.assessments && this.ytpData?.new_summary_json.assessments.length > 0) {
      for (const assessment of this.ytpData?.new_summary_json.assessments) {
        this.assessments.push(assessment);
      }
    }
    if (this.ytpData?.new_summary_json.strengths && this.ytpData?.new_summary_json.strengths.length > 0) {
      for (const strength of this.ytpData?.new_summary_json.strengths) {
        this.strengths.push(strength);
      }
    }
  }

  clearSummary() {
    this.summaryFormGroup?.reset();
  }


  addAssessment() {
    this.assessments.push({ name: '' });
  }

  deleteAssessment(index: any) {
    this.assessments.splice(index, 1);
  }

  addStrength() {
    this.strengths.push({ name: ''});
  }

  deleteStrength(index: any) {
    this.strengths.splice(index, 1);
  }

}
