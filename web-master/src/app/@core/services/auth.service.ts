
import {map, mergeMap,  distinctUntilChanged } from 'rxjs/operators';

import { Location } from '@angular/common';
import { Injectable, Injector, signal } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { CookieService } from 'ngx-cookie-service';
import { BehaviorSubject ,  Observable ,  ReplaySubject ,  Subject } from 'rxjs';

import { AppConfig } from '../../app.config';
import { AppUser } from '../entities/authDataModel';
import { DataStoreService } from './data-store.service';
import { HttpService } from './http.service';
import { SessionStorageService, LocalStorageService } from './storage.service';
import { config } from '../../../environments/config';
import { environment } from '../../../environments/environment';
import { AppConstants } from '../common/constants';
import { hasMatch } from '../common/initializer';
import { FormGroup } from '@angular/forms';
import { IntakeStoreConstants } from '../../pages/newintake/my-newintake/my-newintake.constants';
import { CommonHttpService } from './common-http.service';
import { AlertService } from './alert.service';
import { MatDialog } from '@angular/material/dialog';
import { UploadSharedService } from './upload-shared.service';
import { CaseWorkerUrlConfig } from '../../pages/case-worker/case-worker-url.config';

@Injectable({ providedIn: 'root' })
export class AuthService {
    private currentUserSubject = new BehaviorSubject<AppUser>({} as AppUser);
    public roleupdate$ = new BehaviorSubject<any>({});
    public currentUser = this.currentUserSubject.asObservable().pipe(distinctUntilChanged());
    public navgationChanged = this.roleupdate$.asObservable().pipe(distinctUntilChanged());
    private checkRoleArr: any[] = [];

    private isAuthenticatedSubject = new ReplaySubject<boolean>(1);
    public isAuthenticated = this.isAuthenticatedSubject.asObservable();
    userProfile: any;
    permissionpath = 'PERMISSION.';
    extassessment = 'external-assessment';
    intakepath = '/pages/newintake/new-saveintake';
    homepath = '/pages/home-dashboard';
    cjamspath = '/pages/cjams-dashboard';
    financepath = '/pages/finance/finance-dashboard';
    editAllowedModulesList = ['persongrid','personprofile','personaddress','personeducation','personemployment','personhealth','personrelationship','courtpetition','courthearing','courtorder','legalcustody'];
    editAllowedRolesList = ['IV-E Supervisor','IV-E Specialist','IV-E Eligibility Analyst','IV-E Eligibility Quality Assurance','IV-E Eligibility Administrator'];
    //@Simar - Multi-role hack: use this to hold the original role that the user logged-in with
    //This way on switching context to different role we have a placeholder for the primary role
    primaryRole: any;
    public dashboardConfig$ = new Subject<any>();    
    private location: Location;
    private storage: SessionStorageService;
    private localstore: LocalStorageService;
    private http: HttpService;
    private router: Router;
    private _storeService: DataStoreService;
    private _CookieService: CookieService;
    private _commonService: CommonHttpService;
    private _alertService: AlertService;
    private _dialog: MatDialog;
    uploadfailedfiles: any[] = [];    
    private shareduploadService: UploadSharedService;
    private permissionsData = signal<any>({});
    
    constructor( private injector : Injector) {
        this.location = this.injector.get<Location>(Location);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this.localstore = this.injector.get<LocalStorageService>(LocalStorageService);
        this.http = this.injector.get<HttpService>(HttpService);
        this.router = this.injector.get<Router>(Router); 
        this._storeService = this.injector.get<DataStoreService>(DataStoreService);
        this._CookieService = this.injector.get<CookieService>(CookieService);
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._dialog = this.injector.get<MatDialog>(MatDialog);        
        this.checkRoleArr.push('Central Policy Staff');              
        this.shareduploadService = this.injector.get<UploadSharedService>(UploadSharedService);
    }
    /**
     * Get all Resources for Logged in User - Cached user info
     * @param path - Module name or Screen Name
     */
    public initAuthService(path: string){
       return this._commonService.getArrayList(
                {
                    where: { 'path': path },
                    method: 'get',
                    nolimit: true
                },
                AppConfig.getUserRolesUrl + '?filter'
            )
    }

    public setAuthDetail(path: string, result: any) {
        this.permissionsData.set({});
        const resources = result?.[0]?.resources ?? {};
        const newPermissions: Record<string, any> = {};

        let finalOutput: any = {};

        for (const key of Object.keys(resources)) {
            const r = resources[key];

            finalOutput = {
                isvisible: r?.isvisible ?? true,
                isallowed: r?.isallowed ?? true,
                isenabled: r?.isenabled ?? false
            };

            newPermissions[key] = Object.keys(finalOutput).length ? finalOutput : this.getPermission(path, key);
        }

        if (Object.keys(resources).length > 0) {
            this.permissionsData.set(newPermissions);
        }
    }

    getPermission(path: string, resource: string) {
        const map = this.permissionsData();
        const data = map?.[resource] ?? {
            isvisible: true,
            isallowed: true,
            isenabled: true
        };

        return data;
    }
    
    /**
     * Return true if key is not present Bydefault all will be avilable
     * if Key found then return what ever has been configure
     * @param path
     * @param resource
     */
    public isView(path: string,resource: string){
        return this.getPermission(path, resource).isvisible;
    }
    /**
     * Return true if key is not present Bydefault all will be avilable
     * if Key found then return what ever has been configure
     * @param path
     * @param resource
     */
    public isEdit(path: string,resource: string){
        return this.getPermission(path, resource).isallowed;
    }
    /**
     * Return true if key is not present Bydefault all will be avilable
     * if Key found then return what ever has been configure
     * If in database isenabled flag is true then the button should not be disabled.
     * We are using inbuilt disabled property, which disable button if value of the resource isenabled is false
     * @param path
     * @param resource
     */
    public isDisabled(path: string,resource: string){
        return !this.getPermission(path, resource).isenabled;
    }

        /**
     * Return false if key is not present Bydefault all will be unavilable
     * if Key found then return what ever has been configure
     * If in database isenabled flag is true then the button should be enabled.
     * We are using inbuilt disabled property, which disable button if value of the resource isenabled is false
     * @param path
     * @param resource
     */
    public isEnabled(path: string,resource: string){
        return this.getPermission(path, resource).isenabled;
    }

    public isModuleAccessable(path: string,resource: string){
        const isallowed = this.isEdit(path,resource);
        if(!isallowed) {
            this._alertService.error('User does not have access to view ' + path +' module. Please contact admin.');
        }
        return isallowed;
    }

        /**
     * Return true if key is not present Bydefault all will be avilable
     * if Key found then return what ever has been configure
     * @param path
     * @param resource
     */
    public isPersonSubTabViewable(path: string,resource: string){
        const isView = this.storage.getItem('isView');
        const secData = this.permissionsData();
        let isModuleviewable = false;
        if (secData && secData[resource] && secData[resource].isvisible != null) {
            isModuleviewable = secData[resource].isvisible;
        } else {
           isModuleviewable = true;
        }
        if (isModuleviewable || isView !== 'true') {
            return true;
        } else {
            if (this.checkActiveModuleAndRoles()) {
                return true;
            }
            return false;
        }
    }

    public callAPIToResetCokiesBackFromOpenAm() {
        this.http.post(`${AppConfig.roleProfileUrl}?filter=` + JSON.stringify({userid: this.getCurrentUser().userId})).subscribe();
    }

    private isBase64(str: string): any {
        // Basic check: valid base64 charset + padding rules
        if (/^[A-Za-z0-9+/=]+$/.test(str)) {
            return JSON.parse(decodeURIComponent(atob(str)));
        }

        return str;
    }

    // Verify JWT in localstorage with server & load user's info.
    // This runs once on application startup.
    public populate(returnUrl: string = '') {
       
        // const token = this.storage.getObj('token') as AppUser;
        const token = this.storage.getObj('token') ? this.isBase64(this.storage.getObj('token')) as AppUser : '';
        if (!token) {
            this.handleIfNoTokenFn();
            // }
        } else {
            const currentUser = this.getCurrentUser();
            if (Object.keys(currentUser).length === 0) {
                this.http.post(`${AppConfig.roleProfileUrl}?filter=` + JSON.stringify({userid: token.userId})).subscribe((user: AppUser) => {
                    token.role = user.role;
                    token.resources = user.resources;
                    this.isAuthenticatedSubject.next(true);
                    this.currentUserSubject.next({ ...token , ...user });
                    this.handleLocationPathFn(user);
                });
            }       
        }
    }
    // Assosiated with populate method
    private handleIfNoTokenFn() {
        if (location.pathname.indexOf(this.extassessment) === -1 && location.hash.indexOf(this.extassessment) === -1) {
            this.currentUserSubject.next({} as AppUser);
            // Set auth status to false
            this.isAuthenticatedSubject.next(false);
            // Remove any potential remnants of previous auth states
            this.router.navigate(['/login']);
        } else {
            if (location.pathname.indexOf(this.extassessment) !== -1) {
                this.router.navigate([location.pathname], { replaceUrl: true });
            } else {
                this.router.navigate([location.hash.replace('#', '')], { replaceUrl: true });
            }
        }
    }
    // Assosiated with populate method
    private handleLocationPathFn(user: AppUser) {
        if (this.location.path() !== '') {
            this.openAMlogin('', '').subscribe((response: any) => {
                if (response && response.id && response.role) {
                    localStorage.setItem('userProfile', JSON.stringify(response.user.userprofile));
                //     this.router.navigate([this.location.path()]);
                // } else {
                }
                this.router.navigate([this.location.path()]);
            });
        } else {
            if (user && user.role) {
                this.openAMlogin('', '').subscribe((response: any) => {
                    if (response && response.id && response.role) {
                        localStorage.setItem('userProfile', JSON.stringify(response.user.userprofile));
                    }
                    // } else {
                        this.roleBasedRoute(user.role.name.toLowerCase());
                    // }
                });
            }
        }
    }

    arrangeTeammemberassignment(token: any) {
        const teamMemberAssignment: any = token?.user?.userprofile?.teammemberassignment;
        if (teamMemberAssignment && teamMemberAssignment.length > 0) {
            token.user.userprofile.teammemberassignment = teamMemberAssignment[0];
        }
        return token;
    }

    checkActiveModuleAndRoles() {
        const user = this.arrangeTeammemberassignment(this.getCurrentUser());

        const activeModule = this.storage.getItem('activeModuleNav');
        const hasFamilyAccessToCase = this.storage.getItem('hasFamilyAccessToCase') === 'true';
        const casecountyid = this.storage.getItem('casecountyid');
        const usercounty = user?.user?.userprofile?.teammemberassignment?.teammember?.team?.countyid;
        const isCentralPolicyStaff =  user.resources.filter((menu: any) => menu.modulekey === AppConstants.ROLES.CWPS_CENTRAL_POLICY_STAFF.toLowerCase());
         //CIDM-10751 Disabling readonly access for users which are on case worker module and has family access (This fix is to address users who are unable make any changes at case level due central policy staff role )
        if ((activeModule == 'Case Work' && hasFamilyAccessToCase) || ((activeModule == '4E SPECIALIST' || activeModule == '4E SUPERVISOR') && isCentralPolicyStaff?.length) || (activeModule == 'Appeal Work' && casecountyid == usercounty) || (activeModule == 'Approve' && casecountyid == usercounty) || activeModule == 'Medical Specialist') {
            return true;
        }
    }

    public openAMlogin(email: string, pswd: string): Observable<AppUser> {
        const obj: any = {
            email: email.toLowerCase(),
            fromdevice: 1
        }
        obj[atob(decodeURIComponent('cGFzc3dvcmQ%3D'))]=pswd;
        return this.http.post('admin/userprofile/generateAccessToken', JSON.stringify(obj)).pipe(mergeMap(tokendata => {
            this.storage.setObj('token', tokendata);
            let token: any = JSON.parse(decodeURIComponent(atob(tokendata)));
            token = this.arrangeTeammemberassignment(token);
            // const teamMemberAssignment: any = token?.user?.userprofile?.teammemberassignment;
            // if (teamMemberAssignment && teamMemberAssignment.length > 0) {
            //     token.user.userprofile.teammemberassignment = teamMemberAssignment[0];
            // }
        //    this.currentUserSubject.next({ ...token });
            this.getLatestReleaseDate(token.user?.userprofile?.cwlastlogindatetime);         
            this.isAuthenticatedSubject.next(true);
            setTimeout(() => {
                this.getuserfailedfileupload();
            }, 1500);
            return this.http.post(`${AppConfig.roleProfileUrl}?filter=` + JSON.stringify({userid: token.userId})).pipe(map((user: AppUser) => {
                return this.updatePrimaryRole(token, user);
            }));
        }));
    }

    public login(email: string, password: string): Observable<AppUser> {
        return this.http.post(AppConfig.authTokenUrl, JSON.stringify({ email: email.toLowerCase(), password: password, fromdevice: 1 })).pipe(mergeMap((token: AppUser) => {
            this.storage.setObj('token', token)
            this.isAuthenticatedSubject.next(true);
            token = this.arrangeTeammemberassignment(token);
            // const teamMemberAssignment: any = token?.user?.userprofile?.teammemberassignment;
            // if (teamMemberAssignment && teamMemberAssignment.length > 0) {
            //     token.user.userprofile.teammemberassignment = teamMemberAssignment[0];
            // }
            this.currentUserSubject.next({ ...token });
            setTimeout(() => {
                this.getuserfailedfileupload();
            }, 1500);
            return this.http.post(`${AppConfig.roleProfileUrl}?filter=` + JSON.stringify({userid: this.getCurrentUser().userId})).pipe(map((user: AppUser) => {
                return this.updatePrimaryRole(token, user);
            }));
        }));
    }
    updatePrimaryRole(token: AppUser, user: AppUser) {
        token.role = user.role;
        token.resources = user.resources;
        const expungedUser = this.getCurrentUser()?.resources?.filter(item => item?.name === 'EXPUNGED_SEXUAL_ABUSE_DETAILS_VIEW').length ? 1 : 0;
        this.storage.setItem('IS_EXPUNGED_USER', expungedUser || 0);
        this.savePrimaryRole(user.role);
        token = this.arrangeTeammemberassignment(token);
        // const teamMemberAssignment: any = token?.user?.userprofile?.teammemberassignment;
        // if (teamMemberAssignment && teamMemberAssignment.length > 0) {
        //     token.user.userprofile.teammemberassignment = teamMemberAssignment[0];
        // }
        this.storage.setObj('token_withrole', btoa(encodeURIComponent(JSON.stringify(token))));
        this.currentUserSubject.next({ ...token, ...user });
        return token;
    }

    public async logout() {
        // tslint:disable-next-line:prefer-const
        const workEnv = config.workEnvironment;
        if (workEnv === 'state') {
            await this.invalidateToken();
            const logoutUrl = environment.logoutDHSURL;
            const win =  window.open(logoutUrl,'_blank',
                           `toolbar=0,
                            location=0,
                            status=0,
                            menubar=0,
                            scrollbars=0,
                            resizable=0,
                            left=0, 
                            top=0, 
                            screenX=0,
                            screenY=0,
                            width=1, 
                            height=1, 
                            visible=none`);
            if(win) {
                win.blur();
                window.focus();
                await this.invalidateToken();
                setTimeout(async () => {
                    win.close();
                    window.location.reload();
                }, 3000);
            }
        } else {
            this.invalidateToken();
        }
    }

    private invalidateToken() {
        return new Promise((resolve,reject) => {
            const workEnv = config.workEnvironment;
            this.http.post(AppConfig.logoutUrl).subscribe(
                response => {
                    this.router.routeReuseStrategy.shouldReuseRoute = function () {
                        return false;
                    };
                    if (workEnv === 'state') {
                        this._storeService.clearStore();
                        this.storage.clear();
                        this.localstore.clear();
                        resolve(true);
                    } else {
                        const currentUrl = 'login';
                        this.router.navigateByUrl(currentUrl).then(() => {
                            this.isAuthenticatedSubject.next(false);
                            this.currentUserSubject.next({} as AppUser);
                            this._storeService.clearStore();
                            this.storage.clear();
                            this.localstore.clear();
                            this.router.navigated = false;
                            this.router.navigate([currentUrl], { replaceUrl: true });
                            this.router.events.subscribe((event: any) => {
                                if (event instanceof NavigationEnd) {
                                    location.reload();
                                    resolve(true);
                                }
                            });
                        });
                    }
                },
                error => {
                    if (workEnv === 'state') {
                        this._storeService.clearStore();
                        this.storage.clear();
                        this.localstore.clear();
                    } else {
                        this.clearLogout();
                    }
                    resolve(true);
                }
            );
        });
    }

    public async performTimeout() {
        const workEnv = config.workEnvironment;
        const logoutURL = environment.logoutDHSURL;
        await this.invalidateToken();
        this._storeService.clearStore();
        this.storage.clear();
        this.localstore.clear();
        if (workEnv === 'state') {
            const gotoURL = window.location.protocol+"//"+window.location.host;
            window.location.replace(logoutURL+"&goto="+gotoURL);
        } else {
            location.reload();
        }
    }

    // Some time we lost header information of Open AM so the post call to clear user logged in information may not be
    // execute
    public clearLogout() {
        const workEnv = config.workEnvironment;
        this.storage.removeItem('token');
        this.storage.removeItem('fbToken');
        this._storeService.removeItem('PERSON_NAVIGATION_INFO');
        this.storage.removeItem('intake');
        this._storeService.removeItem('intake');

        if (workEnv === 'state') {
            window.location.reload();
            this._storeService.removeItem('PERSON_NAVIGATION_INFO');
            this.storage.removeItem('intake');
            this._storeService.removeItem('intake');
            // clear session storage properties in log out
            this.storage.removeItem('ISSERVICECASE');
            this.storage.removeItem('activeModuleNav');
            this._storeService.clearStore();
            this.storage.clear();
            this.localstore.clear();
            const logoutURL = environment.logoutDHSURL;
            if ( logoutURL) {
                window.location.replace(logoutURL);
            } else {
                location.reload();
            }

        } else {
            location.reload();
        }
    }

    private savePrimaryRole(userRole: any) {
        this.primaryRole = userRole;
    }

    public getCurrentUser(): AppUser {
        return this.currentUserSubject.value;
    }

    public isExpungementSuperUser():number {
        return parseInt(this.storage.getItem('IS_EXPUNGED_USER'));
    }

    private clearSessionroleswitching(newRole: any) {
        const temptoken = this.storage.getItem('token');
        const tempactiveModuleAgency = this.storage.getItem('activeModuleAgency');
        const tempfbtoken = this.storage.getItem('fbToken');
        const tempDynamsoftProductKey = this.storage.getItem("dynamsoftProductKey");
        this.storage.clear();
        this.storage.setItem('token', temptoken);
        this.storage.setItem('activeModuleAgency', tempactiveModuleAgency);
        this.storage.setItem('activeModuleNav', newRole.modulename);
        this.storage.setItem('activeModuleRole', newRole.rolename);
        this.storage.setItem('fbToken', tempfbtoken);
        this.storage.setItem('dynamsoftProductKey',tempDynamsoftProductKey);
        }

    public changeUserRole(newRole: any) {
        //Clearing session storage for user role change and restoring the session tokens for authentication.
        this.clearSessionroleswitching(newRole);
        this.getCurrentUser().role.name = newRole.rolename;
        this.getCurrentUser().role.key = newRole.rolekey;
        const userData: any = this.arrangeTeammemberassignment(this.getCurrentUser());
        this.currentUserSubject.next(userData);
    }
    public changeUserRoleWithout(newRole: any) {
        //restoring the rolename and rolekey
        this.getCurrentUser().role.name = newRole.rolename;
        this.getCurrentUser().role.key = newRole.rolekey;
        const userData: any = this.arrangeTeammemberassignment(this.getCurrentUser());
        this.currentUserSubject.next(userData);
    }

    public isDevice(): boolean {
        return this.storage.getObj('isDevice');
    }

    public roleBasedRoute(roleName: string) { //SonarQube - code complexity fix
        let navigatePath = this.homepath;
        if (['superuser','cru','intake worker'].includes(roleName.toLowerCase())) {
            navigatePath = this.intakepath;
        } else if ([AppConstants.ROLES.CASE_WORKER,
                    'case worker',
                    AppConstants.ROLES.LDSS_DIRECTOR.toLowerCase(),
                    AppConstants.ROLES.LDSS_RESOURCE_WORKER.toLowerCase(),
                    AppConstants.ROLES.LDSS_SUPERVISOR.toLowerCase(),
                    AppConstants.ROLES.LDSS_HOMESTUDY_WORKER.toLowerCase(),
                    AppConstants.ROLES.LDSS_RECRUITER_TRAINER.toLowerCase(),
                    AppConstants.ROLES.APPEAL_USER.toLowerCase()].includes(roleName)) {
            navigatePath = this.homepath;
        } else if ([AppConstants.ROLES.SUPERVISOR,
                    AppConstants.ROLES.KINSHIP_SUPERVISOR.toLowerCase(),
                    'case management supervisor',
                    AppConstants.ROLES.PROVIDER,
                    'cwfs'].includes(roleName)) {
            navigatePath = this.cjamspath;
        } else if (roleName === AppConstants.ROLES.KINSHIP_SUPERVISOR.toLowerCase()) {
            navigatePath = '/pages/cjams-dashboard/cw-intake-referals';
        } else if (roleName === AppConstants.ROLES.COURT_WORKER.toLowerCase()) {
            navigatePath = '/pages/sao-dashboard';
        } else if (roleName === AppConstants.ROLES.IV_E_WORKER) {
            navigatePath = '/pages/notification';
        } else if (roleName === 'iv-e specialist') {
            navigatePath = '/pages/title4e/worker4e';
        } else if (roleName === 'iv-e eligibility analyst') {
            navigatePath = '/pages/title4e/analyst4e';
        } else if (roleName === 'iv-e supervisor') {
            navigatePath = '/pages/title4e/supervisor4e';
        } else if (roleName === 'iv-e eligibility administrator') {
            navigatePath = '/pages/title4e/admin4e';
        } else if (roleName === 'iv-e eligibility administrator assistant') {
            navigatePath = '/pages/title4e/assistadmin4e';
        } else if (roleName === 'iv-e eligibility quality assurance') {
            navigatePath = '/pages/title4e/qa4e';
        } else if ([AppConstants.ROLES.FINANCE_WORKER.toLowerCase(),
                    AppConstants.ROLES.LDSS_FISCAL_SUPERVISOR.toLowerCase(),
                    AppConstants.ROLES.CENTRAL_OFFICE_FISCAL.toLowerCase(),
                    AppConstants.ROLES.CENTRAL_OFFICE_SUPERVISOR.toLowerCase()].includes(roleName.trim().toLowerCase())) {
            navigatePath = this.financepath;
        } else if (roleName === AppConstants.ROLES.DIRECTOR_OF_FINANCE.toLowerCase()) {
            navigatePath = '/pages/finance/finance-dashboard/director-approval';
        } else if (roleName === AppConstants.ROLES.DHS_LEGAL_ATTORNEY.toLowerCase()) {
            navigatePath = '/pages/case-search/list';
        }
        this.router.navigate([navigatePath]);
    }

    public getAgencyName() {
        if(this.getCurrentUser()?.role?.teamtypekey){
            if (this.getCurrentUser().role.teamtypekey === 'IV-E') {
                return 'CW';
            }
            if (this.getCurrentUser().role.teamtypekey === 'FNS') {
                return 'CW';
            }
            return this.getCurrentUser().role.teamtypekey;
        }
        else if(this.getCurrentUser()?.user?.userprofile){
            if (this.getCurrentUser().user.userprofile.teamtypekey === 'IV-E') {
                return 'CW';
            }
            if (this.getCurrentUser().user.userprofile.teamtypekey === 'FNS') {
                return 'CW';
            }
            return this.getCurrentUser().user.userprofile.teamtypekey;
        }
        return 'CW';
    }

    public isDJS() {
        return this.getAgencyName() === 'DJS';
    }

    public isCW() {
        return this.getAgencyName() === 'CW';
    }

    public isAS() {
        return this.getAgencyName() === 'AS';
    }

    public selectedRoleIs(roleName: string): boolean {
        let roleFound = false;
        const userInfo = this.getCurrentUser();
        if (userInfo && userInfo.role && userInfo.role.name) {
            roleFound = userInfo.role.name === roleName;
        }
        return roleFound;
    }

    public isLoggedIn() {
        return this.storage.getItem('token') ? true : false;
    }

    hasModuleAccess(key: string): boolean {
        const user = this.getCurrentUser();
        if (key && user?.resources?.length > 0) {
            const resources = user.resources.filter(menu => menu.isallowed === true);
            if (hasMatch([key], resources.map(item => (item ? item.name : '')))) {
                return true;
            }
            return false;
        }
        return false;
    }

    hasAccess(key: string): Observable<boolean> {
        return this.currentUser.pipe(map(user => {
            if (key && user?.resources?.length > 0) {
                const resources = user.resources.filter(menu => menu.isallowed === true);
                if (hasMatch([key], resources.map(item => (item ? item.name : '')))) {
                    return true;
                }
                return false;
            }
            return false;
        }));
    }
    readonlyPage(readOnlykey: string, overRideKey: string, forms: FormGroup[]) {
         const user: any = this.getCurrentUser();
         const resources: any[] = user.resources ?? [];

         if (hasMatch([readOnlykey], resources.map(item => (item ? item.name : '')))) {
           if (hasMatch([overRideKey], resources.map(item => (item ? item.name : '')))) {
              return;
           } else {
            if (this.checkActiveModuleAndRoles()) {
                return true;
            }
             forms.forEach((form) => { form.disable(); });
           }
         }
    }
    readonlyButton(readOnlykey: string, overRideKey: string) {
        const user: any = this.getCurrentUser();
        const resources: any[] = user.resources || [];

     if(resources){
        if (hasMatch([readOnlykey], resources.map(item => (item ? item.name : '')))) {
          if ((hasMatch([overRideKey], resources.map(item => (item ? item.name : '')))) || this.checkActiveModuleAndRoles()) {
             return true;
          } else {
            return false;
          }
        }
     } 
        return true;
   }
   isVissbleButton(readOnlykey: string, overRideKey: string) {
    const user: any = this.getCurrentUser();
    const resources: any[] = user.resources || [];
    const activeModule = this.storage.getItem('activeModuleNav');
    const isCentralPolicyStaff = resources.filter(menu => menu.modulekey === AppConstants.ROLES.CWPS_CENTRAL_POLICY_STAFF.toLowerCase());

    if(isCentralPolicyStaff && activeModule == 'Finance') {
        return true;
    }
    if (hasMatch([readOnlykey], resources.map(item => (item ? item.name : '')))) {
      return false;
    }
    return true;
   }

   public addReadOnlyResource() {
    const resource: any = {
        'id': null,
        'parentid': null,
        'name': 'read_only_access',
        'parentkey': null, 'modulekey': null,
        'resourceid': 'Validation', 'resourcetype': 1,
        'description': 'read_only_access', 'isallowed': true, 'isvisible': true, 'isenabled': true};
    this.getCurrentUser().resources.push(resource);
   }

   public addmoduleReadOnlyResource(module_readonly_resource: any) {
    const resource: any = {
        'id': null,
        'parentid': null,
        'name': module_readonly_resource,
        'parentkey': null, 'modulekey': null,
        'resourceid': 'Validation', 'resourcetype': 1,
        'description': module_readonly_resource, 'isallowed': true, 'isvisible': true, 'isenabled': true};
    this.getCurrentUser().resources.push(resource);
   }

    public removeReadOnlyResource(type: string) {
        const index = this.getCurrentUser().resources.findIndex(item => item.name === type);
        if (index !== -1) { this.getCurrentUser().resources.splice(index, 1); }
    }

   public addRemoveReadOnlyResources(casetype: string){
       let resources;
        if(casetype === 'INVESTIGATION'){
            resources = this.getCurrentUser().resources.filter(menu => menu.name === 'investigation_read_only_access' && menu.isallowed === true);
        }
        else if(casetype === 'INTAKE'){
            resources = this.getCurrentUser().resources.filter(menu => menu.name === 'intake_read_only_access' && menu.isallowed === true);
        }
        else if(casetype === 'SERVICECASE'){
            resources = this.getCurrentUser().resources.filter(menu => menu.name === 'servicecase_read_only_access' && menu.isallowed === true);
        }
        else if(casetype === 'ADOPTION'){
            resources = this.getCurrentUser().resources.filter(menu => menu.name === 'adoptioncase_read_only_access' && menu.isallowed === true);
        }
        else if(casetype === 'FINANCE'){
            resources = this.getCurrentUser().resources.filter(menu => menu.name === 'finance_read_only_access' && menu.isallowed === true);
        }
        if(resources && resources.length > 0) {
            this.addReadOnlyResource();
        }
   }

   public addReadOnlyResources(checkType: string){
     let resources;
     if(checkType==='ive'){
        resources = this.getCurrentUser().resources.filter(menu => menu.name === 'ive_read_only_access');
     } else  if(checkType==='gap'){
        resources = this.getCurrentUser().resources.filter(menu => menu.name === 'gap_read_only_access');
     }

     if(resources && resources.length > 0) {
        this.addReadOnlyResource();
     }
   }

   public hasAccessToCase(resourcename: string){
    const user = this.getCurrentUser();
    const resources = user?.resources?.filter(menu => menu.name === resourcename) ?? [];
    return !(resources && (resources.length > 0));
   }

   public removeReadOnly() {
    const user = this.getCurrentUser();
    const resources: any[] = user?.resources?.filter(menu => menu.name !== 'read_only_access') ?? [];
    this.getCurrentUser().resources = resources;
   }

   public setReadOnlyBasedOnRole() {
      const rolename = this.getCurrentUser()?.role ? this.getCurrentUser().role.name : '';
      if (rolename === 'Central Policy Staff') {
        this.addReadOnlyResource();
      }
   }

   public setIntakeReadOnly(forms: FormGroup[]) {
            const view = this._storeService.getData(IntakeStoreConstants.reviewstatus);
            if (view?.status === 'Approved') {
               this._storeService.setData('isView', true);
               forms.forEach((form) => { form.disable(); });
            } else {
                this._storeService.setData('isView', false);
            }
   }

   iscaseclosed(module: string,) {
        const intakecurrentStatus = this._storeService.getData(IntakeStoreConstants.INTAKE_STATUS);
        const da_status = this.storage.getItem('da_status');
        const isView = this.storage.getItem('isView');
        const currentUser = this.getCurrentUser();
        const userrole = currentUser?.role ? currentUser.role.name : '';
        const moduleExist = this.editAllowedModulesList.filter(allowedmodule => allowedmodule === module);
        const roleExist = this.editAllowedRolesList.filter(allowedrole => userrole === allowedrole);
        const isclosedcaseeditable = this.hasModuleAccess('closed_servicecase_fullaccess');
        if(isView && isView === 'true') {
            return true;
        } else {
            if ((['Closed','Completed'].includes(da_status) || ['Closed','Completed','Accepted'].includes(intakecurrentStatus))
                && !(moduleExist.length && (roleExist.length || isclosedcaseeditable))) {
                    return true;
            } else {
                  return false;
            }
        }
    }

   public hasSupervisor() {
       let supervisorid: any = this.getCurrentUser().user.userprofile.supervisorid;

       if (supervisorid) {
           return true;
       } else {
           if(this.getCurrentUser().user.userprofile.teammemberassignment){
            const teamassignment = this.arrangeTeammemberassignment(this.getCurrentUser()).user.userprofile.teammemberassignment;
            supervisorid = teamassignment?.teammember ? teamassignment.teammember.supervisorid : null;
            if (supervisorid) {
                return true;
            }
           }
           if (this.getAgencyName() === 'CW' && this.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) {
            (<any>$('#no-supervisor')).modal('show');
           }
           return false;
       }
   }

    getLatestReleaseDate(cwlastlogindatetime: any) {
        this._commonService
            .getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                'releasenotes/getlatestreleaseinfo?filter'
            )
            .subscribe(response => {
                if (response && response.length > 0){
                    const releaseflag = response[0].releaseflag;
                    if (releaseflag){
                        (<any>$('#release-popup')).modal('show');
                    }
                }
            });
    }

    getuserfailedfileupload() {
        const inputreq = {
            userid: this.getCurrentUser().user?.securityusersid,
        };
        this.uploadfailedfiles = [];
        this._commonService
        .getArrayList(
            {
                where: inputreq,
                method: 'get',
                page: 1,
                limit: 10
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.FailedAttachmentGridUrl
        )
        .subscribe((response: any) => {            
            this.uploadfailedfiles = response[0].getuploadfailedattachments;
            const refreshuploadfiles = this.storage.getItem('refreshuploadfiles');
            if(refreshuploadfiles && refreshuploadfiles.length > 0) {
                this.shareduploadService.setUploadFileProgress(JSON.parse(refreshuploadfiles));
                this.storage.setItem('refreshuploadfiles', null);
            }else{
                if(this.uploadfailedfiles && this.uploadfailedfiles.length > 0) {
                    this.shareduploadService.setUploadFileProgress(this.uploadfailedfiles);
                    (<any>$('#upload-failed-alert')).modal('show');
                }
            }            
            }
        );
    }

    checkIfReloaded() {
        const perfEntries:any = performance.getEntriesByType('navigation');
        if (perfEntries.length > 0 && (perfEntries[0] as any).type === 'reload') {
            // This code runs only if it's a page reload
            localStorage.setItem('showReloadWarning', 'true');
        }
    }
}
