
import {share, pluck} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Observable, Subject } from 'rxjs';

import { ObjectUtils } from '../../../../@core/common/initializer';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { GenericService } from '../../../../@core/services/generic.service';
import { FinancePlacementSearchEntry} from '../../_entities/finance-entity.module';
import { FinanceUrlConfig } from '../../finance.url.config';


@Component({
    // tslint:disable-next-line:component-selector
    selector: 'app-finance-placement-search-filters',
    templateUrl: './finance-placement-search-filters.component.html',
    standalone: false
})
export class FinancePlacementSearchFiltersComponent implements OnInit {

    @Input() searchData$!: Subject<Observable<FinancePlacementSearchEntry[]>>;
    @Input() totalSearchRecord$!: Subject<Observable<number>>;
    @Input() pageNumberSearch$!: Subject<number>;

    placementSearch: FinancePlacementSearchEntry;
    placementFormGroup: FormGroup;

    // datepicker
    minDate = new Date();
    colorTheme = 'theme-blue';

    constructor(private formBuilder: FormBuilder, private _service: GenericService<FinancePlacementSearchEntry>) {
        this._service.endpointUrl = FinanceUrlConfig.EndPoint.placement.getPlacementInfo; 

        
        this.placementSearch = new FinancePlacementSearchEntry();
        this.placementSearch.sortdir = 'asc';
        this.placementSearch.sortcol = 'placementId';
        this.placementSearch.activeflag = '1';

        this.placementFormGroup = this.formBuilder.group({
            clientid: [''],
            clientname: [''],
            providerid: [''],
            placementid: [''],
            providername: [''],
            placementstartdatefrom: [''],
            placementstartdateto: [''],
            placementenddatefrom: [''],
            placementenddateto: [''],
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

                this.searchPlacement(data, this.placementSearch);

        });

    }


    searchPlacement(pageNo: number, modal: FinancePlacementSearchEntry) {
        this.placementSearch = modal;
        modal = Object.assign(new FinancePlacementSearchEntry(), modal);
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
        this.placementFormGroup.reset();
        this.placementFormGroup.patchValue({ county: '', region: '', gender: '', race: '' });
    }
}
