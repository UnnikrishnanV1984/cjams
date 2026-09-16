
import {pluck, share, map} from 'rxjs/operators';
import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Observable ,  forkJoin } from 'rxjs';

import { ControlUtils } from '../../../../../../../@core/common/control-utils';
import { CheckboxModel, DropdownModel } from '../../../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService } from '../../../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../../case-worker-url.config';
import { Alias, People, PersonDetail, PersonIdentifier } from '../../../_entities/involvedperson.data.model';
import * as interpreter from './_configurations/interpreter.json';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'involved-person-role-profile',
    templateUrl: './involved-person-role-profile.component.html',
    styleUrls: ['./involved-person-role-profile.component.scss']
})
export class InvolvedPersonRoleProfileComponent implements OnInit {
    @Input() addedPersons: People[];
    @Input() addedIdentifier: PersonIdentifier[] = [];
    @Input() addedAlias: Alias[] = [];
    @Input() person$: Observable<PersonDetail>;
    @Input() profileFormGroup: FormGroup;
    @Input() raceIds: string[] = [];
    @Output() personIdentifierChanged = new EventEmitter<PersonIdentifier[]>();
    @Output() personAliasChanged = new EventEmitter<Alias[]>();
    @Output() personRaceIdsChanged = new EventEmitter<string[]>();

    person: PersonDetail;
    personId: string;
    raceType: string[];
    ssn: boolean;
    dob: boolean;
    genderItems$: Observable<DropdownModel[]>;
    ethnicGroupItems$: Observable<DropdownModel[]>;
    maritalTypeItems$: Observable<DropdownModel[]>;
    raceTypeItems$: Observable<DropdownModel[]>;
    languageItems$: Observable<DropdownModel[]>;
    incomeItems$: Observable<DropdownModel[]>;
    personIdentifierItems$: Observable<DropdownModel[]>;
    raceCheckboxItems: CheckboxModel[] = [];
    raceCheckboxFormArray: FormArray;
    personProfileFormGroup: FormGroup;
    interpreterDropdown: DropdownModel[];
    // raceIds: string[] = [];
    minDate = new Date();
    private personIdentifier: PersonIdentifier = new PersonIdentifier();
    private personAlias: Alias = new Alias();

    constructor(private formBuilder: FormBuilder, private _commonHttpService: CommonHttpService, private _alertService: AlertService, route: ActivatedRoute) {
        this.personId = route.snapshot.params.personid;
    }

    ngOnInit() {
        this.interpreterDropdown = <any>interpreter;
        this.personProfileFormBuilderGroup();
        this.involvedPersonDropdown();
        this.raceCheckboxFormArray = this.formBuilder.array([this.formBuilder.control(false)]);

        if (this.personId !== '0') {
            this.person$.subscribe((result) => {
                if (result.data.personbasicdetails.dob) {
                    result.data.personbasicdetails.dob = new Date(result.data.personbasicdetails.dob);
                }
                  this.personProfileFormGroup.get('profile').patchValue(result.data.personbasicdetails);
                this.ssn = result.data.personbasicdetails.refusessn;
                this.dob = result.data.personbasicdetails.refusedob;
                if (result.data.personbasicdetails.racetypekey) {
                    this.raceType = result.data.personbasicdetails.racetypekey.split(',');
                    this.raceIds = this.raceType;
                }
                result.data.personbasicdetails.personidentifier.forEach((identifier: PersonIdentifier) => {
                    return this.addedIdentifier.push(identifier);
                });
                result.data.personbasicdetails.alias.forEach((alias: Alias) => {
                    return this.addedAlias.push(alias);
                });
            });
        }
    }

    onChangeRace($event) {
        if ($event.target.checked) {
            this.raceIds.push($event.target.value);
            this.personRaceIdsChanged.emit(this.raceIds);
        } else {
            this.raceIds.splice($event.target.value, 1);
            this.personRaceIdsChanged.emit(this.raceIds);
        }
    }

    private involvedPersonDropdown() {
        const source = forkJoin([
            this._commonHttpService.create(
                {
                    where: { activeflag: '1' },
                    method: 'post',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.GenderTypeUrl + '/genderlist'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.EthnicGroupTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.MartialStatusTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.RaceTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.LanguageTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.IncomeTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonIdentifierTypeUrl + '?filter'
            )
        ]).pipe(
            map((result) => {
                return {
                    gender: result[0].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.gendertypekey
                            })
                    ),
                    ethnicgroup: result[1].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.ethnicgrouptypekey
                            })
                    ),
                    maritalstatus: result[2].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.maritalstatustypekey
                            })
                    ),
                    races: result[3].map(
                        (res) =>
                            new CheckboxModel({
                                text: res.typedescription,
                                value: res.racetypekey,
                                isSelected: false
                            })
                    ),
                    languages: result[4].map(
                        (res) =>
                            new DropdownModel({
                                text: res.languagetypename,
                                value: res.languagetypeid
                            })
                    ),
                    income: result[5].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.incometypekey
                            })
                    ),
                    personidentifier: result[6].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.personidentifiertypekey
                            })
                    )
                };
            }),
            share(),);

        this.genderItems$ = source.pipe(pluck('gender'));
        this.ethnicGroupItems$ = source.pipe(pluck('ethnicgroup'));
        this.maritalTypeItems$ = source.pipe(pluck('maritalstatus'));
        this.languageItems$ = source.pipe(pluck('languages'));
        this.incomeItems$ = source.pipe(pluck('income'));
        this.personIdentifierItems$ = source.pipe(pluck('personidentifier'));

        (source.pipe(pluck('races')) as Observable<CheckboxModel[]>).subscribe((item) => {
            this.raceCheckboxItems = item;
            this.personProfileFormGroup.patchValue({
                Race: ControlUtils.buildCheckBoxGroup(this.formBuilder, this.raceCheckboxItems, (this.raceType) ? this.raceType : [])
            });
            this.raceCheckboxFormArray = ControlUtils.buildCheckBoxGroup(this.formBuilder, this.raceCheckboxItems, (this.raceType) ? this.raceType : []);
        });
    }
    addIdentifier(personIdentifier: PersonIdentifier) {
        if (this.personProfileFormGroup.get('identifier').valid && this.personProfileFormGroup.get('identifier').dirty) {
            this.personIdentifier.insertedby = 'default';
            this.personIdentifier.activeflag = 1;
            this.personIdentifier.updatedby = 'default';
            this.personIdentifier.effectivedate = new Date();
            this.addedIdentifier.push(Object.assign(this.personIdentifier, personIdentifier));
            this.addedIdentifier.forEach((item, ix) => {
                item.index = ix;
                return item;
            });
            this.clearPersonIdentifier();
            this._alertService.success('Person Identifier added successfully');
            this.personIdentifierChanged.emit(this.addedIdentifier);
            this.personIdentifier = Object.assign({});
        } else {
            this._alertService.warn('Please fill mandatory fields!');
        }
    }

    confirmDeleteIdentifier(personIdentifier: PersonIdentifier) {
        this.personIdentifier.index = personIdentifier.index;
        this.addedIdentifier.splice(personIdentifier.index, 1);
        this.clearPersonIdentifier();
        this.addedIdentifier = this.addedIdentifier.map((item, ix) => {
            item.index = ix;
            return item;
        });
        this.personIdentifierChanged.emit(this.addedIdentifier);
    }

    clearPersonIdentifier() {
        this.personProfileFormGroup.get('identifier').reset();
    }
    personIdentifierOnChange(option) {
        this.personIdentifier.personidentifiertype = Object.assign({
            typedescription: option.label
        });
    }
    addAlias(personAlias: Alias) {
        if (this.personProfileFormGroup.get('alias').valid && this.personProfileFormGroup.get('alias').dirty) {
            if (personAlias.firstname || personAlias.lastname) {
                this.personAlias.insertedby = 'default';
                this.personAlias.updatedby = 'default';
                this.personAlias.activeflag = 1;
                this.personAlias.effectivedate = new Date();
                this.addedAlias.push(Object.assign(this.personAlias, personAlias));
                this.addedAlias.forEach((item, ix) => {
                    item.index = ix;
                    return item;
                });
                this.clearPersonAlias();
                this._alertService.success('Person Alias added successfully');
                this.personAliasChanged.emit(this.addedAlias);
                this.personAlias = Object.assign({});
            }
        } else {
            this._alertService.warn('Please fill mandatory fields!');
        }
    }

    confirmDeleteAlias(personAlias: Alias) {
        this.personAlias.index = personAlias.index;
        this.addedAlias.splice(personAlias.index, 1);
        this.clearPersonAlias();
        this.addedAlias = this.addedAlias.map((item, ix) => {
            item.index = ix;
            return item;
        });
        this.personAliasChanged.emit(this.addedAlias);
    }
    clearPersonAlias() {
        this.personProfileFormGroup.get('alias').reset();
    }
    changeProvide(event) {
        if (event.target.value === 'ssn') {
            this.personProfileFormGroup.get('profile').value.refusessn = true;
            this.personProfileFormGroup.get('profile').value.refusedob = null;
        } else {
            this.personProfileFormGroup.get('profile').value.refusessn = null;
            this.personProfileFormGroup.get('profile').value.refusedob = true;
        }
    }
    personProfileFormBuilderGroup() {
        this.personProfileFormGroup = this.formBuilder.group({
            profile: this.profileFormGroup,
            identifier: this.formBuilder.group({
                personidentifiertypekey: ['', Validators.required],
                personidentifiervalue: ['', Validators.required]
            }),
            alias: this.formBuilder.group({
                firstname: [''],
                lastname: ['']
            }),
            race: this.formBuilder.group({
                racetypekey: ['']
            })
        });
    }
}
