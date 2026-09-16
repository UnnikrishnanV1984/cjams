import { ActivatedRoute } from '@angular/router';
import { CaseWorkerUrlConfig } from './../../case-worker-url.config';
import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from './../../../../@core/services/common-http.service';
import { DsdsService } from '../_services/dsds.service';
import { DataStoreService } from '../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'child-removal-list',
    templateUrl: './child-removal-list.component.html',
    styleUrls: ['./child-removal-list.component.scss'],
    standalone: false
})

export class ChildRemovalListComponent implements OnInit {

    id!: string;
    childRemovalList: any;
    isServiceCase = false;
    isShow!: string;
    placement: any;
    
    constructor(
        private _commonService: CommonHttpService,
        private route: ActivatedRoute,
        private _dsdsService: DsdsService,
        private _dataStoreService: DataStoreService
    ) {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    }
    ngOnInit() {
        this.getChildRemoval();
        this.isServiceCase = this._dsdsService.isServiceCase();
    }


    getChildRemoval() {
        const inputRequest = {
            objectid: this.id,
            objecttypekey: 'servicecase'
        };
        this._commonService
            .getSingle(
                {
                    where: inputRequest,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .GetChildRemovalList + '?filter'
            )
            .subscribe(result => {
                if (result && result.length) {
                    this.childRemovalList = result;
                }
            });
    }
    toggleClient(modal: any) {
        this.isShow = modal;
    }
}

