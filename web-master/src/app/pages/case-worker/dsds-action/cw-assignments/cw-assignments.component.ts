import {map} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { Assignments } from './assignments.data.model';
import { SessionStorageService, LocalStorageService } from '../../../../@core/services/storage.service';
import { DataStoreService } from '../../../../@core/services/data-store.service';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { FormBuilder, FormGroup, Validators, FormControl, FormGroupDirective, NgForm } from '@angular/forms';
import { CommonDropdownsService, CommonHttpService, AlertService, AuthService } from '../../../../@core/services';
import moment from 'moment';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { ActivatedRoute } from '@angular/router';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { ErrorStateMatcher } from '@angular/material/core';
import { AppConstants } from '../../../../@core/common/constants';
import { CWAssignmentResolverService } from './cw-assignments-resolver.service';
declare const $: any;
export class MyErrorStateMatcher implements ErrorStateMatcher {
    isErrorState(control: FormControl | null, form: FormGroupDirective | NgForm | null): boolean {
        const isSubmitted = form && form.submitted;
        return !!(control && control.invalid && (control.dirty || control.touched || isSubmitted));
    }
}

@Component({
    selector: 'cw-assignments',
    templateUrl: './cw-assignments.component.html',
    styleUrls: ['./cw-assignments.component.scss'],
    standalone: false
})
export class CwAssignmentsComponent implements OnInit {
    eventcode!: string;
    caseTransfer!: FormGroup;
    ldssCaseWorkerList: any;
    unitCaseWorkerList: any;
    workerCaseWorkerList: any;
    assignmentsList$!: Observable<Assignments[]>;
    serviceCaseId!: string;
    isServiceCase!: string;
    teamList: any;
    user: any;
    matcher = new MyErrorStateMatcher();
    isSupervisor: boolean = false;
    iscurrentcaseended: boolean = false;
    isAddVisible!: boolean;
    fromWorkerDetails: any;
    toWorkerDetails: any;
    id!: string;
    departmentList: Array<any> = [];
    caseType!: string;
    isClosed = false;
    childList$!: Observable<any[]>;
    isAdoptionCase!: boolean;
    isReadonly = true;
    currentDate: any;
    assignmentListData: any;
    isFamilyAssignmentActive = false;
    moduleview: any;
    isEditDisabled = false;
    isAddEnabled: any;
    userInfo: any;
    daNumber: any;
    dsdsActionsSummary: any;
    displayValidationMessages: boolean = false;
    qualifiedindividual = 'Qualified Individual';
    ftdmfacilitator = 'FTDM Facilitator';
    ftdmorqisupervisor = 'FTDM/QI Supervisor';
    dateFormat = 'YYYY-MM-DD';
    disableEdit: boolean = false;
    alertChildErrMsg = 'The selected worker is already having another active child assignment in the case. Please end date the child assignment for the worker or select another worker to proceed further.';
    alertAdminErrMsg = 'The selected worker is already having another active admin assignment in the case. Please end date the admin assignment for the worker or select another worker to proceed further.';
    action = 'Add';
    existingenddate= null;
    existingassignment = null;
    existingfamilyassignment = '#existing-family-assignment-popup';
    iscaseexpunged: any = 0;


        private fb: FormBuilder;
        private _commonService: CommonHttpService;
        private _commonDropDownService: CommonDropdownsService;
        public _authService: AuthService;
        private route: ActivatedRoute;
        private _alertService: AlertService;
        private _dataStoreService: DataStoreService;
        private storage: SessionStorageService;
        private localstore: LocalStorageService;

        constructor(private injector : Injector, private cwAssignmentResolverService: CWAssignmentResolverService) {
                    this.fb = this.injector.get<FormBuilder>(FormBuilder);
                    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
                    this._commonDropDownService=this.injector.get<CommonDropdownsService>(CommonDropdownsService);
                    this._authService = this.injector.get<AuthService>(AuthService);
                    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
                    this._alertService = this.injector.get<AlertService>(AlertService);
                    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
                    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
                    this.localstore = this.injector.get<LocalStorageService>(LocalStorageService);

                        // this.route.data.subscribe((data: any) => {
                        //     if (data && data.hasOwnProperty('result')) {
                        //         this._authService.setAuthDetail('assignment', data.result);
                        //     }
                        // });
                        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }

    ngOnInit() {
        this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.cwAssignmentResolverService.getAssignment().subscribe({
            next: (data: any) => {
                this._authService.setAuthDetail('assignment', data);
            }
        })
        this.moduleview = this._authService.isModuleAccessable('assignment', 'assignment');
        this.isEditDisabled = this._authService.isDisabled('assignment','assignment.cwassignments.edit');
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        if(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR) || this._authService.selectedRoleIs(AppConstants.ROLES.CJAMS_SSA_FTDM_QI_SUPERVISOR)){
        this.isSupervisor = true;}
        this.isAddEnabled = this._authService.isEnabled('assignment','assignment.cwassignments.add');
        this.userInfo = this._authService.getCurrentUser();
        this.setReadOnlyFlag();
        this.currentDate = moment().format();
        this.user = this.localstore.getObj('userProfile');
        this.isServiceCase = this.storage.getItem('ISSERVICECASE');
        const caseType = this.storage.getItem(CASE_STORE_CONSTANTS.CASE_TYPE);
        this.isAdoptionCase = caseType === CASE_TYPE_CONSTANTS.ADOPTION;
        this.setServiceCaseid();
        this.setEventCode();
        this.caseTransfer = this.fb.group({
            selectDeptGroup: [''],
            toteamid: [''],
            appeventcode: [this.eventcode],
            servicecaseid: [this.serviceCaseId ? this.serviceCaseId : this.id],
            assigneduser: ['', Validators.required],
            responsibilitytypekey: [null, Validators.required],
            startdate: [{ value: moment().format() }],
            enddate: [''],
            caseassignmentid: [null],
            remarks: [''],
            child: ['']
        });
        this.getAssignmentsList();
        this.getPersonsList();
        this.getCountyList();
        this.caseTransfer.get('selectDeptGroup')?.valueChanges.subscribe((_res: any) => this.getteamlist());
        const da_status = this.storage.getItem('da_status');
        if (da_status) {
            if (da_status === 'Closed' || da_status === 'Completed') {
                this.isClosed = true;
            } else {
                this.isClosed = false;
            }
        }

        if (!(this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) && (this.isSupervisor || this.isAddEnabled) && !this.isClosed) {
            this.isAddVisible = true;
        } else {
            this.isAddVisible = false;
        }
        if (!this.isReadonly) {
        this._authService.readonlyPage('read_only_access', 'case-assignment-add',
            [this.caseTransfer]);
        }
        this.getActionSummary();
    }
    setReadOnlyFlag() {
        const activeModuleRole = this.storage.getItem('activeModuleRole');
        if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL') {
            this.isReadonly = false;
        } else if (activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
            this.isReadonly = true;
        } else {
            this.isReadonly = this._authService.readonlyButton('read_only_access', 'readonly-assignment');
        }
    }
    
    setServiceCaseid(){
        this.serviceCaseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    }
    setEventCode(){
        if (this.isServiceCase) {
            this.eventcode = 'SRVC';
        } else if (this.isAdoptionCase) {
            this.eventcode = 'ADPC';
        } else {
            this.eventcode = 'INVT';
        }
    }
    private getActionSummary() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this._commonService
          .getById(this.daNumber + `?isExpungementSuperUser=${isExpungementSuperUser}&iscaseexpunged=${this.iscaseexpunged}`, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl)
          .subscribe((response: any) => {
            this.dsdsActionsSummary = response[0];
          });
      }
    getAssignmentsList() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this.assignmentsList$ = this._commonService.getArrayList(
            {
                where: { servicecaseid: this.serviceCaseId ? this.serviceCaseId : this.id, isExpungementSuperUser, iscaseexpunged: this.iscaseexpunged },
                method: 'get'
            },
            'Caseassignments/getworkload?filter'
        );
        this.assignmentsList$.subscribe((data: any) => {
            if (data) {
                this.assignmentListData = data;
            }
        });
    }

    getCountyList() {
        const caseWorker = this._authService.getCurrentUser();
        let currentUserCountyid = caseWorker.user.userprofile.teammemberassignment.teammember.team.countyid;
        this._commonService.getArrayList({
            where: {},
            order: 'countyname',
            nolimit: true,
            method: 'get'
        }, 'admin/county?filter').subscribe((item: any) => {
            this.departmentList = item.filter((x: any) => x.countyid != currentUserCountyid);

        });
    }

    getPersonsList() {
        this.childList$ = this._commonService.getPagedArrayList(
            {
                page: 1,
                limit: 20,
                method: 'get',
                where: { 'caseid': this.id }
            }, 'Caseassignments/getresponsibilitychild?filter').pipe(map((item: any) => {
                return item;
            }));
    }
    toggleTable(id: any) {
        $('#' + id).collapse('toggle');
    }

    getteamlist() {
        const obj: any = {
            activeflag: 1
        }
        if (this.caseTransfer.get('selectDeptGroup')?.value === 'department') {
            obj['teamtypekey'] = 'LDSS';
        } else {
            obj['teamtypekey'] = this.userInfo.role.teamtypekey;
        }
        this._commonService.getPagedArrayList(new PaginationRequest({
            where: obj,
            method: 'get',
            nolimit: true
        }), 'manage/team/getteamlist?filter').subscribe((result: any) => {
            this.teamList = result;
            const activeteam = result.find((v: { isdefault: number; }) => v.isdefault === 1);
            if (activeteam) {
                if (this.caseTransfer.get('toteamid')?.value == '' || this.caseTransfer.get('selectDeptGroup')?.value === 'workers') {
                    this.caseTransfer.get('toteamid')?.patchValue(activeteam.teamid);
                    this.getteamusers(activeteam.teamid);
                }
            }
            if (this.caseTransfer.get('selectDeptGroup')?.value === 'workers' && activeteam) {
                this.caseTransfer.get('toteamid')?.disable();
            } else {
                this.caseTransfer.get('toteamid')?.enable();
            }
        });
    }
    contactDetails(item: any) {
        if (item['fromworkerdetails'] && item['fromworkerdetails'].length) {
            this.fromWorkerDetails = item['fromworkerdetails'][0];
        }
        if (item['toworkerdetails'] && item['toworkerdetails'].length) {
            this.toWorkerDetails = Object.assign({
                responsibilitytypekey: item.responsibilitytypekey
            }, item['toworkerdetails'][0]);
        }
    }
    close() {
        this.caseTransfer.controls['child'].reset();
        this.disableEdit = false;
    }

    getteamusers(data: any, modalid?: any, assignment?: any) {
        const obj = {
            teamid: '',
            filtertypekey: ''
        };
        obj.teamid = data === '' ? null : data;
        const toteamid = this.caseTransfer?.get('toteamid')?.value;
        const isExist = this.teamList?.filter((item:any)=>(item?.teamid === toteamid));
        let selectKey;
        if (isExist && isExist?.length != 0) {
            selectKey = isExist[0]?.name
        }
        obj.filtertypekey = this.getFilterType(obj, selectKey);
        this._commonService.getPagedArrayList(new PaginationRequest({
            where: obj,
            method: 'get',
            nolimit: true
        }), 'manage/team/getteamusers?filter').subscribe((result: any) => {
            this.checkteamUsers(obj,result);
            this.validateFacilitateUser(this.caseTransfer.get('assigneduser')?.value);
            $(modalid).modal('show');
          	this.caseTransfer.get('assigneduser')?.enable();
            if (assignment) {
                const user = result?.find((item: { userid: any; }) => item?.userid === assignment?.assigneduser);
                if(user?.userrole === this.ftdmfacilitator) {
                    this.caseTransfer.get('responsibilitytypekey')?.enable();
                }
            }
        });
    }
    getFilterType(obj: any,selectKey: any){
        let filtertypekey = obj.filtertypekey;
        if (this.caseTransfer.get('selectDeptGroup')?.value === 'workers') {
            filtertypekey = 'worker';
        } else if (this.caseTransfer.get('selectDeptGroup')?.value === 'unit') {
            if(selectKey===this.qualifiedindividual || selectKey===this.ftdmfacilitator || selectKey===this.ftdmorqisupervisor){
                filtertypekey = 'ftdm';
            }else{
            filtertypekey = 'unit';}
        } else if (this.caseTransfer.get('selectDeptGroup')?.value === 'department') {
            filtertypekey = 'ldss';
        }

        return filtertypekey;
    }
    checkteamUsers(obj: any,result: any){
        if(obj.filtertypekey === 'worker') {
            this.workerCaseWorkerList = result;
        } else if(obj.filtertypekey === 'unit'){
            this.unitCaseWorkerList = (this.isServiceCase) ? result : result.filter((item: { userrole: string; }) => item.userrole !== this.qualifiedindividual && item.userrole !== this.ftdmfacilitator);
        } else if(obj.filtertypekey === 'ldss'){
            this.ldssCaseWorkerList = result;
        } else if(obj.filtertypekey === 'ftdm'){
            this.unitCaseWorkerList = result;
        }
    }
    openadd(id: any) {
        this.disableEdit = false;
        this.caseTransfer.get('assigneduser')?.clearValidators();
        this.caseTransfer.get('assigneduser')?.updateValueAndValidity();
        this.caseTransfer.get('responsibilitytypekey')?.clearValidators();
        this.caseTransfer.get('responsibilitytypekey')?.updateValueAndValidity();
        const obj = {
            assigneduser: '',
            responsibilitytypekey: '',
            startdate: moment().format(),
            enddate: '',
            remarks: '',
            selectDeptGroup: 'workers',
            caseassignmentid: null,
        };
        this.iscurrentcaseended = false;
        this.action = 'Add';
        this.caseTransfer.patchValue(obj);
        this.caseTransfer.get('responsibilitytypekey')?.enable();
        $(id).modal('show');
    }
    editcase(data: any, id: any) {
        this.iscurrentcaseended = (data.enddate) ? true : false;
        if (this.isSupervisor) {
            this.disableEdit = true;
            this.action = 'Update';
            this.existingenddate = data.enddate;
            this.existingassignment = data.responsibilitytypekey;
            this.editCaseInfo(data, id);
        } else {
            this._alertService.error('Unauthorized.');
        }
    }
    editCaseInfo(data: any, id: any){
        if (data.responsibilitytypekey === null || data.responsibilitytypekey === '' || data.responsibilitytypekey === undefined) {
            this.caseTransfer.get('responsibilitytypekey')?.enable();
        } else {
            this.caseTransfer.get('responsibilitytypekey')?.disable();
        }

        let selectDeptGroup;
        if (data.assignmenttype === 'T') {
            selectDeptGroup = 'department';
        } else if (data.assignmenttype === 'W') {
            selectDeptGroup = 'workers';
        } else if (data.assignmenttype === 'U') {
            selectDeptGroup = 'unit';
        }

        const obj = {
            servicecaseid: this.serviceCaseId,
            assigneduser: data.toworkeridno,
            responsibilitytypekey: data.responsibilitytypekey,
            startdate: data.startdate,
            enddate: data.enddate,
            caseassignmentid: data.caseassignmentid,
            remarks: data.remarks,
            selectDeptGroup: selectDeptGroup,
            toteamid: data.toteamid
        };

        this.caseTransfer.patchValue(obj);
        if (data.childinfo) {
            const childInfo = data.childinfo.map((item: { intakeservicerequestactorid: any; }) => {
                return item.intakeservicerequestactorid;
            });
            this.caseTransfer.controls['child'].patchValue(childInfo);
        }
        if (obj.toteamid) {
            setTimeout(() => {
                this.getteamusers(obj.toteamid, id, obj);
            }, 500);
        } else {
            $(id).modal('show');
        }
    }

    getDates(sd: any, ed: any) {
        const dates: any[] = [];
        if(sd && ed) {
            let loop = new Date(sd);
            while(loop <= new Date(ed)){
                if(!dates.includes(loop)) {
                    dates.push(loop);
                }
                loop = new Date(loop.setDate(loop.getDate() + 1));
            }
        }
        if(dates.length>0) {
            return dates.map(i => {
                return moment(i).format(this.dateFormat);
            });
        }
        return dates;
    }

    getSortedDates(fam: any) {
        const dates: any[] = [];
        if(fam?.length > 0) {
            fam?.forEach((e: any) => {
                dates.push({id: e?.caseassignmentid, sd: moment(e?.startdate).format(this.dateFormat), ed: moment(e?.enddate).format(this.dateFormat)});
            });
            if(dates.length > 0) {
                return this.datesSort(dates).sort((a: any, b: any): any => {
                    if(b.ed && a.ed) {
                        return new Date(b.ed).getTime() - new Date(a.ed).getTime();
                    }
                });
            }
        }
        return dates;
    }

    private datesSort(dates : any[]) {
       return  dates.sort((a, b) => {
            return new Date(b.sd).getTime() - new Date(a.sd).getTime();
        })
    }

    existingfamilyassignmentpopupsubmit() {
        const val = this.caseTransfer.value;
        try {
            if(!val?.startdate) {
                return this._alertService.error('Please enter start date');
            }
            const ssd = moment(val?.startdate).format(this.dateFormat);
            const sed = (val?.enddate) ? moment(val?.enddate).format(this.dateFormat) : null;
            const vid = val?.caseassignmentid;
            let { access, fad } = this.handleFamListFn(vid);
            if(!access && fad?.length > 0) {
                access = this.returnAccessDataFn(access, ssd, fad, sed);
            }
            if(!access) {
                return this._alertService.error('Family assignment dates overlap!');
            }
        } catch(err) {
        }
        this.handleCaseTransfersubmitCondFn('#cw-assignment-popup', val);
        $(this.existingfamilyassignment).modal('hide');

    }

    caseTransfersubmit(val: any, id: any) {
        this.caseTransfer.get('assigneduser')?.setValidators([Validators.required]);
        this.caseTransfer.get('assigneduser')?.updateValueAndValidity();
        this.caseTransfer.get('responsibilitytypekey')?.setValidators([Validators.required]);
        this.caseTransfer.get('responsibilitytypekey')?.updateValueAndValidity();
        if (this.caseTransfer && this.caseTransfer.invalid) {
            this.displayValidationMessages =true;
            this.caseTransfer.markAllAsTouched();
            return;
        }
        if(this.checkAssignedUserFn()) {
            return this._alertService.error('Please select a social worker');
        }

        const fam = this.returnFamFn();
        const notfam = this.returnIfNotFamilyFn();
        const isEditedRecord = this.isEditedRecordFlag(val);
        if (fam.length === 0 && notfam) {
            return this._alertService.error('No worker of any type (Child, Admin) can be assigned to a case until a family worker has been assigned');
        }

        if (notfam) {
            this.handleCaseTransfersubmitCondFn(id, val);
            return;
        }

        if (fam.length > 0 && id && !isEditedRecord) {
            $(this.existingfamilyassignment).modal('show');
            return;
        }

        try {
            if(!val?.startdate) {
                return this._alertService.error('Please enter start date');
            }
            const ssd = moment(val?.startdate).format(this.dateFormat);
            const sed = (val?.enddate) ? moment(val?.enddate).format(this.dateFormat) : null;
            const vid = val?.caseassignmentid;
            let { access, fad } = this.handleFamListFn(vid);
            if(!access && fad?.length > 0) {
                access = this.returnAccessDataFn(access, ssd, fad, sed);
            }
            if(!access) {
                return this._alertService.error('Family assignment dates overlap!');
            }
        } catch(err) {
        }
        this.handleCaseTransfersubmitCondFn(id, val);


    }
    private returnFamFn() {
        return this.assignmentListData.filter((item: { responsibilitytypekey: any; enddate: null; }) => String(item.responsibilitytypekey).toLowerCase() == 'family' && item.enddate == null);
    }

    // Assosiated with caseTransfersubmit method
    private returnIfNotFamilyFn() {
        return (this.assignmentListData && this.caseTransfer.getRawValue().responsibilitytypekey.toLowerCase() !== 'family');
    }
    // Assosiated with caseTransfersubmit method
    private handleCaseTransfersubmitCondFn(id: any, val: any) {
        this.caseTransfer.get('toteamid')?.enable();
        this.caseTransfer.get('responsibilitytypekey')?.enable();

        $(id).modal('hide');
        this.checkChildDataInCaseTransfersubmitFn();

        const data = this.getcaseTransferInfo(val);
        this.reassignCase(data);
    }

    // Assosiated with caseTransfersubmit method
    private checkAssignedUserFn() {
        return (this.caseTransfer.get('selectDeptGroup')?.value === 'workers' && (this.caseTransfer.get('assigneduser')?.value === null || this.caseTransfer.get('assigneduser')?.value === ''));
    }

    // Assosiated with caseTransfersubmit method
    private handleFamListFn(vid: any) {
        let access = false;
        let fad = [];
        const famList = this?.assignmentListData?.filter((i: { responsibilitytypekey: any; }) => String(i?.responsibilitytypekey).toLowerCase() == 'family');
        if (famList?.length > 0) {
            if (vid) {
                fad = this.getSortedDates(famList?.filter((i: { caseassignmentid: any; }) => i?.caseassignmentid !== vid));
                if (fad?.length === 0) {
                    access = true;
                }
            } else {
                fad = this.getSortedDates(famList);
            }
        } else {
            access = true;
        }
        return { access, fad };
    }
    // Assosiated with caseTransfersubmit method
    private returnAccessDataFn(access: boolean, ssd: string, fad: any[], sed: any) {
        if (!access && ssd >= (fad[0]?.ed && fad[0]?.ed != 'Invalid date' ? fad[0]?.ed :fad[0]?.sd)) {
            access = true;
        }
        if (!access && ssd >= fad[0]?.ed) {
            access = true;
        }
        if (!access && fad[fad?.length - 1]?.sd >= sed) {
            access = true;
        }
        if (!access) {
            const sedays = this.getDates(ssd, sed);
            access = this.handleFadLoopFn(fad, sedays, access);
        }
        return access;
    }
    // Assosiated with caseTransfersubmit method
    private handleFadLoopFn(fad: any[], sedays: any[], access: boolean) {
        let access1 = access;
        for (let i = 0; i < fad?.length; i++) {
            const sldays = this.getDates(((fad[i + 1]?.sd) ? moment(fad[i + 1]?.ed).format(this.dateFormat) : null), ((fad[i]?.sd) ? moment(fad[i]?.sd).format(this.dateFormat) : null));
            if (sldays.length > 0 && sedays.length > 0) {
                let count = 0;
                sedays?.forEach(e => {
                    if (sldays.includes(e)) {
                        count++;
                    }
                });
                if (sedays.length === count) {
                    access1 = true;
                }
            }
        }
        return access1;
    }

    // Assosiated with caseTransfersubmit method
    private checkChildDataInCaseTransfersubmitFn() {
        if (this.caseTransfer.value.child && this.caseTransfer.value.child.length) {
            this.caseTransfer.value.child = this.caseTransfer.value.child.map((item: any) => {
                return {
                    intakeservicerequestactorid: item
                };
            });
        }
    }

    isEditedRecordFlag(val: any) {
        const fam = this.assignmentListData.filter((item: { responsibilitytypekey: any; enddate: null; }) => String(item.responsibilitytypekey).toLowerCase() == 'family' && item.enddate == null);
        let isEditedRecord = false;
        if (val.caseassignmentid && fam.length > 0 && fam[0].caseassignmentid) {
            isEditedRecord = val.caseassignmentid === fam[0].caseassignmentid ? true : this.checkenddate(val);
        }
        return isEditedRecord;
    }

    checkenddate(val: any){
        return val.enddate ? true : false
    }

    getcaseTransferInfo(_val: any) {
        const data = { ...this.caseTransfer.value };
        if (data.selectDeptGroup === 'department') {
            data.assignmenttype = 'T';
        } else if (data.selectDeptGroup === 'workers') {
            data.assignmenttype = 'W';
        } else if (data.selectDeptGroup === 'unit') {
            data.assignmenttype = 'U';
        }
        delete data.selectDeptGroup;
        if (this.caseTransfer.get('selectDeptGroup')?.value === 'department') {
            data.isanotherunit = 1;
        } else {
            data.isanotherunit = null;
        }
        data.enddate = (data?.enddate) ? moment(data.enddate).format('YYYY-MM-DD HH:mm:ss') : '';
        data.startdate = (data?.startdate) ? moment(data.startdate).format('YYYY-MM-DD HH:mm:ss') : '';
        return data;
    }

    reassignCase(data: any){
        this._commonService.create(data, CaseWorkerUrlConfig.EndPoint.DSDSAction.Assignment.Reassigncase).subscribe((res: any) => {
            this.isFamilyAssignmentActive = false;
            if (res && res.length && res[0].statuscode === 200) {
                this._alertService.success(res[0].status_description);
                this._dataStoreService.setData('DSDS_ACTION_UPDATE', true);
                this.caseTransfer.controls['child'].reset();
            } else if(res && res.length && res[0].statuscode === 2001){
                this.caseTransfer.controls['child'].reset();
                this._alertService.error(res[0].status_description);
            } else if(res && res.length && res[0].statuscode === 2002) {
                this.caseTransfer.controls['child'].reset();
                if(this.caseTransfer.getRawValue().responsibilitytypekey.toLowerCase() === 'child') {
                    this._alertService.error(this.alertChildErrMsg);
                } else if(this.caseTransfer.getRawValue().responsibilitytypekey.toLowerCase() === 'administrative') {
                    this._alertService.error(this.alertAdminErrMsg);
                }

            } else {
                this.caseTransfer.controls['child'].reset();
                this._alertService.error('Service Case Assignment Error');
            }
            this.getAssignmentsList();
        });
    }

    validateFacilitateUser(modal: any) {
        if (this.unitCaseWorkerList) {
            const userInfo = this.unitCaseWorkerList.find((item: { userid: any; }) => item.userid === modal);
            if (this.isServiceCase && userInfo && (userInfo.teamname == this.qualifiedindividual || (userInfo.teamname == this.ftdmfacilitator) || userInfo.teamname == this.ftdmorqisupervisor) )
             {
                this.caseTransfer.patchValue({
                    responsibilitytypekey: 'administrative'
                });
                this.caseTransfer.controls.responsibilitytypekey.disable();
            } else {
                this.caseTransfer.controls.responsibilitytypekey.enable();
            }
        }else if(this.workerCaseWorkerList){
            const userInfo = this.workerCaseWorkerList.find((item: { userid: any; }) => item.userid === modal);
            if (this.isServiceCase && userInfo && (userInfo.teamname === this.qualifiedindividual || userInfo.teamname === this.ftdmfacilitator || userInfo.teamname === this.ftdmorqisupervisor)) {
                this.caseTransfer.patchValue({
                    responsibilitytypekey: 'administrative'
                });
                this.caseTransfer.controls.responsibilitytypekey.disable();
            } else {
                this.caseTransfer.controls.responsibilitytypekey.enable();
            }
        }
    }

    onChangeResponsibility(value: any){
        if(value != 'child'){
            this.caseTransfer.controls['child'].reset();
            this.caseTransfer.controls['child'].setErrors(null);
        }
        if(value == 'family' && this.action == 'Add'){
            this.caseTransfer.controls['enddate'].reset();
            this.caseTransfer.controls['enddate'].setErrors(null);
        }
        if(value == 'family' && this.action == 'Update'){
            if(this.existingassignment != 'family') {
                this.caseTransfer.controls['enddate'].reset();
                this.caseTransfer.controls['enddate'].setErrors(null);
            } else {
                this.caseTransfer.get('enddate')?.patchValue(this.existingenddate);
            }
        }
        this.caseTransfer.updateValueAndValidity();
    }

    formatPhoneNumber(phoneNumber: string) {
        return this._commonDropDownService.formatPhoneNumber(phoneNumber);
      }

    getErrorsMessage(ControlName: any, displayName: any){
        if(this.caseTransfer.controls[ControlName].status =='INVALID' ){
            return 'Please enter valid ' + displayName
        }
    }
}
