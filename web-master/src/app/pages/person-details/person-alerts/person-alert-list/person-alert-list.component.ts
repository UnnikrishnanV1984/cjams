import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { PersonAlertsService } from '../person-alerts.service';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { AlertDisplay } from '../../../../@core/common/models/involvedperson.data.model';
import { PersonDetailsService } from '../../person-details.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-alert-list',
    templateUrl: './person-alert-list.component.html',
    styleUrls: ['./person-alert-list.component.scss'],
    standalone: false
})
export class PersonAlertListComponent implements OnInit {
  personid!: string | null | undefined;
  paginationInfo: PaginationInfo = new PaginationInfo();
  paginationHistoryInfo: PaginationInfo = new PaginationInfo();
  totalRecords!: number;

  alerts: AlertDisplay[] = [];
  alertsHistory: AlertDisplay[] = [];

  constructor(private router: Router,
    private route: ActivatedRoute,
    private _service: PersonAlertsService,
    public personService: PersonDetailsService) { }

  ngOnInit() {
    this.personid = this.route.snapshot.parent?.parent?.parent?.paramMap.get('personid');
    this.loadAlerts();
  }

  addAlert() {
    this.router.navigate(['../create'], { relativeTo: this.route });
  }

  viewAlert(alert: any) {
    this._service.selectedAlert = {
      personid: this.personid,
      personalertid: alert.personalertid,
      alerttype: alert.alerttype,
      status: alert.status,
      startdatetime: alert.startdatetime,
      enddatetime: alert.enddatetime,
      notes: alert.notes,
      activeflag: alert.activeflag,
      personalerttype: alert.personalerttype,
      alertid: alert.alertid
    };
    this.router.navigate(['../view'], { relativeTo: this.route });
  }

  editAlert(alert: any) {
    this._service.selectedAlert = {
      personid: this.personid,
      personalertid: alert.personalertid,
      alerttype: alert.alerttype,
      status: alert.status,
      startdatetime: alert.startdatetime,
      enddatetime: alert.enddatetime,
      notes: alert.notes,
      activeflag: alert.activeflag,
      personalerttype: alert.personalerttype,
      alertid: alert.alertid
    };
    this.router.navigate(['../edit'], { relativeTo: this.route });
  }

  loadAlerts() {
    this._service.getAlerts(this.personid, this.paginationInfo).subscribe((alert: any) => {
      this.alerts = alert.data;
      if (this.alerts.length > 0) {
        this.totalRecords = this.alerts[0].totalcount;
      }
    });
  }

  loadHistoryAlerts() {
    this._service.getHistoryAlerts(this.personid, this.paginationHistoryInfo).subscribe((alert: any) => {
      this.alertsHistory = alert.data;
    });
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.loadAlerts();
  }
}
