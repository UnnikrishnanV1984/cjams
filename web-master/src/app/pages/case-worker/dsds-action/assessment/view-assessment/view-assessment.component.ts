import { Component, OnInit, ChangeDetectorRef, Injector, OnChanges, Type } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService, CommonHttpService, AlertService, DataStoreService, CommonDropdownsService } from '../../../../../@core/services';
import { HttpService } from '../../../../../@core/services/http.service';
import { InvolvedPerson, YouthInvolvedPersons } from '../../involved-persons/_entities/involvedperson.data.model';
import { RoutingInfo } from '../../../_entities/caseworker.data.model';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import moment from 'moment';

@Component({
    selector: 'view-assessment',
    templateUrl: './view-assessment.component.html',
    styleUrls: ['./view-assessment.component.scss'],
    standalone: false
})
export class ViewAssessmentComponent implements OnInit {

  id: string;
  serviceCaseId!: string;
  daNumber: string;
  involvedPersons!: InvolvedPerson[];
  youthInvolvedPersons!: YouthInvolvedPersons[];
  routingInfo!: RoutingInfo[];
  routingSupervisors: any[] = [];
  private token!: AppUser;
  selectedAssessmentName!: string;
  selectedAssessment: any;
  openComponent: Type<any> | null = null;
  dtformat = 'MM/DD/YYYY';
  dttimeformat = 'MM/DD/YYYY hh:mm a';
  private readonly route: ActivatedRoute;
  private readonly _authService: AuthService;
  private readonly _commonHttpService: CommonHttpService;
  private readonly _alertService: AlertService;

  constructor(
    private readonly _httpService: HttpService,
    private readonly _router: Router,
    private readonly _dataStoreService: DataStoreService,
    private readonly _changeDetect: ChangeDetectorRef,
    private readonly _commonDDService: CommonDropdownsService,
    private readonly injector : Injector
  ) {
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);

    this.id = this._commonDDService.getStoredCaseUuid();
    this.daNumber = this._commonDDService.getStoredCaseNumber();
  }

  async ngOnInit() {
    this.token = this._authService.getCurrentUser();

    this.involvedPersons = this._dataStoreService.getData('CASEWORKER_INVOLVED_PERSON');
    this.routingInfo = this._dataStoreService.getData('CASEWORKER_ROUTING_INFO') ? this._dataStoreService.getData('CASEWORKER_ROUTING_INFO') : [];
    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS') ? this._dataStoreService.getData('CASEWORKER_SUPERVISORS') : [];

    this.selectedAssessmentName = this._dataStoreService.getData('SELECTED_ASSESSMENT_NAME');
    this.selectedAssessment = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
    if (this.selectedAssessmentName) {
      this.loadComponent(this.selectedAssessmentName);
    }

  }

  async loadComponent(name: string) {
    this.openComponent = null;
    switch (name) {
      case 'AOD Form':
        this.openComponent = (await import('../assessment-aod/assessment-aod.component')).AssessmentAodComponent;
        break;

      case 'PADS Form':
        this.openComponent = (await import('../assessment-pads/assessment-pads.component')).AssessmentPadsComponent;
        break;
      
      case 'cans-v2':
      case 'CANS-F':
        this.openComponent = (await import('../assessment-cans-f/assessment-cans-f.component')).AssessmentCansFComponent;
        break;

      case 'MFIRA':
        this.openComponent = (await import('../assessment-mfira/assessment-mfira.component')).AssessmentMfiraComponent;
        break;
      
      case 'CANS-OUT OF HOME PLACEMENT SERVICE':
        this.openComponent = (await import('../assessment-cans-out/assessment-cans-out.component')).AssessmentCansOutComponent;
        break;

      case 'SAFE-C':
        this.openComponent = (await import('../assessment-safec/assessment-safec.component')).AssessmentSafecComponent;
        break;

      case 'PLACEMENT REQUEST FORM - ATTACHMENT A':
        this.openComponent = (await import('../assessment-placement-request-form/assessment-placement-request-form.component')).AssessmentPlacementRequestFormComponent;
        break;

      case 'SAFE-C OHP':
        this.openComponent = (await import('../assessment-safec-ohp/assessment-safec-ohp.component')).AssessmentSafecOhpComponent;
        break;

    }
  }

  redirectToAssessment() {
    this._router.navigate(['/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/assessment']);
  }

  printAssessment() {
    const personid = this._dataStoreService.getData("YOUTHID")
    if(personid){

    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: personid }
    }, 'personmedicalcondition/personmedicallist?filter').subscribe(res => {
      const medicationpsychotropic = res ? res.data : [];
    this.getHospitalizationInfo(medicationpsychotropic)
    });
  }else{
    this.getHospitalizationInfo([])
  }
  }

  getHospitalizationInfo(medicationpsychotropic: any) {
    const personid = this._dataStoreService.getData("YOUTHID")
    if(personid){
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: personid}
    }, 'personhospitalization/list?filter').subscribe(res => {
      const hospitalList = res ? res.data : [];
      hospitalList.forEach((hospital) =>{
        hospital.start_Date = (hospital?.start_Date) ? this.getDateFormat(hospital.start_Date) : null;
        hospital.end_Date = (hospital?.end_Date) ? this.getDateFormat(hospital.end_Date) : null;

      })
      const mentalpsychohospitalList = hospitalList.filter(data => (data.hospitalization_type === '32780' || data.hospitalization_type === '8017'))
      this.newPrintAssessment(medicationpsychotropic, hospitalList, mentalpsychohospitalList)
    });
  }else{
    this.newPrintAssessment(medicationpsychotropic, [], [])
  }
  }

  newPrintAssessment(medicationpsychotropic: any, hospitalList: any, mentalpsychohospitalList: any) {

    const inputRequest = {
      //'assessmentdata': this.selectedAssessment.submissiondata,
      //get 'PRINTDATA' from datastore
      'assessmentdata': this._dataStoreService.getData('PRINTDATA'),
      'assessmentdetails': this.selectedAssessment,
      'assessmentname': this.selectedAssessmentName,
      'isheaderrequired': false,
    };

    // Print Option for Safe-C Form changes
    if (['SAFE-C', 'SAFE-C OHP', 'LAP (Lethality Assessment Program)', 'Quick Youth Indicators for Trafficking (QYIT)'].includes(this.selectedAssessmentName)) {
      window.print();
      return
    }

    if(inputRequest.assessmentdata?.youthinformation){
      inputRequest.assessmentdata.youthinformation.Youthdob = this.getDateFormat(inputRequest.assessmentdata.youthinformation.Youthdob);
      inputRequest.assessmentdata.youthinformation.currentplacementdate = this.getDateFormat(inputRequest.assessmentdata.youthinformation.currentplacementdate);
    }

    if(inputRequest.assessmentdata?.placementinfo){
      inputRequest.assessmentdata.placementinfo.dateofrequest = this.getDateFormat(inputRequest.assessmentdata.placementinfo.dateofrequest);
      inputRequest.assessmentdata.placementinfo.dateofplacement = this.getDateFormat(inputRequest.assessmentdata.placementinfo.dateofplacement);
      inputRequest.assessmentdata.placementinfo.ftdmdate = this.getDateFormat(inputRequest.assessmentdata.placementinfo.ftdmdate);
      inputRequest.assessmentdata.placementinfo.lastftdmdate = this.getDateFormat(inputRequest.assessmentdata.placementinfo.lastftdmdate);
    }

    if(inputRequest.assessmentdata?.youtheducation){
      inputRequest.assessmentdata.youtheducation.nextmeetingdate = this.getDateFormat(inputRequest.assessmentdata.youtheducation.nextmeetingdate);
      inputRequest.assessmentdata.youtheducation.upcomingdjs = this.getDateFormat(inputRequest.assessmentdata.youtheducation.upcomingdjs);
      inputRequest.assessmentdata.youtheducation.upcomingdjscom = this.getDateFormat(inputRequest.assessmentdata.youtheducation.upcomingdjscom);
      inputRequest.assessmentdata.youtheducation.upcomingelecmonitoring = this.getDateFormat(inputRequest.assessmentdata.youtheducation.upcomingelecmonitoring);
      inputRequest.assessmentdata.youtheducation.upcominggang = this.getDateFormat(inputRequest.assessmentdata.youtheducation.upcominggang);
    }

    if(inputRequest.assessmentdata?.youthmedical){
      inputRequest.assessmentdata.youthmedical.dentistlastseendt = this.getDateFormat(inputRequest.assessmentdata.youthmedical.dentistlastseendt);
      inputRequest.assessmentdata.youthmedical.therapistlastseendt = this.getDateFormat(inputRequest.assessmentdata.youthmedical.therapistlastseendt);
      inputRequest.assessmentdata.youthmedical.hospitalList = hospitalList;
      inputRequest.assessmentdata.youthmedical.mentalpsychohospitalList = mentalpsychohospitalList;
      inputRequest.assessmentdata.youthmedical.medicationpsychotropic = medicationpsychotropic;
    }

    if(inputRequest.assessmentdata?.youthplacementservice){
      inputRequest.assessmentdata.youthplacementservice.assessmentapprovaldate = this.getDateFormat(inputRequest.assessmentdata.youthplacementservice.assessmentapprovaldate);
      inputRequest.assessmentdata.youthplacementservice.assessmentcompletiondate = this.getDateFormat(inputRequest.assessmentdata.youthplacementservice.assessmentcompletiondate);
      inputRequest.assessmentdata.youthplacementservice.todaysdate = this.getDateFormat(inputRequest.assessmentdata.youthplacementservice.todaysdate);
    }

    if(inputRequest.assessmentdata && inputRequest.assessmentdata.familyHOUSEHOLD && inputRequest.assessmentdata.familyHOUSEHOLD.familyArray) {
      inputRequest.assessmentdata.familyHOUSEHOLD.familyArray.map((element: { dob: any; }) => {
          element.dob = element.dob ? moment(element.dob).format(this.dtformat) : '';
      })
    }

    if(inputRequest.assessmentdata && inputRequest.assessmentdata.familyHOUSEHOLD && inputRequest.assessmentdata.familyHOUSEHOLD.assessmentInitDate) {
      inputRequest.assessmentdata.familyHOUSEHOLD.assessmentInitDate = moment(inputRequest.assessmentdata.familyHOUSEHOLD.assessmentInitDate).format(this.dttimeformat);
    }

    inputRequest.assessmentdata = this.setInputRequest(inputRequest);

    const payload = {
      method: 'post',
      count: -1,
      page: 1,
      limit: 20,
      where: inputRequest,
      documntkey: [ 'oohome' ], //CHANGE THIS , Document template table needs a key
    };
    this._commonHttpService.create(payload, 'admin/assessment/generateassessmentpdf').subscribe(
      response => {
        setTimeout(() => window.open(response.data.documentpath), 2000);
    });
  }

  setInputRequest(inputRequest: any){
    if(inputRequest.assessmentdata && inputRequest.assessmentdata.familyYouth_caregiverArray) {
      inputRequest.assessmentdata.familyYouth_caregiverArray.map((element: { caregiverdob: string; }) => {
          element.caregiverdob = this.getcaregiverdob(element);
      })
    }

    if(inputRequest.assessmentdata && inputRequest.assessmentdata.familyYouth_childArray) {
      inputRequest.assessmentdata.familyYouth_childArray.map((element: { childDob: string; }) => {
          element.childDob = this.getchildDob(element);
      })
    }

    if(inputRequest.assessmentdata && inputRequest.assessmentdata.faceLifeForm && inputRequest.assessmentdata.faceLifeForm.length > 0) {
      inputRequest.assessmentdata.faceLifeForm.map((element: { datearray: any; }) => {
          element.datearray.map((item: { meetingdate: string; }) => {
            item.meetingdate = this.getmeetingdate(item);
          })
      })
    }

    if(inputRequest.assessmentdata && inputRequest.assessmentdata.authorizationApproval) {
      inputRequest.assessmentdata.authorizationApproval.caseworkersigndate = this.getcaseworkersigndate(inputRequest);
      inputRequest.assessmentdata.authorizationApproval.reviewdate = this.getreviewdate(inputRequest);
      inputRequest.assessmentdata.authorizationApproval.supervisorsigndate = this.getsupervisorsigndate(inputRequest);
      inputRequest.assessmentdata.authorizationApproval.assessmentsubmission = this.getassessmentsubmission(inputRequest);
    }

    return inputRequest.assessmentdata;
  }
  getcaregiverdob(element: { caregiverdob: any; }){
    return element.caregiverdob ? moment(element.caregiverdob).format(this.dtformat) : '';
  }
  getchildDob(element: { childDob: any; }){
    return element.childDob ? moment(element.childDob).format(this.dtformat) : '';
  }
  getmeetingdate(item: { meetingdate: any; }){
    return item.meetingdate ? moment(item.meetingdate).format(this.dtformat) : '';
  }
  getDateFormat(date: any){
    return date? moment(date).format(this.dtformat) : '';
  }
  getcaseworkersigndate(inputRequest: any){
    return inputRequest.assessmentdata.authorizationApproval.caseworkersigndate ? moment(inputRequest.assessmentdata.authorizationApproval.caseworkersigndate).format(this.dtformat) : '';
  }
  getreviewdate(inputRequest: any){
    return inputRequest.assessmentdata.authorizationApproval.reviewdate ? moment(inputRequest.assessmentdata.authorizationApproval.reviewdate).format(this.dttimeformat) : '';
  }
  getsupervisorsigndate(inputRequest: any){
    return inputRequest.assessmentdata.authorizationApproval.supervisorsigndate ? moment(inputRequest.assessmentdata.authorizationApproval.supervisorsigndate).format(this.dtformat) : '';
  }
  getassessmentsubmission(inputRequest: any){
    return inputRequest.assessmentdata.authorizationApproval.assessmentsubmission ? moment(inputRequest.assessmentdata.authorizationApproval.assessmentsubmission).format(this.dttimeformat) : '';
  }

  // ngOnDestroy() {
  //   window.location.reload();
  // }
}
