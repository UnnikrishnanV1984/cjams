import { Component, OnInit } from '@angular/core';
import { ComplaintTypeCase } from '../../_entities/newintakeSaveModel';
import { DataStoreService } from '../../../../../@core/services';
import { IntakeStoreConstants } from '../../my-newintake.constants';

@Component({
    selector: 'intake-referral-casegrid',
    templateUrl: './intake-referral-casegrid.component.html',
    styleUrls: ['./intake-referral-casegrid.component.scss'],
    standalone: false
})
export class IntakeReferralCasegridComponent implements OnInit {

  createdCases: ComplaintTypeCase[] = [];
  constructor(
    private _datastore: DataStoreService) { }

  ngOnInit() {
    this.processSavedCases();
  }

  processSavedCases() {
    const createdCases = this._datastore.getData(IntakeStoreConstants.createdCases);
    if (createdCases && Array.isArray(createdCases)) {
        this.createdCases = createdCases;
    } else {
        this.createdCases = [];
    }
}

}
