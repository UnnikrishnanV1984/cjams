
import {map} from 'rxjs/operators';
import { Component, Injector,OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';

import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService, AuthService,CommonHttpService, DataStoreService } from '../../../../@core/services';
import { CaseWorkerHistory, DSDSActionSummary, HistoryPSScore, HistroyDAgroup } from '../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { FormGroup, FormBuilder } from '@angular/forms';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

@Component({
  // tslint:disable-next-line:component-selector
  selector: 'history',
  templateUrl: './history.component.html',
  styleUrls: ['./history.component.scss']
})
export class HistoryComponent implements OnInit {
  id: string;
  daNumber: string;
  daStatus = false;
  psScore = false;
  daGrouping = false;
  historyForm: FormGroup;
  getHistory$: Observable<CaseWorkerHistory[]>;
  getPSScoreHistory$: Observable<HistoryPSScore[]>;
  getDAGroup$: Observable<HistroyDAgroup[]>;
  dsdsActionsSummary = new DSDSActionSummary();
  paginationInfo: PaginationInfo = new PaginationInfo();
  private typeHistory: string;
  public _authService: AuthService;
  constructor(
    private route: ActivatedRoute,
    private _alertService: AlertService,
    private formBuilder: FormBuilder,
    private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private injector : Injector
  ) {
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this._authService = this.injector.get<AuthService>(AuthService);
  }
  historyType = [
    { value: 'DAStatus', text: 'DA Status/Disposition Audit Trail' },
    { value: 'PSScore', text: 'PS Score' },
    { value: 'DAGrouping', text: 'DA Grouping' }
  ];
  iscaseexpunged: any = 0;

  ngOnInit() {
    this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    this.historyForm = this.formBuilder.group({
      history: ['DAStatus']
    });
    this.getActionSummary();
    this.changeHistory('DAStatus');
  }
  private getActionSummary() {
    const isExpungementSuperUser = this._authService.isExpungementSuperUser();
    this._commonHttpService
      .getById(this.daNumber + `?isExpungementSuperUser=${isExpungementSuperUser}&iscaseexpunged=${this.iscaseexpunged}`, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl)
      .subscribe(response => {
        this.dsdsActionsSummary = response[0];
      }, error => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      });
  }
  changeHistory(history: string) {
    this.typeHistory = history;
    if (history === 'DAStatus') {
      this.daStatus = true;
      this.psScore = false;
      this.daGrouping = false;
      this.getHistory$ = this._commonHttpService.getPagedArrayList(
        new PaginationRequest({
          page: this.paginationInfo.pageNumber,
          limit: this.paginationInfo.pageSize,
          where: {
            servicerequestid: this.id
          },
          method: 'get'
        }), 'Intakeservicerequestdispositioncodes/GetHistory?filter'
      ).pipe(map(result => {
        return result.data;
      }, error => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }));
    } else if (history === 'PSScore') {
      this.daStatus = false;
      this.psScore = true;
      this.daGrouping = false;
      this.getPSScoreHistory$ = this._commonHttpService.getArrayList(
        new PaginationRequest({
          where: {
            intakeservreqtypekey: this.dsdsActionsSummary.da_type,
          },
          method: 'get'
        }), 'Intakeservicerequests/getpsscoreanddateseen/' + this.id + '?data'
      ).pipe(map(result => {
        return result;
      }, error => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }));

    } else if (history === 'DAGrouping') {
      this.daStatus = false;
      this.psScore = false;
      this.daGrouping = true;
      this.getDAGroup$ = this._commonHttpService.getPagedArrayList(
        new PaginationRequest({
          page: this.paginationInfo.pageNumber,
          limit: this.paginationInfo.pageSize,
          where: {
            intakeserviceid: this.id
          },
          method: 'get'
        }), 'Intakeservicerequestgroupdetails/getgrouphistory' + '?data'
      ).pipe(map(result => {
        return result.data;
      }, error => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }));
    }
  }

}
