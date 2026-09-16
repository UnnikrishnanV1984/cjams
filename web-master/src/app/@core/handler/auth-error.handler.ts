import { ErrorHandler, Injectable, Injector } from '@angular/core';
import { Router } from '@angular/router';

@Injectable({ providedIn: 'root' })
export class AuthErrorHandler implements ErrorHandler {
    constructor(private injector: Injector) {}

    handleError(error: any) {
        const router = this.injector.get(Router);
        if (error.status === 401 || error.status === 403) {
            if (location.pathname.indexOf('external-assessment') === -1) {
                router.navigate(['/login']);
            }
        }
        throw error;
    }
}
