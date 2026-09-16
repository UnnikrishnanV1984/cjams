import { Component, OnInit } from '@angular/core';
import { CommonHttpService, DataStoreService } from '../../../@core/services';

@Component({
    selector: 'quick-person-history',
    templateUrl: './quick-person-history.component.html',
    styleUrls: ['./quick-person-history.component.scss'],
    standalone: false
})
export class QuickPersonHistoryComponent implements OnInit {

  quickPersonHistoryList: any = [];
  maxPageSize = 10;
  query = {};
  showProgress : boolean = false;

  constructor(
    private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService,
   ) { }


  ngOnInit() {
    this.getquickperson();
  }

 

  getquickperson() {
    this.showProgress = true;
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    let intakeserviceid = null;
    let intakenumber = this._dataStoreService.getData('intakenumber') ?  this._dataStoreService.getData('intakenumber') : this._dataStoreService.getData('da_intakenumber') ;
    if (caseInfo) {
      intakeserviceid = caseInfo.intakeserviceid;
      intakenumber = caseInfo.intakenumber;
    }
    const request = {
        objectid: intakenumber ? intakenumber : intakeserviceid , 
        objecttype: intakenumber ? 'intake' : 'case'
    };
    this._commonHttpService.getArrayList(
      {
        where: request,
        method: 'get',
        nolimit: true
      },
      'quickpersonhistory/list?filter'
    ).subscribe(data => {
       if (data && data.length) {
         this.quickPersonHistoryList = data;  
       }
       this.showProgress = false;
    });
  }
}

