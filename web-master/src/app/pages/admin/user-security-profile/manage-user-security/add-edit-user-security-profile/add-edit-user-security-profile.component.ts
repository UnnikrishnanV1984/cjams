import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subject } from 'rxjs';

import { PositionDetail, UpdateProfileDetails } from '../../_entites/user-security-profile.data.modal';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'add-edit-user-security-profile',
    templateUrl: './add-edit-user-security-profile.component.html',
    standalone: false
})
export class AddEditUserSecurityProfileComponent implements OnInit {
    securityusersid: string | undefined;
    isAddMode: boolean = false;
    emailSubject: Subject<string> = new Subject<string>();
    sUserid: Subject<string> = new Subject<string>();
    positionTeammember$: Subject<PositionDetail> = new Subject<PositionDetail>();
    editUserRoles: Subject<UpdateProfileDetails> = new Subject<UpdateProfileDetails>();
    constructor(private route: ActivatedRoute, private router: Router) {}

    ngOnInit() {
        this.sUserid.subscribe((id) => {
            this.securityusersid = id;
        });
        this.route.params.subscribe((item) => {
            this.isAddMode = item['id'] === '0';
        });
        this.editUserRoles.subscribe();
        this.positionTeammember$.subscribe();
    }
    closeUserProfile() {
        $('#add-newusers-popup').modal('hide');
        const currentUrl = 'pages/admin/user-security-profile/manage-user-security';
        this.router.navigateByUrl(currentUrl).then(() => {
            this.router.navigated = false;
            this.router.navigate([currentUrl]);
        });
    }
}
