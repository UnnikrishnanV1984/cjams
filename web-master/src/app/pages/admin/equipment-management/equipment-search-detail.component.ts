import { Component, Input } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';

import { Equipment } from './_entities/equipment-management.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'equipment-search-detail',
    templateUrl: './equipment-search-detail.component.html',
    styleUrls: ['./equipment-search-detail.component.scss'],
    standalone: false
})
export class EquipmentSearchDetailComponent {
  @Input() equipmentSearchDetails$!: Observable<Equipment[]>;
  @Input() totalRecords$!: Observable<number>;
  @Input() canDisplayPager$!: Observable<boolean>;
  @Input() equipmentSearchPageSubject$ = new Subject<number>();
  @Input() equipmentSearchTriggeredSubject$!: Subject<string>;
  currentPageNumber = 1;
  selectedDetailIdSubject$ = new Subject<string>();
  selectedEquipment!: string;

  pageChanged(pageInfo: any) {
    this.currentPageNumber = pageInfo.page;
    this.equipmentSearchPageSubject$.next(this.currentPageNumber);
  }

  equipmentSearchDetailItem(model: any) {
    this.selectedEquipment = model.equipmentid;
    this.selectedDetailIdSubject$.next(model.teammemberequipmentid);
  }
}
