import { Component, OnInit } from '@angular/core';
import { CommonHttpService, DataStoreService } from '../../../../../@core/services';
import { NewUrlConfig } from '../../../newintake-url.config';
import { InvolvedPerson } from '../../_entities/newintakeModel';
import { IntakeStoreConstants } from '../../my-newintake.constants';

@Component({
    selector: 'intake-referral-persongrid',
    templateUrl: './intake-referral-persongrid.component.html',
    styleUrls: ['./intake-referral-persongrid.component.scss'],
    standalone: false
})
export class IntakeReferralPersongridComponent implements OnInit {
  genders: any = [];
  addedPersons: InvolvedPerson[] = [];
  constructor(private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService) { }

  ngOnInit() {
    this.getGender();
    this.addedPersons = this._dataStoreService.getData(IntakeStoreConstants.addedPersons) ? this._dataStoreService.getData(IntakeStoreConstants.addedPersons) : [];
  }

  private getGender() {
    this._commonHttpService.create(
      {
        where: { activeflag: 1 },
        method: 'post',
        nolimit: true
      },
      NewUrlConfig.EndPoint.Intake.GenderTypeUrl + '/genderlist'
    ).subscribe(data => {
      for (const gender of data) {
        this.genders[gender.gendertypekey] = gender.typedescription;
      }
    });
  }

}
