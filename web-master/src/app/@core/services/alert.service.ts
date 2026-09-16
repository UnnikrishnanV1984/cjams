import { Injectable } from '@angular/core';
import { Router, NavigationStart } from '@angular/router';
import { Observable ,  Subject } from 'rxjs';
import { Alert, AlertType } from '../entities/common.entities';
import { DataStoreService } from './data-store.service';

@Injectable({ providedIn: 'root' })
export class AlertService {
    private subject = new Subject<Alert | null>();
    private keepAfterRouteChange = false;

    constructor(private router: Router,private _dataStoreService: DataStoreService) {
        // clear alert messages on route change unless 'keepAfterRouteChange' flag is true
        router.events.subscribe(event => {
            if (event instanceof NavigationStart) {
                if (this.keepAfterRouteChange) {
                    // only keep for a single route change
                    this.keepAfterRouteChange = false;
                } else {
                    // clear alert messages
                    this.clear();
                }
            }
        });
    }

    getAlert(): Observable<any> {
        return this.subject.asObservable();
    }

    success(message: string, keepAfterRouteChange = false) {
        this.alert(AlertType.Success, message, keepAfterRouteChange);
    }

    error(message: string, keepAfterRouteChange = false) {
        const auth= this._dataStoreService.isAuthorized(); //for fortify issues 
        if(auth ){
         this.alert(AlertType.Error, message, keepAfterRouteChange);
        }
    }

    info(message: string, keepAfterRouteChange = false) {
        this.alert(AlertType.Info, message, keepAfterRouteChange);
    }

    warn(message: string, keepAfterRouteChange = false) {
        this.alert(AlertType.Warning, message, keepAfterRouteChange);
    }

    alert(type: AlertType, message: string, keepAfterRouteChange = false) {
        this.keepAfterRouteChange = keepAfterRouteChange;
        this.subject.next(<Alert>{ type: type, message: message, keepAlive: keepAfterRouteChange });
    }
    
    clear() {
        // clear alerts
        this.subject.next(null);
    }
}

