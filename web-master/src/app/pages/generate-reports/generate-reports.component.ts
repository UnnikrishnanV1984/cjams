import { Component, OnInit } from '@angular/core';
import { CommonHttpService, AuthService } from '../../@core/services';
import { Router, ActivatedRoute } from '@angular/router';
import { AppUser } from '../../@core/entities/authDataModel';
import { GenerateReportsService } from './generate-reports.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'generate-reports',
    templateUrl: './generate-reports.component.html',
    standalone: false
})
export class GenerateReportsComponent implements OnInit {
  reports: any;
  selectedReport: any;
  user: AppUser;

  constructor(
    private _commonHttpService: CommonHttpService,
    private _router: Router,
    private _route: ActivatedRoute,
    private _authService: AuthService,
    private _service: GenerateReportsService
  ) {
    this.user = this._authService.getCurrentUser();
  }

  ngOnInit() {
    this.loadReports();
  }

  loadReports() {
    this._commonHttpService.getArrayList({
      nolimit: true,
      where: { referencetypeid: this._service.roleKeyMap[this.user.role.name] }, 'order': 'displayorder ASC', method: 'get'
    },
      'referencevalues?filter').subscribe(response => {
        this.reports = response;
        if (this.reports.length) {
          this.loadSelectedReport(this.reports[0].ref_key);
        }
      });
  }

  loadSelectedReport(report: string) {
    this.selectedReport = report;
    switch (report) {
      case 'CCR':
        this._router.navigate(['ccu'], { relativeTo: this._route, skipLocationChange: true });
        break;
      case 'NCBPR':
        this._router.navigate(['new-case'], { relativeTo: this._route, skipLocationChange: true });
        break;
      case 'EO21':
      case 'EU21':
      case 'ERC':
        this._router.navigate(['exception'], { relativeTo: this._route, skipLocationChange: true, queryParams: { report: report } });
        break;
      case 'PLBS':
        this._router.navigate(['balance-sheet'], { relativeTo: this._route, skipLocationChange: true });
        break;
      case 'CLR':
        this._router.navigate(['courtlist-report'], { relativeTo: this._route, skipLocationChange: true });
        break;
      case 'LR':
        this._router.navigate(['level-report'], { relativeTo: this._route, skipLocationChange: true });
        break;
      case 'PCR':
        this._router.navigate(['census-report'], { relativeTo: this._route, skipLocationChange: true });
        break;
    }
  }

}
