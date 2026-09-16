import { Component, Input, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { FinanceAdoptionSearchEntry} from '../../_entities/finance-entity.module';



@Component({
    selector: 'app-finance-adoption-search-result',
    templateUrl: './finance-adoption-search-result.component.html',
    standalone: false
})
export class FinanceAdoptionSearchResultComponent implements OnInit {

  @Input() showTable:boolean=false;
  @Input() pageNumberResult$!: Subject<number>;
  @Input() searchResultData$!: Observable<FinanceAdoptionSearchEntry[]>;
  @Input() totalResulRecords$!: Observable<number>;

  selectedRecord: FinanceAdoptionSearchEntry;
  paginationInfo: PaginationInfo = new PaginationInfo();
  private pageSubject$ = new Subject<number>();


  constructor() {
    this.showTable = false;
    this.selectedRecord = new FinanceAdoptionSearchEntry();
  }

  ngOnInit() {
    this.pageSubject$.subscribe(pageNumber => {
      this.paginationInfo.pageNumber = pageNumber;
    });

  }

  pageChanged(page: number) {
      this.pageNumberResult$.next(page);
  }

  selectAdoption(data: FinanceAdoptionSearchEntry) {
      this.selectedRecord = data;
      this.selectedRecord.checked = true;
  }
}
