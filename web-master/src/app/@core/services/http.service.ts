
import {EMPTY,  Observable } from 'rxjs';

import {catchError} from 'rxjs/operators';


import { HttpClient, HttpHeaders, HttpParams, HttpRequest, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';

import { AppConfig } from '../../app.config';
import { AlertService } from './alert.service';
import { IdleTimeoutService } from './idle.timeout.service';

@Injectable({ providedIn: 'root' })
export class HttpService {
    baseUrl = '';
    overrideUrl = false;

    errorData!: HttpErrorResponse | null;

    public headers = new HttpHeaders().set('Accept', AppConfig.content_type).set(AppConfig.content_typestr, AppConfig.content_type);

    constructor(private http: HttpClient,
        private _alertService: AlertService,
        private idleTimeoutService: IdleTimeoutService) {
        this.baseUrl = AppConfig.baseUrl;
    }

    public isBase64(str: string): boolean {
        if (str === '' || str.trim() === '') {return false;}
        try {
          return btoa(atob(str)) == str;
        } catch(err){
          return false;
        }
      }


    private get_formatted_url(url: string): string {

        this.idleTimeoutService.resetTimer();

        let ulen = url.length ;
        if (url.lastIndexOf('?') > 0 ) { ulen = url.lastIndexOf('?'); }

        const modname = url.substring(0, ulen);

        return AppConfig.getModuleMapName(modname) + url;
    }

    public get(url: string, params = {}): Observable<any> {

        const res = this.request('GET', this.get_formatted_url(url), {}, params);
        return res.pipe(catchError(
            (err: HttpErrorResponse) => {
                // this._alertService.error('A server error has occurred. Please try again or contact support.');
                // @Simar - On request, hiding the error pop-up, but logging on the console for dev debugging

                this.errorData = err;
                if (err && err.error && err.error.ERROR_CODE && err.error.ERROR_CODE === '401' ) {
                    location.reload();
                }
                //@Dharmendra - below error codes need to change based on error received in get requests
                if (err.error && err.error.error && err.error.error.code) {
                    if (err.error.error.code === 'LOGIN_FAILED') {
                        this._alertService.warn('Invalid email or password.');
                    } else if (err.error.error.code === 'MAX_LENGTH_EXCEEDED') {
                        this._alertService.warn('Exceeded the maximum character limit allowed for certain fields');
                    }
                    else{
                        this._alertService.error('A server error has occurred. Please try again or contact support.');
                    }
                }

                // (<any>$('#service-error-confirm-action')).modal('show');
                return EMPTY;
            }
        ));
    }

    public post(url: string, body: any = {}, params = {}): Observable<any> {

        const response = this.request('POST', this.get_formatted_url(url), body, params);
        return response.pipe(catchError(
            (err: HttpErrorResponse) => {
                // this._alertService.error('A server error has occurred. Please try again or contact support.');
                // @Simar - On request, hiding the error pop-up, but logging on the console for dev debugging
                if (err && err.error && err.error.ERROR_CODE && err.error.ERROR_CODE === '401' ) {
                    location.reload();
                }
                this.errorData = err;
                //@Dharmendra - below error codes need to extended based on error received in post requests
                if (err.error && err.error.error && err.error.error.code) {
                    if (err.error.error.code === 'LOGIN_FAILED') {
                        this._alertService.warn('Invalid email or password.');
                    } else if (err.error.error.code === 'MAX_LENGTH_EXCEEDED') {
                        this._alertService.warn('Exceeded the maximum character limit allowed for certain fields.');
                    } else if (err.error.error.code === 'INTEGER_EXPECTED') {
                        this._alertService.warn('Enter integer value in amount fields.');
                    }
                    else{
                        this._alertService.error('A server error has occurred. Please try again or contact support.');
                    }
                }
                // (<any>$('#service-error-confirm-action')).modal('show');
                return EMPTY;
            }
        ));
    }

    public download(url: string, body: any, params: any, responseType: string): Observable<any> {
        let body1 = body ? body : {};
        let params1 = params ? params : {};

        return this.request('POST', this.get_formatted_url(url), body1, params1, responseType);
    }

    public put(url: string, body: any = {}, params = {}): Observable<any> {

        return this.request('PUT', this.get_formatted_url(url), body, params);
    }

    public patch(url: string, body: any = {}, params = {}): Observable<any> {

        return this.request('PATCH', this.get_formatted_url(url), body, params);
    }

    public delete(url: string, body: any = {}, params = {}): Observable<any> {

        return this.request('DELETE', this.get_formatted_url(url), body, params);
    }

    upload(fileItem: File, url: string, extraData?: any): Observable<any> {

        const formData: FormData = new FormData();

        formData.append('fileItem', fileItem, fileItem.name);
        if (extraData) {
            // tslint:disable-next-line:forin
            for (const key in extraData) {
                // iterate and set other form data
                formData.append(key, extraData[key]);
            }
        }

        const req = new HttpRequest(
            'POST',
            `${this.baseUrl}/${url}`,
            {
                body: formData,
                headers: new HttpHeaders().set('Accept', AppConfig.content_type).set(AppConfig.content_typestr, 'multipart/form-data'),
                reportProgress: true
            },
            { reportProgress: true }
        );

        this.idleTimeoutService.resetTimer();

        return this.http.request(req);
    }

    uploadlargefile(fileItem: File, url: string, fileSha256Hash: string): Observable<any> {    
        this.idleTimeoutService.resetTimer();    
        
        let presignedHeaders = new HttpHeaders().set('Content-Type', fileItem.type);
        if (fileSha256Hash) {
            // guard against 'undefined'/'null' being stringified into the headers, which S3 rejects
            presignedHeaders = presignedHeaders
                .set('x-amz-checksum-sha256', fileSha256Hash)// For S3 checksum validation
                .set('x-amz-meta-sha-256', fileSha256Hash);// Stored as object metadata in S3
        }
        const req = new HttpRequest('PUT', url, fileItem, {
            reportProgress: true,
            headers: presignedHeaders
          });
    
         return this.http.request(req);
    }
    

    public downloadXml(url: any) {
        // resolve url with conditions
        const fullUrl = this.get_formatted_url(url);

        // change and reset headers around request for DL
        this.setHeader(AppConfig.content_typestr, 'application/xml');
        const response = this.request('GET', fullUrl, {}, {}, 'blob');
        this.resetHeaders();

        return response;
    }

    public request(method: string, url: any, body: any = {}, params = {}, responseType: any = null) {

        if (!this.overrideUrl) {
            url = `${this.baseUrl}/${url}`;
        }

        const paramsBuild: any = this.buildParams(params);
        const options: any = {
            body: body,
            headers: this.headers,
            params: paramsBuild,
            responseType: 'json'
        };
        if (responseType) {
            options.responseType = responseType;
        }
        return this.http.request(method, url, options);
    }

    public buildParams(paramsObj: any): HttpParams {
        let params = new HttpParams();
        Object.keys(paramsObj).forEach((key) => {
            params = params.set(key, paramsObj[key]);
        });
        return params;
    }

    public resetHeaders(): void {
        this.headers = new HttpHeaders().set('Accept', AppConfig.content_type).set(AppConfig.content_typestr, AppConfig.content_type);
    }

    public setHeader(key: string, value: string): void {
        this.headers = this.headers.set(key, value);
    }

    public deleteHeader(key: string): void {
        this.headers = this.headers.delete(key);
    }
}
