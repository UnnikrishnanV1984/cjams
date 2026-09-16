
import {pluck, share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';

import { GenericService, DataStoreService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { PriorList } from '../_entities/involvedperson.data.model';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'involved-person-dhs-action',
    templateUrl: './involved-person-dhs-action.component.html',
    styleUrls: ['./involved-person-dhs-action.component.scss']
})
export class InvolvedPersonDhsActionComponent implements OnInit {
    id: string;
    daNumber: string;
    intakeRequestId: string;
    priorList$: Observable<PriorList[]>;
    constructor(
        private _service: GenericService<PriorList>,
        route: ActivatedRoute,
        private _dataStoreService: DataStoreService
    ) {
        this.id =
        route.snapshot.params.dhsid;
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.intakeRequestId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    }

    ngOnInit() {
        ($('#involved-person-dhs-action')).modal('show');
        this.getPrior();
    }

    getPrior() {
         const source = this._service.getArrayList(
            new PaginationRequest({
                method: 'get',
                where: { intakerequestid: this.intakeRequestId}
            }), CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
            .PriorListUrl + `?personid=` + this.id + '&filter'
        ).pipe(share());
         this.priorList$ = source.pipe(pluck('data'));
        }
}
