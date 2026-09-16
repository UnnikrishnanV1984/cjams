import { environment } from './../../../environments/environment.staging';
import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { SessionStorageService } from '../services/storage.service';
import { config } from '../../../environments/config';
import { AuthService } from '../services';

@Injectable({ providedIn: 'root' })
export class AuthTokenInterceptor implements HttpInterceptor {
    constructor(private storage: SessionStorageService, private authservice: AuthService) {}

    public intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
        let authToken =  this.authservice.getCurrentUser();
        if ((!authToken || Object.keys(authToken).length === 0) && config.workEnvironment == 'local' ) {
        const storedTokenObj = this.storage.getObj('token');
        if (storedTokenObj) {
            try {
                authToken = JSON.parse(decodeURIComponent(atob(storedTokenObj)));
            } catch (e) {
                authToken = storedTokenObj; 
            }
        }
     }
        const fbToken = this.storage.getObj('fbToken');
        if(authToken && authToken.user && authToken.user.email){
            request = request.clone({
                headers: request.headers.set('user_email_captureby_application', `${authToken.user.email}`)
            });
        }
        if(authToken && authToken.user && authToken.user.securityusersid){
            request = request.clone({
                headers: request.headers.set('securityusersid', `${authToken.user.securityusersid}`)
            });
        }
        if(authToken && authToken.id) {
            request = request.clone({
                headers: request.headers.set('access_token', `${authToken.id}`)
            });
        }
        if (authToken && config.workEnvironment == 'local') {
            request = request.clone({
                headers: request.headers.set('access_token', `${authToken.id}`)
            });
            if(authToken.user && authToken.user.email){
                request = request.clone({
                    headers: request.headers.set('uid', `${authToken.user.email}`)
                });
            }
        }
        if (fbToken && request.url.indexOf(environment.formBuilderHost) > -1) {
            request = request.clone({
                headers: request.headers.set('x-jwt-token', `${fbToken}`)
            });
        }
        // For stage3 performace testing
        // if(request.url.includes('People/getpersondetail')) {
        //     request = request.clone({
        //         headers: request.headers.set('x-request-id', 'debug1')
        //     });
        // }
        return next.handle(request);
    }
}
