
import {share, pluck} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Observable, Subject } from 'rxjs';

import { ObjectUtils } from '../../../../@core/common/initializer';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { GenericService } from '../../../../@core/services/generic.service';
import { RegulationLibraryResult, RegulationLibrarySearch } from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';

@Component({
    selector: 'regulation-library-search',
    templateUrl: './regulation-library-search.component.html',
    styleUrls: ['./regulation-library-search.component.scss'],
    standalone: false
})
export class RegulationLibrarySearchComponent implements OnInit {
    @Input()
    regulationSearchData$!: Subject<Observable<RegulationLibraryResult[]>>;
    @Input()
    totalSearchRecord$!: Subject<Observable<number>>;
    @Input()
    pageNumberSearch$!: Subject<number>;
    regulationLibraryFormGroup: FormGroup;
    regulationLibrarySearch: RegulationLibrarySearch;
    constructor(private _service: GenericService<RegulationLibraryResult>, private formBuilder: FormBuilder) {
        this.regulationLibrarySearch = new RegulationLibrarySearch();
        this._service.endpointUrl = FindUrlConfig.EndPoint.RegulationLibrary.regulationLibrarySearchURL;
        this.regulationLibraryFormGroup = this.formBuilder.group({
            searchCriteria: [''],
            type: [''],
            status: ['']
        });
    }
    ngOnInit() {
        this.pageNumberSearch$.subscribe(data => {
            this.searchRegulationLibrary(data, this.regulationLibrarySearch);
        });
    }
    //  getting the regulation library data
    searchRegulationLibrary(pageNo: number, modal: RegulationLibrarySearch) {
        this.regulationLibrarySearch = modal;
        modal = Object.assign(new RegulationLibrarySearch(), modal);
        ObjectUtils.removeEmptyProperties(modal);
        const body: PaginationRequest = {
            limit: 10,
            page: pageNo,
            where: modal,
            method: 'post'
        };
        const source = this._service.getPagedArrayList(body).pipe(share());
        this.regulationSearchData$.next(source.pipe(pluck('data')));
        if (pageNo === 1) {
            this.totalSearchRecord$.next(source.pipe(pluck('count')));
        }
    }
}
