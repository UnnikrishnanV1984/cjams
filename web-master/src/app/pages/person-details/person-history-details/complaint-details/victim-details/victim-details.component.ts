import { Component } from '@angular/core';
import { CompliantDetailsService } from '../compliant-details.service';

@Component({
    selector: 'victim-details',
    templateUrl: './victim-details.component.html',
    styleUrls: ['./victim-details.component.scss'],
    standalone: false
})
export class VictimDetailsComponent {

  victims: any[] = [];
  constructor(private complaintDetailsService: CompliantDetailsService) {
    if (this.complaintDetailsService.complaintDetails && this.complaintDetailsService.complaintDetails.victim) {
      this.victims = this.complaintDetailsService.complaintDetails.victim;
    }
  }
}
