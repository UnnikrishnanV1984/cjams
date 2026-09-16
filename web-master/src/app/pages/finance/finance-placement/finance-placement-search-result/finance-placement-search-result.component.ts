import { Component, Input } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { FinancePlacementSearchEntry} from '../../_entities/finance-entity.module';



@Component({
    selector: 'app-finance-placement-search-result',
    templateUrl: './finance-placement-search-result.component.html',
    standalone: false
})
export class FinancePlacementSearchResultComponent {

  @Input() showTable:boolean=false;
  @Input() pageNumberResult$!: Subject<number>;
  @Input() searchResultData$!: Observable<FinancePlacementSearchEntry[]>;
  @Input() totalResulRecords$!: Observable<number>;

  selectedRecord: FinancePlacementSearchEntry;
  paginationInfo: PaginationInfo = new PaginationInfo();


  constructor() {
    this.showTable = false;
    this.selectedRecord = new FinancePlacementSearchEntry();
  }

  pageChanged(page: number) {
      this.paginationInfo.pageNumber = page;
      this.pageNumberResult$.next(page);
  }

  selectPlacement(data: FinancePlacementSearchEntry) {
      this.selectedRecord = data;
  }
}
