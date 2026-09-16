
import {pluck, share, map} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { forkJoin ,  Observable, Subject } from 'rxjs';

import { ObjectUtils } from '../../../../@core/common/initializer';
import { DropdownModel, PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../../@core/services';
import { GenericService } from '../../../../@core/services/generic.service';
import { Person, PersonSearchEntity } from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'app-person-search-filters',
    templateUrl: './person-search-filters.component.html',
    styleUrls: ['./person-search-filters.component.scss'],
    standalone: false
})
export class PersonSearchFiltersComponent implements OnInit {

    @Input()
    personListSubject$!: Subject<Observable<Person[]>>;
    @Input()
    totalRecordSubject$!: Subject<Observable<number>>;
    @Input()
    pageNumber$!: Subject<number>;

    countyDropdownItems$!: Observable<DropdownModel[]>;
    regionDropdownItems$!: Observable<DropdownModel[]>;
    raceDropdownItems$!: Observable<DropdownModel[]>;
    genderDropdownItems$!: Observable<DropdownModel[]>;

    personSearchCriteria: PersonSearchEntity;
    personFormGroup: FormGroup;

    // datepicker
    minDate = new Date();
    colorTheme = 'theme-blue';



    constructor(private formBuilder: FormBuilder, private _service: GenericService<Person>,
        private _commonService: CommonHttpService) {
        this._service.endpointUrl = FindUrlConfig.EndPoint.PersonSearch.globalpersonsearches;
        this.personSearchCriteria = new PersonSearchEntity();
        this.personSearchCriteria.sortdir = 'asc';
        this.personSearchCriteria.sortcol = 'lastname';
        this.personSearchCriteria.personflag = 'T';
        this.personSearchCriteria.activeflag = '1';

        this.personFormGroup = this.formBuilder.group({
            firstname: [''],
            lastname: [''],
            dangerous: [''],
            gender: [''],
            race: [''],
            dobto: [''],
            dobfrom: [''],
            ssn: [''],
            dcn: [''],
            address: [''],
            city: [''],
            zip: [''],
            county: [''],
            region: [''],
            phone: [''],
        }, { validators: [this.checkDateRange] });
    }

    ngOnInit() {
        this.pageNumber$.subscribe(data => {
            if (data !== 1) {
                this.searchPerson(data);
            }
        });
        this.getAllDropdownData();
    }

    getAllDropdownData() {
        const genderTypeRequest = this._commonService.getArrayList({}, FindUrlConfig.EndPoint.PersonSearch.gendertype);
        const raceTypeRequest = this._commonService.getArrayList({}, FindUrlConfig.EndPoint.PersonSearch.racetype);
        const countyTypeRequest = this._commonService.getArrayList({}, FindUrlConfig.EndPoint.common.counties);
        const regionTypeRequest = this._commonService.getArrayList({}, FindUrlConfig.EndPoint.common.regions);

        const source = forkJoin([genderTypeRequest, raceTypeRequest,
            countyTypeRequest, regionTypeRequest]).pipe(map(result => {
                return {
                    genderTypes: result[0].map(res => new DropdownModel(
                        { text: res.typedescription, value: res.gendertypekey })),
                    raceTypes: result[1].map(res => new DropdownModel(
                        { text: res.typedescription, value: res.racetypekey })),
                    counties: result[2].map(res => new DropdownModel(
                        { text: res.countyname, value: res.countyname })),
                    regions: result[3].map(res => new DropdownModel(
                        { text: res.regionname, value: res.regionid })),
                };
            }
            ),share(),);

        this.countyDropdownItems$ = source.pipe(pluck('counties'));
        this.regionDropdownItems$ = source.pipe(pluck('regions'));
        this.raceDropdownItems$ = source.pipe(pluck('raceTypes'));
        this.genderDropdownItems$ = source.pipe(pluck('genderTypes'));
    }

    checkDateRange(group: FormGroup) {
        if (group.controls.dobto.value) {
            if (group.controls.dobto.value < group.controls.dobfrom.value) {
                return { notValid: true };
            }
            return null;
        }
    }

    searchPerson(pageNo: number) {

        this.personSearchCriteria.firstname = this.personFormGroup.value.firstname;
        this.personSearchCriteria.lastname = this.personFormGroup.value.lastname;
        this.personSearchCriteria.dangerous = this.personFormGroup.value.dangerous;
        this.personSearchCriteria.gender = this.personFormGroup.value.gender;

        this.personSearchCriteria.race = this.personFormGroup.value.race;
        this.personSearchCriteria.dobto = this.personFormGroup.value.dobto;
        this.personSearchCriteria.dobfrom = this.personFormGroup.value.dobfrom;

        this.personSearchCriteria.ssn = this.personFormGroup.value.ssn;
        this.personSearchCriteria.dcn = this.personFormGroup.value.dcn;
        this.personSearchCriteria.address = this.personFormGroup.value.address;
        this.personSearchCriteria.city = this.personFormGroup.value.city;
        this.personSearchCriteria.zip = this.personFormGroup.value.zip;
        this.personSearchCriteria.county = this.personFormGroup.value.county;

        this.personSearchCriteria.region = this.personFormGroup.value.region;
        this.personSearchCriteria.phone = this.personFormGroup.value.phone;

        ObjectUtils.removeEmptyProperties(this.personSearchCriteria);
        const source = this._service.getPagedArrayList(new PaginationRequest({
            where: this.personSearchCriteria,
            page: pageNo,
            limit: 10,
            method: 'post'
        })).pipe(share());


        this.personListSubject$.next(source.pipe(pluck('data')));
        if (pageNo === 1) {
            this.totalRecordSubject$.next(source.pipe(pluck('count')));
        }
    }
    clearSearch() {
        this.personFormGroup.reset();
        this.personFormGroup.patchValue({ county: '', region: '', gender: '', race: '' });
    }
}
