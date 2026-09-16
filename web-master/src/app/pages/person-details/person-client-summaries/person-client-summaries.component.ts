import { Component, OnInit } from '@angular/core';
import { PersonDetailConstants } from '../person-details-constants';
import { PersonDetailsService } from '../person-details.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-client-summaries',
    templateUrl: './person-client-summaries.component.html',
    styleUrls: ['./person-client-summaries.component.scss'],
    standalone: false
})
export class PersonClientSummariesComponent implements OnInit {


  summaryTabs: any[] = [];
  IS_HEADER_TAB_NEEDED = true;
  constructor(private personService: PersonDetailsService) { }

  ngOnInit() {
    this.loadSummaryTabs();
    this.listenPersonStatus();

  }

  private listenPersonStatus() {
    this.personService.personStatus$.subscribe(status => {
      this.isHeaderTabNeeded();
    });
  }

  isHeaderTabNeeded() {
    if (this.personService.personStatus !== PersonDetailConstants.ALL) {
      this.IS_HEADER_TAB_NEEDED = false;
    }
  }

  loadSummaryTabs() {
    this.summaryTabs = [{
      path: 'offense',
      name: 'Offense Summary'
    },
    {
      path: 'contact-notes',
      name: 'Contact Notes Summary'
    },
    {
      path: 'placement',
      name: 'Placement Summary'
    },
    {
      path: 'review',
      name: 'Review Summary'
    }];
  }
}
