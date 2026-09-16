import { Component, OnInit } from '@angular/core';

import { FormBuilder, FormGroup } from '@angular/forms';
import { DataStoreService } from '../../../../../@core/services';
import { ProviderChecklist } from '../../../finance.constants';


@Component({
    selector: 'provider-checklist-search',
    templateUrl: './provider-checklist-search.component.html',
    styleUrls: ['./provider-checklist-search.component.scss'],
    standalone: false
})
export class ProviderChecklistSearchComponent implements OnInit {
  providerChecklistForm! :FormGroup
  constructor( private _dataStoreService: DataStoreService,
    private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.providerChecklistForm = this.formBuilder.group({
      ayear:['Y'],
      provider_id: [null],
      provider_name: [null],
      tax_id: [null],
      mail_code: [null],
      startdate: [null],
      enddate: [null]
      
    });
    setTimeout(() => {
      const searchParams = this._dataStoreService.getData(ProviderChecklist.ProviderChecklistSearchParams);
      if (searchParams) {
          this.providerChecklistForm.patchValue(searchParams);
      }
  }, 100);
  }

  searchProvider() {
    const searchParams = this.providerChecklistForm.getRawValue();
    this._dataStoreService.setData(ProviderChecklist.ProviderChecklistSearchParams, searchParams);
  }

  clearSearch() {
    this.providerChecklistForm.reset();
    this._dataStoreService.setData(ProviderChecklist.ProviderChecklistSearchParams, null);
  }

}