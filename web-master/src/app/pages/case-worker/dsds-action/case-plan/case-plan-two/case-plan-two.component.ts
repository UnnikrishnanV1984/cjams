import { Component, OnInit, OnDestroy} from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { CommonHttpService, DataStoreService, AuthService, AlertService } from '../../../../../@core/services';
import { CasePlanService } from '../case-plan.service';
import _ from 'lodash';
import moment from 'moment';
import { config } from '../../../../../../environments/config';


@Component({
    selector: 'case-plan-two',
    templateUrl: './case-plan-two.component.html',
    styleUrls: ['./case-plan-two.component.scss'],
    standalone: false
})
export class CasePlanTwoComponent implements OnInit, OnDestroy {
  currentDataStore: any;


  casePlanQuestionsFormGroup!: FormGroup;
  

  //Editable case plan
  selectedVersion: any;
  expandAll = true;
  caseplan2data: any = {placementinformation: []};
  personsList: any[] = [];
  serviceLogs: any[] = [];
  currentplacemnt: string = '';
  autoSaveIntervalTimer!: NodeJS.Timer;
  autoSaveInitiated: boolean = false;
  currentCasePlan: any;
  lastUpdatedTime: any = null;
  isCasePlanAutoSaveFlag: boolean = false;
  constructor(
    private _formBuilder: FormBuilder,
    private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _authService: AuthService,
    private _alertservice: AlertService,
    private _casePlanService: CasePlanService
  ) {
    this.currentDataStore = this._dataStoreService.getCurrentStore();
  }
  
  ngOnInit() {
    this.selectedVersion = this.currentDataStore['SELECTED_VERSION']
    this.personsList =    this._casePlanService.getCasePersonsList();
    this.cPlanQuestionsFormGroup();
    this.selectVersion(this.selectedVersion);
    this.existingForm();
    this.initiateAutoSave(true);
  }
  initiateAutoSave(enableFlag: any, formData?: any, index?: any) {
    let diffFlag = true;
    if(enableFlag) {
    if(!this.autoSaveInitiated){
        this.autoSaveInitiated = true;
        this.autoSaveIntervalTimer = setInterval(() => {
            
            const latestcasePlan = this.casePlanQuestionsFormGroup.getRawValue();
            diffFlag = _.isEqual(this.currentCasePlan,latestcasePlan);
            if(!diffFlag && this.selectedVersion['approvalstatus'] !=='Approved' && this.selectedVersion['approvalstatus'] !=='Pending'){
              this.saveSnapshotData(null,true);
            }
        }, config.AutoSaveTimer);
        this._dataStoreService.setData('CasePlanAutoSaveTimer', this.autoSaveIntervalTimer);
    }
 }  
}
existingForm(){
  setTimeout(()=>{
  this.currentCasePlan = this.casePlanQuestionsFormGroup.getRawValue();
  }, 3000);
}
ngOnDestroy(): void {
  clearInterval(this._dataStoreService.getData('CasePlanAutoSaveTimer'));
}
  ngAfterViewInit() {
    this.scroll('versions-table');
    this.preparePDFrequest();
  }

  scroll(id: any) {
    const el: any = document.getElementById(id);
    el.scrollIntoView({behavior: 'smooth', block: 'start', inline: 'nearest'});
  }

  casePlan2Print() {
    const item = this.selectedVersion;
    const cplan2data =  (Array.isArray(item.snapshotdata) && item.snapshotdata.length) ? item.snapshotdata[0] : item.snapshotdata;
    cplan2data['serviceLogs'] = this.serviceLogs;
    const inputRequest = {
      'caseplan2data': cplan2data,
      'isheaderrequired': false,
  };
  const payload = {
    method: 'post',
    count: -1,
    page: 1,
    limit: 20,
    where: inputRequest,
    documntkey: [
      'oohome'
  ],
  };
  this._commonHttpService.create(payload, 'caseplan/getReportCaseplan').subscribe(
    response => {
      setTimeout(() => window.open(response.data.documentpath), 2000);
   });
    // this.backupService = this.selectedService ? this.selectedService : null;
    // this.selectedService = item;
    // (<any>$('#servicePlanOohPrint')).modal('show');
  }

  
  // Case Plan Question 
  cPlanQuestionsFormGroup() {
    this.casePlanQuestionsFormGroup = this._formBuilder.group({
      // safeAppropriateCare: [null],
      discussVisitationPlan: [null],
      currentRelationship: [null],
      parentChildInteraction: [null],
      servicesForStability: [null],
      servicesForPermanencyClients: [null],
      servicesForPermanencyOther: [null],
      refMadeDate: [null],
      physicalOrMentaldiagnosis: [null],
      episodesOfHomelessness: [null],
      lengthOfHomeless: [null],
      outOfHomeService: [null],
      facilitatePermanencySelfSufficiency: [null],
      specifyTheNeedsAndServices: [null],
      utilizationOrNonUtilization: [null],
      // flexibleFundsBeenExpended_purpose: [null],
      // flexibleFundsBeenExpended_Amount: [null],
      healthPassport: [null],
      reimbursement: [null],
      discussionOfVisitation: [null],
      emotionalSupportGuidance: [null],
      otherReasons: [null],
      dayCare: [null],
      transportation: [null],
      financialSupport: [null],
      specialTraining: [null],
      discussionOfChildsNeeds: [null],
      respiteCare: [null],
      writeOtherReson: [null],
      diagnosedAxisOne:false,
      diagnosedAxisTwo:false,
      diagnosedAxisThree:false,
      diagnosedAxisFour:false,
      diagnosedAxisFive:false,
      diagnosedAxisOneComment:'',
      diagnosedAxisTwoComment:'',
      diagnosedAxisThreeComment:'',
      diagnosedAxisFourComment:'',
      diagnosedAxisFiveComment:'',
      //curentplacetolive:null,
      //isInClosedProximity:[null],
      //isInClosedProximityExpln:[null],
      //meetingSafetyNeedsExpln:[null],
      //isTreatmentFosterCare:[null],
      //treatmentteameetingdate:[null],
      //lasttreatmentteameetingdate:[null],
      lastprogressreportdate:[null],
      sixMonthsPlacementExpln:[null],
      servicecourtorderdetails:[null],
      visitationcourtorderdetails:[null],
      //courtOrdersExpln:[null],
      //primarypermanencytype:[null],
      //concurrentpermanencytype:[null],
      //establisheddate:[null],
      facilitatePermanencySelfSufficiencyStartDate:[null],
      facilitatePermanencySelfSufficiencyEndDate:[null],
      //permToPermExpln:[null],
      faceToFaceVisit:[null],
      isChildCoComitted:[null],
      episodeExperience:[null],
      episodeExperienceExplain:[null],
      juvenileCourtInvolvement:[null],
      discussServices:[null],
      faceToFaceVisitContactDate:[null],
      faceToFaceVisitAuthoredDate:[null],
      //safeAndCareExpln:[null],
      addressChildNeeds:[null],
      //assessmentPeriodExpln:[null],
      //lifebookExpln:[null],
      //serviceAgreementExpln:[null],
      //parentsInvolvementExpln:[null],
      reasonTPRPetition:[null],
      parentName:[null],
      childInAndOutOfHome:[null],
      tprPetitionDate:[null],
      voluntarySignatureDateMother:[null],
      voluntarySignatureDateFather:[null],
      tprGrantedDate:[null],
      tprDeniedDate:[null],
      tprAppealDateMother:[null],
      tprAppealDateFather:[null],
      tprAppealDecisionDateFather:[null],
      tprAppealDecisionDateMother:[null],
      supportiveServicesRequired:[null],
      passportRecordConfirmation:[null],
      conditionsAndAllergies:[null],
      passportRecordConfirmedDate:[null],
      childEnrolledInFiveDays:[null],
      schoolProximityToPrior:[null],
      placementChangedSchool:[null],
      explainChangeOfSchool:[null],
      discussChildCurrentEducationalSetting:[null],
      educationalServicesReceiving:[null],
      isChildEnrolledInSpecialProgram:[null],
      childCurrentReportCardCopy:[null],
      describeStrengthsAndNeeds:[null],
      eighteenToTwentyOneChildStatus:[null],individualEducationProgram:[null],
      iepDated:[null],
      educationalParentSurrogateName:[null],
      educationalParentSurrogateAddress:[null],
      educationalParentSurrogateRequested:[null],
      atOrNearAgeLevel:[null],
      behavioralProblemsBlockD:[null],
      problemsWithPeersBlockD:[null],
      educationalParentSurrogateStrengths:[null],
      educationalParentSurrogateWeakness:[null],
      behavioralProblemsBlockE:[null],
      problemsWithPeersBlockE:[null],
      schoolSchedule:[null],
      schoolAdjustmentComments:[null],
      extraCurricularActivities:[null],
      educationProgramGoal:[null],
      blockEComments:[null],
    });
  }
  
  /**
   * Editable case plan
   */

  selectVersion(item: any) {
    if (item && (Array.isArray(item.snapshotdata) && item.snapshotdata.length)) {
      this.caseplan2data = item.snapshotdata[0];


      this.currentPlacement();


      this.facetofaceContacDate(item);


      this.parentSSN();
      //Patch the formgroup with the cplanquestion data from the response data already answered

      if(item.snapshotdata[0].cplanquestions!=undefined && item.snapshotdata[0].cplanquestions!=null){
        this.casePlanQuestionsFormGroup.patchValue(item.snapshotdata[0].cplanquestions);
        this.personSelectedQ21();
      }
      if(this.caseplan2data.placementinformation && this.caseplan2data.placementinformation !== undefined && this.caseplan2data.placementinformation !== null) {
        if (Array.isArray(this.caseplan2data.placementinformation)) {
      this.caseplan2data.placementinformation = this.caseplan2data.placementinformation.filter((placement: any) => this.inDateRange(item.fromdate, item.todate, placement));
        }
      }
    }
  }

  currentPlacement() {
    if (this.caseplan2data && this.caseplan2data.placementinformation &&
      this.caseplan2data.placementinformation.length > 0) {
      var activeplacemnt = this.caseplan2data.placementinformation.filter((placement: { enddatetime: any; placementtype: string; }) =>
        !(placement.enddatetime) && (placement.placementtype === 'Living Arrangement'));
      if (activeplacemnt && activeplacemnt.length > 0) {
        this.currentplacemnt = 'Living Arrangement - ' + activeplacemnt[0].livingarrangementtype;
      }
    }
  }
  facetofaceContacDate(item: { fromdate: any; todate: any; }) {
    if (this.caseplan2data && this.caseplan2data['caseworkerservicesandplan'] &&
      this.caseplan2data['caseworkerservicesandplan'].facetofacecontactdate) {
      if (!(Array.isArray(this.caseplan2data['caseworkerservicesandplan'].facetofacecontactdate))) {
        const arr = [];
        arr.push({ contactdate: this.caseplan2data['caseworkerservicesandplan'].facetofacecontactdate })
        this.caseplan2data['caseworkerservicesandplan'].facetofacecontactdate = arr;
      }
      this.caseplan2data['caseworkerservicesandplan'].facetofacecontactdate = _.uniqBy(this.caseplan2data['caseworkerservicesandplan'].facetofacecontactdate, 'insertedon');
      this.caseplan2data['caseworkerservicesandplan'].facetofacecontactdate = this.caseplan2data['caseworkerservicesandplan'].facetofacecontactdate.filter((contact: any) => this.inDateRangeContact(item.fromdate, item.todate, contact));
    }
  }
  
  parentSSN() {
    if (this.caseplan2data && this.caseplan2data['fatherdetails'] && this.caseplan2data['fatherdetails'].ssnvalue) {
      const ssn = this.caseplan2data['fatherdetails'].ssnvalue;
      this.caseplan2data['fatherdetails'].ssnvalue = '***-**-' + ssn.substr(ssn.length - 4);
    }
    if (this.caseplan2data && this.caseplan2data['motherdetails'] && this.caseplan2data['motherdetails'].ssnvalue) {
      const ssn = this.caseplan2data['motherdetails'].ssnvalue;
      this.caseplan2data['motherdetails'].ssnvalue = '***-**-' + ssn.substr(ssn.length - 4);
    }
  }

  inDateRangeContact(fromDate: any, toDate: any, contact: any) {
    if (!toDate) {
      toDate = new Date();
    }
    return (new Date(contact.insertedon) >= new Date(fromDate) && new Date(contact.insertedon) <= new Date(toDate));
  }

  inDateRange(fromDate: any, toDate: any, placement: any) {
    if (!toDate) {
      toDate = new Date();
    }
    let enddatetime = placement.enddatetime;
    if (!enddatetime) {
      enddatetime = new Date();
      if (enddatetime < new Date(fromDate)) {
        enddatetime = new Date(fromDate);
      }
    }
    return (new Date(placement.startdatetime) >= new Date(fromDate) && new Date(placement.startdatetime) <= new Date(toDate)) ||
    (new Date(fromDate) >= new Date(placement.startdatetime) && new Date(fromDate) <= new Date(enddatetime));
  }

  preparePDFrequest(){
    const item = this.selectedVersion;
    const cplan2data =  (Array.isArray(item.snapshotdata) && item.snapshotdata.length) ? item.snapshotdata[0] : item.snapshotdata;
    cplan2data['serviceLogs'] = this.serviceLogs;
    const inputRequest = {
      'caseplan2data': cplan2data,
      'isheaderrequired': false,
    };
    const payload = {
      method: 'post',
      count: -1,
      page: 1,
      limit: 20,
      where: inputRequest,
      documntkey: ['oohome']};
    this._dataStoreService.setData('SELECTED_CASEPLAN2_PAYLOAD', payload);
    return payload;
  }
  personSelectedQ21() {
    this.serviceLogs = [];
    const cpquestions = this.casePlanQuestionsFormGroup.getRawValue();
    if(this.personsList && this.personsList.length > 0
      && cpquestions && cpquestions.servicesForPermanencyClients && cpquestions.servicesForPermanencyClients.length > 0){
        cpquestions.servicesForPermanencyClients.forEach((cjamspid: any) => {
          const person = this.personsList.find(p=> p.cjamspid == cjamspid);
          if(person){
            this.serviceLogs.push({
              fullname: person.fullname,
              cjamspid: person.cjamspid,
              personid: person.personid
            });
            this.getServiceLogs(cjamspid);
          }
        });
      }
  }
  getServiceLogs(cjamspid: any) {
    this._casePlanService.getVendorLog(cjamspid)
      .subscribe((res: any) => {
        const logItem = this.serviceLogs.find(log => log.cjamspid == cjamspid);
        let refList = res['servicelogData'] && res['servicelogData'].length>0 ? res['servicelogData'] : null;
        if(refList) {refList = refList.filter((item: { actual_start_date: any; }) => this._casePlanService.inRange(item.actual_start_date,this.selectedVersion));}
        logItem['referredServiceList'] = refList;
      });
    this._casePlanService.getAgencyLog(cjamspid)
      .subscribe((res: any) => {
      const logItem = this.serviceLogs.find(log => log.cjamspid == cjamspid);
      let agencyList = res['servicelogData'] && res['servicelogData'].length>0 ? res['servicelogData'] : null;
      if(agencyList) {agencyList = agencyList.filter((item: { actual_begin_date: any; }) => this._casePlanService.inRange(item.actual_begin_date,this.selectedVersion));}
      logItem['agencyServiceList'] = agencyList;
    });
  }

  toggleAll() {
    this.expandAll = true;
    const panels = document.querySelectorAll('.panel-collapse');
    panels.forEach((el) => el.classList.add('show'));
  }

  toggleAll1() {
    this.expandAll = false;
    const panels = document.querySelectorAll('.panel-collapse');
    panels.forEach((el) => el.classList.remove('show'));
  }

  getPatchDataPayload() {
    const data = []
    this.caseplan2data['cplanquestions'] = this.casePlanQuestionsFormGroup.getRawValue();
    data[0] = this.caseplan2data;
    return data;
  }

   // Save as draft and update once the assessment record is created
   saveSnapshotData(item: any, isAutoSave?: any) {
    const payload: any = {};
    payload['id'] = this.selectedVersion.id;
    payload['snapshotdata'] = this.getPatchDataPayload();
    payload['updatedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    payload['insertedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    this._commonHttpService.patch(
      this.selectedVersion.id,
      payload,
      'snapshothist'
    ).subscribe((response) => {
        this.currentCasePlan = this.casePlanQuestionsFormGroup.getRawValue();
        if(!isAutoSave){
        this.isCasePlanAutoSaveFlag = false;
        this._alertservice.success('Data saved successfully');
        } else{
        this.lastUpdatedTime = moment().format('MMM Do YY, h:mm:ss a');
        this.isCasePlanAutoSaveFlag = true;
        this._alertservice.success('Data auto saved successfully. Please click \'SAVE ENTERED DATA\' to complete.'); 
        }
      },
      error => {
        this._alertservice.error('Error in saving data');
      }
    );
  }

  closePopover(element: any) {
    element.hide();
  }

}