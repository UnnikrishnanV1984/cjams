import {Injectable} from '@angular/core';
import {CommonHttpService} from './../../@core/services/common-http.service';
import {Observable} from 'rxjs';


@Injectable()
export class ProgramParticipationService {

    selectedPerson: any;
    loadedPrograms: any[] = [];
    loadingPrograms: boolean = false;
    loadingCaseDetails: boolean = false;
    loadedCaseDetails: any;
    
    constructor(private _commonHttpService: CommonHttpService) { }

    onSelectPerson($event: any) {
        this.selectedPerson = $event;
           
        if (this.selectedPerson === undefined) {
            this.resetLoadedPrograms();
            return;
        }

        this.loadPrograms(this.selectedPerson.id);
    }

    resetLoadedPrograms() {
        this.loadedPrograms = [];
    }

    loadPrograms(id: any) {
        this.resetLoadedPrograms();
        this.loadingPrograms = true;
        this.getPrograms(id).subscribe( response => {
                if (this._isValidArrayResponse(response)) {
                    this.loadedPrograms = response;
                    this.loadedPrograms.sort((a, b) => {
                        if (new Date(a.end) > new Date(b.end)){ return -1;}
                        else if (new Date(a.end) < new Date(b.end)){ return 1;}
                        else{ return 0;}
                    });
                    return
                }
                this.resetLoadedPrograms();
            },
            err => { console.error(err); },
            () => { this.loadingPrograms = false; }
        );
    }

    getPrograms(id: any): Observable<any[]> {
        return this._commonHttpService.getAll(`People/getpersonprograms/${id}`);
    }

    loadCaseDetails(id: any) {
        this.loadingCaseDetails = true;
        this.getCaseDetails(id)
        .subscribe( response => {
                if (this._isValidArrayResponse(response) && response[0].getpersonprogramcasedetails) {
                    this.loadedCaseDetails = response[0].getpersonprogramcasedetails[0];
                }
            },
            err => { console.error(err); },
            () => { this.loadingCaseDetails = false; }
        );
    }

    getCaseDetails(caseid: any): Observable<any> {
        return this._commonHttpService.getArrayList(
            {
                where: { caseid: caseid },
                method: 'get'
            },
            'People/getpersonprogramcasedetails?filter'
        );
    }

    private _isValidArrayResponse(response: any) {
        return response && Array.isArray(response) && response.length > 0 
    }
}
