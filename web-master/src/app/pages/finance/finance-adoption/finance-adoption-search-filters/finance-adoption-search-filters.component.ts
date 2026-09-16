
import {share, pluck} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Observable, Subject } from 'rxjs';
import { ObjectUtils } from '../../../../@core/common/initializer';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { GenericService } from '../../../../@core/services/generic.service';
import { FinanceUrlConfig } from '../../finance.url.config';
import { FinanceAdoptionSearchEntry } from '../../_entities/finance-entity.module';


@Component({
    selector: 'app-finance-adoption-search-filters',
    templateUrl: './finance-adoption-search-filters.component.html',
    standalone: false
})

export class FinanceAdoptionSearchFiltersComponent implements OnInit {

    @Input() searchData$!: Subject<Observable<FinanceAdoptionSearchEntry[]>>;
    @Input() totalSearchRecord$!: Subject<Observable<number>>;
    @Input() pageNumberSearch$!: Subject<number>;

    adoptionSearch: FinanceAdoptionSearchEntry;
    adoptionFormGroup: FormGroup;

    constructor(private formBuilder: FormBuilder, private _service: GenericService<FinanceAdoptionSearchEntry>) {
        this._service.endpointUrl = FinanceUrlConfig.EndPoint.adoption.getAdoptionInfo; 
       
        this.adoptionSearch = new FinanceAdoptionSearchEntry();
        this.adoptionSearch.sortdir = 'asc';
        this.adoptionSearch.sortcol = 'adoptionId';
        this.adoptionSearch.activeflag = '1';

        this.adoptionFormGroup = this.formBuilder.group({
            clientid: [''],
            clientname: [''],
            providerid: [''],
            adoptionid: [''],
            providername: [''],
            adoptionstartdatefrom: [''],
            adoptionstartdateto: [''],
            adoptionenddatefrom: [''],
            adoptionenddateto: [''],
            address: [''],
            zip: [''],
            state: [''],
            city: [''],
            county: [''],
            region: [''],
            phonenumber: ['']
        });
    }

    ngOnInit() {
        this.pageNumberSearch$.subscribe(data => {
                this.searchAdoption(data, this.adoptionSearch);
        });
    }

    searchAdoption(pageNo: number, modal: FinanceAdoptionSearchEntry) {
        this.adoptionSearch = modal;
        modal = Object.assign(new FinanceAdoptionSearchEntry(), modal);
        ObjectUtils.removeEmptyProperties(modal);
        const source = this._service.getPagedArrayList(new PaginationRequest({
            where: modal,
            page: pageNo,
            limit: 10,
            method: 'post'
        })).pipe(share());

        this.searchData$.next(source.pipe(pluck('data')));
        if (pageNo === 1) {
            this.totalSearchRecord$.next(source.pipe(pluck('count')));
        }
    }
    
    clearSearch() {
        this.adoptionFormGroup.reset();
        this.adoptionFormGroup.patchValue({ county: '', region: '', gender: '', race: '' });
    }
}
