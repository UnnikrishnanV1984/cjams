
import { of as observableOf,  Observable ,  Subject, EMPTY } from 'rxjs';

import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';

import { ObjectUtils } from '../../../../../@core/common/initializer';
import { PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { GenericService } from '../../../../../@core/services/generic.service';
import { PersonSearch, PersonSearchRequest } from '../../../../case-worker/dsds-action/involved-person/_entities/involvedperson.data.model';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { DataStoreService } from '../../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'involved-person-search',
    templateUrl: './involved-person-search.component.html',
    styleUrls: ['./involved-person-search.component.scss']
})
export class InvolvedPersonSearchComponent implements OnInit {
    showSearchGrid = false;
    id: string;
    daNumber: string;
    showAddPerson: boolean;
    nameIdentifier: string;
    personSearchResult$: Observable<PersonSearch[]>;
    personSearchForm: FormGroup;
    paginationInfo: PaginationInfo = new PaginationInfo();
    totalRecords$: Observable<number>;
    canDisplayPager$: Observable<boolean>;
    private personSearchRequest: PersonSearchRequest;
    private pageSubject$ = new Subject<number>();
    constructor(private _service: GenericService<PersonSearch>, private formBuilder: FormBuilder, route: ActivatedRoute,private _dataStoreService: DataStoreService) {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }

    ngOnInit() {
        this.pageSubject$.subscribe((pageNumber) => {
            this.paginationInfo.pageNumber = pageNumber;
            this.personSearch(this.paginationInfo.pageNumber);
        });
        this.personSearchForm = this.formBuilder.group({
            personName: this.formBuilder.group({
                firstname: [''],
                lastname: [''],
                dob: [''],
                gender: ['']
            }),
            personIdentifier: this.formBuilder.group({
                ssn: [''],
                dcn: ['']
            }),
            nameIdentifier: ['person']
        });
        this.personSearchForm.get('personIdentifier').disable();
        this.personSearchFormLoad();
        this.showSearchGrid = false;
        this.showAddPerson = true;
        this.personSearchForm.patchValue({ nameIdentifier: 'person' });
    }

    personSearchFormLoad() {
        this.personSearchForm.reset();
    }

    resetPersonSearch() {
        this.nameIdentifier = this.personSearchForm.value.nameIdentifier;
        this.personSearchFormLoad();
        if (this.nameIdentifier === 'person') {
            this.personSearchForm.get('personIdentifier').disable();
            this.personSearchForm.get('personName').enable();
        } else if (this.nameIdentifier === 'identifier') {
            this.personSearchForm.get('personIdentifier').enable();
            this.personSearchForm.get('personName').disable();
        }
        this.personSearchForm.patchValue({
            nameIdentifier: this.nameIdentifier
        });
        this.personSearchResult$ = observableOf([]);
        this.totalRecords$ = EMPTY;
        this.showAddPerson = true;
    }

    personSearch(page: number) {
    
            if (this.personSearchForm?.value?.personName?.dob) {
                const event = new Date(this.personSearchForm.value.personName.dob);
                this.personSearchForm.value.personName.dob = event.getMonth() + 1 + '/' + event.getDate() + '/' + event.getFullYear();
            }  
        this.personSearchRequest = Object.assign(new PersonSearchRequest(), this.personSearchForm.value.personName, this.personSearchForm.value.personIdentifier);
        ObjectUtils.removeEmptyProperties(this.personSearchRequest);

        this.paginationInfo.pageNumber = page;
        const source = this._service
            .getPagedArrayList(
                new PaginationRequest({
                    page: this.paginationInfo.pageNumber,
                    limit: this.paginationInfo.pageSize,
                    method: 'post',
                    where: this.personSearchRequest
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonSearchUrl
            ).pipe(
            map((result) => {
                this.showAddPerson = result.data.length !== 0;
                return {
                    data: result.data,
                    count: result.count,
                    canDisplayPager: result.count > this.paginationInfo.pageSize
                };
            }),
            share(),);

        this.personSearchResult$ = source.pipe(pluck('data'));
        if (source.pipe(pluck('data'))) {
            this.showSearchGrid = true;
        }
        if (page === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    personSerachList() {
        this.showSearchGrid = true;
    }
    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.paginationInfo.pageSize = event.itemsPerPage;
        this.pageSubject$.next(this.paginationInfo.pageNumber);
    }
}
