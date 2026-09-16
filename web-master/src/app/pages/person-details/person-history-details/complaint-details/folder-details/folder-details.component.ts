import { Component } from '@angular/core';
import { CompliantDetailsService } from '../compliant-details.service';
import { Router } from '@angular/router';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'folder-details',
    templateUrl: './folder-details.component.html',
    styleUrls: ['./folder-details.component.scss'],
    standalone: false
})
export class FolderDetailsComponent {

  folders: any[] = [];
  constructor(private complaintDetailsService: CompliantDetailsService,
    private _router: Router) {
    if (this.complaintDetailsService.complaintDetails && this.complaintDetailsService.complaintDetails.folders) {
      this.folders = this.complaintDetailsService.complaintDetails.folders;
    }
  }

  openFoder(item: any) {
    switch (item.foldertype) {
      case 'Intake':
      case 'LegalAction':
        this.routeToIntake(item.intakenumber);
        break;
      default:
        this.routeToCase(item.intakenumber);
    }
  }
  routeToIntake(intakenumber: any) {
    const currentUrl = '/pages/newintake/my-newintake/' + intakenumber + '/edit/';
    this._router.navigate([currentUrl]);
  }

  routeToCase(_caseNumber: any) {
    // need case uuid to route
  }

}
