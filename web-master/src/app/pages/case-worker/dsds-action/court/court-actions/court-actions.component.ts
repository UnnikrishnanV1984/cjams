
import {pluck, share, map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import moment from 'moment';
import { Observable ,  forkJoin } from 'rxjs';

import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, DataStoreService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { CourtAction, CourtDetails, CourtOrder, ConditionType, PetitionDetails } from '../_entities/court.data.model';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { CourtResolverService } from '../court-resolver-service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'court-actions',
    templateUrl: './court-actions.component.html',
    styleUrls: ['./court-actions.component.scss'],
    standalone: false
})
export class CourtActionsComponent implements OnInit {
    offenceCategories$!: Observable<DropdownModel[]>;
    courtActionsType$!: Observable<DropdownModel[]>;
    conditionTypes$!: Observable<DropdownModel[]>;
    courtOrder$!: Observable<DropdownModel[]>;
    findingsType$!: Observable<DropdownModel[]>;
    adijuctedDecisions$!: Observable<DropdownModel[]>;
    hearingStatusTypeItem$!: Observable<DropdownModel[]>;
    stateList$!: Observable<DropdownModel[]>;
    countyList$!: Observable<DropdownModel[]>;
    courtDetailsForm!: FormGroup;
    userInfo!: AppUser;
    times: string[] = [];
    id!: string;
    courtDetails!: CourtDetails;
    courtAction: CourtAction[] = [];
    courtOrder: CourtOrder[] = [];
    conditionType: ConditionType[] = [];
    petitionDetails!: PetitionDetails;
    daNumber!: string;
    courtActionDescription: string[] = [];
    courtOrderDescription: string[] = [];
    courtConditionDescription: string[] = [];
    isHearingFilled!: boolean;

    filteroptn = '?filter={"nolimit":true}';
    iscaseexpunged: any = 0;

    constructor(
        private readonly _commonHttpService: CommonHttpService, 
        private readonly _formBuilder: FormBuilder,
        private readonly _authService: AuthService,  
        private readonly _alertService: AlertService, 
        private readonly _dataStoreService: DataStoreService,
        private readonly _courtResolverService: CourtResolverService) { }

    ngOnInit() {
        this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.getPetitionDetails();
        this.isHearingFilled = false;
        this.userInfo = this._authService.getCurrentUser();
        this.initiateFormGroup();
        this.getHearingdetails();
        this.courtDetailsForm.get('workername')?.disable();
        this.getCourtActions();
        this.times = this._courtResolverService.generateTimeList(true);
        this.courtDetailsForm.get('workername')?.disable();
    }
    getCourtActions() {
        if (!this.id) { 
            return
         }
        this._commonHttpService.getArrayList(
            {
                method: 'get',
                where: {
                    intakeservicerequestid: this.id
                }
            },
            `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court
                .getCourtActions}?filter`
        )
            .subscribe(
                (result) => {
                    if (result[0]) {
                        if (result[0]['courtaction']) {
                            result[0].courtactiontypekey = result[0].courtaction.map((item: { courtactiontypekey: any; }) => item.courtactiontypekey);
                            result[0].courtaction = result[0].courtaction.map((item: { courtactiontypekey: any; }) => {
                                return { courtactiontypekey: item.courtactiontypekey };
                            });
                            this.courtAction = result[0].courtaction;
                        }
                        if (result[0]['courtorder']) {
                            result[0].courtordertypekey = result[0].courtorder.map((item: { courtordertypekey: any; }) => item.courtordertypekey);
                            result[0].courtorder = result[0].courtorder.map((item: { courtordertypekey: any; }) => {
                                return { courtordertypekey: item.courtordertypekey };
                            });
                            this.courtOrder = result[0].courtorder;
                        }
                        if (result[0]['courtcondition']) {
                            result[0].conditiontypekey = result[0].courtcondition.map((item: { conditiontypekey: any; }) => item.conditiontypekey);
                            result[0].courtcondition = result[0].courtcondition.map((item: { conditiontypekey: any; }) => {
                                return { conditiontypekey: item.conditiontypekey };
                            });
                            this.conditionType = result[0].courtcondition;
                        }
                        this.patchForm(result[0]);
                    }
                },
                (_error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }
    // Assosiated with getCourtActions method
    private handleCourtconditionFn(result: any[]) {
        if (result[0]['courtcondition']) {
            result[0].conditiontypekey = result[0].courtcondition.map((item: { conditiontypekey: any; }) => item.conditiontypekey);
            result[0].courtcondition = result[0].courtcondition.map((item: { conditiontypekey: any; }) => {
                return { conditiontypekey: item.conditiontypekey };
            });
            this.conditionType = result[0].courtcondition;
        }
    }
    // Assosiated with getCourtActions method
    private handleCourtorderFn(result: any[]) {
        if (result[0]['courtorder']) {
            result[0].courtordertypekey = result[0].courtorder.map((item: { courtordertypekey: any; }) => item.courtordertypekey);
            result[0].courtorder = result[0].courtorder.map((item: { courtordertypekey: any; }) => {
                return { courtordertypekey: item.courtordertypekey };
            });
            this.courtOrder = result[0].courtorder;
        }
    }
    // Assosiated with getCourtActions method
    private handleCourtactionFn(result: any[]) {
        if (result[0]['courtaction']) {
            result[0].courtactiontypekey = result[0].courtaction.map((item: { courtactiontypekey: any; }) => item.courtactiontypekey);
            result[0].courtaction = result[0].courtaction.map((item: { courtactiontypekey: any; }) => {
                return { courtactiontypekey: item.courtactiontypekey };
            });
            this.courtAction = result[0].courtaction;
        }
    }
    getHearingdetails() {
        if (!this.id) {
            return
        }
let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        this._commonHttpService.getArrayList(
            {
                method: 'get',
                where: {
                    intakeservicerequestid: this.id,
                    isExpungementSuperUser: isExpungementSuperUser,
                    iscaseexpunged: this.iscaseexpunged
                }
            },
            `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.getHearingUrl}?filter`
        )
            .subscribe(
                (result) => {
                    if (result[0]) {
                            this.isHearingFilled = true;
                    }
                },
                (_error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }
    initiateFormGroup() {
        this.courtDetailsForm = this._formBuilder.group({
            legalcounselname: null,
            magistratename: null,
            workername: this.userInfo ? this.userInfo.user.userprofile.displayname : null,
            hearingdatetime: null,
            courtactiontypekey: null,
            courtordertypekey: null,
            courtorderdatetime: null,
            conditiontypekey: null,
            conditiontypedescription: null,
            conditiontypecompletiondatetime: null,
            terminationdatetime: null,
            adjudicationdatetime: null,
            adjudicationdecision: null,
            allegationid: null,
            adjudicationDate: null,
            adjudicationTime: '08:00',
            hearingDate: null,
            hearingTime: '08:00',
            terminationDate: null,
            terminationTime: '08:00',
            orderDate: null,
            orderTime: '08:00',
            completionDate: null,
            completionTime: '08:00',
            courtcasenumber: null,
            jurisdiction: null,
            decisionnotes: null,
            courtorderedlanguage: null,
            hearingoutcome: null
        });
    }
    patchForm(data: CourtDetails) {
        if (data) {
            data.hearingDate = moment(data.hearingdatetime).format(this._courtResolverService.dtformat1);
            data.hearingTime = moment(data.hearingdatetime).format('HH:mm');

            data.adjudicationDate = moment(data.adjudicationdatetime).format(this._courtResolverService.dtformat1);
            data.adjudicationTime = moment(data.adjudicationdatetime).format('HH:mm');

            data.completionDate = moment(data.conditiontypecompletiondatetime).format(this._courtResolverService.dtformat1);
            data.completionTime = moment(data.conditiontypecompletiondatetime).format('HH:mm');

            data.orderDate = moment(data.courtorderdatetime).format(this._courtResolverService.dtformat1);
            data.orderTime = moment(data.courtorderdatetime).format('HH:mm');

            data.terminationDate = moment(data.terminationdatetime).format(this._courtResolverService.dtformat1);
            data.terminationTime = moment(data.terminationdatetime).format('HH:mm');
            this.courtDetailsForm.patchValue(data);
        }
      }
    updateCourtDetail() {
        if (this.courtDetailsForm.valid) {
        this.courtDetails = Object.assign({}, this.courtDetailsForm.value );

        this.courtDetails.intakeservicerequestid = this.id;

        const adjudicationDate = this.courtDetailsForm.value.adjudicationDate;
        const adjudicationTime = this.courtDetailsForm.value.adjudicationTime;
        this.courtDetails.adjudicationdatetime = this._courtResolverService.formatDateTime(adjudicationDate, adjudicationTime);

        const completionDate = this.courtDetailsForm.value.completionDate;
        const completionTime = this.courtDetailsForm.value.completionTime;
        this.courtDetails.conditiontypecompletiondatetime = this._courtResolverService.formatDateTime(completionDate, completionTime);
        this.courtDetails.courtorderdatetime = this._courtResolverService.formatDateTime(this.courtDetailsForm.value.orderDate, this.courtDetailsForm.value.orderTime);
        this.courtDetails.hearingdatetime = this._courtResolverService.formatDateTime(this.courtDetailsForm.value.hearingDate, this.courtDetailsForm.value.hearingTime);
        this.courtDetails.terminationdatetime = this._courtResolverService.formatDateTime(this.courtDetailsForm.value.terminationDate, this.courtDetailsForm.value.terminationTime);
        this.courtDetails.courtaction = this.courtAction;
        this.courtDetails.courtorder = this.courtOrder;
        this.courtDetails.courtcondition = this.conditionType;
        this.courtDetails.intakeservicerequestpetitionid = this.petitionDetails.intakeservicerequestpetitionid;
         this._commonHttpService
            .create( this.courtDetails , CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.CourtActionAddUrl)
            .subscribe( _result => {
            this._alertService.success('Court details saved successfully!');
        },
        _error => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        });
    } else {
        this._alertService.error('Please fill all fields');
        }
    }

    selectCourtActionType(event: any) {
        this._courtResolverService.selectCourtType(event, 'courtAction', 'courtactiontypekey', this.courtActionsType$, 'courtActionDescription');
    }
    
    selectCourtOrderType(event: any) {
        this._courtResolverService.selectCourtType(event, 'courtOrder', 'courtordertypekey', this.courtOrder$, 'courtOrderDescription');
    }
    
    selectCourtConditionType(event: any) {
        this._courtResolverService.selectCourtType(event, 'conditionType', 'conditiontypekey', this.conditionTypes$, 'courtConditionDescription');
    }

    private loadDroddowns() {
            const filterParams1 = JSON.stringify({
                nolimit: true,
                where: { intakeservicerequestid: this.id }
            });

            const filterParams2 = encodeURIComponent(JSON.stringify({ 
                nolimit: true,
                order: "countyname asc" 
            }));

            const courtActionUrl = `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.CourtActionTypeUrl}?filter=${filterParams1}`;
            const countyListUrl = `${CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CountyListUrl}?filter=${filterParams2}`;
            const source = forkJoin([
            this._commonHttpService.getArrayList({}, 
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Allegation.AllegationURL}?filter={"nolimit":true,"order":"name asc"}`
                ),
            this._commonHttpService.getArrayList({}, courtActionUrl),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.ConditionTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.CourtOrderTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.FindingTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.AdjudicatedDecisionTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.HearingStatusTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.StateListUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, countyListUrl)
        ]).pipe(
            map(([offenceCategories, courtActionsType, conditionTypes, courtOrder, findingsType, adijuctedDecisions, hearingStatusType, stateList, countyList]: any) => {
                return {
                    offenceCategories: this._courtResolverService.mapToDropdownModel(offenceCategories['data'], 'name', 'allegationid'),
                    courtActionsType: this._courtResolverService.mapToDropdownModel(courtActionsType, 'description', 'courtactiontypekey'),
                    conditionTypes: this._courtResolverService.mapToDropdownModel(conditionTypes, 'description', 'conditiontypekey'),
                    courtOrder: this._courtResolverService.mapToDropdownModel(courtOrder, 'description', 'courtordertypekey'),
                    findingsType: this._courtResolverService.mapToDropdownModel(findingsType, 'description', 'findingtypekey'),
                    adijuctedDecisions: this._courtResolverService.mapToDropdownModel(adijuctedDecisions, 'description', 'adjudicateddecisiontypekey'),
                    hearingStatusType: this._courtResolverService.mapToDropdownModel(hearingStatusType, 'description', 'hearingstatustypekey'),
                    stateList: this._courtResolverService.mapToDropdownModel(stateList, 'description', 'hearingstatustypekey'),
                    countyList: this._courtResolverService.mapToDropdownModel(countyList, 'description', 'hearingstatustypekey'),
                };
            }),
            share(),);
        this.offenceCategories$ = source.pipe(pluck('offenceCategories'));
        this.courtActionsType$ = source.pipe(pluck('courtActionsType'));
        this.conditionTypes$ = source.pipe(pluck('conditionTypes'));
        this.courtOrder$ = source.pipe(pluck('courtOrder'));
        this.findingsType$ = source.pipe(pluck('findingsType'));
        this.adijuctedDecisions$ = source.pipe(pluck('adijuctedDecisions'));
        this.hearingStatusTypeItem$ = source.pipe(pluck('hearingStatusType'));
        this.stateList$ = source.pipe(pluck('stateList'));
        this.countyList$ = source.pipe(pluck('countyList'));

         this.courtActionsType$.subscribe(data => {
        if (data) {
            const courtActionValue = this.courtAction.map(res => res.courtactiontypekey);
            this.courtActionDescription = this._courtResolverService.filterAndMapItems(courtActionValue, data);
        }
        });
        this.conditionTypes$.subscribe(data => {
            if (data) {
                const conditionTypeValue = this.conditionType.map(res => res.conditiontypekey);
                this.courtConditionDescription = this._courtResolverService.filterAndMapItems(conditionTypeValue, data);
            }
        });
        this.courtOrder$.subscribe(data => {
            if (data) {
                const courtOrderValue = this.courtOrder.map(res => res.courtordertypekey);
                this.courtOrderDescription = this._courtResolverService.filterAndMapItems(courtOrderValue, data);
            }
        });
    }

    private getPetitionDetails() {
        this._commonHttpService
            .getArrayList(
                {
                    where: {
                        intakeservicerequestid: this.id
                    },
                    method: 'get'
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionDetailslist}?filter`
            )
            .subscribe(res => {
                if (res[0]) {
                    this.loadDroddowns();
                 this.petitionDetails = res[0];
                }
            });
    }
}
