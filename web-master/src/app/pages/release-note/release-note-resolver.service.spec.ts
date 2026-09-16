import { TestBed } from '@angular/core/testing';
import { of } from 'rxjs';
import { ReleaseNoteAccessResolver, ReleaseNoteAccess } from './release-note-resolver.service';
import { ReleaseNoteService } from '././release-note.service
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';

describe('ReleaseNoteAccessResolver', () => {
    let mockService: jasmine.SpyObj<ReleaseNoteService>;
    const mockRoute = {} as ActivatedRouteSnapshot;
    const mockState = {} as RouterStateSnapshot;

    beforeEach(() => {
        mockService = jasmine.createSpyObj('ReleaseNoteService', ['checkAccess']);

        TestBed.configureTestingModule({
            providers: [
                { provide: ReleaseNoteService, useValue: mockService }
            ]
        });
    });

    it('maps approver and admin flags from first result', done => {
        mockService.checkAccess.and.returnValue(of([{ approver: true, admin: true }]));

        TestBed.runInInjectionContext(() => {
            const result$ = ReleaseNoteAccessResolver(mockRoute, mockState) as any;
            result$.subscribe((access: ReleaseNoteAccess) => {
                expect(access.approver).toBeTrue();
                expect(access.admin).toBeTrue();
                done();
            });
        });
    });

    it('defaults approver and admin to false when first result has no flags', done => {
        mockService.checkAccess.and.returnValue(of([{}]));

        TestBed.runInInjectionContext(() => {
            const result$ = ReleaseNoteAccessResolver(mockRoute, mockState) as any;
            result$.subscribe((access: ReleaseNoteAccess) => {
                expect(access.approver).toBeFalse();
                expect(access.admin).toBeFalse();
                done();
            });
        });
    });

    it('defaults both flags to false when result array is empty', done => {
        mockService.checkAccess.and.returnValue(of([]));

        TestBed.runInInjectionContext(() => {
            const result$ = ReleaseNoteAccessResolver(mockRoute, mockState) as any;
            result$.subscribe((access: ReleaseNoteAccess) => {
                expect(access.approver).toBeFalse();
                expect(access.admin).toBeFalse();
                done();
            });
        });
    });

    it('maps approver=true, admin=false independently', done => {
        mockService.checkAccess.and.returnValue(of([{ approver: true, admin: false }]));

        TestBed.runInInjectionContext(() => {
            const result$ = ReleaseNoteAccessResolver(mockRoute, mockState) as any;
            result$.subscribe((access: ReleaseNoteAccess) => {
                expect(access.approver).toBeTrue();
                expect(access.admin).toBeFalse();
                done();
            });
        });
    });
});
