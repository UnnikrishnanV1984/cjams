
import { map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';

import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import {
    PersonAddress,
    PersonAlias,
    PersonClearing,
    PersonDetails,
    PersonDsdsAction,
    PersonIdentifier,
    PersonPhoneNumber,
    PersonPhoneNumberDetails,
    PersonRole,
} from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';

declare let $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-search-view',
    templateUrl: './person-search-view.component.html',
    styleUrls: ['./person-search-view.component.scss'],
    standalone: false
})
export class PersonSearchViewComponent implements OnInit {


    id: any;
    addresses$!: Observable<PersonAddress[]>;
    personDetails: PersonDetails;
    personPhoneNumberDetails$!: Observable<PersonPhoneNumber[]>;
    personIdentities$!: Observable<PersonIdentifier[]>;
    personRoles$!: Observable<PersonRole[]>;
    personAlias$!: Observable<PersonAlias[]>;
    personDSDSActions$!: Observable<PersonDsdsAction[]>;
    personClearings$!: Observable<PersonClearing[]>;


    constructor(private route: ActivatedRoute, private _commonService: CommonHttpService) {
        this.personDetails = new PersonDetails();
    }

    ngOnInit() {
        this.id = this.route.snapshot.params['id'];

        this.getPersonDetails();
        this.getPersonPhoneNumber();
        this.getPersonAddress();
        this.getPersonIdentities();
        this.getPersonClearing();
        this.getPersonRoles();
        this.getPersonAliases();
        this.getPersonDSDSAction();

        this.showPeronViewModel();
    }



    showPeronViewModel() {
        $('#modal-view-person').modal('show');
    }



    getPersonDetails() {
        const url = FindUrlConfig.EndPoint.PersonSearch.people;

        this._commonService.getArrayList(
            {
                include: 'Ethnicgrouptype',
                where: { personid: this.id },
                method: 'get'
            },
            url).pipe(map(data => {
                this.personDetails = data[0];
            }));
    }

    getPersonPhoneNumber() {
        const url = FindUrlConfig.EndPoint.PersonSearch.phonenumbers;

        this.personPhoneNumberDetails$ = this._commonService.getArrayList(
            {
                include: 'Personphonetype',
                where: { personid: this.id },
                method: 'get'
            }
            , url).pipe(map(data => {
                return data.map(model => new PersonPhoneNumberDetails(model));
            }));

    }

    getPersonAddress() {
        const url = FindUrlConfig.EndPoint.PersonSearch.addresses;
        this.addresses$ = this._commonService.getArrayList(
            {
                include: 'Personaddresstype',
                where: { personid: this.id },
                method: 'get'
            }
            , url).pipe(
            map(data => {
                return data.map(model => new PersonAddress(model));
            }));
    }

    getPersonRoles() {
        const url = FindUrlConfig.EndPoint.PersonSearch.actors;
        this.personRoles$ = this._commonService.getArrayList(
            {
                include: 'Actortype',
                where: { personid: this.id },
                method: 'get'
            }
            , url).pipe(map(data => {
                return data.map(model => new PersonRole(model));
            }));
    }

    getPersonDSDSAction() {
        const url = FindUrlConfig.EndPoint.PersonSearch.intakeservicerequests + `?personid=${this.id}`;
        this.personDSDSActions$ = this._commonService.getArrayList({}, url).pipe(map(data => {
            return data.map(model => new PersonDsdsAction(model));
        }));
    }

    getPersonAliases() {
        const url = FindUrlConfig.EndPoint.PersonSearch.alias;
        this.personAlias$ = this._commonService.getArrayList(
            {
                where: { personid: this.id },
                method: 'get'
            }
            , url).pipe(map(data => {
                return data.map(model => new PersonAlias(model));
            }));
    }

    getPersonClearing() {
        const url = FindUrlConfig.EndPoint.PersonSearch.personclearinginfodata;
        this.personClearings$ = this._commonService.getPagedArrayList(new PaginationRequest({
            where: {
                'personid': this.id,
                'activeflag': '1'
            },
            method: 'post',
            page: 1,
            limit: 10,
        }), url).pipe(map(res => {
            return res.data.map(model => new PersonClearing(model));
        }));

    }

    getPersonIdentities() {
        const url = FindUrlConfig.EndPoint.PersonSearch.identifier;
        this.personIdentities$ = this._commonService.getArrayList(
            {
                where: { personid: this.id, personidentifiertypekey: 'SSN' },
                method: 'get'
            }
            , url).pipe(map(data => {
                return data.map(model => new PersonIdentifier(model));
            }));
    }
}
