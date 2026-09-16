import { Component, OnInit } from '@angular/core';
import { Observable, Subject } from 'rxjs';

import { DocumentsSearchEntity } from '../_entities/find-entity.module';



@Component({
    selector: 'documents',
    templateUrl: './documents.component.html',
    styleUrls: ['./documents.component.scss'],
    standalone: false
})
export class DocumentsComponent implements OnInit {

  searchDocumentsList$: Subject<Observable<DocumentsSearchEntity[]>>;
  searchTotalRecords$: Subject<Observable<number>>;
  resultsPageNumber$: Subject<number>;

  resultsDocumentsList$!: Observable<DocumentsSearchEntity[]>;
  resultsTotalRecords$!: Observable<number>;

  pageNumber$!: Subject<number>;
  showResult = false;
  showView = false;
  constructor() {
    this.searchDocumentsList$ = new Subject<Observable<DocumentsSearchEntity[]>>();
    this.searchTotalRecords$ = new Subject<Observable<number>>();
    this.resultsPageNumber$ = new Subject<number>();
  }

  ngOnInit() {
    this.searchDocumentsList$.subscribe(data => {
      this.resultsDocumentsList$ = data;
      this.showResult = true;
      this.showView = false;
    });

    this.searchTotalRecords$.subscribe(data => {
      this.resultsTotalRecords$ = data;
      this.showView = false;
    });
  }
}
