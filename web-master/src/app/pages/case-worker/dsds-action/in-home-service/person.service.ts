import { Injectable } from '@angular/core';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../@core/services';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { forkJoin } from 'rxjs';
const UNSAFE = 0;

@Injectable()
export class PersonService {

  intakeserviceid!: string;
  daNumber!: string;
  personList: any[] = [];
  teamTypeKey: string;
  involvedPersons: any;
  results!: Object;
  displayorder = 'displayorder ASC';
  referencevaluesurl = 'referencevalues?filter';

  constructor(private _commonService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService,
    private _authService: AuthService    ) {
    this.teamTypeKey = this._authService.getAgencyName();
  }

  getPersonsList() {
    this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    return this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: { 
            objectid: this.intakeserviceid,
            objecttypekey: 'servicecase'
          }
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
      );
  }


  loadProgressReviewDropdowns() {
      return forkJoin([
          this._commonHttpService.getArrayList(
              {
                nolimit: true,
                where: { referencetypeid: 113 }, order: this.displayorder, method: 'get'
              },
              this.referencevaluesurl
          ),
          this._commonHttpService.getArrayList(
              {
                nolimit: true,
                where: { referencetypeid: 114 }, order: this.displayorder, method: 'get'
              },
              this.referencevaluesurl
          ),
          this._commonHttpService.getArrayList(
              {
                nolimit: true,
                where: { referencetypeid: 115 }, order: this.displayorder, method: 'get'
              },
              this.referencevaluesurl
          ),
          this._commonHttpService.getArrayList(
              {
                nolimit: true,
                where: { referencetypeid: 116 }, order: this.displayorder, method: 'get'
              },
              this.referencevaluesurl
          )
      ]);
  }


  getCaseEvaluationDetails(id: string | number) {
    return this._commonHttpService
      .getArrayList(
        {
          method: 'get',
          page: 1,
          limit: 10,
          where: { caseid: id }
        },
        'caseevaluation/list?filter'
      );
  }


  getServicePlanList(id: string | number) {
    return this._commonService.getArrayList({
      method: 'get',
      nolimit: true,
      where: { objectid: id }
    }, 'serviceplan/goal?filter');
  }


  getAgencyServiceList(id: string | number) {
    return this._commonHttpService.getArrayList(
      {
        where: { daNumber: id },
        method: 'get',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.agencyServiceLog + '?filter');
  }


    
  getAssessments(id: string | number) {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    return this._commonService.getArrayList({
            page: 1,
            limit: 25,
            where: {
              servicerequestid:id,
              assessmentstatus:null,
              isExpungementSuperUser: isExpungementSuperUser,
              iscaseexpunged: iscaseexpunged
            },
            method: 'get'
    }, 'admin/assessment/list?filter');
  }

}
