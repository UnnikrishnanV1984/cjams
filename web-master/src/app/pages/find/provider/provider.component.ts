import { Component, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';

import { ProviderAttributeSelector, ProviderSearchResult } from '../_entities/find-entity.module';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'provider',
    templateUrl: './provider.component.html',
    styleUrls: ['./provider.component.scss'],
    standalone: false
})
export class ProviderComponent implements OnInit {

  providerSelecterSubject$: Subject<ProviderAttributeSelector>;
  searchListSubject$: Subject<Observable<ProviderSearchResult[]>>;
  totalRecordsSubject$: Subject<Observable<number>>;
  pageNumberSubject$: Subject<number>;

  searchList$!: Observable<ProviderSearchResult[]>;
  totalRecords$!: Observable<number>;

  searchCriteriaList: ProviderAttributeSelector = {
    provider: 'DMH',
    providerText: 'DMH Provider',
    agencycategory: 'DMH',
    nameFilter: { show: true, legalName: false, officialName: true, dbaName: true, status: false },
    providerFilter: { show: false, paType: true, ssbg: true, specialTerms: true },
    seviceFilter: { show: true, category: true, type: true, businessType: true, service: false, areaServiced: false },
    locationFilter: { show: true, street: true, street2: true, city: true, zip: true, county: true, region: false, phone: true, facid: true }
  };

  selectedProvider = 'DMH';
  searchParams = {};
  showTable = false;

  constructor() {
    this.providerSelecterSubject$ = new Subject<ProviderAttributeSelector>();
    this.searchListSubject$ = new Subject<Observable<ProviderSearchResult[]>>();
    this.totalRecordsSubject$ = new Subject<Observable<number>>();
    this.pageNumberSubject$ = new Subject<number>();
  }

  ngOnInit() {
    this.searchListSubject$.subscribe(data => {
      this.searchList$ = data;
      this.showTable = true;
    });
    this.totalRecordsSubject$.subscribe(data => {
      this.totalRecords$ = data;
    });
  }

  providerSelected(val: Event) {
    const event = (val.target as HTMLInputElement).value;
    this.showTable = false;
    this.selectedProvider = (event);
    this.searchCriteriaList.provider = event;
    switch (event) {
      case 'DMH':
        this.searchCriteriaList.agencycategory = 'DMH';
        this.searchCriteriaList.providerText = 'DMH Provider';
          this.searchCriteriaList.nameFilter = { show: true, legalName: false, officialName: true, dbaName: true, status: false };
        this.searchCriteriaList.providerFilter = { show: false, paType: true, ssbg: true, specialTerms: true };
        this.searchCriteriaList.seviceFilter = { show: true, category: true, type: true, businessType: true, service: false, areaServiced: false };
        this.searchCriteriaList.locationFilter = { show: true, street: true, street2: true, city: true, zip: true, county: true, region: false, phone: true, facid: true };

        break;
      case 'DSDS':
        this.searchCriteriaList.agencycategory = 'Provider';
        this.searchCriteriaList.providerText = 'Agency Provider';
          this.searchCriteriaList.nameFilter = { show: true, legalName: true, officialName: false, dbaName: true, status: true };
        this.searchCriteriaList.providerFilter = { show: true, paType: true, ssbg: true, specialTerms: true };
        this.searchCriteriaList.seviceFilter = { show: true, category: true, type: true, businessType: true, service: true, areaServiced: true };
        this.searchCriteriaList.locationFilter = { show: true, street: true, street2: true, city: true, zip: true, county: true, region: true, phone: true, facid: false };
        break;
      case 'HHH':
        this.searchCriteriaList.agencycategory = 'Agency';
        this.searchCriteriaList.providerText = 'ASPEN';
          this.searchCriteriaList.nameFilter = { show: true, legalName: false, officialName: true, dbaName: true, status: false };
        this.searchCriteriaList.providerFilter = { show: false, paType: true, ssbg: true, specialTerms: true };
        this.searchCriteriaList.seviceFilter = { show: true, category: true, type: true, businessType: true, service: false, areaServiced: false };
        this.searchCriteriaList.locationFilter = { show: true, street: true, street2: true, city: true, zip: true, county: true, region: false, phone: true, facid: true };
        break;

      default:
        break;
    }
    this.providerSelecterSubject$.next(this.searchCriteriaList);
  }
}
