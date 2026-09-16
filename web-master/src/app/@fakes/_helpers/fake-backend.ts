
import {of as observableOf,  Observable } from 'rxjs';
import {dematerialize} from 'rxjs/operators/dematerialize';
import {delay} from 'rxjs/operators/delay';
import {materialize} from 'rxjs/operators/materialize';
import {mergeMap} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { HttpRequest, HttpResponse, HttpHandler, HttpEvent, HttpInterceptor, HTTP_INTERCEPTORS } from '@angular/common/http';
import * as user from '../_data/users.json';
import * as permissions from '../_data/permissions.json';
@Injectable()
export class FakeBackendInterceptor implements HttpInterceptor {

    intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
        // array in local storage for registered users
        // wrap in delayed observable to simulate server api call
        return observableOf(null).pipe(mergeMap(() => {

            if (request.url.match(/\/api\/users\/\d+$/) && request.method === 'GET') {
                return observableOf(new HttpResponse({ status: 200, body: <any>user }));
            }

            if (request.url.endsWith('/permission') && request.method === 'POST') {
                return observableOf(new HttpResponse({ status: 200, body: <any>permissions }));
            }
            // pass through any requests not handled above
            return next.handle(request);
        }),

            // call materialize and dematerialize to ensure delay even if an error is thrown (https://github.com/Reactive-Extensions/RxJS/issues/648)
            materialize(),
            delay(500),
            dematerialize(),);
    }
}

export const fakeBackendProvider = {
    // use fake backend in place of Http service for backend-less development
    provide: HTTP_INTERCEPTORS,
    useClass: FakeBackendInterceptor,
    multi: true
};
