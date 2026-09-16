import { Component, Input } from '@angular/core';
import { Subject ,  Observable } from 'rxjs';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { ProviderSearchResult } from '../../_entities/find-entity.module';

@Component({
    selector: 'app-dsds-provider',
    templateUrl: './dsds-provider.component.html',
    styleUrls: ['./dsds-provider.component.scss'],
    standalone: false
})
export class DsdsProviderComponent {

  @Input() showTable: boolean;
  @Input()
  pageNumberSubject$!: Subject<number>;
  @Input()
  searchList$!: Observable<ProviderSearchResult[]>;
  @Input()
  totalRecords$!: Observable<number>;

  paginationInfo: PaginationInfo = new PaginationInfo();
  constructor() { this.showTable = false; }

  pageChanged(page: number) {
    this.paginationInfo.pageNumber = page;
    this.pageNumberSubject$.next(page);
  }
}
