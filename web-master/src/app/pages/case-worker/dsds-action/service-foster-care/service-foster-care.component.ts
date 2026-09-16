import { Component, OnInit } from '@angular/core';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { DataStoreService } from '../../../../@core/services/data-store.service';
import { DsdsService } from '../_services/dsds.service';
@Component({
    selector: 'service-foster-care',
    templateUrl: './service-foster-care.component.html',
    styleUrls: ['./service-foster-care.component.scss'],
    standalone: false
})
export class ServiceFosterCareComponent implements OnInit {
  scFosterCareList: any[] = [];
  id!: string;
  danumber!: string;
  selectedPlacement: any;
  placementView!: boolean;
  isServiceCase = false;
  isShow!: string;
  constructor(private _commonService: CommonHttpService, private _dataStoreService: DataStoreService, private _dsdsService: DsdsService) { }

  ngOnInit() {
    this.isServiceCase = this._dsdsService.isServiceCase();
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.danumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.getSCfosterCareList();
    this.placementView = false;
  }

  getSCfosterCareList() {
    this._commonService.getSingle(
        {
            'count': -1,
            'page': 1,
            'limit': 50,
            'where': { 'objectid': this.id, 'casenumber': null },
            'method': 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care
            .fostercarereferallistUrl + '?filter'
    )
        .subscribe(result => {
            if (result && result.length) {
                this.scFosterCareList = result;
            }
        });
}

getPlacementDates(log: any, isentry: any) {
  if (log && log.length) {
      const event = { date: this.getEventDate(log, isentry), time: this.getEventTime(log, isentry)};
      return event.date + ' ' + event.time;
  } else {
      return '';
  }
}

getEventDate(log: any, isentry: number){
    if (isentry === 1) {
        return (log[0].entry_dt) ? log[0].entry_dt : '';
    } else {
        return (log[0].exit_dt) ? log[0].exit_dt : '';
    }
}

getEventTime(log: any, isentry: number){
    if (isentry === 1) {
        return (log[0].entry_tm) ? log[0].entry_tm : '';
    } else {
        return (log[0].exit_tm) ? log[0].exit_tm : '';
    }
}

showPlacementInfo(placement: any) {
    this.selectedPlacement = placement;
    this.placementView = true;
}
showList() {
    this.placementView = false;
}
toggleClient(modal: any) {
      this.isShow = modal;
    }

}
