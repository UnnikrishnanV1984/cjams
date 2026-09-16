
import { share, map } from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { CommonHttpService, DataStoreService } from '../../../../../@core/services';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { Subject, BehaviorSubject } from 'rxjs';

@Injectable()
export class PlacementAdoptionService {
  public storeDataPatched$ = new Subject<any>();
  private subsidyStartDate = new BehaviorSubject<string | null>(null);
  placementAdoptionData: any = {};
  AdoptionPlanningTab = '';
  AdoptionPlanningSaveState = false;
  adoptionplanning: any;
  constructor(
    private _commonHttp: CommonHttpService,
    private _dataStoreService: DataStoreService,
  ) { }

  setAdoptionPlanning(data: any) {
    this.adoptionplanning = data;
  }

  subsidyStartDate$ = this.subsidyStartDate.asObservable();

  setSubsidyStartDate(date: string) {
    this.subsidyStartDate.next(date);
  }

  getAdoptionPlanning() {
    return Object.assign({}, this.adoptionplanning);
  }

  getplacementAdoptionData(dataName: any) {
    return (this.placementAdoptionData && this.placementAdoptionData[dataName]) ? this.placementAdoptionData[dataName] : null;
  }

  setplacementAdoptionData(dataName: any, dataValue: any) {
    this.placementAdoptionData[dataName] = (dataValue) ? dataValue : null;
  }

  setAdoptionPlanningData(url: any, saveState: any) {
    this.AdoptionPlanningTab = url;
    this.AdoptionPlanningSaveState = saveState;
  }

  broadStoreDataPatched(data: any) {

    this.storeDataPatched$.next(data);
  }

  getPlacementConfig(pageNumber: any, limit: any, permanencyplanid: any) {
    return  this._commonHttp
      .getArrayList(
        new PaginationRequest({
          page: pageNumber,
          limit: limit,
          method: 'get',
          where: {
            permanencyplanid: permanencyplanid
          },
        }),
        'permanencyplan/getpermanencyplacement?filter'
        // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
      ).pipe(map((res) => {
        return res;
    }),
    share(),);

  }

  getPermanencyPlanId(pageNumber: any, limit: any, transkey: any, transid: any) {
    return  this._commonHttp
      .getArrayList(
        new PaginationRequest({
          page: pageNumber,
          limit: limit,
          method: 'get',
          where: {
            transkey: transkey  , transid: transid
          },
        }),
        'permanencyplan/getpermanencyplacement?filter'
        // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
      ).pipe(map((res) => {
        return res;
    }),
    share(),);

  }

   getRecommendedList(id: any, permanencyPlanId: any) {
    return this._commonHttp
        .getSingle(
            new PaginationRequest({
                where: {
                    servicecaseid: id,
                permanencyplanid: (permanencyPlanId) ? permanencyPlanId : this.adoptionplanning.permanencyplanid
                },
                method: 'get'
            }),
        'tprrecommendation/gettprrecommendation' + '?filter'
        ).pipe(share());
  }

  getRecommendedListByPerson(id: any, permanencyPlanId: any, personid: any) {
    return this._commonHttp
        .getSingle(
            new PaginationRequest({
                where: {
                    servicecaseid: id,
                    permanencyplanid: (permanencyPlanId) ? permanencyPlanId : this.adoptionplanning.permanencyplanid,
                    personid: personid
                },
                method: 'get'
            }),
        'tprrecommendation/gettprrecommendationbyperson' + '?filter'
        ).pipe(share());
  }

   getAdoptionChecklist(adoptionplanningid: any) {
    return this._commonHttp
        .getArrayList(
            new PaginationRequest({
                where: { adoptionplanningid: adoptionplanningid ? adoptionplanningid : null },
                method: 'get'
            }),
            'adoptionchecklist/getadoptionchecklist?filter'
        ).pipe(
        share());
  }

  getAgreementListing(adoptionplanningid: any) {


    return this._commonHttp
      .getSingle(
        new PaginationRequest({
          where: {
            adoptionplanningid: adoptionplanningid

          },
          method: 'get',
          page: 1,
          limit: 10
        }),
        'adoptionagreement/list' + '?filter'
      ).pipe(share());

  }

  getReasonTypeDropDown(referencetypeid: any, teamtypekey: any) {

    return this._commonHttp
        .getArrayList(
            {
                where: { referencetypeid: referencetypeid, teamtypekey: teamtypekey },
                method: 'get'
            },
            'referencetype/gettypes' + '?filter'
        ).pipe(share());
  }

  getLegalCustody(personId: any) {
  return this._commonHttp
        .getArrayList({ method: 'get', where: { personid: personId } },
        'legalcustody/getlegalcustody' + '?filter').pipe(
        share());
  }

  getTPRListForUnknownParent(servicecaseid: any, spclientid: any){
    return this._commonHttp
        .getArrayList(
            new PaginationRequest({
                where: {
                    servicecaseid: servicecaseid ? servicecaseid : null,
                    spclientid: spclientid ? spclientid : null,
                    includeunknownparent: 'yes'
                },
                method: 'get'
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.TPRDetail + '?filter'
        ).pipe(
        share());
  }

  getTPRList(servicecaseid: any) {
    return this._commonHttp
        .getArrayList(
            new PaginationRequest({
                where: {
                    servicecaseid: servicecaseid ? servicecaseid : null
                },
                method: 'get'
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.TPRDetail + '?filter'
        ).pipe(
        share());
}

getClientSpecificTPRList(servicecaseid: any, spclientid: any) {
  return this._commonHttp
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

getEffortListing(permanencyplanid: any) {
  return this._commonHttp
      .getSingle(
          new PaginationRequest({
              where: {
                   permanencyplanid: permanencyplanid
              },
              method: 'get',
              page : 1,
              limit: 10
          }),
          CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.AdoptionEffortList + '?filter'
      ).pipe(
      share());
}

getNarrative(permanencyplanid: any) {
  return this._commonHttp
      .getSingle(
          new PaginationRequest({
              where: {
                  permanencyplanid: permanencyplanid
              },
              method: 'get'
          }),
          CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.AdoptionEffortList + '?filter'
      ).pipe(
      share());
}

  createadoptioncase(reqObj: any) {
    return this._commonHttp.create(reqObj, 'adoptioncase/createadoptioncase');
  }

  setTabAccess(accessStatus: any) {
    this.setplacementAdoptionData('isRecommended', accessStatus);
  }

  getBreaklink(adoptionplanningid: any) {
    return this._commonHttp
        .getArrayList({ method: 'get', where: {
           adoptionplanningid: adoptionplanningid
          }}, 'adoptionbreakthelink/getadoptionbreakthelink?filter').pipe(
          share());
        // .subscribe(res => {
        //     if (res && res.length) {
        //         res.map((item) => {
        //           if(item && item.getadoptionbreakthelink) {
        //            item.getadoptionbreakthelink.map((breaklink) => {

        //           })
        //         }
        //       })
        //         }
        //       });
            }

   }