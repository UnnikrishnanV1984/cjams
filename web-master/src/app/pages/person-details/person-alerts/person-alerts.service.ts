import { Injectable } from '@angular/core';
import { Alert } from '../../../@core/common/models/involvedperson.data.model';
import { GenericService } from '../../../@core/services';
import { Observable } from 'rxjs';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
import { PaginationInfo } from '../../../@core/entities/common.entities';

@Injectable()
export class PersonAlertsService {
  _alerts: Alert[] = [];
  selectedAlert?: Alert | null;
  constructor(private _service: GenericService<Alert>) { }

  getAlerts(personid: any, paginationInfo: PaginationInfo): Observable<Alert[]> {
    return this._service
      .getArrayList({
        where: {
          personid: personid
        },
        method: 'get',
        page: paginationInfo.pageNumber,
        limit: paginationInfo.pageSize
      }, CommonUrlConfig.EndPoint.PERSON.AlertList);
  }

  addAlert(newAlert: Alert): Observable<any> {
    return this._service.create(newAlert, CommonUrlConfig.EndPoint.PERSON.AddAlert);
  }

  updateAlert(alert: Alert): Observable<any> {
    return this._service.create(alert, CommonUrlConfig.EndPoint.PERSON.UpdateAlert);
  }

  getHistoryAlerts(personid: any, paginationInfo: PaginationInfo): Observable<Alert[]> {
    return this._service
      .getArrayList({
        where: {
          personid: personid
        },
        method: 'get',
        page: paginationInfo.pageNumber,
        limit: paginationInfo.pageSize
      }, CommonUrlConfig.EndPoint.PERSON.AlertHistoryList);
  }

  getRestiutionAlertDetails(personalertid: any): Observable<any[]> {
    return this._service
      .getArrayList({
        where: {
          personalertid: personalertid
        },
        method: 'get',
      }, CommonUrlConfig.EndPoint.PERSON.RestituitionAlertDetails);
  }

}
