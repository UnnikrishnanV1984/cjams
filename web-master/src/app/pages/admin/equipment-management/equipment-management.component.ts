import { Component, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';

import { Equipment } from './_entities/equipment-management.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'equipment-management',
    templateUrl: './equipment-management.component.html',
    styleUrls: ['./equipment-management.component.scss'],
    standalone: false
})
export class EquipmentManagementComponent implements OnInit {
  equipmentSearchSubject$ = new Subject<Observable<Equipment[]>>();
  totalRecordsSubject$ = new Subject<Observable<number>>();
  canDisplayPagerSubject$= new Subject<Observable<boolean>>();
  equipmentSearchPageSubject$ = new Subject<number>();
  equipmentSearchDetails$!: Observable<Equipment[]>;
  totalRecords$!: Observable<number>;
  canDisplayPager$!: Observable<boolean>;
  equipmentSearchTriggeredSubject$ = new Subject<string>();

  ngOnInit() {
    this.equipmentSearchSubject$.subscribe(value => {
      this.equipmentSearchDetails$ = value;
    });
    this.totalRecordsSubject$.subscribe(value => {
      this.totalRecords$ = value;
    });
    this.canDisplayPagerSubject$.subscribe(value => {
    this.canDisplayPager$ = value;
  });

  }
}

