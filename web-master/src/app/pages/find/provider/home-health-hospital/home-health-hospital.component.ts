import { Component, Input } from '@angular/core';
import { Subject ,  Observable } from 'rxjs';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { ProviderSearchResult } from '../../_entities/find-entity.module';

@Component({
    selector: 'app-home-health-hospital',
    templateUrl: './home-health-hospital.component.html',
    styleUrls: ['./home-health-hospital.component.scss'],
    standalone: false
})
export class HomeHealthHospitalComponent {
  @Input() showTable: boolean;
  @Input()
  pageNumberSubject$!: Subject<number>;
  @Input()
  searchList$!: Observable<ProviderSearchResult[]>;
  @Input()
  totalRecords$!: Observable<number>;

  paginationInfo: PaginationInfo = new PaginationInfo();
  selectedProvider: ProviderSearchResult;

  constructor() {
    this.selectedProvider = new ProviderSearchResult();
    this.showTable = false;
  }

  selectProvider(item: ProviderSearchResult) {
    this.selectedProvider = item;
  }
  pageChanged(page: number) {
    this.paginationInfo.pageNumber = page;
    this.pageNumberSubject$.next(page);
  }

}
