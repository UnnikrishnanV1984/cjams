import { Component, Injector, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { HighChartOptions } from '../_entities/home-dash-entities';
import { CommonDropdownsService, CommonHttpService, AuthService, SessionStorageService, AlertService, DataStoreService } from '../../../@core/services';
import { Title4eService } from '../services/title4e.service';
import { DropdownModel, PaginationRequest, PaginationInfo, ListDataItem } from '../../../@core/entities/common.entities';
import { FormGroup, FormBuilder } from '@angular/forms';
import moment from 'moment';
import { Observable } from 'rxjs';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
import { AppConstants } from '../../../@core/common/constants';
import { NavigationUtils } from '../../_utils/navigation-utils.service';
declare var $: any;
import { AppUser } from '../../../@core/entities/authDataModel';
@Component({

    // tslint:disable-next-line:component-selector
    selector: 'dashboard4e',
    templateUrl: './dashboard4e.component.html',
    styleUrls: ['./dashboard4e.component.scss'],
    standalone: false
})
export class Dashboard4eComponent implements OnInit {
    fosterCare!: FormGroup;
    caseCloseureChart!: HighChartOptions;
    taskClosurechart: HighChartOptions| undefined;
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
    bookFilteredList!: {
        'CLIENTID': string; 'FULLNAME': string; 'REMOVALDATE': string; 'JURISDICTION': string; 'AGENCY': string; 'ELIGIBILITYSTATUS': string; 'TYPE': string; 'ASSIGNDATE': string;
        'STATUS': string; 'SPECIALISTNAME': string;
    }[];
    intakesData = [];
    intakesMasterData = [];
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
    p: any;
    activeModule: any = null;
    totalRecords!: number;
    displaysortorder!: string | null;
    countyDropDownItems$!: Observable<DropdownModel[]>;
    enableccrAssign!: boolean;
    bulkccrassign: any[] = [];
    countylistdropdown: any[] = [];
    getUsersList!: any[];
    selectedRecord: any;
    //ccrAssignform: FormGroup;
    selectedPerson: any;
    maxDate: Date = new Date();
    reverse = 0;
    dashboardname = 'IV-E SPECIALIST';
    role = 'IVESP';
    sendForApprovalccrId = '#sendForApprovalccr';
    caseassignccrId = '#caseassignccr';
    //myTaskForm: FormGroup;
    taskbulkassign: any[] = [];
    enableTaskAssign!: boolean;
    myTasklist!: any[];
    myTaskDetailsData!: any[];
    myTaskDetailsColumns!: string[];
    myTaskTotalCount: number = 0;
    customTaskpaginationInfo: PaginationInfo = new PaginationInfo();

    gridConfig: any;
    selectedGrid!: string ;
    mainGridData = [];
    mainGridColumns: string[] = [];
    mainGridKeys = [];
    totalcount = 0;
    userRole: any;


    assignedSearchCriteria!: any;
    totalRecordsSupervisor!: number;
    supervisorDetails: any;
    closureApprovalCount!: number;
    fosterCareData: any = [];
    fosterCareMasterData: any = [];
    guardianShipData: any = [];
    guardianShipMasterData: any = [];
    adoptionData: any = [];
    acaData: any = [];
    closureApprovalData: any = [];
    adoptionMasterData: any = [];
    acaMasterData: any = [];
    specialistList!: any[];
    fosterCareApprovalData: any = [];
    guardianShipApprovalData: any = [];
    adoptionApprovalData: any = [];
    workersList: any[] = [];
    user: any;
    roleName: any;
    selectedccr: any;
    selectAssignBulk!: boolean;
    routeData: any;
    onPaginationInfo: PaginationInfo = new PaginationInfo();
    aprvl: any;
    enableAssignBtn!: boolean;
    enablefcAssign!: boolean;
    enablegapAssign!: boolean;
    enableacaAssign!: boolean;
    enableadpAssign!: boolean;
    bulkassign: any[] = [];
    // bulkfcassign: any[] = [];
    // bulkgapassign: any[] = [];
    // bulkacaassign: any[] = [];
    // bulkadpassign: any[] = [];
    isassignedstr = ' is assigned';
    assignspecialisturl = 'titleive/ive/assignspecialist';
    caseassignedmsg = 'Case Assigned Successfully ';
    ivestatusCode = 201;
    supervisorList: any = [];
    roleId!: AppUser;
    currentUser!: string;
    selectedApprovalStatus: string = '';
    //selectedApprovalStatus: string;
    programTypeStatus: string = '';
    totalcountlist = {};


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

    progressselected: any;
    // categories = ['Demographics', 'Removal Type', 'Removal Home', 'Court Order', 'Income Summary', 'Asset', 'Deprivation'];
    categories: any;
    // series = [{
    //     name: '', data: []
    // }];
    series : any;
    fosterCareCount: any;
    fosterCarewidgetcount: any;
    widgetcount: any;
    selectedeligibility!: string;
    gapwidgetcount: any;

    widgetlist =[{name:'Foster Care',description:'FosterCare', img:'assets/images/ive-dashboard/fostercare.svg' ,hide:''},
                 {name:'Guardianship',description:'Guardianship', img:'assets/images/ive-dashboard/guardianship.svg',hide:''},
                 {name:'Adoption',description:'Adoption', img:'assets/images/ive-dashboard/adoption.svg',hide:''},
                 {name:'Adoption Applicability',description:'AdoptionApplicability', img:'assets/images/ive-dashboard/adoption_applicability.svg',hide:''},
                 {name:'Approvals',description:'Approvals', img:'assets/images/ive-dashboard/approvals.svg',hide:''},
                 {name:'Case Closure Review',description:'CaseClosureReview', img:'assets/images/ive-dashboard/case_closure.svg',hide:''},
                 {name:'Case Closure Approval',description:'CaseClosureApproval', img:'assets/images/ive-dashboard/case_closure.svg',hide:'ive-specialist'},
                 {name:'My Tasks',description:'MyAlerts', img:'assets/images/ive-dashboard/my_alerts.svg',hide:''}
                ]
    resetbutton: boolean =false;
    hideunassigned: boolean=false;
    fromsearch: boolean =false;
    progressbarreload!: boolean;
    gridName: string ='Foster Care';
    myalertscount: any;
    returntodashboard!: boolean;
    

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
    ngOnInit() {

        this._authService.initAuthService('ivefc').subscribe(result => {
            this._authService.setAuthDetail('ivefc', result);
        });

        // Supervisor Login
        this.activeModule = this._sessionStorage.getItem('activeModuleNav');
       
         
        if (this.activeModule == '4E QA') {
            this.dashboardname = 'IV-E Eligibility Quality Assurance';
            this.role = 'IVEQA';
        } else if (this.activeModule == '4E Adminstrator') {
            this.dashboardname = 'IV-E Eligibility Administrator';
            this.role = 'IVEADMIN';
        } else if (this.activeModule == '4E AdminAssist') {
            this.dashboardname = 'IV-E Eligibility Administrator Assistant';
            this.role = 'IVEAA';
        } else if (this.activeModule == '4E SUPERVISOR') {
            this.dashboardname = 'IV-E SUPERVISOR';
            this.role = 'IVESV';
        }

        // Specialist Login
        if (this.activeModule == '4E Analyst') {
            this.dashboardname = 'IV-E Eligibility Analyst';
            this.role = 'IVEEA';
        } else if (this.activeModule == ' 4E SPECIALIST') {
            this.dashboardname = 'IV-E SPECIALIST';
        }

        this.fosterCare = this._formBuilder.group({
            casenumber: [''],
            clientId: [''],
            fname: [''],
            lname: [''],
            rdate: [''],
            todate: [''],
            eligiblestatus: [''],
            countylist: [''],
            assignedSpecialist: [''],
            programtype: [''],
            approvalstatus: [''],
            //approvalstatus: [''],
            status: [''],
            securityusersid: [''],
        });

        // setting user role based on activeModule flag
        this.setUserRole();

        // supervisor specific api calls
        if (this.userRole === 'ive-supervisor') {
            this.loadIVeSpecialist();
            this.getWorkersList();

            // this._authService.readonlyPage('titleive_read_only_access', '',
            //     [this.fosterCare]); CDM-44864 commented to enable search filter for all IV-E users

            this.roleId = this._authService.getCurrentUser();
            if (this.roleId && this.roleId.user && this.roleId.user.userprofile) {
                const user = this.roleId.user.userprofile;
                this.currentUser = (user.lastname ? user.lastname : '') + ',    ' + (user.firstname ? user.firstname : '');
            }
            this.loadSupervisor();
            this._authService.readonlyPage('read_only_access', '',
                [this.fosterCare]);
        } else if (this.userRole === 'ive-specialist') {
            this._authService.readonlyPage('read_only_access', '',
                [this.fosterCare]);
        }


        // this.fosterCare = this._formBuilder.group({
        //     casenumber: [''],
        //     clientId: [''],
        //     fname: [''],
        //     lname: [''],
        //     rdate: [''],
        //     todate: [''],
        //     eligiblestatus: [''],
        //     countylist: [''],
        //     assignedSpecialist: [''],
        //     programtype: [''],
        //     approvalstatus: [''],
        //     //approvalstatus: [''],
        //     status: [''],
        //     securityusersid: [''],
        // });

        // this.gap = this._formBuilder.group({
        //     clientId: [''],
        //     fname: [''],
        //     lname: [''],
        //     rdate: [''],
        //     eligiblestatus: [''],
        //     countylist: ['']
        // });
        // this.adoption = this._formBuilder.group({
        //     clientId: [''],
        //     fname: [''],
        //     lname: [''],
        //     rdate: [''],
        //     eligiblestatus: [''],
        //     countylist: ['']
        // });
        // this.acaform = this._formBuilder.group({
        //     clientId: [''],
        //     fname: [''],
        //     lname: [''],
        //     rdate: [''],
        //     eligiblestatus: [''],
        //     countylist: ['']
        // });
        // this.fosterCare = this._formBuilder.group({
        //     clientId: [''],
        //     programtype: [''],
        //     approvalstatus: ['PENDING']
        // });
        // this.ccrAssignform = this._formBuilder.group({
        //     clientId: [''],
        //     casenumber: [''],
        //     status: [''],
        //     county: ['']
        // });
        // this.myTaskForm = this._formBuilder.group({
        //     clientId: [''],
        //     programtype: ['FOSTER CARE'],
        //     countylist: [''],
        //     assignedSpecialist: ['']
        // });
          this.user = JSON.parse(localStorage.getItem('userProfile')?? "");
        this.loadCounty('MD');
        this._dataStore.setData("FosterCare_Selected_Period", null);
        this._dataStore.setData("FosterCare_Selected_Component", null);
        // this.selectedGrid= this._dataStore.getData('titleiveselectedgrid') ? this._dataStore.getData('titleiveselectedgrid') :'FosterCare' ;
        if(this._dataStore.getData('titleiveselectedgrid')){
            this.selectedGrid= this._dataStore.getData('titleiveselectedgrid');
            this.returntodashboard =true
            this.loadMainGrid(this.selectedGrid,'returntodashboard') 
            // this._dataStore.setData('titleiveselectedgrid','');
            
            
        } else{
            
        this.loadMainGrid('FosterCare', 'Initial');
        this.selectedGrid='FosterCare';
        }
    }

    setUserRole(): void {
        if (this.activeModule === '4E SUPERVISOR' || this.activeModule === '4E QA' || this.activeModule === '4E Adminstrator' || this.activeModule === '4E AdminAssist') {
            this.userRole = 'ive-supervisor';

        } else if (this.activeModule === '4E Analyst' || this.activeModule === '4E SPECIALIST') {
            this.userRole = 'ive-specialist';
        }
    }

    displayList(type: string,source?:string) {
        this.paginationInfo.pageNumber = 1;
        if(source ==='progress-bar'){
          this.progressbarreload = true;
        //   this.fosterCare.reset();
        }
        else{
            this.progressbarreload=false;
            this.selectedApprovalStatus='';
        }
        // else{
        if (type === 'search') {
             this.totalcount = 0;
            this.totalCases =0;
            this.widgetcount = [];
            this.progressselected = '';
            this.fromsearch= true;
        
           // this.selectedApprovalStatus='';
           // this.selectedeligibility ='';
            // if(this.fosterCare.value.eligiblestatus.includes(['Eligible Reimbursable','Eligible Non-Reimbursable' ,'Ineligible'])){
                if(this.selectedGrid ==='FosterCare' && this.fosterCare?.value.eligiblestatus){
                if(['Eligible Reimbursable','Eligible Non-Reimbursable' ,'Ineligible'].some(item=>this.fosterCare?.value.eligiblestatus.includes(item))){

                // Eligible Reimbursable Eligible Non-Reimbursable Ineligible
                this.progressselected ='completed'

                }

            }
            this.titleIVeService.setprogressselectedactive(this.progressselected);
            this.titleIVeService.seteligibilityselectedactive(this.selectedeligibility);

            if(this.fosterCare.value.assignedSpecialist){
                this.hideunassigned =true;
            } else{
                this.hideunassigned = false;
            }
            this.loadMainGrid(this.selectedGrid);

        } else {
            this.resetgrid();
            if(!this.progressbarreload) {
                this.fosterCare.reset();
            }
            this.fromsearch=false;
            this.titleIVeService.setprogressselectedactive(this.progressselected);
            this.titleIVeService.seteligibilityselectedactive(this.selectedeligibility);
            this.selectedGrid = type;
            this.loadMainGrid(type);
        }
    // }

    }

    onApprovalStatusChange(value: string) {
        this.selectedApprovalStatus = value;
    }

    onProgramTypeChange(value: string) {
        this.programTypeStatus = value;
    }

    resetgrid() {
        // this.selectedeligibility ='';
        // this.progressselected='';
        this.totalcount = 0;
        this.totalCases =0;
        
        // this.widgetcount = [];
        //  this.selectedApprovalStatus='';
    }
    loadMainGrid(selectedGrid: any, status?: any) {
        let statusValue;
        if(this.selectedGrid === 'Approvals'){
            if(!this.fromsearch){
                statusValue = this.selectedApprovalStatus ? this.selectedApprovalStatus :null;

            }else {
            statusValue = this.returnApprovalStatusFn();
            }
            // statusValue = this.returnApprovalStatusFn();
        } else {
            statusValue = this.selectedGrid === 'MyAlerts' ? this.programTypeStatus : this.selectedApprovalStatus;
        }
        if (status !== 'pagechange' && !this.progressbarreload ||(this.selectedGrid=='Approvals' && status !=='Initial')) {
            this.gridConfig = this.title4eService.getGridConfig(selectedGrid, this.userRole, statusValue);
            if(this.gridConfig){
            this.gridConfig.data = [];
            }
            this.bulkassign = [];
            this.enableAssignBtn = false;
        }
        if (status == 'Initial') {
            // this.loadGap('Initial');
            // this.loadAdoption('Initial');
            // this.loadACA('Initial');
            // this.aprovalDetails(statusValue, 'Initial');
            // this.getTaskDetails('Initial');
            // this.getClosureApproval('Initial');
            // this.getClosureDetails('Initial');
            
            // setTimeout(() => {
                this.loadFosterCare('Initial');
                // this.totalCases =this.fcCount;
                
            // }, 3000);
            



        // } else if(status =='returntodashboard'){
        //     this.loadFosterCare('returntodashboard');

        }
        else {
            if (selectedGrid == 'FosterCare') {
                this.gridName ='Foster Care'
                this.loadFosterCare();
            } else if (selectedGrid == 'Guardianship') {
                this.gridName ='Guardianship'
                this.loadGap();
            } else if (selectedGrid == 'Adoption') {
                this.gridName ='Adoption'
                this.loadAdoption();
            } else if (selectedGrid == 'AdoptionApplicability') {
                this.gridName ='Adoption Applicability'
                this.loadACA();
            } else if (selectedGrid == 'CaseClosureReview') {
                if(this.userRole == 'ive-specialist') {
                  this.gridName ='Case Closure Review'
                } else {
                  this.gridName ='Case Closure Assignment'
                }
                this.getClosureDetails();
            } else if (selectedGrid == 'CaseClosureApproval') {
                this.gridName ='Case Closure Approval'
                this.getClosureApproval();
            } else if (selectedGrid == 'Approvals') {
                this.gridName ='Approvals'
                this.aprovalDetails(statusValue);
            } else if (selectedGrid == 'MyAlerts') {
                this.gridName ='My Tasks'
                this.getTaskDetails();
            }
        }
    }


    // gridSelect(value): void {
    //     this.selectedGrid = value;
    //     this.loadMainGrid(value);
    // }

    callSearchAPI(value: any): void {

    }

    onSortedlist(data:any): void {
        data = JSON.parse(data);
        this.customTaskpaginationInfo.sortBy = data.sortDirection;
        this.customTaskpaginationInfo.sortColumn = data.sortColumn;

        this.displaysortorder = data.sortDirection;
        this.loadMainGrid(this.selectedGrid);
    }

    aprovalDetails(approvalstatus?:string,status?:string) {

        if(status === 'Initial'){
            this.fosterCare.patchValue({ programtype: null });
        }

        const nameoftheuser = this.user.firstname + ' ' + this.user.lastname;
        const roleTypeKey = this.role;
        const approvalDashboardParam = {
            'status': '{71,74,68}',
            'clientId': this.fosterCare.value.clientId ? this.fosterCare.value.clientId.trim() : null,
            'roleTypeKey': roleTypeKey ? roleTypeKey : null,
            'approvalstatus': approvalstatus ? approvalstatus : this.returnApprovalStatusFn(),
            'programtype': this.fosterCare.value.programtype ? this.fosterCare.value.programtype : null,
            'eventType': this.fosterCare.value.programtype ? this.fosterCare.value.programtype : null,
            'eligiblestatus':  approvalstatus ? approvalstatus : this.returnApprovalStatusFn(),
            'requestedtouser': this.userRole === 'ive-supervisor' ? nameoftheuser ? nameoftheuser : null : null,
            'requestedfromuser':this.getrequestedfromuser(nameoftheuser),             
            'filtertype':'Approvals',
             'countstatus' : status ? status : null
            
             

        };
        const pagination = {
            page: this.paginationInfo.pageNumber,
            limit: this.paginationInfo.pageSize,
        }
        this.getDashboardApprovalDataFn(status,approvalDashboardParam, pagination);
    }

    private returnApprovalStatusFn() {
        // return this.fosterCare.value.approvalstatus ? this.fosterCare.value.approvalstatus : 'PENDING';
        return this.fosterCare.value.approvalstatus ? this.fosterCare.value.approvalstatus : null;
    }


    private getDashboardApprovalDataFn(status:any,approvalDashboardParam: { status: any; clientId: any; roleTypeKey: any; approvalstatus: any; programtype: any; requestedtouser: any; requestedfromuser: string; }, pagination: { page: number; limit: number; }) {
        this.selectedApprovalStatus = approvalDashboardParam.approvalstatus;
        if(this.progressbarreload){
            this.getApprovaldashboarddata(status,approvalDashboardParam, pagination)

        }
        else{
           this. getApprovaldashboardandwidgetdata(status,approvalDashboardParam, pagination)
        }
        this.selectedApprovalStatus = approvalDashboardParam.approvalstatus;
        // this.title4eService.getDashboardWidgetApprovalData(approvalDashboardParam, pagination).subscribe(response => {
        //     if (response && response.data && response.data.data && Array.isArray(response.data.data)) {
        //         this.approvalData = response.data.data[0];
        //         this.gridConfig.data = response.data.data.map(item => ({
        //             ...item,
        //             sqnm_sw: item?.sqnm_sw ? item.sqnm_sw : 'I',
        //             approval_status: item?.approval_status === 'PENDING' ? 'REVIEW' : item?.approval_status
        //         }));
        //         // if (response.data.data.length > 0) {
        //         //     this.fosterCare.patchValue({ approvalstatus: response.data.data[0].approval_status });
        //         // }
        //     }
        //     if (response.data && response.data.data.length) {
        //         if(!this.approvalCount){
        //         this.approvalCount = response.data.data[0].countdata;
        //         this.totalcountlist ={...this.totalcountlist,Approvals:this.approvalCount};
        //         }
        //         // this.totalcount = response.data[0].countdata;
        //         //'Approvals');

        //         // ***************
        //         this.totalcount = this.approvalCount;
        //             // this.widgetcount = response.widgetcount.fostercarecountdetails[0];
        //             // this.approvalCount = response.data.data[0].countdata;
        //             // if (status) {
        //             //     this.fcCount = response.data.data[0].countdata;
        //             // }
        //              this.totalCases = this.fromsearch ? response.data.data[0].countdata: this.approvalCount;
        //         // }
        //         // this.totalCases=response.data.data[0].countdata;
               
        //         this.widgetcount = response.widgetcount.fostercarecountdetails[0];
        //         // *******************
        //     }
        // });
    }
    getApprovaldashboardandwidgetdata(status:any,approvalDashboardParam: { status: string; clientId: any; roleTypeKey: string; approvalstatus: any; programtype: any; requestedtouser: any; requestedfromuser: string; }, pagination: { page: number; limit: number; }){
        this.title4eService.getDashboardWidgetApprovalData(approvalDashboardParam, pagination).subscribe(response => {
            if (response && response.data && response.data.data && Array.isArray(response.data.data)) {
                this.approvalData = response.data.data[0];
                if(status !=='Initial'){
                this.gridConfig.data = response.data.data.map(item => ({
                    ...item,
                    sqnm_sw: item?.sqnm_sw ? item.sqnm_sw : 'I',
                    approval_status: item?.approval_status === 'PENDING' ? 'REVIEW' : item?.approval_status
                }));
            }
                // if (response.data.data.length > 0) {
                //     this.fosterCare.patchValue({ approvalstatus: response.data.data[0].approval_status });
                // }
            }
            if (response.data && response.data.data.length) {
                this.totalcount =  response.data.data[0].countdata;
                
                    if(!this.approvalCount || status === 'Initial') {
                    // this.approvalCount = response.data.data[0].countdata;
                    const totValue = response.widgetcount.fostercarecountdetails[0];
                    this.approvalCount = totValue.approvedcount + totValue.pendingcount + totValue.rejectedcount;
                    if(this.returntodashboard){
                        this.totalcountlist = this._dataStore.getData('totalcountlist');
                    }else {
                    this.totalcountlist ={...this.totalcountlist,Approvals:this.approvalCount};
                    }
                } 
        
                if(status !=='Initial'){
                
                this.totalCases = this.fromsearch ? response.data.data[0].countdata: this.approvalCount;
                
               
                this.widgetcount = response.widgetcount.fostercarecountdetails[0];
                }
                
            }
            else{
                this.totalCases = this.approvalCount;
                if(response.data && response.data.data.length ==0)
                this.totalCases=0;
                this.totalcount=0;
                this.widgetcount =[];
                // this.totalcountlist ={...this.totalcountlist,Approvals:0};
            }
        });
    }
    getApprovaldashboarddata(status:any,approvalDashboardParam: { status: string; clientId: any; roleTypeKey: string; approvalstatus: any; programtype: any; requestedtouser: any; requestedfromuser: string; }, pagination: { page: number; limit: number; })
{
    this.title4eService.getDashboardApprovalData(approvalDashboardParam, pagination).subscribe(response => {
        if (response && response.data && Array.isArray(response.data)) {
            this.approvalData = response.data[0];
            this.totalcount =  response.data[0].countdata;
            if(status!= 'Initial'){
            this.gridConfig.data = response.data.map(item => ({
                ...item,
                sqnm_sw: item?.sqnm_sw ? item.sqnm_sw : 'I',
                approval_status: item?.approval_status === 'PENDING' ? 'REVIEW' : item?.approval_status
            }));
        }
        }
        if (response.data && response.data.length) {
            if(!this.approvalCount){
            this.approvalCount = response.data[0].countdata;
            this.totalcountlist ={...this.totalcountlist,Approvals:this.approvalCount};
            }
          
           
            this.totalCases = this.fromsearch ? response.data[0].countdata: this.approvalCount;
            // }
            // this.totalCases=response.data.data[0].countdata;
           
            //this.widgetcount = response.widgetcount.fostercarecountdetails[0];
            // *******************
        }
        else{
            this.totalCases = this.approvalCount;
            this.totalcountlist ={...this.totalcountlist,Approvals:0};
        }

    });
}
    onCaseSorted($event:any) {
        this.customTaskpaginationInfo.sortBy = $event.sortDirection;
        this.customTaskpaginationInfo.sortColumn = $event.sortColumn;
        this.getTaskDetails();
    }

    updateMyAlertProgramTypeValue(): string {
        let programType: any;
        const programTypeControl = this.fosterCare.get('programtype');
        if (programTypeControl?.value === 'Fostercare') {
            programType = 'FOSTER CARE';
        } else if (programTypeControl?.value === 'Adoption') {
            programType = 'ADOPTION';
        } else if (programTypeControl?.value === 'Gap') {
            programType = 'GAP';
        }
        return programType;
    }

    getTaskDetails(status?:string) {

        const progamType = (this.fromsearch || this.progressselected) ? this.updateMyAlertProgramTypeValue() : null;

        const taskDashboardParam = {
            'clientid': this.fosterCare.value.clientId ? this.fosterCare.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'programtype': this.fosterCare.value.programtype && progamType ? progamType : null,
            'eventType': this.fosterCare.value.programtype && progamType ? progamType : null,  
            'assignedspecialist': this.fosterCare.value.assignedSpecialist ? this.fosterCare.value.assignedSpecialist : null,
            'county': this.fosterCare.value.countylist ? this.fosterCare.value.countylist : null,
            'sortColumn': this.customTaskpaginationInfo.sortColumn && this.customTaskpaginationInfo.sortColumn !== 'receiveddate' ? this.customTaskpaginationInfo.sortColumn : 'duedate',
            'sortBy': this.customTaskpaginationInfo.sortBy ? this.customTaskpaginationInfo.sortBy : 'asc',
            'filtertype': 'Mytasks',
            'eligiblestatus':this.myalertscount,
            'status': status ? status : null

        };
        const pagination = {
            page: this.paginationInfo.pageNumber,
            limit: this.paginationInfo.pageSize,
        }
        if(status =='Initial'){
            this.title4eService.getDashboardDataCountDetails(taskDashboardParam, pagination).subscribe(response => {
                if (status) {
                    if (!this.myTaskTotalCount) {
                      if(response.data && response.data.length == 0){
                        this.myTaskTotalCount =0;  
                      } else{
                        this.myTaskTotalCount = response.data[0].countdata;
                      }
                    
                    this.totalcountlist = { ...this.totalcountlist, MyAlerts: this.myTaskTotalCount};
                   }
                }
            })
         }else if(this.progressbarreload){
            this.title4eService.getMyTaskDashboard(taskDashboardParam, pagination).subscribe(response => {
                
            if (response && response.data && response.data.length) {
                response.data.forEach(element => {
                    element.format_due_status = Math.abs(element.due_status);
                });
            }
                this.dashboarddata(response,status);  
                if (!this.myTaskTotalCount) {
                    if(response.data && response.data.length == 0){
                        this.myTaskTotalCount =0;  
                    }
                    else{
                        this.myTaskTotalCount = response.data[0].countdata;
                    }
                    
                    this.totalcountlist = { ...this.totalcountlist, MyAlerts: this.myTaskTotalCount};
                }
                if(status !== 'Initial')
                this.totalCases =  this.fromsearch ? response?.data[0]?.countdata:this.myTaskTotalCount 
            })
         }else {
         this.widgetcount = [];
        this.titleIVeService.getWidgetMytaskdashboard(taskDashboardParam, pagination).subscribe(response => {
            if (response && response.data && response.data.data && response.data.data.length) {
                response.data.data.forEach(element => {
                    element.format_due_status = Math.abs(element.due_status);
                });
            }
            this.dashboardandwidgetdata(response);
            if (!this.myTaskTotalCount) {
                            this.myTaskTotalCount = response.data.data[0].countdata;
                            this.totalcountlist = { ...this.totalcountlist, MyAlerts: this.myTaskTotalCount };
                        }
                        if(status !=='Initial'){  
                    
                    this.totalCases =  this.fromsearch ? response?.data?.data[0]?.countdata:this.myTaskTotalCount
                        }
                });

            }
        }
        // *******************************
        
    //     this.titleIVeService.getWidgetMytaskdashboard(taskDashboardParam, pagination).subscribe(response => {
    //         this.taskbulkassign = [];
    //         this.enableTaskAssign = false
    //         if (response && response.data && response.data.data && Array.isArray(response.data.data)) {
    //             response.data.data.forEach(element => {
    //                 element.format_due_status = Math.abs(element.due_status);
    //             });
    //             this.myTaskDetailsData = response.data.data;
    //             this.gridConfig.data = response.data.data.map(item => ({
    //                 ...item,
    //                 sqnm_sw: item?.sqnm_sw ? item.sqnm_sw : 'I'
    //             }));
    //             this.myTaskTotalCount = response.data.data[0].countdata;
    //             this.totalcount = response.data.data[0].countdata;
    //             this.totalcountlist = { ...this.totalcountlist, MyAlerts: this.myTaskTotalCount };

    //             this.totalCases = response.data.data[0].countdata;
    //             this.widgetcount = response.widgetcount.fostercarecountdetails[0];
    //         } else {
    //             this.myTaskDetailsData = null;
    //             this.myTaskTotalCount = 0;
    //         }

    //     });
    // }



    loadFosterCare(status?: string) {
        let eligibilestatus ;
       if(status){
        eligibilestatus = null;
       }
       else{
        
        eligibilestatus = this.geteligibiltystatus();
       }
        const filtertype = this.getfiltertype();
        const fosterCareDashboardParam = {
            'status': this.userRole === 'ive-supervisor' ? '{16,71}' : '{70}',
            'eventType': 'Fostercare',
            'fname': this.fosterCare.value.fname ? this.fosterCare.value.fname.trim() : null,
            'lname': this.fosterCare.value.lname ? this.fosterCare.value.lname.trim() : null,
            'clientId': this.fosterCare.value.clientId ? this.fosterCare.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'rdate': this.fosterCare.value.rdate ? moment(this.fosterCare.value.rdate).format('MM-DD-YYYY') : null,
            'todate': this.fosterCare.value.todate ? moment(this.fosterCare.value.todate).format('MM-DD-YYYY') : this.fosterCare.value.rdate ? moment(this.maxDate).format('MM-DD-YYYY') : null,            
            'eligiblestatus': eligibilestatus,
            'county': this.fosterCare.value.countylist ? this.fosterCare.value.countylist : null,
            'sortingorder': this.displaysortorder ? this.displaysortorder : null,
            'assignedspecialist': this.fosterCare.value.assignedSpecialist ? this.fosterCare.value.assignedSpecialist : null,
            'filtertype': filtertype
        };
        const pagination = {
            page: this.paginationInfo.pageNumber,
            limit: this.paginationInfo.pageSize,
        }
        const statusValue = this.selectedGrid === 'MyAlerts' ? this.programTypeStatus : this.selectedApprovalStatus;
         if(this.progressbarreload){
            this.title4eService.getDashboardData(fosterCareDashboardParam, pagination).subscribe(response => {
                this.dashboarddata(response);  
                if (status || this.returntodashboard) {
                    this.fcCount = response.data[0].countdata;
                    this.totalcountlist = { ...this.totalcountlist, FosterCare: this.fcCount };
                  
                }
                this.totalCases =  this.fromsearch ? response?.data[0]?.countdata:this.fcCount
            })
         }else {
         this.widgetcount = [];
        this.titleIVeService.getDashboarddataandcount(fosterCareDashboardParam, pagination).subscribe(response => {
            this.dashboardandwidgetdata(response);
            if (status || this.returntodashboard) {
                        if(response.data?.data[0]?.countdata) {
                            this.fcCount = response.data.data[0].countdata;
                        } else {
                            this.fcCount = 0;
                        }
                            if(status){
                                this.loadGap('Initial');
                                this.loadAdoption('Initial');
                                this.loadACA('Initial');
                            this.aprovalDetails(statusValue, 'Initial');
                            this.getTaskDetails('Initial');
                            this.getClosureApproval('Initial');
                            this.getClosureDetails('Initial');
                            }
                            if(this.returntodashboard){
                                // this.fcCount= response.data.data[0].countdata;
                                if(!this.totalcountlist)
                                this.totalcountlist = this._dataStore.getData('totalcountlist');
                                this._dataStore.setData('totalcountlist', '');
                            }else {

                            this.totalcountlist = { ...this.totalcountlist, FosterCare: this.fcCount };
                            }
                        }
                       
                    
                    this.totalCases =  this.fromsearch ? response?.data?.data[0]?.countdata:this.fcCount
                });

            }
            
        



        
    }
    dashboarddata(response:any,status?:any){
        if (response && response.data && Array.isArray(response.data)) {
            if(status !=='Initial'){
        
            this.gridConfig.data = response.data.map((item: { sqnm_sw: any; }) => ({
                ...item,
                sqnm_sw: item?.sqnm_sw ? item.sqnm_sw : 'I'
            }));
        }
            this.intakesMasterData = response.data;
            
            if (response.data && response.data.length) {
                this.totalcount = response.data[0].countdata;
                
               
            }
           
           
        }

    }
dashboardandwidgetdata(response:any){
    
    if (response && response.data && response.data.data && Array.isArray(response.data.data)) {
        
        this.gridConfig.data = response.data.data.map((item: { sqnm_sw: any; }) => ({
            ...item,
            sqnm_sw: item?.sqnm_sw ? item.sqnm_sw : 'I'
        }));
        this.intakesMasterData = response.data.data;
        
        if (response.data && response.data.data.length) {
            this.totalcount = response.data.data[0].countdata;
            if(!this.progressbarreload || this.returntodashboard){
                if(this.returntodashboard){
                  //  this.fcCount= response.data.data[0].countdata;
                   this.totalcountlist = this._dataStore.getData('totalcountlist');
                }
            this.widgetcount = response.widgetcount.fostercarecountdetails[0];
            }
            
           
        }
        this.totalCases =  this.fromsearch ? response?.data?.data[0]?.countdata:this.fcCount
       
    }
}
    pageChanged(pageNumber: any) {
        if(this.paginationInfo.pageNumber !== pageNumber.page){
        this.paginationInfo.pageNumber = pageNumber.page;
        this.loadMainGrid(this.selectedGrid, 'pagechange');
        }
    }

    loadGap(status?: string) {
        this.totalcount = 0;
        this.totalCases=0;
        let eligibilestatus ;
        if(status){
         eligibilestatus = null;
        }
        else{
         
         eligibilestatus = this.geteligibiltystatus();
        }
        const filtertype = this.getfiltertype();
        const gapDashboardParam = {
            'status': this.userRole === 'ive-supervisor' ? '{16,73}' : '{73}',
            'eventType': 'Gap',
            'fname': this.fosterCare.value.fname ? this.fosterCare.value.fname.trim() : null,
            'lname': this.fosterCare.value.lname ? this.fosterCare.value.lname.trim() : null,
            'clientId': this.fosterCare.value.clientId ? this.fosterCare.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'rdate': null,
            'todate': null,
            'eligiblestatus': eligibilestatus ? eligibilestatus : null,
            'county': this.fosterCare.value.countylist ? this.fosterCare.value.countylist : null,
            'filtertype': filtertype ? filtertype : null,
            'sortingorder': this.displaysortorder ? this.displaysortorder : null,
            'assignedspecialist': this.fosterCare.value.assignedSpecialist ? this.fosterCare.value.assignedSpecialist : null,
            'countstatus' : status ? status : null
        };
        
        const pagination = {
            page: this.paginationInfo.pageNumber,
            limit: this.paginationInfo.pageSize,
        }

        if(status =='Initial'){
            this.title4eService.getDashboardData(gapDashboardParam, pagination).subscribe(response => {
                if (status) {
                    this.gapCount = response.data && response.data.length ? response.data[0].countdata : 0;
                    this.totalcountlist = { ...this.totalcountlist, Guardianship: this.gapCount  };
                }
            })
         } else if(this.progressbarreload){
            this.title4eService.getDashboardData(gapDashboardParam, pagination).subscribe(response => {
                this.dashboarddata(response,status);  
                if (status || this.returntodashboard) {
                    this.gapCount =  response.data && response.data.length ? response.data[0].countdata : 0;
                    if(this.returntodashboard){

                        this.totalcountlist = this._dataStore.getData('totalcountlist');
                    }else {
                    this.totalcountlist = { ...this.totalcountlist, Guardianship: this.gapCount};
                    }
                }
                if(status !=='Initial'){
                this.totalCases =  this.fromsearch ? response?.data[0]?.countdata:this.gapCount 
                }
            })
         }else {
         this.widgetcount = [];
        this.titleIVeService.getDashboarddataandcount(gapDashboardParam, pagination).subscribe(response => {
            this.dashboardandwidgetdata(response);
            if (!this.gapCount || this.returntodashboard) {
                            this.gapCount = response.data.data[0].countdata;
                            this.totalcountlist = { ...this.totalcountlist, Guardianship: this.gapCount };
                        }
                       
                    
                    this.totalCases =  this.fromsearch ? response?.data?.data[0]?.countdata:this.gapCount
                });

            }
        // 
        // this.title4eService.getDashboarddataandcount(gapDashboardParam, pagination).subscribe(response => {
        //     if (response && response.data && response.data.data && Array.isArray(response.data.data)) {
        //         this.gapintakesMasterData = response.data.data;
        //         this.gridConfig.data = response.data.data.map(item => ({
        //             ...item,
        //             sqnm_sw: item?.sqnm_sw ? item.sqnm_sw : 'I'
        //         }));
        //         if (response.data && response.data.data.length) {
        //             if (status) {
        //                 this.gapCount = response.data.data[0].countdata;
        //                 this.totalcountlist = { ...this.totalcountlist, Guardianship: this.gapCount };

        //             }
                    
        //             this.totalcount = response.data.data[0].countdata;
        //             this.widgetcount = response.widgetcount.fostercarecountdetails[0];
        //         }
        //         this.totalCases = this.fromsearch ? response.data?.data[0]?.countdata:this.gapCount;
        //     }
        // });
    }
    loadAdoption(status?: string) {
        this.totalcount = 0;
        this.totalCases =0;
        
        let eligibilestatus ;
        if(status){
         eligibilestatus = null;
        }
        else{
         
         eligibilestatus = this.geteligibiltystatus();
        }
        const filtertype = this.getfiltertype();

        const adoptionDashboardParam = {
            'status': this.userRole === 'ive-supervisor' ? '{16,68,69}' : '{67}',
            'eventType': 'Adoption',
            'fname': this.fosterCare.value.fname ? this.fosterCare.value.fname.trim() : null,
            'lname': this.fosterCare.value.lname ? this.fosterCare.value.lname.trim() : null,
            'clientId': this.fosterCare.value.clientId ? this.fosterCare.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'rdate': null,
            'todate': null,
            'eligiblestatus': eligibilestatus ? eligibilestatus : null,
            'sortingorder': this.displaysortorder ? this.displaysortorder : null,
            'county': this.fosterCare.value.countylist ? this.fosterCare.value.countylist : null,
            'filtertype': filtertype ? filtertype : null,
            'assignedspecialist': this.fosterCare.value.assignedSpecialist ? this.fosterCare.value.assignedSpecialist : null,
            'countstatus': status ? status : null
        };
        const pagination = {
            page: this.paginationInfo.pageNumber,
            limit: this.paginationInfo.pageSize,
        }
        if(status =='Initial'){
            this.title4eService.getDashboardData(adoptionDashboardParam, pagination).subscribe(response => {
                if (status) {
                    this.adopCount = response.data && response.data.length ? response.data[0].countdata : 0;
                    this.totalcountlist = { ...this.totalcountlist, Adoption: this.adopCount  };
                }
            })
         } else if(this.progressbarreload){
            this.title4eService.getDashboardData(adoptionDashboardParam, pagination).subscribe(response => {
                this.dashboarddata(response,status);  
                if (status) {
                    this.adopCount = response.data && response.data.length ? response.data[0].countdata : 0;
                    this.totalcountlist = { ...this.totalcountlist, Adoption: this.adopCount  };
                }
                    if(status !=='Initial'){
                this.totalCases =  this.fromsearch ? response?.data[0]?.countdata:this.adopCount ;
                    }
            })
         } else {
         this.widgetcount = [];
        this.titleIVeService.getDashboarddataandcount(adoptionDashboardParam, pagination).subscribe(response => {
            this.dashboardandwidgetdata(response);
            if (!this.adopCount) {
                           this.adopCount = response.data.data[0].countdata;
                            this.totalcountlist = { ...this.totalcountlist, Adoption: this.adopCount  };
                        }
                       
                    
                    this.totalCases =  this.fromsearch ? response?.data?.data[0]?.countdata:this.adopCount
                });

            }
        }
   

    loadACA(status?: string) {
        this.totalcount = 0;
        this.totalCases =0;
        
        let eligibilestatus ;
        if(status){
         eligibilestatus = null;
        }
        else{
         
         eligibilestatus = this.geteligibiltystatus();
        }
        const filtertype = this.getfiltertype();
        const adoptionDashboardParam = {
            'status': this.userRole === 'ive-supervisor' ? '{16,68,69}' : '{67}',
            'eventType': 'ACA',
            'fname': this.fosterCare.value.fname ? this.fosterCare.value.fname.trim() : null,
            'lname': this.fosterCare.value.lname ? this.fosterCare.value.lname.trim() : null,
            'clientId': this.fosterCare.value.clientId ? this.fosterCare.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'rdate': null,
            'todate': null,
            'eligiblestatus': eligibilestatus ? eligibilestatus : null,
            'county': this.fosterCare.value.countylist ? this.fosterCare.value.countylist : null,
            'filtertype': filtertype ? filtertype : null,
            'assignedspecialist': this.fosterCare.value.assignedSpecialist ? this.fosterCare.value.assignedSpecialist : null,
            'countstatus': status ? status : null

        };
        const pagination = {
            page: this.paginationInfo.pageNumber,
            limit: this.paginationInfo.pageSize,
        }
        if(status =='Initial'){
            this.title4eService.getDashboardData(adoptionDashboardParam, pagination).subscribe(response => {
                if(response.data.length == 0){
                        this.acaCount = 0;
                    }else if (response && response.data && Array.isArray(response.data)) {
                        this.acaCount = response.data[0].countdata;
                    }
                    this.totalcountlist = { ...this.totalcountlist, AdoptionApplicability: this.acaCount };
            })
         } else if(this.progressbarreload){
            this.title4eService.getDashboardData(adoptionDashboardParam, pagination).subscribe(response => {
                this.dashboarddata(response,status);  
                if (status) {
                   
                    if(response.data.length == 0){
                        this.acaCount = 0;
                    }else if (response && response.data && Array.isArray(response.data)) {
                        this.acaCount = response.data[0].countdata;
                    }
                    this.totalcountlist = { ...this.totalcountlist, AdoptionApplicability: this.acaCount };
                
            }
                if(status !=='Initial'){
                this.totalCases =  this.fromsearch ? response?.data[0]?.countdata:this.acaCount
                }
            })
            
         }else {
         this.widgetcount = [];
        this.titleIVeService.getDashboarddataandcount(adoptionDashboardParam, pagination).subscribe(response => {
            this.dashboardandwidgetdata(response);
            if (!this.acaCount) {
                this.acaCount = response.data.data[0].countdata;
                            this.totalcountlist = { ...this.totalcountlist, AdoptionApplicability: this.acaCount  };
                        }
                       
                    
                    this.totalCases =  this.fromsearch ? response?.data?.data[0]?.countdata:this.acaCount
                });

            }
        }
   

    searchGap(data: any) {
        let item;
        if(typeof data === 'string'){
            item = JSON.parse(data);
        } else {
            item = data;
        }
        const clientid = item.clientid;
        const removalid = item.removalid;
        if (clientid && removalid) {
            this._dataStore.setData('guardianship_clientid', clientid);
            this._dataStore.setData('guardianship_removalid', removalid);
            this.router.navigate(['/pages/title4e/guardianship/' + clientid + '/' + removalid]);
        }
    }

    searchAdoption(data: any) {
        let item;
        if(typeof data === 'string'){
            item = JSON.parse(data);
        } else {
            item = data;
        }
        const clientid = item.clientid;
        const removalid = item.removalid;
        const sqnm_sw = item.sqnmsw;
        if (clientid && removalid) {
            this._dataStore.setData('adoption_clientid', clientid);
            this._dataStore.setData('adoption_removalid', removalid);
            this._dataStore.setData('titleiveselectedgrid', this.selectedGrid);
             this._dataStore.setData('totalcountlist', this.totalcountlist);
            this.router.navigate(['/pages/title4e/adoption/' + clientid + '/' + removalid]);
            if (sqnm_sw === 'A') {
                this._dataStore.setData('adoption_dashboard', 'aca');
            } else {
                this._dataStore.setData('adoption_dashboard', 'adoption');
            }
        }
    }


    searchACA(data: any) {
        let item;
        if(typeof data === 'string'){
            item = JSON.parse(data);
        } else {
            item = data;
        }
        // The aca route carries the client id in the same position as adoption.
        if (!this.hasClientId(item && item.clientid)) {
            return;
        }
        if (item) {
            this._dataStore.setData('adoption_clientid', item.clientid);
            this._dataStore.setData('adoption_removalid', item.removalid);
            this._dataStore.setData('adoption_dashboard', 'aca');
            this.router.navigate(['/pages/title4e/aca/' + item.clientid + '/' + item.removalid]);
        }
    }

    searchFoster(data: any) {
        const item = JSON.parse(data);
        this._dataStore.setData('titleiveselectedgrid', this.selectedGrid);
        this._dataStore.setData('totalcountlist', this.totalcountlist);
        if (item.client_id) {
            this.router.navigate(['/pages/title4e/foster-car/' + item.client_id + '/' + item.removal_id]);
        }
    }

    searchClosure(data: any) {
        const item = JSON.parse(data);
        let personData = item.clientData;
        let ptype = item.programTypeData;
        var url = '';
        if (!this.hasClientId(personData && personData.cjamspid)) {
            return;
        }
        personData.clientid = personData.cjamspid;
        if (ptype == 'gap') {
            url = '#/pages/title4e/guardianship/' + personData.cjamspid + '/' + personData.guardian_subsidy_id
            window.open(url)
        } else if (ptype == 'ooh') {
            this.navigateutil.loadFostcareIVE(personData.clientid, personData.removalid, null);
        } else if (ptype == 'adop') {
            url = '#/pages/title4e/adoption/' + personData.cjamspid + '/' + personData.removalid
            window.open(url)
        }
    }

    resetadop() {
        // this.adoption.reset();
        this.loadAdoption();
    }
    resetaca() {
        // this.acaform.reset();
        this.loadACA();
    }
    resetapproval() {
        this.fosterCare.reset();
        // this.fosterCare.patchValue({ approvalstatus: 'PENDING' });
        // this.aprovalDetails('PENDING');
        this.aprovalDetails('');
    }

    resetgap() {
        // this.gap.reset();
        this.loadGap();
    }
    reset() {
        // this.resetgrid();
        // this.fosterCare.reset({
        //     approvalstatus: ['PENDING']
        // });
        // this.resetbutton = true;
        this.fromsearch = true;
        this.progressbarreload =false;
        this.fosterCare.reset();
        this.fosterCare.patchValue({ countylist: null })
        this.progressselected = '';
        this.selectedeligibility = '';
        this.selectedApprovalStatus='';
        this.myalertscount='';
         this.loadMainGrid(this.selectedGrid)
        this.titleIVeService.setprogressselectedactive(this.progressselected);
        this.titleIVeService.seteligibilityselectedactive(this.progressselected);
        this.hideunassigned = false;
        
        //this.loadFosterCare();
        // this.fcCount=0;

    }
    searchTaskDetails() {
        this.customTaskpaginationInfo.pageNumber = 1;
        this.getTaskDetails();
    }

    setOrder() {
        switch (this.reverse) {
            case 0:
                this.reverse = 1;
                this.displaysortorder = 'asc';
                this.loadFosterCare();
                break;
            case 1:
                this.reverse = 2;
                this.displaysortorder = 'desc'
                this.loadFosterCare();
                break;
            case 2:
                this.reverse = 0;
                this.displaysortorder = null;
                this.loadFosterCare();
                break;
        }
    }

    // loadCounty(state) {
    //     this._commonDropdownService.getPickListByMdmcode(state).subscribe(countyList => {
    //         this.countyDropDownItems$ = Observable.of(countyList);
    //     });
    // }

    loadCounty(statekey: string) {
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
            const removeCounties = ['DHS Central', 'Central Office', 'DHRIS', 'SSC', 'OIG'];
            this.countylistdropdown = response.filter((a: { countyname: string; }) => !removeCounties.includes(a.countyname));
        });

    }

    getClosureApproval(status?:string) {
        const closureDashboardParam = {
            roleid: 'IVECCR',
            fromsecurityusersid: null,
            statustype: 'approval',
            tosecurityuserid: this.userRole === 'ive-specialist' ? this.user.securityusersid : this.fosterCare.value.securityusersid && this.fosterCare.value.securityusersid !== this.user.securityusersid ? this.fosterCare.value.securityusersid.trim() : null,
            casenumber: this.fosterCare.value.casenumber ? this.fosterCare.value.casenumber.trim() : null,
            clientId: this.fosterCare.value.clientId ? this.fosterCare.value.clientId.trim() : null,
            status: this.fosterCare.value.status ? this.fosterCare.value.status.trim() : null,
            county: this.fosterCare.value.countylist ? this.fosterCare.value.countylist : null,
            countstatus : status ? status : null
        };
        const pagination = {
            page: this.paginationInfo.pageNumber,
            limit: this.paginationInfo.pageSize,
        }
        this.titleIVeService.getClosureDashboardData(closureDashboardParam, pagination).subscribe(response => {
            this.enableccrAssign = false;

            if (response && response.data && Array.isArray(response.data)) {
                this.closureData = response.data;
                //this.gridConfig.data = response.data;
                if(status !=='Initial'){
                this.gridConfig.data = response.data.map(item => ({
                    ...item,
                    headofhousehold: (item.legalguardian[0]?.getcasepersonname?.length && item.legalguardian[0]?.getcasepersonname[0]?.personname)
                        ? item.legalguardian[0].getcasepersonname[0].personname
                        : ''
                }));
            }
            }
            // if (this.closureData && this.closureData.length) {
            //     this.closureCount = this.closureData[0].countdata;
            //     this.totalcount = response.data[0].countdata;
            // } else {
            //     this.closureCount = 0;
            // }
            if (response.data && response.data.length) {
                if(status){
                this.closureCount = response.data[0].countdata;
                this.totalcountlist = { ...this.totalcountlist, CaseClosureApproval: this.closureCount };

                }
                if(status !=='Initial'){
                this.totalCases = response.data[0].countdata
                this.totalcount = response.data[0].countdata;
                // this.widgetcount = response.widgetcount.fostercarecountdetails[0];
                }
            }else{
                if(status =='Initial'){
                this.totalcountlist = { ...this.totalcountlist, CaseClosureApproval: 0 };
                }
            }
        });
    }

    getClosureDetails(status?:string) {
        const closureDashboardParam = {
            roleid: 'IVECCR',
            fromsecurityusersid: null,
            tosecurityuserid: this.userRole === 'ive-supervisor' ? null : this.user.securityusersid,
            statustype: this.userRole === 'ive-supervisor' ? 'assignment' : null,
            casenumber: this.fosterCare.value.casenumber ? this.fosterCare.value.casenumber.trim() : null,
            clientId: this.fosterCare.value.clientId ? this.fosterCare.value.clientId.trim() : null,
            status: this.fosterCare.value.status ? this.fosterCare.value.status.trim() : null,
            eligiblestatus: this.fosterCare.value.status ? this.fosterCare.value.status.trim() : null,
            county: this.fosterCare.value.countylist ? this.fosterCare.value.countylist : null,
            eventType: 'IVECCR',
            roleTypeKey: 'IVECCR',
            filtertype: this.progressselected == 'unassigned' ? this.progressselected : null,
            countstatus : status ? status : null
        };
        const pagination = {
            page: this.paginationInfo.pageNumber,
            limit: this.paginationInfo.pageSize,
        }
        if(status === 'Initial' || this.userRole ==='ive-specialist'){
        this.titleIVeService.getClosureDashboardData(closureDashboardParam, pagination).subscribe(response => {
            this.enableccrAssign = false;

            if (response && response.data && Array.isArray(response.data)) {
                this.closureData = response.data;
                //this.gridConfig.data = response.data;
                if(status !=='Initial'){
                this.gridConfig.data = response.data.map(item => ({
                    ...item,
                    headofhousehold: (item.legalguardian[0]?.getcasepersonname?.length && item.legalguardian[0]?.getcasepersonname[0]?.personname)
                        ? item.legalguardian[0].getcasepersonname[0].personname
                        : ''
                }));
            }
            }
            // if (this.closureData && this.closureData.length) {
            //     this.closureCount = this.closureData[0].countdata;
            //     this.totalcount = response.data[0].countdata;
            // } else {
            //     this.closureCount = 0;
            // }
            if (response.data && response.data.length) {
                if(status =='Initial'){
                this.closureCount = response.data[0].countdata;
                this.totalcountlist = { ...this.totalcountlist, CaseClosureReview: this.closureCount };

                }
                if(status !=='Initial'){
                this.totalCases = response.data[0].countdata
                this.totalcount = response.data[0].countdata;
                // this.widgetcount = response.widgetcount.fostercarecountdetails[0];
                }
            }else{
                if(status =='Initial'){
                this.totalcountlist = { ...this.totalcountlist, CaseClosureReview: 0 };
                }
            }
        });
    }


else if( status!== 'Initial' && this.userRole === 'ive-supervisor'){
        this.titleIVeService.getClosurewidgetDashboardData(closureDashboardParam, pagination).subscribe(response => {
            this.enableccrAssign = false;
            
            if (response && response.data.data && Array.isArray(response.data.data)) {
                this.closureData = response.data.data;
               
              if(status !=='Initial'){
                this.gridConfig.data = response.data.data.map(item => ({
                    ...item,                  
                    headofhousehold: (item.legalguardian[0]?.getcasepersonname?.length && item.legalguardian[0]?.getcasepersonname[0]?.personname)
                        ? item.legalguardian[0].getcasepersonname[0].personname
                        : ''
                }));
            }
            }
         
            if (this.closureData && this.closureData.length) {
                this.closureCount = this.closureData[0].countdata;    
            //     if(status =='Initial')  {          
            //     this.totalcountlist = { ...this.totalcountlist, CaseClosureReview: this.closureCount };
            // }
                if(status !=='Initial'){
                this.totalCases= response.data.data[0].countdata;
                this.totalcount =response.data.data[0].countdata;
                this.widgetcount = response.widgetcount.fostercarecountdetails[0];
                }
            } else {
                this.closureCount = 0;
                this.totalcountlist = { ...this.totalcountlist, CaseClosureReview: this.closureCount };
            }
        });
    }
}

    // resetccrAssign() {
    //     this.ccrAssignform.reset();
    //     this.getClosureDetails();
    // }

    getprogramtype(programs: { programkey: any; }[]) {
        return programs.map(({ programkey }) => programkey).join(' / ');
    }

    // The title4e pages carry the client id in the route and their tab components
    // read it back off the URL, so a worklist row with a null client id opens
    // '/adoption/null/...' and every id-keyed call from that page is rejected with
    // a bare 400. Refuse the navigation and say why rather than opening a page that
    // cannot load.
    private hasClientId(clientid: any): boolean {
        if (clientid === null || clientid === undefined || clientid === ''
            || isNaN(Number(clientid))) {
            this._alertService.error('This record has no client ID, so the Title IV-E page cannot be opened.');
            return false;
        }
        return true;
    }

    searchTaskDashboard(item: { program_type: string; clientid: string; removal_id: string; }) {
        if (!this.hasClientId(item && item.clientid)) {
            return;
        }
        if (item.program_type == 'FOSTER CARE') {
            this.router.navigate(['/pages/title4e/foster-car/' + item.clientid + '/' + item.removal_id]);
        } else if (item.program_type == 'ADOPTION') {
            this.router.navigate(['/pages/title4e/adoption/' + item.clientid + '/' + item.removal_id]);
            this._dataStore.setData('adoption_clientid', item.clientid);
            this._dataStore.setData('adoption_removalid', item.removal_id);
            this._dataStore.setData('adoption_dashboard', 'adoption');
            this._dataStore.setData('adoption_migrated_data', item);
        } else if (item.program_type == 'GAP') {
            this._dataStore.setData('guardianship_clientid', item.clientid);
            this.router.navigate(['/pages/title4e/guardianship/' + item.clientid + '/' + item.removal_id]);
        }
    }

    navigateCaseNumber(data: { casetype: string; caseid: any; casenumber: any; startdate: any; }) {
        if (data.casetype === 'servicecase') {
            const casedata = {
                intakeserviceid: data.caseid,
                casenumber: data.casenumber,
                danumber: data.casenumber,
                datype: 'Request for services'
            }
            this._dataStore.setData('titleiveselectedgrid', this.selectedGrid);
            this._dataStore.setData('totalcountlist', this.totalcountlist);
    
            this.navigateutil.openRespectiveItem(casedata);
        }
        if (data.casetype === 'adoptioncase') {
            const casedata = {
                servicerequestnumber: data.caseid,
                adoptioncaseid: data.caseid,
                adoptioncasenumber: data.casenumber,
                startdate: data.startdate
            }
            this._dataStore.setData('titleiveselectedgrid', this.selectedGrid);
            this._dataStore.setData('totalcountlist', this.totalcountlist);
  
            this.navigateutil.routToAdoptionCase(casedata);
        }
    }

    sendforApproval(data: any) {
        let item;
        if(typeof data === 'string'){
             item = JSON.parse(data);
        } else {
            item = data;
        }
       

        if (item.data) {
            this.selectedRecord = item.data;
        }
        if (item.isSend) {
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

    selectPerson(item: any) {
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
        this._commonHttpService.create(data, 'titleive/ive/assignspecialist').subscribe(response => {
            this.getClosureDetails();
            this._alertService.success('Case Assigned Successfully ');
            $(this.caseassignccrId).modal('hide');
        });
    }

    downloadApprovalSection() {
        let nameoftheuser;
        let namefromuser;
        let roleTypeKey = this.role;
        let userRoleType = this.dashboardname;
        nameoftheuser = this.user.firstname + ' ' + this.user.lastname;
        if (this.activeModule && this.activeModule === '4E SUPERVISOR') {
            namefromuser = this.user.firstname + ' ' + this.user.lastname;
            nameoftheuser = null;
            roleTypeKey = 'IVESV';
            userRoleType = 'IV-E Supervisor';
        }
        const modal = {
            method: 'post',
            where: {
                documenttemplatekey: ['iveapprovalsection'],
                isheaderrequired: false,
                status: '{71,74,68}',
                clientId: this.fosterCare.value.clientId ? this.fosterCare.value.clientId : null,
                roleTypeKey: roleTypeKey ? roleTypeKey : null,
                approvalstatus: this.fosterCare.value.approvalstatus ? this.fosterCare.value.approvalstatus : 'PENDING',
                programtype: this.fosterCare.value.programtype ? this.fosterCare.value.programtype : null,
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

    IVEActionMethods(data: any): void {
        const value = JSON.parse(data);
        const item = value.data;

        const searchAdpt = {
            clientid: item.clientid,
            removalid: item.removalid,
            sqnmsw: value.sqnm_sw
        }
        this._dataStore.setData('titleiveselectedgrid', this.selectedGrid);
        this._dataStore.setData('totalcountlist', this.totalcountlist);

        if (value.type === 'FosterCare') {
            this.router.navigate(['/pages/title4e/foster-car', item.clientid, item.removalid]);
        } else if (value.type === 'Guardianship') {
            this.searchGap(item);
        } else if (value.type === 'Adoption') {
            this.searchAdoption(searchAdpt);
        } else if (value.type === 'AdoptionApplicability') {
            this.searchACA(item);
        } else if (value.type === 'CaseClosureReview' || value.type === 'CaseClosureApproval') {
            this.navigateCaseNumber(item);
        } else if (value.type === 'MyAlerts') {
            this.searchTaskDashboard(item);
        }
    }

    onSelect(item: any): void {
        const data = item.data;
        const receipt = JSON.parse(JSON.stringify(data));
        const selectedReceipt = (this.bulkassign && this.bulkassign.length > 0) ? this.bulkassign.find(rec => rec.objectid === receipt.placementid) : null;
        if (item.isChecked) {
            if (!selectedReceipt) {
                this.bulkassign.push(
                    this.getSelectedRecordData(data)
                );
            }
        } else {
            this.selectAssignBulk = false;
            this.bulkassign = this.bulkassign.filter(rec => rec.objectid !== receipt.placementid);
        }
        this.enableAssignBtn = !!this.bulkassign.length;
        this.enableTaskAssign = !!this.bulkassign.length;
        // const assignlist = this.fosterCareData;
        // if (this.bulkassign.length !== 0) {
        //     const bulkcheckboxselect = (assignlist.length === this.bulkassign.length);
        //     if (bulkcheckboxselect) {
        //         this.selectAssignBulk = true;
        //     } else {
        //         this.selectAssignBulk = false;
        //     }
        // } else {
        //     this.selectAssignBulk = false;
        // }
    }

    getSelectedRecordData(data: { caseid: any; placementid: any; clientid: string; casenumber: any; ivecaseclosurereviewid: any; gapagreementid: any; adoptionbreakthelinkid: any; fromid: any; }): any {
        let params;
        switch (this.selectedGrid) {
            case 'FosterCare':
                params = {
                    servicecaseid: data.caseid,
                    objectid: data.placementid,
                    clientid: data.clientid,
                    notifymsg: 'Foster Care determination for client ' + data.clientid + this.isassignedstr
                }
                break;
            case 'CaseClosureReview':
                params = {
                    servicecaseid: data.caseid,
                    notifymsg: `The Case Closure Review Request for #${data.casenumber} is assigned`,
                    objectid: data.ivecaseclosurereviewid
                }
                break;
            case 'Guardianship':
                params = {
                    servicecaseid: data.caseid,
                    objectid: data.gapagreementid,
                    clientid: data.clientid,
                    notifymsg: 'Gap determination for client ' + data.clientid + this.isassignedstr
                }
                break;
            case 'Adoption':
                params = {
                    servicecaseid: data.caseid,
                    objectid: data.adoptionbreakthelinkid,
                    clientid: data.clientid,
                    notifymsg: 'Adoption determination for client ' + data.clientid + this.isassignedstr
                }
                break;
            case 'AdoptionApplicability':
                params = {
                    servicecaseid: data.caseid,
                    objectid: data.adoptionbreakthelinkid,
                    clientid: data.clientid,
                    notifymsg: 'Adoption applicability determination for client ' + data.clientid + this.isassignedstr
                }
                break;
            case 'CaseClosureApprove':
                params = {
                    servicecaseid: data.caseid,
                    notifymsg: 'Case Closure Review is approved',
                    objectid: data.ivecaseclosurereviewid,
                    assignedtoid: data.fromid
                }
                break;
            case 'MyAlerts':
                params = this.getMyAlertParams(data);
                break;
        }
        return params;
    }

    getMyAlertParams(data: { caseid: any; placementid: any; clientid: any; casenumber?: any; ivecaseclosurereviewid?: any; gapagreementid: any; adoptionbreakthelinkid: any; fromid?: any; program_type?: any; }): any {
        let params;
        if (data.program_type === 'FOSTER CARE') {
            params = {
                servicecaseid: data.caseid,
                objectid: data.placementid,
                clientid: data.clientid,
                program_type: data.program_type,
                notifymsg: 'Foster Care determination for client ' + data.clientid + this.isassignedstr
            }
        } else if (data.program_type === 'ADOPTION') {
            params = {
                servicecaseid: data.caseid,
                objectid: data.adoptionbreakthelinkid,
                clientid: data.clientid,
                program_type: data.program_type,
                notifymsg: 'Adoption determination for client ' + data.clientid + this.isassignedstr
            }
        } else if (data.program_type === 'GAP') {
            params = {
                servicecaseid: data.caseid,
                objectid: data.gapagreementid,
                clientid: data.clientid,
                program_type: data.program_type,
                notifymsg: 'Gap determination for client ' + data.clientid + this.isassignedstr
            }
        }
        return params;

    }

    getwidgetcount(DashboardParam: any) {

        this.titleIVeService.getwidgetcount(DashboardParam).subscribe(response => {
            if (response && response.fostercarecountdetails && Array.isArray(response.fostercarecountdetails)) {

                this.widgetcount = response.fostercarecountdetails[0];
                return this.widgetcount;

            }
        });
    }

    private loadIVeSpecialist() {
        this.titleIVeService.getUsersList().subscribe(result => this.fetchUsersList(result));
    }


    fetchUsersList(result: ListDataItem<any>) {
        if (this.role === 'IVEQA' || this.role === 'IVEADMIN') {
            this.getUsersList = result.data.filter(user => (user.rolecode === AppConstants.ROLES.TITLE_IVE_SPECIALIST || user.rolecode === AppConstants.ROLES.TITLE_IVE_ANALYST) && user.userid !== this.user.securityusersid);
        } else {
            this.getUsersList = result.data.filter(user => user.rolecode === AppConstants.ROLES.TITLE_IVE_SPECIALIST && user.userid !== this.user.securityusersid);
        }
    }

    getWorkersList() {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'INVR' },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe((result) => {
                this.workersList = result.data.filter(s => s.rolecode !== 'SP');
            });
    }

    private loadSupervisor() {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'INTRS' },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe(result => {
                this.supervisorList = result['data'];
                if (this.supervisorList && this.supervisorList?.length && this.supervisorList?.length > 0) {
                    this.supervisorList = this.supervisorList.filter((item: { username: string | null; }) => (item?.username != null && item?.username !== ""));
                }
                this.fosterCare.controls['securityusersid'].patchValue(this.roleId.user.userprofile.securityusersid);
            });
    }

    assignClick(): void {
        this.titleIVeService.getUsersList().subscribe(result => this.fetchUsersList(result));
        $('#caseassign').modal('show');
    }

    getAssignUserParams(): any {
        let type = this.selectedGrid;
        if(type === 'MyAlerts') {
            const program_type = this.fosterCare.value.programtype;
            if (program_type === 'Fostercare' || this.bulkassign[0].program_type == 'FOSTER CARE') {
                type = 'FosterCare';
            } else if (program_type === 'Adoption' || this.bulkassign[0].program_type == 'ADOPTION') {
                type = 'Adoption';
            } else if (program_type === 'Gap' || this.bulkassign[0].program_type == 'GAP') {
                type = 'Guardianship';
            } 
        }

        let data;
        switch (type) {
            case 'FosterCare':
                data = {
                    'where': {
                        'assignedtoid': this.selectedPerson.userid,
                        'bulkassign': this.bulkassign,
                        'userprofilerole': this.role,
                        'touserrole': this.selectedPerson.rolecode,
                        'comments': 'Foster care client is assigned for determination',
                        'routeddescription': 'Foster care client is assigned for determination',
                        'eventcode': 'PLTR',
                        'status': 70
                    }
                };
                break;
            case 'CaseClosureReview':
                data = {
                    'where': {
                        'assignedtoid': (this.ivestatusCode === 204 || this.ivestatusCode === 205) ? this.bulkassign[0].assignedtoid : this.selectedPerson.userid,
                        'eventcode': 'IVECCR',
                        'bulkassign': this.bulkassign,
                        'userprofilerole': this.role,
                        'touserrole': (this.ivestatusCode === 204 || this.ivestatusCode === 205) ? null : this.selectedPerson.rolecode,
                        'status': this.ivestatusCode == 201 ? 202 : this.ivestatusCode, 
                        'comments': 'Case Closure is assigned for Review',
                        'routeddescription': 'Case Closure is assigned for Review'
                    }
                };
                break;
            case 'Guardianship':
                data = {
                    'where': {
                        'assignedtoid': this.selectedPerson.userid,
                        'eventcode': 'GAAR',
                        'bulkassign': this.bulkassign,
                        'userprofilerole': this.role,
                        'touserrole': this.selectedPerson.rolecode,
                        'status': 73,
                        'comments': 'Gap client is assigned for determination',
                        'routeddescription': 'Gap client is assigned for determination'
                    }
                };
                break;
            case 'Adoption':
                data = {
                    'where': {
                        'assignedtoid': this.selectedPerson.userid,
                        'eventcode': 'ABLR',
                        'bulkassign': this.bulkassign,
                        'userprofilerole': this.role,
                        'touserrole': this.selectedPerson.rolecode,
                        'status': 67,
                        'comments': 'Adoption client is assigned for determination',
                        'routeddescription': 'Adoption client is assigned for determination'
                    }
                };
                break;
            case 'AdoptionApplicability':
                data = {
                    'where': {
                        'assignedtoid': this.selectedPerson.userid,
                        'eventcode': 'ADAP',
                        'bulkassign': this.bulkassign,
                        'userprofilerole': this.role,
                        'touserrole': this.selectedPerson.rolecode,
                        'status': 67,
                        'comments': 'Adoption applicability client is assigned for determination',
                        'routeddescription': 'Adoption applicability client is assigned for determination'
                    }
                };
                break;
        }
        return data;
    }

    assignUser() {
        this._commonHttpService.create(this.getAssignUserParams(), this.assignspecialisturl).subscribe(() => {
            this.loadMainGrid(this.selectedGrid);
            this._alertService.success(this.caseassignedmsg);
            $('#caseassign').modal('hide');
        });
    }

    onSelectedeligibilty(event: string) {
        if(this.selectedeligibility != event){
        this.selectedeligibility = event;
        
        this.displayList(this.selectedGrid,'progress-bar');
        
        if (event == 'ineligible' || 'noneligible') {
            this.series = [{}];
            this.getgraphdetails(event);
        }
    }
    }
    getgraphdetails(event:string) {
        const eligibilestatus = this.geteligibiltystatus();
        const filtertype = event =='ineligible' ? 'Ineligible' :'Eligible Non-Reimbursable'
        //const filtertype =event
        const fosterCareDashboardParam = {
            'status': this.userRole === 'ive-supervisor' ? '{16,71}' : '{70}',
            'eventType': 'Fostercare',
            'fname': this.fosterCare.value.fname ? this.fosterCare.value.fname.trim() : null,
            'lname': this.fosterCare.value.lname ? this.fosterCare.value.lname.trim() : null,
            'clientId': this.fosterCare.value.clientId ? this.fosterCare.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'rdate': this.fosterCare.value.rdate ? moment(this.fosterCare.value.rdate).format('MM-DD-YYYY') : null,
            'todate': this.fosterCare.value.todate ? moment(this.fosterCare.value.todate).format('MM-DD-YYYY') : this.fosterCare.value.rdate ? moment(this.maxDate).format('MM-DD-YYYY') : null,            
            'eligiblestatus': eligibilestatus,
            'county': this.fosterCare.value.countylist ? this.fosterCare.value.countylist : null,
            'sortingorder': this.displaysortorder ? this.displaysortorder : null,
            'assignedspecialist': this.fosterCare.value.assignedSpecialist ? this.fosterCare.value.assignedSpecialist : null,
            'filtertype': filtertype
        };
        const pagination = {
            page: this.paginationInfo.pageNumber,
            limit: this.paginationInfo.pageSize,
        }

        this.titleIVeService.getIneligiblegraphdata(fosterCareDashboardParam, pagination).subscribe(response => {
            if (response && response.fostercareineligibledetails && Array.isArray(response.fostercareineligibledetails)) {
                //categories = ['Demographics', 'Removal Type', 'Removal Home', 'Court Order', 'Income Summary', 'Asset', 'Deprivation'];   
                let categories: any;
                if(event =='ineligible'){
                const categories1 = ['courtordercount', 'removalhomecount', 'placementcount', 'incomecount', 'deprivationcount', 'assetscount', 'demographiccount', 'removaltypecount'];
               categories = ['demographiccount', 'removaltypecount', 'removalhomecount', 'courtordercount', 'incomecount', 'assetscount', 'deprivationcount','placementcount'];
               this.categories = ['Demographics', 'Removal Type', 'Removal Home', 'Court Order', 'Income Summary', 'Asset', 'Deprivation', 'Placement Count'];
                }
                else if(event =='noneligible'){
                    categories=['demographiccount','courtordercount','placementcount']
                   this. categories = ['Demographics', 'Court Order', 'Placement Count'];
                }
                const values = response.fostercareineligibledetails[0];
                // this.series['data']=values;
                this.series = [{
                    name: '', 
                    data: categories.map((key: string | number) => values[key]),
                    colorByPoint: true
                }];

                // this.series['data']=categories.map(key=>values[key]);

            }

        })

    }
    onSelectedprogress(event: any) {
        this.progressselected = event;
        this.selectedApprovalStatus='';
        this.selectedeligibility ='';
        this.myalertscount='';
        if(this.selectedGrid ==='Approvals'){
            this.selectedApprovalStatus= event;

            
        }
        if(this.selectedGrid==='MyAlerts'){
          this.myalertscount =event;
        }
        this.displayList(this.selectedGrid,'progress-bar');

    }

    onSelectedGrid(event: string) {
        this.fosterCare.patchValue({programtype : null});
        this.fosterCare.patchValue({approvalstatus :null})
        this.selectedGrid = event;
        this.progressselected='';
        this.selectedApprovalStatus ='';
        this.returntodashboard=false;
        this.displayList(event);

        // this.reset();
        // this.selectedGrid = event;
        // this.loadMainGrid(this.selectedGrid);
    }
    geteligibiltystatus() {
         var eligibilitystatus = null;
        //  if(this.searchfromgrid){

        //  }
        //  else{
        if (this.progressselected) {
            if (this.progressselected == 'Pending') {
                eligibilitystatus = 'Pending';
                // this.fosterCare.patchValue({assignedspecialist :null})

            } else if (this.progressselected == 'completed') {
                //  eligibilitystatus='Eligible Reimbursable'
                if(this.fromsearch){
                    eligibilitystatus =this.fosterCare.value.eligiblestatus;
                    this.selectedeligibility=this.eligibiltyvaluefromsearch(this.fosterCare.value.eligiblestatus);
                    this.onSelectedeligibilty(this.selectedeligibility) ;
                    
                }
                else{
                if (this.selectedeligibility) {
                    switch (this.selectedeligibility) {
                        case 'eligible': eligibilitystatus = 'Eligible Reimbursable';
                            break;
                        case 'noneligible': eligibilitystatus = 'Eligible Non-Reimbursable';
                            break;
                         case 'ineligible':  eligibilitystatus = 'Ineligible';
                            break;
                    }
                }
            }

            }
            else {
                eligibilitystatus = null
            }
            if(!this.fromsearch){
            this.fosterCare.patchValue({ eligiblestatus: null })
            }

        }
        else {
            eligibilitystatus = this.fosterCare.value.eligiblestatus ? this.fosterCare.value.eligiblestatus : null;
        }
    // }
        return eligibilitystatus;
    }
    eligibiltyvaluefromsearch(status: any){
        let eligibilitystatus =''
        switch (status) {
            case 'Eligible Reimbursable': eligibilitystatus = 'eligible';
                break;
            case 'Eligible Non-Reimbursable': eligibilitystatus = 'noneligible';
                break;
            
            case 'Ineligible': eligibilitystatus = 'ineligible';
                break;
        }
        this.titleIVeService.seteligibilityselectedactive(eligibilitystatus);
   return eligibilitystatus
    }
    getfiltertype() {
        if (this.progressselected == 'unassigned' || this.progressselected == 'completed') {
            return this.progressselected;
        }
        else  if(this.progressselected == 'Pending'){
            return this.selectedeligibility;
        }
    }

    confirmClosure(event: any) : void {
        const assigndata = JSON.parse(event);
        const isApprove = true;
        this.selectedccr = {
            assigndata, isApprove
        };
        $('#ccrconfirm').modal('show');

    }

    updateClosure(assigndata: { ivestatuscode: number; caseid: any; ivecaseclosurereviewid: any; fromid: any; }, isApprove: any) {
        let ivestatuscode = assigndata.ivestatuscode == 203 && isApprove ? 204 : 205;
        this.ivestatusCode = assigndata.ivestatuscode == 201 ? 202 : ivestatuscode;
        this.bulkccrassign.push({
            servicecaseid: assigndata.caseid,
            notifymsg: 'Case Closure Review is approved',
            objectid: assigndata.ivecaseclosurereviewid,
            assignedtoid: assigndata.fromid
        });
        this.assignUserCCR();
    }

    assignUserCCR() {
        const data = {
            'where': {
                'assignedtoid': (this.ivestatusCode === 204 || this.ivestatusCode === 205) ? this.bulkccrassign[0].assignedtoid : this.selectedPerson.userid,
                'eventcode': 'IVECCR',
                'bulkassign': this.bulkccrassign,
                'userprofilerole': this.role,
                'touserrole': (this.ivestatusCode === 204 || this.ivestatusCode === 205) ? null : this.selectedPerson.rolecode,
                'status': this.ivestatusCode == 201 ? 202 : this.ivestatusCode,
                'comments': 'Case Closure is assigned for Review',
                'routeddescription': 'Case Closure is assigned for Review'
            }
        };
        this._commonHttpService.create(data,'titleive/ive/assignspecialist').subscribe(response => {
            this.bulkccrassign = [];
            if(this.ivestatusCode === 204 || this.ivestatusCode === 205) {
                this.loadMainGrid('CaseClosureApproval');
                this._alertService.success(`Case ${this.ivestatusCode === 204 ? 'Approved' : 'Rejected'}`);
                $('#ccrconfirm').modal('hide');
            } else {
                this.getClosureDetails();
                this._alertService.success('Case Assigned Successfully');
                $('#caseassignccr').modal('hide');
            }
        });
    }
    getrequestedfromuser(nameoftheuser: string){
        if(this.userRole === 'ive-supervisor' )
        return this.fosterCare.value.assignedSpecialist ? this.fosterCare.value.assignedSpecialist:null;
      else if(this.userRole === 'ive-specialist'){
       return nameoftheuser;
}

    }
}


