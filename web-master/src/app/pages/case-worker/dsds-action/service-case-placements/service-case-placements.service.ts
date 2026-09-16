
import {share, map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { forkJoin ,  Subject } from 'rxjs';
import { CommonHttpService, DataStoreService, AuthService, AlertService } from '../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { PlacementConstants } from './constants';
import { AppConstants } from '../../../../@core/common/constants';
import { ErrorInfo } from '../../../../@core/common/errorDisplay';
import { HttpClient } from '@angular/common/http';
import _ from 'lodash';
import { AppUser } from '../../../../@core/entities/authDataModel';
import moment from 'moment';
import { environment } from '../../../../../environments/environment';
import { HospitalizationService } from '../../../../shared/services/hospitalization.service';

const LIVING_ARRANGEMENT = 'LA';
const VOID_PLACEMENT = 1;
const RESPONSE_ACCEPTED_YES = '4612';
const RESPONSE_REJECTED = 'Rejected';
const RESPONSE_REVIEW = 'Review';
@Injectable({
  providedIn:"root"
})
export class ServiceCasePlacementsService {

  removedChildList: any[] = [];
  childList:any[] = [];
  placementList:any[] = [];
  selectedChildren :any[]= [];
  placementDetails:any[] = [];
  isCaseWorker = false;
  error: ErrorInfo = new ErrorInfo();
  private userInfo: AppUser;
  IVEReferralProdCheck: any;  
  CHILD_CATEGORIES = ['CHILD', 'BIOCHILD', 'NVC', 'OTHERCHILD', 'PAC', 'RC', 'AV'];

  queueIndex = 0;
  public placementApprovalQueue$ = new Subject<any>();
  public refresh$ = new Subject<any>();
  public childSelection$ = new Subject<any>();
  public caregiversList$ = new Subject<any>();
  personsList?: any[];
  caregiversList?: any[];
  caregiverPersonsList?: any[];
  dtformat = 'YYYY-MM-DD';

  constructor(private _commonService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _authService: AuthService,
    private _alert: AlertService,
    private http: HttpClient,
    private hospitalizationService: HospitalizationService) {
      this.userInfo = this._authService.getCurrentUser();
      this.IVEReferralProdCheck = environment.IVEReferralCSMSCall;
     }

  getChildRemoval() {
    return this._commonService
      .getSingle(
        {
          where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID), 'objecttypekey': 'servicecase' , isgroup: 1},
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
          .GetChildRemovalList + '?filter'
      );
  }

  getPersonList(){
    return this._commonService
    .getPagedArrayList(
      new PaginationRequest({
        page: 1,
        limit: 20,
        method: 'get',
        where: {
          objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID),
          objecttypekey: 'servicecase'
        }
      }),
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
    );
  }

  resetValues() {
    this.selectedChildren = [];
  }

  getPlacementInfoList(pageNumber:number, limit:number) {
    return this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: pageNumber,
          limit: limit,
          method: 'get',
          where: { servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        }),
        'placement/getplacementbyservicecase?filter'
      );
  }

  getRelationShip(primaryuserid:string, secondaryuserid:string, relationshiparray:any) {
    let relationshipdesc= '';
    if(primaryuserid === secondaryuserid){
      relationshipdesc = 'Self';
    }else if(relationshiparray && relationshiparray.length) {
      const relationship = relationshiparray.filter((person:any) => ( person.primaryuserid === primaryuserid && person.secondaryuserid === secondaryuserid ) );
      if(relationship && relationship.length) {
        relationshipdesc = relationship[0].description;
      }
    }

    return relationshipdesc;
  }

  getChildRemovalInfoAndPlacements() {
    this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
    return forkJoin([this.getPlacementInfoList(1, 10), this.getChildRemoval(), this.getPersonList(), this.getCaregiversInCase()]).pipe(
      map(([children, childRemoval, persons, caregivers]) => {
        if (children && children.data) {
          children.data.forEach(child => {
            if (Array.isArray(child.placements)) {
              child.hasAlert = this.checkForChildHasAlert(child.placements);
              child.hasActivePlacement = this.checkForChildHasActivePlacements(child.placements);
              child.hasReviewPlacement = this.checkForChildHasReviewPlacements(child.placements);
              child.hasRejectedPlacement = this.checkForChildHasRejectedPlacements(child.placements);
              child.placements.map((placement:any) => {
                return this.processForPlacementActions(placement);
              });
            }

          });
          this.placementList = children.data;
        }
        if (childRemoval) {
          this.removedChildList = childRemoval.filter((item :any) => item.childremoval !== null && item.childremoval.find((ritem :any) => (ritem.approvalstatus === 'Approved' || ritem.previousstatus === 16)));
        }
        this.checkPersons(persons, caregivers);
        this.processRemovedChildListStatus();
        return { placements: this.placementList, removedChildList: this.removedChildList, childList: this.childList, caregiversList: this.caregiverPersonsList };
      }));
  }

  checkPersons(persons:any, caregivers:any){
    if (persons && persons.data) {
      let personList = persons.data;
      this.personsList = this.emptyArrayCheck(personList);
      this.setCaregiversList(caregivers);
      personList = personList.filter((person:any)=> {
        let addPerson = false;
        if (person.roles && person.roles.length) {
          person.roles.forEach((role :any) => {
            const childCategory = this.CHILD_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
            if (childCategory) {
              addPerson = true;
            }
          });
        }
        addPerson = this.childRemovedCheck(person,addPerson);

        if (addPerson) {
          person.notRemoved = true;
          person.typedescription = person.gender;
        }
        return addPerson;
      });
      const list:any[]= [];
      personList.forEach((child :any)=> list.push(child));
      this.removedChildList.forEach(child => list.push(child));
      this.childList = list;
    }
  }

  setCaregiversList(caregivers:any){
    if (caregivers && caregivers.length && caregivers[0].getallcaregiversincase) {
      caregivers = caregivers[0].getallcaregiversincase;
      if (this.personsList && caregivers) {
        this.caregiversList = caregivers.map((caregiver :any) => this.personsList?.find((person:any) => (person.personid == caregiver.personid)));
        this.caregiversList = this.caregiversList && this.caregiversList.length > 0 ? this.caregiversList.filter(item => item) : [];
      }
    }
  }

  emptyArrayCheck(list:any){
    return list ? list : [];
  }

  childRemovedCheck(person:any,addPerson:any){
    if (person && person.personid && this.removedChildList) {
      const childremoved = this.removedChildList.find((item:any) => item?.personid === person.personid);
      if (childremoved) {
        addPerson = false;
      }
    }
    return addPerson;
  }

  getProviderFullName(providerInfo:any) {

    let providerName = ''

    if(providerInfo) {
      providerName = providerInfo.provider_nm ? providerInfo.provider_nm : ''
    }

    if(providerInfo && providerName === '') {
      providerName = '' + 
      (providerInfo.provider_prefix_cd?providerInfo.provider_prefix_cd+' ':'') + 
      (providerInfo.provider_first_nm?providerInfo.provider_first_nm+' ':'') + 
      (providerInfo.provider_middle_nm?providerInfo.provider_middle_nm+' ':'') + 
      (providerInfo.provider_last_nm?providerInfo.provider_last_nm+' ':'') + 
      (providerInfo.provider_suffix_cd?providerInfo.provider_suffix_cd+' ':'') ;
    }

    return providerName;

  }

  checkForChildHasAlert(placements:any) {
    let hasAlert = false;
    if (placements && Array.isArray(placements))
    {
      const runAwayPlacement = placements.find(placement => placement.livingarrangementtypekey === PlacementConstants.RUN_AWAY 
        && placement.enddate === null);
      if (runAwayPlacement) {
        hasAlert = true;
      }
      return hasAlert;
    }
  }
  checkForChildHasActivePlacements(placements:any) {
    let hasActivePlacement = false;
    if (placements && placements.length) {
      const providerPlacement = placements.filter((placement :any) => placement.placementtypekey !== LIVING_ARRANGEMENT 
        && placement.enddate === null
        && placement.isvoided !== VOID_PLACEMENT 
        && placement.responseacceptedkey === RESPONSE_ACCEPTED_YES
        && (placement.routingstatus !== RESPONSE_REJECTED)
        );
      if (providerPlacement && providerPlacement.length) {
        hasActivePlacement = true;
      }
    }
    return hasActivePlacement;
  }

  checkForChildHasReviewPlacements(placements:any) {
    let hasReviewPlacement = false;
    if (placements && placements.length) {
      const providerPlacement = placements.filter((placement :any) => placement.placementtypekey !== LIVING_ARRANGEMENT 
        && (placement.routingstatus === RESPONSE_REVIEW)
        );
      if (providerPlacement && providerPlacement.length) {
        hasReviewPlacement = true;
      }
    }
    return hasReviewPlacement;
  }

  checkForChildHasRejectedPlacements(placements:any) {
    let hasRejectedPlacement = false;
    if (placements && placements.length) {
      const providerPlacement = placements.filter((placement:any) => placement.placementtypekey !== LIVING_ARRANGEMENT 
        && (placement.routingstatus === RESPONSE_REJECTED)
        );
      if (providerPlacement && providerPlacement.length) {
        hasRejectedPlacement = true;
      }
    }
    return hasRejectedPlacement;
  }


  checkChildActivePlacementDate(placements:any) {
    if (placements && placements.length) {
      const providerPlacement = placements.filter((placement:any) => placement.placementtypekey !== LIVING_ARRANGEMENT 
        && placement.enddate === null
        && placement.isvoided !== VOID_PLACEMENT
        && placement.responseacceptedkey === RESPONSE_ACCEPTED_YES
      //  && placement.routingstatus !== RESPONSE_REJECTED
        );
      if (providerPlacement && providerPlacement.length) {
        return this.convertMatinputTimeToTimestamp(providerPlacement[0].startdate, providerPlacement[0].starttime);
      }
      else {
        return null;
      }
    }else{ 
    return null;
    }
  }
  
  convertMatinputTimeToTimestamp(date:Date, time:any) {
    return moment(moment(date).format('MM/DD/YYYY') + ' ' + time).format();
  }
  
  broadCastPageRefresh() {
    this.refresh$.next('refresh');
  }

  processRemovedChildListStatus() {
    this.resetValues();
    if (this.placementList && this.placementList.length && this.childList) {
      this.childList.forEach((removedChild:any) => {
        const childPlaced = this.placementList.find((placedChild:any) => placedChild.personid === removedChild.personid);
        if (childPlaced && childPlaced.placements) {
          childPlaced.placements.map((placement :any) => {
            placement.placementTypeDesc = this.getPlacementTypeDescription(placement.placementtypekey);
          });
          removedChild.hasActivePlacement = this.checkForChildHasActivePlacements(childPlaced.placements);
          removedChild.hasReviewPlacement = this.checkForChildHasReviewPlacements(childPlaced.placements);
          removedChild.hasRejectedPlacement = this.checkForChildHasRejectedPlacements(childPlaced.placements);
          removedChild.placements = childPlaced.placements;
          const reviewPlacement = childPlaced.placements.find((placement :any)=> placement.routingstatus === 'Review');
          if (reviewPlacement) {
            reviewPlacement.fullAddress = this.processAddress(reviewPlacement);
            removedChild.placementStatus = reviewPlacement.routingstatus;
            removedChild.placementType = reviewPlacement.placementtypekey;
            removedChild.placement = reviewPlacement;
            removedChild.isSelected = true;
            this.selectedChildren.push(removedChild);
          }
        }
      });
    }
  }

  processAddress(placement:any) {
    return`${placement.address1} , ${placement.address2} , ${placement.cityname}, ${placement.statetypekey}, ${placement.zipcode}`;
  }

  processForPlacementActions(placement:any) {
    if ( (placement.routingstatus === 'Approved' || placement.routingstatus === 'Rejected' || ((placement.approvalstatustypekey === 'Approved' || placement.approvalstatustypekey === null) && placement.old_id != null && placement.routingstatus !== 'Review')) && this.isCaseWorker) {
      placement.isEditable = true;
    } else {
      placement.isEditable = false;
    }
    if (placement.enddate || placement.isvoided === 1) {
      placement.isEditable = false;
    }
    return placement;
  }

  getPlacementTypeDescription(type:any) {
    if(type == 'LA'){
      return 'Living Arrangement';
    } else {
      return 'Provider Placement';
    }
  }

  selectChild(selectedChild:any, selection:any) {
    selectedChild.isSelected = selection;
    if (selection) {
      this.selectedChildren.push(selectedChild);
    } else {
      if (this.selectedChildren && selectedChild) {
      this.selectedChildren = this.selectedChildren.filter(child => child.personid !== selectedChild.personid);
      }
    }
    if(this.selectedChildren?.length){
      this.hospitalizationService.setSelectedPersonId(this.selectedChildren[this.selectedChildren.length - 1]['personid'])
    }
    
    this.childSelection$.next('SELECTED');
     
  }

  getCaregiversInCase() {
    return this._commonService.getArrayList(
            new PaginationRequest({
                nolimit: true,
                method: 'get',
                where: {
                    personid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID)
                }
            }),
            'Actorrelationships/getallcaregiversincase'+ '?filter'
        );
  }

  getSelectedChildren() {
    return this.selectedChildren ? this.selectedChildren : [];
  }

  sendApprovalInQueue(data:any) {
    this.queueIndex = 0;
    this.sendForApproval(data);
  }

  getPropertyFromChildRemoval(propertyName:any) {
    if (this.selectedChildren.length > 0 && this.selectedChildren[this.queueIndex].childremoval && this.selectedChildren[this.queueIndex].childremoval.length) {
      const childRemoval = _.orderBy(this.selectedChildren[this.queueIndex].childremoval, ['removalid'], ['desc']);
      if (childRemoval && childRemoval.length) {
        const childRemoval0 = childRemoval[0];
        return childRemoval0[propertyName];
      }
      else{
        return null;}
    } else {
      return null;
    }

  }

  sendForApproval(formData:any) {
    if (formData.placementid !== null && formData.placementid !== undefined) {
      this.selectedChildren = this.childList.filter(child => child.personid == formData.personid);
    }

    if (this.isQueueAvailable() && formData.personid && this.queueIndex) {
      formData.personid = null;
    }

    if (this.isQueueAvailable() || formData.placementid !== null) {
      formData.servicecaseid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
      formData.personid = formData.personid ? formData.personid : this.getPersonid();
      formData.intakeservreqchildremovalid = this.getPropertyFromChildRemoval('intakeservreqchildremovalid');
      formData.placementid = formData.placementid ? formData.placementid : null;
      formData.livingid = formData.livingid ? formData.livingid : null;
      formData.v_securityusersid = this.userInfo.user.userprofile.securityusersid;
      formData.intakeservicerequestactorid = this.getActorId();
      this.addUpdatePlacement(formData);
    } else {
      //No operation needed here
    }

  }

  addUpdatePlacement(formData:any) {
    this._commonService
      .create(formData, 'placement/addupdate')
      .subscribe(response => {
        if (response.msgStatus == 'ERROR') {
          this._alert.error(response.message, true);
        } else if (response.msgStatus == 'Success') {
          this._alert.success(response.message, true);
          this.queueIndex++;
          if (this.isQueueAvailable() && (formData.placementid == undefined || formData.placementid == null)) {
            this.sendForApproval(formData);
          } else {
            if (formData.placementid == null) {
              this.placementApprovalQueue$.next('completed');
            } else {
              this.placementApprovalQueue$.next('Placement edit recorded successfully');
            }
          }
        }
      });
  }

  getPersonid(){
    return this.selectedChildren[this.queueIndex] ? this.selectedChildren[this.queueIndex].personid : null;
  }
  getActorId(){
    if (this.getPropertyFromChildRemoval('intakeservicerequestactorid')) {
      return this.getPropertyFromChildRemoval('intakeservicerequestactorid');
    } else {
      return this.selectedChildren[this.queueIndex].intakeservicerequestactorid;
    }
  }
  isQueueAvailable() {
    return this.queueIndex < this.selectedChildren.length;
  }

  extractPlacementId() {
    return this.selectedChildren.map(child => {
      return child.placement.placementid;
    });
  }

  approvePlacements(placementId:any, reason:any) {
    return this.approveOrRejectPlacement(placementId, 'Approved', reason);
  }

  rejectPlacements(placementId:any, reason:any) {
    return this.approveOrRejectPlacement(placementId, 'Rejected', reason);
  }

  placementCheckError(childData:any) {
    if ((childData.placement.revisionupdate) &&
    ( childData.placement.revisionupdate.voidreasontypekey === null || childData.placement.revisionupdate.voidreasontypekey === 'null')
    && ( childData.placement.revisionupdate.isvoided !== 1)) {
      this._commonService.endpointUrl = 'placement/placementAutoValidation';
      const placement = childData.placement;
      const revisionupdate = (placement) ? placement.revisionupdate : null;
      const model = {
        placementid: placement.alternateid,
        startdate: (revisionupdate) ? revisionupdate.entrydate : this.getStartDate(placement),
        enddate: (revisionupdate) ? revisionupdate.enddate : null,
        update_sw: 'P',
        fromscreen: 'other', // other-- Other screen. Not from placement validation screen
        isbefore: false
      };
      this._commonService.create(model).subscribe(
      (response) => {
        // No data or function to add or call
      });
    }
  }

  getStartDate(placement:any){
    return (placement) ? placement.startdate : null;
  }

  approveorRejectPlacementasSupervisor(placementId:any, status:any, reason:any, childData?:any) {
    if (status === 'Approved') {
     this.approvePlacements(placementId, reason).subscribe(response => {
       if (childData && childData.placementType !== 'LA') {
        this.placementCheckError(childData);
       }
       if(this.IVEReferralProdCheck && childData?.childremoval && childData?.childremoval.length) {
          this.sendApprovalInfomation(childData.cjamspid, childData.childremoval[childData.childremoval.length - 1].removalid, (childData.placement?.exittypekey == 'PLCC' || childData.placement?.exittypedescription == 'Permanently Leaving Custody & Care'));
      }
       this.placementApprovalQueue$.next('Placement approved successfully');
     });
    } else  if (status === 'Rejected') {
       this.rejectPlacements(placementId, reason).subscribe(response => {
         this.placementApprovalQueue$.next('Placement returned to the worker successfully.');
       });
      }
    }

  approveOrRejectPlacement(placementId:string, status:any, reason:any) {
    const data = {
      'objectid': placementId,
      'eventcode': 'PLTR',
      'status': status,
      'servicecaseid': this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID),
      'comments': reason,
      'notifymsg': 'Child Placement ' + status,
      'routeddescription': 'Child Placement' + status,
      'servicecaseidforsendpa': this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID),
      'v_securityusersid': this.userInfo.user.userprofile.securityusersid
    };

    return this._commonService
      .create(data, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.approveOrReject);
  }

       // Trigger to pass the CJAMS information to CSMS
  sendApprovalInfomation(clientid:any, removalid:any, exittypekey:any) {
        this._commonService.create(
            {
                'where': {
                    'clientId': clientid,
                    'removalId': removalid,
                    'reviewperiod': exittypekey ? 'Removal Exit' : null
                },
            },
            'titleive/ive/ivecsms-data'
        ).subscribe(response => {
                return true;
            },
            (error) => {
                return false;
            });
    }

  
  startPlacementApprovalInQueue() {
    this.queueIndex = 0;
    this.startPlacementApproval();
  }

  startPlacementApproval() {
    if (this.isQueueAvailable()) {
      const placementId = this.extractPlacementId()[this.queueIndex];
      this.approvePlacements(placementId, '').subscribe(response => {
        this.queueIndex++;
        if (this.isQueueAvailable()) {
          this.startPlacementApproval();
        } else {
          this.placementApprovalQueue$.next('Placement Approved Successfully');
        }
      });
    }

  }

  startPlacementRejectionInQueue() {
    this.queueIndex = 0;
    this.startPlacementRejection();
  }

  startPlacementRejection() {
    if (this.isQueueAvailable()) {
      const placementId = this.extractPlacementId()[this.queueIndex];
      this.rejectPlacements(placementId, '').subscribe(response => {
        this.queueIndex++;
        if (this.isQueueAvailable()) {
          this.startPlacementRejection();
        } else {
          this.placementApprovalQueue$.next('Placement returned to the worker successfully.');
        }
      });
    }
  }

  getClientSpecificTPRList(servicecaseid :any, spclientid:any) {
    return this._commonService
        .getArrayList(
            new PaginationRequest({
                where: {
                    servicecaseid: servicecaseid ? servicecaseid : null,
                    spclientid: spclientid ? spclientid : null
                },
                method: 'get'
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.TPRDetail + '?filter'
        ).pipe(
        share());
  }

  checkChildRemovalFn(placementDates: any,filterChildRemoval:any) {
    const childRemovalcheck = filterChildRemoval;
    if (childRemovalcheck && childRemovalcheck.length > 1) {
      if(!this.childRemovalcheck(placementDates,childRemovalcheck)){
        return false;
      }
    } else if (childRemovalcheck && childRemovalcheck.length == 1 && childRemovalcheck[0].exitdate) {
      const b = childRemovalcheck[0].exitdate;
      if ((new Date(placementDates.placementStartDt) > new Date(b) || new Date(placementDates.placementEndDt) > new Date(b))) {
        return false;
      }
    }
    else if (childRemovalcheck && childRemovalcheck.length == 1 && !childRemovalcheck[0].exitdate ) {
      const a = childRemovalcheck[0].removaltime;
      if (new Date(placementDates.placementStartDt) < new Date(a)) {
        return false;
      }
    }
    return true;
  }

  private childRemovalcheck(placementDates: any,childRemovalcheck:any) : boolean {
    for (let j = 1; j < childRemovalcheck.length; j++) {
      const a = childRemovalcheck[j].removaltime;
      const b = childRemovalcheck[j - 1].exitdate;
      if ((new Date(placementDates.placementStartDt) > new Date(b) && new Date(placementDates.placementStartDt) < new Date(a)) || (new Date(placementDates.placementEndDt) > new Date(b) && new Date(placementDates.placementEndDt) < new Date(a))) {
        return false;
      }
    }
    return true;
  }

    //Associated with saveReferal function
   formatPlacementDates(referalDetails:any) {
      const placementStartDt = referalDetails.startdate ? this.formatDateTime(referalDetails.startdate, referalDetails.starttime) : null;
      const placementEndDt = referalDetails.enddate ? this.formatDateTime(referalDetails.enddate, referalDetails.endtime) : null;
      return { placementStartDt, placementEndDt };
    }

     //Associated with saveReferal function
  formatDateTime(date:any, time:any) {
    return date && time ? moment(date).format(this.dtformat) + 'T' + time + ':00' : null;
  }
 
}