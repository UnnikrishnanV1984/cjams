import { Injectable } from '@angular/core';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { GenericService } from '../../../../@core/services';
import { Observable } from 'rxjs';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { TransportationAddEdit } from '../../_entities/caseworker.data.model';

@Injectable()
export class TransportService {

  constructor(private _service: GenericService<any>) { }

  getTransportations(id: string, paginationInfo: PaginationInfo): Observable<any> {
    return this._service.getPagedArrayList({
      method: 'get',
      where: {
        intakeserviceid: id,
        personid: null
      },
      page: paginationInfo.pageNumber,
      limit: paginationInfo.pageSize

    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.Transport.TransportationList);
  }

  getFromDropDownList(): Observable<any[]> {
    return this._service.getArrayList({ method: 'get' }, CaseWorkerUrlConfig.EndPoint.DSDSAction.Transport.FromList);
  }

  getToDropDownList(): Observable<any[]> {
    return this._service.getArrayList({ method: 'get' }, CaseWorkerUrlConfig.EndPoint.DSDSAction.Transport.ToList);
  }

  addTrasnsport(transport: TransportationAddEdit): Observable<any> {
    return this._service.create(transport, CaseWorkerUrlConfig.EndPoint.DSDSAction.Transport.AddTransport);
  }

  deleteTransport(trasportid: string): Observable<any> {
    return this._service.remove(trasportid, {}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Transport.DeleteTransport);
  }

  getTransportById(transportid: string): Observable<any> {
    return this._service.getSingle({
      method: 'get',
      where: {
        persontransportationid: transportid
      }
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.Transport.TransportationById
    );
  }

  updateTransport(transport: TransportationAddEdit, transportid: any): Observable<any> {
    return this._service.create(transport, CaseWorkerUrlConfig.EndPoint.DSDSAction.Transport.UpdateTransport + transportid);
  }
  routingupdateTransport(data: any) {
    return this._service.create(data, 'routing/routingupdate');
  }
}
