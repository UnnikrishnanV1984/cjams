import { Component, Input } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';

import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { ProviderSearchResult } from '../../_entities/find-entity.module';

@Component({
    selector: 'app-dmh-provider',
    templateUrl: './dmh-provider.component.html',
    styleUrls: ['./dmh-provider.component.scss'],
    standalone: false
})
export class DmhProviderComponent {

  @Input() showTable: boolean;
  @Input()
  pageNumberSubject$!: Subject<number>;
  @Input()
  searchList$!: Observable<ProviderSearchResult[]>;
  @Input()
  totalRecords$!: Observable<number>;

  paginationInfo: PaginationInfo = new PaginationInfo();
  selectedDmh: ProviderSearchResult;
  constructor() {
    this.selectedDmh = new ProviderSearchResult();
    this.showTable = false;
  }
  
  pageChanged(page: number) {
    this.paginationInfo.pageNumber = page;
    this.pageNumberSubject$.next(page);
  }
  selectDMH(item: ProviderSearchResult) {
    this.selectedDmh = item;
  }
}
