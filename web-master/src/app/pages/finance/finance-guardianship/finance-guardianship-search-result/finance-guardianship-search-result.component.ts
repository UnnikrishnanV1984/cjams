import { Component, Input, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { FinanceGuardianshipSearchEntry} from '../../_entities/finance-entity.module';



@Component({
    selector: 'app-finance-guardianship-search-result',
    templateUrl: './finance-guardianship-search-result.component.html',
    standalone: false
})
export class FinanceGuardianshipSearchResultComponent implements OnInit {

  @Input() showTable:boolean=false;
  @Input() pageNumberResult$!: Subject<number>;
  @Input() searchResultData$!: Observable<FinanceGuardianshipSearchEntry[]>;
  @Input() totalResulRecords$!: Observable<number>;

  selectedRecord: FinanceGuardianshipSearchEntry;
  paginationInfo: PaginationInfo = new PaginationInfo();
  private pageSubject$ = new Subject<number>();


  constructor() {
    this.showTable = false;
    this.selectedRecord = new FinanceGuardianshipSearchEntry();
  }

  ngOnInit() {
    this.pageSubject$.subscribe((pageNumber:any) => {
      this.paginationInfo.pageNumber = pageNumber;
    });

  }

  pageChanged(page: number) {
      this.pageNumberResult$.next(page);
  }

  selectGuardianship(data: FinanceGuardianshipSearchEntry) {
      this.selectedRecord = data;
  }
}
