import { RegulationLibraryResult } from '../_entities/find-entity.module';
import { Observable, Subject } from 'rxjs';
import { Component, OnInit } from '@angular/core';

@Component({
    selector: 'find-regulation-library',
    templateUrl: './find-regulation-library.component.html',
    styleUrls: ['./find-regulation-library.component.scss'],
    standalone: false
})
export class FindRegulationLibraryComponent implements OnInit {
  regulationSearchData$: Subject<Observable<RegulationLibraryResult[]>>;
  totalSearchRecord$: Subject<Observable<number>>;
  pageNumberResult$: Subject<number>;
  regulationResultData$!: Observable<RegulationLibraryResult[]>;
  totalResulRecords$!: Observable<number>;
  dsdsActionSearhResult: any;
  showTable = false;
  constructor() {
    this.regulationSearchData$ = new Subject();
    this.totalSearchRecord$ = new Subject();
    this.pageNumberResult$ = new Subject();
  }

  ngOnInit() {
    this.regulationSearchData$.subscribe((data: any) => {
      this.regulationResultData$ = data;
      this.showTable = true;
    });
    this.totalSearchRecord$.subscribe(data => {
      this.totalResulRecords$ = data;
    });

  }

}
