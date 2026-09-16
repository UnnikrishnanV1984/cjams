import { Injectable } from '@angular/core';
import {  Subject, Subscription, Observable } from 'rxjs';
import { environment } from '../../../environments/environment';


@Injectable({ providedIn: 'root' })
export class IdleTimeoutService {
    private _timeoutSeconds = environment.IdleTimeOut; // 13 mins
    private _count = 0;

    private resetOnTrigger = false;
    public timeroutSubscription: Subscription = new Subscription();
    private timerSubscription: Subscription = new Subscription();
    private timer!: Observable<any>;
    public timeoutExpired: Subject<number> = new Subject<number>();

    myTimer!: NodeJS.Timer;

    public resetTimer() {
        // No content to add
    }
}
