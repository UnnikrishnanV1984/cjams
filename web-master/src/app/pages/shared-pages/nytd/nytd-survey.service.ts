import { Injectable } from '@angular/core';
import { CommonHttpService } from '../../../@core/services';

@Injectable()

export class NytdSurveyService {
  intakeserviceid!: string;
  daNumber!: string;

  constructor(private _commonHttpService: CommonHttpService) {  }

  getNytdDataElements() {
    return this._commonHttpService.getArrayList(
      { nolimit: true, method: 'get' }, 
        'nytddataelements?filter'
    );
  }

  getNytdSummary(personid: any) {
    return this._commonHttpService.getArrayList(
      { nolimit: true, method: 'get', where: { 'personid' : personid } },
        'personnytdsummary?filter'
    );
  }

  getNytdDetail(summaryid: any) {
    return this._commonHttpService.getArrayList(
      { nolimit: true, method: 'get', where: { 'summaryid' : summaryid } }, 
      'personnytddetail?filter'
    );
  }

  getSurveyStatus() {
    return this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        where: { 'active_sw': 'Y', 'picklist_type_id': '10017', 'delete_sw': 'N' }
      },
      'tb_picklist_values/getpicklist' + '?filter'
    );
  }

  getReportTypes() {
    return this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        where: { 'active_sw': 'Y', 'picklist_type_id': '10016', 'delete_sw': 'N' }
      },
      'tb_picklist_values/getpicklist' + '?filter'
    );
  }

  getUserNames() {
    return this._commonHttpService.getArrayList(
      { nolimit: true, method: 'get' }, 
        'users/list?filter'
    );
  }

  createNewResponse(cjamspid: any, directive: any) { //add new or update existing based on directive
    return this._commonHttpService.create(
      { where: { 'cjamspid' : cjamspid, 'directive': directive } }, 
      'personnytddetail/add?filter'
    );
  }

  saveUpdateNytdSurvey(report: any, data: any, directive: any) {
    const payload: any = {};
    payload['summaryid'] = report.summaryid;
    payload['elements'] = data;
    payload['directive'] = directive;

    return this._commonHttpService.create(
      payload,
      'personnytddetail/saveUpdate?filter'
    );
  }

  documentGenerate(item: any, typeData: any) {
    const modal = {
      count: -1,
      where: {
        documenttemplatekey: ['nytd'],
        id: item.id,
        type: typeData,
        format: 'pdf'
      },
      method: 'post'
    };
    this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
      .subscribe(res => {
        const blob = new Blob([new Uint8Array(res)]);
        const link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        link.download = 'nytd.pdf';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    });
  }
}

