
import {map, pluck, share} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable ,  forkJoin } from 'rxjs';

import { AppUser } from '../../../../../../@core/entities/authDataModel';
import { PaginationInfo, PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../../../@core/services';
import { AuthService } from '../../../../../../@core/services/auth.service';
import { HttpService } from '../../../../../../@core/services/http.service';
import { AppConfig } from '../../../../../../app.config';
import { Assessments, GetintakAssessment, InvolvedPerson, RoutingInfo } from '../../../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { ChildRoles } from '../../../child-removal/_entities/childremoval.model';
import { AssessmentBlob } from '../../../involved-persons/_entities/involvedperson.data.model';
import { Placement } from '../../../service-plan/_entities/service-plan.model';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'appla-list',
    templateUrl: './appla-list.component.html',
    styleUrls: ['./appla-list.component.scss'],
    standalone: false
})
export class ApplaListComponent implements OnInit {
    startAssessment$!: Observable<Assessments[]>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    getAsseesmentHistory: any;
    id: string;
    daNumber: string;
    showAssesment = -1;
    involvedPersons!: InvolvedPerson[];
    routingInfo!: RoutingInfo[];
    placement!: Placement[];
    relationName: ChildRoles[] = [];
    childDetail: ChildRoles[] = [];
    roleId!: AppUser;
    assessmentDetail!: AssessmentBlob;
    isServiceCase!: string;
    inputRequest!: Object;
    assessmentTemplateId: any;
    personDetail: any;
    
    private _http: HttpService;
    private _service: CommonHttpService;
    private route: ActivatedRoute;
    private _dataStoreService: DataStoreService;
    private _router: Router;
    private _authService: AuthService;

    constructor(
        private readonly injector : Injector,
        private storage: SessionStorageService,
        private _alertService: AlertService,
    ) {
        this._http = this.injector.get<HttpService>(HttpService);
        this._service = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._router = this.injector.get<Router>(Router);
        this._authService = this.injector.get<AuthService>(AuthService);
        
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }

    ngOnInit() {
        this.roleId = this._authService.getCurrentUser();
        this.isServiceCase = this.storage.getItem('ISSERVICECASE');
        if (this.isServiceCase) {
            this.inputRequest = {
                objecttypekey: 'servicecase',
                objectid: this.id,
                description: 'APPLA'
            };
        } else {
            const isExpungementSuperUser = this._authService.isExpungementSuperUser();
             const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
            this.inputRequest = {
                servicerequestid: this.id,
                isExpungementSuperUser : isExpungementSuperUser,
                'iscaseexpunged':iscaseexpunged
            };
        }
        this.getAssessmentPrefillData();
        this.getPage(1);

    }
    getPage(page: number) {

        this._http.overrideUrl = false;
        this._http.baseUrl = AppConfig.baseUrl;
        const source = this._service
            .getPagedArrayList(
                new PaginationRequest({
                    page: page,
                    limit: this.paginationInfo.pageSize,
                    where: this.inputRequest,
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.ListAssessment + '?filter'
            ).pipe(
            map((result) => {
                return { data: result.data, count: result.count };
            }),
            share(),);
        this.startAssessment$ = source.pipe(pluck('data'));
    }

    private getAssessmentPrefillData() {
        forkJoin([
            this._service.getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: this.inputRequest
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            ),
            this._service.getArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 50,
                    method: 'get',
                    where: { 'servicecaseid': this.id }
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.RoutingInfoList
            ),
            this._service.getPagedArrayList(
                {
                    where: this.inputRequest,
                    page: 1,
                    limit: 50,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PlacementListUrl + '?filter'
            ),
            this._service.getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: this.inputRequest
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
            )
        ]).subscribe(result => {
            if (result && result[0]['data']) {
                this.involvedPersons = result[0]['data'];
            }
            if (result && result[1].length > 0) {
                this.routingInfo = result[1][0]['routinginfo'];
            }
            this.placement = result[2]['data'];
            this.relationName = [];
            this.relationName = result[3].data;
            this.childDetail = [];
            this.relationName.forEach(res => {
                if (res.roles) {
                    const checkRC = res.roles.filter(role => role.intakeservicerequestpersontypekey === 'CHILD');
                    if (checkRC.length) {
                        this.childDetail.push(res);
                    }
                }
            });
        });
    }
    startAssessment(assessment: any, mode: any) {
        assessment.mode = mode;
        const storeData = this._dataStoreService.getCurrentStore();
        storeData['CASEWORKER_INVOLVED_PERSON'] = this.involvedPersons;
        storeData['CASEWORKER_ROUTING_INFO'] = this.routingInfo;
        storeData['CASEWORKER_PLACEMENT'] = this.placement;
        storeData['CASEWORKER_SELECTED_ASSESSMENT'] = assessment;
        storeData['CASEWORKER_CHILD_DETAIL'] = this.childDetail;
        this._dataStoreService.setObject(storeData, true, 'CASEWORKER_ASSESSMENT_LOAD');
        this._router.navigate(['../view'], { relativeTo: this.route });
    }
    showAssessment(id: number, row: any) {
        
        this.personDetail = this.storage.getObj('placed_child');
        const getAssessmentHistoryCheck: any[] = [];

        row.forEach((element: any) => {
            if (element.submissiondata !== null && element.submissiondata.child !== undefined && element.submissiondata.child.personid == this.personDetail.personid ) {
               getAssessmentHistoryCheck.push(element);
            } 
        });

        this.getAsseesmentHistory = getAssessmentHistoryCheck && getAssessmentHistoryCheck.length ? getAssessmentHistoryCheck : row;
        
        if (this.showAssesment !== id) {
            this.showAssesment = id;
        } else {
            this.showAssesment = -1;
        }
    }
    actionIconDisplay(modal: any, status: string): boolean {
        if (status === 'View') {
            return modal.assessmentstatustypekey !== 'Open' && modal !== null;
        } else if (status === 'Edit') {
            const cwstatusList = ['Rejected', 'Accepted'];
            const supStatusList = ['Open', 'Accepted'];
            return (!cwstatusList.includes(modal.assessmentstatustypekey) && modal !== null) || (this.roleId.role.name === 'apcs' && !supStatusList.includes(modal.assessmentstatustypekey));
        } else if (status === 'Print') {
            return modal.assessmentstatustypekey !== 'Open' && modal !== null;
        } else if (status === 'InProcess') {
            return modal.assessmentstatustypekey === 'InProcess' && modal !== null;
        }
        return false;
    }
    isIconDisabled(modal: any) {
        if (this.roleId.role.name === 'apcs') {
            if (modal.assessmentstatustypekey === 'InProcess' || modal.assessmentstatustypekey === 'Rejected' || modal.assessmentstatustypekey === 'Accepted') {
                return 'icon-disabled';
            }
        } else {
            return;
        }
    }

    confirmDelete(assessmentid: any) {
        this.assessmentTemplateId = assessmentid;
        $('#delete-assessment-popup').modal('show');
    }
    
    deleteAssessment() {
        this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.DeleteAssessment;
        this._service.create({
            assessmentid: this.assessmentTemplateId,
            // method: 'post'
        })
            .subscribe(
                response => {
                    if (response) {
                        this._alertService.success(
                            'Assessment deleted successfully'
                        );
                        $('#delete-assessment-popup').modal('hide');
                        this.getPage(1);
                        this.getAsseesmentHistory = null;
                        this.showAssesment = -1;
                    }
                },
                error => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }
}
