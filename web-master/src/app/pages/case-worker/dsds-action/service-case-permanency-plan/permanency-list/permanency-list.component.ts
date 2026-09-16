import { Component, OnInit, Injector } from '@angular/core';
import { ServiceCasePermanencyPlanService } from '../service-case-permanency-plan.service';
import { Router, ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { AuthService, AlertService, DataStoreService, CommonHttpService, SessionStorageService } from '../../../../../@core/services';
import { AppConstants } from '../../../../../@core/common/constants';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { FormGroup, FormBuilder } from '@angular/forms';
import { PaginationInfo } from '../../../../../@core/entities/common.entities';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import moment from 'moment';
import _ from 'lodash';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'permanency-list',
    templateUrl: './permanency-list.component.html',
    styleUrls: ['./permanency-list.component.scss'],
    standalone: false
})
export class PermanencyListComponent implements OnInit {
  
  placementList = [];
  selectedPlan: any;
  selectedPlanid!: string | null;
  isCaseWorker = false;
  isViewQues = false;
  isSuperVisor = false;
  isCompleted = false;
  selectedPlanforReview: any;
  permanencyPlanQuestionnaireForm!: FormGroup;
  isInClosedProximity: any;
  isInClosedProximityExpln: any;
  meetingSafetyNeedsExpln: any;
  sixMonthsPlacementExpln: any;
  courtOrdersExpln: any;
  permToPermExpln: any;
  safeAndCareExpln: any;
  assessmentPeriodExpln: any;
  lifebookExpln: any;
  serviceAgreementExpln: any;
  isProviderAgree: any;
  permanencyplanremainssame: any;
  permanencyplanremainssamedate: any;
  isProviderAgreeExpln!: string;
  serviceAgreementForOtherExpln!: string;
  isReviewPlan!: boolean;
  permanencyPlanList!: any[];
  permanencyPlan: any;
  public updatePermanency$ = new Subject<any>();
  planHistory: any;
  planHistoryDetails: any;
  historyTotalRecords: any;
  historyPaginationInfo: PaginationInfo = new PaginationInfo();
  historyRequest: any;
  fromDate: any;
  toDate: any;
  worker: any;
  caseworkerList: any;
  updatedby: any;
  permanancyPlanDueList: any;

  maxDate: Date = new Date();
  toMinDate: Date | null = null;
  isClosed = false;
  isReadonly = true;
  moduleview: any;
  isEditDiabled = false;
  enablePlanReviewDate=false;
  historyReviewList!: any[];
  activeremoval: any;
  serviceCaseId: any;
  dtformat = 'MM/DD/YYYY';
  historyreviewpopupid = '#history-list-review';
  reviewplanpopupid = '#review-plan';
  showHistoryDetail: number | null = null;

  private _serviceCasePermanencyPlanService: ServiceCasePermanencyPlanService;
  private router: Router;
  private route: ActivatedRoute;
  private _authService: AuthService;
  private _alert: AlertService;
  private _router: Router;
  private formBuilder: FormBuilder;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private storage: SessionStorageService;
  constructor(private injector : Injector) {
    this._serviceCasePermanencyPlanService = this.injector.get<ServiceCasePermanencyPlanService>(ServiceCasePermanencyPlanService);
    this.router = this.injector.get<Router>(Router);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._alert = this.injector.get<AlertService>(AlertService);
    this._router = this.injector.get<Router>(Router);
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
  }

  ngOnInit() {
    this.isEditDiabled = this._authService.isDisabled('permanencyplan','permanencyplan.permanencyplanlist.edit');
    this.selectedPlanid = null;
    this.readOnlyAccess();
    this.getAssignmentsList();
    this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
    this.isSuperVisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
    this._serviceCasePermanencyPlanService.getChildRemovalInfoAndPlacements();
    this.permanencyPlanList = this._serviceCasePermanencyPlanService.permanencyPlanList;
    this.permanancyPlanDueList = [];
    if (this.permanencyPlanList && this.permanencyPlanList.length) {
      this. setPermanancyPlanDueList();
      this.checkpermanencyPlanList();
      if (this.permanancyPlanDueList && this.permanancyPlanDueList.length && !this.isSuperVisor) {
        (<any>$('#permanancy-plan-alert')).modal('show');
      }
    }

    if (this.permanencyPlanList) {
      this.permanencyPlan = this.permanencyPlanList[0];
    }

    this.forminit();
    this._serviceCasePermanencyPlanService.refresh$.subscribe(() => {
      this.permanencyPlanList = this._serviceCasePermanencyPlanService.permanencyPlanList;
    });
    this.permanencyPlanList.forEach(res => {
      res.fullname =  res.firstname + ' ' + res.middlename + ' ' + res.lastname + ' ' ;
    });
    this._serviceCasePermanencyPlanService.placementApprovalQueue$.subscribe(data => {
      this._alert.success(data);
      this.goBack();
    });
    const da_status = this.storage.getItem('da_status');
    this.isClosed = da_status && (da_status === 'Closed' || da_status === 'Completed');
    this.permanencyPlanQuestionnaireForm.controls.permanencyplanremainssame.disable();
    this.permanencyPlanQuestionnaireForm.controls.permanencyplanremainssamedate.disable();
    this.route.queryParams.subscribe(params => {
      if (params['origin'] === 'ytp') {
      const child = this.permanencyPlanList.filter(e => e.personid === params['personid'])
      const matchingPlan = this.permanencyPlanList
            .map(e => e.permanencyplans || [])
            .reduce((acc, curr) => acc.concat(curr), []) 
            .find((plan :any) => plan.permanencyplanid === params['permanencyplanid']);
    
      if (matchingPlan) {
        this.viewPermanency(matchingPlan, child, true);
        this.setPermanencyplanid(matchingPlan, 'view')
      }
    }  
    });
  }

  private readOnlyAccess(){
    const activeModuleRole = this.storage.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
      this.isReadonly = this._authService.readonlyButton('read_only_access', 'readonly-permplan');
    }
  }

  setPermanancyPlanDueList() {
    this.permanencyPlanList.forEach(child => {
      if (child.permanencyplans && child.permanencyplans.length) {
        child.permanencyplans = _.sortBy(child.permanencyplans, 'enddate').reverse();
        let notReviewed = false;
        child.permanencyplans.forEach((plan: any) => {
          let days = 0;
          if (plan.establisheddate) {
            days = this.diffbetweenDays(new Date(plan.establisheddate), new Date());
            plan.establisheddate = this.formatDate(plan.establisheddate);
          }
          if (plan.enddate) {
            plan.enddate = this.formatDate(plan.enddate);
          }
          if (plan.status === 'Review' && days > 180) {
            notReviewed = true;
          }
        });
        if (notReviewed) {
          this.permanancyPlanDueList.push(child.clientname);
        }
      }
    });
  }

  checkpermanencyPlanList() {
    for (let i = 0; i < this.permanencyPlanList.length; i++) {
      this.setActiveRemoval(i);
      for (let j = 0; j < this.permanencyPlanList[i]?.permanencyplans.length; j++) {
        let mainDate = this.getMainDate(i, j);
        const exitDate = this.permanencyPlanList[i]?.removalList[0]?.exitdate;
        let establisheddate = this.permanencyPlanList[i]?.permanencyplans[j]?.establisheddate;
        mainDate = new Date(Date.parse(mainDate));
        establisheddate = new Date(Date.parse(establisheddate));
        mainDate = this.setMainDate(mainDate, establisheddate, i, j);
        const formattedDate: any = moment().format(this.dtformat);
        const currentDate: any = moment(formattedDate, this.dtformat, true);
        const main_Date: any = moment(mainDate, this.dtformat, true);
        const mainDatCheck: any = main_Date;
        const duration = moment.duration(currentDate.diff(main_Date)).asDays();
        if (mainDatCheck._i !== 'Invalid date' && main_Date.isValid()) {
          this.permanencyPlanList[i].permanencyplans[j].planreviewdate = main_Date;
        } else {
          this.permanencyPlanList[i].permanencyplans[j].planreviewdate = null;
        }
        this.permanencyPlanList[i].permanencyplans[j].duration = duration.toFixed(0);
        this.permanencyPlanList[i].permanencyplans[j].exitDate = exitDate;
      }
    }
  }

  getMainDate(i: any, j: any){
    const removalDate = this.activeremoval?.removaldate ? this.activeremoval?.removaldate : '';
    const reviewdate = this.permanencyPlanList[i]?.permanencyplans[j]?.reviewdate;
    return reviewdate === null ? removalDate : reviewdate;
  }

  setMainDate(mainDate: any, establisheddate: any, i: any, j: any){
    if (this.permanencyPlanList[i].permanencyplans[j].status !== 'Rejected') {
      if (mainDate >= establisheddate) { mainDate.setDate(mainDate.getDate() + 180) }
      else {
        while (mainDate <= establisheddate) {
          mainDate.setDate(mainDate.getDate() + 180)
          if (mainDate > establisheddate) {
            break;
          }
        }
      }
    }
    return mainDate;
  }

  setActiveRemoval(i: any) {
    const activeremoval = this.permanencyPlanList[i].removalList;
    activeremoval.forEach((element: any) => {
      if (element.exitdate === null) {
        this.activeremoval = element;
      }
    });
  }

  formatDate(inputDate: any){
    return inputDate ? moment(inputDate).format(this.dtformat) : inputDate;
  }

  diffbetweenDays(date1: any, date2: any) {

    const diffc = date2.getTime() - date1.getTime();
    return Math.round(Math.abs(diffc / (1000 * 60 * 60 * 24)));
  }
   getAssignmentsList() {
    const userid = this._authService.getCurrentUser()?.user?.securityusersid;
    this.serviceCaseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this._commonHttpService.getArrayList(
        {
            where: { servicecaseid: this.serviceCaseId  },
            method: 'get'
        },
        'Caseassignments/getworkload?filter'
    ).subscribe(data => {
        if (data) {
          const cw =data.some(ele=>ele?.toworkerdetails && (ele?.toworkerdetails[0]?.securityusersid == userid &&ele?.enddate==null));
          const supervisor =data.some(ele=> ele?.enddate==null && 
            ele?.tosecurityusersdata.some((sup: { securityusersid: string; })=>sup.securityusersid == userid));           
        if(supervisor||cw){
        this.enablePlanReviewDate = true;
        }
      }
    });
}
  viewQuesData(plan: any) {
    if (plan && plan.permplanquestdata && plan.permanencyplanid) {
      this.isViewQues = true;
      this.selectedPlanid = plan.permanencyplanid;
      this.permanencyPlanQuestionnaireForm.patchValue(plan.permplanquestdata);
      this.permanencyPlanQuestionnaireForm.disable();
    }
  }


  resetQuestForm() {
    this.selectedPlanid = null;
    this.isViewQues = false;
    this.permanencyPlanQuestionnaireForm.reset();
    this.permanencyPlanQuestionnaireForm.enable();
    this.permanencyPlanQuestionnaireForm.controls.permanencyplanremainssame.disable();
    this.permanencyPlanQuestionnaireForm.controls.permanencyplanremainssamedate.disable();
  }

  forminit() {
    this.permanencyPlanQuestionnaireForm = this.formBuilder.group({
      isInClosedProximity: [null],
      isInClosedProximityExpln: [null],
      meetingSafetyNeedsExpln: [null],
      sixMonthsPlacementExpln: [null],
      courtOrdersExpln: [null],
      permToPermExpln: [null],
      safeAndCareExpln: [null],
      assessmentPeriodExpln: [null],
      lifebookExpln: [null],
      serviceAgreementExpln: [null],
      isProviderAgree: [null],
      isProviderAgreeExpln: [null],
      serviceAgreementForOtherExpln: [null],
      permanencyplanremainssame: [null],
      permanencyplanremainssamedate: [null],
    });
  }


  addPermanency() {

    if (this._authService.hasSupervisor()) {
      this._serviceCasePermanencyPlanService.setViewMode(false);
      if (this._serviceCasePermanencyPlanService.selectedChildren && this._serviceCasePermanencyPlanService.selectedChildren.length) {
        const childList = this._serviceCasePermanencyPlanService.selectedChildren.map((child: { personid: any; }) => child.personid);
        const plan = this.permanencyPlanList.filter(item => childList.includes(item.personid));
        const hasActiveCase = this.getHasActiveCase(plan);
        const hasActivePlan = this.getHasActivePlan(plan);
        if (hasActiveCase) {
          (<any>$('#active-case-exist')).modal('show');
        } else if (hasActivePlan) {
          (<any>$('#active-permenency-plan-exist')).modal('show');
        } else {
          this._serviceCasePermanencyPlanService.toggleFormAction('Add');
          this.router.navigate(['form'], { relativeTo: this.route });
        }
      } else {
        this._alert.warn('Please Select Child');
      }
      this.storage.setObj('planreviewdateFrHistory', '');
    }
  }

  getHasActiveCase(plan: any) {
    return plan.some((item: any) => {
      const permanencyPlan = (Array.isArray(item.permanencyplans)) ? item.permanencyplans : [];
      return permanencyPlan.some((pp: { casedetails: any; }) => {
        const casedetails = Array.isArray(pp.casedetails) ? pp.casedetails : [];
        return casedetails.some(ele => ele.adoptioncase_status === 1);
      });
    });
  }

  getHasActivePlan(plan: any){
    return plan.some((item: any) => {
      const permanencyPlan = (Array.isArray(item.permanencyplans)) ? item.permanencyplans : [];
      return permanencyPlan.some((pp: any) => {
        let activePlan = true;
        const primaryPermanencyPlan = (Array.isArray(pp.primarypermanency)) ? pp.primarypermanency[0] : null;
        if (primaryPermanencyPlan) {
          if ('Reunification' === primaryPermanencyPlan.permanencyplantypekey) {
            activePlan = false;
          }
        }
        return ((activePlan && pp.enddate === null) || (pp.enddate !== null && pp.status !== 'Approved' && pp.status !== 'Rejected')); // if there is not enddate and not reunification, consider this as active.
      });
    });
  }

  editPermanency(plan: any, child: any, isView: any) {
      (<any>$(this.historyreviewpopupid)).modal('hide');
      this._serviceCasePermanencyPlanService.toggleFormAction('Edit', plan);
      child.permanencyplans = [];
      child.permanencyplans.push(plan);
      this._serviceCasePermanencyPlanService.setViewMode(isView);
      this._serviceCasePermanencyPlanService.setSelectedChild(child);
      setTimeout(() => {
        this.router.navigate(['form'], { relativeTo: this.route });
      }, 200);
  }

  viewPermanency(plan: any, child: any, isView: any) {
    (<any>$(this.historyreviewpopupid)).modal('hide');
    this._serviceCasePermanencyPlanService.toggleFormAction('View', plan);
    child.permanencyplans = [];
    child.permanencyplans.push(plan);
    this._serviceCasePermanencyPlanService.setViewMode(isView);
    this._serviceCasePermanencyPlanService.setSelectedChild(child);
    setTimeout(() => {
      this.router.navigate(['form'], { relativeTo: this.route });
    }, 200);
}

  planReview(plan: any, child: any, isView: any) {
    this._serviceCasePermanencyPlanService.toggleFormAction('Review', plan);
    child.permanencyplans = [];
    child.permanencyplans.push(plan);
    this._serviceCasePermanencyPlanService.setViewMode(isView);
    this._serviceCasePermanencyPlanService.setSelectedChild(child);
    setTimeout(() => {
      this.router.navigate(['form'], { relativeTo: this.route });
    }, 200);
}

exitView(plan: any, child: any, isView: any) {
  this._serviceCasePermanencyPlanService.toggleFormAction('Exit', plan);
  child.permanencyplans = [];
  child.permanencyplans.push(plan);
  this._serviceCasePermanencyPlanService.setViewMode(isView);
  this._serviceCasePermanencyPlanService.setSelectedChild(child);
  setTimeout(() => {
    this.router.navigate(['form'], { relativeTo: this.route });
  }, 200);
}

auditlog(plan: any, child: any, isView: any) {
  (<any>$(this.historyreviewpopupid)).modal('hide');
  child.permanencyplans = [];
  this._serviceCasePermanencyPlanService.toggleFormAction('AuditLog', plan);
  child.permanencyplans.push(plan);
  this._serviceCasePermanencyPlanService.setViewMode(isView);
  this._serviceCasePermanencyPlanService.setSelectedChild(child);
  setTimeout(() => {
    this.router.navigate(['form'], { relativeTo: this.route });
  }, 200);
}

  savePermanencyPlanQuestionnaire() {
    if (this.permanencyPlanList) {
      if (this.permanencyPlanList[0].permanencyplans) {
        this.permanencyPlan = this.permanencyPlanList[0].permanencyplans[0];
        const permanencyPlanData = this.permanencyPlanQuestionnaireForm.getRawValue();
        this.permanencyPlan.permplanquestdata = JSON.stringify(permanencyPlanData);
        this._serviceCasePermanencyPlanService.saveOrUpdatePermanencyPlan(this.permanencyPlan);
      }
    }
  }

  viewPlan(plan: any) {
    this.selectedPlan = plan;
    (<any>$('#viewPlan')).modal('show');
  }

  isPlanSubmitted(planData: any) {
    if (planData && planData.permanencyplans && planData.permanencyplans.length) {
      const plans = planData.permanencyplans.filter((item: any) => {
        if (item.status === 'Review' || item.status === 'Approved') {
          return item;
        }
      });
      return (plans && plans.length) ? plans.length : 0;
    }
    return false;
  }

  isReUnification(plan: any) {
    if (plan.primarypermanency && plan.primarypermanency.length > 0) {
      const primary = plan.primarypermanency[0];
      if (primary.permanencyplantypekey === 'Reunification') { 
        return this.checkConcurrentplantype(plan);
      } else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  checkConcurrentplantype(plan: any){
    const primary = plan.primarypermanency[0];
    const concurrent = plan.concurrentpermanency?plan.concurrentpermanency[0]:null;
    const concurrentplantype = concurrent?concurrent.concurrentplantypekey:null;
    if (concurrentplantype === 'Guardianship' || concurrentplantype === 'GUARDR') { 
      if(primary.gapstatuscheck === null) {
        return true;
      }
      return false;
    } else if (concurrentplantype === 'ADOPTR' || concurrentplantype === 'ADOPTNR' || concurrentplantype === 'Adoption' || concurrentplantype === 'CRLTC' || concurrentplantype === 'APPLA') {
      return false;
    }
    return true;
  }

  isPlanReview(planData: any) {

    if (planData && planData.permanencyplans && planData.permanencyplans.length) {
      const plans = planData.permanencyplans.filter((item: { status: string; }) => item.status === 'Review');
      return (plans && plans.length) ? plans.length : 0;
    }
    return false;
  }

  addChild() {
    if (this.isSuperVisor) {
      this._serviceCasePermanencyPlanService.resetValues();
    }
    this.permanencyPlanList.forEach(data => {
      this.isReviewPlanExists(data);
    });
    if (this._serviceCasePermanencyPlanService.selectedChildren && this._serviceCasePermanencyPlanService.selectedChildren.length) {
      (<any>$(this.reviewplanpopupid)).modal('show');
    }
  }

  reviewPermanency(plan: any, child: any) {
    this.selectedPlanforReview = [];
    this.selectedPlanforReview.push(child);
    this.selectedPlanforReview[0].permanencyplans = [];
    this.selectedPlanforReview[0].permanencyplans.push(plan);
    (<any>$(this.reviewplanpopupid)).modal('show');
  }

  approveorRejectPlacement(status: any) {
    let permanencyPlanId = null;
    if (this.selectedPlanforReview[0] && this.selectedPlanforReview[0].permanencyplans && this.selectedPlanforReview[0].permanencyplans.length) {
      permanencyPlanId = this.selectedPlanforReview[0].permanencyplans[0].permanencyplanid;
      this._serviceCasePermanencyPlanService.approveorRejectPlacement(permanencyPlanId, status);
    }
  }

  checkIfReviewPlanExist() {
    let ifPlanExist = false;
    this.permanencyPlanList.forEach(data => {
      if (data && data.permanencyPlanList && data.permanencyPlanList.length) {
        data.permanencyplans.filter((item: { status: string; }) => {
          if (item.status === 'Review') {
            ifPlanExist = true;
          }
        });
      }
    });
    return ifPlanExist;

  }

  isReviewPlanExists(planData: any) {
    if (planData && planData.permanencyplans && planData.permanencyplans.length) {
      const plans = planData.permanencyplans.filter((item: { status: string; }) => item.status === 'Review');
      if (plans && plans.length && this.isSuperVisor) {
        this._serviceCasePermanencyPlanService.selectChild(planData, true);
      }
      return (plans && plans.length) ? plans : null;
    }
    return null;
  }



  goBack() {
    this.resetQuestForm();
    this._serviceCasePermanencyPlanService.getChildRemovalInfoAndPlacements().subscribe(response => {
      this._serviceCasePermanencyPlanService.broadCastPageRefresh();
      (<any>$(this.reviewplanpopupid)).modal('hide');
      
    });
  }

  approveorReject(selectedPlan: any, action: any) {
    if (selectedPlan && selectedPlan.permanencyplanid) {
      this._serviceCasePermanencyPlanService.approveOrRejectPlacement(selectedPlan.permanencyplanid, action);
    }
  }

  approve() {
    this.resetQuestForm();
    this._serviceCasePermanencyPlanService.startPlacementApprovalInQueue();
  }

  reject() {
    this.resetQuestForm();
    this._serviceCasePermanencyPlanService.startPlacementRejectionInQueue();
  }

  routeToPlan(plan: any, child: any) {
    (<any>$(this.historyreviewpopupid)).modal('hide');
      this._dataStoreService.setData('placed_child', child);
      this.storage.setObj('placed_child', child);
      this._dataStoreService.setData('adoptionAgreement', null);
      this._dataStoreService.setData('permanencyplanid_details', plan.permanencyplanid);
      this._dataStoreService.setData('adoptionEffort', null);
      this._dataStoreService.setData('TPR_LIST', null);
      this._dataStoreService.setData('TPR_RECOMENDATION_LIST', null);
      this._dataStoreService.setData(CASE_STORE_CONSTANTS.ADOPTION_PERMANENCYPLANID, null);
    
    if (plan && plan.casedetails && plan.casedetails.length && plan.casedetails[0] && plan.casedetails[0].adoptioncasenumber){
      this._dataStoreService.setData('adoption_case_created', true);
    }else{
      this._dataStoreService.setData('adoption_case_created', false);
    }
    if (child.permanencyplans.length > 0) {
      this._dataStoreService.setData('placement_child', plan);
      this.storage.setObj('placement_child', plan);
    }

    const selectedPlacedChild = this._serviceCasePermanencyPlanService.selectedPlacedChild(child.cjamspid);
    if (selectedPlacedChild && selectedPlacedChild.length && selectedPlacedChild[0]['placements'] && selectedPlacedChild[0]['placements'].length) {
      const placedChild = selectedPlacedChild[0]['placements'];

      placedChild.forEach((placement: any) => {
        if (placement.placementtypekey && placement.placementtypekey !== 'LA' && !placement.enddate && placement.isvoided !== 1 && placement.routingstatus !== 'Rejected') {
          placement.permanencyplanid = plan.permanencyplanid;
          this._dataStoreService.setData(CASE_STORE_CONSTANTS.PLACEMENT_CHILD, placement);
          this.storage.setObj('placement_child', placement);
        }
      });


    }
    this._dataStoreService.setData('childforGAP', child.cjamspid);
    this.permanencyPlanRouting(plan);
  }

  permanencyPlanRouting(plan: any) {
    if (plan.primarypermanency && plan.primarypermanency.length > 0) {
      const primary = plan.primarypermanency[0];
      let permanencyplantype = primary.permanencyplantypekey;
      if(permanencyplantype === 'Reunification'){
        const concurrent = plan.concurrentpermanency?plan.concurrentpermanency[0]:null;
        if(concurrent && concurrent.concurrentplantypekey){
          permanencyplantype = concurrent.concurrentplantypekey;
        }
      }
      this.routeToUrl(plan, permanencyplantype);
    }
  }

  routeToUrl(plan: any, permanencyplantype: any) {
    let url = '';
    if (permanencyplantype === 'Guardianship' || permanencyplantype === 'GUARDR') { // Garudian non relative or Garudian by relative
      this._dataStoreService.setData(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, plan.permanencyplanid);
      url = 'placement/placement-gap/application';
    } else if (permanencyplantype === 'ADOPTR' || permanencyplantype === 'ADOPTNR' || permanencyplantype === 'Adoption') {
      this._dataStoreService.setData(CASE_STORE_CONSTANTS.ADOPTION_PERMANENCYPLANID, plan.permanencyplanid);
      url = 'placement/adoption/tpr-recom';
    } else if (permanencyplantype === 'CRLTC' || permanencyplantype === 'APPLA') {
      url = 'placement/appla/list';
    }
    if (url !== '') {
      this._router.navigate([url], { relativeTo: this.route });
    }
  }



  showHistory(child: any) {
    this.getCaseWorkerList();
    (<any>$('#history-list')).modal('show');
    this.historyRequest = {
      'intakeservicerequestactorid': child.intakeservicerequestactorid,
      'personid': child.personid,
      'sortcol': this.historyPaginationInfo.sortColumn,
      'sortby': this.historyPaginationInfo.sortBy,
      'updatedfrom': this.fromDate,
      'updatedto': this.toDate,
      'updatedby': this.worker
    };

    this.loadHistory(1);
  }

  showHistoryReview(child: any) {
    this.getCaseWorkerList();
    (<any>$(this.historyreviewpopupid)).modal('show');
    this.historyRequest = {
      'intakeservicerequestactorid': child.intakeservicerequestactorid,
      'personid': child.personid,
      'sortcol': this.historyPaginationInfo.sortColumn,
      'sortby': this.historyPaginationInfo.sortBy,
      'updatedfrom': this.fromDate,
      'updatedto': this.toDate,
      'updatedby': this.worker
    };
    this.setHistoryRequestReviewObj(child);
    this.loadHistory(1);
    this.historyReviewList = [];
    if (this.permanencyPlanList) {
      this.historyReviewList = this.permanencyPlanList.filter((item: any) => (item.personid === child.personid));
    }
  }

  setHistoryRequestReviewObj(child: any){
    this.historyRequest = {
      'intakeservicerequestactorid': child.intakeservicerequestactorid,
      'personid': child.personid,
      'sortcol': this.historyPaginationInfo.sortColumn,
      'sortby': this.historyPaginationInfo.sortBy,
      'updatedfrom': this.fromDate,
      'updatedto': this.toDate,
      'updatedby': this.worker
    };
    this.storage.setObj('historyRequestReview', this.historyRequest);
  }

  loadHistory(pageNumber: any) {
    this.historyRequest.updatedfrom = this.fromDate;
    this.historyRequest.updatedto = this.toDate;
    this.historyRequest.updatedby = this.updatedby;
    this.historyRequest.sortby = this.historyPaginationInfo.sortBy;
    this.historyRequest.sortcol = this.historyPaginationInfo.sortColumn;

    this._serviceCasePermanencyPlanService.getPermanencyPlanHistory(pageNumber, this.historyRequest).subscribe(result => {
      if (result.data && result.data.length) {
        this.historyTotalRecords = result.count;
        this.planHistory = result.data;
      } else {
        this.historyTotalRecords = 0;
        this.planHistory = [];
      }
    });
  }

  clearSearch() {
    this.fromDate = null;
    this.toDate = null;
    this.updatedby = null;
    this.toMinDate = null;
    this.maxDate = new Date();
    this.loadHistory(1);
  }

  getCaseWorkerList() {
    this._commonHttpService
      .getPagedArrayList(
        {
          where: { appevent: 'ALL' },
          method: 'post'
        },
        'Intakedastagings/getroutingusers'
      ).subscribe(result => {
        this.caseworkerList = result.data;
      });
  }

  historyPageChanged(event: any) {
    this.historyPaginationInfo.pageNumber = event.page;
    this.loadHistory(this.historyPaginationInfo.pageNumber);
  }

  onHistorySorted($event: ColumnSortedEvent) {
    this.historyPaginationInfo.pageNumber = 1;
    this.historyPaginationInfo.sortBy = $event.sortDirection;
    this.historyPaginationInfo.sortColumn = $event.sortColumn;
    this.loadHistory(this.historyPaginationInfo.pageNumber);
  }

  fromDateChanged(fromDate: string) {
    // No content to add or call
  }
  toDateChanged(toDate: string) {
    // No content to add or call
  }
  // showHistoryDetail = false;
  planHistoryById = [];
  searchHistoryWidId(permanencyplanid: any, id: any, index: any) {

    // (<any>$('.collapse.in')).collapse('hide');
    // (<any>$('#' + id)).collapse('toggle');
    // (<any>$('.history-details tr')).removeClass('selected-bg');
    // (<any>$(`#history-details-${index}`)).addClass('selected-bg');
    this.fromDate = null;
    this.toDate = null;
    this.loadHistory(1);

    this._serviceCasePermanencyPlanService.getPermanencyPlanHistoryDetails(permanencyplanid).subscribe(result  => {
      if (result) {
        this.planHistoryDetails = result;
        this.checkPlanHistoryDetails();
      } else {
        this.planHistoryDetails = [];
      }
    });

    this.planHistoryById = this.planHistory.filter((i:any)=>(i.status === permanencyplanid))
    
    if(this.checkAccordionRow(id,'accordion-tables')) {
      if (this.showHistoryDetail === index) {
        this.showHistoryDetail = null;
      } else {
        this.showHistoryDetail = index;
      }
    }
  }

  checkAccordionRow(id: string, value: any): boolean {
    return id.includes(value);
  }

  checkPlanHistoryDetails(){
    const caseworkerid = this.planHistoryDetails.filter((i:any)=>(i.status === 'Review'))
    this.planHistoryDetails.forEach((i: { permanencyplanremainssame: string; caseworkerdetails: any; caseworkerupdated: any; }) => {
      if(i.permanencyplanremainssame) {
          i.permanencyplanremainssame = 'Yes'
      } else if(!i.permanencyplanremainssame) {
          i.permanencyplanremainssame = 'No'
      } else {
          i.permanencyplanremainssame = 'NA'
      }
      if(caseworkerid && caseworkerid.length) {
        i.caseworkerdetails = caseworkerid[0].fullname;
        i.caseworkerupdated = caseworkerid[0].updatedon;
      }
    });
  }


  setPermanencyplanid(item: any, event: any) {
    this.storage.setObj('permanencyplanIdFrHistory', item.permanencyplanid);
    this.storage.setObj('exitDateFrHistory', moment(item.exitDate).format(this.dtformat));
    if (event !== 'edit') {this.storage.setObj('planreviewdateFrHistory', moment(item.planreviewdate).format(this.dtformat));}
    else { this.storage.setObj('planreviewdateFrHistory', ''); }
  }

}
