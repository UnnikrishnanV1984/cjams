import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { DataStoreService } from '../../../../@core/services';
import { IntakeStoreConstants } from '../my-newintake.constants';

@Component({
    selector: 'intake-private-adoption',
    templateUrl: './intake-private-adoption.component.html',
    standalone: false
})
export class IntakePrivateAdoptionComponent implements OnInit {

  privateadoptionform!: FormGroup;
  constructor(
    private _formBilder: FormBuilder,
    private _datastoreService: DataStoreService
  ) { }

  ngOnInit() {
    this.initFormGorup();
    this.patchSavedValues();
    this.privateadoptionform.valueChanges.subscribe(data => {
      this._datastoreService.setData(IntakeStoreConstants.PRIVATE_ADOPTION, data);
    });
    if(this._datastoreService.getData(IntakeStoreConstants.INTAKE_IS_CLOSED)){
      this.privateadoptionform.disable();}
  }

  patchSavedValues() {
    const roacps = this._datastoreService.getData(IntakeStoreConstants.PRIVATE_ADOPTION);
    if (roacps) {
      this.privateadoptionform.patchValue(roacps);
    }
  }

  initFormGorup() {
    this.privateadoptionform = this._formBilder.group({
      adoptiondate: [null],
      adoptionofferedflag: [null],
      subsidyflag: [null],
      isofferaccepted: false,
      paymentkeytype: [null],
      fatheragreementdate: [null],
      motheragreementdate: [null],
      designeeagreementdate: [null]
    });
  }
}
