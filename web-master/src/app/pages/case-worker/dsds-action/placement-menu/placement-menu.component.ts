import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { SessionStorageService } from '../../../../@core/services/storage.service';
import { DataStoreService } from '../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'placement-menu',
    templateUrl: './placement-menu.component.html',
    standalone: false
})
export class PlacementMenuComponent implements OnInit {
    id: any;
    daNumber: any;
    isServiceCase!: string;
    constructor(private route: ActivatedRoute,
        private storage: SessionStorageService,
        private _dataStoreService: DataStoreService) {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }

    ngOnInit() {
        this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    }
}
