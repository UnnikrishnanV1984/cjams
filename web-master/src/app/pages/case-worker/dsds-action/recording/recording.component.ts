import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../../../@core/services';
import { AppConstants } from '../../../../@core/common/constants';
import { ActivatedRoute } from '@angular/router';
import { RecordingResolverService } from './recording-resolver-service';

// tslint:disable-next-line:max-line-length

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'recording',
    templateUrl: './recording.component.html',
    styleUrls: ['./recording.component.scss'],
    standalone: false
})
export class RecordingComponent implements OnInit {
    userInfo!: string;
    userRole: any;
    isIntakeWorker!: boolean;
    ipaduser: boolean = false;
    moduleview: any;
    constructor(private _authService: AuthService, private route: ActivatedRoute,private recordingResolverService: RecordingResolverService) {
        // this.route.data.subscribe((data: any) => {
        //     if (data && data.hasOwnProperty('result')) {
        //       _authService.setAuthDetail('contacts',data.result);
        //     }
        // });
    }

    ngOnInit() {
        this.recordingResolverService.getContacts().subscribe({
            next: (data: any) => {
                this._authService.setAuthDetail('contacts',data);
            }
        })
        if (navigator.userAgent.match(/(iPod|iPhone|iPad|Android)/)) {
            this.ipaduser = true;
        }
        this.moduleview = this._authService.isModuleAccessable('contacts', 'contacts');
        this.userInfo = this._authService.getCurrentUser().role.teamtypekey;
        this.userRole = this._authService.getCurrentUser();
        this.isIntakeWorker =
            this.userRole.role.name === AppConstants.ROLES.INTAKE_WORKER;
    }
}
