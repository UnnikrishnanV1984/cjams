import { Component, OnInit } from '@angular/core';
import { DataStoreService, CommonHttpService } from '../../../../../@core/services';
import { CasePlanService } from '../case-plan.service';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

@Component({
    selector: 'case-plan-legacy',
    templateUrl: './case-plan-legacy.component.html',
    styleUrls: ['./case-plan-legacy.component.scss'],
    standalone: false
})
export class CasePlanLegacyComponent implements OnInit {
  casePlanLegacyData : any;
  caseId: any;
  personId: any;
  store: any;
  cp1Data: any;
  case: any;
  childInfo: any;
  generatedocurl = 'evaluationdocument/generateintakedocument';
  fullscreenstr = 'fullscreen=yes';
  locationstr = 'location=yes';
  pdfcontenttype = 'application/pdf';
  viewdocerrmsg = "Error occured in case plan 1 view document";
  constructor(
    private _dataStoreService: DataStoreService,
    private _casePlanService: CasePlanService,
    private _commonHttpService: CommonHttpService,
  ) { 
    this.store = this._dataStoreService.getCurrentStore();
    this.cp1Data = this.store['SELECTED_CHILD_DATA'];
    this.caseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID)
  }

  ngOnInit() {
    this.onGetCasePlanLegacyInfo();
  }

  onGetCasePlanLegacyInfo(){    
    this.personId = this.cp1Data ? this.cp1Data.personid : null;     
    if(this.personId && this.caseId){     
          const selectedCase = this._casePlanService.getCasePlanLegacyInfo(this.caseId,this.personId);    
          selectedCase.subscribe(data => {   
            this.case = data;       
            this.childInfo = this.case ? this.case.childinfo : null;
            this.casePlanLegacyData = data;            
          
        });
    }
  }
  
  downloadCasePlan1(data: { caseplanid: any; }){
    const modal = {
      count: -1,
      where: {
        documenttemplatekey: ['caseplan1'],
        caseplanid: data.caseplanid,
        caseid: this.caseId
      },
      method: 'post'
    };
    this._commonHttpService.download(this.generatedocurl, modal).subscribe( response => {
      const pdfData = response && response !== null  ?   response : '';
      const blob = new Blob([new Uint8Array(pdfData)]);
      const link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob);
      link.download = 'Case Plan1.pdf';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
  }

  viewCasePlan(condition: any) {
    const modal = {
      count: -1,
      where: condition,
      method: 'post'
    };
    this._commonHttpService.download(this.generatedocurl, modal).subscribe(response => {
      const viewPdfData = response && response !== null ? response : '';
      const params = [
        'height=' + screen.height,
        'width=' + screen.width,
        this.fullscreenstr,
        this.locationstr
      ].join(',');
      const blob = new Blob([new Uint8Array(viewPdfData)], { type: this.pdfcontenttype });
      const fileURL = window.URL.createObjectURL(blob);
      window.open(fileURL, params);
    });
  }

  viewCasePlan1(data: any) {
    let condition: any = {
      documenttemplatekey: ['caseplan1'],
      caseplanid: data.caseplanid,
      caseid: this.caseId
    };

    this.viewCasePlan(condition);
  }

  downloadCasePlan2(data: { caseplanid: any; }){
    const modal = {
      count: -1,
      where: {
        documenttemplatekey: ['caseplan2'],
        caseplanid: data.caseplanid,
        caseid: this.caseId
      },
      method: 'post'
    };
    this._commonHttpService.download(this.generatedocurl, modal).subscribe( response => {
      const pdfData = response && response !== null  ?   response : '';
      const blob = new Blob([new Uint8Array(pdfData)]);
      const link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob);
      link.download = 'Case Plan-2.pdf';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
  }

  viewCasePlan2(data: { caseplanid: any; }){
    let condition = {
      documenttemplatekey: ['caseplan2'],
      caseplanid: data.caseplanid,
      caseid: this.caseId
    };

    this.viewCasePlan(condition);
  }

  viewCasePlan3ServiceAgr(data: { caseplan3servagreementid: any; }) {
    let condition = {
      documenttemplatekey: ['caseplan3agreement'],
      caseid: this.caseId,
      agreementid: data.caseplan3servagreementid
    };

    this.viewCasePlan(condition);
  }

  downloadCasePlan3ServiceAgr(data: { caseplan3servagreementid: any; }){
    const modal = {
      count: -1,
      where: {
        documenttemplatekey: ['caseplan3agreement'],        
        caseid: this.caseId,
        agreementid: data.caseplan3servagreementid
      },
      method: 'post'
    };
    this._commonHttpService.download(this.generatedocurl, modal).subscribe( response => {   
      const pdfData = response && response !== null  ?   response : '';  
      const blob = new Blob([new Uint8Array(pdfData)]);
      const link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob);
      link.download = 'Case Plan3 Service Agreement.pdf';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
  }

  viewCasePlanAppla(data: { caseplanid: any; }){
    let condition = {
      documenttemplatekey: ['caseplan3appla'],
      caseplanid: data.caseplanid,
      caseid: this.caseId
    };

    this.viewCasePlan(condition);
  }

  downloadCasePlanAppla(data: { caseplanid: any; }){
    const modal = {
      count: -1,
      where: {
        documenttemplatekey: ['caseplan3appla'],
        caseplanid: data.caseplanid,
        caseid: this.caseId
      },
      method: 'post'
    };
    this._commonHttpService.download(this.generatedocurl, modal).subscribe( response => {   
      const pdfData = response && response !== null  ?   response : '';  
      const blob = new Blob([new Uint8Array(pdfData)]);
      const link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob);
      link.download = 'Case Plan3 Appla.pdf';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
  }

  viewCasePlan4ILP(data: { caseplanid: any; }){
    let condition = {
      documenttemplatekey: ['caseplan4ilp'],
      caseplanid: data.caseplanid,
      caseid: this.caseId
    };

    this.viewCasePlan(condition);
  }

  downloadCasePlan4ILP(data: { caseplanid: any; }){
    const modal = {
      count: -1,
      where: {
        documenttemplatekey: ['caseplan4ilp'],
        caseplanid: data.caseplanid,
        caseid: this.caseId
      },
      method: 'post'
    };
    this._commonHttpService.download(this.generatedocurl, modal).subscribe( response => {
      const pdfData = response && response !== null  ?   response : '';
      const blob = new Blob([new Uint8Array(pdfData)]);
      const link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob);
      link.download = 'Case Plan4 ILP.pdf';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
  }
}
