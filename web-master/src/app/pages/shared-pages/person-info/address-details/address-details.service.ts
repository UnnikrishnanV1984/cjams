
import {pluck, share, map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Subject ,  Observable } from 'rxjs';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { PersonInfoService } from '../person-info.service';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { AddressType,EmailType, PhoneType } from '../../../admin/general/_entities/general.data.models';

@Injectable()
export class AddressDetailsService {
  public isShowAddAddress$ = new Subject<any>();
  public selectedAddress$ = new Subject<any>();
  public addressPersonType$ = new Observable<AddressType[]>();
  public emailPersonType$= new Observable<EmailType[]>();
  public phonePersonType$= new Observable<PhoneType[]>();
  personId: any;
  constructor(
    private _commonHttpService: CommonHttpService,
    private _personService: PersonInfoService,
  ) {
    this.personId = (this._personService.getPersonId()) ? this._personService.getPersonId() : '';
  }

  isShowAddAddressEnabled(value: any) {
    this.isShowAddAddress$.next(value);
  }

  getAddress(model: any) {
    this.selectedAddress$.next(model);
  }

  getAddressListPage(page: number) {
    const source = this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest(
          {
            method: 'get',
            where: { personid: this._personService.getPersonId()},
            page: 1, // this.paginationInfo.pageNumber,
            limit: 10// this.paginationInfo.pageSize,
          }),
        CommonUrlConfig.EndPoint.PERSON.ADDRESS.ListAddressUrl + '?filter'
      ).pipe(map((result: any) => {
        return {
          data: result,
          count: result.length > 0 ? result[0].totalcount : 0
        };
      }))

    this.addressPersonType$ = source.pipe(pluck('data'));
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
      ).pipe(map((result: any) => {   // NOSONAR // This function has less than 3 lines of identical code. Hence marking it as no sonar
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
      ).pipe(map((result: any) => {   // NOSONAR // This function has less than 3 lines of identical code. Hence marking it as no sonar
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
