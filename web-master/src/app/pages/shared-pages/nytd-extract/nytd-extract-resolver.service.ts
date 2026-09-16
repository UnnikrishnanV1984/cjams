
import {share, map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Resolve } from '@angular/router';
import { Observable ,  forkJoin } from 'rxjs';
import { NytdExtractService } from './nytd-extract.service';
import { PersonInfoService } from '../person-info/person-info.service';

@Injectable()
export class NytdExtractResolverService implements Resolve<any> {
    personid:any;
    reportTypes:any;
    userNames:any;
    summary:any = [];
    reportingPeriods: any = [];

    constructor(private _NytdSurveyService: NytdExtractService, private _personService: PersonInfoService) { }

    resolve(): Observable<any> {
        this.personid = (this._personService.getPersonId()) ? this._personService.getPersonId() : '';

        const year = new Date().getFullYear();
        const month = new Date().getMonth() + 1;
        var reportingperiod = year.toString().concat(month > 3 ? '09' : '03')

        return forkJoin([
            this._NytdSurveyService.getReportTypes(),
            this._NytdSurveyService.getUserNames(),
            this._NytdSurveyService.getNytdSummary(reportingperiod),
            this._NytdSurveyService.getReportingPeriods()
        ]).pipe(map((result) => {
            this.reportingPeriods = [];
            return {
                reportTypes: result[0],
                userNames: result[1],
                summary: result[2],
                reportingPeriods: result[3]
            };
        }),share(),);

 
    }
}
