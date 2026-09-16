
import {map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Observable ,  BehaviorSubject, Subject, EMPTY } from 'rxjs';
import { ErrorInfo } from '../common/errorDisplay';
import { ListDataItem, PaginationRequest } from '../entities/common.entities';
import { HttpService } from './http.service';
import { SessionStorageService } from './storage.service';
import moment from 'moment';



@Injectable({ providedIn: 'root' })
export class CommonHttpService {
  error: ErrorInfo = new ErrorInfo();
  endpointUrl!: string;
  citizenData: any;
  SectionAData: any;
  SectionBData: any;
  SectionCData: any;
  public signatureSource: BehaviorSubject<string> = new BehaviorSubject('');
  candidacyDropDownChange : Subject<any> = new Subject();
  signature = this.signatureSource.asObservable();
  token: any;

  constructor(public http: HttpService,
    private _session: SessionStorageService
    ) {
  }

  updateSignature(data?: any) {
    this.signatureSource.next(data);
  }

  getAll(url?: string) {
    const request = this.http.get(this.getUrl(url));
    return request.pipe(map((result1) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      let resultdata: any[];
      const isBase64Valid = (typeof result1 === 'string') && (this.http.isBase64(result1));
      if(isBase64Valid && result1 !== null && result1.length !== 0){
        resultdata = JSON.parse(decodeURIComponent(atob(result1)));
        return resultdata;
      }else{
        resultdata = result1;
        return resultdata;
      }
    }, (err: any) => {

      this.error.error(err);
    }));
  }

  getAllPaged(options: PaginationRequest, url?: string) {
    this.token = this.returnTokenfn();
    options.securityuserid =  (this.token && this.token.user) ? this.token.user.userprofile.securityusersid : undefined;
    const request = this.http.get(`${this.getUrl(url)}/list?filter=` + JSON.stringify(options));
    return request.pipe(map((result2) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      let resultdata: ListDataItem<any>;
      const isBase64Valid = (typeof result2 === 'string') && (this.http.isBase64(result2));
      if(isBase64Valid && result2 !== null && result2.length !== 0){
        resultdata = JSON.parse(decodeURIComponent(atob(result2)));
        return resultdata;
      }else{
        resultdata = result2;
        return resultdata;
      }
    }, (err: any) => {

      this.error.error(err);
    }));
  }

    private returnTokenfn() {
        const storedToken = window.sessionStorage.getItem('token');
        return storedToken ? JSON.parse(storedToken) : '';
    }

  getAllFilter(options: PaginationRequest, url?: string) {
    this.token = this.returnTokenfn();
    options.securityuserid =  (this.token && this.token.user) ? this.token.user.userprofile.securityusersid : undefined;
    const request = this.http.post(`${this.getUrl(url)}`, JSON.stringify(options));
    return request.pipe(map(result3 => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      const isBase64Valid = (typeof result3 === 'string') && (this.http.isBase64(result3));
      if(isBase64Valid && result3 !== null && result3.length !== 0){
        result3 = JSON.parse(decodeURIComponent(atob(result3)));
        return result3;
      }else{
        return result3;
      }
    }, (err: any) => {

      this.error.error(err);
    }));
  }

  post(reqBody: any, url: string) {
    this.token = this.returnTokenfn();
    reqBody.securityuserid =  (this.token && this.token.user) ? this.token.user.userprofile.securityusersid : undefined;
    return this.http.post(url, JSON.stringify(reqBody)).pipe(map((data1: any) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      const isBase64Valid = (typeof data1 === 'string') && (this.http.isBase64(data1));
      if(isBase64Valid && data1 !== null && data1.length !== 0){
        data1 = JSON.parse(decodeURIComponent(atob(data1)));
        return data1;
      }else{
        return data1;
      }
    }, (err: any) => {
      this.error.error(err);
    }));
  }

  getById(id: number | string, url?: string) {
    return this.http.get(`${this.getUrl(url)}/${id}`).pipe(map((data2: any) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      const isBase64Valid = (typeof data2 === 'string') && (this.http.isBase64(data2));
      if(isBase64Valid && data2 !== null && data2.length !== 0){
        data2 = JSON.parse(decodeURIComponent(atob(data2)));
        return data2;
      }else{
        return data2;
      }
    }, (err: any) => {
      this.error.error(err);
    }));
  }

  getSettings(settingnames: string[]) {
    const settingnameString = settingnames.join(',');

    return this.http.get(`${this.getUrl('settings/getvalue')}?settingname=${settingnameString}`).pipe(
      map((data: any) => {
        return data;
      })
    );
  }

  private isBase64(str: string): boolean {
    // Basic check: valid base64 charset + padding rules
    return /^[A-Za-z0-9+/=]+$/.test(str);
  }


  create(item: any, url?: string) {
    this.token = this.returnTokenfn();
    if (this.isBase64(this.token)) {
      this.token = JSON.parse(decodeURIComponent(atob(this.token)));
    }
    item.securityuserid =  (this.token && this.token.user) ? this.token.user.userprofile.securityusersid : undefined;
    return this.http.post(this.getUrl(url), JSON.stringify(item)).pipe(map((data3: any) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      const isBase64Valid = (typeof data3 === 'string') && (this.http.isBase64(data3));
      if(isBase64Valid && data3 !== null && data3.length !== 0){
        data3 = JSON.parse(decodeURIComponent(atob(data3)));
        return data3;
      }else{
        return data3;
      }
    }, (err: any) => {
      this.error.error(err);
    }));
  }

  update(id: string, item: any, url?: string) {
    this.token = this.returnTokenfn();
    if (this.isBase64(this.token)) {
      this.token = JSON.parse(decodeURIComponent(atob(this.token)));
    }
    item.securityuserid =  (this.token && this.token.user) ? this.token.user.userprofile.securityusersid : undefined;
    return this.http.put(`${this.getUrl(url)}/${id}`, JSON.stringify(item)).pipe(map((data4: any) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      const isBase64Valid = (typeof data4 === 'string') && (this.http.isBase64(data4));
      if(isBase64Valid && data4 !== null && data4.length !== 0){
        data4 = JSON.parse(decodeURIComponent(atob(data4)));
        return data4;
      }else{
        return data4;
      }
    }, (err: any) => {
      this.error.error(err);
    }));
  }
  updateWithoutid(item: any, url?: string) {
    this.token = this.returnTokenfn();
    if (this.isBase64(this.token)) {
      this.token = JSON.parse(decodeURIComponent(atob(this.token)));
    }
    if(item){
    item.securityuserid =  (this.token && this.token.user) ? this.token.user.userprofile.securityusersid : undefined;
    }
  return this.http.put(this.getUrl(url), JSON.stringify(item)).pipe(map((data5: any) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      const isBase64Valid = (typeof data5 === 'string') && (this.http.isBase64(data5));
      if(isBase64Valid && data5 !== null && data5.length !== 0){
        data5 = JSON.parse(decodeURIComponent(atob(data5)));
        return data5;
      }else{
        return data5;
      }
    }, (err: any) => {
      this.error.error(err);
    }));
  }

  patch(id: string, item: any, url?: string) {
    this.token = this.returnTokenfn();
    item.securityuserid =  (this.token && this.token.user) ? this.token.user.userprofile.securityusersid : undefined;
    return this.http.patch(`${this.getUrl(url)}/${id}`, JSON.stringify(item)).pipe(map((data6: any) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      const isBase64Valid = (typeof data6 === 'string') && (this.http.isBase64(data6));
      if(isBase64Valid && data6 !== null && data6.length !== 0){
        data6 = JSON.parse(decodeURIComponent(atob(data6)));
        return data6;
      }else{
        return data6;
      }
    }, (err: any) => {
      this.error.error(err);
    }));
  }

  remove(id: any, item?: any, url?: string) {
    return this.http.delete(`${this.getUrl(url)}/${id}`, JSON.stringify(item)).pipe(map((response: any) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      return response;
    }, (err: any) => {
      this.error.error(err);
    }));
  }

  deleteByPost(id: number | string, item?: any, url?: string) {
    return this.http.post(`${this.getUrl(url)}`, JSON.stringify(item)).pipe(map((response: any) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      return response;
    }, (err: any) => {
      this.error.error(err);
    }));
  }

  getUrl(url: string | undefined) {
    return url ? url : this.endpointUrl;
  }

  getSingle(options: PaginationRequest | any, url?: string) {
    this.token = this.returnTokenfn();
    options.securityuserid =  (this.token && this.token.user) ? this.token.user.userprofile.securityusersid : undefined;
    let request: Observable<any> = EMPTY;
    if (!options.method) {
      request = this.http.get(`${this.getUrl(url)}`);
    } else if (options.method === 'get') {
      request = this.http.get(`${this.getUrl(url)}=` + JSON.stringify(options));
    } else if (options.method === 'post') {
      request = this.http.post(`${this.getUrl(url)}`, JSON.stringify(options));
    }
    return request.pipe(map((result4: any) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      const isBase64Valid = (typeof result4 === 'string') && (this.http.isBase64(result4));
      if(isBase64Valid && result4 !== null && result4.length !== 0){
        result4 = JSON.parse(decodeURIComponent(atob(result4)));
        return result4;
      }else{
        return result4;
      }
    }, (err: any) => {

      this.error.error(err);
    }));
  }

  getArrayList(options: PaginationRequest | any, url?: string) {
    this.token = this.returnTokenfn();
    if(!options.securityuserid) {
    options.securityuserid =  (this.token && this.token.user) ? this.token.user.userprofile.securityusersid : undefined;
    }
    let request: Observable<any> = EMPTY;
    if (!options.method) {
      request = this.http.get(`${this.getUrl(url)}`);
    } else if (options.method === 'get') {
      request = this.http.get(`${this.getUrl(url)}=` + JSON.stringify(options));
    } else if (options.method === 'post') {
      request = this.http.post(`${this.getUrl(url)}`, JSON.stringify(options));
    }
    return request.pipe(map((result5) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      let resultdata: any[];
      const isBase64Valid = (typeof result5 === 'string') && (this.http.isBase64(result5));
      if(isBase64Valid && result5 !== null && result5.length !== 0){
        resultdata = JSON.parse(decodeURIComponent(atob(result5)));
        return resultdata;
      }else{
        resultdata = result5;
        return resultdata;
      }
    }, (err: any) => {

      this.error.error(err);
    }));
  }

  getArrayListWithNullCheck(options: PaginationRequest | any, url?: string) {
    this.token = this.returnTokenfn();
    options.securityuserid =  (this.token && this.token.user) ? this.token.user.userprofile.securityusersid : undefined;
    const request: Observable<any> = this.returnRequestDataFn(options, url);
    return request.pipe(map((result6) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      let resultdata: any[];
      const isBase64Valid = (typeof result6 === 'string') && (this.http.isBase64(result6));
      if(isBase64Valid && result6 !== null && result6.length !== 0){
        resultdata = JSON.parse(decodeURIComponent(atob(result6)));
        return resultdata ? resultdata : [];
      }else{
        resultdata = result6;
        return resultdata ? resultdata : [];
      }
    }, (err: any) => {

      this.error.error(err);
    }));
  }
  // Assosiated to getArrayListWithNullCheck method
  private returnRequestDataFn(options: any, url: any) {
    let request: Observable<any> = EMPTY;
    if (!options.method) {
      request = this.http.get(`${this.getUrl(url)}`);
    } else if (options.method === 'get') {
      request = this.http.get(`${this.getUrl(url)}=` + JSON.stringify(options));
    } else if (options.method === 'post') {
      request = this.http.post(`${this.getUrl(url)}`, JSON.stringify(options));
    }
    return request;
  }

  getPagedArrayList(options: PaginationRequest | any, url?: string) {
    this.token = this.returnTokenfn();
    options.securityuserid =  (this.token && this.token.user) ? this.token.user.userprofile.securityusersid : undefined;
    let request: Observable<any> = EMPTY;
    if (!options.method) {
      request = this.http.get(`${this.getUrl(url)}`);
    } else if (options.method === 'get') {
      request = this.http.get(`${this.getUrl(url)}=` + JSON.stringify(options));
    } else if (options.method === 'post') {
      request = this.http.post(`${this.getUrl(url)}`, JSON.stringify(options));
    }
    return request.pipe(map((result7) => {
      let resultdata: ListDataItem<any>;
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      const isBase64Valid = (typeof result7 === 'string') && (this.http.isBase64(result7));
      if(isBase64Valid && result7 !== null && result7.length !== 0){
        resultdata = JSON.parse(decodeURIComponent(atob(result7)));
        return resultdata;
      }else{
        resultdata = result7;
        return resultdata;
      }
    }, (err: any) => {

      this.error.error(err);
    }));
  }




  upload(fileItem: File, url: string, extraData?: object) {
    return this.http.upload(fileItem, this.getUrl(url), extraData).pipe(map((response: any) => {
      this._session.setItem('apiDate', moment(new Date()).add(15, 'm').toDate());
      return response;
    }, (err: any) => {
      this.error.error(err);
    }));
  }

  download(url: string, condition: any) {
    return this.http.download(url, condition, {}, 'arraybuffer');
  }

  downloadXml(url: string) {
    return this.http.downloadXml(url);
  }

  gapCitizenData(data: any) {
    this.citizenData = data;
  }
  gepSectionA(data: any) {
    this.SectionAData = data;
  }
  gepSectionB(data: any) {
    this.SectionBData = data;
  }

  gepSectionC(data: any) {
    this.SectionCData = data;
  }

}
