import { Injectable } from '@angular/core';
import { IntakeStore } from '../../_utils/intake-utils.service';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable, of, switchMap, tap } from 'rxjs';
import { SessionStorageService, AuthService, DataStoreService, CommonHttpService } from '../../../@core/services';
import { NewUrlConfig } from '../newintake-url.config';

@Injectable()
export class MyNewintakeResolverService {
  intakeStore!: IntakeStore;
  intakeNumber!: string | null;
  iscaseexpunged: any;
  constructor(private _authService: AuthService, private _commonHttpService: CommonHttpService, private _dataStoreService: DataStoreService, private _sessionStorage: SessionStorageService) {

  }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> | undefined {
    this.intakeStore = this._dataStoreService.getObj('intake');
    if (!this.intakeStore) {
      this.intakeStore = new IntakeStore();
      this.intakeStore.number = route.paramMap.get('id');
      this.intakeStore.action = route.paramMap.get('mode');
      this._dataStoreService.setData('intake', this.intakeStore);
    }
    this.intakeNumber = this.intakeStore.number;
    this._sessionStorage.setTabKeyKey(this.intakeNumber);
    this.getcaseexpungedflag();
    this.checkAndLoadReadOnlyAccess();
    if (this.intakeStore.action === 'edit' || this.intakeStore.action === 'view' || this.intakeStore.action ==='add') {
      return this.getcaseexpungedflag().pipe(
        switchMap(() => this.populateIntake())
      );
    }

  }
  checkAndLoadReadOnlyAccess() {
    if(this._authService.hasModuleAccess('intake_full_access')) {
      this._authService.removeReadOnly();
      this._authService.addRemoveReadOnlyResources('INTAKE');
    }
  }

  private getcaseexpungedflag(): Observable<any> {
    const isExpungementSuperUser = this._authService.isExpungementSuperUser();
    if(isExpungementSuperUser == 1) {
        const reqData = {
        'objectid': this.intakeNumber,
        'objecttype': 'intake'
        };
       return this._commonHttpService
        .getSingle(
            {
            order: 'desc',
            where: reqData,
            method: 'get'
            },
            'Intakeservicerequests/getcaseexpungedflag?filter'
        ).pipe(
                tap(data => {
                    if (data && data.length) {
                        this._dataStoreService.setData('iscaseexpunged', data[0].iscaseexpunged);
                        this.iscaseexpunged = data[0].iscaseexpunged;
                    }
                })
            );
    } else {
        this._dataStoreService.setData('iscaseexpunged',0);
        this.iscaseexpunged = 0;
        return of(null);
    }
  }

  populateIntake() : Observable<any> {
    const isExpungementSuperUser = this._authService?.isExpungementSuperUser();
    return this._commonHttpService
      .create(
        {
          page: 1,
          limit: 10,
          where: {
            status: 'intake',
            intakenumber: this.intakeNumber, 
            isExpungementSuperUser: isExpungementSuperUser,
            'iscaseexpunged': this.iscaseexpunged
          }
        },
        NewUrlConfig.EndPoint.Intake.TemporarySavedIntakeUrl
      );
  }
}
