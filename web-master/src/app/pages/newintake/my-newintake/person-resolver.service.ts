import { Injectable } from '@angular/core';
import { AuthService, DataStoreService, SessionStorageService } from '../../../@core/services';
import { InvolvedPersonsService } from '../../shared-pages/involved-persons/involved-persons.service';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { AppConstants } from '../../../@core/common/constants';
import { IntakeStore } from '../../_utils/intake-utils.service';

@Injectable()
export class PersonResolverService {

  constructor(private _authService: AuthService, private _ips: InvolvedPersonsService,
    private _dataStoreService: DataStoreService,
    private _sessionStorage: SessionStorageService
  ) {

  }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): any {
    let intakeStore = this._dataStoreService.getObj('intake');
    if (!intakeStore) {
      intakeStore = new IntakeStore();
      intakeStore.number = route.paramMap.get('id');
      intakeStore.action = route.paramMap.get('mode');
      this._dataStoreService.setData('intake', intakeStore);
    }

    //@Simar: This resolver is to be used for Intake only, so setting the source module as INTAKE for InvolvedPersonsService
    this._dataStoreService.setData(AppConstants.GLOBAL_KEY.SOURCE_PAGE, AppConstants.MODULE_TYPE.INTAKE);
    if (intakeStore.action === 'edit' || intakeStore.action === 'view') {
      return this._ips.getInvolvedPerson(1, 10);
    }
  }

}
