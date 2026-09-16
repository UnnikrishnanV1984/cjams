import { Component } from '@angular/core';
import { CompliantDetailsService } from '../compliant-details.service';

@Component({
    selector: 'petition-details',
    templateUrl: './petition-details.component.html',
    styleUrls: ['./petition-details.component.scss'],
    standalone: false
})
export class PetitionDetailsComponent {

  petitions: any[] = [];
  constructor(private complaintDetailsService: CompliantDetailsService) {
    if (this.complaintDetailsService.complaintDetails && this.complaintDetailsService.complaintDetails.petitions) {
      this.petitions = this.complaintDetailsService.complaintDetails.petitions;
    }
  }

  toggleTable(id: any) {
    (<any>$('#' + id)).collapse('toggle');
  }


}
