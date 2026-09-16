import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../@core/services';
import { IntakeStoreConstants } from '../my-newintake.constants';

@Component({
    selector: 'intake-history-clearance',
    templateUrl: './intake-history-clearance.component.html',
    standalone: false
})
export class IntakeHistoryClearanceComponent implements OnInit {
  reason: any;
  maxDate: any;
  general: any;

  historyForm!: FormGroup;
  constructor(
    private _commonHttpService: CommonHttpService,
    private _formBilder: FormBuilder,
    private _datastoreService: DataStoreService,
    private _authService: AuthService
  ) { }

  ngOnInit() {
    this.general = this._datastoreService.getData(IntakeStoreConstants.general);
    this.initFormGorup();
    this.loadDropdowns();
    this.patchSavedValues();
    this.historyForm.valueChanges.subscribe(data => {
      this._datastoreService.setData(IntakeStoreConstants.clearhistory, data);
    });
    if(this._datastoreService.getData(IntakeStoreConstants.INTAKE_IS_CLOSED)){
      this.historyForm.disable();}
  }

  patchSavedValues() {
    const roacps = this._datastoreService.getData(IntakeStoreConstants.clearhistory);
    if (roacps) {
      this.historyForm.patchValue(roacps);
    }
  }

  initFormGorup() {
    this.historyForm = this._formBilder.group({
      reason: [null],
      startdatetime: [null],
      workername: [this.general ? this.general.Author : ''],
      thirdparty: [null],
      individual: [null],
      comments: [null],
      close: [null]
    });
  }

  loadDropdowns() {
    this._commonHttpService.getArrayList({
      nolimit: true,
      where: { referencetypeid: 98 }, order: 'displayorder ASC', method: 'get'
    },
      'referencevalues?filter').subscribe(res => {
        this.reason = res;
      });
  }
}
