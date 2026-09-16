import { Component, OnInit, Injector } from '@angular/core';
import { Router } from '@angular/router';
import _ from 'lodash';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import {DropdownModel, DynamicObject, PaginationRequest, PaginationInfo } from '../../../@core/entities/common.entities';
import { Title4eService } from '../services/title4e.service';
import { AppConstants } from '../../../@core/common/constants';
import {AlertService, AuthService, SessionStorageService, DataStoreService} from '../../../@core/services';
import { FormGroup, FormBuilder } from '@angular/forms';
import moment from 'moment';
import { Observable, Subject} from 'rxjs';
import {CommonUrlConfig} from '../../../@core/common/URLs/common-url.config';
import { NavigationUtils } from '../../_utils/navigation-utils.service';
import { AppUser } from '../../../@core/entities/authDataModel';
import { ReviewGridModal } from '../../cjams-dashboard/_entities/dashBoard-datamodel';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'supervisor4e',
    templateUrl: './supervisor4e.component.html',
    styleUrls: ['./supervisor4e.component.scss'],
    standalone: false
})
export class Supervisor4eComponent implements OnInit {
    assignedCaseForm!: FormGroup;
    assignedSearchCriteria: any;
    totalRecordsSupervisor!: number;
    fosterCare!: FormGroup;
    gap!: FormGroup;
    adoption!: FormGroup;
    acaform!: FormGroup;
    approvalform!: FormGroup;
    ccrAssignform!: FormGroup;
    ccrApprovalform!: FormGroup;
    supervisorDetails: any;
    fcCount!: number;
    gapCount!: number;
    adopCount!: number;
    acaCount!: number;
    closureCount!: number;
    closureApprovalCount!: number;
    approvalCount!: number;
    fosterCareData: any = [];
    fosterCareMasterData: any = [];
    guardianShipData: any = [];
    guardianShipMasterData: any = [];
    adoptionData: any = [];
    acaData: any = [];
    closureData: any = [];
    closureApprovalData: any = [];
    activeModule: any = null;
    adoptionMasterData: any = [];
    acaMasterData: any = [];
    specialistList!: any[];
    fosterCareApprovalData: any = [];
    guardianShipApprovalData: any = [];
    adoptionApprovalData: any = [];
    approvalData: any = [];
    approvalListData: any = [];
    workersList: any[] = [];
    clientId = '';
    selectedStatus = 'OPEN';
    user!: any;
    roleName: any;
    selectedccr: any;
    selectAssignBulk!: boolean;
    add = {
        test2: '',
        test3: '',
        test4: ''
    };
    routeData: any;
    getUsersList: any[]=[];
    selectedPerson: any;
    paginationInfo: PaginationInfo = new PaginationInfo();
    gapPaginationInfo: PaginationInfo = new PaginationInfo();
    adopPaginationInfo: PaginationInfo = new PaginationInfo();
    acaPaginationInfo: PaginationInfo = new PaginationInfo();
    closurePaginationInfo: PaginationInfo= new PaginationInfo();
    closureApprovalPaginationInfo: PaginationInfo= new PaginationInfo();
    approvalPaginationInfo: PaginationInfo = new PaginationInfo();
    onPaginationInfo: PaginationInfo = new PaginationInfo();
    dynamicObjectReviewToSupervisor: DynamicObject = {};
    reviewToSupervisor!: ReviewGridModal[];
    aprvl: any;
    enablefcAssign!: boolean;
    enablegapAssign!: boolean;
    enableacaAssign!: boolean;
    enableadpAssign!: boolean;
    enableccrAssign!: boolean;
    bulkfcassign: any[] = [];
    bulkgapassign: any[] = [];
    bulkacaassign: any[] = [];
    bulkadpassign: any[] = [];
    bulkccrassign: any[] = [];
    countyDropDownItems$!: Observable<DropdownModel[]>;
    countylistdropdown: any[] = [];
    displaysortorder!:any;
    reverse = 0;
    dashboardname = 'IV-E SUPERVISOR';
    role = 'IVESV';
    isassign = true;
    isassignedstr = ' is assigned';
    assignspecialisturl = 'titleive/ive/assignspecialist';
    caseassignedmsg = 'Case Assigned Successfully ';
    ivestatusCode = 201;
    supervisorList: any = [];
    roleId!: AppUser;
    currentUser!: string;
    myTaskForm!: FormGroup;
    taskbulkassign: any[] = [];
    enableTaskAssign!: boolean;
    myTasklist: any[] = [];
    myTaskDetailsData: any;
    myTaskDetailsColumns: string[] = [];
    myTaskTotalCount: number = 0;
    customTaskpaginationInfo: PaginationInfo = new PaginationInfo();
    
    private pageStreamOnGoing$ = new Subject<number>();
    private searchTermStreamOnGoing$ = new Subject<DynamicObject>();

    private router: Router;
    private _commonHttpService: CommonHttpService;
    private titleIVeService: Title4eService;
    private _alertService: AlertService;
    private _sessionStorage: SessionStorageService;
    private _formBuilder: FormBuilder;
    private _dataStore: DataStoreService;
    public _authService: AuthService;
    private navigateutil: NavigationUtils;
    constructor(private injector: Injector) {
        this.router = this.injector.get<Router>(Router);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.titleIVeService = this.injector.get<Title4eService>(Title4eService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._dataStore = this.injector.get<DataStoreService>(DataStoreService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this.navigateutil = this.injector.get<NavigationUtils>(NavigationUtils);
    }

    ngOnInit() {
        this._authService.initAuthService('ivefc').subscribe(result => {
            this._authService.setAuthDetail('ivefc',result);
        });
        this.activeModule = this._sessionStorage.getItem('activeModuleNav');
        if(this.activeModule == '4E QA'){
            this.dashboardname = 'IV-E Eligibility Quality Assurance' ;
            this.role = 'IVEQA';
        } else if(this.activeModule == '4E Adminstrator') {
            this.dashboardname = 'IV-E Eligibility Administrator';
            this.role = 'IVEADMIN';            
        } else if(this.activeModule == '4E AdminAssist') {
            this.dashboardname = 'IV-E Eligibility Administrator Assistant';
            this.role = 'IVEAA'; 
        }
        
        this.fosterCare = this._formBuilder.group({
            clientId: [''],
            fname: [''],
            lname: [''],
            rdate: [''],
            eligiblestatus: [''],
            countylist: [''],
            sortingorder: ['']
        });
        this.gap = this._formBuilder.group({
            clientId: [''],
            fname: [''],
            lname: [''],
            rdate: [''],
            countylist: [''],
            eligiblestatus: ['']
        });
        this.myTaskForm = this._formBuilder.group({
            clientId: [''],
            programtype: ['FOSTER CARE'],
            countylist: [''],
            assignedSpecialist: ['']
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
            jurisdictionlist :['']
        });
        this.ccrApprovalform = this._formBuilder.group({
            clientId: [''],
            casenumber: [''],
            securityusersid: [''],
            status: [''],
            county : [''],
        });
        this.user = JSON.parse(localStorage.getItem('userProfile')?? "");
        this.getSupervisorDetails();
        this.loadIVeSpecialist();
        this.getGuardianShipDetails();
        this.getAdoptionDetails();
        this.getACADetails();
        this.getClosureDetails();
        this.getClosureApprovalDetails();
        this.getWorkersList();
        this.loadCounty('MD');
        this.aprovalDetails(null);
        this.getTaskDetails();
        this._dataStore.setData("FosterCare_Selected_Period", null);
        this._dataStore.setData("FosterCare_Selected_Component", null);
        this._authService.readonlyPage('titleive_read_only_access','',
        [this.approvalform]);

        this.roleId = this._authService.getCurrentUser();
        if (this.roleId && this.roleId.user && this.roleId.user.userprofile) {
            const user = this.roleId.user.userprofile;
            this.currentUser = (user.lastname ? user.lastname : '') + ',    ' + (user.firstname ? user.firstname : '');
        }
        this.loadSupervisor();

    }

    private loadSupervisor() {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'IVEADOP' },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe(result => {
                this.supervisorList = result['data'];
                if(this.supervisorList && this.supervisorList?.length && this.supervisorList?.length>0){
                    this.supervisorList = this.supervisorList.filter((item: any) => (item?.username !=null && item?.username !== "" 
                    && item.rolecode === AppConstants.ROLES.TITLE_IVE_SUPERVISOR));
                }
                this.ccrApprovalform.controls['securityusersid'].patchValue(this.roleId.user.userprofile.securityusersid);
            });
    }

    private loadIVeSpecialist() {
        this.titleIVeService.getUsersList().subscribe(result => this.fetchUsersList(result));
    }

    Restore() {
        this.add.test2 = '';
        this.add.test3 = '';
        this.add.test4 = '';
    }
    onspecialistSelect(specialist:any, i:any) {
        this.specialistList.splice(i, 1);
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
    selectPerson(item:any) {
        this.selectedPerson = item;
    }
    accept(item:any) {
        item.STATUS = 'ACCEPTED';
    }
    changeSelectedStatus(status:any) {
        this.selectedStatus = status;
    }
    getSupervisorDetails() {
        this.supervisorDetails = {
            firstName: '',
            lastName: '',
            title: '',
            Jurisdiction: '',
            phoneNumber: ''
        };
        this.specialistList = [
            {
                id: '',
                name: ''
            },
            {
                id: '',
                name: ''
            }
        ];
        const fosterCareDashboardParam = {
            'status': '{16,71}',
            'eventType': 'Fostercare',
            'fname': this.fosterCare.value.fname ? this.fosterCare.value.fname.trim() : null,
            'lname': this.fosterCare.value.lname ? this.fosterCare.value.lname.trim() : null,
            'clientId': this.fosterCare.value.clientId ? this.fosterCare.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'rdate': this.fosterCare.value.rdate ? moment(this.fosterCare.value.rdate).format('MM-DD-YYYY') : null,
            'eligiblestatus': this.fosterCare.value.eligiblestatus ? this.fosterCare.value.eligiblestatus : null,
            'county': this.fosterCare.value.countylist ? this.fosterCare.value.countylist : null,
            'sortingorder': this.displaysortorder ? this.displaysortorder : null
        };
        const pagination = {
            page: this.paginationInfo.pageNumber,
            limit: this.paginationInfo.pageSize
        }
        this.titleIVeService.getDashboardData(fosterCareDashboardParam, pagination).subscribe(response => {
            this.bulkfcassign = [];
            this.enablefcAssign = false;
            this.enableTaskAssign = false;
            if (response && response.data && Array.isArray(response.data)) {
                this.fosterCareData = response.data;
                this.fosterCareMasterData = response.data;
                if (response.data && response.data.length) {
                    this.fcCount = response.data[0].countdata;
                }
            }
        });

    }
    fostercareselection(checked:any, assigndata:any) {
        const receipt = JSON.parse(JSON.stringify(assigndata));
        const selectedReceipt = (this.bulkfcassign && this.bulkfcassign.length > 0) ? this.bulkfcassign.find(rec => rec.objectid === receipt.placementid) : null;
        if (checked) {
            if (!selectedReceipt) {
                this.bulkfcassign.push({
                    servicecaseid: assigndata.caseid,
                    objectid: assigndata.placementid,
                    clientid: assigndata.clientid,
                    notifymsg: 'Foster Care determination for client ' + assigndata.clientid + this.isassignedstr
                });
            }
        } else {
            this.selectAssignBulk = false;
            this.bulkfcassign = this.bulkfcassign.filter(rec => rec.objectid !== receipt.placementid);
        }
        this.enablefcAssign = !!this.bulkfcassign.length;
        this.enableTaskAssign = !!this.bulkfcassign.length;
        const assignlist = this.fosterCareData;
        if (this.bulkfcassign.length !== 0) {
            const bulkcheckboxselect = (assignlist.length === this.bulkfcassign.length);
            if (bulkcheckboxselect) {
                this.selectAssignBulk = true;
            } else {
                this.selectAssignBulk = false;
            }
        } else {
            this.selectAssignBulk = false;
        }
    }
    getBulkAssign(event:any) {
        this.bulkfcassign = [];
        if (event) {
            this.enablefcAssign = true;
            this.enableTaskAssign = true;
            if (this.fosterCareData && this.fosterCareData.length) {
                for (let i = 0; i < this.fosterCareData.length; i++) {
                    $('#trans-id-' + i).prop('checked', true); /* //NOSONAR */
                    this.selectAssignBulk = true;
                    this.bulkfcassign.push({
                        servicecaseid: this.fosterCareData[i].caseid,
                        objectid: this.fosterCareData[i].placementid,
                        clientid: this.fosterCareData[i].clientid,
                        notifymsg: 'Foster Care determination for client ' + this.fosterCareData[i].clientid + this.isassignedstr
                    });
                }
            }
        } else {
            this.enablefcAssign = false;
            this.enableTaskAssign =  false;
            this.selectAssignBulk = false;
            $('.trans').prop('checked', false);/* //NOSONAR */

        }
    }
    gapselection(event:any, assigndata:any) {
        const checked =event?.target.checked
        const receipt = JSON.parse(JSON.stringify(assigndata));
        const selectedReceipt = (this.bulkgapassign && this.bulkgapassign.length > 0) ? this.bulkgapassign.find(rec => rec.objectid === receipt.gapagreementid) : null;
        if (checked) {
            if (!selectedReceipt) {
                this.bulkgapassign.push({
                    servicecaseid: assigndata.caseid,
                    objectid: assigndata.gapagreementid,
                    clientid: assigndata.clientid,
                    notifymsg: 'Gap determination for client ' + assigndata.clientid + this.isassignedstr
                });
            }
        } else {
            this.bulkgapassign = this.bulkgapassign.filter(rec => rec.objectid !== receipt.gapagreementid);
        }
        this.enablegapAssign = !!this.bulkgapassign.length;
        this.enableTaskAssign = !!this.bulkgapassign.length;
    }
    adoptionselection(event:any, assigndata:any) {
        const checked =event.target.checked
        const receipt = JSON.parse(JSON.stringify(assigndata));
        const selectedReceipt = (this.bulkadpassign && this.bulkadpassign.length > 0) ? this.bulkadpassign.find(rec => rec.objectid === receipt.adoptionbreakthelinkid) : null;
        if (checked) {
            if (!selectedReceipt) {
                this.bulkadpassign.push({
                    servicecaseid: assigndata.caseid,
                    objectid: assigndata.adoptionbreakthelinkid,
                    clientid: assigndata.clientid,
                    notifymsg: 'Adoption determination for client ' + assigndata.clientid + this.isassignedstr
                });
            }
        } else {
            this.bulkadpassign = this.bulkadpassign.filter(rec => rec.objectid !== receipt.adoptionbreakthelinkid);
        }
        this.enableadpAssign = !!this.bulkadpassign.length;
        this.enableTaskAssign = !!this.bulkadpassign.length;
    }
    acaselection(event:any, assigndata:any) {
        const checked =event.target.checked;
        const receipt = JSON.parse(JSON.stringify(assigndata));
        const selectedReceipt = (this.bulkacaassign && this.bulkacaassign.length > 0) ? this.bulkacaassign.find(rec => rec.objectid === receipt.adoptionbreakthelinkid) : null;
        if (checked) {
            if (!selectedReceipt) {
                this.bulkacaassign.push({
                    servicecaseid: assigndata.caseid,
                    objectid: assigndata.adoptionbreakthelinkid,
                    clientid: assigndata.clientid,
                    notifymsg: 'Adoption applicability determination for client ' + assigndata.clientid + this.isassignedstr
                });
            }
        } else {
            this.bulkacaassign = this.bulkacaassign.filter(rec => rec.objectid !== receipt.adoptionbreakthelinkid);
        }
        this.enableacaAssign = !!this.bulkacaassign.length;
    }
    updateClosure(assigndata:any, isApprove:any) {
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
    confirmClosure(assigndata:any, isApprove:any) {
        this.selectedccr = {
            assigndata, isApprove
        };
        $('#ccrconfirm').modal('show');
    }

    closureselection(event:any, assigndata:any) {
        const checked =event.target.checked;
        const receipt = JSON.parse(JSON.stringify(assigndata));
        this.ivestatusCode = 202;
        const selectedReceipt = (this.bulkccrassign && this.bulkccrassign.length > 0) ? this.bulkccrassign.find(rec => rec.servicecaseid === receipt.caseid) : null;
        if (checked) {
            if (!selectedReceipt) {
                this.bulkccrassign.push({
                    servicecaseid: assigndata.caseid,
                    notifymsg: `The Case Closure Review Request for #${assigndata.casenumber} is assigned`,
                    objectid: assigndata.ivecaseclosurereviewid
                });
            }
        } else {
            this.selectAssignBulk = false;
            this.bulkccrassign = this.bulkccrassign.filter(rec => rec.servicecaseid !== receipt.caseid);
        }
        this.enableccrAssign = !!this.bulkccrassign.length;
        const assignlist = this.closureData;
        if (this.bulkccrassign.length !== 0) {
            const bulkcheckboxselect = (assignlist.length === this.bulkccrassign.length);
            if (bulkcheckboxselect) {
                this.selectAssignBulk = true;
            } else {
                this.selectAssignBulk = false;
            }
        } else {
            this.selectAssignBulk = false;
        }
    }
    getGuardianShipDetails() {
        const guardianShipDashboardParam = {
            'status': '{16,73}',
            'eventType': 'Gap',
            'fname': this.gap.value.fname ? this.gap.value.fname.trim() : null,
            'lname': this.gap.value.lname ? this.gap.value.lname.trim() : null,
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
        this.titleIVeService.getDashboardData(guardianShipDashboardParam, pagination).subscribe(response => {
            this.bulkgapassign = [];
            this.enablegapAssign = false
            this.enableTaskAssign = false;
            if (response && response.data && Array.isArray(response.data)) {
                this.guardianShipData = this.guardianShipMasterData = response.data;
            }
            if (response.data && response.data.length) {
                this.gapCount = response.data[0].countdata;
            }
        });
    }
    getAdoptionDetails() {
        const adoptionDashboardParam = {
            'status': '{16,68,69}',
            'eventType': 'Adoption',
            'fname': this.adoption.value.fname ? this.adoption.value.fname.trim() : null,
            'lname': this.adoption.value.lname ? this.adoption.value.lname.trim() : null,
            'clientId': this.adoption.value.clientId ? this.adoption.value.clientId.trim() : null,
            'roleTypeKey': this.role,
            'rdate':  null,
            'eligiblestatus': this.adoption.value.eligiblestatus ? this.adoption.value.eligiblestatus : null,
            'county': this.adoption.value.countylist ? this.adoption.value.countylist : null
        };
        const pagination = {
            page: this.adopPaginationInfo.pageNumber,
            limit: this.adopPaginationInfo.pageSize,
        }
        this.titleIVeService.getDashboardData(adoptionDashboardParam, pagination).subscribe(response => {
            this.enableadpAssign = false;
            this.enableTaskAssign = false;
            this.bulkadpassign = [];
            if (response && response.data && Array.isArray(response.data)) {
                this.adoptionData = this.adoptionMasterData = response.data;
            }
            if (response.data && response.data.length) {
                this.adopCount = response.data[0].countdata;
            }
        });
    }
    getACADetails() {
        const adoptionDashboardParam = {
            'status': '{16,68,69}',
            'eventType': 'ACA',
            'fname': this.acaform.value.fname ? this.acaform.value.fname.trim() : null,
            'lname': this.acaform.value.lname ? this.acaform.value.lname.trim() : null,
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
        this.titleIVeService.getDashboardData(adoptionDashboardParam, pagination).subscribe(response => {
            this.enableacaAssign = false;
            this.bulkacaassign = [];
            if (response && response.data && Array.isArray(response.data)) {
                this.acaData = this.acaMasterData = response.data;
            }
            if (response.data && response.data.length) {
                this.acaCount = response.data[0].countdata;
            }
        });
    }

    getClosureDetails() {
        const closureDashboardParam = {
            roleid: 'IVECCR',
            fromsecurityusersid: null,
            tosecurityuserid: null, 
            statustype: 'assignment',
            casenumber: this.ccrAssignform.value.casenumber ? this.ccrAssignform.value.casenumber.trim() : null,
            clientId: this.ccrAssignform.value.clientId ? this.ccrAssignform.value.clientId.trim() : null,
            status: this.ccrAssignform.value.status ? this.ccrAssignform.value.status.trim() : null,
            county: this.ccrAssignform.value.jurisdictionlist ? this.ccrAssignform.value.jurisdictionlist : null
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
            if ( this.closureData &&  this.closureData.length) {
                this.closureCount =  this.closureData[0].countdata;
            }
            else {
                this.closureCount = 0;
            }
        });
    }

    supervisorChange() {
        this.getClosureApprovalDetails();
    }

    getClosureApprovalDetails() {
        const closureDashboardParam = {
            roleid: 'IVECCR',
            fromsecurityusersid: null,
            tosecurityuserid: this.ccrApprovalform.value.securityusersid ? this.ccrApprovalform.value.securityusersid.trim() : null, 
            statustype: 'approval',
            casenumber: this.ccrApprovalform.value.casenumber ? this.ccrApprovalform.value.casenumber.trim() : null,
            clientId: this.ccrApprovalform.value.clientId ? this.ccrApprovalform.value.clientId.trim() : null,
            status: this.ccrApprovalform.value.status ? this.ccrApprovalform.value.status.trim() : null,
            county: this.ccrApprovalform.value.county? this.ccrApprovalform.value.county: null
        };
        if (this.roleId && this.roleId.user && this.ccrApprovalform.value.securityusersid === this.roleId.user.userprofile.securityusersid){
            closureDashboardParam.tosecurityuserid = null;
        }
        const pagination = {
            page: this.closureApprovalPaginationInfo.pageNumber,
            limit: this.closureApprovalPaginationInfo.pageSize,
        }
        this.titleIVeService.getClosureDashboardData(closureDashboardParam, pagination).subscribe(response => {
            this.handleGetClosureDashboardRespFn(response);
        });
    }
    // Assosiated with getClosureApprovalDetails method
    private handleGetClosureDashboardRespFn(response: any) {
        if (response && response.data && Array.isArray(response.data)) {
            this.closureApprovalData = response.data.filter((x :any)=> x.ivereviewstatus === 'CCR_Approved' || x.ivereviewstatus === 'CCR_Pending');
            this.closureApprovalData = response.data;
        }
        if (this.closureApprovalData && this.closureApprovalData.length) {
            this.closureApprovalCount = this.closureApprovalData[0].countdata;
        } else{
            this.closureApprovalCount = 0;
        }
    }

    getprogramtype(programs:any){
        return programs.map(({programkey}:any)=>programkey).join(' / ');
    }

    // The title4e pages carry the client id in the route and their tab components
    // read it back off the URL, so a worklist row with a null client id opens
    // '/adoption/null/...' and every id-keyed call from that page is rejected with
    // a bare 400. Refuse the navigation and say why rather than opening a page that
    // cannot load.
    private hasClientId(clientid:any): boolean {
        if (clientid === null || clientid === undefined || clientid === ''
            || isNaN(Number(clientid))) {
            this._alertService.error('This record has no client ID, so the Title IV-E page cannot be opened.');
            return false;
        }
        return true;
    }

    searchClosure(personData:any, ptype:any) {
        var url = '';
        if (!this.hasClientId(personData && personData.cjamspid)) {
            return;
        }
        personData.clientid = personData.cjamspid;
        if(ptype == 'gap'){
            url = '#/pages/title4e/guardianship/' + personData.cjamspid + '/' + personData.guardian_subsidy_id
            window.open(url)
        } else if(ptype == 'ooh'){
            this.navigateutil.loadFostcareIVE(personData.clientid, personData.removalid, null);
        } else if(ptype == 'adop') {
            url = '#/pages/title4e/adoption/' + personData.cjamspid + '/' + personData.removalid
            window.open(url)
            // this.router.navigate(['/pages/title4e/adoption', personData.cjamspid, personData.removalid])
        }
    }

    aprovalDetails(approvalstatus:any) {
        const nameoftheuser = this.user.firstname + ' ' + this.user.lastname;
        const roleTypeKey = this.role;
        const apprStatus = this.approvalform.value.approvalstatus ? this.approvalform.value.approvalstatus : 'PENDING';
        const approvalDashboardParam = {
            'status': '{71,74,68}',
            'clientId': this.approvalform.value.clientId ? this.approvalform.value.clientId : null,
            'roleTypeKey': roleTypeKey ? roleTypeKey : null,
            'approvalstatus': approvalstatus ? approvalstatus : apprStatus,
            'programtype': this.approvalform.value.programtype ? this.approvalform.value.programtype : null,
            'requestedtouser': nameoftheuser ? nameoftheuser : null,
            'requestedfromuser': null
        };
        const pagination = {
            page: this.approvalPaginationInfo.pageNumber,
            limit: this.approvalPaginationInfo.pageSize,
        }
        this.titleIVeService.getDashboardApprovalData(approvalDashboardParam, pagination).subscribe(response => {
            this.getDashboardApprovalDataResponse(response);
        });

    }
    private getDashboardApprovalDataResponse(response: any) {
        if (response && response.data && Array.isArray(response.data)) {
            this.approvalData = response.data;
            if (response.data.length > 0) {
                this.approvalform.patchValue({ approvalstatus: response.data[0].approval_status });
            }
        }
        if (response.data && response.data.length) {
            this.approvalCount = response.data[0].countdata;
        }
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

       

    getFosterCareApprovalDetails() {
        const fosterCareDashboardParam = {
            'status': '{71}',
            'eventType': 'Fostercare'
        };
        this.titleIVeService.getDashboardApprovalData(fosterCareDashboardParam).subscribe(response => {
            if (response && response.data && Array.isArray(response.data)) {
                this.fosterCareApprovalData = response.data;
            }
        });

    }
    getGuardianShipApprovalDetails() {
        const guardianShipDashboardParam = {
            'status': '{74}',
            'eventType': 'Gap'
        };
        this.titleIVeService.getDashboardApprovalData(guardianShipDashboardParam).subscribe(response => {
            if (response && response.data && Array.isArray(response.data)) {
                this.guardianShipApprovalData = response.data;
            }
        });
    }
    getAdoptionApprovalDetails() {
        const adoptionDashboardParam = {
            'status': '{68}',
            'eventType': 'Adoption'
        };
        this.titleIVeService.getDashboardApprovalData(adoptionDashboardParam).subscribe(response => {
            if (response && response.data && Array.isArray(response.data)) {
                this.adoptionApprovalData = response.data;
            }
        });
    }
    searchClientIds(type: string, searchQuery: string) {
        const clientid = searchQuery.trim();
        switch (type) {
            case 'FC':
                this.fosterCareData = this.filterClientId(clientid, this.fosterCareMasterData);
                break;
            case 'GAP':
                this.guardianShipData = this.filterClientId(clientid, this.guardianShipMasterData);
                break;
            case 'ADOP':
                this.adoptionData = this.filterClientId(clientid, this.adoptionMasterData);
                break;
            case 'ACA':
                this.adoptionData = this.filterClientId(clientid, this.acaMasterData);
                break;
        }
    }
    filterClientId(clientid:any, masterData:any) {
        return _.isEmpty(clientid) ? masterData : _.filter(masterData, { clientid });
    }
    onSearch(field: string, value: string) {
        this.router.navigate(['/pages/title4e/supervisor4e']);
    }
    searchFoster(item:any) {
        this.titleIVeService.getClientId(item.client_id);
        if (item.client_id) {
            this.router.navigate(['/pages/title4e/foster-car/' + item.client_id + '/' + item.removal_id]);
        }
    }
    searchFosterDashboard(item:any) {
        this.titleIVeService.getClientId(item.clientid);
        if (item.clientid) {
            this.router.navigate(['/pages/title4e/foster-car/' + item.clientid + '/' + item.removalid]);
        }
    }
    searchGap(clientid:any, removalid:any) {
        if (clientid) {
            this._dataStore.setData('guardianship_clientid', clientid);
            this.router.navigate(['/pages/title4e/guardianship/' + clientid + '/' + removalid]);
        }
    }

    searchTaskDashboard(item: any) {
        // The title4e routes carry the client id as a path segment and the tab
        // components read it back out of the URL, so a row with no client id
        // navigates to '/adoption/null/...' and every id-keyed call from that page
        // fails on the string 'null'. Stop here instead, as searchFoster already does.
        if (!this.hasClientId(item && item.clientid)) {
            return;
        }
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
            var casedata = {
                intakeserviceid: data.caseid,
                casenumber: data.casenumber,
                danumber: data.casenumber,
                datype: 'Request for services'
            }
            this.navigateutil.openRespectiveItem(casedata);
        }
        if (data.casetype === 'adoptioncase') {
            this.navigateutil.routToAdoptionCase({
                servicerequestnumber: data.caseid,
                adoptioncaseid: data.caseid,
                adoptioncasenumber: data.casenumber,
                startdate: data.startdate
            });
        }
    }

    searchAdoption(item:any) {
        if (!this.hasClientId(item && item.clientid)) {
            return;
        }
        if (item) {
            this.router.navigate(['/pages/title4e/adoption/' + item.clientid + '/' + item.removalid]);
            this._dataStore.setData('adoption_clientid', item.clientid);
            this._dataStore.setData('adoption_removalid', item.removalid);
            this._dataStore.setData('adoption_dashboard', 'adoption');
            this._dataStore.setData('adoption_migrated_data', item);
        }
    }
    searchACA(item:any) {
        // The aca route carries the client id in the same position as adoption.
        if (!this.hasClientId(item && item.clientid)) {
            return;
        }
        if (item) {
            this.router.navigate(['/pages/title4e/aca/' + item.clientid + '/' + item.removalid]);
            this._dataStore.setData('adoption_clientid', item.clientid);
            this._dataStore.setData('adoption_removalid', item.removalid);
            this._dataStore.setData('adoption_dashboard', 'aca');
        }
    }
    searchAdoptionApproval(item:any) {
        if (!this.hasClientId(item && item.client_id)) {
            return;
        }
        if (item) {
            this._dataStore.setData('adoption_clientid', item.client_id);
            this._dataStore.setData('adoption_removalid', item.removal_id);
            if (item.sqnm_sw === 'A') {
                this._dataStore.setData('adoption_dashboard', 'aca');
                this.router.navigate(['/pages/title4e/aca/' + item.client_id + '/' + item.removal_id]);
            } else {
                this._dataStore.setData('adoption_dashboard', 'adoption');
                this.router.navigate(['/pages/title4e/adoption/' + item.client_id + '/' + item.removal_id]);
            }
        }
    }

    fetchUsersList(result:any) {
        if(this.role === 'IVEQA' || this.role === 'IVEADMIN'){
            this.getUsersList = result.data.filter((user:any) => (user.rolecode === AppConstants.ROLES.TITLE_IVE_SPECIALIST || user.rolecode === AppConstants.ROLES.TITLE_IVE_ANALYST) && user.userid !== this.user.securityusersid);
        }else {
            this.getUsersList = result.data.filter((user:any) => user.rolecode === AppConstants.ROLES.TITLE_IVE_SPECIALIST && user.userid !== this.user.securityusersid);
        }
    }

    assignFosterCare() {
        this.titleIVeService.getUsersList().subscribe(result => this.fetchUsersList(result));
        $('#caseassign').modal('show');
    }
    assignGuardianShip() {
        this.titleIVeService.getUsersList().subscribe(result => this.fetchUsersList(result));
        $('#caseassignguardianship').modal('show');
    }
    assignAdoption() {
        this.titleIVeService.getUsersList().subscribe(result => this.fetchUsersList(result));
        $('#caseassignadoption').modal('show');
    }
    assignACA() {
        this.titleIVeService.getUsersList().subscribe(result => this.fetchUsersList(result));
        $('#caseassignaca').modal('show');
    }

    assignCCR() {
        this.titleIVeService.getUsersList().subscribe(result => this.fetchUsersList(result));
        $('#caseassignccr').modal('show');
    }

    assignTask() {
        this.titleIVeService.getUsersList().subscribe(result => this.fetchUsersList(result));
        if(this.myTaskForm.value.programtype == 'FOSTER CARE') {
            $('#caseassign').modal('show');
        } else if(this.myTaskForm.value.programtype == 'ADOPTION') {
            $('#caseassignadoption').modal('show');
        } else if (this.myTaskForm.value.programtype == 'GAP') {
            $('#caseassignguardianship').modal('show');
        }
        
    }

    assignUser() {
        const data = {
            'where': {
                'assignedtoid': this.selectedPerson.userid,
                'bulkassign': this.bulkfcassign,
                'userprofilerole': this.role,
                'touserrole': this.selectedPerson.rolecode,
                'comments': 'Foster care client is assigned for determination',
                'routeddescription': 'Foster care client is assigned for determination',
                'eventcode': 'PLTR',
                'status': 70
            }
        };
        this._commonHttpService.create(data,this.assignspecialisturl).subscribe(response => {
            this.getSupervisorDetails();
            if(this.enableTaskAssign) {
                this.getTaskDetails();
            }
            this._alertService.success(this.caseassignedmsg);
            $('#caseassign').modal('hide');
        });
    }
    assignUserGuardianShip() {
        const data = {
            'where': {
                'assignedtoid': this.selectedPerson.userid,
                'eventcode': 'GAAR',
                'bulkassign': this.bulkgapassign,
                'userprofilerole': this.role,
                'touserrole': this.selectedPerson.rolecode,
                'status': 73,
                'comments': 'Gap client is assigned for determination',
                'routeddescription': 'Gap client is assigned for determination'
            }
        };
        this._commonHttpService.create(data,this.assignspecialisturl).subscribe(response => {
            this.getGuardianShipDetails();
            if(this.enableTaskAssign) {
                this.getTaskDetails();
            }
            this._alertService.success(this.caseassignedmsg);
            $('#caseassignguardianship').modal('hide');
        });
    }
    assignUserAdoption() {
        const data = {
            'where': {
                'assignedtoid': this.selectedPerson.userid,
                'eventcode': 'ABLR',
                'bulkassign': this.bulkadpassign,
                'userprofilerole': this.role,
                'touserrole': this.selectedPerson.rolecode,
                'status': 67,
                'comments': 'Adoption client is assigned for determination',
                'routeddescription': 'Adoption client is assigned for determination'
            }
        };
        this._commonHttpService.create(data,this.assignspecialisturl).subscribe(response => {
            this.getAdoptionDetails();
            if(this.enableTaskAssign) {
                this.getTaskDetails();
            }
            this._alertService.success(this.caseassignedmsg);
            $('#caseassignadoption').modal('hide');
        });
    }
    assignUserACA() {
        const data = {
            'where': {
                'assignedtoid': this.selectedPerson.userid,
                'eventcode': 'ADAP',
                'bulkassign': this.bulkacaassign,
                'userprofilerole': this.role,
                'touserrole': this.selectedPerson.rolecode,
                'status': 67,
                'comments': 'Adoption applicability client is assigned for determination',
                'routeddescription': 'Adoption applicability client is assigned for determination'
            }
        };
        this._commonHttpService.create(data,this.assignspecialisturl).subscribe(response => {
            this.getACADetails();
            this._alertService.success(this.caseassignedmsg);
            $('#caseassignaca').modal('hide');
        });
    }
    assignUserCCR() {
        const data = {
            'where': {
                'assignedtoid': (this.ivestatusCode === 204 || this.ivestatusCode === 205) ? this.bulkccrassign[0].assignedtoid : this.selectedPerson.userid,
                'eventcode': 'IVECCR',
                'bulkassign': this.bulkccrassign,
                'userprofilerole': this.role,
                'touserrole': (this.ivestatusCode === 204 || this.ivestatusCode === 205) ? null : this.selectedPerson.rolecode,
                'status': this.ivestatusCode,
                'comments': 'Case Closure is assigned for Review',
                'routeddescription': 'Case Closure is assigned for Review'
            }
        };
        this._commonHttpService.create(data,'titleive/ive/assignspecialist').subscribe(response => {
            this.bulkccrassign = [];
            if(this.ivestatusCode === 204 || this.ivestatusCode === 205) {
                this.getClosureApprovalDetails() 
                this._alertService.success(`Case ${this.ivestatusCode === 204 ? 'Approved' : 'Rejected'}`);
                $('#ccrconfirm').modal('hide');
            } else {
                this.getClosureDetails();
                this._alertService.success('Case Assigned Successfully ');
                $('#caseassignccr').modal('hide');
            }
        });
    }
    resetaca() {
        this.acaform.reset();
        this.getACADetails();
    }
    resetccrApproval() {
        this.ccrApprovalform.reset();
        this.getClosureApprovalDetails();
        this.loadSupervisor();
    }
    resetccrAssign() {
        this.ccrAssignform.reset();
        this.getClosureDetails();
    }
    resetapproval() {
        this.approvalform.reset();
        this.approvalform.patchValue({ approvalstatus: 'PENDING'});
        this.aprovalDetails('PENDING');
    }
    resetadop() {
        this.adoption.reset();
        this.getAdoptionDetails();
    }
    resetgap() {
        this.gap.reset();
        this.getGuardianShipDetails();
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


    reset() {
        this.fosterCare.reset();
        this.getSupervisorDetails();
    }
    pageChanged(pageNumber: any) {
        this.paginationInfo.pageNumber = pageNumber.page;
        this.getSupervisorDetails();
    }
    gapPageChanged(pageNumber: any) {
        this.gapPaginationInfo.pageNumber = pageNumber.page;
        this.getGuardianShipDetails();
    }
    adopPageChanged(pageNumber: any) {
        this.adopPaginationInfo.pageNumber = pageNumber.page;
        this.getAdoptionDetails();
    }
    acaPageChanged(pageNumber: any) {
        this.acaPaginationInfo.pageNumber = pageNumber.page;
        this.getACADetails();
    }
    closurePageChanged(pageNumber: any) {
        this.closurePaginationInfo.pageNumber = pageNumber.page;
        this.getClosureDetails();
    }
    closureApprovalPageChanged(pageNumber: any) {
        this.closureApprovalPaginationInfo.pageNumber = pageNumber.page;
        this.getClosureApprovalDetails();
    }
    approvalPageChanged(pageNumber: any) {
        this.approvalPaginationInfo.pageNumber = pageNumber.page;
        this.aprovalDetails(null);
    }

    myTaskPageChanged(pageNumber: any) {
        this.customTaskpaginationInfo.pageNumber = pageNumber.page;
        this.getTaskDetails();
    }

    setOrder() {
        switch (this.reverse) {
            case 0:
                this.reverse = 1;
                this.displaysortorder = 'asc';
                this.getSupervisorDetails();
                break;
            case 1:
                this.reverse = 2;
                this.displaysortorder = 'desc'
                this.getSupervisorDetails();
                break;
            case 2:
                this.reverse = 0;
                this.displaysortorder = null;
                this.getSupervisorDetails();
                break;
        }
    }

    loadCounty(statekey:any) {
        const state = statekey ? statekey : 'MD';
        this._commonHttpService.create({
            where: { state: state },
            order: 'countyname',
            method: 'post',
            nolimit: true
        }, CommonUrlConfig.EndPoint.Listing.CountyListUrl
        ).subscribe(response => {
            // Filtering DHS Central and Central office from county list on IVE dashboard
            const removeCounties = ['DHS Central', 'Central Office', 'DHRIS', 'SSC', 'OIG'];
            this.countylistdropdown = response.filter((a:any) => !removeCounties.includes(a.countyname));
        });

    }

    downloadApprovalSection() {

        let nameoftheuser = this.user.firstname + ' ' + this.user.lastname;
        let namefromuser;
        let roleTypeKey = this.role;
        let userRoleType = this.dashboardname;
        if (this.activeModule && this.activeModule === '4E SPECIALIST') {
            namefromuser = this.user.firstname + ' ' + this.user.lastname;
            nameoftheuser = '';
            roleTypeKey = 'IVESP';
            userRoleType = 'IV-E Specialist';
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
                requestedtouser: nameoftheuser ? nameoftheuser : null,
                requestedfromuser: namefromuser ? namefromuser : null,
                userName: nameoftheuser ? nameoftheuser : null,
                userRoleType: userRoleType ? userRoleType : null
            },
            limit: 10,
            order: 'desc',
            page: 1,
            count: -1
        };
        this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
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
