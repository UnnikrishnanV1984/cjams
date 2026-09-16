import { AppConfig } from './../../../../../app.config';
import { Injectable } from '@angular/core';
import { HttpClient } from "@angular/common/http";

@Injectable()
export class CreateBeaconAuditService {
    constructor(private http: HttpClient,) { }

    createAudit(event: string, eventPage: string, eventId: string = '', ssn = '',personid: string = ''): void {
        const req = {
            event: event,
            eventpage: eventPage,
            eventid: eventId,
            SSN: ssn,
            personid : personid
        }
        this.http
            .post(`${AppConfig.baseUrl}/beacon/addbeaconaudit`, req)
            .subscribe();
    }
}
