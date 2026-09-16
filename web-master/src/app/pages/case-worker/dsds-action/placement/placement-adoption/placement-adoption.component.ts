
import {share, map} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { DynamicObject, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { DataStoreService, SessionStorageService, AuthService, CommonHttpService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { PlacementAdoptionService } from './placement-adoption.service';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { DSDS_STORE_CONSTANTS } from '../../dsds-action.constants';
import { ServiceCasePermanencyPlanService } from '../../service-case-permanency-plan/service-case-permanency-plan.service';
import { PlacementAdoptionResolverService } from './placement-adoption-resolver.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'placement-adoption',
    templateUrl: './placement-adoption.component.html',
    styleUrls: ['./placement-adoption.component.scss'],
    standalone: false
})
export class PlacementAdoptionComponent implements OnInit {
    id!: string;
    daNumber!: string;
    permanencyPlanId!: string;
    private childActorId!: string;
    private store: DynamicObject;
    isSupervisor!: boolean;
    roleId!: AppUser;
    transkey!: string;
    transid!: string;
    showNavScale = true;
    child: any;
    ivestatus!: string;
    ivecomment!: string;
    involvedPersons: any;
    selectedChild: any;
    completedIVEReview = false;
    adoptionSubsidyIsEdited = false;    
    disclosureapprovalStatus: any;
    moduleview: any;

    private _store: DataStoreService;
    private _commonHttp: CommonHttpService;
    private route: ActivatedRoute;
    private _PlacementAdoptionService: PlacementAdoptionService;
    private _serviceCasePermanencyPlanService: ServiceCasePermanencyPlanService;
    private _session: SessionStorageService;
    private _authService: AuthService;
    retrydoc: boolean = false;

    constructor(private readonly injector : Injector, private router: Router, private _dataStoreService: DataStoreService,private placementAdoptionResolverService: PlacementAdoptionResolverService) {
        this._store = this.injector.get<DataStoreService>(DataStoreService);
        this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);
        this._serviceCasePermanencyPlanService = this.injector.get<ServiceCasePermanencyPlanService>(ServiceCasePermanencyPlanService);
        this._session = this.injector.get<SessionStorageService>(SessionStorageService);
        this._authService = this.injector.get<AuthService>(AuthService);

        this.store = this._store.getCurrentStore();
        this.route.data.subscribe(response => {
            if (response && response.hasOwnProperty('tprRecomendation')) {
                this._authService.setAuthDetail('adoptionplanning',response.tprRecomendation.authdetails);
            }
        });
        this.route.queryParams.subscribe(params => {
            if(params['retrydocument'] == 'true') {
              this.retrydoc = true;   
            }
        });
    }

    ngOnInit() {
        // this.placementAdoptionResolverService.getAdoptionplanning().subscribe({
        //     next: (data: any) => {
        //         this._authService.setAuthDetail('adoptionplanning',data.authdetails);
        //     }
        // })
        this.moduleview = this._authService.isModuleAccessable('adoptionplanning', 'adoptionplanning');
        this.roleId = this._authService.getCurrentUser();
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        const caseType = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
        this.showNavScale = (caseType === CASE_TYPE_CONSTANTS.ADOPTION) ? false : true;
        if (this.roleId.role.name === 'apcs' || this.retrydoc) {
             this.transkey = this._session.getItem('transkey');
            this.transid = this._session.getItem('transid');
            this.getChildDetails(true);
            this.id = this.store['CASEUID'];
            this.daNumber = this.store['DANUMBER'];
            this.isSupervisor = true;
            this._session.setItem('transkey', null);
            this._session.setItem('transid', null);
            this._PlacementAdoptionService.setplacementAdoptionData('PermanencyPlanId', this.permanencyPlanId);
        } else {
            this.getChildDetails(false);
        }
        this.validateStoreValues();
        if(this.showNavScale){
            this.getReportedChild();
        }else{
            this.getInvolvedPerson();
        }
    }

    closeIVEPopup(){
        (<any>$('#ivePopUp')).modal('hide');
      }

    private getInvolvedPerson() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        let url = '';

        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        this._commonHttp
            .getArrayList(
                {
                    page: 1,
                    method: 'get',
                    where: {intakeserviceid : this.id ,isExpungementSuperUser:isExpungementSuperUser,'iscaseexpunged':iscaseexpunged}
                },
                url + '?filter'
            )
            .subscribe((res: any) => {
                if (res['data'] && res['data'].length) {
                    this.involvedPersons = [];
                    res['data'].map((item: any) => {
                      const rolename = item.rolename ? item.rolename : '';
                      const child = ['CHILD', 'AV', 'OTHERCHILD', 'RC'].includes(rolename);
                      if(child) {
                          this.involvedPersons.push(item);
                      }
                    });
                }

                if(this.involvedPersons && this.involvedPersons.length) {
                  this.selectedChild = this.involvedPersons[0];
                }
                });
      }


    private getReportedChild() {
        this._commonHttp
            .getSingle(
                {
                    method: 'get',
                    where: {objecttypekey: 'servicecase', objectid: this.id }
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
            )
            .subscribe(res => {
                if (res && res.data) {
                const cjamspid = this._dataStoreService.getData('childforGAP');
                const repChild = res.data.filter((child: { cjamspid: any; }) => child.cjamspid === cjamspid);
                if (repChild && repChild.length) {
                    this._dataStoreService.setData('childremovalid', repChild[0].removalid);
                    this._commonHttp.getSingle(
                        {},
                        'iveadoption/adoption/adoption-aca-worksheet/' +  cjamspid+'/'+ repChild[0].removalid
                        ).subscribe(response => {
                            this.responsecheck(response);
                          });
                }
                 }
            });
    }
    responsecheck(response: any){
        if(response && response.adoptionAcaInfo && response.adoptionAcaInfo.length > 0 
            && response.adoptionAcaInfo[0].ivestatus){
                this.ivestatus = response.adoptionAcaInfo[0].ivestatus;
                this.ivecomment = response.adoptionAcaInfo[0].ivecomment;
            }
        if(this.ivestatus==='APPROVED' || this.ivestatus==='PENDING'){
            this.completedIVEReview = true;
        }
        if(this.ivestatus==='RETURNED'){
            (<any>$('#ivePopUp')).modal('show');}
    }
    validateStoreValues() {
        if(!this.store['placement_child']) {
            this.store['placement_child'] = this._session.getObj('placement_child');
        }
        if(!this.store['placed_child']) {
            this.store['placed_child'] = this._session.getObj('placed_child');
            if(!this.child) {
                this.child = this.store['placed_child'];
            }
        }
        if (this.store['placement_child']) {
            this.checkIfplacementchildFn();
        } else  {
            this.checkElsePlacementchildFn();
        } 
        // else {
        //     this.goBack();
        // }

    }
    // Assosiated with validateStoreValues function
    private checkIfplacementchildFn() {
        this.childActorId = this.store['placement_child'].intakeservicerequestactorid;
        this.permanencyPlanId = this.store['placement_child'].permanencyplanid;
        this.id = this.store['CASEUID'];
        this.getRecommendedList();
        if (this.childActorId) {
            this.getLegalCustody(this.childActorId);
        }
        const spclientid = this.store['placed_child'] ? this.store['placed_child'].personid : this.returnSpclientidFn();
        if (spclientid) {
            this.getClientspecificTPRDetails(this.id, spclientid);
        } else {
            this.getTPRDetails(this.id);
        }
        this.getEffortListing(this.permanencyPlanId);
    }
    // Assosiated with validateStoreValues function
    private returnSpclientidFn() {
        return (this.store['spclientid'] ? this.store.get('spclientid') : null);
    }
    // Assosiated with validateStoreValues function
    private checkElsePlacementchildFn() {
        this._PlacementAdoptionService.getPermanencyPlanId(1, 100, this.transkey, this.transid).subscribe(data => {
            this.permanencyPlanId = (data && data.length) ? data[0].permanencyplanid : null;
            this._PlacementAdoptionService.getPlacementConfig(1, 100, this.permanencyPlanId).subscribe(
                res => {
                    let adoptionplanningid = null;
                    if (res.length && res[0] && res[0].placements && res[0].placements.length) {
                        const placement = res[0];
                        placement.intakeservicerequestactorid = placement['placements'][0].intakeservicerequestactorid;
                        this._dataStoreService.setData('placed_child', placement);
                        placement['placements'][0].permanencyplanid = this.permanencyPlanId;
                        this._dataStoreService.setData('placement_child', placement['placements'][0]);
                        adoptionplanningid = placement['adoptionplanningid'];
                        this._dataStoreService.setData('adoptionplanningid', placement['adoptionplanningid']);
                        this._dataStoreService.setData('tprrecommendationid', placement['tprrecommendationid']);
                        this._dataStoreService.setData('adoptionagreementid', placement['adoptionagreementid']);
                        this.validateStoreValues();
                    } else if (res.length && res[0]) {
                        adoptionplanningid = res[0].adoptionplanningid;
                        this._dataStoreService.setData('placement_child', res[0].placements);
                        this._dataStoreService.setData('adoptionplanningid', res[0].adoptionplanningid);
                        this._dataStoreService.setData('tprrecommendationid', res[0].tprrecommendationid);
                        this._dataStoreService.setData('adoptionagreementid', res[0].adoptionplanningid);
                        this.validateStoreValues();
                    }
                    if (res.length && res[0]) {
                        this.checkAdoptionSubsidyIsEdited(adoptionplanningid);
                    }
                    this.getAdoption(adoptionplanningid);
                }
            );
        });
    }

    getLegalCustody(childActorId: any) {

        this._PlacementAdoptionService.getLegalCustody(childActorId)
            .subscribe(res => {
                if (res && res.length && res[0].getlegalcustody) {
                    this._store.setData('LegalCustodyDetails', res[0].getlegalcustody);
                    this.broadCastTabLoad('LegalCustody');
                }
            });
    }

   getTPRDetails(id: any) {
        this._PlacementAdoptionService.getTPRList(id)
            .subscribe(res => {
                if (res && res.length ) {
                    this._store.setData(DSDS_STORE_CONSTANTS.TPR_LIST, res);
                    this.broadCastTabLoad('TRPList');
                }
            });
    }
    getClientspecificTPRDetails(id: any,spclientid: any) {
        this._PlacementAdoptionService.getClientSpecificTPRList(id, spclientid)
            .subscribe(resp => {
                if (resp && resp.length ) {
                    this._store.setData(DSDS_STORE_CONSTANTS.TPR_LIST, resp);
                    this.broadCastTabLoad('TRPList');
                }
            });
    }

    getEffortListing(id: any) {
        this._PlacementAdoptionService.getEffortListing(id).subscribe(res => {
        if (res && res.length && res[0].getadoptionplanning) {
            this._store.setData('adoptionEffort', res[0].getadoptionplanning[0]);
            this._PlacementAdoptionService.setAdoptionPlanning(res[0].getadoptionplanning[0]);
            this.broadCastTabLoad('planning');
            this.getNarrativeListing(id);
        }
        });
    }

    getNarrativeListing(id:any) {
        this._PlacementAdoptionService.getNarrative(id).subscribe(res => {
        if (res && res.length && res[0].getadoptionplanning) {
            this._store.setData('adoptionEffort', res[0].getadoptionplanning[0]);
            this.checkAdoptionSubsidyIsEdited(res[0].getadoptionplanning[0].adoptionplanningid);
            this.getAdoption(res[0].getadoptionplanning[0].adoptionplanningid);
            this._PlacementAdoptionService.setAdoptionPlanning(res[0].getadoptionplanning[0]);
            this.broadCastTabLoad('TRPList');
        }
        });
    }

    getPlacementInfoList(pageNumber: any, limit: any) {
        return  this._commonHttp
          .getPagedArrayList(
            new PaginationRequest({
              page: pageNumber,
              limit: limit,
              method: 'get',
              where: { servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
            }),
            'placement/getplacementbyservicecase?filter'
            // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
          ).pipe(map((res) => {
            return {
                data: res.data,
                count: res.count
            };
        }),
        share(),);

      }

    private getRecommendedList() {
        // this._commonHttp
        //     .getSingle(
        //         new PaginationRequest({
        //             where: {

        //                 intakeservicerequestactorid: this.childActorId ? this.childActorId : null,
        //                 intakeserviceid: this.id
        //             },
        //             method: 'get'
        //         }),
        //         CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.TprRecommendationList + '?filter'
        //     )
            this._PlacementAdoptionService.getRecommendedList(this.id, this.permanencyPlanId)
            .subscribe(res => {
                this._store.setData('TPRRecommendationList', res, true);
                this._store.setData('TPRRecommendationId', res.tprrecommendationid);
                this.broadCastTabLoad('TPRRecommend');
            });
    }

    broadCastTabLoad(tabName: any) {
        this._PlacementAdoptionService.broadStoreDataPatched(tabName);
    }

    getTabAccess() {
        this._PlacementAdoptionService.getplacementAdoptionData('isRecommended');
      }

    goBack() {
        this.router.navigate(['../../'], { relativeTo: this.route });
    }

    getChildDetails(_action: any) {
        this._PlacementAdoptionService.getPermanencyPlanId(1, 100, this.transkey, this.transid).subscribe(data => {
            this.permanencyPlanId = (data && data.length) ? data[0].permanencyplanid : null;

        this._serviceCasePermanencyPlanService.getPermanencyPlanList(1, 10).subscribe((data: any) => {
            let permanencyPlanList = data;
            let permanencyplanid = this._session.getItem(CASE_STORE_CONSTANTS.ADOPTION_PERMANENCYPLANID) ? this._session.getItem(CASE_STORE_CONSTANTS.ADOPTION_PERMANENCYPLANID) :
                this._dataStoreService.getData(CASE_STORE_CONSTANTS.ADOPTION_PERMANENCYPLANID);
                permanencyplanid = permanencyplanid === "null" ? this.permanencyPlanId : permanencyplanid;
            permanencyPlanList = Array.isArray(permanencyPlanList) ? permanencyPlanList : [];
            const plan = permanencyPlanList.find((item: { permanencyplans: any; }) => {
                const planlist = Array.isArray(item.permanencyplans) ? item.permanencyplans : [];
                return planlist.some(ele => ele.permanencyplanid === permanencyplanid);
            });
            if (plan) {
                this.child = {
                    clientname: plan.clientname,
                    cjamspid: plan.cjamspid,
                    dob: plan.dob,
                    gender: plan.gender
                };
                this._dataStoreService.setData('childforGAP', plan.cjamspid);
            }
        });
 });

    }

    private checkAdoptionSubsidyIsEdited(adoptionplanningid: any) {
        if (adoptionplanningid && adoptionplanningid != '') {
            this._commonHttp
                .getSingle(
                    new PaginationRequest({
                        where: { adoptionplanningid: adoptionplanningid },
                        method: 'get',
                        page: 1,
                        limit: 1
                    }),
                    'adoptionagreement/list?filter'
                )
                .subscribe(res => {
                    if (res && res.length && Array.isArray(res)) {
                        const agreementList = res[0].getadoptionagreementlist;
                        if (agreementList && agreementList.length && agreementList[0]) {
                            this.adoptionSubsidyIsEdited = true;
                        }
                        else{
                            this.adoptionSubsidyIsEdited = false;}
                    }
                }
                );
        }
    }

    private getAdoption(adpplanningid: any) {
        this._commonHttp
            .getArrayList(
                new PaginationRequest({
                    where: { adoptionplanningid: adpplanningid ? adpplanningid : null},
                    method: 'get'
                }),
                'adoptionchecklist/getadoptionchecklist?filter'
            )
            .subscribe(result => {
                if (result && result.length) {
                    if(result[0]){
                        this.disclosureapprovalStatus = result[0].status;}                
                } 
            });
    }
}
