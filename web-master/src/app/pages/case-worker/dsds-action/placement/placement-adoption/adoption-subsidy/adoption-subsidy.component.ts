import { Component, Injector, OnInit } from '@angular/core';
import {
    CommonHttpService,
    AlertService,
    DataStoreService,
    AuthService
} from '../../../../../../@core/services';
import { ActivatedRoute, Router } from '@angular/router';
import { FormBuilder, FormGroup } from '@angular/forms';
import { PlacementAdoptionService } from '../placement-adoption.service';
import { DynamicObject, PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { AppConstants } from '../../../../../../@core/common/constants';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';

declare var $: any;

@Component({
    selector: 'adoption-subsidy',
    templateUrl: './adoption-subsidy.component.html',
    styleUrls: ['./adoption-subsidy.component.scss'],
    standalone: false
})
export class AdoptionSubsidyComponent implements OnInit {
    subsidyAgreementRateForm!: FormGroup;
    subsidyAgreementForm!: FormGroup;
    id: string;
    daNumber: string;
    store: DynamicObject;
    permanencyplanid!: string;
    isAdoptionCase!: boolean;
    isSupervisor: boolean;
    child: any;
    private readonly _commonHttp: CommonHttpService;
    private readonly route: ActivatedRoute;
    private readonly _formBuilder: FormBuilder;
    private readonly _alert: AlertService;
    private readonly _store: DataStoreService;
    private readonly _router: Router;
    private readonly _PlacementAdoptionService: PlacementAdoptionService;

    constructor(
        private readonly injector : Injector,
        private readonly _authService: AuthService,
        private readonly _dataStoreService: DataStoreService
    ) {
        this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._alert = this.injector.get<AlertService>(AlertService);
        this._store = this.injector.get<DataStoreService>(DataStoreService);
        this._router = this.injector.get<Router>(Router);
        this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);

        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.store = this._store.getCurrentStore();
        const caseType = this._store.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
        this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);

        if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
            this.isAdoptionCase = true;
        }
        if (this.store) {
            this.id = this.store['CASEUID'];
            this.daNumber = this.store['DANUMBER'];
            this.permanencyplanid = (this.store['placement_child']) ? this.store['placement_child'].permanencyplanid : null;
        }
    }

    ngOnInit() {
        this.getInvolvedPerson();
        this.formInitialize();
        this.getAgreementListing();
        const adoptionPlanningId = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;
        if(adoptionPlanningId) {
        this._PlacementAdoptionService.getAdoptionChecklist(adoptionPlanningId).subscribe(data => {
            if(data && data.length) {
                const adoptionData = data[0];
                if(!adoptionData.status  || adoptionData.status !== 'Approved') {
                    $('#ap-subsidy').modal('show');
                }
            } else {
                $('#ap-subsidy').modal('show');
            }
        });
        }
    }

    getInvolvedPerson() {
        this._commonHttp
        .getPagedArrayList( new PaginationRequest({
            method: 'get',
            page: 1, limit : 20,
            where: { intakeserviceid: this.id }
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
        ).subscribe(response => {
            if (response && response.data.length) {
                this.child = response.data.find(item => item.rolename === 'CHILD');
                this._dataStoreService.setData('CHILD',this.child);
            }
        });
    }

    navigateTo() {
        const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement-menu/placement/adoption/planning/checklist';
        this._router.navigate([redirectUrl]);
    }

    formInitialize() {
        this.subsidyAgreementRateForm = this._formBuilder.group({
            startdate: [null],
            enddate: [null],
            provider_id: [null],
            paymentamout: [null],
            isapproval: [null],
            approvaldate: [null],
            isspeacialneeds: [null],
            parent1actorid: [null],
            parent2actorid: [null],
            childrelationship: [null],
            notes: [null],
            speacialneeds: [null],
            transactiondate: [null],
            adoptionagreementid: [null],
        });

        this.subsidyAgreementForm = this._formBuilder.group({
          adoptionplanningid: [null],
          servicecaseid: [null],
          isofferedsubsidy: [null],
          offeraccepteddate: [null],
          startdate: [null],
          enddate: [null],
          finalizationdate: [null],
          isunderappeal: [null],
          parent1signdate: [null],
          parent2signdate: [null],
          ldssdate: [null],
          issubsidypaid: [null],
          adoptionagreementrate: [null]
      });
    }

    saveAgreement() {
        const agreementInput = Object.assign(this.subsidyAgreementForm.value);
        const agreementRateInput = Object.assign(this.subsidyAgreementRateForm.value);
        agreementInput.intakeserviceid = null;
        agreementInput.servicecaseid = this.id ? this.id : null;
        agreementInput.adoptionplanningid = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;
        agreementInput.permanencyplanid = this.permanencyplanid  ? this.permanencyplanid : null;
        agreementInput.adoptionagreementrate = agreementRateInput ? agreementRateInput : null;
        this._commonHttp
            .create(
              agreementInput,
               'adoptionagreement/add'
            )
            .subscribe(
                res => {
                    this._alert.success('Subsidy agreement saved successfully');
                    this.getAgreementListing();
                },
                err => {
                    this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }

    saveAgreementRate() {
        const agreementInput = Object.assign(this.subsidyAgreementRateForm.value);
        agreementInput.intakeserviceid = null;
        agreementInput.servicecaseid = this.id ? this.id : null;
        agreementInput.permanencyplanid = this.permanencyplanid  ? this.permanencyplanid : null;

        this._commonHttp
            .create(
              agreementInput,
               'adoptionagreementrate/add'
            )
            .subscribe(
                res => {
                    this._alert.success('Subsidy agreement saved successfully');
                    this.getAgreementListing();
                },
                err => {
                    this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }

    getAgreementListing() {
        this._commonHttp
            .getSingle(
                new PaginationRequest({
                    where: {
                      adoptionplanningid: this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null
                        // intakeserviceid: this.id,
                        //  intakeservicerequestactorid: this.childActorId ? this.childActorId : null
                    },
                    method: 'get',
                    page : 1,
                    limit: 10
                }),
                'adoptionagreement/list' + '?filter'
            )
            .subscribe(res => {
                if (res && res.length) {
                  this.subsidyAgreementForm.patchValue(res[0]);
                  if (res.agreementrate) {
                  this.subsidyAgreementRateForm.patchValue(res[0].agreementrate); }
                }
            });

    }
}
