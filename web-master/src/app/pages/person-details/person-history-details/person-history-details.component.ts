import { Component, OnInit } from '@angular/core';

@Component({
    selector: 'person-history-details',
    templateUrl: './person-history-details.component.html',
    styleUrls: ['./person-history-details.component.scss'],
    standalone: false
})
export class PersonHistoryDetailsComponent implements OnInit {
  basicTabs: any[] = [];

  ngOnInit() {
    this.loadBasicTabs();
  }

  loadBasicTabs() {
    this.basicTabs = [{
      path: 'history',
      name: 'Legal Actions History'
    },
    {
      path: 'probation',
      name: 'Probation Orders'
    }];
  }

}
