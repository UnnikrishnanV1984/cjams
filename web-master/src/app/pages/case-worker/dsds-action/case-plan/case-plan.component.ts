
import {map} from 'rxjs/operators';
import { Component, Injector, OnInit, ViewChild } from '@angular/core';
import { CasePlanService } from './case-plan.service';
import { FormBuilder, FormGroup } from '@angular/forms';
import { CP_TABS } from './case-plan-config';
import { DataStoreService, AuthService, AlertService, SessionStorageService, CommonHttpService } from '../../../../@core/services';
import { ActivatedRoute, Router } from '@angular/router';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { MatRadioChange } from '@angular/material/radio';
import { AppConstants } from '../../../../@core/common/constants';
import JSZip from 'jszip';
import {addDays} from 'date-fns';
import { saveAs } from 'file-saver';
import { CasePlanTwoComponent } from './case-plan-two/case-plan-two.component';
import { CasePlanFourComponent } from './case-plan-four/case-plan-four.component';
import { CasePlanFiveComponent } from './case-plan-five/case-plan-five.component';
import { Observable } from 'rxjs';
import moment from 'moment';
import { environment } from '../../../../../environments/environment';

@Component({
    selector: 'case-plan',
    templateUrl: './case-plan.component.html',
    styleUrls: ['./case-plan.component.scss'],
    standalone: false
})
export class CasePlanComponent implements OnInit {
  childList: any[] = [];
  selectedChild: any;
  selectedVersion: any;
  parent1: any[] = [];
  parent2: any[] = [];
  raceDropDown: any = {};
  childCardFormGroup!:  FormGroup;
  riskAssessment: any;
  safeCAssessment: any;
  searchResult: any;

  tabs: any[] = CP_TABS;
  CASE_PLAN_ONE_PATH = 'case-plan-one';
  CASE_PLAN_TWO_PATH = 'case-plan-two';
  intakeservicerequestactorids: any[] = [];

  isSupervisor!: boolean;
  snapshotVersions: any[] = [];
  snapshotVersions$!: Observable<any>;

  selectedChildRemovalDate!: Date;

  //Periods for review
  periodList: any[] = [];

  //Filtering
  selectedFilterType!: string | null;
  selectedPeriod: any;

  snapshotFilterFormGroup!: FormGroup;
  selectedSnapshotVersion: any;

  //Routing and approval
  selectedPerson: any;
  getUsersList: any[] = [];
  approvalProcess!: string;
  user!: AppUser;
  reviewComments: any;
  reviewFormGroup!: FormGroup;

  @ViewChild(CasePlanFourComponent) cp4component!: CasePlanFourComponent;
  @ViewChild(CasePlanFiveComponent) cp5component!: CasePlanFiveComponent;
  @ViewChild(CasePlanTwoComponent) cp2component!: CasePlanTwoComponent;

  id = '';
  daNumber = '';
  legacy: boolean = false;
  casePlanFlag: boolean = true;
  ytpflag: boolean = true;
  cpTwoFlag: boolean = true;
  store: any;
  moduleview: any;
  currentDate : any;
  deleteItem: any;
  isReadonly: any;
  environment = environment;
  confirmpopupid = '#confirm-decision';
  deletepopupid = '#delete-popup';
  generatedocurl = 'evaluationdocument/generateintakedocument';
  private _commonHttpService: CommonHttpService;
  private _dataStoreService: DataStoreService;
  private _authService: AuthService;
  private _alertService: AlertService;
  private _formBuilder: FormBuilder;
  private route: ActivatedRoute;
  private _router: Router;
  private storage: SessionStorageService;
  private _casePlanService: CasePlanService;
  constructor(private injector: Injector,) {
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._router = injector.get<Router>(Router);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._casePlanService = this.injector.get<CasePlanService>(CasePlanService);
    this.route.data.subscribe(data => {
      if (data && data.hasOwnProperty('result')) {
        this._authService.setAuthDetail('caseplan', data.result);
      }
    });
  }

  ngOnInit() {
    this.moduleview = this._authService.isModuleAccessable('caseplan', 'caseplan');
    this.store = this._dataStoreService.getCurrentStore();
    const childList = this._casePlanService.getChildList();
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
    this.user = this._authService.getCurrentUser();
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.childList = childList.filter(data => this.childFilter(data));
    this.initForm();
    this.parent1 = this._casePlanService.getParent('Biological Mother');
    this.parent2 = this._casePlanService.getParent('Biological Father');
    this.currentDate = new Date()

    this.involvedPersonDropdown();
    this.getAssessmentsForm();
    
    this.initSnapshotFilterFormGroup();
    this.initReviewFormGroup();
    const activeModuleRole = this.storage.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
    this.isReadonly =  this._authService.readonlyButton('read_only_access','readonly-servicelog');}
  }

  initForm() {
    this.childCardFormGroup = this._formBuilder.group({
      child: [null],
    });
  }

  childFilter(data: any) {
    if (data.removalid) {
      return true;
    } else if (data.programarea && Array.isArray(data.programarea) && data.programarea.length > 0) {
      return data.programarea.find((item: { programkey: string; }) => item.programkey === 'OOH') ? true : false;
    } else {
      return false;
    }
}

  viewChildInfo(child: any) {
    this.selectedChild = child;
    this.selectedChild.parent1name = ( this.parent1 && this.parent1.length ) ? ( this.parent1[0].firstname + ' ' +  this.parent1[0].lastname ) : null;
    this.selectedChild.parent2name = ( this.parent2 && this.parent2.length ) ? ( this.parent2[0].firstname + ' ' +  this.parent2[0].lastname ) : null;
    this.selectedChild.riskAssessment = (this.riskAssessment && this.riskAssessment.length) ? this.riskAssessment[0] : null;
    this.selectedChild.safeCAssessment = (this.safeCAssessment && this.safeCAssessment.length) ? this.safeCAssessment[0] : null;
    this.viewSocialHistoryInfo(child);
  }

  selectChild(child: any) {
    if (child.removaldtforcaseplan) {
        child.removaldate = child.removaldtforcaseplan;
    }
    this.selectedVersion = null;
    this.viewChildInfo(child);
    this.getActorIds();
    this.getChildRemovalDate();
    this._dataStoreService.setData('SELECTED_CHILD_DATA', this.selectedChild);
    this.getHist(child.personid);
    this.legacy = false;
    this.casePlanFlag = false;
  }

  selectVersion(version: any) {
    this.selectedVersion = version;
    this._dataStoreService.setData('SELECTED_VERSION', version);
    this._router.navigate([this.CASE_PLAN_ONE_PATH], { relativeTo: this.route });
  }
  showLegacy(){
    if(this.selectedChild) {
      if(this.legacy){
        this.legacy = false;
      }else{
        this.legacy = true;}
    }
  }
  showCasePlan() {
    if(this.selectedChild) {
      if(this.casePlanFlag){
        this.casePlanFlag = false;
      }else{
        this.casePlanFlag = true;}
    }
  }

  getAssessmentsForm() {
    this._casePlanService.getAssessMents('MARYLAND FAMILY INITIAL RISK ASSESSMENT').subscribe(data => {
       this.riskAssessment = data.data[0];
    });
    this._casePlanService.getAssessMents('SAFE-C').subscribe(data => {
      this.safeCAssessment = data.data[0];
   });
  }

  getRaceDesc(key: any) {
    if (this.raceDropDown  && this.raceDropDown[key]) {
        return this.raceDropDown[key];
    } else {
      return null;
    }
  }
  private involvedPersonDropdown() {
    this.raceDropDown = {};
   this._casePlanService.loadRaceDropDown().
   subscribe( res => {
    res.forEach((data: any) => {
      this.raceDropDown[data.racetypekey] = data.typedescription;
    });
    // text: res.typedescription,
    // value: res.racetypekey,
    });


}

  resetSelectedChild() {
    this.selectedChild = null;
    this.childCardFormGroup.reset();
  }

  viewSocialHistoryInfo(child: any) {
    if ( child &&  child.intakeservicerequestactorid) {
      this._casePlanService.getSocialHistory(child.intakeservicerequestactorid).subscribe(data => {
        if (data && data.length) {
         this.selectedChild.placement = data[0].placement;
         this.selectedChild.familyhistory = data[0].familyhistory;
         this.selectedChild.childdesc = data[0].childdesc;
        }
      });
    }  else  {
      this.selectedChild = [];
    }
  }
  
  getActorIds() {
    this.intakeservicerequestactorids = [];
    if (this.selectedChild.roles && Array.isArray(this.selectedChild.roles)) {
      this.selectedChild.roles.forEach((role: { intakeservicerequestactorid: any; }) => {
        this.intakeservicerequestactorids.push(role.intakeservicerequestactorid)
      });
    }
  }

  getChildRemovalDate() {
    this.selectedChildRemovalDate = new Date(this.selectedChild.removaldate);
  }

  generatecaseplansnapshot() {
    this._casePlanService.genCasePlan(
      {
        personid: this.selectedChild.personid,
        servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID),
        intakeservicerequestactorid: this.selectedChild.intakeservicerequestactorid,
        intakeservicerequestactorids: this.intakeservicerequestactorids,
        periodstartdate: this.getVersionFilterStartDate(),
        periodenddate: this.getVersionFilterEndDate(),
        // cplanquestions: this.casePlanQuestionsFormGroup.getRawValue(),
        method: 'post',
        nolimit: true
      }).subscribe((_result: any) => {
        this.getHist();
      });
  }

  //Snopshot version work
  initSnapshotFilterFormGroup() {
    this.snapshotFilterFormGroup = this._formBuilder.group({
      personlist: [null],
      startdate: [null],
      enddate: [null]
    });
  }

  initReviewFormGroup() {
    this.reviewFormGroup = this._formBuilder.group({
      comments: [null]
    });
  }


  setDefaultSnapshotFilterValues() {
    this.selectedFilterType = 'PERIOD_RANGE';
    this.snapshotFilterFormGroup.patchValue({
      startdate: new Date(),
      enddate: new Date()
    });
    if(this.periodList?.length>0){
      this.selectPeriod(this.periodList[0]);
    }
  }

  setSelectedSnapshotVersion(item: any) {
    this.selectedSnapshotVersion = item;
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
  isPeriodPending(fromdate: any, todate: any){
    const f = this.snapshotVersions?.find(version=>
      new Date(version.fromdate).setHours(0,0,0,0) == new Date(fromdate).setHours(0,0,0,0) &&
      (todate == version.todate || new Date(version.todate).setHours(0,0,0,0) == new Date(todate).setHours(0,0,0,0)) &&
      (version.approvalstatus == 'Pending' || version.approvalstatus== 'Draft' || version.approvalstatus == 'Approved')
    ) ;
    return f ? true : false;
  }
  addDaysToRemovalDate(days: any){
    if(days == null){
      return null;
    }
    return addDays(this.selectedChildRemovalDate, days)
  }

  getPeriod(item: any){
    const list = this.periodList.filter(p =>  moment(p.fromdate).format('YYYY-MM-DD') === item.fromdate)
    if (list && list.length) {
       item.timeframe =  list[0].timeframe ? list[0].timeframe + ' months' : 'Custom Range';
       let periodend = list[0].periodend? ' - '+ list[0].periodend : '+';
       item.periodrange = list[0] ? (list[0].periodstart + periodend +' days') : 'Custom Range';
    }
    return  item.periodrange;
  }
  /**
   * Snapshot work 
   * */
  getVersionFilterStartDate() {
    if (this.selectedFilterType === 'DATE_RANGE') {
      return this.snapshotFilterFormGroup.get('startdate')?.value;
    } else 
    if (this.selectedFilterType === 'PERIOD_RANGE') {
      return this.selectedPeriod['fromdate'];
    }
    return this.selectedPeriod['fromdate'];
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

  //Filtering
  resetSelectedFilterType() {
    this.selectedFilterType = null;
  }

  changeSelectedFilterType(event: MatRadioChange) {
    //No operation needed here
  }

  selectPeriod(item: any) {
    this.selectedPeriod = item;
  }

   //Snapshot version approval and routing

   getRoutingUser(appovalValue: any) {
    this.approvalProcess = appovalValue;

    this.getUsersList = [];
    if (appovalValue === 'Pending') {
      this._casePlanService.getRoutingUsers()
      .subscribe(result => {
          this.getUsersList = result.data;
          this.getUsersList = this.getUsersList.filter(
              users => users.userid !== this._authService.getCurrentUser().user.securityusersid
          );
      });
    }  else {
      (<any>$(this.confirmpopupid)).modal('show');
    }
  }
  
  selectPerson(row: any) {
    this.selectedPerson = row;
  }

  assignNewUser() {
      
    // Instead of the service plan, the snapshot version is sent for approval 
    // selectedService.approvalstatustypekey = this.approvalProcess;
    
    this.selectedSnapshotVersion.approvalstatus = this.approvalProcess;

    const payload = {
      eventcode: 'CPLAN2',
      tosecurityusersid: this.selectedPerson ? this.selectedPerson.userid : '',
      objectid: this.selectedSnapshotVersion.id,
      serviceNumber: this.daNumber,
      approvalstatustypekey: this.approvalProcess
    };
    this._casePlanService.assignUser(payload).subscribe(
      (response) => {
        if( response && response.data && response.data.length >0 && response.data[0].caseplanrouting && response.data[0].caseplanrouting
==="Success") 
          {
        this._alertService.success('Decision submitted successful!');
        this.updateSnapshotVersionStatus();
        (<any>$('#intake-caseassignnewX')).modal('hide');
          } else {
            this._alertService.error('Unable to submit decision!');

          }
      },
      (error) => {
        this._alertService.error('Unable to submit decision!');
      });
  }

  updateSnapshotVersionStatus() {
    const payload: any = {};
    payload['id'] = this.selectedSnapshotVersion.id;
    payload['approvalstatus'] = this.approvalProcess;
    payload['updatedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    payload['insertedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    payload['comments'] = this.reviewFormGroup.get('comments')?.value
    this._casePlanService.updateSnapshot(payload).subscribe(
      () => {
        this.getHist();
        this._alertService.success('Decision submitted successfully!');
      },
      (_error: any) => {
        this._alertService.error('Error in submitting decision!');
      }
    );
  }

  confirmDecision() {
    this.assignNewUser();
    (<any>$(this.confirmpopupid)).modal('hide');
  }

  cancelDecision() {
    this.reviewFormGroup.reset();
    (<any>$(this.confirmpopupid)).modal('hide');
  }

  showReviewComments(item: any) {
    this.reviewComments = item.comments ? item.comments : 'No comments found!';
  }

  /**
   * Regenerate case plan snapshot
   * we will recapture all the application data, 
   * basically re-hydrate the existing snapshot with latest data
   * but preserve the editable questions that have been answered
   * -- All editable data goes in cplanquestion
   */
  regeneratecaseplansnapshot() {
    this._casePlanService.genCasePlan(
      {
        personid: this.selectedChild.personid,
        servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID),
        intakeservicerequestactorid: this.selectedChild.intakeservicerequestactorid,
        intakeservicerequestactorids: this.intakeservicerequestactorids,
        periodstartdate: this.selectedVersion.fromdate,
        periodenddate: this.selectedVersion.todate,
        cplanquestions: this.getCplan(this.selectedVersion),
        method: 'post',
        nolimit: true
      }).subscribe(() => {
        this.getHist();
      });
  }
  getCplan(selectedVersion: any){
    return selectedVersion && selectedVersion.snapshotdata && selectedVersion.snapshotdata.length > 0 && selectedVersion.snapshotdata[0].cplanquestions? selectedVersion.snapshotdata[0].cplanquestions : null;
  }

  deleteCasePlanSnapshot()  { 
    const data = this.deleteItem; 
    this.selectedSnapshotVersion = data;
    const payload: any = {};
    payload['id'] = data.id;
    payload['activeflag'] = 0;
    payload['updatedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    payload['insertedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    this._casePlanService.updateSnapshot(payload)
      .subscribe(
        (response: any) => {
          this._alertService.success('Case plan version deleted successfully');
          this.getHist();
          (<any>$(this.deletepopupid)).modal('hide');
        },
        (error: any) => {
          this._alertService.error('Could not delete Case plan version');
          this.getHist();
          (<any>$(this.deletepopupid)).modal('hide');
        this.deleteItem = null;
      });

      this._commonHttpService.create(payload, 'routing/deleteByObjectId').subscribe();
    
  }

getHist(personid = null){
  if (personid == null){
    personid = this.selectedChild.personid;
  }
  this.initPeriodList();
  this.snapshotVersions$ = this._casePlanService.getHistoryForServicePlan(personid).pipe(map(response => { return response;}));
  this.snapshotVersions$.subscribe(data => {
    const filterDataByPersonId =   data?.filter((x: { personid: null; })=> x.personid === personid);
    this.snapshotVersions = filterDataByPersonId;
  });
}

  downloadAll(){ 
    var zip = new JSZip();
    var count = 0;
    var zipFilename = "Case-Plan.zip";
    var urls =this.processCasePlanRequest();
    urls.forEach((url)=>{
      // loading a file and add it in a zip file
      this._casePlanService.getPdfBlob(url.payload,url.url).subscribe(response=> {
          var filename = url.filename;
          zip.file(filename,response,{binary:true});
          count++;
          if (count == urls.length) {
            zip.generateAsync({type:'blob'}).then(function(content) {
                saveAs(content, zipFilename);
            });
          }
      });
    });

    
  }

  fetchUrls(ytp: any, i: any) {
    return {
      payload: {
        count: -1,
        where: {
          documenttemplatekey: ['ytp'],
          selYouth: ytp,
          zippdf: true
        },
        method: 'post'
      },
      filename: 'Youth Transition Plan-' + i + '.pdf',
      url: this.generatedocurl
    }
  }

  processCasePlanRequest() {
    const caseplan = this.selectedVersion;
    const urls: any[] = [];
    //Case Plan 1 
    const payload = this.store.SELECTED_CASEPLAN1_PAYLOAD;
    const ssn = payload.where.ssn;
    payload.where.ssn = (ssn != null && ssn != undefined && ssn != '') ? "***-**-" + ssn.substr(ssn.length - 4, 4) : "";
    payload.where.zippdf =true;
    urls.push({
      url: this.generatedocurl,
      payload: payload,
      filename : 'Case Plan - Social History.pdf'
    });
    //Case Plan 2
    const payload2: any = this.cp2component.preparePDFrequest();
    payload2.where['zippdf'] =true;
    urls.push({
      url: 'caseplan/getReportCaseplan',
      payload: payload2,
      filename : 'Case Plan - Permanency Progress.pdf'
    });
    //Case Plan - service plan 
    if(caseplan && caseplan.snapshotdata && caseplan.snapshotdata[0]){
      const snapshotdata = caseplan.snapshotdata[0];
      const versionList = snapshotdata.versionList ? snapshotdata.versionList : [];
      let i=0;
      versionList.forEach((serviceplanversion: { serviceplanid: any; id: any; }) => {
        i++;
        urls.push({
          url:'serviceplan/getreportserviceplan',
          payload:{
            method: 'post',
            count: -1,
            page: 1,
            limit: 20,
            where: {
                    'zippdf':true,
                    'intakeserviceid': this.id,
                    'id': serviceplanversion.serviceplanid,
                    'type': 'OOH',
                    'snapshotid': serviceplanversion.id,
                    'isheaderrequired': false,
                  },
            documntkey: [ 'oohome'],
          },
          filename:'ServicePlan - OutOfHome-'+i+'.pdf',
          method:1
        });
      });
    }
        //Case Plan 4 - YTP
    if(this.cp4component && this.cp4component.ytpList){
      this.cp4component.ytpList.forEach((ytp: any, i: any) => {
        urls.push(this.fetchUrls(ytp, i));
      });
    }
    if(this.cp5component && this.cp5component.ytpList){
      this.cp5component.ytpList.forEach((ytp: any, i: any) => {
        urls.push(this.fetchUrls(ytp, i));
      });
    }
    return urls;
  }

  declineDelete() {
    (<any>$(this.deletepopupid)).modal('hide');
  }
  confirmDelete(modal: any){
    if(modal && modal?.approvalstatus === 'Pending'){
      this._alertService.error('Please approve or reject the case plan to delete.');
    } else{
      this.deleteItem = modal;
      (<any>$(this.deletepopupid)).modal('show');
    }
  }
  checkforfuturedate(item: any){
   if((this.currentDate >item.fromdate && this.currentDate <=item.todate) ||(this.currentDate >item.fromdate && this.currentDate >=item.todate) ){
     return '';
   } else {return 'disabledfield';}
  }

}
