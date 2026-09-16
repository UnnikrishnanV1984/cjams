
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
    selector: 'dashboard-ldss-myinquiries',
    templateUrl: './dashboard-ldss-myinquiries.component.html',
    styleUrls: ['./dashboard-ldss-myinquiries.component.scss'],
    standalone: false
})
export class DashboardLDSSMyinquiriesComponent implements OnInit {

    myApplicationList$!: Observable<any>;
    totalRecords$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();

    constructor(private _alertService: AlertService, 
                private _dataStoreService: DataStoreService, 
                private _commonService: CommonHttpService, 
                private _router: Router) { }

    ngOnInit() {
       this.getApplications(1);
    }


    getApplications(pageNo: number) {
      this._commonService.endpointUrl = 'publicproviderreferral/getassignedlist'
      const body = new PaginationRequest({
           where: { 
            activeflag: 1,
            requesttype: 'dashboard'
          },
          
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
