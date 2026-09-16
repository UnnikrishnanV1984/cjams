
import {map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { forkJoin ,  Subject } from 'rxjs';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { AuthService, DataStoreService, CommonHttpService } from '../../../../@core/services';
import { ErrorInfo } from '../../../../@core/common/errorDisplay';
import { AppConstants } from '../../../../@core/common/constants';
import { PlacementConstants } from '../service-case-placements/constants';
const LIVING_ARRANGEMENT = 'LA';
const VOID_PLACEMENT = 1;
const RESPONSE_ACCEPTED_YES = '4612';
const RESPONSE_REJECTED = 'Rejected';
const RESPONSE_APPROVED = 'Approved';

@Injectable()
export class ServiceCasePermanencyPlanService {

  removedChildList: any = [];
  placementList: any = [];
  permanencyPlanList: any;
  selectedChildren: any = [];
  placementDetails: any = [];
  formAction = 'Add';
  // For Edit Load
  selectedPermanencyPlan: any;
  isCaseWorker = false;
  isSuperVisor = false;
  error: ErrorInfo = new ErrorInfo();
  isViewMode: boolean;
  queueIndex = 0;
  addedPermanencyplan = false;
  public placementApprovalQueue$ = new Subject<any>();
  public refresh$ = new Subject<any>();
  public childSelection$ = new Subject<any>();
  public updatePermanencyList$ = new Subject<any>();

  permanencyplan = 'Permanency Plan ';
  constructor(private _commonService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _authService: AuthService) {
    this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
    this.isSuperVisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
    this.isViewMode = false;
  }

  toggleFormAction(action: any, data?: any) {
    this.formAction = action;
    if (data) {
      this.selectedPermanencyPlan = data;
    }
  }

  setSelectedChild(child: any) {
    this.selectedChildren = [];
    this.selectedChildren.push(child);
  }

  setViewMode(isViewMode: any) {
    this.isViewMode = isViewMode;
  }
  getChildRemoval() {
    return this._commonService
      .getSingle(
        {
          where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID), 'objecttypekey': 'servicecase' },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
          .GetChildRemovalList + '?filter'
      );
  }

  resetValues() {
    this.selectedChildren = [];
    this.queueIndex = 0;
    this.addedPermanencyplan = false;
  }

  resetValuesWithOutChild(){
    this.queueIndex = 0;
    this.addedPermanencyplan = false;
  }

  getPlacementInfoList(pageNumber: any, limit: any) {
    return this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: pageNumber,
          limit: limit,
          method: 'get',
          where: { servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        }),
        'placement/getplacementbyservicecase?filter'
        // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
      );
  }

  getPermanencyPlanList(pageNumber: any, _limit: any) {
    return this._commonService
      .getArrayList(
        new PaginationRequest({
          page: pageNumber,
          limit: 100,
          nolimit: true,
          method: 'get',
          where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        }),
        'permanencyplan/list?filter'
        // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
      );


  }

  getPermanencyPlanHistory(pageNumber: number, requestParam: any) {
    return this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: pageNumber,
          limit: 10,
          method: 'get',
          where: requestParam,
        }),
        'permanencyplanhistory/list?filter'
        // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
      );


  }


  getPermanencyPlanHistoryDetails( id: any) {
    return this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 10,
          method: 'get',
          where:  { objectid: id, 'objecttypekey': 'servicecase' },
        }),
        'permanencyplanhistory/details?filter'
      );


  }

  getChildRemovalInfoAndPlacements() {
    return forkJoin([this.getPlacementInfoList(1, 10), this.getChildRemoval(), this.getPermanencyPlanList(1, 10)]).pipe(
      map(([children, childRemoval, permanencyPlanList]) => {
        if (children && children.data) {
          children.data.forEach(child => {
            child.hasAlert = this.checkForChildHasAlert(child.placements);
            child.hasActivePlacement = this.checkForChildHasProviderPlacements(child.placements);
            child.placements.map((placement: any) => {
              return this.processForPlacementActions(placement);
            });
          });
          this.placementList =  children.data;
        }
        if (childRemoval) {
          this.removedChildList = childRemoval;          
          if (this.placementList && this.placementList.length > 0) {
            this.placementList.forEach((data: any) => {
              const isavailableatremoval = this.isChildAvailable(data);
              data.isAvailinRemoval = this.nullCheck(isavailableatremoval);
            });
            this.placementList = this.placementList.filter((ele: { isAvailinRemoval: any; }) => ele.isAvailinRemoval)
          }
        } else {
          this.placementList = [];
        }
        if (permanencyPlanList) {
          permanencyPlanList.forEach(item => {
            const childPlacment = this.placementList.find((placment: { personid: any; }) => item.personid === placment.personid);
            item.placements = childPlacment ? childPlacment.placements : [];
            const removalList = this.removedChildList.filter((child: { personid: any; }) => child.personid === item.personid);
            item.removalList = removalList;
          });
         
          this.permanencyPlanList = permanencyPlanList;
        }
        return { placements: this.placementList, removedChildList: this.removedChildList };
      }));
  }

  nullCheck(input: any){
    return input ? true : false;
  }

  isChildAvailable(data: any){
    return (this.removedChildList && this.removedChildList.length > 0) ? this.removedChildList.find((ele: { personid: any; }) => ele.personid === data.personid) : null;
  }

  checkForChildHasAlert(placements: any) {
    let hasAlert = false;
    const runAwayPlacement = placements.find((placement: { livingarrangementtypekey: string; }) => placement.livingarrangementtypekey === PlacementConstants.RUN_AWAY);
    if (runAwayPlacement) {
      hasAlert = true;
    }
    return hasAlert;
  }
  checkForChildHasProviderPlacements(placements: any) {
    let hasActivePlacement = false;
    if (placements && placements.length) {
      const pastProviderPlacement = placements.filter((placement: any) => 
        (  placement.placementtypekey !== LIVING_ARRANGEMENT //Provider placement with:
        && placement.responseacceptedkey === RESPONSE_ACCEPTED_YES  //Accepted Reponse, and
        && ( placement.routingstatus === RESPONSE_APPROVED || //Approved status (or in void/enddate review), and
             placement.revisionupdate && (placement.revisionupdate.enddate || placement.revisionupdate.isvoided))
        && ( placement.isvoided !== VOID_PLACEMENT || //Valid Placement, and
             placement.revisionupdate && placement.revisionupdate.isvoided)));
      if (pastProviderPlacement) {
        hasActivePlacement = true;
      }
    }
    return hasActivePlacement;
  }

  selectedPlacedChild(childId: any) {
    return this.placementList.filter((placement: { cjamspid: any; }) => placement.cjamspid === childId);
  }

  broadCastPageRefresh() {
    this.resetValuesWithOutChild();
    this.refresh$.next('refresh');
  }

  updatePermanency(list: any) {
    this.updatePermanencyList$.next(list);
  }

  processRemovedChildListStatus() {
    this.resetValues();
    if (this.placementList && this.placementList.length) {
      this.removedChildList.forEach((removedChild: any) => {

        const childPlaced = this.placementList.find((placedChild: { personid: any; }) => placedChild.personid === removedChild.personid);

        if (childPlaced && childPlaced.placements) {

          childPlaced.placements.forEach((placement: any) => {
            placement.placementTypeDesc = this.getPlacementTypeDescription(placement.placementtypekey);
          });
          removedChild.hasActivePlacement = this.checkForChildHasProviderPlacements(childPlaced.placements);
          const reviewPlacement = childPlaced.placements.find((placement: { routingstatus: string; }) => placement.routingstatus === 'Review');
          if (reviewPlacement) {
            reviewPlacement.fullAddress = this.processAddress(reviewPlacement);
            removedChild.placementStatus = reviewPlacement.routingstatus;
            removedChild.placementType = reviewPlacement.placementtypekey;
            removedChild.placement = reviewPlacement;
            removedChild.isSelected = true;
            if(removedChild.hasActivePlacement) {
            this.selectedChildren.push(removedChild);
            }
          }


        }
      });
    }
  }

  processAddress(placement: any) {
    return `${placement.address1} , ${placement.address2} , ${placement.cityname}, ${placement.statetypekey}, ${placement.zipcode}`;
  }

  processForPlacementActions(placement: any) {
    if (placement.routingstatus === 'Approved' && this.isCaseWorker) {
      placement.isEditable = true;
    } else {
      placement.isEditable = false;
    }
    if (placement.enddate || placement.voidreasontypekey) {
      placement.isEditable = false;
    }
    return placement;
  }

  getPlacementTypeDescription(type: any) {
    if (type === 'LA'){
      return 'Living Arrangement';
    } else {
      return 'Provider Placement';
    }
  }

  selectChild(selectedChild: any, selection: any) {
    selectedChild.isSelected = selection;
    if (selection) {
      this.selectedChildren.push(selectedChild);
    } else {
      this.selectedChildren = this.selectedChildren.filter((child: { personid: any; }) => child.personid !== selectedChild.personid);
    }
    this.childSelection$.next('SELECTED');

  }

  getSelectedChildren() {
    return this.selectedChildren ? this.selectedChildren : [];
  }

  sendApprovalInQueue(data: any) {
    this.queueIndex = 0;
    this.sendForApproval(data);
  }

  getPropertyFromChildRemoval(propertyName: any) {
    if (this.selectedChildren[this.queueIndex]) {
      if (this.formAction === 'Add' && this.selectedChildren[this.queueIndex].placements && this.selectedChildren[this.queueIndex].placements.length) {
        return this.getReturnPropertyValue(propertyName);
      } else if (this.selectedChildren[this.queueIndex].permanencyplans && this.selectedChildren[this.queueIndex].permanencyplans.length) {
        const childRemoval = this.selectedChildren[this.queueIndex].permanencyplans[0];
        return childRemoval[propertyName];
      } else {
        return null;
      }
    } else {
      return null;
    }

  }

  //Added a check to map the placement id that is active to the Permanency plan created - CDM-10028
  getReturnPropertyValue(propertyName: any) {
    let propVal = null
    if (propertyName === 'intakeservicerequestactorid') {
      propVal = this.selectedChildren[this.queueIndex]['intakeservicerequestactorid'];
      return propVal;
    }
    else if(propertyName === 'placementid'){
      const placedChild = this.selectedChildren[this.queueIndex].placements;
      let propertyValue = null;
      let returnPropertyValue = null;
      placedChild.forEach((placement: any) => {
        if (placement.placementtypekey && !placement.enddate) {
          const childRemoval = placement;
          propertyValue = childRemoval[propertyName];
          if (propertyValue) {
            returnPropertyValue = propertyValue;
          }
        }
      });
    return returnPropertyValue;
    }    
  }

  sendForApproval(formData: any) {
    if (this.isQueueAvailable()) {
      formData.servicecaseid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
      formData.intakeserviceid = null;
      formData.intakeservicerequestactorid = this.getPropertyFromChildRemoval('intakeservicerequestactorid');
      formData.placementid = this.getPropertyFromChildRemoval('placementid');
      const updatedData  = Object.assign({}, formData);
      formData.modifiedjson = updatedData;

      this._commonService
        .create(formData, 'permanencyplan/add')
        .subscribe(response => {
          this.addedPermanencyplan = true;
          this.queueIndex++;
          if (this.isQueueAvailable()) {
            this.sendForApproval(formData);
          } else {
            const msg = formData.isreviewsubmit ? ' Permanency plan submitted for supervisor approval successfully!' : ' Permanency plan saved successfully!';
            this.placementApprovalQueue$.next(msg);
            this.getChildRemovalInfoAndPlacements();
            this.resetValues();
          }
        });


    } else {
      //No operation needed here
    }

  }

  saveOrUpdatePermanencyPlan(formData: any) {
    this._commonService
      .create(formData, 'permanencyplan/add').subscribe();
  }

  isQueueAvailable() {
    return this.queueIndex < this.selectedChildren.length;
  }

  isApproveRejectionQueueAvailable() {
    return this.queueIndex < this.selectedChildren.length;
  }

  extractPlacementId(queueIndex: any) {
    const permanencyplans = (this.selectedChildren && this.selectedChildren[queueIndex].permanencyplans) ? this.selectedChildren[queueIndex].permanencyplans : null;
    if (permanencyplans) {
      return permanencyplans.map((plan: { status: string; permanencyplanid: any; }) => {
        if (plan.status === 'Review') {
          return plan.permanencyplanid;
        }
      });
    } else {
      return null;
    }
  }

  approvePlacements(placementId: any) {
    return this.approveOrRejectPlacement(placementId, 'Approved');
  }

  rejectPlacements(placementId: any) {
    return this.approveOrRejectPlacement(placementId, 'Rejected');
  }

  approveOrRejectPlacement(placementId: any, status: any) {
    const data = {
      'objectid': placementId,
      'eventcode': 'PPLR',
      'servicecaseid': this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID),
      'status': status,
      'comments': this.permanencyplan + status,
      'notifymsg': this.permanencyplan + status,
      'routeddescription': this.permanencyplan + status
    };

    return this._commonService
      .create(data, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.approveOrReject);
  }



  startPlacementApprovalInQueue() {
    this.queueIndex = 0;
    this.startPlacementApproval();
  }

  startPlacementApproval() {
    if (this.isApproveRejectionQueueAvailable()) {
      const availablePlans = this.extractPlacementId(this.queueIndex);
      if (availablePlans && availablePlans.length) {
        availablePlans.map((placementId: any) => {
          if (placementId) {
            this.approvePlacements(placementId).subscribe(response => {
              this.queueIndex++;
              if (this.isApproveRejectionQueueAvailable()) {
                this.startPlacementApproval();
              } else {
                this.placementApprovalQueue$.next('Permanency Plan Approved Successfully');
              }
            });
          }
        });
      }
    }

  }

  startPlacementRejectionInQueue() {
    this.queueIndex = 0;
    this.startPlacementRejection();
  }

  approveorRejectPlacement(permanencyPlanId: any, status: any) {
    if (status === 'Approved') {
      this.approvePlacements(permanencyPlanId).subscribe(response => {
        this.placementApprovalQueue$.next('Permanency Plan Approved Successfully');
      });
    } else if (status === 'Rejected') {
      this.rejectPlacements(permanencyPlanId).subscribe(response => {
        this.placementApprovalQueue$.next('Permanency Plan Rejected Successfully');
      });
    }
  }

  startPlacementRejection() {
    if (this.isApproveRejectionQueueAvailable()) {
      this.extractPlacementId(this.queueIndex).map((placementId: any) => {
        this.rejectPlacements(placementId).subscribe(response => {
          this.queueIndex++;
          if (this.isApproveRejectionQueueAvailable()) {
            this.startPlacementRejection();
          } else {
            this.placementApprovalQueue$.next('Placement Rejected Successfully');
          }
        });
      });
    }
  }

  childHasAnyPermanencyPlans(child: any) {
    if (this.permanencyPlanList.length === 0) {
      return false;
    }

    const childPlans = this.permanencyPlanList.find((plan: { cjamspid: any; }) => plan.cjamspid === child.cjamspid);

    if (!childPlans) {
      return false;
    } else {
      return true;
    }

  }

  isAnyPlansExist() {
    let isAnyPlanExist = false;
    this.selectedChildren.forEach((child: any) => {
      isAnyPlanExist = this.childHasAnyPermanencyPlans(child);
    });
    return isAnyPlanExist;
  }



}