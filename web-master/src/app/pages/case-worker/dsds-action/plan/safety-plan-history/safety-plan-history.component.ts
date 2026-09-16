import { DataStoreService } from './../../../../../@core/services/data-store.service';
import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../../../@core/services';
import { ActivatedRoute, Router } from '@angular/router';
import { InvolvedPerson } from '../../involved-person/_entities/involvedperson.data.model';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { forkJoin ,  Subject } from 'rxjs';
import moment from 'moment';
import { SafetyPlanView, SaftyPlan } from '../../../_entities/caseworker.data.model';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
export const SERVICE_PLAN = {
    SERVICE_PLAN_EDIT: 'SERVICE_PLAN_EDIT'
};
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'safety-plan-history',
    templateUrl: './safety-plan-history.component.html',
    styleUrls: ['./safety-plan-history.component.scss'],
    standalone: false
})
export class SafetyPlanHistoryComponent implements OnInit {
    id!: string;
    daNumber!: string;
    involvedPersons!: InvolvedPerson[];
    saftyPlans!: SaftyPlan[];
    safetyPlanView = new SafetyPlanView();
    saftyPlan$ = new Subject<SaftyPlan>();
    constructor(private _commonHttpService: CommonHttpService, private route: ActivatedRoute, private _store: DataStoreService, private _route: Router) {}

    ngOnInit() {
        this.id = this._store.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._store.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.getSafetyPlanHistory();
    }

    openPrintView(saftyPlan: SaftyPlan) {
        $('#safetyPlanPrintView').modal('show');
        this.saftyPlan$.next(saftyPlan);
    }
    editPlan(plan: SaftyPlan) {
        this._store.setData(SERVICE_PLAN.SERVICE_PLAN_EDIT, plan);
        this._route.routeReuseStrategy.shouldReuseRoute = function() {
            return false;
        };
        const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/plan/safety-plan';
        this._route.navigateByUrl(currentUrl).then(() => {
            this._route.navigated = false;
            this._route.navigate([currentUrl]);
        });
    }

    private getSafetyPlanHistory() {
        const involvedPersonRequest = this._commonHttpService.getPagedArrayList(
            new PaginationRequest({
                page: 1,
                limit: 50,
                method: 'get',
                where: { intakeservreqid: this.id }
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
        );
        const safeCAssessmentRequest = this._commonHttpService.getArrayList(
            {
                method: 'get',
                where: {
                    intakeserviceid: this.id,
                    externalid: null
                },
                page: 1,
                limit: 10
            },
            'Intakeservicerequestsafetyplans/list?filter'
        );
       forkJoin([safeCAssessmentRequest, involvedPersonRequest]).subscribe((item) => {
            this.saftyPlans = (item[0] as any) as SaftyPlan[];
            this.involvedPersons = (item[1]['data'] as any) as InvolvedPerson[];
            this.setInvolvedPersons();
        });
    }

    private setInvolvedPersons() {
        const caseHeadDetail = this.involvedPersons.find((item) => item.rolename === 'CASEHD');
        if (caseHeadDetail) {
            this.safetyPlanView.caseHeadName = caseHeadDetail.lastname.trim() + ', ' + caseHeadDetail.firstname.trim();
            this.safetyPlanView.caseHeadId = caseHeadDetail.dcn;
        }

        const childDetails = this.involvedPersons.find((item) => item.rolename === 'RC');
        if (childDetails) {
            this.safetyPlanView.childName = childDetails.lastname.trim() + ', ' + childDetails.firstname.trim();
        }
        this.safetyPlanView.planDate = moment(new Date()).format('DD/MM/YYYY');
    }
}
