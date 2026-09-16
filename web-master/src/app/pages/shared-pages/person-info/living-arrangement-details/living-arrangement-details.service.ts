
import {map, share, pluck} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Subject ,  Observable } from 'rxjs';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { PersonInfoService } from '../person-info.service';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { AddressType,EmailType, PhoneType } from '../../../admin/general/_entities/general.data.models';
import { DataStoreService } from '../../../../@core/services';

@Injectable()
export class LivingArrangementDetailsService {
  public isShowAddLivingArrangement$ = new Subject<any>();
  public isShowLivingArrangement$ = new Subject<any>();
  public selectedLivingArrangement$ = new Subject<any>();
  public addressPersonType$ = new Observable<AddressType[]>();
  public emailPersonType$= new Observable<EmailType[]>();
  public phonePersonType$= new Observable<PhoneType[]>();
  personId: any;
  public caregiversList$ = new Subject<any>();
  caregiversList: any[]=[];
  constructor(
    private _commonHttpService: CommonHttpService,
    private _personService: PersonInfoService,
    private _dataStoreService: DataStoreService,
  ) {
    this.personId = (this._personService.getPersonId()) ? this._personService.getPersonId() : '';
  }

  isShowAddLivingArrangementEnabled(value:any) {
    this.isShowAddLivingArrangement$.next(value);
  }

  isShowLivingArrangementEnabled(value:any) {
    this.isShowLivingArrangement$.next(value);
  }

  getLivingArrangement(model:any) {
    this.selectedLivingArrangement$.next(model);
  }

  getEmailList(personId: any) {
    const source = this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest(
          {
            method: 'get',
            where: { personid: personId },
            page: 1, // this.paginationInfo.pageNumber,
            limit: 10// this.paginationInfo.pageSize,
          }),
        CommonUrlConfig.EndPoint.PERSON.EMAIL.ListEmail + '?filter'
      ).pipe(map((result: any) => {
        return {
          data: result,
          count: result.length > 0 ? result[0].totalcount : 0
        };
      }),share(),);

    this.emailPersonType$ = source.pipe(pluck('data'));
  }


  getPhoneList(personId: any) {
    const source = this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest(
          {
            method: 'get',
            where: { personid: personId },
            page: 1, // this.paginationInfo.pageNumber,
            limit: 10// this.paginationInfo.pageSize,
          }),
        CommonUrlConfig.EndPoint.PERSON.PHONE.ListPhoneUrl + '?filter'
      ).pipe(map((result: any) => {   // NOSONAR    // This function has less than 3 lines of identical code. Hence marking it as no sonar
        return {
          data: result,
          count: result.length > 0 ? result[0].totalcount : 0
        };
      }),share(),);

    this.phonePersonType$ = source.pipe(pluck('data'));
  }

  set addressPersonType(addressPersonType: Observable<AddressType[]>) {
    this.addressPersonType$ = addressPersonType;
  }

  get addressPersonType(): Observable<AddressType[]> {
    return this.addressPersonType$;
  }
}
