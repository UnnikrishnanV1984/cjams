import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { PersonDetailsService } from '../person-details.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-basic-details',
    templateUrl: './person-basic-details.component.html',
    styleUrls: ['./person-basic-details.component.scss'],
    standalone: false
})
export class PersonBasicDetailsComponent implements OnInit {
  basicTabs: any[] = [];
  personid: string | null | undefined;

  constructor(
    private route: ActivatedRoute,
    private personService: PersonDetailsService

  ) { }

  ngOnInit() {
    this.loadBasicTabs();
    this.personid = this.route.snapshot?.parent?.parent?.paramMap.get('personid');
    this.loadPersonInfo();
  }

  loadBasicTabs() {
    this.basicTabs = [{
      path: 'demographics',
      name: 'Demographics'
    },
    {
      path: 'names-relations',
      name: 'Other Names / Relations'
    }];
  }

  private loadPersonInfo() {
    this.personService.getPersonDetails(this.personid).subscribe(response => {
      this.personService.person = response;
    });
  }
}
