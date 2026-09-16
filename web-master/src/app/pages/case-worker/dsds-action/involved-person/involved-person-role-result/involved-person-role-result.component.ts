
import {pluck, share} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable ,  Subject } from 'rxjs';

import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { AlertService } from '../../../../../@core/services/alert.service';
import { GenericService } from '../../../../../@core/services/generic.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { InvolvedPerson } from '../_entities/involvedperson.data.model';
import { DataStoreService } from '../../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'involved-person-role-result',
    templateUrl: './involved-person-role-result.component.html',
    styleUrls: ['./involved-person-role-result.component.scss']
})
export class InvolvedPersonRoleResultComponent implements OnInit {

    @Input() involvedPersonPageSubject$ = new Subject<number>();
    id: string;
    daNumber: string;
    involevedPerson$: Observable<InvolvedPerson[]>;
    involevedPerson: InvolvedPerson = new InvolvedPerson();
    constructor(
        private _service: GenericService<InvolvedPerson>,
        private route: ActivatedRoute,
        private _alertService: AlertService,
        private _dataStoreService: DataStoreService) { }

    deletepopupid = '#delete-popup';

    ngOnInit() {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.involvedPersonPageSubject$.subscribe(value => {
            this.getInvolvedPerson();
        });
        this.getInvolvedPerson();
    }

    getInvolvedPerson() {
        this.involevedPerson$ = this._service
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: { intakeservreqid: this.id },
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl +
               '?data'
            ).pipe(share(),pluck('data'),);
    }

    deletePerson() {
        this._service
            .patch(this.id, { 'actorid': this.involevedPerson.actorid }, CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.DeletePerson)
            .subscribe(
                response => {
                    if (response) {
                        this._alertService.success(
                            'Person deleted successfully'
                        );
                        this.getInvolvedPerson();
                        ($(this.deletepopupid)).modal('hide');
                    }
                },
                error => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }

    declineDelete() {
        ($(this.deletepopupid)).modal('hide');
    }

    confirmDelete(id, model) {
        this.involevedPerson = model;
        ($(this.deletepopupid)).modal('show'); 
    }

}


