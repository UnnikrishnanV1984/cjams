
import {pluck, share, map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import moment from 'moment';
import { Observable ,  forkJoin } from 'rxjs';

import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, DataStoreService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { CourtAction, CourtDetails, PetitionDetails } from '../_entities/court.data.model';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { CourtResolverService } from '../court-resolver-service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'court-detail',
    templateUrl: './court-detail.component.html',
    styleUrls: ['./court-detail.component.scss'],
    standalone: false
})
export class CourtDetailComponent implements OnInit {
    offenceCategories$!: Observable<DropdownModel[]>;
    courtActionsType$!: Observable<DropdownModel[]>;
    conditionTypes$!: Observable<DropdownModel[]>;
    courtOrder$!: Observable<DropdownModel[]>;
    findingsType$!: Observable<DropdownModel[]>;
    adijuctedDecisions$!: Observable<DropdownModel[]>;
    hearingStatusTypeItem$!: Observable<DropdownModel[]>;
    courtDetailsForm!: FormGroup;
    userInfo!: AppUser;
    times: string[] = [];
    id!: string;
    courtDetails!: CourtDetails;
    courtAction: CourtAction[] = [];
    petitionDetails!: PetitionDetails;
    daNumber!: string;
    courtActionDescription: string[] = [];

    filteroptn = '?filter={"nolimit":true}';

    constructor(
        private readonly _commonHttpService: CommonHttpService,
        private readonly _formBuilder: FormBuilder,
        private readonly _authService: AuthService,  
        private readonly _alertService: AlertService, 
        private readonly _router: Router,
        private readonly _dataStoreService: DataStoreService,
        private readonly _courtResolverService: CourtResolverService
        ) { }

    ngOnInit() {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.getPetitionDetails();
        this.userInfo = this._authService.getCurrentUser();
        this.initiateFormGroup();
         if (this.id) {
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    where: {
                        intakeservicerequestid: this.id
                    }
                },
                'intakeservicerequestcourtaction/getcourtaction' + '?filter'
            )
            .subscribe(
                (result) => {
                    if (result[0]) {
                        if (result[0]['courtaction']) {
                        result[0].courtactiontypekey = result[0].courtaction.map((item: { courtactiontypekey: any; }) => item.courtactiontypekey);
                        result[0].courtaction = result[0].courtaction.map((item: { courtactiontypekey: any; }) => {
                            return {courtactiontypekey: item.courtactiontypekey};
                        });
                        this.courtAction = result[0].courtaction;
                    }
                        this.patchForm(result[0]);
                    }
                },
                (_error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
         }
        this.times = this._courtResolverService.generateTimeList(true);
    }

    initiateFormGroup() {
        this.courtDetailsForm = this._formBuilder.group({
            legalcounselname: ['', Validators.required],
            magistratename: ['', Validators.required],
            workername: this.userInfo ? this.userInfo.user.userprofile.displayname : '',
            hearingdatetime: [''],
            courtactiontypekey: [''],
            courtordertypekey: ['', Validators.required],
            courtorderdatetime: [''],
            conditiontypekey: ['', Validators.required],
            conditiontypedescription: ['', Validators.required],
            conditiontypecompletiondatetime: [''],
            terminationdatetime: [''],
            adjudicationdatetime: [''],
            adjudicationdecision: ['', Validators.required],
            allegationid: ['', Validators.required],
            adjudicationDate: ['', Validators.required],
            adjudicationTime: ['', Validators.required],
            hearingDate: ['', Validators.required],
            hearingTime: ['', Validators.required],
            terminationDate: ['', Validators.required],
            terminationTime: ['', Validators.required],
            orderDate: ['', Validators.required],
            orderTime: ['', Validators.required],
            completionDate: ['', Validators.required],
            completionTime: ['', Validators.required],
            courtcasenumber: [''],
            jurisdiction: [''],
            hearingstatustypekey: ['', Validators.required],
            decisionnotes: ['', Validators.required],
            nexthearingdate: ['']
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
        this.courtDetails.intakeservicerequestpetitionid = this.petitionDetails.intakeservicerequestpetitionid;
        this._commonHttpService.create(this.courtDetails, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.CourtActionAddUrl)
        .subscribe(
            _result => {
            this._alertService.success('Court details saved successfully!');
            },
            _error => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    } else {
        this._alertService.error('Please fill all fields');
    }
    }

    selectCourtActionType(event: any) {
            this._courtResolverService.selectCourtType(event, 'courtAction', 'courtactiontypekey', this.courtActionsType$, 'courtActionDescription');
    }
    

    private loadDroddowns() {
        const filterParams = encodeURIComponent(JSON.stringify({ 
            nolimit: true,
            order: "name asc" 
        }));

        const AllegationUrl = `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Allegation.AllegationURL}?filter=${filterParams}`;
        const source = forkJoin([
            this._commonHttpService.getArrayList({}, AllegationUrl),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.CourtActionTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.ConditionTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.CourtOrderTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.FindingTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.AdjudicatedDecisionTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.HearingStatusTypeUrl + this.filteroptn)
        ]).pipe(
            map(([offenceCategories, courtActionsType, conditionTypes, courtOrder, findingsType, adijuctedDecisions, hearingStatusType]: any) => {
                return {
                    offenceCategories: this._courtResolverService.mapToDropdownModel(offenceCategories['data'], 'name', 'allegationid'),
                    courtActionsType: this._courtResolverService.mapToDropdownModel(courtActionsType, 'description', 'courtactiontypekey'),
                    conditionTypes: this._courtResolverService.mapToDropdownModel(conditionTypes, 'description', 'conditiontypekey'),
                    courtOrder: this._courtResolverService.mapToDropdownModel(courtOrder, 'description', 'courtordertypekey'),
                    findingsType: this._courtResolverService.mapToDropdownModel(findingsType, 'description', 'findingtypekey'),
                    adijuctedDecisions: this._courtResolverService.mapToDropdownModel(adijuctedDecisions, 'description', 'adjudicateddecisiontypekey'),
                    hearingStatusType: this._courtResolverService.mapToDropdownModel(hearingStatusType, 'description', 'hearingstatustypekey'),
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

        this.courtActionsType$.subscribe(data => {
            if (data) {
                const courtActionValue = this.courtAction.map(res => res.courtactiontypekey);
                this.courtActionDescription = this._courtResolverService.filterAndMapItems(courtActionValue, data);

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
                } else {
                    this._router.navigate([`/pages/case-worker/${this.id}/${this.daNumber}/court/petition-detail`]);
                }
            });
    }
}
