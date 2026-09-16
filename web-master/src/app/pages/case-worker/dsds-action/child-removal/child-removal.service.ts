
import { map } from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { CommonHttpService, DataStoreService, AuthService, SessionStorageService, CommonDropdownsService } from '../../../../@core/services';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { forkJoin, Subject } from 'rxjs';
import { PersonDisabilityService } from '../../../shared-pages/person-disability/person-disability.service';
const UNSAFE = 0;
import _ from 'lodash';

@Injectable()
export class ChildRemovalService {

  intakeserviceid!: string;
  daNumber!: string;
  personList: any[] = [];
  childList: any[] = [];
  teamTypeKey: string;
  CHILD_CATEGORIES = ['CHILD', 'BIOCHILD', 'NVC', 'OTHERCHILD', 'PAC', 'RC', 'AV'];
  removedChildren: any[] = [];
  public childRemoval$ = new Subject<any>();
  public childRemovalInfo$ = new Subject<any>();
  public removalConfig$ = new Subject<any>();
  public removalDisabilityConfig$ = new Subject<any>();
  childRemovalInfo: any[] = [];
  placementList: any[] = [];


  // dropdown list
  removalReason: any[] = []; sendTo: any[] = []; familyStructure: any[] = []; childRemoval: any[] = [];
  exitCaseReasons: any[] = []; reasonableEfforts: any[] = []; reasonableEffortsNotMade: any[] = [];
  disabilityTypes: any[] = []; disabilityConditions: any[] = []; removalEndReasons: any[] = [];
  transferagencies: any[] = []; locationofadoptions: any[] = []; environmentAtRemovalList: any[] = [];
  orderbystr = 'description asc';
  childremovalapproved = 'Child Removal Approved';
  childremovalrejected = 'Child Removal Rejected';
  removalCircumstances: any;
  constructor(private _commonService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService,
    private _authService: AuthService,
    private _personDisabilityService: PersonDisabilityService,
    private _session: SessionStorageService,
    private _commonDDService: CommonDropdownsService) {
    this.teamTypeKey = this._authService.getAgencyName();
  }

  getPersonsList() {

    return this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 100,
          nolimit: true,
          method: 'get',
          where: this.getRequestParam()
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
      );
  }

  getAssessments() {
    return this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 100,
          nolimit: true,
          where: this.getRequestParamAssessment(),
          method: 'get'
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.ListAssessment + '?filter'
      );
  }
  getAssessmentsInvolvedPersons() {
    return this._commonService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          where: this.getRequestParam(),
          method: 'get'
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
      );
  }
  getAssessmentsRoutingInfo() {
    return this._commonService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          where: this.getRequestParam(),
          method: 'get'
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.RoutingInfoList
      );
  }

  loadPersonList(persons: any) {
    this.personList = persons;
    this.loadPersonDisabilities();
  }

  loadPersonDisabilities() {
    this.personList.forEach(person => {
      person.hasDisability = null;
      this._personDisabilityService.getDisabilityList(person.personid).subscribe(response => {
        if (response && Array.isArray(response) && response.length) {
          person.personDisabilities = response;
          person.hasDisability = true;
        } else {
          person.personDisabilities = [];
          person.hasDisability = false;
        }

      });
    });
  }

  loadChildRemoval(info: any) {
    this.childRemovalInfo = info;
  }

  getCareGiverList() {
    return this.personList.filter(person => {
      const houseHold = (person.ishousehold);
      let isChild = false;
      let isParent = false;
      if (person.roles && person.roles.length) {
        person.roles.forEach((role: { intakeservicerequestpersontypekey: string; }) => {
          const childCategory = this.CHILD_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
          if (role.intakeservicerequestpersontypekey === 'PARENT') {
            isParent = true;
          }

          if (childCategory) {
            isChild = true;
          }
        });
      }
      return houseHold && (!isChild || isParent);
    });
  }

  getChildList() {
    this.childList = this.personList.filter(child => {
      let childFound = false;
      if (child.roles && child.roles.length) {
        child.roles.forEach((role: { intakeservicerequestpersontypekey: string; }) => {
          const childCategory = this.CHILD_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
          if (childCategory) {
            childFound = true;
          }
        });
      }
      return childFound;
    });

    return this.childList;
  }

  getLegalGuardianList() {
    return this.personList.filter(item => {
      const roles = (item.roles && item.roles.length) ? item.roles : [];
      const lg = roles.some((ele: { intakeservicerequestpersontypekey: string; }) => ele.intakeservicerequestpersontypekey === 'LG');
      if (lg) {
        return true;
      } else {
        return false;
      }
    });
  }

  loadDropDownList() {
    forkJoin([
      this._commonService.getArrayList(
        {
          method: 'get',
          order: this.orderbystr
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
          .GetRemovalReason + '?filter'
      ),
      this._commonService.getArrayList(
        {
          where: { agencycategorykey: 'CHDC', order: this.orderbystr },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetSentTo +
        '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '28', 'delete_sw': 'N' }
        },
        'tb_picklist_values/getpicklist' + '?filter'
      ),
      this._commonService.getArrayList(
        {
          where: { referencetypeid: '53', teamtypekey: null, order: this.orderbystr },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes +
        '?filter'
      ),
      this._commonService.getArrayList(
        {
          where: { referencetypeid: '5470', teamtypekey: null, order: this.orderbystr },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes +
        '?filter'
      ),
      this._commonService.getArrayList(
        {
          where: { referencetypeid: '68', teamtypekey: this.teamTypeKey, order: this.orderbystr },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes +
        '?filter'
      ),
      this._commonService.getArrayList(
        {
          where: { referencetypeid: '69', teamtypekey: this.teamTypeKey, order: this.orderbystr, nolimit: true },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes +
        '?filter'
      ),
      this._commonService.getArrayList(
        {
          where: { referencetypeid: '70', teamtypekey: this.teamTypeKey },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes +
        '?filter'
      ),
      this._commonService.getArrayList(
        {
          where: { referencetypeid: '97', teamtypekey: this.teamTypeKey },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes +
        '?filter'
      ),
      this._commonService.getArrayList(
        {
          where: { referencetypeid: '70', teamtypekey: this.teamTypeKey },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes +
        '?filter'
      ),
      this._commonService.getArrayList(
        {
          where: { referencetypeid: '343', teamtypekey: this.teamTypeKey },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetAllTypesList +
        '?filter'
      ),
      this._commonService.getArrayList(
        {
          where: { referencetypeid: '350', teamtypekey: this.teamTypeKey },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetAllTypesList +
        '?filter'
      ),
      this._commonService.getArrayList(
        {
          where: { referencetypeid: '351', teamtypekey: this.teamTypeKey },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetAllTypesList +
        '?filter'
      ),
      this._commonService.getArrayList(
        {
          where: { referencetypeid: '1200', teamtypekey: this.teamTypeKey, order: this.orderbystr, nolimit: true },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes +
        '?filter'
      ),
    ])
      .subscribe(([removalReason, sendTo, familyStructure, childRemoval, environmentAtRemoval,
        exitCaseReasons, reasonableEfforts, reasonableEffortsNotMade, disabilityTypes, disabilityConditions,
        removalEndReasons, transferagencies, locationofadoptions, removalCircumstances]) => {
        this.removalReason = removalReason;
        this.sendTo = sendTo;
        this.familyStructure = familyStructure;
        this.environmentAtRemovalList = environmentAtRemoval;
        this.childRemoval = childRemoval;
        this.exitCaseReasons = exitCaseReasons;
        this.reasonableEfforts = reasonableEfforts;
        this.reasonableEffortsNotMade = reasonableEffortsNotMade;
        if (disabilityTypes && Array.isArray(disabilityTypes)) {
          this.disabilityTypes = disabilityTypes;
        }
        this.disabilityConditions = disabilityConditions;
        this.removalEndReasons = removalEndReasons;
        this.transferagencies = transferagencies;
        this.locationofadoptions = locationofadoptions;
        this.removalCircumstances = removalCircumstances;
        this.removalConfig$.next('loaded');


      });
  }

  getRemovedChildren() {
    return this.childList.filter(child => child.isRemoved);
  }

  getReviewChildrenForSupervisor() {
    const selectedremovalid = this._session.getItem(CASE_STORE_CONSTANTS.CHILDREMOVAL_ID);
    const reviewInfo = this.childList.find(person => person.intakeservreqchildremovalid === selectedremovalid);
    return reviewInfo ? [reviewInfo] : [];
  }

  childselection(removedChild: any, isRemoved: any) {
    let ischilselected = true;
    const foundChild = this.childList.find(child => {
      return child.isRemoved &&
        child.personid !== removedChild.personid &&
        child.intakeservreqchildremovalid !== undefined &&
        child.intakeservreqchildremovalid !== null &&
        isRemoved
    });

    if (foundChild) {
      isRemoved = false;
      ischilselected = false;

    }
    return ischilselected;
  }

  removeChild(removedChild: any, isRemoved: any) {
    this.childList.find(child => {    //  NOSONAR   // This function required re-evalution
      if (child.personid === removedChild.personid) {
        child.isRemoved = isRemoved;
        return true;
      } else {
        return false;
      }
    });
    this.childRemoval$.next(removedChild);
  }

  getAddressPerson(personid: number) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest(
          {
            method: 'get',
            where: { personid: personid },
            page: 1, // this.paginationInfo.pageNumber,
            limit: 10// this.paginationInfo.pageSize,
          }),
        CommonUrlConfig.EndPoint.PERSON.ADDRESS.ListAddressUrl + '?filter'
      );
  }

  sendForApproval(childRemovalFormData: any) {
    return this._commonService
      .create(childRemovalFormData, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.SubmitChildRemoval);
  }
  approveChildRemoval(childRemovalId: any) {
    const bintiInfoPayload = childRemovalId?.bintiinfo ?? childRemovalId?.bintiInfo;

    let data;
    if (this.isServiceCase()) {
      data = {
        'objectid': childRemovalId?.removalID || childRemovalId,
        'eventcode': 'CHRR',
        'status': 'Approved',
        'comments': this.childremovalapproved,
        'notifymsg': this.childremovalapproved,
        'routeddescription': this.childremovalapproved,
        'servicecaseid': this.intakeserviceid,
        ...(bintiInfoPayload ? { bintiinfo: bintiInfoPayload } : {})
      };
    } else {
      data = {
        'objectid': childRemovalId?.removalID || childRemovalId,
        'eventcode': 'CHRR',
        'status': 'Approved',
        'comments': this.childremovalapproved,
        'notifymsg': this.childremovalapproved,
        'routeddescription': this.childremovalapproved,
        intakeserviceid: this.intakeserviceid,
        ...(bintiInfoPayload ? { bintiinfo: bintiInfoPayload } : {})
      };
    }

    return this._commonService
      .create(data, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.approveOrReject);
  }

  rejectChildRemoval(childRemovalId: any) {
    const data = {
      'objectid': childRemovalId,
      'eventcode': 'CHRR',
      'status': 'Rejected',
      'comments': this.childremovalrejected,
      'notifymsg': this.childremovalrejected,
      'routeddescription': this.childremovalrejected
    };
    return this._commonService
      .create(data, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.approveOrReject);
  }


  getChildRemoval(groupByPerson: number = 0, personId?: string) {
    const isExpungementSuperUser = this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    const requestData = !!personId ? this.getChildRemovalRequestParam(personId) : { ...this.getRequestParam(), ...{ isgroup: groupByPerson } };
    return this._commonService
      .getSingle(
        {
          where: { ...requestData, isExpungementSuperUser, iscaseexpunged: iscaseexpunged },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
          .GetChildRemovalList + '?filter'
      );
  }

  getPlacementInfoList() {
    return this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: { servicecaseid: this._commonDDService.getStoredCaseUuid() },
        }),
        'placement/getplacementbyservicecase?filter'
      );
  }

  getPersonsAndChildRemovalInfo() {
    return forkJoin([this.getPersonsList(),
    this.getChildRemoval(),
    this.getPlacementInfoList()]).pipe(
      map(([persons, childRemoval, placmentList]) => {
        let personList: any[] = [];
        let childRemovalInfo: any[] = [];
        if (persons && persons.data) {
          personList = persons.data;
        }
        if (childRemoval) {
          childRemovalInfo = childRemoval;
        }

        if (placmentList && placmentList.data && Array.isArray(placmentList.data)) {
          this.placementList = placmentList.data;
        }
        this.loadPersonList(personList);
        this.loadChildRemoval(childRemovalInfo);
        this.updatePersonListWithChildRemoval();
        this.getChildList();
        this.childList.forEach(item => {
          if (item.removalHistory && item.removalHistory.length > 0) {
            item.removalHistory = item.removalHistory.sort((remove1: any, remove2: any) => { return new Date(remove2.removaldate).getTimezoneOffset() - new Date(remove1.removaldate).getTimezoneOffset() });
          }
        });


        return { persons: personList, childRemovalInfo: childRemovalInfo };
      }));
  }

  updatePersonListWithChildRemoval() {
    this.intakeserviceid = this._commonDDService.getStoredCaseUuid();
    if (this.childRemovalInfo && this.childRemovalInfo.length) {
      this.childRemovalInfo = _.orderBy(this.childRemovalInfo, ['removalid'], ['asc']);
      this.childRemovalInfo.forEach(removalInfo => {
        this.personList.forEach(person => {
          if (person.personid === removalInfo.personid) {
            this.updatePerson(person, removalInfo);
          }
        });
      });

    }
  }

  updatePerson(person: any, removalInfo: any) {
    person.removalStatus = this.getRemovalStatus(removalInfo);
    person.intakeservreqchildremovalid = removalInfo.intakeservreqchildremovalid;
    if (removalInfo.exitdate && person.removalStatus === 'Approved') {
      person.removalStatus = null;
      person.intakeservreqchildremovalid = null;
      person.enableNewRemoval = true;
    }

    if (this.isServiceCase()) {
      if (!removalInfo.exitdate && person.removalStatus === 'Approved') {
        person.enableEndRemoval = true;
      } else if (removalInfo.exitdate && person.removalStatus === 'Review') {
        person.enableEndRemoval = true;
      } else {
        person.enableEndRemoval = false;
      }
    } else {
      person.enableEndRemoval = false;
      if (!removalInfo.exitdate && person.removalStatus === 'Approved') {
        person.viewOnly = true;
      }
    }
    person.removalInfo = removalInfo;
    person.placementList = this.getPlacementList(person);
    person.removalHistory = JSON.parse(JSON.stringify(this.childRemovalInfo.filter(removalHistory => removalHistory.personid === person.personid)));
    person.removalHistory = _.orderBy(person.removalHistory, ['removalid'], ['desc']);
    person.hasHistory = this.getHasHistory(person);
    return person;
  }
  getRemovalStatus(removalInfo: any) {
    return removalInfo.approvalstatus ? removalInfo.approvalstatus : 'Draft';
  }

  getPlacementList(person: any) {
    return this.placementList ? this.placementList.filter(placement => placement.personid === person.personid) : null;
  }
  getHasHistory(person: any) {
    return person.removalHistory.length ? true : false;
  }

  showChildRemovalInformation(childRemovalId: any, type: any) {
    this.childList.forEach(child => {
      child.editType = type;
      if (child.intakeservreqchildremovalid === childRemovalId && ['Draft', 'Approved', 'Review', 'Rejected'].includes(child.removalStatus)) {
        child.isRemoved = true;
      } else {
        child.isRemoved = false;
      }
    });
    const removedChildren = this.childList.filter(child => child.intakeservreqchildremovalid === childRemovalId);
    this.childRemovalInfo$.next(removedChildren);
  }

  showChildRemovalHistoryInfo(selectedChild: any, removalInfo: any, isViewOrNot: any) {
    const child = selectedChild;
    child.removalInfo = removalInfo;
    if (removalInfo.exitdate) {
      child.enableEndRemoval = true;
    } else {
      child.enableEndRemoval = false;
    }
    child.viewOnly = true;
    child.isViewOrNot = isViewOrNot;
    child.intakeChildRemovalid = removalInfo.intakeservreqchildremovalid;
    this.childRemovalInfo$.next([JSON.parse(JSON.stringify(child))]);
  }

  serviceCaseCreatOrMerge(serviceCaseId: any, isNewCase: any) {
    return this._commonService
      .create(
        {
          servicecaseid: serviceCaseId,
          intakeserviceid: this.intakeserviceid,
          isnewcase: isNewCase,
          subtypekey: 'ohm'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
          .CreateCaseUrl
      );
  }

  serviceCaseCreateOrCheckIsExist() {
    return this._commonService
      .getSingle(
        {
          where: {
            intakeserviceid: this.intakeserviceid,
            subtypekey: 'ohm'
          },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
          .ServiceCaseValidate + '?filter'
      );
  }

  getRequestParam() {

    this.intakeserviceid = this._commonDDService.getStoredCaseUuid();
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    let requestData;
    if (this.isServiceCase()) {
      requestData = {
        objectid: this.intakeserviceid,
        objecttypekey: 'servicecase'
      };

    } else {
      requestData = { intakeserviceid: this.intakeserviceid };
    }
    return requestData;
  }

  getChildRemovalRequestParam(personId: string) {
    return {
      objectid: personId,
      objecttypekey: 'personid'
    };
  }

  getRequestParamAssessment() {

    this.intakeserviceid = this._commonDDService.getStoredCaseUuid();
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    let requestData;
    if (this.isServiceCase()) {
      requestData = {
        objectid: this.intakeserviceid,
        objecttypekey: 'servicecase'
      };

    } else {
      const isExpungementSuperUser = this._authService.isExpungementSuperUser();
      const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
      requestData = {
        servicerequestid: this.intakeserviceid,
        isExpungementSuperUser: isExpungementSuperUser,
        iscaseexpunged: iscaseexpunged
      };
    }
    return requestData;
  }

  isServiceCase() {
    const isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    if (isServiceCase) {
      return true;
    } else {
      return false;
    }
  }



}