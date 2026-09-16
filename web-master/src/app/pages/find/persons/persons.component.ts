import { Component, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';

import { PaginationInfo } from '../../../@core/entities/common.entities';
import { Person, PersonSearchEntity } from '../_entities/find-entity.module';

@Component({
    selector: 'app-persons',
    templateUrl: './persons.component.html',
    styleUrls: ['./persons.component.scss'],
    standalone: false
})
export class PersonsComponent implements OnInit {
    personSearchCriteriaSubject$: Subject<Observable<Person[]>>;
    personListDataSubject$: Subject<Observable<Person[]>>;
    totalRecordsSubject$: Subject<Observable<number>>;
    errorSubject$: Subject<string>;
    pageNumberSubject$: Subject<number>;

    personSearchResult$: Observable<Person[]>;
    totalRecords$!: Observable<number>;

    personSearchCriteria: PersonSearchEntity;
    paginationInfo: PaginationInfo = new PaginationInfo();

    showTable = false;

    constructor() {
        this.personSearchCriteriaSubject$ = new Subject();
        this.personSearchResult$ = new Subject();
        this.personListDataSubject$ = new Subject();
        this.totalRecordsSubject$ = new Subject();
        this.errorSubject$ = new Subject();
        this.pageNumberSubject$ = new Subject();

        this.personSearchCriteria = new PersonSearchEntity();
        this.personSearchCriteria.sortdir = 'asc';
        this.personSearchCriteria.sortcol = 'lastname';
        this.personSearchCriteria.personflag = 'T';
        this.personSearchCriteria.activeflag = '1';
    }

    ngOnInit() {
        this.personSearchCriteriaSubject$.subscribe((data) => {
            this.personSearchResult$ = data;
        });

        this.personListDataSubject$.subscribe((data) => {
            this.personSearchResult$ = data;
            this.showTable = true;
        });

        this.totalRecordsSubject$.subscribe((data) => {
            this.totalRecords$ = data;
        });
    }
}
