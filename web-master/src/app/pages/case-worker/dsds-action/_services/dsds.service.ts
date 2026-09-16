import { Injectable } from '@angular/core';
import { SessionStorageService } from '../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

@Injectable()
export class DsdsService {
  attachmenttype:any;
  personid:string='';
  constructor(private _session: SessionStorageService) {

  }

  isServiceCase() {
    return this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
  }
  setField(name:any, value:any) {
    (this as any)[name] = value;
  }
  getField(name:any) {
    return (this as any)[name];
  }

}
