import {EventEmitter, Injectable} from '@angular/core';
import {CommonHttpService} from './../../@core/services/common-http.service';
import {Observable} from 'rxjs';

import {Details} from './models/details.model';
import {Person} from './models/person.model';
import {Report} from './models/report.model';

@Injectable()
export class NytdService {

    // local store
    selectedPerson!: Person| undefined;
    selectedReport!: Report;
    loadedReports!: Report[];
    loadedReport!: Report | null;
    loadedDetails?: Details;
    answers: any;

    // request statuses
    isLoadingReports = false;
    isLoadingReport = false;
    isLoadingDetails = false;
    isSubmitting = false;
    submission: any;

    summary!: any[];
    served!: any[];
    survey!: any[];

    didSuccessfullySubmit = new EventEmitter<any>();

    constructor(private _commonHttpService: CommonHttpService) { }

    load() { this.loadReports(); }

    loadReports(): void {
        this.isLoadingReports = true;
        this.getReports().subscribe( response => {
                this.loadedReports = response;
            },
            err => { console.error(err); },
            () => { this.isLoadingReports = false; }
        );
    }

    loadReport(period:any): void {
        this.isLoadingReport = true;
        this.getReport(period).subscribe(
            response => {
               this.loadedReport = response;
            },
            err => { console.error(err); },
            () => { this.isLoadingReport = false; }
        );
    }

    loadDetails(id:any): void {
        this.isLoadingDetails = true;
        this.getDetails(id).subscribe(
            response => {
               this.loadedDetails = response;
               this.summary = this.loadedDetails.summary;
               this.served = this.loadedDetails.served;
               this.survey = this.loadedDetails.survey;
            },
            err => { console.error(err); },
            () => { this.isLoadingDetails = false; }
        );
    }

    submit(survey:any) {
        this.isSubmitting = true;
        this.updateSurvey(survey).subscribe(
            response => {
               this.submission = response;
               this.didSuccessfullySubmit.emit(response);
            },
            err => { console.error(err); },
            () => { this.isSubmitting = false; }
        );
    }

    // HTTP Requests
    getReports(): Observable<Report[]> {
        return this._commonHttpService.getAll('reports');
    }

    getReport(period:any): Observable<Report> {
        return this._commonHttpService.getById(period, 'reports');
    }

    getDetails(id:any): Observable<Details> {
        return this._commonHttpService.getById(id, 'details');
    }

    updateSurvey(survey:any): Observable<any> {
        return this._commonHttpService.update(this.loadedDetails?.id, survey, 'surveys');
    }

    // Event Listeners
    onSubmit($event:any) {
        const survey = {
            answers: this.answers,
            validated: $event.validated
        };

        this.submit(survey);
    }

    saveAnswers($event:any) {
        this.answers = $event;
    }

    onSelectReport($event:any) {
        this.selectedReport = $event;

        this.loadedDetails = undefined;
        if (this.selectedReport == undefined) {
            return;
        }
        this.selectedPerson = undefined;
        this.loadReport(this.selectedReport.period);
    }

    downloadAsXml(): Observable<any> {
        const period = this.loadedReport?.period;

        return this._commonHttpService.downloadXml(`reports/${period}/xml`);
    }

    onSelectPerson($event:any) {
        this.selectedPerson = $event;

        if (this.selectedPerson == undefined) {
            this.loadedDetails = undefined;
            return;
        }
        this.loadDetails(this.selectedPerson.detailsId);
    }
}
