import { Component } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { PersonDetailsService } from '../../person-details.service';
import { CompliantDetailsService } from './compliant-details.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'complaint-details',
    templateUrl: './complaint-details.component.html',
    styleUrls: ['./complaint-details.component.scss'],
    standalone: false
})
export class ComplaintDetailsComponent {

  complaintDetails: any = null;
  constructor(private router: Router,
    private route: ActivatedRoute,
    private personService: PersonDetailsService,
    private _service: CompliantDetailsService) {
      this.route.data.subscribe(response => {
        this.complaintDetails = response.complaintDetails[0];
        this._service.complaintDetails = this.complaintDetails;
      });
     }

}
