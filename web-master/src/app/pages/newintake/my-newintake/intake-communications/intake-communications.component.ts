import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../../../@core/services';

// tslint:disable-next-line:max-line-length
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'intake-communications',
    templateUrl: './intake-communications.component.html',
    styleUrls: ['./intake-communications.component.scss'],
    standalone: false
})
export class IntakeCommunicationsComponent implements OnInit {
    userInfo: string;
    constructor(private _authService: AuthService) {}

    ngOnInit() {
        this.userInfo = this._authService.getCurrentUser().role.teamtypekey;
     }
}
