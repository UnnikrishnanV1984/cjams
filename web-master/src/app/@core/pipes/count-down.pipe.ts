
import {interval as observableInterval,  Observable } from 'rxjs';

import {map} from 'rxjs/operators';
import { Pipe, PipeTransform } from '@angular/core';
import moment from 'moment';

@Pipe({
    name: 'countDown',
    standalone: false
})
export class CountDownTimer implements PipeTransform {
    currentTime!: string;
    countDown: any;
    timeDiff!: number;
    transform(value: any, hours: number = 2): Observable<any> {
        return observableInterval(1000).pipe(
            map((res) => {
                if (new Date().getTime() < new Date(value).getTime() + hours * 60 * 60 * 1000) {
                    this.timeDiff = Math.floor(((new Date(value).getTime() + hours * 60 * 60 * 1000) - new Date().getTime()) / 1000) - 1;
                } else {
                    this.timeDiff = Math.floor((new Date().getTime() - (new Date(value).getTime() + hours * 60 * 60 * 1000)) / 1000);
                }
                return this.timeDiff;
            }),
            map((res) => {
                const timeLeft = moment.duration(res, 'seconds');
                this.currentTime = '';
                //Months
                if (timeLeft.months()) {
                    if (timeLeft.months() == 1) {
                    this.currentTime += timeLeft.months() + ' Month ';
                    } else{
                        this.currentTime += timeLeft.months() + ' Months ';
                    }
                }
                // Days.
                if (timeLeft.days()) {
                    this.currentTime += timeLeft.days() + ' Days';
                }
                // Hours.
                if (timeLeft.hours()) {
                    this.currentTime += ' ' + timeLeft.hours() + ' Hours';
                }
                // Minutes.
                if (timeLeft.minutes()) {
                    this.currentTime += ' ' + timeLeft.minutes() + ' Mins';
                }

                if (new Date().getTime() < (new Date(value).getTime() + hours * 60 * 60 * 1000)) {
                    this.countDown = {
                        time: this.currentTime,
                        color: 'green'
                    };
                } else {
                    this.countDown = {
                        time:  this.currentTime + ' Overdue' ,
                        color: 'red'
                    };
                }
                return this.countDown;
            }),);
    }
}
