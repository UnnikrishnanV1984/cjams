import { Component, OnInit, Injector } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { AlertService, AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { AppConfig } from '../../../../../app.config';
import { DSDSActionSummary } from '../../../_entities/caseworker.data.model';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { PaginationInfo } from '../../../../../@core/entities/common.entities';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AppConstants } from '../../../../../@core/common/constants';
import { TransferHistoryApprovedService } from '../../../../../shared/services/transfer-history-approved.service';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';

@Component({
    selector: 'visitation-log',
    templateUrl: './visitation-log.component.html',
    styleUrls: ['./visitation-log.component.scss'],
    standalone: false
})
export class VisitationLogComponent implements OnInit {

    visitationLogForm!: FormGroup;
    baseUrl: string;
    dsdsActionsSummary = new DSDSActionSummary();
    caseId!: string;
    visitationlogs: any[] = [];
    personList: any[] = [];
    deleteVisitationLogId!: string;
    collateralPersons: any[] = [];
    paginationInfo: PaginationInfo = new PaginationInfo();
    totalRecords: any;
    isReadonly = true;
    disabledTillSaved:boolean = false;
    selectPersonNameList: string[] = [];
    selectClientNameList: string = '';
    selectParticipantNameList: string[] = [];
    pageNumber!: number;
    visitationstatus = [
        { ref_key: '2862', value_text: 'Cancelled' },
        { ref_key: '2863', value_text: 'Child Refused' },
        { ref_key: '2864', value_text: 'Completed' },
        { ref_key: '2865', value_text: 'No-show' }
    ];
    userRole: any;
    intakeNumber: any;
    checkmandatory: boolean = false;
    displayValidationMessages: boolean = false;

    private _formBuilder: FormBuilder;
    private _commonHttpService: CommonHttpService;
    private _alertService: AlertService;
    public _authService: AuthService;
    private _dataStoreService: DataStoreService;
    private storage: SessionStorageService;
    private _session: SessionStorageService;
    private readonly _transferHistoryApprovedService: TransferHistoryApprovedService;

    constructor(private injector: Injector){
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this._session = this.injector.get<SessionStorageService>(SessionStorageService);
        this._transferHistoryApprovedService = this.injector.get<TransferHistoryApprovedService>(TransferHistoryApprovedService);
        
        this.baseUrl = AppConfig.baseUrl;
    }

    ngOnInit() {
        this.initializeVisitationForm();
        this.dsdsActionsSummary = this._dataStoreService.getData('dsdsActionsSummary');
        this.userRole = this._authService.getCurrentUser();
        if (this.userRole && this.userRole.role && this.userRole.role.name !== AppConstants.ROLES.SUPERVISOR) {
            const activeModuleRole = this.storage.getItem('activeModuleRole');
     
                if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
                    this.isReadonly = this.compareWithResponsibleworkers(this.userRole.user.email);
                } else {
                    this.isReadonly = this._authService.readonlyButton('read_only_access', 'caseworker-contacts-notes-add-new');
                }
        }
        this.caseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.getPersons();
        this.getVisitationLogs(1);
        this.getcollateral();
        if(this.isIntakeMode() && this._transferHistoryApprovedService.getTrasferHistory()) {
            this.visitationLogForm.disable();
            this.isReadonly = false
        }
    }

    compareWithResponsibleworkers(userDetail: any){
        let activeMod = "";
        if (this._session.getItem('activeModuleRole') == 'CJAMS_SSA_FTDM_FACILITATOR') { activeMod = "FTDM Facilitator"; }
        else if (this._session.getItem('activeModuleRole') == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL') { activeMod = "Qualified Individual"; }
        else if (this._session.getItem('activeModuleRole') == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') { activeMod = "FTDM/QI Supervisor"; }

        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        const tempArray: any[] = [];
        let isReadonly = false;
        if(caseInfo && caseInfo.responsibleworkers){
            for (let i = 0; i < caseInfo.responsibleworkers.length; i++) {
                if(caseInfo.responsibleworkers[i].enddate == null && caseInfo.responsibleworkers[i].email == userDetail 
                    && caseInfo?.responsibleworkers[i]?.teamname == activeMod){
                    tempArray.push(caseInfo.responsibleworkers[i]);
                }
            }
            if(tempArray.length!=0){isReadonly=true;}
        }
        return isReadonly;
    }

    private initializeVisitationForm() {
        this.visitationLogForm = this._formBuilder.group({
            visitationlogid: [null],
            visitdate: [null, Validators.required],
            courtorderedflag: [null],
            visitstatustypekey: [null, Validators.required],
            otherparticipants: [''],
            supervisedflag: [null],
            supervisecomments: [''],
            visitlocation: [''],
            visitcomments: [''],
            caseid: [null],
            personid: [null, Validators.required],
            datavalidflag: [null],
            // activeflag: [null],
            visitationlogclient: [null],
            collaterallist: [null],
        });
    }

    resetVisitationLog() {
        ['personid', 'visitdate', 'visitstatustypekey'].forEach((item) => {
            this?.visitationLogForm?.get(item)?.clearValidators();
            this?.visitationLogForm?.get(item)?.updateValueAndValidity();
        });
        this.displayValidationMessages =false;
        this.visitationLogForm.reset();
        this.selectPersonNameList = [];
        this.selectClientNameList = '';
        this.selectParticipantNameList = [];
    }


    //Get all visitation logs
    getVisitationLogs(page: any) {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        let caseId;
        if (this._dataStoreService?.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE)) {
            caseId = this.caseId;
        } else if (this.isIntakeMode()) {
            caseId = this.getIntakeNumber();
        } else {
            caseId = this?.caseId;
        }

        const payload = {
            method: 'get',
            page: this.paginationInfo.pageNumber,
            limit: 10,
            where: {
                caseid: caseId,
                sortdirection:this.paginationInfo.sortBy,
                sortcolumn:this.paginationInfo.sortColumn,
                isExpungementSuperUser: isExpungementSuperUser,
                'iscaseexpunged': iscaseexpunged
            }
        };
        this._commonHttpService.getArrayList(payload, 'visitationlog/listallvisitationlogs?filter').subscribe((response: any) => {
                if (response && response['data'] && response['data'].length > 0) {
                    for (const record of response['data']) {
                        record.visitdate = record.visitdate ? new Date(record.visitdate) : null;
                    }
                }
                this.visitationlogs = response['data'];
                this.totalRecords = response['count'];
                this.pageNumber = page;
                if(this.disabledTillSaved)
                {
                    (<any>$('#addVisitationLog')).modal('hide');
                    this._alertService.success('Visitation log details saved successfully!');
                    this.disabledTillSaved = false;
                } 
            }
        );
    }

    onSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
        this.getVisitationLogs(1);
    }

    //Save vaistation log
    saveVisitationLog() {
        // Save the visitation log details
        ['personid', 'visitdate', 'visitstatustypekey'].forEach((item) => {
            this?.visitationLogForm?.get(item)?.setValidators([Validators.required]);
            this?.visitationLogForm?.get(item)?.updateValueAndValidity();
        });
        if (this.visitationLogForm && this.visitationLogForm.invalid) {
            this.visitationLogForm.markAllAsTouched();
            this.displayValidationMessages =true;
            return;
        }
            this.checkmandatory = true;
            if (!this.visitationLogForm.pristine || !this.visitationLogForm.invalid) {
            const visitationplan = this.visitationLogForm.getRawValue();
            let caseId;

            if (this?._dataStoreService?.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE)) {
                caseId = this?.caseId;
            } else if (this?.isIntakeMode()) {
                caseId = this?.getIntakeNumber();
            } else {
                caseId = this?.caseId;
            }

            visitationplan.caseid = caseId;
            this._commonHttpService.create(visitationplan, 'visitationlog/addupdate').subscribe(
                response => {
                    if (response.visitationlogid) {
                        this.getVisitationLogs(1);
                        // (<any>$('#visitation-plans')).modal('show');
                        // this.visitationPlanFormGroup.reset();
                        this.resetVisitationLog();
                        (<any>$('#addVisitationLog')).modal('hide');
                    }
                    else{
                        this._alertService.error('Error has occurred. Please try again or contact support.');}
                }
            );
        } else {
            this.disabledTillSaved = true;
        }
    }

    editVisitationLog(item: any) {
        const formdata = item;
        formdata.visitdate = new Date(formdata.visitdate);
        this.visitationLogForm.patchValue(formdata);
        this.visitationLogForm.enable();
        this.getClientNameList(formdata.personid,this.personList);
        this.getPersonNameList(this.visitationLogForm.getRawValue().visitationlogclient, this.personList);
    }

    deleteVisitationLog(item: { visitationlogid: string; }) {
        this.deleteVisitationLogId = item.visitationlogid;
    }

    confirmDelete() {
        const payload: any = {}
        payload['visitationlogid'] = this.deleteVisitationLogId;
        this._commonHttpService.create(payload, 'visitationlog/deletevisitationlog').subscribe(
            response => {
                this.getVisitationLogs(1);
                (<any>$('#deleteVisitationLog')).modal('hide');
                this._alertService.success('Visitation log deleted successfully!');
            }
        );
    }
 
    isIntakeMode() {
        return this.getIntakeNumber() ? true : false;
    }
    getIntakeNumber() {
        const intakeStore = this._dataStoreService.getObj('intake');
        if (intakeStore && intakeStore.number) {
            this.intakeNumber = intakeStore.number
            return intakeStore.number;
        } else {
            return null;
        }
    }
    getPersons() {
        let inputRequest = {};
        const isServiceCase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        if (isServiceCase) {
            inputRequest = {
                objectid: this.caseId,
                objecttypekey: 'servicecase'
            };
        } else if (this.isIntakeMode()) {
            inputRequest = {
                intakenumber: this.getIntakeNumber(),
                'isExpungementSuperUser': isExpungementSuperUser,
                'iscaseexpunged': iscaseexpunged
            };
        }
        else {
            inputRequest = {
                intakeserviceid: this.caseId,
                'isExpungementSuperUser': isExpungementSuperUser,
                'iscaseexpunged': iscaseexpunged
            };
        }

        
        let url = '';
        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        const payload = {
            method: 'get',
            count: -1,
            page: 1,
            limit: 50,
            nolimit: true,
            where: inputRequest
        };
        this._commonHttpService.getPagedArrayList(payload, url + '?filter').subscribe(
            response => {
                this.personList = response.data;
                
            });
    }

    getFullName(person: any) {
        const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
        let name = '';
        nameKeys.forEach(key => {
          if(person && person.hasOwnProperty(key)){
          if (person[key] != null && person[key] != 'null' && person[key] != '') {
            name = name + person[key] + ' ';
          }}
        });
        return name;
    }

    getVisitationStatus(key: string | null) {
        if (key != null) {
        return this.visitationstatus.find(x => x.ref_key === key)?.value_text;
    }
    }

    getcollateral() {
        if (this.collateralPersons && this.collateralPersons.length === 0) {
            const request = {
                objectid: this.caseId,
                objecttype: 'case'
              };
              this._commonHttpService.getArrayList(
                {
                  where: request,
                  method: 'get',
                  nolimit: true
                },
                'collateral/list?filter'
              ).subscribe(res => {
                if (res && res.length && res[0].getcollateraldetails && res[0].getcollateraldetails.length) {
                  this.collateralPersons = res[0].getcollateraldetails;
                }
              });
        }
      }
      pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.getVisitationLogs(pageInfo.page);
    }
getPersonNameList(id: string | any[], list: any[])  {
        if(id) {
          const selectPersonList = list.filter((f: any) => id?.includes(f.personid));
          this.selectPersonNameList = selectPersonList.map(item => item.fullname);
        }
    }

    getClientNameList(id: any, list: any[]) {
        const selectPersonList = list.find(f => f.personid === id);
        this.selectClientNameList = selectPersonList.fullname;
    }

    getParticipantNameList(id: string | any[], list: any[]) {
        const selectPersonList = list.filter(f => id.includes(f.collateralid));
        this.selectParticipantNameList = selectPersonList.map(item => item.fullname);
    }
/*
    getAssignmentsList() {
        this._commonHttpService.getArrayList(
          {
            where: { servicecaseid: this.caseId },
            method: 'get'
          },
          'Caseassignments/getworkload?filter'
        ).subscribe(data => {
          if (data) {
            const fam = data.filter(item => item.enddate == null);
            if(fam && fam.length>0){
                fam.map(element => {
                    if(this.userRole.role.description.toLocaleLowerCase() === "case management specialist,cw" || JSON.stringify(this.userRole.resources).includes('CJAMS_CW_CASE_MGMT_SPECIALIST')){
                        this.hasFamilyAccessToCase = true;
                    }
                    else{
                        if(!this.hasFamilyAccessToCase && element){
                            if(this.userRole.role.description.toLowerCase().includes('supervisor') && this._session.getItem('activeModuleNav') === 'Approve') {
                                if(element.countyid && element.countyid === this.userRole?.user?.userprofile?.teammemberassignment?.teammember?.team?.countyid){
                                    this.hasFamilyAccessToCase = true;
                                }
                            } else if(this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)){
                                let _key = element.responsibilitytypekey;
                                if(_key && (_key==='family' || _key==='child' || _key==='administrative')){
                                    if(element.toworkerdetails){
                                        let familyAssignmentWorker = element.toworkerdetails.filter(a => a.securityusersid === this._authService.getCurrentUser().user.securityusersid);
                                        if (familyAssignmentWorker.length > 0) {
                                        this.hasFamilyAccessToCase = true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                })
            }
          }
        });
      }
*/
      getFormMsg(ControlName: string | number, displayName: string){
        if(this.visitationLogForm.controls[ControlName].status =='INVALID' ){
            return 'Please enter valid ' + displayName
        }
      }

}