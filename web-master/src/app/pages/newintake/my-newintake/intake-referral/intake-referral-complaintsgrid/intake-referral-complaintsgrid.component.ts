import { Component, OnInit } from '@angular/core';
import { EvaluationFields } from '../../_entities/newintakeSaveModel';
import { DataStoreService, CommonHttpService } from '../../../../../@core/services';
import { IntakeStoreConstants } from '../../my-newintake.constants';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { NewUrlConfig } from '../../../newintake-url.config';

@Component({
    selector: 'intake-referral-complaintsgrid',
    templateUrl: './intake-referral-complaintsgrid.component.html',
    styleUrls: ['./intake-referral-complaintsgrid.component.scss'],
    standalone: false
})
export class IntakeReferralComplaintsgridComponent implements OnInit {

  offenceCategoryList: any = [];
  evals: EvaluationFields[] = [];
  purposeID = '';
  constructor(private _datastore: DataStoreService,
    private _commonHttpService: CommonHttpService) { }

  ngOnInit() {
    this.processSavedEvaluations();
    this._datastore.currentStore.subscribe(store => {
      if (store[IntakeStoreConstants.purposeSelected]) {
          const purposeSelected = store[IntakeStoreConstants.purposeSelected];
          const storePurposeId = purposeSelected.value;
          if (storePurposeId !== this.purposeID) {
              this.purposeID = storePurposeId;
              this.listAllegations(this.purposeID);
          }
      }
  });
  }

  processSavedEvaluations() {
    const evaluations = this._datastore.getData(IntakeStoreConstants.evalFields);
    if (evaluations && Array.isArray(evaluations)) {
      evaluations.forEach(evalFeilds => {
        if (evalFeilds.allegedoffense) {
          evalFeilds.allegedoffense = evalFeilds.allegedoffense.map((offence: any) => {
            if (offence.allegationid) {
              return offence.allegationid;
            } else {
              return offence;
            }
          });
        }
      });
      this.evals = evaluations;
    } else {
      this.evals = [];
    }
  }

  listAllegations(purposeID: any) {
    const checkInput = {
      where: { intakeservreqtypeid: purposeID },
      method: 'get',
      nolimit: true,
      order: 'name'
    };
    this._commonHttpService
      .getArrayList(new PaginationRequest(checkInput), NewUrlConfig.EndPoint.Intake.allegationsUrl + '?filter')
      .subscribe(offenceCategories => {
        if (offenceCategories) {
          offenceCategories.forEach(offence => {
            this.offenceCategoryList[offence.allegationid] = offence.name;
          });
        }
      });
  }

}
