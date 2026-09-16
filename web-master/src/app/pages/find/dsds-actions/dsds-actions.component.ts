import { Component, OnInit } from '@angular/core';
import { Observable, Subject } from 'rxjs';

import { DsdsActionResult } from '../_entities/find-entity.module';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dsds-actions',
    templateUrl: './dsds-actions.component.html',
    styleUrls: ['./dsds-actions.component.scss'],
    standalone: false
})
export class DsdsActionsComponent implements OnInit {
  dsdsActionSearchData$: Subject<Observable<DsdsActionResult[]>>;
  totalSearchRecord$: Subject<Observable<number>>;
  pageNumberResult$: Subject<number>;
  dsdsActionResultData$!: Observable<DsdsActionResult[]>;
  totalResulRecords$!: Observable<number>;
  dsdsActionSearhResult: any;
  showTable = false;
  constructor() {
    this.dsdsActionSearchData$ = new Subject();
    this.totalSearchRecord$ = new Subject();
    this.pageNumberResult$ = new Subject();
  }
  ngOnInit() {
    this.dsdsActionSearchData$.subscribe((data: any) => {
      this.dsdsActionResultData$ = data;
      this.showTable = true;
    });
    this.totalSearchRecord$.subscribe(data => {
      this.totalResulRecords$ = data;
    });

  }
}
