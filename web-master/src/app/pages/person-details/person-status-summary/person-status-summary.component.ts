import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services';
import { PersonDetailsService } from '../person-details.service';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
import { DropdownModel } from '../../../@core/entities/common.entities';
import { IntakeUtils } from '../../_utils/intake-utils.service';

@Component({
    selector: 'person-status-summary',
    templateUrl: './person-status-summary.component.html',
    styleUrls: ['./person-status-summary.component.scss'],
    standalone: false
})
export class PersonStatusSummaryComponent implements OnInit {

  intakeList: any[] = [];
  selectedValue: any;
  defaultValue: any;
  statusTimeline: any[] = [];
  constructor(
    private _commonHttpService: CommonHttpService,
    private _personDetailService: PersonDetailsService,
    private _intakeUtil: IntakeUtils
  ) { }

  ngOnInit() {
    this.loadDropdown();
  }

  loadDropdown() {
    this._commonHttpService.getArrayList(
      {
        where: { personid: this._personDetailService.person.personid },
        method: 'get'
      },
      CommonUrlConfig.EndPoint.PERSON.YOUTHSTATUS.intakeList + '?filter'
    ).subscribe(item => {
      this.intakeList = item.map(
        (res) =>
          new DropdownModel({
            text: res.intakenumber + (res.casenumber ? '-' + res.casenumber : ''),
            value: res
          })
      );
      this.selectedValue = this.intakeList.length ? this.intakeList[0].value : {};
      this.loadTimeLine(this.selectedValue);
    });
  }

  loadTimeLine(value: any) {
    this._intakeUtil.getFocusPersonStatus(this._personDetailService.person.personid, null, value.intakenumber, null)
      .subscribe(statuses => this.statusTimeline = statuses);
  }

}
