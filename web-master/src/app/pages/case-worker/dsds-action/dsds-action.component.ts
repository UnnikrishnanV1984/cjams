
import {of as observableOf,  Observable } from 'rxjs';
import { Location } from '@angular/common';
import { AfterViewInit, ChangeDetectorRef, Component, OnInit, OnDestroy, Injector, ViewChild, ElementRef } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService, AuthService, SessionStorageService } from '../../../@core/services';
import { AppUser, UserInfo } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../_entities/caseworker.data.constants';
import { hasMatch } from '../../../@core/common/initializer';
import { NavigationUtils } from '../../_utils/navigation-utils.service';
import moment from 'moment';

declare const $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dsds-action',
    templateUrl: './dsds-action.component.html',
    styleUrls: ['./dsds-action.component.scss'],
    standalone: false
})
export class DsdsActionComponent implements OnInit, AfterViewInit, OnDestroy {
    id: string;
    daNumber: string;
    tabList: any;
    selected: any;
    currentTab!: string;
    tabList$!: Observable<any[]>;
    roleId!: AppUser;
    canDisplayChildRemoval$!: Observable<boolean>;
    role!: string;
    intakeCaseStore: any;
    appEvent: any;
    isStateWideFA = false;
    caseworkerurl = '/pages/case-worker/';
    investigationplanurl = '/dsds-action/investigation-plan';
    assessmenturl = '/dsds-action/assessment';
    attachmenturl = '/dsds-action/attachment';
    dispositionurl = '/dsds-action/disposition';
    reportsummaryurl = '/dsds-action/report-summary';
    petitiondetailurl = '/dsds-action/court/petition-detail';
    childremoval = 'Child Removal';
    casetimeline = 'Case Timeline';
    timelineviewurl = '/dsds-action/time-line-view';
    caseworkersummary = 'caseworker-summary';
    cwpersonurl = '/dsds-action/person-cw';
    relationshipurl = '/dsds-action/relationship';
    notesurl = '/dsds-action/recording/notes';
    childremoveurl = '/dsds-action/child-removal/details';
    serviceplanurl = '/dsds-action/service-plan/sc-gc';
    cwassignmentsurl = '/dsds-action/cw-assignments';
    isNotfoundUser: boolean = true;

    canScrollLeft: boolean = false;
    canScrollRight: boolean = true;
    @ViewChild('tabListRef') tabListContainer!: ElementRef<HTMLUListElement>;

    private _dataStoreService: DataStoreService;
    private location: Location;
    private router: Router;
    private route: ActivatedRoute;
    private ref: ChangeDetectorRef;
    private _authServie: AuthService;
    private _session: SessionStorageService;
    private _navigationService: NavigationUtils;

    constructor(private injector: Injector){
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this.location = this.injector.get<Location>(Location);
        this.router = this.injector.get<Router>(Router);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this.ref = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this._authServie = this.injector.get<AuthService>(AuthService);
        this._session = this.injector.get<SessionStorageService>(SessionStorageService);
        this._navigationService = this.injector.get<NavigationUtils>(NavigationUtils);
    
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.intakeCaseStore = this._session.getObj('IntakeCaseStore');
        this._dataStoreService.setData('IntakeCaseStore', this.intakeCaseStore);
        this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.appEvent = this._dataStoreService.getData('appevent');
        this.roleId = this._authServie.getCurrentUser();
        this.role = this.roleId.role.name; 
        this.route.data.subscribe(data => {
            if (data && data.hasOwnProperty('result')) {
                this._authServie.hasAccess('State Wide FA').subscribe(result => {
                    this.isStateWideFA = result;
                    this.checkAndLoadReadOnlyAccess(data.result);
                  }) ;       
            }            
          });
    }

    ngOnInit() {
        // this.roleId = this._authServie.getCurrentUser();
        // this.role = this.roleId.role?.name;
        // this.dsdsActionResolverService.getWorkLoad(this.id).subscribe({
        //     next: (data: any) => {
        //         this._authServie.hasAccess('State Wide FA').subscribe(result => {
        //             this.isStateWideFA = result;
        //             this.checkAndLoadReadOnlyAccess(data);
        //         });
        //     }
        // })
        this._navigationService.dsdsActionTabSwitch$.subscribe( data => {
            if(this.tabList && this.tabList.length > 0){
                const selected =  this.tabList.filter((tab: { id: any; }) => tab.id === data);
                this.selected = selected && selected.length > 0 ? selected[0] : this.selected;
                this.selected.isActive = true;
                this.isActiveTab(this.selected);
                if(this.selected.tabName === 'Placement'){
                    $('.aut-lnk-li').removeClass(function(index: any) {
                        return "active";
                    });
                    $('.aut-lnk-placement-li').addClass(function(index: any) {
                        return "active";
                    });
                }
            }
        });
        this.loadTabs();
    }
    ngOnDestroy() {
        // commenting below two line ng destroy is calling on every other child tabs loading
       // this._session.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
       // this._session.removeItem(CASE_STORE_CONSTANTS.CASE_TYPE);
        // this._dataStoreService.clearStore();
    }
    ngAfterViewInit() {
        const __this = this;
        document.body.scrollTop = 0; // For Safari
        document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera

        this._dataStoreService.currentStore.subscribe((store) => {
            if (store['dsdsActionsSummary']) {
                const actionSummary = store['dsdsActionsSummary'];
                if (actionSummary.da_subtype === 'CPS-AR') {
                    $('#arCaseClosureTab').show();
                } else {
                    $('#arCaseClosureTab')?.hide();
                }
            }
        });
        if (this._authServie.isDJS() && this.intakeCaseStore && this.intakeCaseStore.action === 'view') {
            $(':button').prop('disabled', true);
            $('span').css({'pointer-events': 'none',
                        'cursor': 'default',
                        'opacity': '0.5',
                        'text-decoration': 'none'});
            $('i').css({'pointer-events': 'none',
                                    'cursor': 'default',
                                    'opacity': '0.5',
                                    'text-decoration': 'none'});
            $('th a').css({'pointer-events': 'none',
                                    'cursor': 'default',
                                    'opacity': '0.5',
                                    'text-decoration': 'none'});
        }
    }

    scrollTabs(direction: any): void {
        if (!this.tabListContainer) {
            return;
        }
    
        const scrollAmount = 400;
        const container = this.tabListContainer.nativeElement;
    
        if (direction === 'left') {
        container.scrollLeft -= scrollAmount;
        } else {
        container.scrollLeft += scrollAmount;
        }
    }

    updateScrollButtonState(): void {
        if (!this.tabListContainer) {
          return;
        }
    
        const container = this.tabListContainer.nativeElement;
        this.canScrollLeft = container.scrollLeft > 0;
    
        this.canScrollRight = container.scrollWidth - container.scrollLeft - container.clientWidth > 1;
      }
      onTabScroll(): void {
        this.updateScrollButtonState();
      }

    selectTab(tabItem: any) {
        this.tabList.forEach((tab: any) => tab.isActive = false);
        tabItem.isActive = true;
        this.router.navigate([tabItem.route]);
    }

    checkAndLoadReadOnlyAccess (result: any) {
        const rolesConfig = ['field', 'apcs','APPEALCO'];
        const user = this._authServie.getCurrentUser();
        const actualuser = user.user;
        const countyid = this.getcountyid(actualuser);
        this.isNotfoundUser = true;
        const caseType = this.getcasetype();
        if (result && result.length ) {
            for(let element of result){
                const data = element;
                this.workerCheck(actualuser, data);
                this.supervisorCheck(actualuser, data);
                this.checkIfUserFromSameCounty(data.countyid,countyid);
                const roleExist = rolesConfig.filter(role => this.role === role);
                this.caseWorkerRoleCheck(roleExist, actualuser, data, countyid);
                if (!this.isNotfoundUser){
                    break;
                }
                this.countyCheck(data, countyid, caseType, roleExist);
                if (!this.isNotfoundUser){
                    break;
                }
            }
            this.loadReadOnly(caseType);           
          }
        this._authServie.addRemoveReadOnlyResources(caseType);
    }

    checkIfUserFromSameCounty(userCountry: any, caseCounty: any) {
        if(userCountry === caseCounty) {
            this._dataStoreService.setData('IsUserFromSameCounty', true);
        } else {
            this._dataStoreService.setData('IsUserFromSameCounty', false);
        }
    }

    getcountyid(actualuser: any){
        let countyid = '';
        if (actualuser.userprofile
            && actualuser.userprofile.teammemberassignment
            && actualuser.userprofile.teammemberassignment.teammember.team
            &&  actualuser.userprofile.teammemberassignment.teammember.team.countyid ) {
                countyid = actualuser.userprofile.teammemberassignment.teammember.team.countyid;
        }
        return countyid;
    }

    getcasetype(){
        let caseType;
        caseType =  this._session.getItem(CASE_STORE_CONSTANTS.CASE_TYPE);
        caseType = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE) && caseType !== 'ADOPTION' ? 'SERVICECASE' : this.checkCaseType(caseType);
        return caseType;  
    }

    checkCaseType(caseType: string){
        return caseType === 'ADOPTION' ? caseType : 'INVESTIGATION';
    }

    workerCheck(actualuser: any, data: any) {
        if ((hasMatch([actualuser.securityusersid], this.getfromsecurityusersiddata(data))
            || hasMatch([actualuser.securityusersid], this.getfromworkerdetails(data))
            || hasMatch([actualuser.securityusersid], this.gettosecurityusersdata(data))
            || hasMatch([actualuser.securityusersid], this.gettoworkerdetails(data))
        ) && (!data.endate || (data.endate && moment(data.enddate).isValid() && new Date(data.enddate) > new Date()))) {
            this.isNotfoundUser = false;
        }
    }

    getfromsecurityusersiddata(data: any){
        return data.fromsecurityusersiddata ? data.fromsecurityusersiddata.map((item: { securityusersid: any; }) => (item ? item.securityusersid : '')): [];
    }
    getfromworkerdetails(data: any){
        return data.fromworkerdetails ? data.fromworkerdetails.map((item: { securityusersid: any; }) => (item ? item.securityusersid : '')) : [];
    }
    gettoworkerdetails(data: any){
        return data.toworkerdetails ? data.toworkerdetails.map((item: { securityusersid: any; }) => (item ? item.securityusersid : '')) : [];
    }
    gettosecurityusersdata(data: any){
        return data.tosecurityusersdata ? data.tosecurityusersdata.map((item: { securityusersid: any; }) => (item ? item.securityusersid : '')) : []
    }

    supervisorCheck(actualuser: any, data: any) {
        /**
        * In case transfer flow the case is assigned to Supervisor of different county for assigning it to someone in his/her county
        * checking if there is an active assignment to supervisor user and allowing access to this user
        */
        if (hasMatch([actualuser.securityusersid], data.toworkerdetails ? data.toworkerdetails.map((item: { securityusersid: any; }) => (item ? item.securityusersid : '')) : [])
            && (!data.endate || (data.endate && moment(data.enddate).isValid() && new Date(data.enddate) > new Date()))
            && this.role === 'apcs') {
            this.isNotfoundUser = false;
        }
    }
    caseWorkerRoleCheck(roleExist: any, actualuser: any, data: any, countyid: any) {
        if (actualuser.userprofile.teammemberassignment.teammember.team.name &&
            actualuser.userprofile.teammemberassignment.teammember.team.name === data.teamname && data.countyid && data.countyid === countyid && Array.isArray(roleExist) && roleExist.length
            && (!data.endate || (data.endate && moment(data.enddate).isValid() && new Date(data.enddate) > new Date()))) {
            this.isNotfoundUser = false;
        }
    }

    countyCheck(data: any, countyid:any, caseType: any, roleExist: any){
        if(data.countyid){
            if((data.countyid ===  countyid || this.isStateWideFA) && ((caseType === 'INVESTIGATION' && this._authServie.hasModuleAccess('investigation_full_access')) || (caseType === 'INTAKE' && this._authServie.hasModuleAccess('intake_full_access')) ||
                                              (caseType === 'SERVICECASE' && this._authServie.hasModuleAccess('servicecase_full_access')) || (caseType === 'ADOPTION' && this._authServie.hasModuleAccess('adoptioncase_full_access')))) {
                this.isNotfoundUser = false;
            } else if (data.countyid !==  countyid  && !(Array.isArray(roleExist) && roleExist.length)) {
                this.isNotfoundUser = true;
            }
        }
    }

    loadReadOnly(caseType: string){
        if (this.isNotfoundUser) {
            this._authServie.addReadOnlyResource();
         } else {
            this._authServie.removeReadOnly();
            this._authServie.addRemoveReadOnlyResources(caseType);
         }
    }


    navigateToPlacement() {
        this.tabList.map((item: { id: string; isActive: boolean; }) => {
            if (item.id === 'placementTab') {
                item.isActive = true;
            } else {
                item.isActive = false;
            }});
        this.selected = this.tabList.find((item: { id: string; }) => item.id === 'placementTab');
        this.currentTab = 'placementTab';
        this.isActiveTab(this.selected);
    }
    isActiveTab(item: any) {
        return this.selected === item;
    }

    loadTabs() {
        const agency = this.getAgency();
        const actionSummary = this._dataStoreService.getData('dsdsActionsSummary');
        if (agency === 'DJS') {
            this.currentTab = 'Supervision Plan';
            this.tabList = [
                {
                    id: 'summaryTab', tabName: 'Summary', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/report-summary-djs', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: '',
                },
                {
                    id: 'supervisionPlanTab', tabName: this.currentTab, route: this.caseworkerurl + this.id + '/' + this.daNumber + this.investigationplanurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                // To be developed DJS New Person Module
                {
                    id: 'personsTab', tabName: 'Persons', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/involved-person', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'appointmentsTab', tabName: 'Appointments', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/appointment', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'notesTab', tabName: 'Contacts', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/recording/djsnotes', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'assessmentsTab', tabName: 'Assessments', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.assessmenturl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'placementTab', tabName: 'Placement', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/djs-placement', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'documentsTab', tabName: 'Documents', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.attachmenturl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'dispositionTab', tabName: 'Decision', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.dispositionurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'leagalActionTab', tabName: 'Legal Action', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/legal-action-history', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'transport', tabName: 'Transport', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/transport', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'visitir', tabName: 'Visitor', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/visitor', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'courtactions', tabName: 'Court Actions', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/court-action', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'caseTimelineTab', tabName: 'Event Timeline', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/time-line-view-djs', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                }
            ];
            const actionSummary1 = this._dataStoreService.getData('dsdsActionsSummary');
            if (actionSummary1 && actionSummary1.isrestitution) {
                const restitutionTab = {
                    id: 'restitution', tabName: 'Restitution', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/djs-restitution/payment-schedule', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR]
                };
                this.tabList.splice(this.tabList.length - 1, 0, restitutionTab);
            }

        } else if (agency === 'AS') {
            this.currentTab = 'Check List';
            this.tabList = [
                {
                    id: 'summaryTab', tabName: 'Summary', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.reportsummaryurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'checkListTab', tabName: this.currentTab, route: this.caseworkerurl + this.id + '/' + this.daNumber + this.investigationplanurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'personsTab', tabName: 'Persons', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/involved-person', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'adultScreenTab', tabName: 'Adult Screen', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/case-adult-screen-tool', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'notesTab', tabName: 'Contacts', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/as-recording/as-notes', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'crossReferencesTab', tabName: 'Cross References', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/cross-reference', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'cwExEntities', tabName: 'Entities', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/entities', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'adultassessmentsTab', tabName: 'Assessments', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/adult-assessment', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'oas', tabName: 'Action Letters', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/as-oas', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'maltreatmentAllegationInfoTab',
                    tabName: 'Investigation Findings',
                    route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/as-maltreatment-information',
                    isActive: false, role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'monthlyIncome', tabName: 'Monthly Report', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/monthly-report', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'asInvestigationPlan', tabName: 'Maltreatment Allegation', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/as-invstgn-plan',
                    isActive: false, role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'placementTab', tabName: 'Placement', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/adult-placement', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'attachmentsTab', tabName: 'Documents', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.attachmenturl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'servicePlanTab', tabName: 'Service Plan', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/as-service-plan', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'dispositionTab', tabName: 'Disposition', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.dispositionurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'courtTab', tabName: 'Court', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.petitiondetailurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'childRemovalTab', tabName: this.childremoval, route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/child-removal/details', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'referralsTab', tabName: 'Referrals', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/as-referral', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    id: 'caseTimelineTab', tabName: this.casetimeline, route: this.caseworkerurl + this.id + '/' + this.daNumber + this.timelineviewurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                }
            ];
        } else if (agency === 'CW') {
            this.loadTabsForCW(actionSummary);
    }
        const seletectedTab = this.tabList.filter((element: any) => {
            return this.location.path().search(element.route) !== -1;
        });
        if (seletectedTab.length) {
            this.selected = seletectedTab[0];
        } else {
            this.selected = this.tabList[0];
            const appEvents = ['GAARR', 'GAAR', 'GADR', 'GAYR', 'GASR', 'ADPR', 'ASAR', 'ABLR'];
            if (appEvents.indexOf(this.appEvent) !== -1 ) {
                this.selected = this.tabList[8];
            }

        }
        if (agency !== 'CW') {
            const index = this.tabList.findIndex((tab: any) => tab.tabName === this.childremoval);
            if (index > 0) {
                this.tabList.splice(index, 1);
            }
        }
        this.selected.isActive = true;
        this.tabList$ = observableOf(this.tabList);
        this.ref.markForCheck();
    }
    getAgency(){
        let agency = this._authServie.getAgencyName();
        if (localStorage.getItem('iveagency')) {
            const iveagency = localStorage.getItem('iveagency');
            if (iveagency === 'IV-E') {
                if (this._authServie.getAgencyName() === 'IV-E') {
                    agency = 'CW'
                }
            }
            localStorage.removeItem('iveagency');
        }
        if (this._authServie.getCurrentUser().user.userprofile.teamtypekey === 'FNS') {
            agency = 'CW';
        }
        return agency;
    }
    loadTabsForCW(actionSummary: any) {
        const isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        const caseType = this._session.getItem(CASE_STORE_CONSTANTS.CASE_TYPE);
        const isSupervisor = this._authServie.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
        const isCentralPolicyStaff = this._authServie.selectedRoleIs(AppConstants.ROLES.CJAMS_CENTRAL_POLICY_STAFF);
        if (caseType) { this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_TYPE, caseType); }
        if (isServiceCase && caseType !== 'ADOPTION') {
            this.currentTab = 'CheckList';
            this.tabList = [
                {
                    overRideKey: '',
                    id: 'summaryTab', tabName: 'Summary', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.reportsummaryurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: this.caseworkersummary,
                },
                {
                    overRideKey: '',
                    id: 'personsTab', tabName: 'Persons', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.cwpersonurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR]
                },
                {
                    overRideKey: '',
                    id: 'relationshipTab', tabName: 'Relationship', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.relationshipurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'notesTab', tabName: 'Contacts', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.notesurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'sdmTab', tabName: 'SDM', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/sdm', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: 'caseworker-sdm'
                },

                {
                    overRideKey: '',
                    id: 'checkListTab', tabName: this.currentTab, route: this.caseworkerurl + this.id + '/' + this.daNumber + this.investigationplanurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR]
                },
                {
                    overRideKey: '',
                    id: 'childRemovalTab', tabName: this.childremoval, route: this.caseworkerurl + this.id + '/' + this.daNumber + this.childremoveurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'familyFindingsTab',
                    tabName: 'Family Findings',
                    route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/family-findings',
                    isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'placementTab', tabName: 'Placement', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/sc-placements/list', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'permanencyPlan', tabName: 'permanency Plan', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/sc-permanency-plan', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'socialHistoryTab', tabName: 'Social History', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/social-history', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'cw-case-plan'
                },
                {
                    overRideKey: '',
                    id: 'servicePlanTab', tabName: 'Services', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.serviceplanurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'casePlanTab', tabName: 'Case Plan', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/case-plan', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'cw-case-plan'
                },
                {
                    overRideKey: '',
                    id: 'assignmentsTab', tabName: 'Assignments', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.cwassignmentsurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'assessmentsTab', tabName: 'Assessments', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.assessmenturl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'attachmentsTab', tabName: 'Documents', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.attachmenturl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'courtTab', tabName: 'Court', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.petitiondetailurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR]
                },
                {
                    overRideKey: '',
                    id: 'participationTab', tabName: 'Participation', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/participation', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR]
                },
                {
                    overRideKey: '',
                    id: 'paytmentsTab', tabName: 'Payments', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/payments', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR]
                },
                {
                    overRideKey: '',
                    id: 'dispositionTab', tabName: 'Decision', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.dispositionurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                }
            ];

            this.addAuditTab(isSupervisor, isCentralPolicyStaff);
            this.addServiceAgreementTab(isServiceCase);
            this.removeSDMTab(actionSummary);
        } else if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
            this.tabList = [
                {
                    overRideKey: '',
                    id: 'personsTab', tabName: 'Persons', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/adoption-persons', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'cw-persons-screen'
                },
                {
                    overRideKey: '',
                    id: 'providerProfile', tabName: 'Provider Address', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/provider-profile', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'notesTab', tabName: 'Contacts', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.notesurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'cw-contacts-screen'
                },
                {
                    overRideKey: '',
                    id: 'assessmentsTab', tabName: 'Assessments', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.assessmenturl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'servicePlanTab', tabName: 'Services', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.serviceplanurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'paymentHistory', tabName: 'Payments', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/payment-history', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'attachmentsTab', tabName: 'Documents', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.attachmenturl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'agreementDocsTab', tabName: 'Agreement Documents', route: this.caseworkerurl + this.id + '/' + this.daNumber +
                        '/dsds-action/placement/adoption/adoption-subsidy/agreement', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'assignmentsTab', tabName: 'Assignments', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.cwassignmentsurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'narrative', tabName: 'Narrative', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/narrative', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: this.caseworkersummary
                },
                {
                    overRideKey: '',
                    id: 'dispositionTab', tabName: 'Decision', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.dispositionurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'cw-disposition-screen'
                },
                {
                    overRideKey: '',
                    id: 'courtTab', tabName: 'COURT', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/court', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                }
            ];
        } else if (actionSummary && (actionSummary.da_subtype === 'IHS') && actionSummary.teamtypekey === 'CW') {
            this.currentTab = 'CheckList';
            this.tabList = [
                {
                    overRideKey: '',
                    id: 'summaryTab', tabName: 'Summary', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.reportsummaryurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'cw-summary-screen'
                },
                {
                    overRideKey: '',
                    id: 'personsTab', tabName: 'Household', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.cwpersonurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR]
                },
                {
                    overRideKey: '',
                    id: 'relationshipTab', tabName: 'Relationship', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.relationshipurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'checkListTab', tabName: this.currentTab, route: this.caseworkerurl + this.id + '/' + this.daNumber + this.investigationplanurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR]
                },
                {
                    overRideKey: '',
                    id: 'notesTab', tabName: 'Contacts', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.notesurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'cw-contacts-screen'
                },
                {
                    overRideKey: '',
                    id: 'assignmentsTab', tabName: 'Assignments', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.cwassignmentsurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'assessmentsTab', tabName: 'Assessments', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.assessmenturl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'attachmentsTab', tabName: 'Documents', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.attachmenturl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'cw-attachment-screen'
                },
                {
                    overRideKey: '',
                    id: 'servicePlanTab', tabName: 'Service Plan', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/service-plan', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'cw-service-plan'
                },
                {
                    overRideKey: '',
                    id: 'serviceAgreementTab', tabName: 'Service Agreement', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/in-home-service/service-agreement',
                    isActive: false, role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR], screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'childRemovalTab', tabName: this.childremoval, route: this.caseworkerurl + this.id + '/' + this.daNumber + this.childremoveurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR]
                },
                {
                    overRideKey: '',
                    id: 'courtTab', tabName: 'Court', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.petitiondetailurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'cw-court-screen'
                },
                {
                    overRideKey: '',
                    id: 'dispositionTab', tabName: 'Disposition', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.dispositionurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'cw-disposition-screen'
                },
                {
                    overRideKey: '',
                    id: 'caseTimelineTab', tabName: this.casetimeline, route: this.caseworkerurl + this.id + '/' + this.daNumber + this.timelineviewurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'cw-case-timeline-screen'
                }

            ];
        } else {
            this.currentTab = 'CheckList';
            this.tabList = [
                {
                    overRideKey: '',
                    id: 'summaryTab', tabName: 'Summary', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.reportsummaryurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: this.caseworkersummary
                },
                {
                    overRideKey: '',
                    id: 'checkListTab', tabName: this.currentTab, route: this.caseworkerurl + this.id + '/' + this.daNumber + this.investigationplanurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'caseworker-checklist'
                },
                {
                    overRideKey: '',
                    id: 'personsTab', tabName: 'Persons', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.cwpersonurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'caseworker-persons'
                },
                {
                    overRideKey: '',
                    id: 'relationshipTab', tabName: 'Relationship', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.relationshipurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'notesTab', tabName: 'Contacts', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.notesurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'caseworker-contacts'
                },
                {
                    overRideKey: '',
                    id: 'sdmTab', tabName: 'SDM', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/sdm', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: 'caseworker-sdm'
                },
                {
                    overRideKey: '',
                    id: 'assignmentsTab', tabName: 'Assignments', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.cwassignmentsurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
                    screenKey: ''
                },
                {
                    overRideKey: '',
                    id: 'assessmentsTab', tabName: 'Assessments', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.assessmenturl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'caseworker-assessment'
                },
                {
                    overRideKey: '',
                    id: 'childRemovalTab', tabName: this.childremoval, route: this.caseworkerurl + this.id + '/' + this.daNumber + this.childremoveurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'caseworker-child-removal'
                },
                {
                    overRideKey: '',
                    id: 'courtTab', tabName: 'Court', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.petitiondetailurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'caseworker-court'
                },
                {
                    overRideKey: '',
                    id: 'attachmentsTab', tabName: 'Documents', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.attachmenturl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'caseworker-attachments'
                },
                {
                    overRideKey: '',
                    id: 'servicePlanTab', tabName: 'Services', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.serviceplanurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'caseworker-service-plan'
                },
                {
                    overRideKey: '',
                    id: 'dispositionTab', tabName: 'Decision', route: this.caseworkerurl + this.id + '/' + this.daNumber + this.dispositionurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'caseworker-disposition'
                },
                {
                    overRideKey: '',
                    id: 'caseTimelineTab', tabName: this.casetimeline, route: this.caseworkerurl + this.id + '/' + this.daNumber + this.timelineviewurl, isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: 'caseworker-case-timeline'
                }
            ];
            if (isSupervisor) {
                const auditTab = {
                    overRideKey: '',
                    id: 'auditTrailTab', tabName: 'Case Audit Trail', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/case-audit-trail', isActive: false,
                    role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                    screenKey: ''
                }
                this.tabList.push(auditTab);
            }
        }
        this.addCPSIRARTabs(actionSummary)
        this.addProgressReviewTab(actionSummary);
    }

    removeSDMTab(actionSummary: any){
        if (actionSummary && actionSummary?.intake_jsondata && actionSummary?.intake_jsondata.length > 0 && (actionSummary?.intake_jsondata[0]?.intakeservreqtypeid === '7933508f-0350-4552-be50-350598a387a7')) {
            this.tabList.splice(4, 1);
        } 
    }

    addAuditTab(isSupervisor: any, isCentralPolicyStaff: any){
        if (isSupervisor || isCentralPolicyStaff) {
            const auditTab = {
                overRideKey: '',
                id: 'auditTrailTab', tabName: 'Case Audit Trail', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/case-audit-trail', isActive: false,
                role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR],
                screenKey: ''
            }
            this.tabList.push(auditTab);
        }
    }

    addServiceAgreementTab(isServiceCase: any){
        if (isServiceCase) {
            const SATab = {
                overRideKey: '',
                id: 'serviceAgreementTab', tabName: 'Service Agreement', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/in-home-service/service-agreement',
                isActive: false, role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR], screenKey: ''
            };
            this.tabList.splice(12, 0, SATab);
        }
    }

            

    addCPSIRARTabs(actionSummary: any){
        if (actionSummary && (actionSummary.da_subtype === 'CPS-IR' || actionSummary.da_subtype === 'CPS-AR')) {
            const MaltreatmentAllegationTab = {
                overRideKey: '',
                id: 'maltreatmentAllegationInfoTab',
                tabName: 'Maltreatment Allegation',
                screenKey: 'caseworker-maltreatment-allegation',
                route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/maltreatment-information',
                isActive: false, role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR]

            };
            this.tabList.splice(6, 0, MaltreatmentAllegationTab);

            this.addInvestigationFindingTab(actionSummary);
            this.addAlternativeResponseSummaryTab(actionSummary);

        } 
    }

    addInvestigationFindingTab(actionSummary: any){
        if (actionSummary && actionSummary.da_subtype === 'CPS-IR') {
            const InvestigationFindingTab = {
                overRideKey: '',
                id: 'investigationFindingsTab',
                tabName: 'Investigation Findings',
                screenKey: 'caseworker-investigation-findings',
                route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/investigation-findings',
                isActive: false, role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR]
            };
            this.tabList.splice(7, 0, InvestigationFindingTab);
        }
    }

    addAlternativeResponseSummaryTab(actionSummary: any){
        if (actionSummary && actionSummary.da_subtype === 'CPS-AR') {
            const AlternativeResponseSummaryTab = {
                overRideKey: '',
                id: 'alternativeResponseSummaryTab',
                tabName: 'AR Summary',
                route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/alternative-response-summary',

                isActive: false, role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR]
            };
            this.tabList.splice(7, 0, AlternativeResponseSummaryTab);
        }
    }

    addProgressReviewTab(actionSummary: any){
        if (actionSummary && actionSummary.service_old_id) {
            const prTab = {
                overRideKey: '',
                id: 'progressReviewTab', tabName: 'Legacy Progress Review', route: this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/in-home-service/progress-review',
                isActive: false, role: [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_SUPERVISOR], screenKey: ''
            };
            this.tabList.push(prTab);
        }
    }
}