import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService, CommonHttpService, DataStoreService } from '../../../../@core/services';
import { TimeLineView } from '../../_entities/caseworker.data.model';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

@Component({
    selector: 'time-line-view-djs',
    templateUrl: './time-line-view-djs.component.html',
    styleUrls: ['./time-line-view-djs.component.scss'],
    standalone: false
})

export class TimeLineViewDjsComponent implements OnInit {
    id: string;
    daNumber: string;
    timeLineViewList: TimeLineView[] = [];
    constructor(private route: ActivatedRoute, private _alertService: AlertService, private _commonHttpService: CommonHttpService, private _dataStoreService: DataStoreService) {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }
    ngOnInit() {
        this._commonHttpService.getArrayList({}, 'Intakeservicerequests/getdatimelinedjs/' + this.id).subscribe(
            (response) => {
                this.timeLineViewList = response ? response : [];
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    openWindow(data: TimeLineView) {
        window.open('#/pages/case-worker/' + data.intakeserviceid + '/' + data.servicerequestnumber + '/dsds-action/report-summary', '_blank');
    }
}

