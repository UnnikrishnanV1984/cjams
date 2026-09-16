
import {map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { CommonHttpService, DataStoreService, AuthService, SessionStorageService } from '../../../../@core/services';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { forkJoin ,  Subject } from 'rxjs';
import moment from 'moment';
const UNSAFE = 0;
@Injectable()
export class CasePlanService {
  intakeserviceid!: string;
  daNumber!: string;
  personList: any[] = [];
  parent: any[] = [];
  childList: any[] = [];
  teamTypeKey: string;
  CHILD_CATEGORIES = ['CHILD', 'BIOCHILD', 'NVC', 'OTHERCHILD', 'PAC', 'RC', 'AV'];
  PARENT1_CATEGORIES = ['BGMTHR'];
  PARENT2_CATEGORIES = ['BGFTHR'];
  removedChildren: any[] = [];
  public childRemoval$ = new Subject<any>();
  public childRemovalInfo$ = new Subject<any>();
  public removalConfig$ = new Subject<any>();
  childRemovalInfo: any[] = [];
  loggermsg = 'process person list';
  dtformat = 'YYYY-MM-DD';

  constructor(private _commonService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService,
    private _authService: AuthService,
    // private _personDisabilityService: PersonDisabilityService,
    private _session: SessionStorageService) {
    this.teamTypeKey = this._authService.getAgencyName();
  }

  getPersonsAndChildRemovalInfo() {
    return forkJoin([this.getPersonsList(), this.getChildRemoval()]).pipe(
      map(([persons, childRemoval]) => {
        let personList = [];
        let childRemovalInfo = [];
        if (persons && persons.data) {
          personList = persons.data;
        }
        if (childRemoval) {
          childRemovalInfo = childRemoval.filter((item: { exitdate: null; }) => item.exitdate === null);
        }
        this.loadPersonList(personList);
        this.loadChildRemoval(childRemovalInfo);
        this.updatePersonListWithChildRemoval();



        return { persons: personList, childRemovalInfo: childRemovalInfo };
      }));
  }

  loadPersonList(persons: any) {
    this.personList = persons;
  }

  loadRaceDropDown() {

    return this._commonService
    .getSingle(
      {

        where: { activeflag: '1' },
        method: 'get',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.RaceTypeUrl + '?filter'
    );

  }

  getParent(ParentRole: any) {
    this.parent = this.personList.filter(parent =>
  parent.relationship === ParentRole
  ) ;
      // parent.roles.forEach(role => {
      //   const parentCategory = ParentRole.find(category => category === role.intakeservicerequestpersontypekey);
      //   if (parentCategory) {
      //     parentFound = true;
      //     return;
      //   }
      // });
      // return childFound; // removing unsafe child validation for 11/3 demo
    //   return parentFound; //  comment if unsafe child only needs to remove
    // });

    return this.parent;
  }

  getParentList() {
    this.parent = this.personList.filter(parent => {
      const roleList = Array.isArray(parent.roles) ? parent.roles : [];
      return roleList.some((item: { intakeservicerequestpersontypekey: string; }) => item.intakeservicerequestpersontypekey === 'PARENT');
    });
    return this.parent;
  }

  getChildList() {
    this.childList = this.personList.filter(child => {
      let childFound = false;
      if (child.roles) {
        child.roles.forEach((role: { intakeservicerequestpersontypekey: string; }) => {
          const childCategory = this.CHILD_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
          if (childCategory) {
            childFound = true;
          }
        });
      }
      return childFound && (child.issafe === UNSAFE || this.isServiceCase()); //  comment if unsafe child only needs to remove
    });

    return this.childList;
  }

  loadChildRemoval(info: any) {
    this.childRemovalInfo = info;
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
        // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
      );
  }

  getChildRemoval(groupByPerson: number = 0) {
    const requestData = { ...this.getRequestParam(), ...{ isgroup: groupByPerson } };
    return this._commonService
      .getSingle(
        {
          where: requestData,
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
          .GetChildRemovalList + '?filter'
      );
  }

  isServiceCase() {
    const isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    if (isServiceCase) {
      return true;
    } else {
      return false;
    }
  }

  inRange(date: any, version: any) {
    return new Date(date).setHours(0,0,0,0) >= new Date(version.fromdate).setHours(0,0,0,0) && 
    (
      version.todate == null || version.todate == undefined ||
      new Date(date).setHours(0,0,0,0) <= new Date(version.todate).setHours(0,0,0,0)
    );
  }

  inBetweenRange(insertDt: any, completeDt: any, version: any){
    const versionToDt = moment(moment(version.todate).format(this.dtformat)); 
    const versionFromDt = moment(moment(version.fromdate).format(this.dtformat)); 
    insertDt = moment(moment(insertDt).format(this.dtformat));
    completeDt = moment(moment(completeDt).format(this.dtformat));
    let isValid = false;
    const isVersionFromDtSame = versionFromDt.isSame(insertDt) || versionFromDt.isSame(completeDt);
    const isVersionToDtSame = versionToDt.isSame(insertDt) || versionToDt.isSame(completeDt);

    isValid = insertDt.isBetween(versionFromDt, versionToDt) || completeDt.isBetween(versionFromDt, versionToDt) || isVersionFromDtSame || isVersionToDtSame
    
    return isValid;
  }

  getRequestParam() {

    this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
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

  getAssessMents(tempId: any) {
   {
     // e.g tempId : 'SAFE-C'
    return this._commonService
    .getSingle(
      {

        limit: 10,
        order: 'desc',
        page: 1,
        count: -1,
        where: { 'objectid' : this.intakeserviceid,
        // this.intakeserviceid,
         templatename : tempId } ,
        method: 'get'
      },
      'serviceplanchild/getAssessment?filter'
    );
  }
 }

  getassessment() {
    const isExpungementSuperUser = this._authService.isExpungementSuperUser();
    let iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    let inputRequest: Object;
        if (this.isServiceCase()) {
            inputRequest = {
                objecttypekey: 'servicecase',
                objectid: this.intakeserviceid
                // objectid: '1ab13583-6d94-4929-92e0-09723df839f3'
            };
        } else {
            inputRequest = {
                servicerequestid: this.intakeserviceid,
                categoryid: null,
                subcategoryid: null,
                targetid: null,
                assessmentstatus: null,
                isExpungementSuperUser: isExpungementSuperUser,
                iscaseexpunged: iscaseexpunged
            };
        }
        return this._commonService
        .getPagedArrayList(
            new PaginationRequest({
                page: 1,
                limit: 25,
                where: inputRequest,
                method: 'get'
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.ListAssessment + '?filter'
        );
  }

  updatePersonListWithChildRemoval() {
    if (this.childRemovalInfo && this.childRemovalInfo.length) {
      this.childRemovalInfo.forEach(removalInfo => {
        this.updateRemovalInfo(removalInfo);
      });

    }
  }
  updateRemovalInfo(removalInfo: any) {
    this.personList.forEach(person => {
      if (person.personid === removalInfo.personid) {
        if (person.removalInfo == undefined || person.removalInfo == null || moment(person.removaldate).isBefore(moment(removalInfo.removalDate))) {
          person.removalStatus = removalInfo.approvalstatus ? removalInfo.approvalstatus : 'Draft';
          person.intakeservreqchildremovalid = removalInfo.intakeservreqchildremovalid;
          person.removalInfo = removalInfo;
        }
      }
    });
  }

  getSocialHistory(personid: any) {
    return this._commonService
    .getArrayList(
      new PaginationRequest({
        page: 1,
        limit: 10,
        count: -1,
        method: 'get',
        where: { 'personid_fk' : personid },
        order: 'insertedon desc'
      }),
      'socialhistory/getlist?filter'
    );
  }

  searchCase(caseId: any, caseType: any, url: any) {
    return this._commonService
    .getSingle(
      {

        limit: 10,
        order: 'desc',
        page: 1,
        count: -1,
        where: { servicerequestnumber : caseId, actiontype : caseType } ,
        method: 'get'
      },
      url
    );
  }

  getCaseReview(caseid: any) {
    return this._commonHttpService.getArrayList(
      {
        where: {
          caseid: caseid
        },
        method: 'get',
        nolimit: true
    },
    'casereview/fetchCasereviewbycaseid?filter');
  }

  getCasePersonsList(){
    return this.personList;
  }

  getVendorLog(cjamspid: any){
    return this._commonHttpService.getArrayList(
      {
          where: {
              daNumber: this.daNumber, 
              clientid: cjamspid, 
              service_log_id: null,
              incaseplan: true,
              sortcolumn: 'actual_start_date', 
              sortorder: 'desc'
          },
          method: 'get'
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.vendorServiceLog + '?filter'
    );
  }

  getAgencyLog(cjamspid: any){
    return this._commonHttpService.getArrayList(
      {
        where: { 
          daNumber: this.daNumber, 
          client_id: cjamspid,
          incaseplan: true,
          sortcolumn: 'actual_begin_date', 
          sortorder: 'desc' 
        },
        method: 'get',
        nolimit: true
      },

      CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.agencyServiceLog + '?filter'

    )
  }

  getRecommendation(casereviewid: any) {
    return this._commonHttpService.getArrayList(
      {
        where: {
          casereviewid: casereviewid
        },
        method: 'get',
        nolimit: true
    },
    'Reviewrecommendations/fetchrecommendationsbycasereviewid?filter');
  }

  getReviewType() {
    return this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true
    },
    'Reviewrecommendations/getReviewtypeList?filter');
  }

  saveCaseReview() {
    return this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true
    },
    'http://localhost:3000/api/casereview/addupdate?filter');
  }
  assignUser(payload: any){
   return this._commonHttpService.create(
      payload,
    'caseplan/caseplanrouting'
  );
  }
  updateSnapshot(payload: any){
    return this._commonHttpService.patch(
      payload.id,
      payload,
      'snapshothist'
    );
  }
  getRelationshipOfPerson(personid: string) {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    let iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 30,
          method: 'get',
          where:  {objectid: caseID, objecttypekey: 'servicecase', personid : personid, 'isExpungementSuperUser': isExpungementSuperUser, 'iscaseexpunged': iscaseexpunged}
        }),
        'People/getallpersonrelationbyprovidedpersonid?filter'
      );
  }


  getCasePlanLegacyInfo(caseid: any, personid: any) {
    return this._commonHttpService.getArrayList(
      {
        where: {
          caseid: caseid,
		      personid: personid
        },
        method: 'get',
        nolimit: true
    },
    'caseplanlegacy/getcaseplanlegacy?filter');
  }

  getRoutingUsers(){
    return this._commonHttpService
      .getPagedArrayList(
          new PaginationRequest({
              where: { appevent:  'SPLAN' },
              method: 'post'
          }),
          'Intakedastagings/getroutingusers'
      );
  }
  
  getHist(personid: any) {
    const caseid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    return this._commonHttpService.getArrayList(
      new PaginationRequest({
        page: 1,
        limit: 20,
        method: 'get',
        order: 'insertedon desc',
        where: {
         objectid: caseid,
         objecttype: 'CPLAN2',
        //  objecttype: 'CPLANALL',
         personid: personid
         }
      }),
      'snapshothist' + '?filter'
    );
  }


  getHistoryForServicePlan(personid: any) {
    const caseid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    return this._commonHttpService.getArrayList(
      new PaginationRequest({
        method: 'post',
        where: {
         objectid: caseid,
         objecttype: 'SPLAN'
         }
      }),
      'Serviceplan/getserviceloghistory'
    )
  }


  genCasePlan(payload: any){
    return this._commonHttpService.getArrayList(
      payload,
      'caseplan/generatecaseplansnapshot');
  }
  getPdfBlob(payload: any, url: any, otherParams: any=null){
    return this._commonHttpService.download(url, payload);
  }

}
