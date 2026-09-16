import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { CommonHttpService, SessionStorageService } from '../../../@core/services';
import { PaginationInfo } from '../../../@core/entities/common.entities';

@Component({
    selector: 'audit-trail',
    templateUrl: './audit-trail.component.html',
    styleUrls: ['./audit-trail.component.scss'],
    standalone: false
})
export class AuditTrailComponent implements OnInit {

  caseId: string;
  paginationInfo: PaginationInfo = new PaginationInfo();
  logs: any = [];
  totalRecords: any;
  caseInfo: any;
  caseNumber: string;

  maxDate: Date = new Date();
  toMinDate: Date | null = null;
  constructor(private _router: Router,
    private route: ActivatedRoute,
    private _commonHttpService: CommonHttpService,
    private _session: SessionStorageService) {
    this.caseId = this.route.snapshot.params['caseid'];
    this.caseNumber = this.route.snapshot.params['casenumber'];
  }
  caseworkerList: any[] = [];
  // search params
  fromDate: any;
  toDate: any;
  worker: any;

  ngOnInit() {

    this.paginationInfo.sortColumn = 'updatedon';
      this.paginationInfo.sortBy = 'desc';
    this.caseInfo = this._session.getObj('caseSearchItem');
    this.loadLogs(1);

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

  public loadLogs(pageNumber: number) {
    const searchData = {
      sortcol: this.paginationInfo.sortColumn,
      sortby: this.paginationInfo.sortBy,
      objectid: this.caseId,
      casenumber: this.caseNumber,
      updatedfrom: this.fromDate,
      updatedto: this.toDate,
      updatedby: this.worker
    }
    this._commonHttpService
      .getArrayList(
        {
          limit: this.paginationInfo.pageSize,
          order: this.paginationInfo.sortBy,
          page: pageNumber,
          count: this.paginationInfo.total,
          where: searchData,
          method: 'get'
        },
        'Auditlog/listbyobjectid?filter'
      )
      .subscribe(response => {
        if (Array.isArray(response) && response.length) {
          this.logs = response;
          this.totalRecords = response[0].totalcount;

        } else {
          this.logs = [];
          this.totalRecords = 0;
        }


      });

  }


  clearSearch() {
    this.fromDate = null;
    this.toDate = null;
    this.worker = null;
    this.toMinDate = null;
    this.maxDate = new Date();
    this.loadLogs(1);
  }

  pageChanged(event: any) {
    this.paginationInfo.pageNumber = event.page;
    this.loadLogs(this.paginationInfo.pageNumber);
  }

  onLogSort($event: any) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.loadLogs(1);
  }


  goBack() {
    this._router.navigate(['../../../'], { relativeTo: this.route });
  }

  fromDateChanged(fromDate: string) {
    this.toMinDate = new Date(fromDate);
  }

  toDateChanged(toDate: string){
    this.maxDate = new Date(toDate);
  }

}
