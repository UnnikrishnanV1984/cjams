import { Component, Injector, OnInit, ViewChild } from '@angular/core';
import { CookieService } from 'ngx-cookie-service';
import {  Router } from '@angular/router';
import { Location } from '@angular/common';
import { ErrorInfo } from '../../@core/common/errorDisplay';
import { UserLogin } from '../../@core/entities/authDataModel';
import { AlertService, CommonHttpService, SessionStorageService } from '../../@core/services';
import { AuthService } from '../../@core/services/auth.service';
import { config } from '../../../environments/config';

@Component({
    selector: 'login',
    styleUrls: ['./login.component.scss'],
    templateUrl: 'login.component.html',
    standalone: false
})

export class LoginComponent implements OnInit {
    show = false;
    user: UserLogin = new UserLogin();
    error: ErrorInfo = new ErrorInfo();
    openam_token: any;
    workEnv: boolean | undefined;
    dynamsoftProductKey:any;
    private _service: CommonHttpService;
    private _alertService: AlertService;
    private _CookieService: CookieService;
    private location: Location;
    private _storage: SessionStorageService;

    @ViewChild('showhideinput')
    input: any;
    constructor(private authService: AuthService, private router: Router,private readonly injector: Injector) {
        this._service = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._CookieService = this.injector.get<CookieService>(CookieService);
        this.location = this.injector.get<Location>(Location);
        this._storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this.getheaders(this.openam_token);
    }

    ngOnInit() {
        if (config.workEnvironment === 'local') {
            this.workEnv = false;
        } else {
            this.workEnv = true;
        }
    }

    getheaders(_token: any) {
        //OpenAM check is removed on 4/6/2020 as part openam improvement
        this.authService.openAMlogin('', '').subscribe(async (response: any) => {
            if (response && response.id && response.role) {
                localStorage.setItem('userProfile', JSON.stringify(response.user.userprofile));
                this.authService.roleBasedRoute(response.role.name.toLowerCase());
                const secret: any = await this.getWebAwsSecretsManager().toPromise();
                if(secret){
                    this.dynamsoftProductKey= secret['dynamsoftProductKey'];
                    this._storage.setItem("dynamsoftProductKey",btoa(encodeURIComponent ( this.dynamsoftProductKey)));
                }
            } else {
                this._alertService.error('User does not exist to access this application. Please contact your site admin.');
            }
        });
    }

    getWebAwsSecretsManager() {
        this._service.endpointUrl = 'awsapiKeys/getWebAwsSecretsManager';
         return this._service.getAll()
    }
    // get headers from openAM

    login() {
        if (this.user?.email && this.user?.password) {
            this.authService.login(this.user.email, this.user.password).subscribe(
                (response) => {
                    if (response?.id && response?.role) {
                        localStorage.setItem('userProfile', JSON.stringify(response.user.userprofile));
                        this.authService.roleBasedRoute(response.role.name.toLowerCase());
                        // }
                    } else {
                        this._alertService.error('User roles are not mapped for this user to access this application. Please contact your site admin.');
                    }
                },
                (err) => {
                        if (err?.error?.error?.code === 'LOGIN_FAILED') {
                            this._alertService.warn('Invalid email or password.');
                        } else if (err?.error?.error?.code === 'USERNAME_EMAIL_REQUIRED') {
                            this._alertService.warn('Email or password should not be empty!');
                        } else {
                            this._alertService.error('Unable to login, please try again.', err);
                            this.error.error(err);
                        }
                    /*} else {
                        this._alertService.error('Unable to login, please try again.', err);
                    }*/
                }
            );
        } else {
            this._alertService.warn('Email or password should not be empty!');
        }
    }

    toggleShow() {
        this.show = !this.show;
        const input = document.querySelector('#showinput');
        if (this.show && input) {
            this.input.nativeElement.type = 'text';
        } else {
            this.input.nativeElement.type = 'password';
        }
    }
}
