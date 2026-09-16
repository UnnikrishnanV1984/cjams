import { Component, OnInit, EventEmitter, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ValidatorFn, ValidationErrors } from '@angular/forms';
import { DataStoreService } from '../../../../@core/services';
import { FinanceStoreConstants } from '../../finance.constants';


@Component({
    selector: 'app-finance-accountsReceivable-search-filters',
    templateUrl: './finance-accountsReceivable-search-filters.component.html',
    styleUrls: ['./finance-accountsReceivable-search-filters.component.scss'],
    standalone: false
})

export class FinanceAccountsReceivableSearchFiltersComponent implements OnInit {
    accountsReceivableFormGroup!: FormGroup;
    @Output() searchEmitter = new EventEmitter<any>();
    receivableType = [
        {
          'text': 'All',
          'value': 'All'
        },
        {
          'text': 'System Receivable',
          'value': 'System'
        },
        {
            'text': 'Manual Receivable',
            'value': 'Manual'
        }
      ];

    constructor(private formBuilder: FormBuilder, private _datatoreService: DataStoreService) { }

    ngOnInit() {
        this.accountsReceivableFormGroup = this.formBuilder.group({
            paymentid: [null],
            providerid: [null],
            providername: [null],
            clientid: [null],
            enddate: [null],
            startdate: [null],
            organme: [null],
            fname: [null],
            lname: [null],
            taxid: [null],
            mailcode: [null],
            dobdaterangefrom: [null],
            dobdaterangeto: [null],
            ayear: [null],
            receivable_type: ['']
        }, { validators: this.atleastOne(Validators.required) });
        this.accountsReceivableFormGroup.patchValue({
            receivable_type: 'All'
        });
        const getSearchdata = this._datatoreService.getData('FinanceProviderSearch');
        if (getSearchdata && (getSearchdata.page === 'Both' || getSearchdata.page === 'Maintenance' || getSearchdata.page === 'Ancillary')) {
            this.accountsReceivableFormGroup.reset();
            this.accountsReceivableFormGroup.patchValue({
            providerid: getSearchdata.providerId
            });
            this.searchProviders();
            this._datatoreService.setData('FinanceProviderSearch', null);
        }
        setTimeout(() => {
            const searchParams = this._datatoreService.getData(FinanceStoreConstants.AccountsReceivableSearchParams);
            if (searchParams) {
                this.accountsReceivableFormGroup.patchValue(searchParams);
            }
        }, 100);
    }

    // ReceivedType is mandatory, and at least one other field should be there for the form to be valid.
    atleastOne = (validator: ValidatorFn) => (group: FormGroup): ValidationErrors | null => {
        const controls = group.controls;
        const isReceivableType = !validator(controls.receivable_type);
        const validFields = Object.keys(controls).filter(
            (k) => !validator(controls[k])
        );

        return validFields.length >= 2 && isReceivableType ? null : { atleastOne: true }
    };

    searchProviders() {
        const searchParams = this.accountsReceivableFormGroup.getRawValue();
        this._datatoreService.setData(FinanceStoreConstants.AccountsReceivableSearchParams, searchParams);
        this.searchEmitter.emit();
    }

    clearSearch() {
        this.accountsReceivableFormGroup.reset();
        this._datatoreService.setData(FinanceStoreConstants.AccountsReceivableSearchParams, null);
        this.searchEmitter.emit();
    }
}
