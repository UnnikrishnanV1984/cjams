import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { PersonDetail } from '../_entities/involvedperson.data.model';
import { GenericService, DataStoreService } from '../../../../../@core/services';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { Subject } from 'rxjs';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
declare var $: any;

@Component({
  // tslint:disable-next-line:component-selector
  selector: 'involved-person-search-view',
  templateUrl: './involved-person-search-view.component.html',
  styleUrls: ['./involved-person-search-view.component.scss']
})
export class InvolvedPersonSearchViewComponent implements OnInit {
    id: string;
    personid: string;
    daNumber: string;
    firstname: string;
    lastname: string;
    address: PersonDetail[] = [];
    person: PersonDetail[] = [];
    dhsAction: PersonDetail[] = [];
    clearing: PersonDetail[] = [];
    person$ = new Subject<PersonDetail[]>();
  constructor( route: ActivatedRoute,private _dataStoreService: DataStoreService,
    private _service: GenericService<PersonDetail>) {
      this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
      this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
      this.personid = route.snapshot.params.personid; }

  ngOnInit() {
    ($('#view-persons-search')).modal('show');
    this.getPerson();
  }


  getPerson() {
    this._service
    .getPagedArrayList(
        new PaginationRequest({
            method: 'get',
            where: { intakeserviceid : this.id},
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.Person +
            '/' + this.personid +
            '?data'
    ).subscribe( result => {
        this.person$.next(result.data);
    });
}

}
