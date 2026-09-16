
import {pluck, share, map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Accomplishment, Testing, Vocation } from '../../../@core/common/models/involvedperson.data.model';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { HttpService } from '../../../@core/services/http.service';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
import { PaginationRequest } from '../../../@core/entities/common.entities';

@Injectable()
export class PersonEducationDetailsService {

  schoolInfo$ = new Observable<any[]>();
  accomplishmentsInfo$ = new Observable<Accomplishment[]>();
  testingInfo$ = new Observable<Testing[]>();
  vocationInfo$ = new Observable<Vocation[]>();

  constructor(private _commonHttpService: CommonHttpService,
    private _httpService: HttpService) { }


  getSchools(searchKey: any) {
    return this._httpService.get(CommonUrlConfig.EndPoint.PERSON.EDUCATION.SCHOOL.GetSchoolUrl, {
      searchkey: searchKey
    });
  }

  addUpdateSchool(school: any) {
    return this._commonHttpService.create(school, CommonUrlConfig.EndPoint.PERSON.EDUCATION.SCHOOL.AddUpdateSchool);
  }

  getSchoolList(paginationRequest: PaginationRequest, pageinfosize: any) {
    const source = this._commonHttpService.getPagedArrayList(paginationRequest,
      CommonUrlConfig.EndPoint.PERSON.EDUCATION.SCHOOL.ListSchool + '?filter'
    ).pipe(map((result: any) => {
      return {
        data: result,
        count: result.length > 0 ? result[0].totalcount : 0,
        canDisplayPager: result.length > 0 ? result[0].totalcount > pageinfosize : false
      };
    }),share(),);
    this.schoolInfo$ = source.pipe(pluck('data'));
    return source;
  }

  deleteSchool(schoolid: any) {
    this._commonHttpService.endpointUrl = CommonUrlConfig.EndPoint.PERSON.EDUCATION.SCHOOL.DeleteSchool;
    return this._commonHttpService.remove(schoolid);
  }

  addAccomplishmentSchool(accomplishments: any) {
    return this._commonHttpService.create(accomplishments, CommonUrlConfig.EndPoint.PERSON.EDUCATION.ACCOMPLISHMENTS.AddUpdateaccomplishments);
  }

  getAccomplishmentList(paginationRequest: PaginationRequest, pageinfosize: any) {
    const source = this._commonHttpService.getPagedArrayList(paginationRequest,
      CommonUrlConfig.EndPoint.PERSON.EDUCATION.ACCOMPLISHMENTS.Listaccomplishments + '?filter'
    ).pipe(map((result1: any) => {
      return {
        data: result1,
        count: result1.length > 0 ? result1[0].totalcount : 0,
        canDisplayPager: result1.length > 0 ? result1[0].totalcount > pageinfosize : false
      };
    }),share(),);
    this.accomplishmentsInfo$ = source.pipe(pluck('data'));
    return source;
  }

  deleteAccomplishment(accomplishmentsid: any) {
    this._commonHttpService.endpointUrl = CommonUrlConfig.EndPoint.PERSON.EDUCATION.ACCOMPLISHMENTS.Deleteaccomplishments;
    return this._commonHttpService.remove(accomplishmentsid);
  }

  addTesting(testing: any) {
    return this._commonHttpService.create(testing, CommonUrlConfig.EndPoint.PERSON.EDUCATION.TESTING.AddUpdatetesting);
  }

  getTestingList(paginationRequest: PaginationRequest, pageinfosize: any) {
    const source = this._commonHttpService.getPagedArrayList(paginationRequest,
      CommonUrlConfig.EndPoint.PERSON.EDUCATION.TESTING.Listtesting + '?filter'
    ).pipe(map((result2: any) => {
      return {
        data: result2,
        count: result2.length > 0 ? result2[0].totalcount : 0,
        canDisplayPager: result2.length > 0 ? result2[0].totalcount > pageinfosize : false
      };
    }),share(),);
    this.testingInfo$ = source.pipe(pluck('data'));
    return source;
  }

  deleteTesting(testingid: any) {
    this._commonHttpService.endpointUrl = CommonUrlConfig.EndPoint.PERSON.EDUCATION.TESTING.Deletetesting;
    return this._commonHttpService.remove(testingid);
  }

  addVocation(vocation: any) {
    return this._commonHttpService.create(vocation, CommonUrlConfig.EndPoint.PERSON.EDUCATION.VOCATION.AddUpdateVocation);
  }

  getVocationList(paginationRequest: PaginationRequest, pageinfosize: any) {
    const source = this._commonHttpService.getPagedArrayList(paginationRequest,
      CommonUrlConfig.EndPoint.PERSON.EDUCATION.VOCATION.ListVocation + '?filter'
    ).pipe(map((result3: any) => {
      return {
        data: result3,
        count: result3.length > 0 ? result3[0].totalcount : 0,
        canDisplayPager: result3.length > 0 ? result3[0].totalcount > pageinfosize : false
      };
    }),share(),);
    this.vocationInfo$ = source.pipe(pluck('data'));
    return source;
  }

  deleteVocation(vocationid: any) {
    this._commonHttpService.endpointUrl = CommonUrlConfig.EndPoint.PERSON.EDUCATION.VOCATION.DeleteVocation;
    return this._commonHttpService.remove(vocationid);
  }

  set schoolInfo(schoolInfo: Observable<any[]>) {
    this.schoolInfo$ = schoolInfo;
  }

  get schoolInfo(): Observable<any[]> {
    return this.schoolInfo$;
  }

  set accomplishmentsInfo(accomplishmentsInfo: Observable<Accomplishment[]>) {
    this.accomplishmentsInfo$ = accomplishmentsInfo;
  }

  get accomplishmentsInfo(): Observable<Accomplishment[]> {
    return this.accomplishmentsInfo$;
  }

  set testingInfo(testingInfo: Observable<Testing[]>) {
    this.testingInfo$ = testingInfo;
  }

  get testingInfo(): Observable<Testing[]> {
    return this.testingInfo$;
  }

  set vocationInfo(vocationInfo: Observable<Vocation[]>) {
    this.vocationInfo$ = vocationInfo;
  }

  get vocationInfo(): Observable<Vocation[]> {
    return this.vocationInfo$;
  }

}
