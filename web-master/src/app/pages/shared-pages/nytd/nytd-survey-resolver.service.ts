
import {share, map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Resolve } from '@angular/router';
import { Observable ,  forkJoin } from 'rxjs';
import { NytdSurveyService } from './nytd-survey.service';
import { PersonInfoService } from '../person-info/person-info.service';

@Injectable()
export class NytdSurveyResolverService implements Resolve<any> {
    personid:any;
    personInfo:any;
    reportTypes:any;
    surveyStatuses:any;
    dataElements:any;
    summary:any;
    userNames:any;

    constructor(private _NytdSurveyService: NytdSurveyService, private _personService: PersonInfoService) { }

    resolve(): Observable<any> {
        this.personid = (this._personService.getPersonId()) ? this._personService.getPersonId() : '';

        return forkJoin([
            this._NytdSurveyService.getReportTypes(),
            this._NytdSurveyService.getSurveyStatus(),
            this._NytdSurveyService.getNytdDataElements(),
            this._NytdSurveyService.getNytdSummary(this.personid),
            this._NytdSurveyService.getUserNames()
        ]).pipe(map((result) => {
            return {
                reportTypes: result[0],
                surveyStatuses: result[1],
                dataElements: result[2],
                summary: result[3],
                userNames: result[4]
            };
        }),share(),);
    }
}
