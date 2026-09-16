
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
// tslint:disable-next-line:import-blacklist
import { Observable } from 'rxjs';
import { Router, ActivatedRoute } from '@angular/router';
import { PaginationInfo, DropdownModel, PaginationRequest } from '../../../@core/entities/common.entities';
import { CommonHttpService, AlertService } from '../../../@core/services';
import { PersonDetailsService } from '../person-details.service';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-youthstatus',
    templateUrl: './person-youthstatus.component.html',
    styleUrls: ['./person-youthstatus.component.scss'],
    standalone: false
})
export class PersonYouthstatusComponent implements OnInit {

  intakeList: any[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  intakeListAll$!: Observable<any>;
  selectedValue: any;
  selectedIntake: any;
  intakeListAllcount$!: Observable<number>;
  defaultValue: any;
  showOpenButton = false;
  openDescription = 'Re-Entry';
  updateNotes: any;
  notesPlaceholder = 'Notes...';
  isStatus = '';
  isDetention: any;
  isCommunityMonitoring: any;
  constructor(private _commonHttpService: CommonHttpService, private _alertSevice: AlertService,
    private _personDetailService: PersonDetailsService,
    private router: Router,
    private route: ActivatedRoute) { }

  ngOnInit() {
    this.loadDropdown();
    this.selectedValue = this.defaultValue = { intakeserviceid: '', intakenumber: '' };
    this.changedIntake(1, this.selectedValue);
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
    });
  }

  changedIntake(pagenumber: any, value: any) {
    this.cancelSelected();
    this.selectedValue = value;
    const source = this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          nolimit: true,
          where: {
            personid: this._personDetailService.person.personid,
            intakeserviceid: this.returnIntakeserviceid(value),
            intakenumber: this.returnIntakenumber(value),
            status: 'Open'
          },
          method: 'get'
        }),
        CommonUrlConfig.EndPoint.Intake.personStatus
      ).pipe(
      map((result: any) => {
        if (this.selectedValue.intakenumber) {
          this.personStatusResponseFn(result);
        }
        return {
          data: result,
          count: this.returnCountFn(result)
        };
      }),
      share(),);
    this.intakeListAll$ = source.pipe(pluck('data'));
    if (pagenumber === 1) {
      this.intakeListAllcount$ = source.pipe(pluck('count'));
    }
  }

  private personStatusResponseFn(result: any) {
    if (result.length === 0) {
      this.showOpenButton = true;
      this.openDescription = 'Re-Entry';
    } else {
      this.isDetention = result.filter((status: { focuspersonstatustypekey: string; }) => status.focuspersonstatustypekey === 'DET');
      this.isCommunityMonitoring = result.filter((status: { focuspersonstatustypekey: string; }) => status.focuspersonstatustypekey === 'CM');
      if (this.isDetention.length > 0 && this.isCommunityMonitoring.length === 0) {
        this.showOpenButton = true;
        this.openDescription = 'Community Monitoring';
      } else {
        this.showOpenButton = false;
      }
    }
  }

  private returnCountFn(result: any): any {
    return result.length > 0 ? result[0].totalcount : 0;
  }

  private returnIntakenumber(value: any) {
    return value.intakenumber ? value.intakenumber : null;
  }

  private returnIntakeserviceid(value: any) {
    return value.intakeserviceid ? value.intakeserviceid : null;
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
    this.changedIntake(pageInfo.page, this.selectedValue);
  }

  changeStatus(value: any) {
    this.selectedIntake = value;
    this.updateNotes = null;
    if (!value.focuspersoncasestatusid && value.intakenumber) {
      this.isStatus = 'Open';
    } else {
      this.isStatus = 'Close';
    }
    $('#notes-popup').modal('show');
  }

  updateStatus() {
    if (!this.updateNotes) {
      this._alertSevice.warn('Please enter notes.');
      return;
    }
    const value = this.selectedIntake;
    if (!value.focuspersoncasestatusid && value.intakenumber) {
      value.personid = this._personDetailService.person.personid;
      if (this.openDescription !== 'Re-Entry') {
        value.focuspersonstatustypekey = 'CM';
      } else {
        value.focuspersonstatustypekey = 'RE';
      }
      value.status = 'Open';
      value.opennotes = this.updateNotes;
    } else {
      value.status = 'Closed';
      value.closenotes = this.updateNotes;
    }
    this._commonHttpService.create(value, CommonUrlConfig.EndPoint.PERSON.YOUTHSTATUS.UpdateStatus).subscribe(result => {
      this._alertSevice.success('Youth Status Updated successfully for ' + this.selectedIntake.intakenumber + '!');
      $('#notes-popup').modal('hide');
      this.pageChanged(this.paginationInfo);
      this.cancelSelected();
    }, error => {
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  cancelSelected() {
    this.selectedIntake = null;
    this.updateNotes = '';
    this.isDetention = null;
    this.showOpenButton = false;
    this.openDescription = 'Re-Entry';
  }


}
