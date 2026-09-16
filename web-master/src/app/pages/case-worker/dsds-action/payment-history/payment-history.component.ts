
import {map} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';

import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService, CommonHttpService, SessionStorageService, DataStoreService, AuthService } from '../../../../@core/services';
import { CaseWorkerHistory, DSDSActionSummary, HistoryPSScore, HistroyDAgroup } from '../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { FormGroup, FormBuilder } from '@angular/forms';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'payment-history',
    templateUrl: './payment-history.component.html',
    styleUrls: ['./payment-history.component.scss'],
    standalone: false
})
export class PaymentHistoryComponent implements OnInit {
  id: string;
  daNumber: string;
  daStatus = false;
  psScore = false;
  daGrouping = false;
  historyForm!: FormGroup;
  placementHistory: any[] = [];
  getHistory$!: Observable<CaseWorkerHistory[]>;
  getPSScoreHistory$!: Observable<HistoryPSScore[]>;
  getDAGroup$!: Observable<HistroyDAgroup[]>;
  dsdsActionsSummary = new DSDSActionSummary();
  involvedPersons: any;
  accountpayableList: any;
  selectedChild: any;
  provider1PaymentHistory: any;
  provider2PaymentHistory: any;
  provider1PaymentCount: any;
  provider2PaymentCount: any;
  provider1id: any;
  provider1name: any;
  provider2id: any;
  provider2name: any;
  provider1paginationInfo: PaginationInfo = new PaginationInfo();
  provider2paginationInfo: PaginationInfo = new PaginationInfo();
  paginationInfo: PaginationInfo = new PaginationInfo();
  private typeHistory!: string;
  childID: any;
  public _authService: AuthService;
  constructor(
    private route: ActivatedRoute,
    private _alertService: AlertService,
    private formBuilder: FormBuilder,
    private _commonHttpService: CommonHttpService,
    private _sessionStorage: SessionStorageService,
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
  ngOnInit() {
    this.getInvolvedPerson();
    this.historyForm = this.formBuilder.group({
      history: ['DAStatus']
    });
    this.getActionSummary();    
    this.changeHistory('DAStatus');
    const caseData = this._sessionStorage.getObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD);
    if(caseData && caseData.providerdetails && caseData.providerdetails.length ) {
        const providerInfo = caseData.providerdetails[0];
        if(providerInfo.parent1providerid) {
            this.provider1id = providerInfo.parent1providerid;
            this.provider1name = providerInfo.parent1providername;
            this.getPaymentHistory(providerInfo.parent1providerid, 'provider1');
        }
    }

  }

  pageChanged(pageEvent: { page: number; }, providerid: any, provider: any) {
    this.paginationInfo.pageNumber = pageEvent.page;
    this.getPaymentHistory(providerid, provider);
  }

  private getInvolvedPerson() {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    let url = '';

    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    this._commonHttpService
        .getArrayList(
            {
                page: 1,
                method: 'get',
                where: {intakeserviceid : this.id,isExpungementSuperUser:isExpungementSuperUser,'iscaseexpunged': iscaseexpunged}
            },
            url + '?filter'
        )
        .subscribe((res: any) => {
            if (res['data'] && res['data'].length) {
                this.involvedPersons = [];
                res['data'].map((item: any) => {
                  const rolename = item.rolename ? item.rolename : '';
                  const child = ['CHILD', 'AV', 'OTHERCHILD', 'RC'].includes(rolename);
                  if(child) {
                      this.involvedPersons.push(item);
                  }
                });
            }
            if(this.involvedPersons && this.involvedPersons.length) {
              this.showChildHistory(this.involvedPersons[0]);
              this.getPaymentHistory(this.provider1id, 'provider1');
              this.selectedChild = this.involvedPersons[0];
            }
            });


  }

  getPaymentHistory(providerid: any, provider: string) {
    if (this.involvedPersons && this.involvedPersons.length ) {
      this.childID = this.involvedPersons[0].cjamspid;
    }
    this._commonHttpService
    .getArrayList(
        {
          page: this.paginationInfo.pageNumber,
          limit: this.paginationInfo.pageSize,
            method: 'get',
            where: {
              providerid : providerid,
              clientid: this.childID ? this.childID : null,
              caseid: this.daNumber ? this.daNumber : null
             }
        },
        'adoptioncase/adoptionpaymenthistory?filter'
    )
    .subscribe((res: any) => {
       this.provider1PaymentHistory = res['data'];
       if (this.paginationInfo.pageNumber === 1) {
        this.provider1PaymentCount = res['count'];
      }

    });
  }

  showChildHistory(child: any) {
    this.accountpayableList = [];
    this.paginationInfo.pageNumber = 1;
    this.paginationInfo.pageSize = 10;

    this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        method: 'post',
        where: {
          clientid: child.cjamspid
        }
      }), 'tb_payment_header/getAccountsPayableHeader'
    ).subscribe((result: any) => {
      if (result) {
        this.accountpayableList = result.data;
      }
    });
  }

  private getActionSummary() {
    const isExpungementSuperUser = this._authService.isExpungementSuperUser();
     const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    this._commonHttpService
      .getById(this.daNumber + `?isExpungementSuperUser=${isExpungementSuperUser}&iscaseexpunged=${iscaseexpunged}`, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl)
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
      }, (_error: any) => {
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
      }, (_error: any) => {
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
      }, (_error: any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }));
    }
  }

}
