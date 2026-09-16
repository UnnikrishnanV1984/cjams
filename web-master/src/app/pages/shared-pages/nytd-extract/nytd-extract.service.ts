import { Injectable } from '@angular/core';
import { CommonHttpService } from '../../../@core/services';
import {saveAs} from 'file-saver';

@Injectable()

export class NytdExtractService {
  intakeserviceid!: string;
  daNumber!: string;

  constructor(private _commonHttpService: CommonHttpService) {  }

  getNytdSummary(reportingperiod: any) {
    return this._commonHttpService.getArrayList(
      { nolimit: true, method: 'get', where: { 'reportingperiod': reportingperiod } },
        'personnytdsummary/list?filter'
    );
  }

  getReportingPeriods() {
    return this._commonHttpService.getArrayList(
      { nolimit: true, method: 'get' },
        'personnytdsummary/reportingperiods?filter'
    );
  }

  getReportTypes() {
    return this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        where: { 'active_sw': 'Y', 'picklist_type_id': '10016', 'delete_sw': 'N' }
      },
      'tb_picklist_values/getpicklist?filter'
    );
  }

  getUserNames() {
    return this._commonHttpService.getArrayList(
      { nolimit: true, method: 'get' }, 
        'users/list?filter'
    );
  }

  downloadAsXml(period: any) {
    return this._commonHttpService.downloadXml(`personnytddetail/${period}/xml`);
  }

  saveAsXMLFile(buffer: any, fileName: string): void {
    const data: Blob = new Blob([buffer], {
      type: 'application/xml'
    });
    saveAs(data, fileName + '.xml');
  }
}

