import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService, CommonHttpService, DataStoreService, SessionStorageService, AuthService } from '../../../../@core/services';
import { TimeLineView } from '../../_entities/caseworker.data.model';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { TimeLineViewResolverService } from './time-line-view-resolver-service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'time-line-view',
    templateUrl: './time-line-view.component.html',
    styleUrls: ['./time-line-view.component.scss'],
    standalone: false
})
export class TimeLineViewComponent implements OnInit {
    id: string;
    daNumber: string;
    timeLineViewList: TimeLineView[] = [];
    isClosed = false;
    moduleview: any;
    constructor(private route: ActivatedRoute, private _alertService: AlertService,
        private _commonHttpService: CommonHttpService,
        private _dataStoreService: DataStoreService,
        private storage: SessionStorageService,
        private _authService: AuthService,private timeLineViewResolverService: TimeLineViewResolverService) {
        this.id =  this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        // this.route.data.subscribe(data => {
        //     if (data && data.hasOwnProperty('result')) {
        //       _authService.setAuthDetail('casetimeline',data.result);
        //     }
        // });
    }
    ngOnInit(){
        this.timeLineViewResolverService.getCasetimeline().subscribe({
            next: (data: any) => {
                this._authService.setAuthDetail('casetimeline',data);
            }
        })
        let isExpungementSuperUser=this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.moduleview=this._authService.isModuleAccessable('casetimeline','casetimeline');
        this._commonHttpService.getArrayList({},'Intakeservicerequests/getdatimeline/'+this.id+'?isExpungementSuperUser='+isExpungementSuperUser+`&iscaseexpunged=${iscaseexpunged}`).subscribe(
            (response)=>{
                this.timeLineViewList=response?response:[];
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );

        const da_status = this.storage.getItem('da_status');
        if (da_status) {
        if (da_status === 'Closed' || da_status === 'Completed') {
            this.isClosed = true;
        } else {
            this.isClosed = false;
        }
        }
    }

    openWindow(data: TimeLineView) {
        window.open('#/pages/case-worker/' + data.intakeserviceid + '/' + data.servicerequestnumber + '/dsds-action/report-summary', '_blank');
    }
}
