import { Component, OnInit, Injector } from '@angular/core';
import { ServiceCasePlacementsService } from '../service-case-placements.service';
import { AuthService, AlertService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { AppConstants } from '../../../../../@core/common/constants';
import { Router, ActivatedRoute } from '@angular/router';
import { PlacementConstants } from '../constants';
import { PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { FinanceService } from '../../../../finance/finance.service';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import moment from 'moment';

@Component({
    selector: 'placement-list',
    templateUrl: './placement-list.component.html',
    styleUrls: ['./placement-list.component.scss'],
    standalone: false
})
export class PlacementListComponent implements OnInit {
  id: string;
  daNumber: any;
  da_status: any;
  placementList: any[] = [];
  isCaseWorker = false;
  isSuperVisor = false;
  accountpayableList: any[] = [];
  selectedChild: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  noPlacementsInReview = true;
  ALERT_MESSAGE = 'There is a living arrangement marked alongside a provider placement. Please take action to end the provider placement not later than 30 calendar days.';
  placementHistory: any = [];
  selectedChildPlacementHistory: any;
  placementRevison: any[] = [];
  cpahomerevision: any[] = [];
  exitPlacementvalid!: boolean;
  exitValidationObj: any;
  isClosed = false;
  changeHistory: any[] = [];
  tprCompletedChild: any = {};
  tprCompletedChildList: any[] = [];
  isEditDiabled = false;
  isExitDiabled = false;
  isVoidDiabled = false;
  isAddEnabled: any;
  noApprovedActiveRemoval: boolean = false;
  isReadonly!: boolean;

  dtformat = "YYYY-MM-DD";
  historyplacementpopupid ='#historyPlacement';
  detailspagepath = '../details/';
  bgclssname = 'selected-bg';
  mandatorymsg = 'Please select child/children ';
  
  paymentDetails: any;
  showHistoryDetail: number | null = null;
  showHistoryDetailCpa: number | null = null;

  private _service: ServiceCasePlacementsService;
  public _authService: AuthService;
  private router: Router;
  private route: ActivatedRoute;
  private _alertService: AlertService;
  private _dataStoreService: DataStoreService;
  private storage: SessionStorageService;
  private commonHttpService: CommonHttpService;
  private _financeSerice: FinanceService;

  constructor(private injector: Injector){
    this._service =  this.injector.get<ServiceCasePlacementsService>(ServiceCasePlacementsService);
    this._authService =  this.injector.get<AuthService>(AuthService);
    this.router =  this.injector.get<Router>(Router);
    this.route =  this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._alertService =  this.injector.get<AlertService>(AlertService);
    this._dataStoreService =  this.injector.get<DataStoreService>(DataStoreService);
    this.storage =  this.injector.get<SessionStorageService>(SessionStorageService);
    this.commonHttpService =  this.injector.get<CommonHttpService>(CommonHttpService);
    this._financeSerice =  this.injector.get<FinanceService>(FinanceService);
  
      this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
      this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
      this.da_status = this.storage.getItem('da_status');
    }

  settimein12hr(strtime: any) {
    if (strtime && moment(new Date(strtime), 'HH:mm', true).isValid()) {
      return moment(new Date(strtime), 'HH:mm', true).toDate();
    }
    else if (strtime && moment(strtime, 'HH:mm', true).isValid()) {
      return moment(strtime, 'HH:mm', true).toDate();
    }
    else if (strtime && moment(strtime, 'HH:mm:ss', true).isValid()) {
      return moment(strtime, 'HH:mm:ss', true).toDate();
    }
  }
  ngOnInit() {
    this.isEditDiabled = this._authService.isDisabled('placement','placement.placementlist.edit');
    this.isExitDiabled = this._authService.isDisabled('placement','placement.placementlist.exit');
    this.isVoidDiabled = this._authService.isDisabled('placement','placement.placementlist.viod');
    this.isAddEnabled = this._authService.isEnabled('placement','placement.placementlist.add');
    this.placementList = this._service.childList;
    if (this.placementList && this.placementList.length > 0) {
      this.checkPlacementList();
    }
    this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
    this.isSuperVisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
    const da_status = this.storage.getItem('da_status');
    if (da_status) {
     if (da_status === 'Closed' || da_status === 'Completed') {
         this.isClosed = true;
     } else {
         this.isClosed = false;
     }
    }
    const showexitchecklist = this._dataStoreService.getData('showexitchecklist');
    if (showexitchecklist) {
      this._dataStoreService.setData('showexitchecklist', false);
      const child = this._service.placementDetails;
      const placement = this._service.placementDetails[0].placement;
      this.exitPlacement(child, placement, 0);
    }
    this.checkChildTPR();

    if(this._dataStoreService.getData('editedChildId') !== undefined && this._dataStoreService.getData('editedChildId') !== null && this._dataStoreService.getData('editedPlacementId') !== undefined && this._dataStoreService.getData('editedPlacementId') !== null) {
      
      const childData = this.placementList.filter((item: any) => item.personid === this._dataStoreService.getData('editedChildId'));
      const placement = childData[0].placements.filter((item: { placementid: any; }) => item.placementid === this._dataStoreService.getData('editedPlacementId'));
      this.reviewPlacement(childData[0], placement[0]);
      

    }
    const activeModuleRole = this.storage.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
    this.isReadonly =  this._authService.readonlyButton('read_only_access','caseworker-placement-exit');}
  }

  checkPlacementList() {
    this.placementList.forEach(res => {
      if (res && res.placements && res.placements.length > 0) {
        for (let i = 0; i < res.placements.length; i++) {
          if (res.placements[i].revisionupdate != null && res.placements[i].placementtypekey !== 'LA') {
            res.placements[i].stime = this.getPlacementStartTime1(res, i);
            res.placements[i].startdate = this.getPlacementStartDate(res, i);
          } else {
            res.placements[i].stime = this.getPlacementStartTime2(res, i);
            res.placements[i].etime = this.settimein12hr(this.nullCheck(res.placements[i].endtime));
            res.placements[i].startdate = this.nullCheck(res.placements[i].startdate);
            res.placements[i].enddate = this.nullCheck(res.placements[i].enddate);
          }
          res.active = this.getActiveFlag(res, i);
        }
      }
    });
  }

  getPlacementStartDate(res: any, i: any){
    return (res.placements[i].revisionupdate.entrydate) ? res.placements[i].revisionupdate.entrydate : null;
  }
  getPlacementStartTime1(res: any, i: any){
    return (res.placements[i].revisionupdate.entrytime) ? (this.settimein12hr(res.placements[i].revisionupdate.entrytime)) : null;
  }

  getPlacementStartTime2(res: any, i: any){
    return this.settimein12hr((res.placements[i].starttime) ? res.placements[i].starttime : this.nullCheck(res.placements[i].startdate));
  }

  getActiveFlag(res: any, i: any){
    if (!(res.placements[i].enddate) && res.placements[i].placementtypekey !== 'LA' && res.placements[i].responseacceptedkey !== '4612') {
      return false;
    } else {
      return true;
    }
  }

  nullCheck(inputData: any){
    return inputData ? inputData : null;
  }

  placementHistoryDetail(placement: any) {
    if (placement && placement.placements && placement.placements.length) {
      placement = this.setPlacementTimes(placement);
    }
    this.placementHistory = placement;
    this.selectedChildPlacementHistory = placement;
  }

  setPlacementTimes(placement: any){
    placement.placements.forEach((item: any) => {
      if (item.starttime) {
        if (moment(item.starttime).isValid()) {
          item.startdate = this.getItemStartDate1(item);
        }
        else if (String(item.starttime).includes(':')) {
          item.startdate = this.getItemStartDate2(item);
        }
      }
      if (item.endtime) {
        item.enddate = this.getItemEndDate(item);
      }
    })

    return placement;
  }

  getItemStartDate1(item: any){
    const d = new Date(item.starttime);
    if (item.startdate) {
      const startdatespilt = moment(item.startdate).format(this.dtformat);
      item.startdate = moment(startdatespilt).add(d.getHours() ? d.getHours() : 0, 'h').add(d.getMinutes() ? d.getMinutes() : 0, 'm').toDate();
    } else {
      const startdatespilt = moment(item.starttime).format(this.dtformat);
      item.startdate = moment(startdatespilt).add(d.getHours() ? d.getHours() : 0, 'h').add(d.getMinutes() ? d.getMinutes() : 0, 'm').toDate();
    }

    return item.startdate;
  }

  getItemStartDate2(item: any) {
    const timeSplit = item.starttime.split(':');
    if (item.startdate) {
      const startdatespilt = moment(item.startdate).format(this.dtformat);
      item.startdate = moment(startdatespilt).add(timeSplit[0] ? timeSplit[0] : 0, 'h').add(timeSplit[1] ? timeSplit[1] : 0, 'm').toDate();
    }
    else {
      const startdatespilt = moment(item.starttime).format(this.dtformat);
      item.startdate = moment(startdatespilt).add(timeSplit[0] ? timeSplit[0] : 0, 'h').add(timeSplit[1] ? timeSplit[1] : 0, 'm').toDate();
    }
    return item.startdate;
  }

  getItemEndDate(item: any){
    if (moment(item.endtime).isValid()) {
      const d = new Date(item.endtime);
      const enddatespilt = moment(item.enddate).format(this.dtformat);
      item.enddate = moment(enddatespilt).add(d.getHours() ? d.getHours() : 0, 'h').add(d.getMinutes() ? d.getMinutes() : 0, 'm').toDate();
    }
    else if (String(item.endtime).includes(':')) {
      const timeSplit = item.endtime.split(':');
      const enddatespilt = moment(item.enddate).format(this.dtformat);
      item.enddate = moment(enddatespilt).add(timeSplit[0] ? timeSplit[0] : 0, 'h').add(timeSplit[1] ? timeSplit[1] : 0, 'm').toDate();
    }
    return item.enddate;
  }

  editPlacement(child: any, placement: any) {
      (<any>$(this.historyplacementpopupid)).modal('hide');
      const placementDetails = child;
      child.placementType = placement.placementtypekey;
      placementDetails.placement = placement;
      placementDetails.viewMode = false;
      placementDetails.exitMode = false;
      this._service.placementDetails = [placementDetails];
      this.router.navigate([this.detailspagepath + PlacementConstants.ACTIONS.EDIT], { relativeTo: this.route });
   }

  exitPlacement(child: any, placement: any, action: any) {
      (<any>$(this.historyplacementpopupid)).modal('hide');
      if (action) {
        const placementDetails = child;
        child.placementType = placement.placementtypekey;
        placementDetails.placement = placement;
        placementDetails.viewMode = true;
        placementDetails.exitMode = true;
        this._service.placementDetails = [placementDetails];
        this.router.navigate([this.detailspagepath + PlacementConstants.ACTIONS.EXIT], { relativeTo: this.route });
      } else {
        this.getExitPlacementValidation(child, placement);
      }
  }

  voidPlacement(child: any, placement: any) {
    (<any>$(this.historyplacementpopupid)).modal('hide');
    if (this._authService.hasSupervisor()) {
    const placementDetails = child;
    child.placementType = placement.placementtypekey;
    placementDetails.placement = placement;
    this._service.placementDetails = [placementDetails];
    this.router.navigate([this.detailspagepath + PlacementConstants.ACTIONS.VOID], { relativeTo: this.route });
    }
  }


  voidHistoryPlacement(placement: any) {
    (<any>$(this.historyplacementpopupid)).modal('hide');
    const selectedChildPlacementHistory = this.selectedChildPlacementHistory;
    if (this._authService.hasSupervisor()) {
    const placementDetails = selectedChildPlacementHistory;
    selectedChildPlacementHistory.placementType = placement.placementtypekey;
    placementDetails.placement = placement;
    this._service.placementDetails = [placementDetails];
    this.router.navigate([this.detailspagepath + PlacementConstants.ACTIONS.VOID], { relativeTo: this.route });
    }
  }

  reviewPlacement(child: any, placement: any) {
    (<any>$(this.historyplacementpopupid)).modal('hide');
    this._dataStoreService.setData('editedChildId', null);
    this._dataStoreService.setData('editedPlacementId', null);
    const placementDetails = child;
    child.placementType = placement.placementtypekey;
    placementDetails.placement = placement;
    placementDetails.viewMode = true;
    placementDetails.exitMode = false;
    this._service.placementDetails = [placementDetails];
    this.router.navigate([this.detailspagepath + PlacementConstants.ACTIONS.REVIEW], { relativeTo: this.route });
  }

  addCPAHome(child: any, placement: any) {
    (<any>$(this.historyplacementpopupid)).modal('hide');
    const placementDetails = child;
    child.placementType = placement.placementtypekey;
    placementDetails.placement = placement;
    this._service.placementDetails = [placementDetails];
    this.router.navigate([this.detailspagepath + PlacementConstants.ACTIONS.ADD], { relativeTo: this.route });
  }

  showPlacementDetails(child: any, placement: any) {
    (<any>$(this.historyplacementpopupid)).modal('hide');
    const placementDetails = child;
    child.placementType = placement.placementtypekey;
    placementDetails.placement = placement;
    placementDetails.viewMode = true;
    placementDetails.exitMode = false;
    this._service.placementDetails = [placementDetails];
    this.router.navigate([this.detailspagepath + PlacementConstants.ACTIONS.VIEW], { relativeTo: this.route });
  }

  toggleTable(id: any, index: any, placementrevison: any) {
    this.placementRevison = placementrevison;
    if(this.checkAccordionRow(id,'accordion-tables-placement')) {
      this.showHistoryDetailCpa = null;
      if (this.showHistoryDetail === index) {
        this.showHistoryDetail = null;
      } else {
        this.showHistoryDetail = index;
      }
    }

    if(this.checkAccordionRow(id,'cpa-homes-table')) {
      this.showHistoryDetail = null;
      if (this.showHistoryDetailCpa === index) {
        this.showHistoryDetailCpa = null;
      } else {
        this.showHistoryDetailCpa = index;
      }
    }
  }

  checkAccordionRow(id: string, value: any): boolean {
    return id.includes(value);
  }

  showCPAHomes(id: any, index: any, cpahomerevision: any) {
    this.cpahomerevision = cpahomerevision;
    (<any>$('.collapse.show')).collapse('hide');
    (<any>$('#' + id)).collapse('toggle');
    (<any>$('.provider-details tr')).removeClass(this.bgclssname);
    (<any>$(`#cpa-homes-table${index}`)).addClass(this.bgclssname);
  }

  // [routerLink]="[ '../wrapper']"
  addPlacements() {
    if (this._authService.hasSupervisor()) {
      this.continueAddPlacements();
      // Fix for CIDM-9102
      //this.router.navigate(['../wrapper'], { relativeTo: this.route });
    }
  }

  continueAddPlacements() {
    if (this._service.selectedChildren && this._service.selectedChildren.length === 0) {
      this._alertService.error(this.mandatorymsg);
      return;
    }
    if (this._service.selectedChildren && this._service.selectedChildren.length > 0) {
      this.checkSelectedChildren();
      if (this.noApprovedActiveRemoval) {
        (<any>$('#noApprovedActiveRemoval')).modal('show');
        return;
      }
      const rejectedPlacementChildren = this._service.selectedChildren.filter(child => child.hasRejectedPlacement);
      if (rejectedPlacementChildren.length > 0) {
        (<any>$('#placementRejectedAlert')).modal('show');
        return;
      }
      const reviewPlacementChildren = this._service.selectedChildren.filter(child => child.hasReviewPlacement);
      if (reviewPlacementChildren.length > 0) {
        (<any>$('#placementReviewAlert')).modal('show');
        return;
      }
    }
    this.router.navigate(['../wrapper'], { relativeTo: this.route });
  }

  checkSelectedChildren() {
    const children = this._service.selectedChildren;
    children.forEach(c => {
      if (c.childremoval && c.childremoval.length > 0) {
        const removal = c.childremoval;
        const orderofRemovalInfo = removal;
        orderofRemovalInfo.sort((a: any, b: any) => a.removaldate.localeCompare(b.removaldate));
        const sortRemoval = orderofRemovalInfo.reverse();
        if (sortRemoval[0].removaldate && (!sortRemoval[0].exitdate || sortRemoval[0].exitdate == null) && (!sortRemoval[0].approvalstatus || sortRemoval[0].approvalstatus == null)) {
          this.noApprovedActiveRemoval = true;
        }
      }
    });
  }

  reviewPlacements(placement: any, child: any) {
    this._service.resetValues();
    const selectedChild = [];
    child.placementStatus = placement.routingstatus;
    child.placementType = placement.placementtypekey;
    selectedChild.push(child);
    if (selectedChild && selectedChild.length) {
      selectedChild[0].placement = placement;
    }
    this._service.placementDetails = selectedChild;
    this.router.navigate([this.detailspagepath + PlacementConstants.ACTIONS.REVIEW], { relativeTo: this.route });

  }

  reviewPlacements_old() {
    if (this._service.selectedChildren && this._service.selectedChildren.length === 0) {
      this._alertService.error(this.mandatorymsg);
      return;
    }
    this._service.placementDetails = this._service.selectedChildren;
    let reviewCount = 0;

    this._service.placementDetails.forEach(child => {
      if (child.placementStatus === 'Review') {
        reviewCount++;
      }
    });

    if (reviewCount === 0) {
      this._alertService.error('No placements in review');
      return;
    }
    this.router.navigate([this.detailspagepath + PlacementConstants.ACTIONS.REVIEW], { relativeTo: this.route });
  }

  openLivingArrangement() {
    if (this._service.selectedChildren && this._service.selectedChildren.length === 0) {
      this._alertService.error(this.mandatorymsg);
      return;
    }
    this.router.navigate(['../wrapper/living-arrangement'], { relativeTo: this.route });
  }

  openPlacement() {
    if (this._service.selectedChildren && this._service.selectedChildren.length === 0) {
      this._alertService.error(this.mandatorymsg);
      return;
    }
    if (this._service.selectedChildren) {
      const activePlacementChildren = this._service.selectedChildren.filter(child => child.hasActivePlacement);
      if (activePlacementChildren.length > 0) {
        (<any>$('#placementExistAlert')).modal('show');
        return;
      }
    }
    this.router.navigate(['../wrapper/referral'], { relativeTo: this.route });
  }
  showChildHistory(child: any) {
    this.accountpayableList = [];
    this.paginationInfo.pageNumber = 1;
    this.paginationInfo.pageSize = 10;
    this.selectedChild = child;
    this.commonHttpService.getPagedArrayList(
      new PaginationRequest({
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        method: 'post',
        where: {
          clientid: this.selectedChild.cjamspid
        }
      }), 'tb_payment_header/getAccountsPayableHeaderForCase'
    ).subscribe((result: any) => {
      if (result) {
        this.accountpayableList = result.data;
      }
    });
  }

  getExitPlacementValidation(child: any, placement: any) {
    this.commonHttpService.getArrayList(
      {
        method: 'get',
        where: {
          personid: child.personid
        }
      }, 'placement/placementvalidation?filter'
    ).subscribe((result: any) => {
      if (Array.isArray(result) && result.length) {
        const data = result[0].getplacementvalidations;
        const obj = data[0];
        this.exitValidationObj = obj;

        this.exitPlacementvalid = (obj.iscaseplan && obj.iscaseplaneligibility && obj.ischildage && obj.is_servicelog && obj.islivingarrgangement) ? true : false;
          (<any>$('#exitplacementvalidation')).modal('show');
        // }
      }
    });
  }
  placementExit() {
    const exitFormData = this._dataStoreService.getData('exitFormData');
    const children = this._service.placementDetails;
    if (children && children.length && children[0].placement) {
      exitFormData.placementid = children[0].placement.placementid;
      exitFormData.servicecaseid = children[0].placement.servicecaseid;
      if (children[0].placement.providerdetails) {
        exitFormData.providerid = children[0].placement.providerdetails.provider_id;
      }
    }
    this.commonHttpService
      .create(exitFormData, 'placement/exitplacement')
      .subscribe(response => {
        this._alertService.success('Placement exit recorded successfully', true);
      });
  }

  showFiscal(item: { alternateid: any; }) {
    if (item) {
      this._financeSerice.getChangeHistory(1, item.alternateid, 'placement');
    }
  }

  getDateFormatted(date:any){
    if(date && moment(date).isValid()){
      return moment(date).format('MM/DD/YYYY');
    }else{
      return '';}
  }
  
  checkChildTPR() {
    let childList = this._service.childList;
    childList = childList.filter(child => child.hasActivePlacement);
    this.tprCompletedChildList = [];
    if (childList && childList.length > 0) {
      this.checkChildList(childList);
    }

  }

  checkChildList(childList: any) {
    const tprChildAcceptablePlacement = [500, 501];
    childList.forEach((child: any) => {
      if (child && child.placements && child.placements.length > 0) {
        for (let i = 0; i < child.placements.length; i++) {
          //This is the active placement
          if (!(child.placements[i].enddate) && child.placements[i].placementtypekey === 'PRPL') {
            this.getClientSpecificTPRList(child, i, tprChildAcceptablePlacement);
          }
        }
      }
    });
  }
  getClientSpecificTPRList(child: any, i: any, tprChildAcceptablePlacement: any) {
    this._service.getClientSpecificTPRList(this.id, child.personid)
      .subscribe(res => {
        if (res && res.length) {
          const tprList = res.filter(tpr => tpr.personid == child.personid);
          if (this.validtprList(tprList)) {
            if (child.placements[i].ischangepreadoptive != null && !child.placements[i].ischangepreadoptive) {
              const tprCompletedChild = {
                'childname': this.getChildName(child),
                'personid': child.personid,
                'placementid': child.placements[i].placementid,
                'currentplacementstr': child.placements[i].placementstructuredesc
              };
              if (!tprChildAcceptablePlacement.includes(child.placements[i].service_id)) {
                this.tprCompletedChildList.push(tprCompletedChild);
              }
              this.tprChildAlert();
            }
          }
        }
      });
  }
  getChildName(child: any){
    return child.personname ? child.personname : (child.firstname + " " + child.lastname);
  }

  validtprList(tprList: any){
    if (tprList && tprList.length && (tprList.length === 2 || (tprList.length === 1 && tprList[0].singleparent))){
      return true;
    } else {
      return false;
    }
  }
  tprChildAlert(){
    if (this.tprCompletedChildList.length > 0) {
      (<any>$('#tpr-child-alert')).modal('show');
    }
  }

  selectAccountsPayable(_payment: any) {
    // No data or fuction to call
  }
}