import { Component, OnInit } from '@angular/core';
import { Subject ,  Observable } from 'rxjs';

import { EntitiesSearchEntity } from '../_entities/find-entity.module';

@Component({
    selector: 'app-entities',
    templateUrl: './entities.component.html',
    styleUrls: ['./entities.component.scss'],
    standalone: false
})

export class EntitiesComponent implements OnInit {

  searchEntitiesList$: Subject<Observable<EntitiesSearchEntity[]>>;
  searchTotalRecords$: Subject<Observable<number>>;
  resultsEntitiesList$!: Observable<EntitiesSearchEntity[]>;
  resultsTotalRecords$!: Observable<number>;
  resultsPageNumber$: Subject<number>;
  pageNumber$!: Subject<number>;
  showTable = false;
  constructor() {
    this.searchEntitiesList$ = new Subject();
    this.searchTotalRecords$ = new Subject();
    this.resultsPageNumber$ = new Subject();
  }

  ngOnInit() {
    this.searchEntitiesList$.subscribe(data => {
      this.resultsEntitiesList$ = data;
      this.showTable = true;
    });

    this.searchTotalRecords$.subscribe(data => {
      this.resultsTotalRecords$ = data;
    });
  }
}
