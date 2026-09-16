
import {map, pluck, share} from 'rxjs/operators';
import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';
import { FormArray, FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { forkJoin ,  Observable } from 'rxjs';

import { ControlUtils } from '../../../../../../../@core/common/control-utils';
import {
    CheckboxModel,
    DropdownModel
} from '../../../../../../../@core/entities/common.entities';
import {
    AlertService,
    CommonHttpService,
    DataStoreService
} from '../../../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../../case-worker-url.config';
import {
    Actor,
    InvolvedActor,
    PersonDetail,
    ActorRelation
} from '../../../_entities/involvedperson.data.model';
import { CASE_STORE_CONSTANTS } from '../../../../../_entities/caseworker.data.constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'involved-person-role-role-of-person',
    templateUrl: './involved-person-role-role-of-person.component.html',
    styleUrls: ['./involved-person-role-role-of-person.component.scss']
})
export class InvolvedPersonRoleRoleOfPersonComponent implements OnInit {
    @Input() addedActor: Actor[] = [];
    @Input() person$: Observable<PersonDetail>;
    @Input() addedActorRelations: ActorRelation[] = [];
    @Output() actorDataChanged = new EventEmitter<Actor[]>();
    actorTypes$: Observable<DropdownModel[]>;
    relationships$: Observable<DropdownModel[]>;
    actorType$: Observable<InvolvedActor>;
    actorFormGroup: FormGroup;
    relationCheckboxItems: CheckboxModel[] = [];
    relationCheckboxFormArray: FormArray;

    id: string;
    personId: string;
    actorId: string;
    showRelation: boolean;
    relationIds: string[] = [];
    private actor: Actor = new Actor();
    private actorRelationship: ActorRelation = new ActorRelation();
    constructor(
        route: ActivatedRoute,
        private _commonHttpService: CommonHttpService,
        private formBuilder: FormBuilder,
        private _alertService: AlertService,
        private _dataStoreService: DataStoreService
    ) {
        this.id =
            this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.personId = route.snapshot.params.personid;
        this.actorId = route.snapshot.params.actorid;
    }

    ngOnInit() {
        this.relationCheckboxFormArray = this.formBuilder.array([
            this.formBuilder.control(false)
        ]);

        this.actorFormBuilderGroup();
        this.actorType();
        this.relationship();
        this.showRelation = true;
        if (this.personId !== '0' && this.actorId !== '0') {
            this.person$.subscribe(result => {
                this.actor = Object.assign(result.data.personroledetails[0]);
                 this.actor.actortypedesc = Object.assign({
                    actortype: result.data.personroledetails[0].actor.actortype ? result.data.personroledetails[0].actor.actortype : null,
                    typedescription: result.data.personroledetails[0].actor.actortypedesc ? result.data.personroledetails[0].actor.actortypedesc.typedescription : null
                });
                return this.addedActor.push(this.actor);
            });
        }
    }

    actorType() {
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                {
                    order: 'typedescription asc',
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
                    .ActorType + '?filter'
            )
        ]).pipe(
            map(result => {
                return {
                    actor: result[0].map(
                        res =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.actortype
                            })
                    )
                };
            }),
            share(),);

        this.actorTypes$ = source.pipe(pluck('actor'));
    }

    relationship() {
        this.relationships$ = this._commonHttpService.getArrayList(
            {
                where: { activeflag: '1' },
                method: 'get',
                nolimit: true
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
                .Relationship + '?filter'
        );

        (this.relationships$ as Observable<CheckboxModel[]>).subscribe(item => {
            this.relationCheckboxItems = item;
            this.actorFormGroup.patchValue({
                Race: ControlUtils.buildCheckBoxGroup(
                    this.formBuilder,
                    this.relationCheckboxItems,
                    []
                )
            });
            this.relationCheckboxFormArray = ControlUtils.buildCheckBoxGroup(
                this.formBuilder,
                this.relationCheckboxItems,
                []
            );
        });
    }

    addRole(actor: Actor) {
        if (this.actorFormGroup.valid && this.actorFormGroup.dirty) {
            this.actor.intakeserviceid = this.id;
            this.actor.intakeservicerequestpersontypekey = actor.actortype;
            this.actor.actortypedesc = Object.assign({
                actortype: actor.actortype,
                typedescription: this.actor.typedescription
            });
            this.actor.actor = Object.assign({
                actorid: actor.actorid,
                actortype: actor.actortype

            });
            this.actor.actor.actortypedesc = this.actor.actortypedesc;
            this.addedActor.push(Object.assign(this.actor, actor));
            if (this.addedActor.length > 1) {
                this.addedActor = [];
                this.actor.actortypedesc = Object.assign({
                    actortype: actor.actortype,
                    typedescription: this.actor.typedescription
                });
                this.actor.actor = Object.assign({
                    actorid: actor.actorid,
                    actortype: actor.actortype
                });
                this.actor.actor.actortypedesc = this.actor.actortypedesc;
                this.addedActor.push(Object.assign(this.actor, actor));
            }
            this.clearRole();
            this._alertService.success('Person Role added successfully');
            this.actorDataChanged.emit(this.addedActor);
        } else {
            this._alertService.warn('Please fill mandatory fields!');
        }
    }

    actorOnChange(option) {
        this.actor.typedescription = option.label;
        if (option.label === 'Reported Adult') {
            this.showRelation = false;
            this.addedActorRelations = [];
        } else {
            this.showRelation = true;
        }

    }

    onChangeRelation($event) {
        if ($event.target.checked) {
            this.actorRelationship.insertedby = 'SYSTEM';
            this.actorRelationship.relationshiptypekey = $event.target.value;
            this.addedActorRelations.push(
                Object.assign(this.actorRelationship)
            );
            this.actorRelationship = Object.assign({});
        } else {
            this.addedActorRelations.forEach((item, index) => {
                if (item.relationshiptypekey === $event.target.value) {
                    this.addedActorRelations.splice(index, 1);
                }
            });
        }
    }
    confirmActor(actor: Actor) {
        this.addedActor.splice(actor.index, 1);
        this.clearRole();
        this.addedActor = this.addedActor.map((item, ix) => {
            item.index = ix;
            return item;
        });
        this.actorDataChanged.emit(this.addedActor);
    }

    clearRole() {
        this.actorFormGroup.reset();
        this.actorFormBuilderGroup();
    }

    actorFormBuilderGroup() {
        this.actorFormGroup = this.formBuilder.group({
            actortype: [''],
            relation: ['']
        });
    }
}
