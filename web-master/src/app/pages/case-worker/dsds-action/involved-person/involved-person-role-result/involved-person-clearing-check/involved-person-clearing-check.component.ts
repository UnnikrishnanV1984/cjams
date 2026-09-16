import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { DataStoreService } from '../../../../../../@core/services';
declare var $: any;
@Component({
  // tslint:disable-next-line:component-selector
  selector: 'involved-person-clearing-check',
  templateUrl: './involved-person-clearing-check.component.html',
  styleUrls: ['./involved-person-clearing-check.component.scss']
})
export class InvolvedPersonClearingCheckComponent implements OnInit {
  [x: string]: any;
    id: string;
    daNumber: string;
  constructor( route: ActivatedRoute,private _dataStoreService: DataStoreService) {
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
   }

  ngOnInit() {
    ($('#clearing-popup')).modal('show');
  }

}
