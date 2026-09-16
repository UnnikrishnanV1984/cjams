
import {map} from 'rxjs/operators';
import { MaltreatmentAllegations } from './../../_entities/caseworker.data.model';
import { Component, OnInit } from '@angular/core';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import { DSDSActionSummary } from '../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { CommonHttpService, AlertService, DataStoreService } from '../../../../@core/services';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable } from 'rxjs';
import { MaltreatmentInformation } from '../maltreatment-information/_entites/maltreatment.data.model';
import { AllegationItem, ChoosenAllegation } from './_entities/investigation-plan.data.model';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
declare var $: any;
@Component({
    selector: 'as-investigation-plan',
    templateUrl: './as-investigation-plan.component.html',
    styleUrls: ['./as-investigation-plan.component.scss'],
    standalone: false
})
export class AsInvestigationPlanComponent implements OnInit {
    id: string;
    daNumber: string;
    intakeCases: any;
    daTypeKey: string;
    allegationDropDownItems: DropdownModel[];
    allegationStatusDropDown$: Observable<DropdownModel[]>;
    identifiedAllegations: ChoosenAllegation[] = [];
    allegationItems: AllegationItem[] = [];
    filteredAllegationItems: AllegationItem[] = [];
    choosenAllegation: ChoosenAllegation;
    actionTitle: string;
    maltreatementAlegationForm: FormGroup;
    addePersons = [];
    relationShipToRADropdownItems$: Observable<any[]>;
    identifiedMaltreatementAllegations = [];
    reportedMaltreatementAllegations = [];
    editIndex = null;
    dsdsActionsSummary = new DSDSActionSummary();
    maltreatmentAllegations = new MaltreatmentAllegations();
    maltreatmentInformation: MaltreatmentInformation[] = [];
    maltreatmentReported: MaltreatmentInformation[] = [];
    maltreatmentIdentified: MaltreatmentInformation[] = [];
    maltreatmentInfo = new MaltreatmentInformation();
    editReportedIndex = null;
    isInitialLoad = false;
    actionText = 'Add';
    investigationallegationid = null;
    disableAdd = false;
    indicatorsID : Array<any> = [];
    constructor(
        private readonly _commonHttpService: CommonHttpService,
        private readonly _alertService: AlertService,
        private readonly formBuilder: FormBuilder,
        private readonly _dataStoreService: DataStoreService
    ) {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }

    ngOnInit() {
        this.initialMaltreatmentFormGroup();
        this.loadDropdowns();
        this.getMaltreatmentStatus();
        this.isInitialLoad = true;
        this._dataStoreService.currentStore.subscribe(store => {
            if (this.isInitialLoad && store['dsdsActionsSummary']) {
                this.dsdsActionsSummary = store['dsdsActionsSummary'];
                if (this.dsdsActionsSummary) {
                    this.getMaltreatmentInformation();
                    this.loadAllegation();
                    this.isInitialLoad = false;
                }
            }
        });
    }

    findAllegationID(allegationName) {
        const allegation = this.allegationDropDownItems.find(item => item.text === allegationName);
        if (allegation) {
            return allegation.value;
        }
        return 'id';
    }
    private initialMaltreatmentFormGroup() {
        this.maltreatementAlegationForm = this.formBuilder.group({
            allegationid: ['', Validators.required],
            indicators: [''],
            personid: ['', Validators.required],
            relationship: [''],
            investigationalegationstatuskey: [''],
            outcome: ['']
        });
    }

    private loadDropdowns() {
        this._commonHttpService
            .getSingle(
                {
                    method: 'get',
                    where: { intakeservreqid: this.id }
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            )
            .subscribe(result => {
                this.addePersons = result.data;
            });
        this.relationShipToRADropdownItems$ = this._commonHttpService.getArrayList(
            {
                where: { activeflag: 1 },
                method: 'get',
                nolimit: true
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.RelationshipTypesUrl + '?filter'
        );
    }

    getMaltreatmentInformation() {
        this._commonHttpService
            .getArrayList(
                {
                    where: { investigationid: this.dsdsActionsSummary.da_investigationid },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.MaltreatmentInformation + '?filter'
            )
            .subscribe(data => {
                this.maltreatmentInformation = data;
                if (this.maltreatmentInformation) {
                    this.maltreatmentReported = this.maltreatmentInformation.filter(reporter => reporter.isreported === 'reported' && reporter.investigationallegation);
                    this.maltreatmentIdentified = this.maltreatmentInformation.filter(reporter => reporter.isreported === 'identifer' && reporter.investigationallegation);
                }
            });
    }

    getMaltreatmentStatus() {
        this.allegationStatusDropDown$ = this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 22, teamtypekey: 'AS' },
                    method: 'get'
                },
                'referencetype/gettypes' + '?filter'
            ).pipe(
            map(data => {
                return data.map(
                    list =>
                        new DropdownModel({
                            text: list.description,
                            value: list.ref_key
                        })
                );
            }));
    }

    getIndicatorsID(event) {
        if (event.option.value && event.option.selected) {
            this.indicatorsID.push({
                indicatorid: event.option.value
            });
        } else if (!event.option.selected) {
            this.indicatorsID = this.indicatorsID.filter(item => item.indicatorid !== event.option.value);
        }
    }

    loadAllegation() {
        this.choosenAllegation = new ChoosenAllegation();
        this.allegationItems = [];
        this.allegationDropDownItems = [];
        this.filteredAllegationItems = [];
        const url = CaseWorkerUrlConfig.EndPoint.DSDSAction.as_maltreatment.AllegationsIndicaorUrl + '?filter';
        this._commonHttpService
            .getArrayList(
                {
                    where: { intakeservreqtypeid: this.dsdsActionsSummary.da_typeid },
                    method: 'get'
                },
                url
            )
            .subscribe(result => {
                this.allegationItems = result.map(item => new AllegationItem(item));

                this.allegationDropDownItems = this.allegationItems.map(
                    item =>
                        new DropdownModel({
                            text: item.allegationname,
                            value: item.allegationid
                        })
                );
            });
    }

    allegationOnChange(option: any) {
        this.loadSelectedAllegation(option.value);
        this.choosenAllegation.allegationID = option.value;
    }

    getIndicator(option: any) {
        this.loadSelectedAllegation(option);
        this.choosenAllegation.allegationID = option;
    }

    loadSelectedAllegation(selectedAllegation: string) {
        this.filteredAllegationItems = this.allegationItems.filter(item => {
            return item.allegationid === selectedAllegation;
        });
    }
    saveAllegations() {
        let ispresent = false;
        this.identifiedAllegations.forEach(element => {
            if (this.choosenAllegation.allegationValue === element.allegationValue) {
                element.indicators = this.choosenAllegation.indicators;
                ispresent = true;
            }
        });
        if (!ispresent) {
            this.identifiedAllegations.push(this.choosenAllegation);
        }
    }

    edit(allegation, index) {
        this.editIndex = index;
        this.actionText = 'Update';
        this.maltreatementAlegationForm.enable();
        this.maltreatementAlegationForm.patchValue(allegation);
        setTimeout(() => {
            this.maltreatementAlegationForm.patchValue({ allegationid: allegation.allegationid });
        }, 1000);
        this.allegationOnChange({ value: allegation.allegationid });
    }

    editReported(allegation, index) {
        this.editReportedIndex = index;
        this.actionText = 'Update';
        this.maltreatementAlegationForm.patchValue(allegation);
        setTimeout(() => {
            this.maltreatementAlegationForm.patchValue({ allegationid: { value: allegation.allegationid.value, text: allegation.allegationid.text } });
        }, 1000);
        this.allegationOnChange({ value: allegation.allegationid });
    }

    resetForm() {
        this.maltreatementAlegationForm.reset();
        this.actionText = 'Add';
        this.disableAdd = false;
        this.editIndex = null;
        this.editReportedIndex = null;
        this.indicatorsID = [];
    }

    saveAllegationForm() {
        const maltreatmentAllegation = this.maltreatementAlegationForm.getRawValue();
        this.maltreatmentAllegations.investigationallegationid = this.maltreatmentInfo ? this.maltreatmentInfo.investigationallegation[0].investigationallegationid : null;
        this.maltreatmentAllegations.allegationid = maltreatmentAllegation.allegationid;
        this.maltreatmentAllegations.relationshiptypekey = maltreatmentAllegation.relationship;
        this.maltreatmentAllegations.maltreatoractorid = null;
        this.maltreatmentAllegations.maltreatorname = null;
        this.maltreatmentAllegations.allegationname = null;
        this.maltreatmentAllegations.maltreatmentid = this.maltreatmentInfo ? this.maltreatmentInfo.investigationallegation[0].maltreatmentid : null;
        this.maltreatmentAllegations.personid = null;
        this.maltreatmentAllegations.intakeservicerequestactorid = maltreatmentAllegation.personid;
        this.maltreatmentAllegations.investigationid = this.dsdsActionsSummary.da_investigationid;
        this.maltreatmentAllegations.outcome = maltreatmentAllegation.outcome;
        this.maltreatmentAllegations.investigationalegationstatuskey = maltreatmentAllegation.investigationalegationstatuskey;
        this.maltreatmentAllegations.isjurisdiction = '0';
        this.maltreatmentAllegations.isapproximatedate = '';
        this.maltreatmentAllegations.sextrafficking = '';
        this.maltreatmentAllegations.indicator = this.indicatorsID;
        const maltreatmentObject = Object.assign(this.maltreatmentAllegations);
        this._commonHttpService.create(maltreatmentObject, 'investigationmaltreatment/addupdate').subscribe(data => {
            if (data) {
                if (this.maltreatmentInfo) {
                    this._alertService.success('Maltreatment Allegation Updated Successfully');
                } else {
                    this._alertService.success('Maltreatment Allegation Added Successfully');
                }
                this.getMaltreatmentInformation();
            }
        });
        if (this.editIndex) {
            this.identifiedMaltreatementAllegations[this.editIndex] = maltreatmentAllegation;
        } else if (this.editReportedIndex !== null) {
            this.reportedMaltreatementAllegations[this.editReportedIndex] = maltreatmentAllegation;
        } else {
            this.identifiedMaltreatementAllegations.push(maltreatmentAllegation);
        }

        $('#AddEditMaltreatmentAllegation').modal('hide');
        this.resetForm();
    }
    viewAllegation(item, action) {
        this.maltreatmentInfo = Object.assign({}, item);
        if (this.maltreatmentInfo && this.maltreatmentInfo.investigationallegation) {
            setTimeout(() => {
                this.maltreatementAlegationForm.patchValue({
                    allegationid: this.maltreatmentInfo.investigationallegation[0].allegationid,
                    personid: this.maltreatmentInfo.intakeservicerequestactorid,
                    relationship: this.maltreatmentInfo.investigationallegation[0].relationshiptypekey,
                    investigationalegationstatuskey: this.maltreatmentInfo.investigationallegation[0].investigationalegationstatuskey,
                    outcome: this.maltreatmentInfo.investigationallegation[0].outcome
                });
            }, 300);
            this.getIndicator(this.maltreatmentInfo.investigationallegation[0].allegationid);

            if (this.maltreatmentInfo.investigationallegation[0].indicator) {
                const indicatorsID = this.maltreatmentInfo.investigationallegation[0].indicator.map(list => list.indicatorid);
                indicatorsID.forEach(data => {
                    this.indicatorsID.push({
                        indicatorid: data
                    });
                });
                setTimeout(() => {
                    this.maltreatementAlegationForm.patchValue({
                        indicators: indicatorsID
                    });
                }, 300);
            }
            if (action === 'View') {
                this.disableAdd = true;
                setTimeout(() => {
                    this.maltreatementAlegationForm.disable();
                }, 300);
            } else if (action === 'Reported') {
                this.disableAdd = false;
                setTimeout(() => {
                    this.maltreatementAlegationForm.enable();
                    this.maltreatementAlegationForm.get('allegationid').disable();
                    this.maltreatementAlegationForm.get('indicators').disable();
                }, 300);
            } else {
                this.disableAdd = false;
                this.maltreatementAlegationForm.enable();
            }
            $('#AddEditMaltreatmentAllegation').modal('show');
        }
    }
    addAllegation() {
        this.maltreatmentInfo = null;
        this.disableAdd = false;
        this.maltreatementAlegationForm.enable();
        this.maltreatementAlegationForm.reset();
    }
}
