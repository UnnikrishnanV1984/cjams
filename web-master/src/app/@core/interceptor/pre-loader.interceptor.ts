
import {tap} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { HttpRequest, HttpHandler, HttpResponse, HttpEvent, HttpErrorResponse, HttpInterceptor } from '@angular/common/http';
import { Observable } from 'rxjs';

declare var $: any;

@Injectable({ providedIn: 'root' })
export class PreLoaderInterceptor implements HttpInterceptor {
    private callCount = 0;
    
    intercept(
        request: HttpRequest<any>,
        next: HttpHandler
    ): Observable<HttpEvent<any>> {
        if (request.url.includes('sys.columns')) {      //SonarQube - consider using 'includes' method to make this check safe and explicit.
            throw new Error('Suspicious activity detected.');
        }

        if (request.headers.get('ctype') === 'file' || request.headers.get('no-loader') === 'true') {
            return next.handle(request);
        } else {
            this.showBusyLoader();
            this.callCount++;

            return next.handle(request).pipe(tap(
                (event: HttpEvent<any>) => {
                    if (event instanceof HttpResponse) {
                        this.callCount--;
                        if (this.callCount === 0 || this.callCount < 5) {
                            this.hideBusyLoader();
                        }
                    }
                },
                (error: any) => {
                    if (error instanceof HttpErrorResponse) {
                        this.callCount--;
                        this.hideBusyLoader();
                    }
                }
            ));
        }

    }

    showBusyLoader() {
        $('#loaderAnimation2').show();
    }

    hideBusyLoader() {
        $('#loaderAnimation2')
            .fadeOut('slow')
            .hide();
    }
}
