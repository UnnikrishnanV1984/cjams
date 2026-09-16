import { Component, OnInit } from '@angular/core';
import { AuthService, CommonHttpService } from '../../../@core/services';
import { ActivatedRoute } from '@angular/router';

@Component({
    selector: 'ive-afcarsreport',
    templateUrl: './ive-afcars-report.component.html',
    styleUrls: ['./ive-afcars-report.component.scss'],
    standalone: false
})

export class IveAfcarsReportComponent implements OnInit {
  loggedInUser: any;

  constructor (
    private _authService: AuthService,
    private route: ActivatedRoute,
    private _commonHttpService: CommonHttpService,
  ) { }
 
  ngOnInit() {
    this.loggedInUser = this._authService.getCurrentUser().user.userprofile.displayname;
  }

     // Trigger to pass the CJAMS information to CSMS
  sendIVEInformation() {
      this._commonHttpService.create(
          {
              'where': {
                  'userid': this.loggedInUser
              },
          },
          'titleive/ive/afcars-ene'
      ).subscribe(response => {
              return true;
          },
          (error) => {
              return false;
          });
  }

}
