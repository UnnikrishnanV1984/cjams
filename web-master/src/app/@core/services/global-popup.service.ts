import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { CommonHttpService } from './common-http.service';
import { HomeDashboardUrlConfig } from '../../../../src/app/pages/home-dashboard/home-dashbaord.url.config';


@Injectable({ providedIn: 'root' })
export class GlobalPopupService {


    constructor(private _commonHttpService: CommonHttpService) {
    }

    private legalGuardianRoleData = new BehaviorSubject<any>(null);   
    private identifyactivepersons = new BehaviorSubject<any>(null);
    private medicalPrescribedData = new BehaviorSubject<any>(null);
    private isNavigateFromNotes = new BehaviorSubject<any>(null);
    private hospitalizationData = new BehaviorSubject<any>(null);
    private livingarrangpopup = new BehaviorSubject<any>(null);
    private livingarrangementFcnFHSpopup = new BehaviorSubject<any>(null);
    private livingarrangementFcnFHSClientDetails = new BehaviorSubject<any>(null);
    private sennotification =new BehaviorSubject<any>(null);
    private setChildNames = new BehaviorSubject<any>(null);

  
    lgrData$ = this.legalGuardianRoleData.asObservable();
    identfyactiper$ = this.identifyactivepersons.asObservable();
    isNavgFromNotes$ = this.isNavigateFromNotes.asObservable();
    mpActiondata$ = this.medicalPrescribedData.asObservable();
    hospitalData$ = this.hospitalizationData.asObservable();
    lapopup$ = this.livingarrangpopup.asObservable();
    lapopupFcnFHS$ = this.livingarrangementFcnFHSpopup.asObservable();
    lapopupClientFcnFHS$ = this.livingarrangementFcnFHSClientDetails.asObservable();
    sencaseconnect$ =this.sennotification.asObservable();
    setChildName$ = this.setChildNames.asObservable();
    setlegalGuardianRoleData(data: any): void {
        this.legalGuardianRoleData.next(data);
    }

    sethospitalizationData(data: any): void {
        this.hospitalizationData.next(data);
    }

    setlapopup(data:any) : void {
        this.livingarrangpopup.next(data);
    }
    
    setlapopupFcnFHS(data:any) : void {
        this.livingarrangementFcnFHSpopup.next(data);
    }

    setClientNamesFcnFHS(data:any) : void {
        this.livingarrangementFcnFHSClientDetails.next(data);
    }

    setMedicalPrescribedData(data: any, isNavigateFromNotes: boolean = false): void {
        const currentData = this.medicalPrescribedData.value ?? [];
        const newData = data ?? [];
        this.medicalPrescribedData.next([...currentData, ...newData]);
        this.isNavigateFromNotes.next(isNavigateFromNotes);
    }

    setIdentifyActivePersons(data: any): void {
        this.identifyactivepersons.next(data);
    }

    getChilderNames(data:any): void {
        this.setChildNames.next(data ?? []);
    }

    capitalizeWords(string: any) {
        return string.split(' ').map((word: any) =>
            word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()
        ).join(' ')
    }
    setcaseconnectsen(data:any){
        this.sennotification.next(data)

    }

    resetData(): void {
        this.medicalPrescribedData.next(null);
        this.isNavigateFromNotes.next(null);
        this.legalGuardianRoleData.next(null);
        this.hospitalizationData.next(null);
        this.identifyactivepersons.next(null);
        this.livingarrangpopup.next(null);
        this.livingarrangementFcnFHSpopup.next(null);
        this.livingarrangementFcnFHSClientDetails.next(null);
        this.sennotification.next(null);
    }

    updateMyTaskbyUser(alerttype: any, personId: any, ispageopened?: boolean,) {
        const data = {
            personid: personId,
            ispageopened: ispageopened,
            alerttype: alerttype

        };
        this._commonHttpService.create(data, HomeDashboardUrlConfig.EndPoint.myTasks.updateMyTaskURL).subscribe();

    }

    saveHealth(data: any, personId: any) {
        const saveObject = { 'health': data, 'pid': personId, 'isnew': 1 };
        return this._commonHttpService
            .create(saveObject, 'People/personhealthaddupdate');
    }
}