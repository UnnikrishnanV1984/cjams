
import {share, pluck} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Observable, Subject } from 'rxjs';
import { ObjectUtils } from '../../../../@core/common/initializer';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { GenericService } from '../../../../@core/services/generic.service';
import { FinanceUrlConfig } from '../../finance.url.config';
import { FinanceGuardianshipSearchEntry } from '../../_entities/finance-entity.module';


@Component({
    selector: 'app-finance-guardianship-search-filters',
    templateUrl: './finance-guardianship-search-filters.component.html',
    standalone: false
})

export class FinanceGuardianshipSearchFiltersComponent implements OnInit {

    @Input() searchData$!: Subject<Observable<FinanceGuardianshipSearchEntry[]>>;
    @Input() totalSearchRecord$!: Subject<Observable<number>>;
    @Input() pageNumberSearch$!: Subject<number>;

    guardianshipSearch: FinanceGuardianshipSearchEntry;
    guardianshipFormGroup: FormGroup;

    constructor(private formBuilder: FormBuilder, private _service: GenericService<FinanceGuardianshipSearchEntry>) {
        this._service.endpointUrl = FinanceUrlConfig.EndPoint.guardianship.getGuardianshipInfo; 
       
        this.guardianshipSearch = new FinanceGuardianshipSearchEntry();
        this.guardianshipSearch.sortdir = 'asc';
        this.guardianshipSearch.sortcol = 'guardianshipId';
        this.guardianshipSearch.activeflag = '1';

        this.guardianshipFormGroup = this.formBuilder.group({
            clientid: [''],
            clientname: [''],
            providerid: [''],
            guardianshipid: [''],
            providername: [''],
            disclosuredatefrom: [''],
            disclosuredateto: [''],
            assistancestartdatefrom: [''],
            assistancestartdateto: [''],
            assistanceenddatefrom: [''],
            assistanceenddateto: [''],
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
                this.searchGuardianship(data, this.guardianshipSearch);
        });
    }

    searchGuardianship(pageNo: number, modal: FinanceGuardianshipSearchEntry) {
        this.guardianshipSearch = modal;
        modal = Object.assign(new FinanceGuardianshipSearchEntry(), modal);
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
        this.guardianshipFormGroup.reset();
        this.guardianshipFormGroup.patchValue({ county: '', region: '', gender: '', race: '' });
    }
}
