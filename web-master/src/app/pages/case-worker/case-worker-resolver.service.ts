import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { from, Observable, of, switchMap, tap } from 'rxjs';
import { AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../@core/services';
import { CaseWorkerUrlConfig } from './case-worker-url.config';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from './_entities/caseworker.data.constants';

@Injectable()
export class CaseWorkerResolverService {
  daNumber!: string | null;
  caseuid!: string | null;
  isServiceCase: any;
  isAdoptionCase: any;
  constructor(private _authService: AuthService,
     private _commonHttpService: CommonHttpService,
     private _dataStoreService: DataStoreService, 
     private _session: SessionStorageService) { 
  }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    this.daNumber = route.paramMap.get('daNumber');
    this.caseuid = route.paramMap.get('id');
    this._session.setTabKeyKey(this.daNumber);
    this.isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    this._dataStoreService.setData(CASE_STORE_CONSTANTS.DA_NUMBER, this.daNumber);
    this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_UID, this.caseuid);
    this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, this.isServiceCase);
    if (this.isServiceCase === 'true') {
      this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.SERVICE_CASE);
    }
    const caseType =  this._session.getItem(CASE_STORE_CONSTANTS.CASE_TYPE) ;
    if (caseType === CASE_TYPE_CONSTANTS.ADOPTION || this._session.getItem('ISADOPTION')) {
        this.isAdoptionCase = true;
    }
   
    return this.getcaseexpungedflag().pipe(
        switchMap(() => this.getActionSummary())
    );
  }

  private getActionSummary(): Observable<any> {
    const isExpungementSuperUser = this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    let url = '';
    if (this.isServiceCase || this.isAdoptionCase) {
      url = `${CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl}/${this.caseuid}/casetype`;
    } else {
      url = `${CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl}/${this.daNumber}?isExpungementSuperUser=${isExpungementSuperUser}&iscaseexpunged=${iscaseexpunged}`;
    }
    return this._commonHttpService.getAll(url);
  }

   private getcaseexpungedflag(): Observable<any> {
    const isExpungementSuperUser = this._authService.isExpungementSuperUser();
    const id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    if (isExpungementSuperUser == 1) {
      return this._commonHttpService.getSingle(
          { order: 'desc', where: { 'objectid': id, 'objecttype': 'Case' }, method: 'get' },
          'Intakeservicerequests/getcaseexpungedflag?filter'
      ).pipe(
          tap(data => {
              if (data && data.length) {
                  this._dataStoreService.setData('iscaseexpunged', data[0].iscaseexpunged);
              }
          })
      );
    } else {
      this._dataStoreService.setData('iscaseexpunged', 0);
      return of(null);
    }
  }

}
