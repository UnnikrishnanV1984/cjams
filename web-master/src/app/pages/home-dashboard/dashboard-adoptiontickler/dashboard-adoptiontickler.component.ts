

import { Component, Input, OnInit } from '@angular/core';
import { Subject } from 'rxjs';
import { Router } from '@angular/router';
import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { CommonHttpService, DataStoreService } from '../../../@core/services';
import { HomeDashboardUrlConfig } from '../home-dashbaord.url.config';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ExcelService } from '../excel.service';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { CommonModule } from '@angular/common';
import { MatSortModule } from '@angular/material/sort';

@Component({
    selector: 'dashboard-adoptiontickler',
    templateUrl: './dashboard-adoptiontickler.component.html',
    styleUrls: ['./dashboard-adoptiontickler.component.scss'],
    imports:[MatSortModule,PaginationModule,FormsModule,CommonModule,ReactiveFormsModule],
    standalone: true
})
export class DashboardAdoptionticklerComponent implements OnInit {

    @Input()
    eventSubject$!: Subject<string>;

    taskList: any;
    totalRecord: any;
    paginationInfo: PaginationInfo = new PaginationInfo();
    myirForm!: FormGroup;
    constructor(private _commonService: CommonHttpService,
        private _router: Router,
        private _dataStoreService: DataStoreService, private _formBuilder: FormBuilder,  private excelService: ExcelService) { }

    ngOnInit() {
        this.myirForm = this._formBuilder.group({
            filter: ['Nex30']
        });
        this.gettaskList(1);
        this.eventSubject$?.subscribe(data => {

            if (data === 'refresh') {
                this.gettaskList(1);
            }
        });
    }

    gettaskList(pageNo: number) {
        const adoptioncount = this._dataStoreService.getData('ADOPTIONCASEDASHBOARD-COUNT');
        const adoptionLoaded = this._dataStoreService.getData('ADOPTIONCASEDASHBOARD-LOADED');
        const servicecount = this._dataStoreService.getData('SERVICECASEDASHBOARD-COUNT');
        const serviceLoaded = this._dataStoreService.getData('SERVICECASEDASHBOARD-LOADED');
        if ((!adoptionLoaded || !serviceLoaded ) || (adoptionLoaded && serviceLoaded && (adoptioncount !== 0 || servicecount !== 0))) {
            this._commonService.endpointUrl = `${HomeDashboardUrlConfig.EndPoint.myDsdsActions.reportAdoptionORGap}?filter`;
            const body = new PaginationRequest({
                where: {filterdatetype : this.myirForm.value.filter ? this.myirForm.value.filter : 'Nex30'},
                limit: 10,
                method: 'get',
                page: pageNo
            });

        this._commonService.getPagedArrayList(body).subscribe((data: any) => {
            if (data) {
                this.taskList = data[0].getadoptionorgapreportbyuser;
                if (pageNo === 1) { 
                    this.totalRecord =  data[0].totalcount;
                }
            }
            });
      }
    }
    ExportTOExcel() {
      this.excelService.exportAsExcelFile(this.taskList, 'downloadAdoptionGap');
    }


    pageChanged(page: number) {
        this.gettaskList(page);
    }
    routToCaseWorker(item: any) {
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
