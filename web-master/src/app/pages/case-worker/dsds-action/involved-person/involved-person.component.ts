import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { DataStoreService, AuthService } from '../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'involved-person',
    templateUrl: './involved-person.component.html',
    styleUrls: ['./involved-person.component.scss']
})
export class InvolvedPersonComponent {
    id: string;
    daNumber: string;
    private daStatus: string;
    involvedPersonPageSubject$ = new Subject<number>();
    constructor(route: ActivatedRoute, private _dataStoreService: DataStoreService, private _authService: AuthService) {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }
}
