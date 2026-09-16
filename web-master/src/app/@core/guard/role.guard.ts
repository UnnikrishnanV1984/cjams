import {of as observableOf, Observable, of } from 'rxjs';
import { Injectable, signal } from '@angular/core';
import { Router, RouterStateSnapshot, ActivatedRouteSnapshot, CanActivate, CanActivateChild, UrlTree } from '@angular/router';
import { map, catchError } from 'rxjs/operators';
import { AuthService } from '../services/auth.service';
import { CommonHttpService, DataStoreService } from '../services';
import { AppConfig } from '../../app.config';

import { ResourceAccess } from '../entities/authDataModel';
import { PaginationRequest } from '../entities/common.entities';

@Injectable({providedIn: 'root'})
export class RoleGuard implements CanActivate, CanActivateChild {

    private readonly permissionsList = signal<any[]>([]);
    
    constructor(private authService: AuthService, private router: Router, private _store: DataStoreService, private _commonService: CommonHttpService
    ) {}

    canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<boolean | UrlTree> {
        return this.checkActivation(route, state);
    }

    canActivateChild(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<boolean | UrlTree> {
        return this.checkActivation(route, state);
    }

     private checkActivation(route: ActivatedRouteSnapshot,state: RouterStateSnapshot): Observable<boolean | UrlTree> {

        const screenKey = route.data?.screen?.key;
        const currentUser = this.authService.getCurrentUser();
        
        if (!screenKey) {
             return of(true);
        }

        const request = new PaginationRequest({
            where: {
            modulekey: screenKey,
            userid: currentUser.userId
            },
            method: 'get'
        });

        return this._commonService.getSingle(request, AppConfig.pageProfile + '?arg')
        .pipe(map((result: ResourceAccess) => {
            this.permissionsList.set(result.resources);
            return true;
        }),
        catchError((_error) => {
            // Fail closed if the API call itself fails
            this.router.navigate(['/access-denied']);
            return of(false);
        }));
    }

    getPermissionsList() {
        return this.permissionsList();
    }
}