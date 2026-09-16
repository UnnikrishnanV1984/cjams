import { Component, Injector, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../../../../@core/services/common-http.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { DataStoreService, AuthService, SessionStorageService } from '../../../../../../@core/services';
import { DynamicObject, PaginationRequest, PaginationInfo } from '../../../../../../@core/entities/common.entities';
import { ActivatedRoute, Router } from '@angular/router';
import { DsdsActionComponent} from '../../../dsds-action.component';
import { InvolvedPerson } from '../../../../../../@core/common/models/involvedperson.data.model';
import { DSDS_STORE_CONSTANTS } from '../../../dsds-action.constants';
import { PlacementAdoptionService } from '../placement-adoption.service';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { FinanceUrlConfig } from '../../../../../finance/finance.url.config';
import { FinanceService } from '../../../../../finance/finance.service';
import { NavigationUtils } from '../../../../../_utils/navigation-utils.service';
import { ServiceCasePermanencyPlanService } from '../../../service-case-permanency-plan/service-case-permanency-plan.service';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'adoption-planning',
    templateUrl: './adoption-planning.component.html',
    styleUrls: ['./adoption-planning.component.scss'],
    standalone: false
})
export class AdoptionPlanningComponent implements OnInit {
    id: string;
    store: DynamicObject;
    reportedChild?: InvolvedPerson;
    daNumber: string;
    validationMessage = '';
    selectedurl: any;
    agency = '';
    activeRoute: any;
    isChildInPreAdoption: any;
    changehistory = [];
    adjustment!: any[];
    paginationInfo: PaginationInfo  = new PaginationInfo();
    pageInfo: PaginationInfo  = new PaginationInfo();
    isAdoptionCreated!: boolean;
    providerDetails: any;
    placmentDetails: any;
    overpayments!: any[];
    disclosurecheckliststatus: boolean = true;
    appopupid = '#ap-planning';
    adoptionplaningid!: string;
    trpList: any;
    private readonly _commonHttp: CommonHttpService;
    private readonly _store: DataStoreService;
    private readonly route: ActivatedRoute;
    private readonly _route: Router;
    private readonly _DsdsActionComponent: DsdsActionComponent;
    private readonly _authService: AuthService;
    private readonly _PlacementAdoptionService: PlacementAdoptionService;
    private readonly _financeService: FinanceService;
    private readonly _session: SessionStorageService;

    constructor(private readonly injector : Injector, private readonly _serviceCasePermanencyPlanService: ServiceCasePermanencyPlanService, 
         private readonly _navigationService: NavigationUtils) {
            this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
            this._store = this.injector.get<DataStoreService>(DataStoreService);
            this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
            this._route = this.injector.get<Router>(Router);
            this._DsdsActionComponent = this.injector.get<DsdsActionComponent>(DsdsActionComponent);
            this._authService = this.injector.get<AuthService>(AuthService);
            this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);
            this._financeService = this.injector.get<FinanceService>(FinanceService);
            this._session = this.injector.get<SessionStorageService>(SessionStorageService);

        this.id = this._store.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._store.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.store = this._store.getCurrentStore();
    }

    ngOnInit() {
        this.agency = this._authService.getAgencyName();
        const spclientid =
            this.store?.['placed_child']?.personid ??
            this.returnSpclientidFn() ??
            this._session?.getItem('adoptionplanningpersonid');
        this._PlacementAdoptionService.getClientSpecificTPRList(this.id, spclientid)
            .subscribe(res => {
                if (res && res.length ) {                  
                    this.trpList = spclientid ? res?.filter(item=>item.personid === spclientid) : res;
                    this.validation();
                    this._store.setData(DSDS_STORE_CONSTANTS.TPR_LIST, res);
                }
                else{
                    this.validation();
                }
            });
        this._PlacementAdoptionService.storeDataPatched$.subscribe(data => {
            if (data === 'TRPList') {
                this.ValidateStoreValues();
            }
        });
        this.paginationInfo.pageNumber = 1;
        this.paginationInfo.pageSize = 10;
        this.getBreaklink();
        this.childPlacementList();
        this.getAdoptionInfo();
    }
    // Assosiated with ngOnInit method
    private returnSpclientidFn() {
        return this.store['spclientid'] ? this.store.get('spclientid') : null;
    }

    childPlacementList() {
        this._commonHttp
          .getPagedArrayList(
            new PaginationRequest({
              page: 1,
              limit: 10,
              method: 'get',
              where: { servicecaseid: this._store.getData(CASE_STORE_CONSTANTS.CASE_UID) },
            }),
            'placement/getplacementbyservicecase?filter'
            // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
          ).subscribe(result => {
            if (result && result.data) {
                this.placmentDetails = result?.data?.find(item => item?.cjamspid === this.store['placed_child']?.cjamspid);
                this.providerDetails = (this.placmentDetails && this.placmentDetails.placements && this.placmentDetails.placements.length && this.placmentDetails.placements[0].providerdetails) ?
                                    this.placmentDetails.placements[0].providerdetails : null;
                if (this.providerDetails) {
                    this.getOverPaymentList(this.providerDetails.provider_id, this.store['placed_child'].cjamspid);
                }
            }
        });
      }

      getOverPaymentList(providerID: any, clientid: any) {
        this._commonHttp.getPagedArrayList({
            where: {
              providerid: providerID,
              client_id: clientid
            },
            page: 1,
            limit: null,
            nolimt: true,
            method: 'get'
          }, FinanceUrlConfig.EndPoint.accountsReceivable.overpayments.list).subscribe((res: any) => {
            if (res && res.data && res.data.length) {
              this.overpayments = res.data;
            }
          });
      }

    checkTPRPlacement() {

        //If TPR completed and missing pre-adoptive placement
        (<any>$('#tpr-completion-placement')).modal('show');


    }

    ValidateStoreValues() {
        if ( this.store['placed_child'] && this.store['placed_child'].cjamspid) {
            this.reportedChild = this.store['placed_child'];
        }
        if (this.store['placement_child']) {
            this.getPlacementHistory();
        } else {
            this.planListing();
        }
    }
    validation() {
        if (this.store['TPRRecommendationId'] || this.store['TPR_RECOMMENDATION_ID']) {
            if (!this.trpList || this.trpList.length === 0) {
                this.validationMessage = 'Please complete Termination of Parental Rights';
                (<any>$(this.appopupid)).modal('show');
                return;
            }
            const isValid = true;
            this.validationMessage = '';
            const tprListLength = this.trpList.length;
            if (tprListLength < 2 && !(this.trpList[0].singleparent)) {
                this.validationMessage = 'Please complete Termination of Parental Rights';
                (<any>$(this.appopupid)).modal('show');
            }
            else {
                this.handleIfTprListLengthLessthanTwoFn(isValid);
            }
            // } else {
            //     this.validationMessage = 'Please complete Termination of Parental Rights';
            //     (<any>$(this.appopupid)).modal('show');
            // }
        } else {
            (<any>$('#ap-custody')).modal('show');
        }
    }

    // Assosiated with validation method
    private handleIfTprListLengthLessthanTwoFn(isValid: boolean) {
        this.trpList.forEach((element: any) => {
            if (element.isappealed === 1 && !element.appealdecisiontypekey) {
                isValid = false;
                this.validationMessage = 'Must wait for a court order from the appeals hearing upholding the TPR decision prior to moving to an adoption planning case.';
            } else if (element.isappealed === 1 && element.appealdecisiontypekey === 'APGR') {
                isValid = false;
                this.validationMessage = 'Cannot continue with Adoption Planning due to Appeal Status!.';
            }
        });
        if (!isValid) {
            (<any>$(this.appopupid)).modal('show');
        } else {
            (<any>$('#ap-planning-start')).modal('show');
        }
        // return isValid;
    }

    getPlacementHistory() {
        this._commonHttp
            .getPagedArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: {
                        casenumber: this.daNumber
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fostercarereferallistUrl + '?filter'
            )
            .subscribe((res) => {
                const data = res && res.data ? res.data : [];
                this.isChildInPreAdoption = data.some(ele => (ele.placementstructure === 'Pre-Finalized Adoptive Home' && ele.placemententrydate && !ele.placementexitdate));
                this._PlacementAdoptionService.broadStoreDataPatched('TRPList_a');
            });
    }

    broadCastStoreData(_data: any) {
        if (!this.disclosurecheckliststatus) {
            this._PlacementAdoptionService.broadStoreDataPatched('TRPList_a');
        }
    }
    private preValidation() {
        this._commonHttp
            .getSingle(
                new PaginationRequest({
                    where: {
                        intakeserviceid: this.id
                    },
                    method: 'get'
                }),
                'adoptionchecklist/validateadoptionplan?filter'
            )
            .subscribe(res => {
                if (res || res.length) {
                    if (res.statuscode === 500) {
                        this.validationMessage = 'Must wait for a court order from the appeals hearing upholding the TPR decision prior to moving to an adoption planning case.';
                        (<any>$(this.appopupid)).modal('show');
                    }
                }
            });
    }
    navigateTo() {
        this._PlacementAdoptionService.broadStoreDataPatched('LegalCustody');
        const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement-menu/placement/adoption/tpr';
        this._route.navigate([redirectUrl]);
    }

    navigateToPlacement() {
        const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/sc-placements/list';
        this._navigationService.dsdsActionTabSwitch$.next('placementTab');
        this._route.navigate([redirectUrl]);
    }
    alertforSave(selectedUrl: any) {
        this.selectedurl = selectedUrl;
       (<any>$('#save-alert')).modal('show');
    }
    checkforAdoptionPlaningID(routeUrl: any) {
        if (this._PlacementAdoptionService.getAdoptionPlanning().adoptionplanningid === undefined) {
            this.selectedurl = routeUrl;
            switch (routeUrl) {
                case 'emotion-ties':
                    this.selectedurl = 'Emotional Ties';
                    break;
                case 'narrative':
                        this.selectedurl = 'Narrative';
                    break;
                case 'checklist':
                        this.selectedurl = 'Checklist';
                    break;
                case 'aca-form':
                    this.selectedurl = 'ACA Form';
                break;
            }
            (<any>$('#save-alert-model')).modal('show');
        } else {
            if (routeUrl === 'checklist') {
                if (!this.disclosurecheckliststatus) {
                    this._route.navigate([routeUrl], {relativeTo : this.route});
                }
            } else {
                this._route.navigate([routeUrl], {relativeTo : this.route});
            }
        }
    }
    checkDataSave() {
        const urlSegments = this._route.url.split('/');
        if (urlSegments && urlSegments.length) {
          const routeLength = urlSegments.length;
          this.activeRoute =  urlSegments[routeLength - 1 ] ;
        }

        const isUnsavedData = this._PlacementAdoptionService.AdoptionPlanningSaveState;
        return ((isUnsavedData && !this.isAdoptionCreated ) ? true : false);
    }
    private getReportedChild(childActorId: any) {
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
                const repChild = res.data.filter((child: { personid: any; }) => child.personid === childActorId);
                if (repChild && repChild.length) {
                    this.getGender(repChild[0].gender);
                    this.reportedChild = repChild[0];
                }
                 }
            });
    }
    private getGender(gender: any) {
        this._commonHttp
            .create(
                {
                    where: { activeflag: 1 },
                    method: 'post',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.GenderTypeUrl + '/genderlist'
            )
            .subscribe(res => {
                const childGender = res.filter((item: { gendertypekey: any; }) => item.gendertypekey === gender);
                if(this.reportedChild){
                this.reportedChild.genderText = childGender && childGender.length > 0 ? childGender[0].typedescription : null;
                }
            });
    }
    private planListing() {
        this._commonHttp
            .getSingle(
                {
                    method: 'get',
                    page: 1,
                    limit: 10,
                    where: { objectid: this.id }
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PermanencyPlan.PermanencyPlanList + '?filter'
            )
            .subscribe(res => {
                if (res.length) {
                    res.map((plan: { personid: any; }) => {
                        this.getReportedChild(plan.personid);
                    });
                }
                if (res.data && res.data.length) {
                    res.data.map((plan: any) => {
                        if (plan.status === 'Approved') {
                            if (plan.primarypermanency.length) {
                                this._store.setData('permanencyPlan', plan, true);
                                this.getReportedChild(plan.intakeservicerequestactorid);
                            }
                        }
                    });
                }
            });
    }

    private getBreaklink() {
        this._commonHttp
          .getArrayList({
            method: 'get', where: {
              adoptionplanningid: this._PlacementAdoptionService.getAdoptionPlanning().adoptionplanningid
            }
          }, 'adoptionbreakthelink/getadoptionbreakthelink?filter')
          .subscribe(res => {
            if (res && res.length) {
              res.forEach((item) => {
                if(item && item.getadoptionbreakthelink){
                    this.returnBreaklinkFn(item);
                }
              });
            }
          });
      }
      // Assosiated with getBreaklink method
    private returnBreaklinkFn(item: any) {
        return item.getadoptionbreakthelink.map((breaklink: { adoptioncasenumber: any; }) => {
            this.isAdoptionCreated = (breaklink.adoptioncasenumber) ? true : false;
            return breaklink;
        });
    }

    private getAdoptionInfo() {
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
                    const cjamspid = this._store.getData('childforGAP');
                    const repChild = res.data.filter((child: { cjamspid: any; }) => child.cjamspid === cjamspid);
                    let adoptionRemovalID;
                    if (repChild && repChild.length) {
                        adoptionRemovalID = repChild[0].adoptionremovalid ? repChild[0].adoptionremovalid : repChild[0].removalid;
                        this._store.setData('childremovalid', adoptionRemovalID);
                        this._commonHttp.getSingle(
                            {},
                            'iveadoption/adoption/adoption-aca-worksheet/' +  cjamspid+'/'+ adoptionRemovalID
                        ).subscribe(response => {
                            this.handleAdoptionResponseFn(response);
                        });
                    }
                }
            });
    }
    // Assosiated with getAdoptionInfo method
    private handleAdoptionResponseFn(response: any) {
        if (response && response.adoptionAcaInfo && response.adoptionAcaInfo.length > 0
            && response.adoptionAcaInfo[0].ivestatus) {
            if (response.adoptionAcaInfo[0].ivestatus === 'APPROVED') {
                this.disclosurecheckliststatus = false;
            } else {
                this.disclosurecheckliststatus = true;
            }
        }
    }

      fiscalAudit() {
        if ( this.store['placed_child'] && this.store['placed_child'].cjamspid) {
            this.reportedChild = this.store['placed_child'];
        }
      }
}
