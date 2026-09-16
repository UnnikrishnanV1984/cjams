import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable } from 'rxjs';

import { PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CommonHttpService, DataStoreService, AuthService, SessionStorageService } from '../../../../../@core/services';
import { InvolvedPerson } from '../../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { Placement } from '../../service-plan/_entities/service-plan.model';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { PlacementGapService } from './placement-gap.service';
import { PlacementGapResolverService } from './placement-gap-resolver-service';


@Component({
    // tslint:disable-next-line:component-selector
    selector: 'placement-gap',
    templateUrl: './placement-gap.component.html',
    styleUrls: ['./placement-gap.component.scss'],
    standalone: false
})
export class PlacementGapComponent implements OnInit {
    paginationInfo: PaginationInfo = new PaginationInfo();
    id!: string;
    placement!: Placement[];
    permanencyPlanList: any;
    cjamsPid!: string;
    child: any;
    guardianDetails: any;
    isSelectChild = false;
    selectedChild!: InvolvedPerson;
    involevedPerson$!: Observable<InvolvedPerson[]>;
    childForm!: FormGroup;
    private daNumber!: string;
    moduleview: any;
    
    private readonly _httpService: CommonHttpService;
    private readonly route: ActivatedRoute;
    private readonly _dataStoreService: DataStoreService;
    private readonly _router: Router;
    private readonly _gapService: PlacementGapService;
    private readonly _authService: AuthService;
    retrydoc: boolean = false;

    constructor(private readonly _formBuilder: FormBuilder, private readonly injector : Injector, private readonly _session: SessionStorageService,private placementGapResolverService: PlacementGapResolverService) { 
        this._httpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._router = this.injector.get<Router>(Router);
        this._gapService = this.injector.get<PlacementGapService>(PlacementGapService);
        this._authService = this.injector.get<AuthService>(AuthService);
        // this.route.data.subscribe(data => {
        //     if (data && data.hasOwnProperty('result')) {
        //         this._authService.setAuthDetail('gap',data.result);
        //     }
        // });
    }

    ngOnInit() {
        this.placementGapResolverService.getGap().subscribe({
            next: (data: any) => {
                this._authService.setAuthDetail('gap',data);
            }
        })
        this.route.queryParams.subscribe(params => {
            if(params['retrydocument']) {
              this.retrydoc = true;   
            }
        });
        this.moduleview = this._authService.isModuleAccessable('gap', 'gap');
        this.childForm = this._formBuilder.group({
            selectchild: ['']
        });

        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.child = this._dataStoreService.getData('placed_child');
        this.checkforChildId();
        this.setUpGapData();
        this.getGuardianDetails();

    }

    checkforChildId() {
        this.cjamsPid = this._dataStoreService.getData('childforGAP');
    }
    getPlacement(page: number) {
        this._httpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: page,
                    limit: 50,
                    where: {
                        intakeserviceid: this.id,
                        casenumber: this.daNumber
                    },
                    method: 'get'
                }),
                // CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PlacementListUrl + '?filter'
                CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fostercarereferallistUrl + '?filter'
            )
            .subscribe(res => {
                this.placement = res.data;
                if (this.placement && this.placement.length) {
                    this.childForm.patchValue({
                        selectchild: this.placement[0]
                    });
                    this.selectChild({ value: this.placement[0] });
                }
            });
    }
    selectChild(modal: any) {
        if (modal.value) {
            this._dataStoreService.setData('placement_child', modal.value);
            this.selectedChild = modal.value;
            this.isSelectChild = true;
        }
    }

    isGAPApproved(child: any) {
        this.cjamsPid = this._dataStoreService.getData('childforGAP');
        let status = false;
        if (child) {
            if (child.cjamspid && child.cjamspid === this.cjamsPid) {
                status = true;
            }
        }

        // For GAP Approval Check
        // if (child && child.permanencyplans && child.permanencyplans.length) {
        //     const permanencyPlan = child.permanencyplans;
        //     permanencyPlan.forEach(plan => {
        //          if (plan.status === 'Approved' && plan.primarypermanency && plan.primarypermanency.length && plan.primarypermanency[0].permanencyplantypekey  === 'Guardianship') {
        //            status = true;
        //          }
        //     });
        // }
        return status;
    }

    openDisabilityForm(child: any) {
        this._router.navigate(['disability/' + child.personid + '/create'], { relativeTo: this.route });
        // (<any>$('#disability-form')).modal('show');
    }

    openDisabilityList(child: any) {
        this._router.navigate(['disability/' + child.personid + '/list'], { relativeTo: this.route });
    }

    close() {
        this._router.navigate(['../../'], { relativeTo: this.route });
    }

    setUpGapData() {
        let reqParam = {};
        let permanencyplanid = '';
        if (this._authService.selectedRoleIs('apcs') || this.retrydoc) {
            permanencyplanid = this._session.getItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
            const storeplanid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
            permanencyplanid = (permanencyplanid) ? permanencyplanid : storeplanid;
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, permanencyplanid);
            reqParam = {
                permanencyplanid: permanencyplanid
            };
            this._gapService.getGapDisclosureDetails(reqParam).subscribe(result => {
                if (Array.isArray(result.data) && result.data.length > 0) {
                    const disClosure = result.data[0];
                    this._gapService.getInvolvedPerson().subscribe(data => {
                        const persons = data.data;
                        this.child = persons.find(person => person.personid === disClosure.personid);
                        this._dataStoreService.setData('placed_child', this.child);
                    });
                }
            });
        }
    }

    getGuardianDetails() {
        let reqParam = {};
        let permanencyplanid = '';
            permanencyplanid = this._dataStoreService.getData('permanencyplanid_details');
            reqParam = {
                permanencyplanid: permanencyplanid
            };
            this._gapService.getGapDisclosureDetails(reqParam).subscribe(result => {
                if (Array.isArray(result.data) && result.data.length > 0) {
                    this.guardianDetails = result.data[0];
                }
            });
        }
}
