import { inject } from '@angular/core';
import { ResolveFn, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { ReleaseNoteService } from './release-note.service';

export interface ReleaseNoteAccess {
    approver: boolean;
    admin: boolean;
}

export const ReleaseNoteAccessResolver: ResolveFn<ReleaseNoteAccess> = (
    _route: ActivatedRouteSnapshot,
    _state: RouterStateSnapshot
): Observable<ReleaseNoteAccess> => {
    return inject(ReleaseNoteService).checkAccess().pipe(
        map((res: any[]) => ({
            approver: res[0]?.approver ?? false,
            admin:    res[0]?.admin    ?? false
        })),
        catchError(() => of({ approver: false, admin: false }))
    );
};
