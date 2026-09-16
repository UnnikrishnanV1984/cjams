
import {map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { CommonHttpService, DataStoreService, AuthService, SessionStorageService } from '../../../../@core/services';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { forkJoin ,  Subject } from 'rxjs';
const UNSAFE = 0;
@Injectable()

export class SocialHistoryService {
  intakeserviceid!: string;
  daNumber!: string;
  personList = [];
  childList = [];
  teamTypeKey: string;
  CHILD_CATEGORIES = ['CHILD', 'BIOCHILD', 'NVC', 'OTHERCHILD', 'PAC', 'RC', 'AV'];
  removedChildren = [];
  public childRemoval$ = new Subject<any>();
  public childRemovalInfo$ = new Subject<any>();
  public removalConfig$ = new Subject<any>();
  childRemovalInfo = [];

  constructor(private _commonService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService,
    private _authService: AuthService,
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
          childRemovalInfo = childRemoval;
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

  getChildList() {
    this.childList = this.personList.filter((child: any) => {
      let childFound = false;
      if (child.roles) {
        child.roles.forEach((role: any) => {
        const childCategory = this.CHILD_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
        if (childCategory) {
          childFound = true;
        }
      });
    }
      return childFound; // removing unsafe child validation for 11/3 demo
      // return childFound && child.issafe === UNSAFE; //  comment if unsafe child only needs to remove
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

  getSocialHistory(personId: any) {
    return this._commonService
    .getArrayList(
      new PaginationRequest({
        page: 1,
        limit: 10,
        count: -1,
        method: 'get',
        where: { 'personid_fk' : personId },
        order: 'insertedon desc'
      }),
      'socialhistory?filter'
    );
  }

  getSocialHistoryList(personId: any) {
    return this._commonService
    .getArrayList(
      new PaginationRequest({
        page: 1,
        limit: 10,
        count: -1,
        method: 'get',
        where: { 'personid_fk' : personId },
        order: 'insertedon desc'
      }),
      'socialhistory/getlist?filter'
    );
  }

  createSocialHistory(personid: any, data: any) {
    this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    return this._commonHttpService.create(
      {
        personid_fk: personid,
        placement: data.placement,
        familyhistory: data.familyhistory,
        childdesc: data.childdesc,
        updatedby: this._authService?.getCurrentUser()?.user?.securityusersid,
        insertedby: this._authService?.getCurrentUser()?.user?.securityusersid
      },
      'socialhistory/'
    );
  }

  patchData(jsondata: any) {
    let payload: any = {};
    payload = jsondata;
    return this._commonHttpService.patch(
      jsondata.socialhistoryid,
      payload,
      'socialhistory'
    );
  }

  // addSocialHistory(data) {
  //   return this._commonService
  //     .create( data, 'caseplan1/addupdate');
  // }

  isServiceCase() {
    const isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    if (isServiceCase) {
      return true;
    } else {
      return false;
    }
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

  updatePersonListWithChildRemoval() {
    if (this.childRemovalInfo && this.childRemovalInfo.length) {
      this.childRemovalInfo.forEach(removalInfo => {
        this.personList.forEach(person => {
          this.returnPersonDataFn(person, removalInfo);
        });
      });
    }
  }
  // Associated with updatePersonListWithChildRemoval function
  private returnPersonDataFn(person: any, removalInfo: any) {
    if (person.personid === removalInfo.personid) {
      if (person.removalStatus !== 'Approved') {
        person.removalStatus = removalInfo.approvalstatus ? removalInfo.approvalstatus : 'Draft';
      }
      person.intakeservreqchildremovalid = removalInfo.intakeservreqchildremovalid;
      person.removalInfo = removalInfo;
    }
  }
}
