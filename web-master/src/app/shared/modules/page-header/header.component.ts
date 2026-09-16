
import {map} from 'rxjs/operators';
import { Component, OnInit, Directive, HostListener, EventEmitter, Output, ElementRef, ChangeDetectorRef, Injector } from '@angular/core';
import { ActivatedRoute, NavigationEnd, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { Location } from '@angular/common';
import { AppConstants } from '../../../@core/common/constants';
import { hasMatch } from '../../../@core/common/initializer';
import { AppUser, UserProfile } from '../../../@core/entities/authDataModel';
import { AuthService, CommonHttpService, DataStoreService, SessionStorageService, AlertService } from '../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../pages/case-worker/case-worker-url.config';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { NgxfUploaderService, UploadStatus } from 'ngxf-uploader';
import { AppConfig } from '../../../app.config';
import { HttpHeaders } from '@angular/common/http';
import { UserRoleProfile } from '../../../pages/admin/user-security-profile/_entites/user-security-profile.data.modal';
import * as appSettingsJson from '../../../../environments/version.json';
import moment from 'moment';
import { UploadSharedService } from '../../../@core/services/upload-shared.service';

declare var $: any;

@Directive({
    selector: 'div[clickoutside]',
    standalone: false
})
export class ClickOutside {
    @Output() outsidetrigger = new EventEmitter<MouseEvent>();
    constructor(private elementRef: ElementRef, private changeDetectorRef: ChangeDetectorRef) { }
    @HostListener('document:click', ['$event']) clickedOutside(event: MouseEvent): void {
        const targetElement = event.target as HTMLElement;
        if (targetElement && !this.elementRef.nativeElement.contains(targetElement)) {
            this.outsidetrigger.emit(event);
        }
    }
}
@Component({
    selector: 'app-header',
    templateUrl: './header.component.html',
    styleUrls: ['./header.component.scss'],
    standalone: false
})
export class HeaderComponent implements OnInit {
    pushRightClass = 'push-right';
    userInfo: AppUser = new AppUser();
    today = Date.now();
    role = '';
    numberoftickets:any;
    agency = '';
    totalNotificationCount = 10;
    totalExternalNotificationCount = 10;
    showNotification = false;
    showExternalNotification = false;
    isPreIntake = false;
    dashBoardLink = '';
    isDjs = false;
    roleName:any;
    ROLES = AppConstants.ROLES;
    feedbackUser: UserProfile = new UserProfile();
    curDate!: Date;
    feedbackForm!: FormGroup
    supportNo!: number;
    fileUploaded: any;
    reports: any;
    nytdreport: any;
    modulecoll = false;
    logout = false;
    activeModule = '';
    activeModuleNavAccess = [];
    allowedModules: any[] = [];
    imagefile: any;
    public imagePath: any;
    imgURL: any;
    isUploading = false;
    uploadedFile: any[] = [];
    isAttachType = '';
    isCate = 'CW-CJAMS';
    issubCate= 'CW-Other Document';
    attachmenttype= 'case';
    addUpdateUserProfile: UserRoleProfile = new UserRoleProfile();
    user!: { userphoto: any; };
    appSettings = appSettingsJson;
    isMenu: boolean = false;
    isFacilitator: boolean = false;
    isIVESupversiororNot: boolean = false;
    financeimg = 'finance.png';
    financeapproval = 'Finance Approval';
    paymentimg = 'payment.png';
    homestudyimg = 'home-study.png';
    licensecoordinatorrole = 'Licensing Coordinator';
    qacoordinatorrole = 'QA Coordinator';
    adminauditmonitorrole = 'Admin Audit Monitor CQI';
    dashboardpath = '/pages/home-dashboard';
    defaultDashboardpath = '/pages/default-dashboard';
    psychotropicreviewuser: boolean = false;
    beaconreviewuser: boolean= false;
    isPolicyStaffUser: boolean= false;
    psychotropiccounty: any;


    public router: Router;
    private _authService: AuthService;
    private _service: CommonHttpService;
    private _dataStoreService: DataStoreService;
    private _sessionStorage: SessionStorageService;
    private _uploadService: NgxfUploaderService;
    private _formBuild: FormBuilder;
    private _alert: AlertService;
    private location: Location;
    private ref: ChangeDetectorRef;
    private readonly route: ActivatedRoute = new ActivatedRoute;
    private shareduploadService: UploadSharedService;
    countyname: any;
    showpsychotropictab = false;
    uploadfailedfiles = [];
    pendingDocs: any;
        

    constructor(private injector : Injector) {
        this.router = this.injector.get<Router>(Router);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._service = this.injector.get<CommonHttpService>(CommonHttpService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
        this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
        this._formBuild = this.injector.get<FormBuilder>(FormBuilder);
        this._alert = this.injector.get<AlertService>(AlertService);
        this.shareduploadService = this.injector.get<UploadSharedService>(UploadSharedService);
        this.location = this.injector.get<Location>(Location);
        this.ref = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);

        this.router.events.subscribe(val => {
            if (val instanceof NavigationEnd && window.innerWidth <= 992 && this.isToggled()) {
                this.toggleSidebar();
            }
        });
    }

    ngOnInit() {
        this.userInfo = this._authService.getCurrentUser();

        //CIDM-7561  Not able to load IVE cases from dashboard
        if(this.userInfo && this.userInfo.role && this.userInfo.role.name) {
           this.roleName = this.userInfo.role.name;
        }
        if (this.userInfo && this.userInfo.user && this.userInfo.user.userprofile && this.userInfo.user.userprofile.userphoto) {
          this.imgURL = this.userInfo.user.userprofile.userphoto;
        }

        //Faciliator Login Validation
        this.isFacilitator = this.userInfo?.role && (this.userInfo.role.name === 'CJAMS_SSA_FTDM_FACILITATOR' || this.userInfo.role.name === 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || this.userInfo.role.name === 'CJAMS_SSA_FTDM_QI_SUPERVISOR');
                //psychotropic cordinator , pharmacist  validation
        try {
            if (!this.userInfo?.role && this._sessionStorage.getObj('token_withrole')) {
                this.userInfo = this.isBase64(this._sessionStorage.getObj('token_withrole'));
            }
        } catch (error) {
            console.error('An error occurred while parsing the user info:', error);
            // Handle the error, maybe set a default value or notify the user
        }
        if(this.userInfo?.resources?.some(resource => resource.name === 'BEACON_DOL_ALLOW_ACCESS')){
            this.beaconreviewuser=true;
        }
        //psychotropic cordinator , pharmacist  validation
        if(this.userInfo?.role && (this.userInfo?.role?.name ==='CJAMS_CW_PSYCH_COORDINATOR'
         || this.userInfo?.role?.name ==='CJAMS_CW_PSYCH_PHARMACIST'
         || this.userInfo?.role?.name === 'CJAMS_CW_PSYCH_PSYCHIARIST'))
        {
            this.psychotropicreviewuser  =true;
            if (this.psychotropicreviewuser ===true){
                this.router.navigate(['/pages/psychotropicprescription-review'], { relativeTo: this.route });

            }
        }

        this.getNotificationTicketsCount();
        this.handleActiveModuleNavFn();
        this.getUserCounty();
    }

    private isBase64(str: string): any {
        // Basic check: valid base64 charset + padding rules
        if (/^[A-Za-z0-9+/=]+$/.test(str)) {
            return JSON.parse(decodeURIComponent(atob(str)));
        }

        return str;
    }

    // Assosiated to ngOnInit method
    private handleActiveModuleNavFn() {
        if (!this._sessionStorage.getItem('activeModuleNav')) {
            this.sessionStorageSetCondition();
        } else {
            this.activeModule = this._sessionStorage.getItem('activeModuleNav');
            this.role = this._sessionStorage.getItem('activeModuleRole');
            this.agency = this._sessionStorage.getItem('activeModuleAgency');
        }
        if(this._sessionStorage.getItem('FROM_REPORT')){
            setTimeout(() => this.setActiveModules(),2000);
        } else {
        this.setActiveModules();
        }
        if (this.role === 'SCRNW') {
            this.isPreIntake = true;
        }

        this._dataStoreService.currentStore.subscribe(notify => {
            if (notify['notification'] === true) {
                this.getNotificationCount();
            }
        });
        this.setDashBoardLink();
        this.reports = environment.reports;
        this.nytdreport = '#/pages/nytd-extract';
        const expungedUser = this._authService.getCurrentUser()?.resources?.filter(item => item?.name === 'EXPUNGED_SEXUAL_ABUSE_DETAILS_VIEW').length ? 1 : 0;
        this._sessionStorage.setItem('IS_EXPUNGED_USER', expungedUser || 0);
    }

    private sessionStorageSetCondition() {
        this._sessionStorage.setItem('activeModuleNav', this.activeModule);
        this.initializeForm();
        if (this.userInfo && this.userInfo.role) {
            this.sessionStorageSetIfCondition();
            this.getNotificationCount();
        }
    }

    private sessionStorageSetIfCondition() {
        if (this.userInfo.role && this.userInfo.role.name) {
            this.role = this.userInfo.role.name;
        }
        if (this.userInfo.user && this.userInfo.user.userprofile) {
            if (this.userInfo.role.teamtypekey === 'IV-E') {
                this.agency = 'CW';
            } else {
                this.agency = this.userInfo.role && this.userInfo.role.teamtypekey ? this.userInfo.role.teamtypekey : this.userInfo.user.userprofile.teamtypekey;
            }
            this._sessionStorage.setItem('activeModuleAgency', this.agency);
        }
    }

    ngAfterContentChecked() {
        this.ref.detectChanges();
    }

    setActiveModules() {

        //@Simar: This was already hardcoded here, just adding the rolekey as just rolename is not enough when switching to different module context
        // We should move this module access logic to backend as doing it on the header component is neither secure nor re-usable
        if (this.hasModuleAccess('Help') || this.hasModuleAccess('New')) {
            this.allowedModules.push({ modulename: 'Intake', image: 'intake.png', rolename: 'Intake Worker', rolekey: 'CWIW' });
        }
        if (this.hasModuleAccess('Validation') || this.hasModuleAccess('CaseWork Dashboard')) {
            this.allowedModules.push({ modulename: 'Case Work', image: 'case-work.png', rolename: 'field', rolekey: 'CWCW' });
        }
        // Approval Tab check
        this.approvalTabModuleAllowCheckFn();
        // FTDM Module check
        this.ftdmModuleAllowCheckFn();
        if (this.hasModuleAccess('QUALIFIED_INDIVIDUAL_Worker')) {
            this.allowedModules.push({ modulename: 'Qualified Individual', image: 'Qualifiedworker.png', rolename: 'CJAMS_SSA_QUALIFIED_INDIVIDUAL', rolekey: 'QUINW' });
        }
        this.financeModuleAllowCheckFn();
        if (this.hasModuleAccess('central_policy_staff')) {
            this.commonAllowedModulePushFn('Policy Staff',this.homestudyimg,'CWPS',AppConstants.ROLES.CJAMS_CENTRAL_POLICY_STAFF);
        }
        if (this.hasModuleAccess('Medical Specialist')) {
            this.allowedModules.push({ modulename: 'Medical Specialist', image: 'medical_specialist.svg', rolename: this.role });
        }
        if (this.hasModuleAccess('SSA_Placement_Manager')) {
           this.allowedModules.push({ modulename: 'SSA Placement Manager', image: 'approve.png',  rolename: AppConstants.ROLES.SSA_Placement_Manager });
        }
        if (this.hasModuleAccess('Legal Rep-Agency Attorney')) {
            this.commonAllowedModulePushFn('Legal Rep',this.homestudyimg,'CWLR',AppConstants.ROLES.CJAMS_Legal_Rep);
        }
        if (this.hasModuleAccess('Independent Living Coordinator')) {
            this.commonAllowedModulePushFn('Independent Living',this.homestudyimg,'CWIL',AppConstants.ROLES.CJAMS_Independent_Living);
        }
        if (this.hasModuleAccess('Executive')) {
            this.allowedModules.push({ modulename: 'Executive', image: this.homestudyimg, rolekey: 'CWEXE', rolename: 'Executive' });
        }
        if (this.hasModuleAccess(this.licensecoordinatorrole)) {
            this.allowedModules.push({ modulename: this.licensecoordinatorrole, image: this.homestudyimg, rolekey: 'CWLC', rolename: this.licensecoordinatorrole });
        }
        if (this.hasModuleAccess(this.qacoordinatorrole)) {
            this.allowedModules.push({ modulename: this.qacoordinatorrole, image: this.homestudyimg, rolekey: 'CWQAC', rolename: this.qacoordinatorrole });
        }
        if (this.hasModuleAccess(this.adminauditmonitorrole)) {
            this.allowedModules.push({ modulename: this.adminauditmonitorrole, image: this.homestudyimg, rolekey: 'CWQAC', rolename: this.adminauditmonitorrole });
        }

        this.checkCitizensReviewBoardAndPsychotropicFn();

        // IV Module check
        this.ivModuleAllowCheckFn();

        this.getActiveModuleFn();
        this.removeReadOnlyAccess();
        this._sessionStorage.setItem('activeModuleNav', this.activeModule);
        this._sessionStorage.setItem('activeModuleRole', this.role);
    }

    private approvalTabModuleAllowCheckFn() {
        if (this.hasModuleAccess('Appeal Coordinator')) {
            this.allowedModules.push({ modulename: 'Appeal Work', image: 'appeal-work.png', rolename: 'APPEALCO', rolekey: 'CWCW' });
        }
        if (this.hasModuleAccess('Approval Inbox')) {
            this.allowedModules.push({ modulename: 'Approve', image: 'approve.png', rolename: 'apcs', rolekey: 'CWSP' });
            this.allowedModules.push({ modulename: 'Reports', image: 'report.png', rolename: 'apcs', rolekey: 'CWSP' });
        }
    }

    private ftdmModuleAllowCheckFn() {
        if (this.hasModuleAccess('FTDM_Facilitator_Worker')) {
            this.allowedModules.push({ modulename: 'FTDM Facilitator', image: 'FTDM.png', rolename: 'CJAMS_SSA_FTDM_FACILITATOR', rolekey: 'FTDMFW' });
        }
        if (this.hasModuleAccess('FTDM_QI_SUPERVISOR')) {
            this.allowedModules.push({ modulename: 'FTDM/QI Supervisor', image: 'Qi1Supervisor.png', rolename: 'CJAMS_SSA_FTDM_QI_SUPERVISOR', rolekey: 'FTDMQIS' });
        }
    }

    private financeModuleAllowCheckFn() {
        if (this.hasModuleAccess('Central Finance')) {
            this.allowedModules.push({ modulename: 'Finance', image: this.financeimg, rolekey: 'FNSCOFW', rolename: AppConstants.ROLES.FINANCE_WORKER });
        }
        if (this.hasModuleAccess('Central Finance Approval')) {
            this.commonAllowedModulePushFn(this.financeapproval,this.paymentimg,'FNSCOFS',AppConstants.ROLES.LDSS_FISCAL_SUPERVISOR);
        }
        if (this.hasModuleAccess('Finance')) {

            if (this.role && this.role.toLowerCase().trim() === AppConstants.ROLES.CENTRAL_OFFICE_FISCAL.toLowerCase()) {
                this.commonAllowedModulePushFn('Finance',this.financeimg,'COFW',AppConstants.ROLES.CENTRAL_OFFICE_FISCAL);
            } else {
                this.commonAllowedModulePushFn('Finance',this.financeimg,'FNSFW',AppConstants.ROLES.FINANCE_WORKER);
            }

        }
        if (this.hasModuleAccess(this.financeapproval)) {
            if (this.role && (this.role.toLowerCase().trim() === AppConstants.ROLES.CENTRAL_OFFICE_SUPERVISOR)) {
                this.commonAllowedModulePushFn(this.financeapproval,this.paymentimg,'COFS',AppConstants.ROLES.CENTRAL_OFFICE_SUPERVISOR);
            } else {
                this.commonAllowedModulePushFn(this.financeapproval,this.paymentimg,'FNSFS',AppConstants.ROLES.LDSS_FISCAL_SUPERVISOR);
            }

        }
    }

    private commonAllowedModulePushFn(modulename: string, image: string, rolekey: string, rolename: string) {
        this.allowedModules.push({ modulename: modulename, image: image, rolekey: rolekey, rolename: rolename });
    }

    private checkCitizensReviewBoardAndPsychotropicFn() {
        if (this.hasModuleAccess('Citizens_Review_Board_for_Children')) {
            this.allowedModules.push({ modulename: 'Citizens Review Board For Children', image: 'case-work.png', rolekey: 'CWCRBFC', rolename: AppConstants.ROLES.Citizens_Review_Board });
        }
        if (this.hasModuleAccess('Psychotropic_Pharmacist_Review')) {
            this.allowedModules.push({ modulename: 'Psychotropic Pharmacist Review', image: 'case-work.png', rolekey: 'CWPSYPHARM', rolename: AppConstants.ROLES.PSYCH_PHARMACIST });
        }
        if (this.hasModuleAccess('Psychotropic_Psychiarist_Review')) {
            this.allowedModules.push({ modulename: 'Psychotropic Psychiarist Review', image: 'case-work.png', rolekey: 'CWPSYPSYCH', rolename: AppConstants.ROLES.PSYCH_PSYCHIARIST });
        }
        if (this.hasModuleAccess('Psychotropic_Coordinator_Review')) {
            this.allowedModules.push({ modulename: 'Psychotropic Coordinator Review', image: 'case-work.png', rolekey: 'CWPSYCOORD', rolename: AppConstants.ROLES.PSYCH_COORDINATOR });
        }
    }

    private ivModuleAllowCheckFn() {
        if (this.hasModuleAccess('IV-E SUPERVISOR')) {
            this.isIVESupversiororNot = true;
            this.allowedModules.push({ modulename: '4E SUPERVISOR', image: '4e.png', rolename: 'IV-E Supervisor', rolekey: 'IVESV'});
        }
        if (this.hasModuleAccess('IV-E SPECIALIST')) {
            this.isIVESupversiororNot = false;
            this.allowedModules.push({ modulename: '4E SPECIALIST', image: '4e.png', rolename: 'IV-E Specialist', rolekey: 'IVESP' });
        }
        if (this.hasModuleAccess('IV-E Eligibility Administrator')) {
            this.allowedModules.push({ modulename: '4E Adminstrator', image: '4e.png', rolename: 'IV-E Eligibility Administrator', rolekey: 'IVEADMIN' });
        }
        if (this.hasModuleAccess('IV-E Eligibility Administrator Assistant')) {
            this.allowedModules.push({ modulename: '4E AdminAssist', image: '4e.png', rolename: 'IV-E Eligibility Administrator Assistant', rolekey: 'IVEAA' });
        }
        if (this.hasModuleAccess('IV-E Eligibility Analyst')) {
            this.allowedModules.push({ modulename: '4E Analyst', image: '4e.png', rolename: 'IV-E Eligibility Analyst', rolekey: 'IVEEA' });
        }
        if (this.hasModuleAccess('IV-E Eligibility Quality Assurance')) {
            this.allowedModules.push({ modulename: '4E QA', image: '4e.png', rolename: 'IV-E Eligibility Quality Assurance', rolekey: 'IVEQA' });
        }
        if (this.hasModuleAccess('IV-E Liaison')) {
            this.allowedModules.push({ modulename: '4E Liaison', image: '4e.png', rolename: 'IV-E Liaison', rolekey: 'IVELI' });
        }
        if (this.hasModuleAccess('LDSS_PROVIDER')) {
            this.allowedModules.push({ modulename: 'LDSS_PROVIDER', image: 'provide.png', rolename: this.role });
        }
        if (this.hasModuleAccess('Admin')) {
            this.allowedModules.push({ modulename: 'Admin', image: 'admin.png', rolename: this.role });
        }
    }

    private getActiveModuleFn() {
        let activemodules;
        if (this.role && (this.role.toLowerCase().trim() === 'central office fiscal staff' || this.role.toLowerCase().trim() === 'central office fiscal supervisor')) {
            activemodules = this.allowedModules.filter(c => c.rolename === this.role.toLowerCase().trim());
        } else {
            activemodules = this.allowedModules.filter(c => c.rolename === this.role);
        }
        if (activemodules.length) {
            let finanaceModule = null;
            activemodules.forEach(element => {
                if (element.modulename === 'Finance' || element.modulename === this.financeapproval) {
                    finanaceModule = element.modulename;
                }
            });
            this.activeModule = finanaceModule ? finanaceModule : activemodules[0].modulename;
            this._authService.changeUserRoleWithout(activemodules[0]);
        } 
        else {
            if(!this._sessionStorage.getItem('activeModuleNav')){
                this.activeModule = '';
            }
    }
}

    removeReadOnlyAccess() {
        this.isPolicyStaffUser = false;
        if(this.activeModule === 'Intake') {
            this._authService.removeReadOnlyResource('intake_read_only_access');
            this._authService.removeReadOnlyResource('read_only_access');
        } else if(this.activeModule === 'Policy Staff') {
        // CIDM-10751 To Display Psychotrophic Dashboard for Central Policy Staff users
            this.isPolicyStaffUser = true;
        }
        // else if(this.activeModule === 'Case Work' || this.activeModule === 'Approve') {
        //     this._authService.removeReadOnlyResource('servicecase_read_only_access');
        //     this._authService.removeReadOnlyResource('adoptioncase_read_only_access');
        //     this._authService.removeReadOnlyResource('investigation_read_only_access');
        //     this._authService.removeReadOnlyResource('read_only_access');
        // } else if(this.activeModule === 'Finance' || this.activeModule === this.financeapproval) {
        //     this._authService.removeReadOnlyResource('finance_read_only_access');
        //     this._authService.removeReadOnlyResource('read_only_access');
        // } else if(this.activeModule === '4E SUPERVISOR' || this.activeModule === '4E SPECIALIST') {
        //     this._authService.removeReadOnlyResource('read_only_access');
        // }
    }

    isToggled(): boolean {
        const dom: any = document.querySelector('body');
        return dom.classList.contains(this.pushRightClass);
    }

    toggleSidebar() {
        const dom: any = document.querySelector('body');
        dom.classList.toggle(this.pushRightClass);
    }

    rltAndLtr() {
        const dom: any = document.querySelector('body');
        dom.classList.toggle('rtl');
    }

    onLoggedout() {
        this.shareduploadService.uploadFileProgress$.subscribe(uploadprogress => {
            if(uploadprogress && uploadprogress?.length) {
                this.pendingDocs = uploadprogress.filter((up: any) => up.progress > 0 && !up.uploadComplete);
            }
        });
        if(this.pendingDocs && this.pendingDocs.length > 0 ) {
            $('#confirm-logout').modal('show');  
            $('div.modal-backdrop.fade.show').hide();
        } else {
            this.continueLogout();  
        }        
    }

    continueLogout() {
        if(this.pendingDocs && this.pendingDocs.length > 0 ){
            this.pendingDocs.forEach((doc: any) => {
                const url = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadStatusUpdateAttachmentUrl + '/' + doc.ecmsdocumentid;
                this._service.create({},url).subscribe((_response) => {
                    // No data or function to add or call                                                  
                });
            })            
        }
        this._authService.logout();
    }

    hasModuleAccess(key: string): boolean {
        let user = this._authService.getCurrentUser();
        if(!(user?.resources?.length > 0)){
                user = this.userInfo;
            }
        if (key && user && user.resources && user.resources.length > 0) {
            const resources = this.userInfo.resources.filter(menu => menu.isallowed === true);
            if (hasMatch([key], resources.map(item => (item ? item.name : '')))) {
                return true;
            }
            return false;
        }
        return false;

    //     const user = this._authService.getCurrentUser();
    //    if (key && user && user.resources && user.resources.length > 0) {
    //         const resources = user.resources.filter(menu => menu.isallowed === true);
    //         if (hasMatch([key], resources.map(item => (item ? item.name : '')))) {
    //             return true;
    //         }
    //         return false;
    //     }
    //     return false;
    }

    hasAccess(key: string): Observable<boolean> {
        return this._authService.currentUser.pipe(map(user => {
            if (user.resources && user.resources.length > 7) {
                this.isMenu = true;
            } else {
                this.isMenu = false;
            }
            if (key && user.resources && user.resources.length > 0) {
                const resources = user.resources.filter(menu => menu.isallowed === true);
                if (hasMatch([key], resources.map(item => (item ? item.name : '')))) {
                    return true;
                }
                return false;
            }
            return true;
        }));
    }

    hasSubMenuAccess(mainmenu: string, submenu: string ): boolean {
        let isAllowed = true;
        if (this._authService && this._authService.currentUser &&  this._authService.getCurrentUser().resources) {
            this._authService.currentUser.pipe(map(user => (user?.resources ?? []).filter(res => res.resourceid === submenu && res.parentkey === mainmenu))).subscribe((item) => {
                if (item.length) {
                    item.forEach((activeMenu) => {
                        if (activeMenu.resourceid === submenu) {
                            isAllowed = activeMenu.isallowed === true;
                        } else {
                            isAllowed = true;
                        }
                    });
                }
            });
        }
        return isAllowed;
    }

    hasMainMenuAccess(key: string | undefined, menu: string | undefined): boolean {
        let isAllowed = true;
        if (this._authService && this._authService.currentUser &&  this._authService.getCurrentUser().resources) {
        this._authService.currentUser.pipe(map(user => (user?.resources ?? []).filter(res => res.resourceid === menu && res.modulekey === key))).subscribe((item) => {
            if (item.length) {
                item.forEach((activeMenu) => {
                    if (activeMenu.resourceid === menu) {
                        isAllowed = activeMenu.isallowed === true;
                    } else {
                        isAllowed = true;
                    }
                });
            }
        });
    }
        return isAllowed;
    }

    setActiveNav(module: { modulename: string; rolename: string; }) {

        this.activeModule = module.modulename;
        this._sessionStorage.setItem('activeModuleNav', this.activeModule);
        this.role = module.rolename;
        this._authService.changeUserRole(module);
        this._authService.roleupdate$.next(module);
        this.setDashBoardLink();

        setTimeout(() => {
            this.removeReadOnlyAccess();
        }, 2000);
        if (module.modulename === 'Psychotropic Pharmacist Review' || module.modulename === 'Psychotropic Psychiarist Review' || module.modulename === 'Psychotropic Coordinator Review') {
            this.router.navigate(['/pages/psychotropicprescription-review'], {relativeTo: this.route });
        } else if (module.modulename === 'Resource Home' || module.modulename === 'Home Study' || module.modulename === 'Recruiter Trainer') {
            this.router.navigate(['/pages/provider-dashboard']);
        } else if (module.modulename === 'Finance' || module.modulename === this.financeapproval) {
            this.router.navigate(['/pages/finance/finance-dashboard']);
            this._authService.dashboardConfig$.next('REFRESH-DASHBORAD');
        } else if (module.modulename === 'LDSS_PROVIDER' ) {
            this.router.navigate([this.defaultDashboardpath]);
        }
        else {
            this._authService.roleBasedRoute(this.role.toLowerCase());
        }
        this.modulecoll = false;
        if (this.activeModule === "Find"){
            this.router.navigate([this.defaultDashboardpath]);
        }
        const expungedUser = this._authService.getCurrentUser()?.resources?.filter(item => item?.name === 'EXPUNGED_SEXUAL_ABUSE_DETAILS_VIEW').length ? 1 : 0;
        this._sessionStorage.setItem('IS_EXPUNGED_USER', expungedUser || 0);
    }
    clearCount() {
        this.showNotification = false;
    }

    clearExternalCount() {
        this.showExternalNotification = false;
    }

    viewTickets() {
        this.showNotification = false;
        this._dataStoreService.setData('pageSource','notification');
        this.router.navigate(['/pages/contact-support']);
    }

    getNotificationCount() {
        this._service.endpointUrl = 'Usernotifications/getUserNotificationCount' + '?filter';
        this._service.getArrayList({}).subscribe((data: any) => {
            this.totalNotificationCount = data['systemcount'];
            this.totalExternalNotificationCount = data['externalcount'];
            if (data['systemcount'] !== '0') {
                this.showNotification = true;
            }
            if (data['externalcount'] != '0') {
                this.showExternalNotification = true;
            }
        })
    }


    getNotificationTicketsCount() {
        this._service
            .getAll('supportlog/getcountpendingtickets')
            .subscribe(res => {
                this.numberoftickets = res[0]?.count;
            });
    }
    setDashBoardLink() {
        if (this.role === AppConstants.ROLES.PROVIDER) {
            this.dashBoardLink = '/pages/cjams-dashboard';
        } else if (this.role === AppConstants.ROLES.INTAKE_WORKER || this.role === AppConstants.ROLES.KINSHIP_INTAKE_WORKER) {
            this.dashBoardLink = '/pages/newintake/new-saveintake';
        } else if (this.role === AppConstants.ROLES.KINSHIP_SUPERVISOR || this.role === AppConstants.ROLES.SUPERVISOR) {
            this.dashBoardLink = '/pages/cjams-dashboard/cw-intake-referals';
        } else if (this.agency === 'FNS' || this.role === AppConstants.ROLES.FINANCE_WORKER ||
            this.role === AppConstants.ROLES.LDSS_FISCAL_SUPERVISOR || this.role === AppConstants.ROLES.DIRECTOR_OF_FINANCE) {
            this.dashBoardLink = '/pages/finance/finance-dashboard';
        } else if (this.returnSetDashBoardLinkCond1Fn()) {
            this.dashBoardLink = this.dashboardpath;
        } else if (this.activeModule === 'LDSS_PROVIDER') {
            this.dashBoardLink = this.defaultDashboardpath;
        } else if (this.role === AppConstants.ROLES.APPEAL_USER) {
            this.dashBoardLink = this.dashboardpath;
        } else if (this.returnSetDashBoardLinkCond2Fn()) {
            this.dashBoardLink = this.dashboardpath;
        } else if (this.hasAccess('ICPC_Approver')) {
            this.dashBoardLink = '/pages/neice-icpc/pendingApprovals';
        } else {
            this.dashBoardLink = this.dashboardpath;
        }
    }

    private returnSetDashBoardLinkCond2Fn() {
        return (this.role === 'CJAMS_SSA_FTDM_FACILITATOR' || 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || 'CJAMS_SSA_FTDM_QI_SUPERVISOR');
    }

    private returnSetDashBoardLinkCond1Fn() {
        return (this.activeModule === 'Case Work' || this.activeModule === 'Resource Home' || this.activeModule === 'Home Study' || this.activeModule === 'Recruiter Trainer' || this.activeModule === 'FTDM Facilitator' || this.activeModule === 'Qualified Individual');
    }

    fillFeedback() {
        this.curDate = new Date();
        let caseid = 'Dashboard';
        this.feedbackForm.patchValue({ clientid: 'Dashboard' });
        if (this.location.path().indexOf('/case-worker/') !== -1) {
            caseid = this.location.path().split('/')[4];
            this.getInvolvedPerson();
        } else if (this.location.path().indexOf('/my-newintake/') !== -1) {
            caseid = this._dataStoreService.getObj('intake') ? this._dataStoreService.getObj('intake').number : '';
            this.feedbackForm.patchValue({ clientid: 'Intake' });
        }
        this.feedbackForm.patchValue({ supportlogdate: this.curDate, caseid: caseid, pageurl: this.location.path() });
        $('#user-feedback').modal('show');
    }
    onAttachmentChange(event: { target: { files: string | any[]; }; }) {
        const reader = new FileReader();
        if (event.target.files && event.target.files.length) {
            this.fileUploaded = event.target.files[0];
            const [file] = event.target.files;
            reader.readAsDataURL(file);
            reader.onload = () => {
                this.feedbackForm.patchValue({
                    filedata: reader.result
                });
            };
        }
    }
    sendFeedback() {
        this._service.create(this.feedbackForm.value, 'supportlog/add').subscribe(
            res => {
                this._alert.success('Feedback sent successfully');
                this.resetFeedback();
                this.supportNo = res.supportno;
                $('#supportNo').modal('show');
            },
            err => {
                this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    resetFeedback() {
        $('#user-feedback').modal('hide');
        this.feedbackForm.reset();
        this.fileUploaded = Object.assign({});
        $('#filedata').val(null);
        if (this.userInfo.user && this.userInfo.user.userprofile) {
            this.feedbackFormPatchFn();
            this.feedbackForm.patchValue({
                severity: ''
            });
        }
    }
    private feedbackFormPatchFn() {
        this.feedbackForm.patchValue({
            displayname: this.userInfo.user?.userprofile?.displayname,
            cjamspid: this.userInfo.user?.userprofile?.cjamspid,
            frommailid: this.userInfo.user?.userprofile?.email,
            userrole: this.userInfo?.role?.description
        });
    }

    private initializeForm() {
        this.feedbackForm = this._formBuild.group({
            displayname: [''],
            cjamspid: [''],
            frommailid: [''],
            ldssregion: [''],
            supportlogdate: [null],
            officelocation: [''],
            clientid: [''],
            subject: [''],
            notes: ['', [Validators.required]],
            userrole: [''],
            caseid: [''],
            filedata: [null],
            severity: [''],
            pageurl: ['']
        });
        if (this.userInfo.user && this.userInfo.user.userprofile) {
            this.feedbackFormPatchFn();
        }
    }
    private getInvolvedPerson() {
        const intakeServiceId = this.location.path().split('/')[3] ? this.location.path().split('/')[3] : null;
        this._service
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: { intakeserviceid: intakeServiceId }
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
            )
            .subscribe(res => {
                const person = res.data.filter(child => child.rolename === 'RC')[0];
                this.feedbackForm.patchValue({ clientid: person.cjamspid });
            });
    }

    uploadFile(file: any): void {
        this.preview(file);
        const fileExt = file['name'].toLowerCase()
            .split('.')
            .pop();
        if (fileExt === 'jpeg' ||
        fileExt === 'jpg' ||
        fileExt === 'png') {
        this.uploadedFile.push(file);
        this.uploadedFile[0].attachmenttypekey = 'Document';
        this.isAttachType = this.uploadedFile[0].attachmenttypekey;
        } else {
            this._alert.error(fileExt + 'format can\'t be uploaded');
            return;
        }
        const uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' +  this.userInfo.userId + '&attachmenttype=' + this.attachmenttype + '&personid=' + this.userInfo.user.securityusersid ;

        this.isUploading = true;
        if (!(file instanceof File)) {
          this.isUploading = false;
          return;
        }
        this._uploadService.upload({
          url: uploadUrl,
          headers: new HttpHeaders().set('ctype', 'file'),
          filesKey: ['file'],
                    files: this.uploadedFile[0],
                    process: true
        }).subscribe(
          (response) => {
            if (response.status) {
                this.uploadedFile[0].percentage = response.percent;
            }
            if ( response.status === UploadStatus.Completed) {
                this.user = {
                    userphoto: response.data.s3bucketpathname
                };
                this._service.create(this.user, 'admin/userprofile/updatephoto').subscribe((result) => {
                    if (result) {
                        this._alert.success('User photo updated successfully.');
                    }
                });
            }
          },
          (err) => {
            console.error(err);
          },
          () => {
            this.isUploading = false;
          });
      }

      preview(files: any) {
        const mimeType = files.type;
        if (mimeType.match(/image\/*/) == null) {
          return;
        }
        const reader = new FileReader();
        this.imagePath = files;
        reader.readAsDataURL(files);
        reader.onload = (_event) => {
          this.imgURL = reader.result;
        };
      }
     getpsychotropiccounty(){



        this._service.getArrayList(
            {
                where: { objecttype:  'psycotrophic-secondary-review'},
                method: 'get',
                nolimit: true
            },

            'admin/county/getcountygoliveconfig' + '?filter'
        ).subscribe( response => {
            this.psychotropiccounty  = response[0];
            if(this.psychotropiccounty?.statewide){
                const statewidedate = this.psychotropiccounty?.statewide;
                if( moment(statewidedate).isSameOrBefore(moment(), 'day')){
                    this.showpsychotropictab = true;
            }
        }else{
            if(this.psychotropiccounty){
                let countylivedate = this.psychotropiccounty[`${this.countyname?.replace(/[.\s']/g, '').toLowerCase()}`];
                if (countylivedate) {
                    if (moment(countylivedate).isSameOrBefore(moment(), 'day')) {
                        this.showpsychotropictab = true;
                    }
                }

        }
    }
        });



      }

    getUserCounty() {

        const filter: any = {};
        this._service
            .getAll('admin/county/getusercounty?data=' + encodeURIComponent(JSON.stringify(filter)))
            .subscribe(res => {
                if (res && res.length > 0) {
                   const userCounty = res[0];
                   this.countyname = userCounty.countyname;
                    this.getpsychotropiccounty();
                }
            });
    }
    navigatetodest(value: any){
        if(value =='Review'){
            this.dashBoardLink ='/pages/psychotropicprescription-review'

        } else if(value == 'Report'){
            this.dashBoardLink ='/pages/psychotropicprescription-review/psychotropicprescription-report'
        }
    }
}