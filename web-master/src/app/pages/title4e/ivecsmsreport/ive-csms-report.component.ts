import { Component, OnInit } from '@angular/core';
import { AuthService, CommonHttpService, AlertService} from '../../../@core/services';
import { ActivatedRoute } from '@angular/router';

@Component({
    selector: 'ive-csms',
    templateUrl: './ive-csms-report.component.html',
    standalone: false
})

export class IveCSMSReportComponent implements OnInit {
  loggedInUser: any;
  csmsdetails: any;


  constructor (
    private _authService: AuthService,
    private route: ActivatedRoute,
    private _alertService: AlertService,
    private _commonHttpService: CommonHttpService,
  ) { }
 
  ngOnInit() {
    this.getIVEReferralList();
    this.loggedInUser = this._authService.getCurrentUser().user.userprofile.displayname;
  }

     // Trigger to pass the CJAMS information to CSMS
  sendIVEInformation(details:any) {
      this._commonHttpService.create(
          {
              'where': {
                'clientId': details.clientid,
                'removalId': details.removalid,
                'reviewperiod': null
              },
          },
          'titleive/ive/ivecsms-data'
      ).subscribe(response => {
            return true;
          },
          (error) => {
            return false;
          });
  }

  getIVEReferralList(){
    this._commonHttpService.getSingle(
      {
        method: 'post'
      },
      'titleive/ive/csmsreferrals'
    ).subscribe(data => {
        this.csmsdetails = data[0].getcsmsivereferralsinfo;
    });
  }


}
