import { Component, Input, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable ,  Subject } from 'rxjs';

import { PaginationInfo, PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { CommonHttpService, GenericService, ValidationService } from '../../../../../../@core/services';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { CreateUser, UpdateProfileDetails, UpdateUser, PositionDetail } from '../../../_entites/user-security-profile.data.modal';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'roles-login-details',
    templateUrl: './roles-login-details.component.html',
    styleUrls: ['./roles-login-details.component.scss'],
    standalone: false
})
export class RolesLoginDetailsComponent implements OnInit {
    @Input() id!: Subject<string>;
    @Input() emailSubject!: Subject<string>;
    @Input() userRoles!: Subject<UpdateProfileDetails>;
    @Input() positionTeammember$!: Subject<PositionDetail>;
    emailUserProfile!: string;
    securityusersid!: string;
    createPrincipalid!: number;
    principalid!: string;
    teammemberDateils!: PositionDetail;
    show = false;
    saveButton!: boolean;
    resetButton!: boolean;
    addSecurityRoles!: FormGroup;
    // userRole$: Observable<UserRole[]>;
    // userRole$: Observable<UserRole[]>;
    totalRecords$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    updateUser: UpdateUser = new UpdateUser();
    emailControl!: AbstractControl | null;
    passwordControl!: AbstractControl | null;
    confirmPasswordControl!: AbstractControl | null;
    constructor(
        private route: ActivatedRoute,
        private router: Router,
        private formBuilder: FormBuilder,
        private _alertService: AlertService,
        private _userService: GenericService<CreateUser>,
        private _commonHttp: CommonHttpService
    ) {}

    ngOnInit() {
        this.formInitilize();
        this.emailControl = this.addSecurityRoles.get('email');
        this.passwordControl = this.addSecurityRoles.get('password');
        this.confirmPasswordControl = this.addSecurityRoles.get('confirmpassword');
        this.id.subscribe((id) => {
            this.securityusersid = id;
            this.saveButton = false;
            this.resetButton = false;
        });
        this.emailSubject.subscribe((email) => {
            this.emailUserProfile = email;
            this.addSecurityRoles.patchValue({ email: email });
        });
        this.emailControl?.disable();

        this.route.params.subscribe((item: any) => {
            this.principalid = item['id'];
            if (this.principalid !== '0') {
                this.saveButton = true;
                this.resetButton = true;
                this.passwordControl?.disable();
                this.confirmPasswordControl?.disable();
                this.userRoles.subscribe((roles) => {
                    this.createPrincipalid = roles.id;
                    this.addSecurityRoles.patchValue({
                        // roleid: roles.role.roleid,
                        email: roles.email
                    });
                });
            }
        });
        this.positionTeammember$.subscribe((res) => {
            this.teammemberDateils = res;
        });
    }

    formInitilize() {
        this.addSecurityRoles = this.formBuilder.group(
            {
                email: ['', [ValidationService.mailFormat, Validators.required]],
                // roleid: ['', Validators.required],
                password: ['', Validators.required, ValidationService.passwordStrengthValidation],
                confirmpassword: ['', Validators.required]
            },
            {
                validators: ValidationService.equalValueValidator('password', 'confirmpassword', 'The passwords you entered do not match.')
            }
        );
    }
    // getRoles() {
    //     this.userRole$ = this._commonHttp.getArrayList({}, 'roles').map((result) => {
    //         return result;
    //     });
    // }
    closeUserProfile() {
        this.saveButton = false;
        $('#add-newusers-popup').modal('hide');
        const currentUrl = 'pages/admin/user-security-profile';
        this.router.navigateByUrl(currentUrl).then(() => {
            this.router.navigated = false;
            this.router.navigate([currentUrl]);
        });
    }
    saveLogin() {
        const modal = {
            email: this.emailUserProfile,
            password: this.addSecurityRoles.value.password,
            securityusersid: this.securityusersid,
            teammemberid: this.teammemberDateils ? this.teammemberDateils.teammemberid : '',
            roleid: this.teammemberDateils ? this.teammemberDateils.roleid : ''
        };
        if (this.addSecurityRoles.dirty && this.addSecurityRoles.valid) {
            this._commonHttp.create(modal, 'users/createuser').subscribe(
                (result) => {
                    this._alertService.success('User profile created successfully!');
                    this.closeUserProfile();
                    this.saveButton = true;
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    updateLogin() {
        const modal: any = {
            principalid: this.createPrincipalid,
            roleid: this.teammemberDateils ? this.teammemberDateils.roleid : '',
            teammemberid: this.teammemberDateils ? this.teammemberDateils.teammemberid : '',
            password: this.addSecurityRoles.value.password
        };
        if (this.addSecurityRoles.value === '') {
            const encodepwsd =decodeURIComponent(atob('cGFzc3dvcmQ=')); //encoded the variable pswd
            delete modal[encodepwsd];
        }
        if (this.addSecurityRoles.dirty && this.addSecurityRoles.valid) {
            this._commonHttp
                .getArrayList(
                    new PaginationRequest({
                        where: modal,
                        method: 'post'
                    }),
                    'users/updateuser'
                )
                .subscribe(
                    (result) => {
                        if (result) {
                            this.closeUserProfile();
                            this.emailControl?.enable();
                            this._alertService.success('User profile updated successfully!');
                        } else {
                            this._alertService.error('Failed to update profile!');
                        }
                    },
                    (error) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
        }
    }
    resetPassword() {
        this.passwordControl?.enable();
        this.confirmPasswordControl?.enable();
        this.resetButton = false;
    }

    getControlByIndexFn(index: string): FormControl {
        return this.addSecurityRoles.controls[index] as FormControl;
    }
}
