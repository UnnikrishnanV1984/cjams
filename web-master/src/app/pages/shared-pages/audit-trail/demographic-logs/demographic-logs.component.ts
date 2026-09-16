import { Component, OnInit } from '@angular/core';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';
import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { Router, ActivatedRoute } from '@angular/router';
import { DataStoreService, CommonHttpService, AuthService, SessionStorageService } from '../../../../@core/services';

@Component({
    selector: 'demographic-logs',
    templateUrl: './demographic-logs.component.html',
    styleUrls: ['./demographic-logs.component.scss'],
    standalone: false
})
export class DemographicLogsComponent implements OnInit {

  selectedPerson: any;
  selectedCaseInfo: any = [];
  personid: string;
  isAuditVisible = false;
  auditLogs: any[] = [];
  aduitTotalRecords!: number;
  auditPaginationInfo: PaginationInfo = new PaginationInfo();
  caseworkerList: any[] = [];

  // search params
  fromDate: any;
  toDate: any;
  worker: any;
  isAuthorized:any;

  maxDate: Date = new Date();
  toMinDate: any = null;

  constructor(
    private _router: Router,
    private route: ActivatedRoute,
    private _commonHttpService: CommonHttpService,
    private _authService: AuthService,
    private _datastoreService:DataStoreService,
    private _session: SessionStorageService) {
    this.personid = this.route.snapshot.params['personid'];
  }

  ngOnInit() {
    // need to check for only supervisor
    this.auditPaginationInfo.sortColumn = 'modifiedon';
    this.isAuthorized= this._datastoreService.isAuthorized(); //for fortify issues 
    this.auditPaginationInfo.sortBy = 'desc';
    this.selectedPerson = this._session.getObj('personSearchSelectedPerson');
    this.loadAuditLogs(1);
    this.getCaseWorkerList();
  }

  getCaseWorkerList() {
    this._commonHttpService
      .getPagedArrayList(
        {
          where: { appevent: 'ALL' },
          method: 'post'
        },
        'Intakedastagings/getroutingusers'
      ).subscribe(result => {
        this.caseworkerList = result.data;
      });
  }



  loadAuditLogs(pageNumber: any) {
    this.auditPaginationInfo.pageNumber = pageNumber;
    this.getAuditLogs(this.personid, pageNumber).subscribe(response => {
      if (Array.isArray(response)) {
        this.auditLogs = response;
        if (pageNumber === 1 && response.length) {
          this.aduitTotalRecords = response[0].totalcount;
        }
      }
      else {
        this.auditLogs = [];
        this.aduitTotalRecords = 0;
      }
    });
  }

  clearSearch() {
    this.fromDate = null;
    this.toDate = null;
    this.worker = null;
    this.toMinDate = null;
    this.maxDate = new Date();
    this.loadAuditLogs(1);
  }

  getAuditLogs(personid: any, pageNumber: any) {
    return this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: pageNumber,
          limit: 10,
          where: {
            personid: personid,
            sortcolumn: this.auditPaginationInfo.sortColumn,
            sortorder: this.auditPaginationInfo.sortBy,
            updatedfrom: this.fromDate,
            updatedto: this.toDate,
            updatedby: this.worker
          },
          method: 'get'
        }),
        'People/getPersonAuditLog?filter'
      );
  }

  onAuditLogSorted($event: ColumnSortedEvent) {
    this.auditPaginationInfo.sortBy = $event.sortDirection;
    this.auditPaginationInfo.sortColumn = $event.sortColumn;
    this.loadAuditLogs(1);
  }

  auditPageChanged(event: any) {
    this.auditPaginationInfo.pageNumber = event.page;
    this.loadAuditLogs(this.auditPaginationInfo.pageNumber);
  }

  closeAuditLog() {
    this.selectedPerson = null;
    (<any>$('#person-audit-logs')).modal('hide');
  }

  goBack() {
    this._router.navigate(['../../cw-search'], { relativeTo: this.route });
  }

  fromDateChanged(fromDate: string) {
    this.toMinDate = new Date(fromDate);
  }
  toDateChanged(toDate: string){
    this.maxDate = new Date(toDate);
  }

}
