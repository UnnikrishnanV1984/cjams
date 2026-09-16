import { Component, Injector, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { HighChartOptions } from '../_entities/home-dash-entities';
import {CommonDropdownsService, CommonHttpService, AuthService, SessionStorageService, AlertService, DataStoreService} from '../../../@core/services';
import { Title4eService } from '../../title4e/services/title4e.service';
import {DropdownModel, PaginationInfo} from '../../../@core/entities/common.entities';
import { FormGroup, FormBuilder } from '@angular/forms';
import moment from 'moment';
import {Observable} from 'rxjs';
import {CommonUrlConfig} from '../../../@core/common/URLs/common-url.config';
import { AppConstants } from '../../../@core/common/constants';
import { NavigationUtils } from '../../_utils/navigation-utils.service';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'worker4e',
    templateUrl: './worker4e.component.html',
    styleUrls: ['./worker4e.component.scss'],
    standalone: false
})
export class Worker4eComponent implements OnInit {
    fosterCare!: FormGroup;
    gap!: FormGroup;
    adoption!: FormGroup;
    acaform!: FormGroup;
    approvalform!: FormGroup;
    caseCloseureChart!: HighChartOptions;
    taskClosurechart!: HighChartOptions;
    closedCasesToday!: number;
    closedCasesWeek!: number;
    averageclosurerate!: number;
    closedCompliance!: number;
    openCompliance!: number;
    irRatio!: number;
    arRatio!: number;
    closedCases!: number;
    openCases!: number;
    totalCases!: number;
    irCase!: number;
    arCase!: number;
    taskclosed!: number;
    taskCompliance!: number;
    totaltask!: number;
    opentask!: number;
    showCaseChart!: boolean;
    showTaskChart!: boolean;
    clientId = '';
    approvalData: any = [];
    approvalListData: any = [];
    selectedStatus = 'OPEN';
    add = {
        test2: '',
        test3: '',
        test4: ''
    };
    moreData: any;
    display = false;
    clientdata: any;
    bookFilteredList: {
        'CLIENTID': string; 'FULLNAME': string; 'REMOVALDATE': string; 'JURISDICTION': string; 'AGENCY': string; 'ELIGIBILITYSTATUS': string; 'TYPE': string; 'ASSIGNDATE': string;
        'STATUS': string; 'SPECIALISTNAME': string;
    }[]=[];
    intakesData:any[]= [];
    intakesMasterData:any[]= [];
    fcCount!: number;
    gapCount!: number;
    adopCount!: number;
    acaCount!: number;
    closureCount!: number;
    approvalCount!: number;
    gapintakesData: any;
    gapintakesMasterData: any;
    adoptionintakesData: any;
    adoptionintakesMasterData: any;
    acaintakesData: any;
    closureData: any;
    acaintakesMasterData: any;
    paginationInfo: PaginationInfo = new PaginationInfo();
    gapPaginationInfo: PaginationInfo = new PaginationInfo();
    adopPaginationInfo: PaginationInfo = new PaginationInfo();
    acaPaginationInfo: PaginationInfo = new PaginationInfo();
    approvalPaginationInfo: PaginationInfo = new PaginationInfo();
    closurePaginationInfo: PaginationInfo = new PaginationInfo();
    p: any;
    activeModule: any = null;
    totalRecords!: number;
    displaysortorder!:any;
    countyDropDownItems$!: Observable<DropdownModel[]>;
    enableccrAssign!: boolean;
    bulkccrassign: any[] = [];
    countylistdropdown: any[] = [];
    getUsersList!: any[];
    selectedRecord: any;
    ccrAssignform!: FormGroup;
    selectedPerson: any;
    reverse = 0;
    dashboardname = 'IV-E SPECIALIST';
    role = 'IVESP';
    sendForApprovalccrId = '#sendForApprovalccr';
    caseassignccrId = '#caseassignccr';
    myTaskForm!: FormGroup;
    taskbulkassign: any[] = [];
    enableTaskAssign!: boolean;
    myTasklist: any[] = [];
    myTaskDetailsData: any;
    myTaskDetailsColumns: string[] = [];
    myTaskTotalCount: number = 0;
    customTaskpaginationInfo: PaginationInfo = new PaginationInfo();
    
    private router: Router;
    private _commonService: CommonHttpService;
    private _commonDropdownService: CommonDropdownsService;
    private _commonHttpService: CommonHttpService;
    private titleIVeService: Title4eService;
    private _alertService: AlertService;
    private title4eService: Title4eService;
    private _formBuilder: FormBuilder;
    private _sessionStorage: SessionStorageService;
    private _dataStore: DataStoreService;
    public _authService: AuthService;
    private navigateutil: NavigationUtils;

    constructor(private injector: Injector) {
        this.router = this.injector.get<Router>(Router); 
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService); 		 
        this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService); 
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService); 
        this.titleIVeService = this.injector.get<Title4eService>(Title4eService); 
        this._alertService = this.injector.get<AlertService>(AlertService); 
        this.title4eService = this.injector.get<Title4eService>(Title4eService); 
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder); 
        this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService); 
        this._dataStore = this.injector.get<DataStoreService>(DataStoreService); 
        this._authService = this.injector.get<AuthService>(AuthService); 
        this.navigateutil = this.injector.get<NavigationUtils>(NavigationUtils); 
    }
    user: any;
    roleName: any;
    ngOnInit() {
        this._authService.initAuthService('ivefc').subscribe(result => {
            this._authService.setAuthDetail('ivefc',result);
        });
        this.activeModule = this._sessionStorage.getItem('activeModuleNav');
        if(this.activeModule == '4E Analyst'){
            this.dashboardname = 'IV-E Eligibility Analyst' ;
            this.role = 'IVEEA';
        }
        this.fosterCare = this._formBuilder.group({
            clientId: [''],
            fname: [''],
            lname: [''],
            rdate: [''],
            eligiblestatus: [''],
            countylist: ['']
         });
         this.gap = this._formBuilder.group({
            clientId: [''],
            fname: [''],
            lname: [''],
            rdate: [''],
            eligiblestatus: [''],
            countylist: ['']
         });
         this.adoption = this._formBuilder.group({
            clientId: [''],
            fname: [''],
            lname: [''],
            rdate: [''],
            eligiblestatus: [''],
            countylist: ['']
         });
         this.acaform = this._formBuilder.group({
            clientId: [''],
            fname: [''],
            lname: [''],
            rdate: [''],
            eligiblestatus: [''],
            countylist: ['']
         });
         this.approvalform = this._formBuilder.group({
            clientId: [''],
            programtype: [''],
            approvalstatus: ['PENDING']
         });
         this.ccrAssignform = this._formBuilder.group({
            clientId: [''],
            casenumber: [''],
            status: [''],
            county : ['']
        });
        this.myTaskForm = this._formBuilder.group({
            clientId: [''],
            programtype: ['FOSTER CARE'],
            countylist: [''],
            assignedSpecialist: ['']
        });
        const userprofile =localStorage.getItem('userProfile')
        if(userprofile!=null){
         this.user = JSON.parse(userprofile);
        }
        this.searchFosterCare();
        this.loadGap();
        this.loadAdoption();
        this.loadACA();
        this.aprovalDetails(null);
        this.getTaskDetails();
        this.loadCounty('MD');
        this.getClosureDetails();
        this._dataStore.setData("FosterCare_Selected_Period",null);
        this._dataStore.setData("FosterCare_Selected_Component", null);
        this._authService.readonlyPage('read_only_access','',
        [this.fosterCare,this.gap,this.adoption,this.acaform,this.approvalform]);
    }

    aprovalDetails(approvalstatus:any) {
        const nameoftheuser = this.user.firstname + ' ' + this.user.lastname;
        const roleTypeKey = this.role;
        const approvalDashboardParam = {
            'status': '{71,74,68}',
            'clientId': this.approvalform.value.clientId ? this.approvalform.value.clientId : null,
            'roleTypeKey': roleTypeKey ? roleTypeKey : null,
            'approvalstatus' : approvalstatus ? approvalstatus : this.returnApprovalStatusFn(),
            'programtype': this.approvalform.value.programtype ? this.approvalform.value.programtype : null,
            'requestedtouser': null,
            'requestedfromuser': nameoftheuser ? nameoftheuser :null
        };
        const pagination = {
            page: this.approvalPaginationInfo.pageNumber,
            limit: this.approvalPaginationInfo.pageSize,
        }
        this.getDashboardApprovalDataFn(approvalDashboardParam, pagination);    
    }

    private returnApprovalStatusFn() {
        return this.approvalform.value.approvalstatus ? this.approvalform.value.approvalstatus : 'PENDING';
    }


    private getDashboardApprovalDataFn(approvalDashboardParam: { status: string; clientId: any; roleTypeKey: any; approvalstatus: any; programtype: any; requestedtouser: any; requestedfromuser: any; }, pagination: { page: number; limit: number; }) {
        this.title4eService.getDashboardApprovalData(approvalDashboardParam, pagination).subscribe(response => {
            if (response && response.data && Array.isArray(response.data)) {
                this.approvalData = response.data;
                if (response.data.length > 0) {
                    this.approvalform.patchValue({ approvalstatus: response.data[0].approval_status });
                }
            }
            if (response.data && response.data.length) {
                this.approvalCount = response.data[0].countdata;
            }
        });
    }

    onCaseSorted($event: any) {
        this.customTaskpaginationInfo.sortBy = $event.sortDirection;
        this.customTaskpaginationInfo.sortColumn = $event.sortColumn;
        this.getTaskDetails();
    }


    getTaskDetails() {
        const taskDashboardParam = {
            'clientid': this.myTaskForm.value.clientId ? this.myTaskForm.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'programtype': this.myTaskForm.value.programtype ? this.myTaskForm.value.programtype : null,
            'assignedspecialist': this.myTaskForm.value.assignedSpecialist ? this.myTaskForm.value.assignedSpecialist : null,
            'county': this.myTaskForm.value.countylist ? this.myTaskForm.value.countylist : null,
            'sortColumn': this.customTaskpaginationInfo.sortColumn && this.customTaskpaginationInfo.sortColumn !== 'receiveddate'   ? this.customTaskpaginationInfo.sortColumn : 'duedate',
            'sortBy': this.customTaskpaginationInfo.sortBy  ? this.customTaskpaginationInfo.sortBy : 'asc',

        };
        const pagination = {
            page: this.customTaskpaginationInfo.pageNumber,
            limit: this.customTaskpaginationInfo.pageSize,
        }
        this.titleIVeService.getMyTaskDashboard(taskDashboardParam, pagination).subscribe(response => {
            this.taskbulkassign = [];
            this.enableTaskAssign = false
            if (response && response.data && Array.isArray(response.data) && response.data.length) {
                response.data.forEach(element => {
                    element.format_due_status = Math.abs(element.due_status);
                });
                this.myTaskDetailsData = response.data;
                this.myTaskTotalCount = response.data[0].countdata;
            } else {
                this.myTaskDetailsData = null;
                this.myTaskTotalCount = 0;
            }
            
        });
    }

  

    searchFosterCare() {
        const fosterCareDashboardParam = {
            'status': '{70}',
            'eventType' : 'Fostercare',
            'fname' : this.fosterCare.value.fname ? this.fosterCare.value.fname.trim() : null,
            'lname' : this.fosterCare.value.lname ? this.fosterCare.value.lname.trim() : null,
            'clientId': this.fosterCare.value.clientId ? this.fosterCare.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'rdate': this.fosterCare.value.rdate ? moment(this.fosterCare.value.rdate).format('MM-DD-YYYY') : null,
            'eligiblestatus': this.fosterCare.value.eligiblestatus ? this.fosterCare.value.eligiblestatus : null,
            'county': this.fosterCare.value.countylist ? this.fosterCare.value.countylist : null,
            'sortingorder': this.displaysortorder ? this.displaysortorder : null
        };
        const pagination = {
            page: this.paginationInfo.pageNumber,
            limit: this.paginationInfo.pageSize,
        }
        this.title4eService.getDashboardData(fosterCareDashboardParam, pagination).subscribe(response => {
            if (response && response.data && Array.isArray(response.data)) {
                this.intakesData = response.data;
                this.intakesMasterData = response.data;
                if (response.data && response.data.length) {
                  this.fcCount = response.data[0].countdata;
                }
            }
        });
    }

    pageChanged(pageNumber: any) {
        this.paginationInfo.pageNumber = pageNumber.page;
        this.searchFosterCare();
    }
    gapPageChanged(pageNumber: any) {
        this.gapPaginationInfo.pageNumber =  pageNumber.page;
        this.loadGap();
    }
    adopPageChanged(pageNumber: any) {
        this.adopPaginationInfo.pageNumber =  pageNumber.page;
        this.loadAdoption();
    }
    acaPageChanged(pageNumber: any) {
        this.acaPaginationInfo.pageNumber =  pageNumber.page;
        this.loadACA();
    }

    approvalPageChanged(pageNumber: any) {
        this.approvalPaginationInfo.pageNumber =  pageNumber.page;
        this.aprovalDetails(null);
    }
    loadGap() {
        const gapDashboardParam = {
            'status': '{73}',
            'eventType' : 'Gap',
            'fname' : this.gap.value.fname ? this.gap.value.fname.trim() : null,
            'lname' : this.gap.value.lname ? this.gap.value.lname.trim() : null,
            'clientId': this.gap.value.clientId ? this.gap.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'rdate':  null,
            'eligiblestatus': this.gap.value.eligiblestatus ? this.gap.value.eligiblestatus : null,
            'county': this.gap.value.countylist ? this.gap.value.countylist : null,

        };
        const pagination = {
            page: this.gapPaginationInfo.pageNumber,
            limit: this.gapPaginationInfo.pageSize,
        }
        this.title4eService.getDashboardData(gapDashboardParam, pagination).subscribe(response => {
            if (response && response.data && Array.isArray(response.data)) {
                this.gapintakesData = response.data;
                this.gapintakesMasterData = response.data;
                if (response.data && response.data.length) {
                    this.gapCount = response.data[0].countdata;
                }
            }
        });
    }
    loadAdoption() {
        const adoptionDashboardParam = {
            'status': '{67}',
            'eventType' : 'Adoption',
            'fname' : this.adoption.value.fname ? this.adoption.value.fname.trim() : null,
            'lname' : this.adoption.value.lname ? this.adoption.value.lname.trim() : null,
            'clientId': this.adoption.value.clientId ? this.adoption.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'rdate':  null,
            'eligiblestatus': this.adoption.value.eligiblestatus ? this.adoption.value.eligiblestatus : null,
            'county': this.adoption.value.countylist ? this.adoption.value.countylist : null,
        };
        const pagination = {
            page: this.adopPaginationInfo.pageNumber,
            limit: this.adopPaginationInfo.pageSize,
        }
        this.title4eService.getDashboardData(adoptionDashboardParam, pagination).subscribe(response => {
            if (response && response.data && Array.isArray(response.data)) {
                this.adoptionintakesData = response.data;
                this.adoptionintakesMasterData = response.data;
                if (response.data && response.data.length) {
                    this.adopCount = response.data[0].countdata;
                }
            }
        });
    }

    loadACA() {
        const adoptionDashboardParam = {
            'status': '{67}',
            'eventType' : 'ACA',
            'fname' : this.acaform.value.fname ? this.acaform.value.fname.trim() : null,
            'lname' : this.acaform.value.lname ? this.acaform.value.lname.trim() : null,
            'clientId': this.acaform.value.clientId ? this.acaform.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'rdate':  null,
            'eligiblestatus': this.acaform.value.eligiblestatus ? this.acaform.value.eligiblestatus : null,
            'county': this.acaform.value.countylist ? this.acaform.value.countylist : null

        };
        const pagination = {
            page: this.acaPaginationInfo.pageNumber,
            limit: this.acaPaginationInfo.pageSize,
        }
        this.title4eService.getDashboardData(adoptionDashboardParam, pagination).subscribe(response => {
            if (response && response.data && Array.isArray(response.data)) {
                this.acaintakesData = response.data;
                this.acaintakesMasterData = response.data;
                if (response.data && response.data.length) {
                    this.acaCount = response.data[0].countdata;
                }
            }
        });
    }

    searchGap(clientid:any, removalid:any) {
        if (clientid && removalid) {
            this._dataStore.setData('guardianship_clientid',clientid);
            this._dataStore.setData('guardianship_removalid', removalid);
            this.router.navigate(['/pages/title4e/guardianship/' + clientid + '/' + removalid]);
        } 
     }

     searchAdoption(clientid:any, removalid:any, sqnm_sw:any) {
         if (clientid && removalid) {
            this._dataStore.setData('adoption_clientid', clientid);
            this._dataStore.setData('adoption_removalid', removalid);
            this.router.navigate(['/pages/title4e/adoption/' + clientid + '/' + removalid]);
            if(sqnm_sw === 'A'){
                this._dataStore.setData('adoption_dashboard', 'aca');
            } else {
                this._dataStore.setData('adoption_dashboard', 'adoption');
            }
         }
     }


     searchACA(item:any) {
         if (item) {
            this._dataStore.setData('adoption_clientid', item.clientid);
            this._dataStore.setData('adoption_removalid', item.removalid);
            this._dataStore.setData('adoption_dashboard', 'aca');
            this.router.navigate(['/pages/title4e/aca/' + item.clientid + '/' + item.removalid]);
         }
     }


     searchFoster(item:any) {
        if (item.client_id) {
            this.router.navigate(['/pages/title4e/foster-car/' + item.client_id + '/' + item.removal_id]);
        }
    }

    searchClosure(personData:any, ptype:any) {
        var url = '';
        personData.clientid = personData.cjamspid;
        if(ptype == 'gap'){
            url = '#/pages/title4e/guardianship/' + personData.cjamspid + '/' + personData.guardian_subsidy_id
            window.open(url)
        } else if(ptype == 'ooh'){
            this.navigateutil.loadFostcareIVE(personData.clientid, personData.removalid);
        } else if(ptype == 'adop') {
            url = '#/pages/title4e/adoption/' + personData.cjamspid + '/' + personData.removalid
            window.open(url)
        }
    }

    resetadop() {
        this.adoption.reset();
        this.loadAdoption();
    }
    resetaca() {
        this.acaform.reset();
        this.loadACA();
    }
    resetapproval() {
        this.approvalform.reset();
        this.approvalform.patchValue({ approvalstatus: 'PENDING'});
        this.aprovalDetails('PENDING');
    }

    resetgap() {
        this.gap.reset();
        this.loadGap();
    }
    reset() {
        this.fosterCare.reset();
        this.searchFosterCare();
    }

    resetTask() {
        this.myTaskForm.reset();
        this.myTaskForm.patchValue({ programtype: 'FOSTER CARE'});
        this.customTaskpaginationInfo.pageNumber = 1;
        this.getTaskDetails();
    }

    searchTaskDetails(){
        this.customTaskpaginationInfo.pageNumber = 1;
        this.getTaskDetails();
    }

    setOrder() {
        switch (this.reverse) {
            case 0:
                this.reverse = 1;
                this.displaysortorder = 'asc';
                this.searchFosterCare();
                break;
            case 1:
                this.reverse = 2;
                this.displaysortorder = 'desc'
                this.searchFosterCare();
                break;
            case 2:
                this.reverse = 0;
                this.displaysortorder = null;
                this.searchFosterCare();
                break;
        }
    }

    // loadCounty(state) {
    //     this._commonDropdownService.getPickListByMdmcode(state).subscribe(countyList => {
    //         this.countyDropDownItems$ = Observable.of(countyList);
    //     });
    // }

    loadCounty(statekey:any) {
        const state = statekey ? statekey : 'MD';
        this._commonService.create(
            {
                where: { state: state },
                order: 'countyname',
                method: 'post',
                nolimit: true
            },
            CommonUrlConfig.EndPoint.Listing.CountyListUrl
        ).subscribe(response => {
            // Filtering DHS Central and Central office from county list on IVE dashboard
            const removeCounties = ['DHS Central', 'Central Office', 'DHRIS', 'SSC','OIG'];
            this.countylistdropdown = response.filter((a:any) => !removeCounties.includes(a.countyname));
        });

    }

    getClosureDetails() {
        const closureDashboardParam = {
            roleid: 'IVECCR',
            fromsecurityusersid: null,
            tosecurityuserid: this.user.securityusersid,
            casenumber: this.ccrAssignform.value.casenumber ? this.ccrAssignform.value.casenumber.trim() : null,
            clientId: this.ccrAssignform.value.clientId ? this.ccrAssignform.value.clientId.trim() : null,
            status: this.ccrAssignform.value.status ? this.ccrAssignform.value.status.trim() : null,
            county: this.ccrAssignform.value.county ? this.ccrAssignform.value.county : null
        };
        const pagination = {
            page: this.closurePaginationInfo.pageNumber,
            limit: this.closurePaginationInfo.pageSize,
        }
        this.titleIVeService.getClosureDashboardData(closureDashboardParam, pagination).subscribe(response => {
            this.enableccrAssign = false;
            if (response && response.data && Array.isArray(response.data)) {
                this.closureData = response.data;
            }
            if (this.closureData && this.closureData.length) {
                this.closureCount = this.closureData[0].countdata;
            }else{
                this.closureCount = 0;
            }
        });
    }

    resetccrAssign() {
        this.ccrAssignform.reset();
        this.getClosureDetails();
    }

    getprogramtype(programs:any){
        return programs.map((programkey:any)=>programkey).join(' / ');
    }

    searchTaskDashboard(item: any) {
        if(item.program_type == 'FOSTER CARE') {
            this.router.navigate(['/pages/title4e/foster-car/' + item.clientid + '/' + item.removal_id]);
        } else if(item.program_type == 'ADOPTION') {
            this.router.navigate(['/pages/title4e/adoption/' + item.clientid + '/' + item.removal_id]);
            this._dataStore.setData('adoption_clientid', item.clientid);
            this._dataStore.setData('adoption_removalid', item.removal_id);
            this._dataStore.setData('adoption_dashboard', 'adoption');
            this._dataStore.setData('adoption_migrated_data', item);
        } else if(item.program_type == 'GAP') {
            this._dataStore.setData('guardianship_clientid', item.clientid);
            this.router.navigate(['/pages/title4e/guardianship/' + item.clientid + '/' + item.removal_id]);
        } 
    }

    navigateCaseNumber(data: any) {
        if (data.casetype === 'servicecase') {
            const casedata = {
                intakeserviceid: data.caseid,
                casenumber: data.casenumber,
                danumber: data.casenumber,
                datype: 'Request for services'
            }
            this.navigateutil.openRespectiveItem(casedata);
        }
        if (data.casetype === 'adoptioncase') {
            const casedata = {
                servicerequestnumber: data.caseid,
                adoptioncaseid: data.caseid,
                adoptioncasenumber: data.casenumber,
                startdate: data.startdate
            }
            this.navigateutil.routToAdoptionCase(casedata);
        }
    }

    sendforApproval(details:any, proceedCheck:any) {
        if(details) {
            this.selectedRecord = details
          }
        if(proceedCheck) {
            this.titleIVeService.getUsersList().subscribe(result => {
              this.getUsersList = result.data.filter(user => user.rolecode === AppConstants.ROLES.TITLE_IVE_SUPERVISOR && user.userid !== this.user.securityusersid);
            });
            $(this.sendForApprovalccrId).modal('hide');
            $(this.caseassignccrId).modal('show');
        } else {
            $(this.sendForApprovalccrId).modal('show');
        }
    }

    clearCaseClosureItem() {
        $(this.sendForApprovalccrId).modal('hide');
    }

    selectPerson(item:any) {
        this.selectedPerson = item;
    }


    sendforApprovalCCR() {
        const data = {
            'where': {
                'assignedtoid': this.selectedPerson.userid,
                'eventcode': 'IVECCR',
                'objectid': this.selectedRecord.ivecaseclosurereviewid,
                'userprofilerole': this.role,
                'touserrole': this.selectedPerson.rolecode,
                'servicecaseid': this.selectedRecord.caseid,
                'status': 203,
                'notifymsg': `${this.selectedRecord.assignedto} has reviewed the case closure request for case ${this.selectedRecord.casenumber},  Please approve the case closure request.`,
                'comments': 'Case Closure Review sent from Specialist to Supervisor',
                'routeddescription': 'Case Closure Review sent from Specialist to Supervisor'
            }
        };
        this._commonHttpService.create(data,'titleive/ive/assignspecialist').subscribe(response => {
            this.getClosureDetails();
            this._alertService.success('Case Assigned Successfully ');
            $(this.caseassignccrId).modal('hide');
        });
    }

    closurePageChanged(pageNumber: any) {
        this.closurePaginationInfo.pageNumber = pageNumber.page;
        this.getClosureDetails();
    }

    downloadApprovalSection() {

        let nameoftheuser = this.user.firstname + ' ' + this.user.lastname;
        let namefromuser;
        let roleTypeKey = this.role;
        let userRoleType = this.dashboardname;
        if (this.activeModule && this.activeModule === '4E SUPERVISOR') {
            namefromuser = this.user.firstname + ' ' + this.user.lastname;
            nameoftheuser = '';
            roleTypeKey = 'IVESV';
            userRoleType = 'IV-E Supervisor';
        }
        const modal = {
            method: 'post',
            where: {
                documenttemplatekey: ['iveapprovalsection'],
                isheaderrequired: false,
                status: '{71,74,68}',
                clientId: this.approvalform.value.clientId ? this.approvalform.value.clientId : null,
                roleTypeKey: roleTypeKey ? roleTypeKey : null,
                approvalstatus: this.approvalform.value.approvalstatus ? this.approvalform.value.approvalstatus : 'PENDING',
                programtype: this.approvalform.value.programtype ? this.approvalform.value.programtype : null,
                requestedtouser: namefromuser ? namefromuser : null,
                requestedfromuser: nameoftheuser ? nameoftheuser : null,
                userName: nameoftheuser ? nameoftheuser : null,
                userRoleType: userRoleType ? userRoleType : null
            },
            limit: 10,
            order: 'desc',
            page: 1,
            count: -1
        };
        this._commonService.download('evaluationdocument/generateintakedocument', modal)
            .subscribe(res => {
                const blob = new Blob([new Uint8Array(res)]);
                const link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = `iveApprovalSectionPDF.pdf`;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });
    }


}
