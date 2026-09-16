import { Injectable } from '@angular/core';
import { CommonHttpService, DataStoreService } from '../../../../@core/services';
import { AppConstants } from '../../../../@core/common/constants';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { PersonInfoService } from '../person-info.service';
import { Subject } from 'rxjs';

@Injectable({providedIn: 'root'})
export class PersonHealthService {
  renewalflag!:boolean;
  public healthDataListener$ = new Subject<any>();
  private activeSectionSubject = new Subject<string>();

  constructor(private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _personInfoService: PersonInfoService) {
  }

  updateHealth(data:any, isNew = 1) {
    return this._commonHttpService
      .create(data, 'personimmunizationconfig/immunizationupdate');
  }

  saveHealth(data:any, isNew = 1) {
    const personId = this._personInfoService.getPersonId();
    const saveObject = { 'health': data, 'pid': personId, 'isnew': isNew};
    return this._commonHttpService
      .create(saveObject, 'People/personhealthaddupdate');
  }

  getPersonHealthInfo() {
    const personId = this._personInfoService.getPersonId();
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: personId }
        }),
        'People/listpersonhealth?filter'
      );
  }

  setPersonHealthInfo() {
    this.getPersonHealthInfo().subscribe(healthInfo => {
      if (healthInfo && Array.isArray(healthInfo) && healthInfo.length) {
        this._dataStoreService.setData(AppConstants.GLOBAL_KEY.PERSON_HEALTH_INFO, healthInfo[0]);
        this.healthDataListener$.next(healthInfo);
      }
    });
  }

  getHealthInfoWithKey(keyName: string) {
    const healthInfo = this._dataStoreService.getData(AppConstants.GLOBAL_KEY.PERSON_HEALTH_INFO);
    if (healthInfo && healthInfo.hasOwnProperty(keyName)) {
      return healthInfo[keyName];
    } else {
      return null;
    }
  }

  getExaminationList(param?: any) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: this._personInfoService.getPersonId(), startDate: param?.startDate, endDate: param?.endDate }
        }),
        'personexamination/list?filter'
      );
  }

  getBirthInfo(param?: any) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: this._personInfoService.getPersonId(), startDate: param?.startDate, endDate: param?.endDate  }
        }),
        'clientunder5yearsinfo/list?filter'
      );
  }

  getSexualInfo(param?: any) {
    return this._commonHttpService
      .getSingle(
        new PaginationRequest({
          method: 'get',
          where: { personid: this._personInfoService.getPersonId(), startDate: param?.startDate, endDate: param?.endDate }
        }),
        'personsexualinfo/list?filter'
      );
  }

  getHospitalizationInfo(param?: any) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: this._personInfoService.getPersonId(), startDate: param?.startDate, endDate: param?.endDate  }
        }),
        'personhospitalization/list?filter'
      );
  }

  getFeedingInfo() {
    return this._commonHttpService
    .getSingle(
      new PaginationRequest({
        method: 'get',
        where: { personid: this._personInfoService.getPersonId() }
      }),
      'personfamilyinfo/getpersonfeeding?filter'
    );
  }

  setActiveSection(section: string) {
    this.activeSectionSubject.next(section);
  }

  getActiveSection() {
    return this.activeSectionSubject.asObservable();
  }

}