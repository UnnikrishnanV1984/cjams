import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { PersonDisabilityService } from './person-disability.service';

@Component({
    selector: 'person-disability',
    templateUrl: './person-disability.component.html',
    styleUrls: ['./person-disability.component.scss'],
    standalone: false
})
export class PersonDisabilityComponent {

  constructor(private route: ActivatedRoute, private _service: PersonDisabilityService) {
    this.route.data.subscribe(res => {
      this._service.person = res.personDetails;
    });
  }
}
