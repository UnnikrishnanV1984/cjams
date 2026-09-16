
import {share, map} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CustomValidators } from 'ng4-validators';
import { Observable ,  Subject } from 'rxjs';

import { ObjectUtils } from '../../../../../../@core/common/initializer';
import { PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { AlertService, GenericService, DataStoreService } from '../../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import {
    Actor,
    ActorRelation,
    AddPerson,
    Alias,
    DangerWorker,
    People,
    PersonAddress,
    PersonDetail,
    PersonIdentifier,
    PersonPhone,
} from '../../_entities/involvedperson.data.model';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';

declare const $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'involved-person-add-edit-role',
    templateUrl: './involved-person-add-edit-role.component.html',
    styleUrls: ['./involved-person-add-edit-role.component.scss'],
    standalone: false
})
export class InvolvedPersonAddEditRoleComponent implements OnInit {
    @Input() involvedPersonPageSubject$ = new Subject<number>();

    id: string;
    personId: string;
    actorId: string;
    daNumber: string;
    addedPersons: People;
    raceIds: string[] = [];
    addedIdentifier: PersonIdentifier[] = [];
    addedAlias: Alias[] = [];
    personAddress: PersonAddress[] = [];
    addedPhone: PersonPhone[] = [];
    person$: Observable<PersonDetail>;
    addedActor: Actor[] = [];
    addedActorRelations: ActorRelation[] = [];
    dangerWorker: DangerWorker[] = [];
    involvedPerson: AddPerson = new AddPerson();
    profileFormGroup: FormGroup;
    dangerPersonFormGroup: FormGroup;
    personDetails: PersonDetail;
    formTitle: string;
    editpersonpopupid = '#edit-persons';
    caseworkerpageurl = '/pages/case-worker/';
    involvedpersonurl = '/dsds-action/involved-person';
    constructor(
        route: ActivatedRoute,
        private router: Router,
        private formBuilder: FormBuilder,
        private _service: GenericService<PersonDetail>,
        private _involvedPersonService: GenericService<AddPerson>,
        private _alertService: AlertService,
        private _dataStoreService: DataStoreService
    ) {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.personId = route.snapshot.params.personid;
        this.actorId = route.snapshot.params.actorid;
    }

    ngOnInit() {
        ($(this.editpersonpopupid)).modal('show');
        if (this.personId !== '0' && this.actorId !== '0') {
            this.formTitle = 'Edit';
        } else {
            this.formTitle = 'Add';
        }
        this.getPerson();

        this.profileFormGroup = this.formBuilder.group({
            firstname: ['', Validators.required],
            lastname: ['', Validators.required],
            middlename: [''],
            nameSuffix: [''],
            firstnamesoundex: [''],
            dob: [null, CustomValidators.maxDate(new Date())],
            ethnicgrouptypekey: [''],
            gendertypekey: [''],
            incometypekey: [''],
            interpreterrequired: [''],
            lastnamesoundex: [''],
            maritalstatustypekey: [''],
            primarylanguageid: [''],
            racetypekey: [''],
            secondarylanguageid: [''],
            activeflag: 1,
            insertedby: ['default'],
            effectivedate: [new Date()],
            refusedob: [''],
            refusessn: ['']
        });

        this.dangerPersonFormGroup = this.formBuilder.group({
            dangerlevel: ['', Validators.required],
            dangerreason: ['']
        });
    }

    getPerson() {
        if (this.actorId === '0') {
            this.actorId = null;
        }
        this.person$ = this._service
            .getSingle(
                new PaginationRequest({
                    method: 'get',
                    where: { intakeserviceid: this.id, actorid: this.actorId }
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.Person + '/' + this.personId + '?data'
            ).pipe(
            map((result) => {
                return result;
            }),
            share(),);
    }

    savePerson() {
        if (this.personId !== '0') {
            if (this.dangerPersonFormGroup.value.dangerlevel === 0) {
                this.dangerPersonFormGroup.value.dangerlevel = '0';
            }
            if (!this.dangerPersonFormGroup.value.dangerlevel) {
                this.dangerPersonFormGroup.value.dangerlevel = 'null';
            }

        }
        if (!this.addedActor.length) {
            this._alertService.error('Please select Role of the Person');
            return false;
        }  else if (!this.profileFormGroup.value.firstname) {
            this._alertService.error('Please Enter Firstname');
            return false;
        } else if (!this.profileFormGroup.value.lastname) {
            this._alertService.error('Please Enter LastName');
            return false;
        } else if (!this.dangerPersonFormGroup.value.dangerlevel) {
            this._alertService.error('Please select Danger to Worker');
            return false;
        } else {
            this.continueSavePerson();
        }
    }

    continueSavePerson() {
        if (this.profileFormGroup.value.dob) {
            const event = new Date(
                this.profileFormGroup.value.dob
            );
            this.profileFormGroup.value.dob =
                event.getMonth() + 1 + '/' +
                event.getDate() + '/' +
                event.getFullYear();
        }
        this.involvedPerson.Actor = this.addedActor;
        this.involvedPerson.People = this.profileFormGroup.value;
        this.involvedPerson.Personidentifier = this.addedIdentifier;
        this.involvedPerson.Actorrelation = this.addedActorRelations;
        this.involvedPerson.Alias = this.addedAlias;
        this.involvedPerson.People.racetypekey = this.raceIds.join(',');
        this.involvedPerson.Personaddresses = this.personAddress;
        this.involvedPerson.Personphonenumber = this.addedPhone;
        this.involvedPerson.Actor[0].primarylanguageid = this.getLanguageId(this.involvedPerson.People.primarylanguageid);
        this.involvedPerson.Actor[0].secondarylanguageid = this.getLanguageId(this.involvedPerson.People.secondarylanguageid);
        this.involvedPerson.People = Object.assign(this.involvedPerson.People, this.dangerPersonFormGroup.value);
        ObjectUtils.removeEmptyProperties(this.involvedPerson.People);
        if (this.dangerPersonFormGroup.value.dangerlevel === 'null') {
            this.involvedPerson.People.dangerlevel = null;
        }
        if (this.personId !== '0' && this.actorId !== '0') {
            this.updatePerson();
        } else {
            this._involvedPersonService.create(this.involvedPerson, CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.SavePerson).subscribe(
                (response) => {
                    this._alertService.success('Person added successfully');
                    this.involvedPersonPageSubject$.next(1);
                    $(this.editpersonpopupid).modal('hide');
                    this.router.routeReuseStrategy.shouldReuseRoute = function () {
                        return false;
                    };
                    const currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + this.involvedpersonurl;
                    this.router.navigateByUrl(currentUrl).then(() => {
                        this.router.navigated = false;
                        this.router.navigate([currentUrl]);
                    });
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    updatePerson() {
        if (this.actorId) {
            this.involvedPerson.People.personid = this.personId;
            this._involvedPersonService.patch(this.personId, this.involvedPerson, CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.UpdatePerson).subscribe(
                (response) => {
                  this.udpatePersonResponse();
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._involvedPersonService.getSingle(new PaginationRequest({
                method: 'get',
                where: { personid: this.personId, personrole: this.involvedPerson.Actor[0].actortype ? this.involvedPerson.Actor[0].actortype : undefined }
            }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CheckPerson + '/' + this.id + '?data'
            )
                .subscribe((result) => {
                    if (result) {
                        this.involvedPerson.People.personid = this.personId;
                        this._involvedPersonService.patch(this.personId, this.involvedPerson, CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.UpdatePerson).subscribe(
                            (response) => {
                               this.udpatePersonResponse();
                            },
                            (error) => {
                                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                            }
                        );
                    } else {
                        this._alertService.warn('Person with same role already added');
                    }
                });
        }
    }

    udpatePersonResponse(){
        this._alertService.success('Person updated successfully');
        this.involvedPersonPageSubject$.next(1);
        ($(this.editpersonpopupid)).modal('hide');
        this.router.routeReuseStrategy.shouldReuseRoute = function () {
            return false;
        };
        const currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + this.involvedpersonurl;
        this.router.navigateByUrl(currentUrl).then(() => {
            this.router.navigated = true;
            this.router.navigate([currentUrl]);
        });
    }

    getLanguageId(languageid){
        return languageid ? languageid : null;
    }

    clearAll() {
        this.addedActor = [];
        this.profileFormGroup.reset();
        this.dangerPersonFormGroup.reset();
        this.addedIdentifier = [];
        this.addedActorRelations = [];
        this.addedAlias = [];
        this.personAddress = [];
        this.addedPhone = [];
        this.raceIds = [];
    }

    actorDataChanged(actors: Actor[]) {
        this.addedActor = actors;
    }

    personAddressChanged(address: PersonAddress[]) {
        this.personAddress = address;
    }
    personPhoneChanged(phone: PersonPhone[]) {
        this.addedPhone = phone;
    }
    personIdentifierChanged(Identifier: PersonIdentifier[]) {
        this.addedIdentifier = Identifier;
    }
    personAliasChanged(alias: Alias[]) {
        this.addedAlias = alias;
    }
    personRaceIdsChanged(race: string[]) {
        this.raceIds = race;
    }
}
