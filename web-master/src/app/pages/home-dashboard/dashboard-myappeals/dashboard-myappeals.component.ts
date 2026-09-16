
import {share, pluck} from 'rxjs/operators';
import { Component, OnInit, Input } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, Subject } from 'rxjs';
import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { DataStoreService, CommonHttpService } from '../../../@core/services';
import { DSDSActionDetails } from '../../case-worker/_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { AlertService } from '../../../@core/services/alert.service';


@Component({
    selector: 'dashboard-myappeals',
    templateUrl: './dashboard-myappeals.component.html',
    styleUrls: ['./dashboard-myappeals.component.scss'],
    standalone: false
})
export class DashboardMyappAppealsComponent implements OnInit {

    myApplicationList$!: Observable<any>;
    @Input()
  eventSubject$!: Subject<string>;
    totalRecords$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();

    constructor(private _alertService: AlertService, 
                private _dataStoreService: DataStoreService, 
                private _commonService: CommonHttpService, 
                private _router: Router) { }

    ngOnInit() {
      this.eventSubject$.subscribe((data) => {
        if (data === 'refresh') {
            this.getApplications(1);
        }
    });
    this.getApplications(1);
    }


    getApplications(pageNo: number) {
      this._commonService.endpointUrl = 'providerapplicant/getapplsassgndlist'
      const body = new PaginationRequest({
          where: { eventcode: 'APPEAL' },
          page: pageNo,
          limit: 10,
          method: 'post',
          count: -1
      });
      const source = this._commonService.getPagedArrayList(body).pipe(share());

      this.myApplicationList$ = source.pipe(pluck('data'));
      if (pageNo === 1) {
          this.totalRecords$ = source.pipe(pluck('count'));
      }
    }

    pageChanged(pageNo: number) {
        this.getApplications(pageNo);
    }

    routToCaseWorker(item: DSDSActionDetails) {
        this._commonService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            if (dsdsActionsSummary) {
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            const currentUrl = '/pages/case-worker/' + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/report-summary';
            this._router.navigate([currentUrl]);
            }
        });
      }
}
