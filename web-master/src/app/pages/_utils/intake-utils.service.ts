import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { CommonHttpService, AuthService, DataStoreService } from '../../@core/services';
import { CommonUrlConfig } from '../../@core/common/URLs/common-url.config';
import { AppConstants } from '../../@core/common/constants';
import moment from 'moment';
import { FormGroup } from '@angular/forms';
import { Subject } from 'rxjs';
import { CASE_STORE_CONSTANTS } from '../case-worker/_entities/caseworker.data.constants';

export class IntakeStore {
    number!: string | null;
    action!: string | null;
    traffickingupdate!: boolean;
    maltreatmentupdated!: boolean;
}
export class IntakeCaseStore {
    intakeserviceid!: string;
    servicerequestnumber!: string;
    action!: string;
}



@Injectable()

export class IntakeUtils {

    public notesUpdated$ = new Subject<any>();
    public intakeTabSwitch$ = new Subject<any>();
    public narrativeUpdated$ = new Subject<any>();
    constructor(private _router: Router,
        private _sessionStorage: DataStoreService,
        private _commonHttpService: CommonHttpService,
        private _datastore: DataStoreService,
        private _authService: AuthService
        ) { }

        redirectIntake(intakeNumber: string, action?: string) {
            this.clearSessionStorage();
            const intake = Object.create(IntakeStore);
            intake.number = intakeNumber;
            intake.action = action ? action : 'edit';
            const url = '/pages/newintake/my-newintake/' + intake.number + '/' + intake.action + '/narrative';
            this._datastore.clearStore();
            this._datastore.clearStoreWithout();
            this._router.navigate([url]);
    }

    redirectToCase(intakeserviceid: string, servicerequestnumber: string, action?: string) {
        this._sessionStorage.removeItem('intakeCase');
        const intake = Object.create(IntakeCaseStore);
        intake.intakeserviceid = intakeserviceid;
        intake.servicerequestnumber = servicerequestnumber;
        intake.action = action ? action : 'edit';
        this._sessionStorage.setObj('IntakeCaseStore', intake);
        const url = `/pages/case-worker/${intakeserviceid}/${servicerequestnumber}/dsds-action/report-summary-djs`;
        this._router.navigate([url], { skipLocationChange: true });
    }

    redirectToPerson(personid: string) {
        const url = `/pages/person-details/view/${personid}/basic/demographics`;
        this._router.navigate([url]);
    }

    getFocusPersonStatus(personid: string | null, intakeserviceid: string | null, intakenumber: string | null, status: any = 'Open') {
        return this._commonHttpService.getArrayList({
            where: {
                personid: personid,
                intakeserviceid: intakeserviceid,
                intakenumber: intakenumber,
                status: status
            }, method: 'get'
        }, CommonUrlConfig.EndPoint.Intake.personStatus);
    }

    getResedentialStatus(personid: any) {
        return this._commonHttpService.getArrayList({ where: { personid: personid }, nolimit: true, method: 'get' }, 'placement/placementresidential?filter');
    }

    loadCaseAssignDashboard() {
        let assignCaseRoute = '/pages/cjams-dashboard';
        switch (this._authService.getAgencyName()) {
            case AppConstants.AGENCY.DJS:
                assignCaseRoute += '/assign-case';
                break;
            case AppConstants.AGENCY.CW:
                assignCaseRoute += '/cw-assign-case';
                break;
            // for AS no sepearte tab avalabe to assign case
        }
        this._router.navigate([assignCaseRoute]);
    }

    loadIntakeDashboard() {
        let assignCaseRoute = '/pages/cjams-dashboard';
        switch (this._authService.getAgencyName()) {
            case AppConstants.AGENCY.DJS:
                assignCaseRoute += '/intake-summary';
                break;
            case AppConstants.AGENCY.CW:
                assignCaseRoute += '/cw-assign-case';
                break;
            case AppConstants.AGENCY.AS:
                break;
            // for AS no sepearte tab avalabe to assign case
        }
        return assignCaseRoute;
    }

    extractDateOnly(date: any): string | null {
        const formattedDate = moment(date).format('YYYY-MM-DD');
        return formattedDate === 'Invalid date' ? null : formattedDate;
    }

    isValidZipCode(zipcode: string): boolean {
        const regex: RegExp = new RegExp(/^[0-9]{5}(?:-[0-9]{4})?$/);
        return regex.test(zipcode);
    }

    public findInvalidControls(form: FormGroup) {
        const invalid = [];
        const controls = form.controls;
        for (const name in controls) {
            if (controls[name].invalid) {
                invalid.push(name);
            }
        }
        return invalid;
    }
    public getAge(dateValue: string): number {
        if (
            dateValue &&
            moment(new Date(dateValue), 'MM/DD/YYYY', true).isValid()
        ) {
            const rCDob = moment(new Date(dateValue), 'MM/DD/YYYY').toDate();
            return moment().diff(rCDob, 'years');
        } else {
            return 0;
        }
    }
    public getAgeFormat(dateValue: string, format: string): number {
        if (
            dateValue &&
            moment(new Date(dateValue), format, true).isValid()
        ) {
            const rCDob = moment(new Date(dateValue), format).toDate();
            return moment().diff(rCDob, 'years');
        } else {
            return 0;
        }
    }

    public getAgeFormatBy(dateValue: string, format: string, mode: any): number {
        if (
            dateValue &&
            moment(new Date(dateValue), format, true).isValid()
        ) {
            const rCDob = moment(new Date(dateValue), format).toDate();
            return moment().diff(rCDob, mode);
        } else {
            return 0;
        }
    }

    public addDate(dateValue: string, format: string, count: number, mode: any) {
        if (
            dateValue &&
            moment(new Date(dateValue), format, true).isValid()
        ) {
            return moment(new Date(dateValue), format).add(count, mode).toDate();
        } else {
            return null;
        }
    }

    getIntakeStore(): IntakeStore {
        return this._sessionStorage.getObj('intake');
    }

    setIntakeStore(intakeStore: IntakeStore) {
        this._sessionStorage.setObj('intake', intakeStore);
    }

    // patchRestrictedItem(itemid, isrestricted) {
    //     let payload = {};
    //     payload['intakenumber'] = itemid;
    //     payload['isrestricteditem'] = isrestricted;
    //     return this._commonHttpService.patch(
    //       itemid,
    //       payload,
    //       'Intakedastagings'
    //     );
    //   }

    createRestrictedItem(itemid: string | null, objecttype: string, accessuser: any[], activeflag: number) {
        const payload: any = {};
        payload['objectid'] = itemid;
        payload['objecttypekey'] = objecttype;
        payload['userslist'] = accessuser;
        payload['activeflag'] = activeflag;
        if (activeflag === 1) {
        return this._commonHttpService.create(
            payload,
            'restricteditems/addrestriction'
        );
        } else {
         return this._commonHttpService.create(payload,
                'restricteditems/updaterestrictions'
            );
        }
    }


    isRestrictedItem(itemid: string) {
        return this._commonHttpService.getArrayList(
            {
                where: { objectid: itemid },
                nolimit: true,
                method: 'get'
            },
            'restricteditems/list?filter'
        );
    }

    restrictedItemAuditLog(itemid: string) {
        return this._commonHttpService.getArrayList(
            {
                where: { objectid: itemid },
                nolimit: true,
                method: 'get'
            },
            'restricteditems/restrictedauditlog?filter'
        );
    }

    clearSessionStorage() {
        this._sessionStorage.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this._sessionStorage.removeItem('intake');
    }


}
