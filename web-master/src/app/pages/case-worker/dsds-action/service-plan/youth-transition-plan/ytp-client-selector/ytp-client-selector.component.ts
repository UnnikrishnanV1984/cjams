import { Component, OnInit } from '@angular/core';

import { DataStoreService } from '../../../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { IntakeUtils } from '../../../../../_utils/intake-utils.service';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import { ChildRemovalService } from '../../../child-removal/child-removal.service';
import _ from 'lodash';

// FILTER CRITERIA
const YOUTH_AGE_BAR = 14;
const YOUTH_DUE_DAY_COUNT = 120; // YOUTH_AGE_BAR - YOUTH_DUE_DAY_COUNT
// DUE DATE CALC CRITERIA
// IF AGE > 14 THEN ADD REMOVAL_BUFFER_COUNT FROM REMOVAL DATE 
// ELSE 14th BIRTHDAY DATE.
const REMOVAL_BUFFER_COUNT = 60;
const API_DATE_FORMAT = 'YYYY/MM/DD';
@Component({
    selector: 'ytp-client-selector',
    templateUrl: './ytp-client-selector.component.html',
    styleUrls: ['./ytp-client-selector.component.scss'],
    standalone: false
})
export class YTPClientSelectorComponent implements OnInit {

  id!: string;
  personList: any[] = [];
  childList: any[] = [];
  YOUTH_AGE_BAR = YOUTH_AGE_BAR;

  constructor(
    private _childRemoval: ChildRemovalService,
    private _dataStoreService: DataStoreService,
    private _intakeUtils: IntakeUtils,
    private _youthTransitionPlanService: YouthTransitionPlanService,
    private _ytpService: YouthTransitionPlanService
  ) { }

  ngOnInit() {
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this._childRemoval.getChildRemoval(1).subscribe((items) => {
      if (items && items.length) {
        this.childList = items.filter((person: { dob: string; }) => {
          const totalDays = this._intakeUtils.getAgeFormatBy(person.dob, API_DATE_FORMAT, 'days');
          if (totalDays >= (YOUTH_AGE_BAR * 365) - YOUTH_DUE_DAY_COUNT) {
            return true;
          } else {
            return false;
          }
        });
        this.childList.forEach(res => {
          res.fullname = this.getFullName(res);
          return res.fullname;
        });

        this.childList.forEach(child => {

          if (child.childremoval && Array.isArray(child.childremoval) && child.childremoval.length) {
            this.ifChildremovalFn(child);
          } else {
            child.removalInfo = null;
            child.dueDate = null;
          }
        });
        this._dataStoreService.setData('PERSONLIST-CASE-PLAN', this.childList);
      } else {
        this.childList = [];
      }

    });
  }
  // Associated with ngOnInit function
  private ifChildremovalFn(child: any) {
    const removalHistory = _.orderBy(child.childremoval, ['removalid'], ['desc']);
    child.removalInfo = removalHistory[0];
    child.dueDate = this.calculateDueDate(child);
    this._ytpService.getYTPPlanList(child.personid).subscribe((data) => {
      if (data && data.length) {
        let maxDate = child.dueDate;
        data.forEach(plan => {
          if (maxDate && plan.nextduedate && maxDate <= new Date(plan.nextduedate)) {
            maxDate = plan.nextduedate;
          }
        });
        child.dueDate = maxDate;
      }
    });
  }

  getFullName(person: any) {
    const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
    let name = '';
    nameKeys.forEach(key => {
      if(person && person.hasOwnProperty(key)){
      if ( (person[key] != null) && (person[key] != 'null') && (person[key] != '') ) {
        name = name + person[key] + ' ';
      }}
    });
    return name.trim();
  }
  selectedPerson(child: any) {
    this._dataStoreService.setData(CASE_STORE_CONSTANTS.YTP_PERSON_ID, child.personid);
    this._dataStoreService.setData('YTP_SEL_CHILD', child);
    this._youthTransitionPlanService.onGetPerson.emit(child.personid);
  }

  calculateDueDate(child: any) {
    const age = this._intakeUtils.getAgeFormat(child.dob, API_DATE_FORMAT);

    if (age >= YOUTH_AGE_BAR) {

      return this._intakeUtils.addDate(child.removalInfo.removaldate, API_DATE_FORMAT, REMOVAL_BUFFER_COUNT, 'days');
    } else {
      // Setting 14th birthday date
      return this._intakeUtils.addDate(child.dob, API_DATE_FORMAT, YOUTH_AGE_BAR, 'years');
    }

  }

  
}
