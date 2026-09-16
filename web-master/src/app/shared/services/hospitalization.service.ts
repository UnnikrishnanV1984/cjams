import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
        providedIn: 'root',
})
export class HospitalizationService {

    selectedPersonId$: BehaviorSubject<string> = new BehaviorSubject<string>('')
    selectedPersonId:any;
    intakeservicerequestactorid:any;
    dischargeDateChange$: BehaviorSubject<any> = new BehaviorSubject<any>(null);
    exitPlacementEndDate$: BehaviorSubject<any> = new BehaviorSubject<any>(null);
    dischargeTimeChange$: BehaviorSubject<any> = new BehaviorSubject<any>(null);
    exitPlacementEndTime$: BehaviorSubject<any> = new BehaviorSubject<any>(null);

    getSelectedPersonId(): any {
        return this.selectedPersonId$.asObservable();
    }

    setSelectedPersonId(selectedPersonId: string){
        this.selectedPersonId$.next(selectedPersonId)
    }

    getDischargeDate():any {
        return this.dischargeDateChange$.asObservable();
    }

    setDischargDate(value:any):any {
        this.dischargeDateChange$.next(value);
    }

    getExitPlacementEndDate():any {
        return this.exitPlacementEndDate$.asObservable();
    }

    setExitPlacementEndDate(value:any):any {
        this.exitPlacementEndDate$.next(value);
    }

    getDischargeTime():any {
        return this.dischargeTimeChange$.asObservable();
    }

    setDischargTime(value:any):any {
        this.dischargeTimeChange$.next(value);
    }

    getExitPlacementEndTime():any {
        return this.exitPlacementEndTime$.asObservable();
    }

    setExitPlacementEndTime(value:any):any {
        this.exitPlacementEndTime$.next(value);
    }
}