import { Component, Injector, OnInit } from '@angular/core';
import { CommonHttpService, AlertService, DataStoreService } from '../../../../../../@core/services';
import { PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { pluck, share } from 'rxjs';

@Component({
  selector: 'ytp-fcgs-audit',
  templateUrl: './ytp-fcgs-audit.component.html',
  styleUrls: ['./ytp-fcgs-audit.component.scss'],
  standalone: false
})
export class YtpFcgsAuditComponent implements OnInit {
  auditlogTrail: any[] = [];
  ready = false;
  loading = false;
  errorMessage: string | null = null;
  id!: string;
  personList: any[] = [];

  private _commonHttpService: CommonHttpService;
  private _alertService: AlertService;
  private _ytpService: YouthTransitionPlanService;
  private _dataStoreService: DataStoreService;

  constructor(private injector: Injector) {
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._ytpService = this.injector.get<YouthTransitionPlanService>(YouthTransitionPlanService);
    this._dataStoreService = this.injector.get < DataStoreService > (DataStoreService);
  }

  ngOnInit(): void {
    
    const ytpId = this._ytpService.youthtransitionplanid;

    if (!ytpId) {
      this.errorMessage = 'No Youth Transition Plan selected. Please select a plan to view history.';
      this.ready = true;
      return;
    }

    this.loadAuditHistory(ytpId);
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.getInvolvedPerson();
  }

  loadAuditHistory(youthtransitionplanid: string): void {
    this.loading = true;
    this.errorMessage = null;
    this.auditlogTrail = [];
    this.ready = false;

    this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
        limit: 30,
        page: 1,
        method: 'get',
        where: {
          columnid: 'youthtransitionplanid',
          tableid: 'youthtransitionplan_history',
          objectid: youthtransitionplanid
        }
      }),
      'servicecase/getauditlog?filter'
    ).subscribe({
      next: (result: any) => {
        this.loading = false;
        this.ready = true;
        
        if (result && result.data) {
          this.auditlogTrail = result.data;
          this.mapAuditPersonIdToName();
        } else {
          this.auditlogTrail = [];
        }
      },
      error: (err: any) => {
        this.loading = false;
        this.ready = true;
        this.auditlogTrail = [];
        this.errorMessage = 'Unable to load Foster Care to Adult Guardianship Checklist history.';
        this._alertService.error('Unable to load FCGS audit history');
      }
    });
  }

  reload(): void {
    const ytpId = this._ytpService.youthtransitionplanid;
    if (ytpId) {
      this.loadAuditHistory(ytpId);
    }
  }

  getInvolvedPerson() {
    const reqObj: any = {
      objectid: this.id,
      objecttypekey: 'servicecase'
    };
    const personsList = this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 100,
          nolimit: true,
          method: 'get',
          where: reqObj
        }),
        `People/getpersondetailcw?filter`
      ).pipe(
        share(),
        pluck('data'),);
    personsList.subscribe((items: any) => {
      this.personList = items || [];

      this.getcollateral();
    });
  }
  getcollateral() {
    const request = {
      objectid: this.id,
      objecttype: 'case'
    };
    this._commonHttpService.getArrayList(
      {
        where: request,
        method: 'get',
        nolimit: true
      },
      'collateral/list?filter'
    ).subscribe(res => {
      if (res?.length && res[0]?.getcollateraldetails?.length) {
        res[0].getcollateraldetails.forEach((element: any) => {
            this.personList.push({
              personid: element.collateralid,
              fullname: element.fullname,
              dob: element.dob,
              roles: element.collateralroleconfig
            });
        });
      }

      this.mapAuditPersonIdToName();
    });
  }

  getPersonNameById(personId: string): string {
    const person = this.personList.find((item: any) => item.personid === personId);
    return person ? person.fullname : personId;
  }

  mapAuditPersonIdToName() {
    if (!this.auditlogTrail?.length || !this.personList?.length) {
      return;
    }

    this.auditlogTrail.forEach((audit: any) => {
      if (audit?.modifieddata?.length) {
        audit.modifieddata.forEach((item: any) => {
          if (item?.key?.toLowerCase() === 'personid') {
            item.new_value = item.new_value ? this.getPersonNameById(item.new_value) : item.new_value;
            item.old_value = item.old_value ? this.getPersonNameById(item.old_value) : item.old_value;
          }
        });
      }
    });
  }
}