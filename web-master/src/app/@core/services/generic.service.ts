
import {map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { EMPTY, Observable, BehaviorSubject } from 'rxjs';
import { ErrorInfo } from '../common/errorDisplay';
import { ListDataItem, PaginationRequest } from '../entities/common.entities';
import { HttpService } from './http.service';
@Injectable({ providedIn: 'root' })
export class GenericService<T> {
  error: ErrorInfo = new ErrorInfo();
  endpointUrl!: string;
  private getdsdsactionsummarydtls = new BehaviorSubject<null>(null);
  constructor(private http: HttpService) {
  }

  getAll(url?: string) {
    const request = this.http.get(this.getUrl(url));
    return request.pipe(map((result) => {
      let data : T[];
      const isBase64Valid = (typeof result === 'string') && (this.http.isBase64(result));
      if(isBase64Valid && result !== null && result.length !== 0){
        data = JSON.parse(decodeURIComponent(atob(result)));
    } else {
        data = result;
    }
        return data;

    }, (err: any) => {
      console.error(err);
      this.error.error(err);
    }));
  }

  getAllPaged(options: PaginationRequest, url?: string) {
    const request = this.http.get(`${this.getUrl(url)}/list?filter=` + JSON.stringify(options));
    return request.pipe(map((result) => {
      let data: ListDataItem<T>;
      const isBase64Valid = (typeof result === 'string') && (this.http.isBase64(result));
      if(isBase64Valid && result !== null && result.length !== 0){
        data = JSON.parse(decodeURIComponent(atob(result)));
      }else {
        data = result;
    }
        return data;

    }, (err: any) => {
      console.error(err);
      this.error.error(err);
    }));
  }
  getAllFilter(options: PaginationRequest, url?: string) {
    const request = this.http.post(`${this.getUrl(url)}`, JSON.stringify(options));
    return this.commonFilterFunc(request);
  }

  commonFilterFunc(request: any) {
    return request.pipe(map((result: any) => {
      let data: ListDataItem<T>;
      const isBase64Valid = (typeof result === 'string') && (this.http.isBase64(result));
      if(isBase64Valid && result !== null && result.length !== 0) {
        data = JSON.parse(decodeURIComponent(atob(result)));
      } else {
        data = result;
        return data;
      }
      return data;
    }, (err: any) => {
      console.error(err);
      this.error.error(err);
    }));
  }

  getById(id: number | string, url?: string) {
    const request = this.http.get(`${this.getUrl(url)}/${id}`);
    return this.commonFilterFunc(request);
  }

  create(item: T, url?: string) {
    const request = this.http.post(this.getUrl(url), JSON.stringify(item));
    return this.commonFilterFunc(request);
  }

  createArrayList(item: T[], url?: string) {
    const request = this.http.post(this.getUrl(url), JSON.stringify(item));
    return this.commonFilterFunc(request);
  }
  update(id: number | string, item: T, url?: string) {
    const request = this.http.put(`${this.getUrl(url)}/${id}`, JSON.stringify(item));
    return this.commonFilterFunc(request);
  }

  patch(id: number | string, item?: any, url?: string) {
    const request = this.http.patch(`${this.getUrl(url)}/${id}`, JSON.stringify(item));
    return this.commonFilterFunc(request);
  }

  patchWithoutid(item?: any, url?: string) {
    const request = this.http.patch(this.getUrl(url), JSON.stringify(item))
    return this.commonFilterFunc(request);
  }

  remove(id: number | string, item?: any, url?: string) {
    return this.http.delete(`${this.getUrl(url)}/${id}`, JSON.stringify(item)).pipe(map((response: T) => {
      return response;
    }, (err: any) => {
      this.error.error(err);
    }));
  }

  getUrl(url: string | undefined) {
    return url ? url : this.endpointUrl;
  }

  getSingle(options: PaginationRequest | any, url?: string) {
    let request: Observable<any> = EMPTY;
    if (!options.method) {
      request = this.http.get(`${this.getUrl(url)}`);
    } else if (options.method === 'get') {
      request = this.http.get(`${this.getUrl(url)}=` + JSON.stringify(options));
    } else if (options.method === 'post') {
      request = this.http.post(`${this.getUrl(url)}`, JSON.stringify(options));
    }
    return request.pipe(map((result) => {
      let resultdata: T;
      const isBase64Valid = (typeof result === 'string') && (this.http.isBase64(result));
      if(isBase64Valid && result !== null && result.length !== 0){
        resultdata = JSON.parse(decodeURIComponent(atob(result)));
        return resultdata;
      }else{
        resultdata = result;
        return resultdata;
      }
    }, (err: any) => {
      this.error.error(err);
    }));
  }

  getArrayList(options: PaginationRequest | any, url?: string) {
    let request: Observable<any> = EMPTY;
    if (!options.method) {
      request = this.http.get(`${this.getUrl(url)}`);
    } else if (options.method === 'get') {
      request = this.http.get(`${this.getUrl(url)}=` + JSON.stringify(options));
    } else if (options.method === 'post') {
      request = this.http.post(`${this.getUrl(url)}`, JSON.stringify(options));
    }
    return request.pipe(map((result) => {
      let resultdata: T[];
      const isBase64Valid = (typeof result === 'string') && (this.http.isBase64(result));
      if(isBase64Valid && result !== null && result.length !== 0){
        resultdata = JSON.parse(decodeURIComponent(atob(result)));
        return resultdata;
      }else{
        resultdata = result;
        return resultdata;
      }
    }, (err: any) => {
      this.error.error(err);
    }));
  }

  getPagedArrayList(options: PaginationRequest | any, url?: string) {
    let request: Observable<any> = EMPTY;
    if (!options.method) {
      request = this.http.get(`${this.getUrl(url)}`);
    } else if (options.method === 'get') {
      request = this.http.get(`${this.getUrl(url)}=` + JSON.stringify(options));
    } else if (options.method === 'post') {
      request = this.http.post(`${this.getUrl(url)}`, JSON.stringify(options));
    }
    return request.pipe(map((result) => {
      let resultdata: ListDataItem<T>;
      const isBase64Valid = (typeof result === 'string') && (this.http.isBase64(result));
      if(isBase64Valid && result !== null && result.length !== 0){
        resultdata = JSON.parse(decodeURIComponent(atob(result)));
        return resultdata;
      }else{
        resultdata = result;
        return resultdata;
      }
    }, (err: any) => {
      console.error(err);
      this.error.error(err);
    }));
  }

  upload(fileItem: File, url: string, extraData?: object) {
    return this.http.upload(fileItem, this.getUrl(url), extraData).pipe(map((response: T) => {
      return response;
    }, (err: any) => {
      this.error.error(err);
    }));
  }

  getdsdsactionsummary() {
    this.getdsdsactionsummarydtls.next(null);
  }

}
