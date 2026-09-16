
import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import moment from 'moment';
import { Subject, Observable ,  forkJoin } from 'rxjs';

import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService } from '../../../../../@core/services';
import { SafetyPlanView, SaftyPlan, SaftyPlanDangerInfluence } from '../../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { InvolvedPerson } from '../../involved-person/_entities/involvedperson.data.model';
import { SaftyPlanAction, SaftyPlanBlob } from './../../../_entities/caseworker.data.model';
import { DataStoreService } from '../../../../../@core/services/data-store.service';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

// tslint:disable-next-line:import-blacklist
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'safety-plan',
    templateUrl: './safety-plan.component.html',
    styleUrls: ['./safety-plan.component.scss'],
    standalone: false
})
export class SafetyPlanComponent implements OnInit {
    id!: string;
    safetyPlanFormGroup!: FormGroup;
    minDate = new Date();
    maxDate = new Date();
    saftyPlan!: SaftyPlan;
    involvedPersons: InvolvedPerson[] = [];
    safetyPlanView = new SafetyPlanView();
    saftyPlan$ = new Subject<SaftyPlan>();
    savedSafeCDangerInfluence : Array<any> = [];
    lastParticipantsCall: any[] = [];
    involevedPerson$!: Observable<InvolvedPerson[]>;
    isSaveBtnHide = false;
    constructor(
        private formBuilder: FormBuilder,
        private _commonHttpService: CommonHttpService,
        private _alertService: AlertService,
        private route: ActivatedRoute,
        private _store: DataStoreService
    ) {}

    ngOnInit() {
        this.id = this._store.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.safetyPlanView.daNumber = this._store.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.intializeForm(new SaftyPlan());
        this.getSafetyPlanInfo();
        this.getInvolvedPerson();
        this._store.currentStore.subscribe((res) => {
            //No operation needed here
        });
    }

    intializeForm(saftyPlan: SaftyPlan) {
        let dangerInfluenceForms: FormGroup[] = [];
        if (saftyPlan.dangerinfluence) {
            dangerInfluenceForms = saftyPlan.dangerinfluence.map((item) => {
                return this.createSafetyPlanForm(item);
            });
        }
        this.safetyPlanFormGroup = this.formBuilder.group({
            intakeserviceid: [saftyPlan.intakeserviceid ? saftyPlan.intakeserviceid : ''],
            external_templateid: [saftyPlan.external_templateid ? saftyPlan.external_templateid : ''],
            plandate: [saftyPlan.plandate ? saftyPlan.plandate : new Date()],
            submissionid: [saftyPlan.submissionid ? saftyPlan.submissionid : ''],
            dangerinfluence: this.formBuilder.array([...dangerInfluenceForms])
        });
        this.safetyPlanFormGroup.setControl('safetyplanactor', this.formBuilder.array([]));
    }
    createSafetyPlanForm(dangerinfluence: SaftyPlanDangerInfluence): FormGroup {
        let actionsForm: FormGroup[] = [];
        if (dangerinfluence.action) {
            actionsForm = dangerinfluence.action.map((item) => {
                return this.initActionRequired(item);
            });
        }
        return this.formBuilder.group({
            dangerinfluencenumber: [dangerinfluence.dangerinfluencenumber ? dangerinfluence.dangerinfluencenumber : ''],
            dangerinfluencedesc: [dangerinfluence.dangerinfluencedesc ? dangerinfluence.dangerinfluencedesc : ''],
            completiondate: [dangerinfluence.completiondate ? dangerinfluence.completiondate : ''],
            partiesname: [dangerinfluence.partiesname ? dangerinfluence.partiesname : ''],
            reevaluationdate: [dangerinfluence.reevaluationdate ? dangerinfluence.reevaluationdate : ''],
            action: this.formBuilder.array([...actionsForm])
        });
    }

    private getSafetyPlanInfo() {
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
                    objectid: this.id,
                    assessmenttemplatename: 'SAFE-C'
                },
                page: 1,
                limit: 10
            },
            'admin/assessment/getassessment?filter'
        );
      forkJoin([safeCAssessmentRequest, involvedPersonRequest]).subscribe((item) => {
            const safetyPlanBlob = <SaftyPlanBlob>item[0][0];
            this.saftyPlan = new SaftyPlan();
            if (safetyPlanBlob) {
                this.savedSafeCDangerInfluence = safetyPlanBlob.submissiondata['safeCDangerInfluence'];
                this.safetyPlanView.planDate = safetyPlanBlob.submissiondata['dateoflastsafetyplan'];
                this.saftyPlan.external_templateid = safetyPlanBlob.externaltemplateid;
                this.saftyPlan.submissionid = safetyPlanBlob.submissionid;
            }
            if (!this.safetyPlanView.planDate) {
                this.safetyPlanView.planDate = new Date().toString();
            }
            this.safetyPlanFormGroup.patchValue({ plandate: this.safetyPlanView.planDate });
            this.saftyPlan.plandate = moment(this.safetyPlanView.planDate).format('YYYY-MM-DD');
            this.saftyPlan.intakeserviceid = this.id;
            if (this.savedSafeCDangerInfluence.length > 0) {
                this.saftyPlan.dangerinfluence = this.savedSafeCDangerInfluence.map((infItem) => {
                    return <SaftyPlanDangerInfluence>{
                        dangerinfluencenumber: infItem.text,
                        action: [new SaftyPlanAction()]
                    };
                });
            }
            this.intializeForm(this.saftyPlan);
            this.involvedPersons = (item[1]['data'] as any) as InvolvedPerson[];
            this.setInvolvedPersons();
        });
    }

    initActionRequired(saftyPlanAction: SaftyPlanAction): FormGroup {
        return this.formBuilder.group({
            actiondescription: ['']
        });
    }

    addActionRequired(actionFormArray: FormArray) {
        actionFormArray.push(this.initActionRequired(new SaftyPlanAction()));
    }

    removeActionRequired(actionFormArray: any, j: number) {
        actionFormArray.splice(j, 1);
    }

    submitActionRequired(saftyPlan: SaftyPlan) {
        this.saftyPlan.dangerinfluence = saftyPlan.dangerinfluence.map((item: any) => {
            item.dangerinfluencedesc = item.dangerinfluencedesc ? item.dangerinfluencedesc : null;
            item.completiondate = item.completiondate ? item.completiondate : null;
            item.reevaluationdate = item.reevaluationdate ? item.reevaluationdate : null;
            item.action = item.action.map((actItem: any) => {
                actItem.actiondescription = actItem.actiondescription ? actItem.actiondescription : null;
                return actItem;
            });
            return item;
        });
        const checkMandatory = saftyPlan.dangerinfluence.filter((res) => !res.completiondate || !res.reevaluationdate);
        if (checkMandatory.length === 0) {
            this._commonHttpService.create(saftyPlan, 'Safetyplans/add').subscribe(
                (item) => {
                    this._alertService.success('Safety plan saved successfully.');
                },
                (error) => {
                    this._alertService.error('Unable to save safety plan.');
                }
            );
        } else {
            this._alertService.warn('Please fill mandatory fields!');
        }
    }

    safetyPlanPrintView(saftyPlan: SaftyPlan) {
        this.saftyPlan$.next(saftyPlan);
        $('#safetyPlanPrintView').modal('show');
    }

    private setInvolvedPersons() {
        const caseHeadDetail = this.involvedPersons.find((item) => item.rolename === 'CASEHD');
        if (caseHeadDetail) {
            this.safetyPlanView.caseHeadName = caseHeadDetail.lastname.trim() + ', ' + caseHeadDetail.firstname.trim();
        }

        const childDetails = this.involvedPersons.find((item) => item.rolename === 'RC');
        if (childDetails) {
            this.safetyPlanView.childName = childDetails.lastname.trim() + ', ' + childDetails.firstname.trim();
        }
        this.safetyPlanView.planDate = moment(new Date()).format('MM/DD/YYYY');
    }

    private addPerson(person: any) {
        const control = <FormArray>this.safetyPlanFormGroup.controls['safetyplanactor'];
        control.push(this.createFormGroup(person));
    }
    private deletePerson(index: number, e: any) {
        const control = <FormArray>this.safetyPlanFormGroup.controls['safetyplanactor'];
        control.removeAt(index);
    }
    private createFormGroup(person: any) {
        return this.formBuilder.group({
            intakeservicerequestactorid: [person.actorid ? person.actorid : null],
            personFullName: [person.firstname ? person.firstname + ' , ' + person.lastname : null],
            firstname: [person.firstname ? person.firstname : null],
            lastname: [person.lastname ? person.lastname : null],
            role: [person.roles ? person.roles[0].intakeservicerequestpersontypekey : null],
            roleDesc: [person.roles ? person.roles[0].typedescription : null],
            dob: [person.dob ? person.dob : null],
            issignrefuse: [0],
            signimage: [null],
        });
    }
    changePerson(event: any) {
        if (event.source.selected && event.source.value !== this.lastParticipantsCall) {
            this.addPerson(event.source.value);
            this.lastParticipantsCall = event.source.value;
        } else if (!event.source.selected) {
            const control = <FormArray>this.safetyPlanFormGroup.controls['safetyplanactor'];
            control.controls.forEach((cont) => {
                if (event.source.value.rolename === cont.value.role) {
                    const removeIndex = control.controls.indexOf(cont);
                    this.deletePerson(removeIndex, event);
                }
            });
        } else {
            this.lastParticipantsCall = [];
        }
    }
    checkSignRefuse() {
        const control = <FormArray>this.safetyPlanFormGroup.controls['safetyplanactor'];
        let signRefuseCount = 0;
        control.controls.forEach((cont) => {
            if (cont.value.issignrefuse) {
                signRefuseCount = signRefuseCount + 1;
            }
        });
        if (signRefuseCount > 0) {
            this.isSaveBtnHide = true;
        } else {
            this.isSaveBtnHide = false;
        }
    }
    private getInvolvedPerson() {
        this.involevedPerson$ = this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    where: { intakeservreqid: this.id }
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            ).pipe(
            map((res: any) => {
                return res['data'];
            }));
    }
}
