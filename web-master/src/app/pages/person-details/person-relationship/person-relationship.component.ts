import { Component } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { PersonDetailsService } from '../person-details.service';
import { RelationshipService } from './relationship.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-relationship',
    templateUrl: './person-relationship.component.html',
    styleUrls: ['./person-relationship.component.scss'],
    standalone: false
})
export class PersonRelationshipComponent {
  constructor(private router: Router,
    public personService: PersonDetailsService,
    private relationShipService: RelationshipService,
    private route: ActivatedRoute) {
    this.route.data.subscribe(res => {
      this.relationShipService.relativePersons = res.relations;
    });
  }

}
