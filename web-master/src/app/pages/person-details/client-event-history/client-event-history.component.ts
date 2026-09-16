import { Component, OnInit } from '@angular/core';
import { ClientEventHistoryService } from './client-event-history.service';
import { PersonDetailsService } from '../person-details.service';
import { PaginationInfo, DropdownModel } from '../../../@core/entities/common.entities';
import { CommonDropdownsService } from '../../../@core/services';
import { Observable } from 'rxjs';
import { Router } from '@angular/router';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'client-event-history',
    templateUrl: './client-event-history.component.html',
    styleUrls: ['./client-event-history.component.scss'],
    standalone: false
})
export class ClientEventHistoryComponent implements OnInit {

  paginationInfo: PaginationInfo = new PaginationInfo();
  totalRecords!: number;
  folderTypes$!: Observable<DropdownModel[]>;
  folderType!: string;
  status!: string;
  Statuses: DropdownModel[] = [];
  clientEventHistoires: any[] = [];
  constructor(private _service: ClientEventHistoryService,
    private personService: PersonDetailsService,
    private dropdownService: CommonDropdownsService,
    private _router: Router) {
  }

  ngOnInit() {
    this.paginationInfo.pageNumber = 1;
    this.paginationInfo.pageSize = 10;
    this.loadDropdowns();
    this.loadTable();
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.loadTable();
  }

  private loadDropdowns() {
    this.folderTypes$ = this.dropdownService.getFolderTypes();
    this.Statuses = this.getStatuses();
  }

  public loadTable() {

    const params = { personid: this.personService.person.personid, foldersearch: this.folderType, statussearch: this.status };
    this.paginationInfo.where = params;
    this._service.getClientEventHistory(this.paginationInfo).subscribe((response: any) => {
      this.clientEventHistoires = response;
      if (this.clientEventHistoires.length) {
        this.totalRecords = this.clientEventHistoires[0].totalcount;
      }

    });
  }
  openFoder(item: any) {
    switch (item.foldertype) {
      case 'Intake':
      case 'LegalAction':
        this.routeToIntake(item.servicerequestnumber);
        break;
      default:
        this.routeToCase(item);
    }
  }
  routeToIntake(intakenumber: any) {
    const currentUrl = '/pages/newintake/my-newintake/' + intakenumber + '/edit/';
    this._router.navigate([currentUrl]);
  }

  routeToCase(item: any) {
    const currentUrl = '/pages/case-worker/' + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/report-summary-djs';
    this._router.navigate([currentUrl]);
  }
  private getStatuses() {
    return [{
      text: 'Accepted',
      value: 'Accepted'
    },
    {
      text: 'Active',
      value: 'Active'
    },
    {
      text: 'Closed',
      value: 'Closed'
    }];
  }
}