import { Component, Input } from '@angular/core';
import { Subject ,  Observable } from 'rxjs';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { EntitiesSearchEntity } from '../../_entities/find-entity.module';

@Component({
    selector: 'entities-results',
    templateUrl: './entities-results.component.html',
    styleUrls: ['./entities-results.component.scss'],
    standalone: false
})
export class EntitiesResultsComponent {

  @Input()
  resultsPageNumber$!: Subject<number>;
  @Input()
  resultsEntitiesList$!: Observable<EntitiesSearchEntity[]>;
  @Input()
  resultsTotalRecords$!: Observable<number>;

  selectedEntity$: Subject<EntitiesSearchEntity>;
  paginationInfo: PaginationInfo = new PaginationInfo();
  @Input() showTable: boolean;

  constructor() {
    this.selectedEntity$ = new Subject<EntitiesSearchEntity>();
    this.showTable = false;
  }

  pageChanged(pageNumber: number) {
    this.paginationInfo.pageNumber = pageNumber;
    this.resultsPageNumber$.next(pageNumber);
  }

  entitySelected(entity: EntitiesSearchEntity) {
    this.selectedEntity$.next(entity);
  }
}
