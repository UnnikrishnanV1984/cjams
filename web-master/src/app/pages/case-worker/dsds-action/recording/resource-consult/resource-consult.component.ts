import {of as observableOf, EMPTY,  Observable, Subject } from 'rxjs';
import {share, pluck, map} from 'rxjs/operators';
import { Component, OnInit, AfterViewInit, Injector, ViewChild } from '@angular/core';
import { AuthService, CommonHttpService, AlertService, GenericService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { ResourceConsult, ResourceList } from '../_entities/recording.data.model';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { ActivatedRoute } from '@angular/router';
import moment from 'moment';
import { AppConstants } from '../../../../../@core/common/constants';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { TransferHistoryApprovedService } from '../../../../../shared/services/transfer-history-approved.service';
import { MatDatepicker } from '@angular/material/datepicker';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'resource-consult',
    templateUrl: './resource-consult.component.html',
    styleUrls: ['./resource-consult.component.scss'],
    standalone: false
})
export class ResourceConsultComponent implements OnInit, AfterViewInit {
    @ViewChild ('picker') picker!:MatDatepicker<Date>;
    recsourceConsultForm!: FormGroup;
    id!: string;
    popUpText = 'Add';
    btnName = 'Add';
    intakeservicerequestconsultreviewid!: string | null;
    resourceID!: string | null;
    isView!: boolean;
    canDisplayPager$!: Observable<boolean>;
    totalRecords$!: Observable<number>;
    resourceCOnsult$!: Observable<ResourceConsult[]>;
    resourceCOnsult!: ResourceConsult;
    paginationInfo: PaginationInfo = new PaginationInfo();
    private pageStream$ = new Subject<number>();
    selectType$ = new Observable<DropdownModel[]>();
    resourceList$ = new Observable<ResourceList[]>();
    recsourceConsultUserForm!: FormGroup;
    recsourceConsultUser$ = new Observable<Array<any>>();
    recsourceConsultUser: any[] = [];
    isClosed = false;
    source!: string;
    caseNumber: any;
    caseType!: string;
    isReadonly= true;
    isEditDisabled = false;
    isDeleteDisabled = false;
    userRole: any;
    checkmandatory: boolean = false;
    checkmandatory_Form: boolean = false;
    deleteresourcepopupid = '#delete-resource-popup';
    private _formBuilder: FormBuilder;
    private _service: GenericService<ResourceConsult>;
    private _commonHttpService: CommonHttpService;
    private _alertService: AlertService;
    private route: ActivatedRoute;
    private _storeService: DataStoreService;
    private _authService: AuthService;
    private _dataStoreService: DataStoreService;
    private _session: SessionStorageService;
    private readonly _transferHistoryApprovedService: TransferHistoryApprovedService;

    constructor(private injector: Injector) {
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._service = this.injector.get<GenericService<ResourceConsult>>(GenericService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
	this._storeService = this.injector.get<DataStoreService>(DataStoreService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._session = this.injector.get<SessionStorageService>(SessionStorageService);
	this._transferHistoryApprovedService = injector.get<TransferHistoryApprovedService>(TransferHistoryApprovedService);    
}

    ngOnInit() {
        this.isEditDisabled = this._authService.isDisabled('contacts','contacts.consultreview.edit');
        this.isDeleteDisabled = this._authService.isDisabled('contacts','contacts.consultreview.delete');
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.userRole = this._authService.getCurrentUser();


            if(this.userRole.role.name === 'CJAMS_SSA_FTDM_FACILITATOR' ||this.userRole.role.name === 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' ||this.userRole.role.name === 'CJAMS_SSA_FTDM_QI_SUPERVISOR'){
                this.isReadonly = this.compareWithResponsibleworkers(this.userRole.user.email);
            } else {
            this.isReadonly = this._authService.readonlyButton('read_only_access','caseworker-contacts-notes-add-new');
        }
        
        this.loadForm();
        this.loadresourceConsultUserForm();
        this.listDropdown();
        this.pageStream$.subscribe((pageNumber) => {
            this.paginationInfo.pageNumber = pageNumber;
            this.getPage(this.paginationInfo.pageNumber);
        });
        this.getPage(1);
        const da_status = this._session.getItem('da_status');
        if (da_status) {
        if (da_status === 'Closed' || da_status === 'Completed') {
            this.isClosed = true;
        } else {
            this.isClosed = false;
        }
        }
        
        if(this.isIntakeMode() && this._transferHistoryApprovedService.getTrasferHistory()) {
            this.isClosed = true;
        }
    }

    compareWithResponsibleworkers(userDetail: any){
        let activeMod = "";
        if (this._session.getItem('activeModuleRole') == 'CJAMS_SSA_FTDM_FACILITATOR') { activeMod = "FTDM Facilitator"; }
        else if (this._session.getItem('activeModuleRole') == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL') { activeMod = "Qualified Individual"; }
        else if (this._session.getItem('activeModuleRole') == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') { activeMod = "FTDM/QI Supervisor"; }

        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        const tempArray = [];
        let isReadonly = false;
        if(caseInfo && caseInfo.responsibleworkers){
            for (let i = 0; i < caseInfo.responsibleworkers.length; i++) {
                if(caseInfo.responsibleworkers[i].enddate == null && caseInfo.responsibleworkers[i].email == userDetail 
                    && caseInfo?.responsibleworkers[i]?.teamname == activeMod){
                    tempArray.push(caseInfo.responsibleworkers[i]);
                }
            }
            if(tempArray.length!=0){isReadonly=true;}
            else{isReadonly=false;}
        }
        return isReadonly;
    }

    ngAfterViewInit() {
      const intakeCaseStore = this._storeService.getData('IntakeCaseStore');
      if (this._authService.isDJS() && intakeCaseStore && intakeCaseStore.action === 'view') {
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

    loadForm() {
        this.recsourceConsultForm = this._formBuilder.group({
            resourceconsultuser: [''],
            notes: ['', Validators.required],
            date: ['', Validators.required],
            time: ['', Validators.required]
        });
    }

    loadresourceConsultUserForm() {
        this.recsourceConsultUser$ = EMPTY;
        this.recsourceConsultUser = [];
        this.recsourceConsultUserForm = this._formBuilder.group({
            name: ['', Validators.required],
            consultreviewusertype: [''],
        });
    }

    addrecsourceConsultUser() {
        if(!this.recsourceConsultUserForm.pristine || !this.recsourceConsultUserForm.invalid){
        const nameModel = this.recsourceConsultUserForm.get('name')?.value;
        const consultreviewusertypeModel = this.recsourceConsultUserForm.get('consultreviewusertype')?.value;
        if (nameModel && consultreviewusertypeModel) {
            this.recsourceConsultUser.push({
                name: nameModel,
                consultreviewusertypekey: consultreviewusertypeModel.value,
                consultreviewusertype: consultreviewusertypeModel.text,
                onDelete: false,
                intakeservicerequestconsultreviewconfigid: null
            });
            this.recsourceConsultUser$ = observableOf(this.recsourceConsultUser);
            this.recsourceConsultUserForm.reset();
            }
            this.checkmandatory_Form = false;
        }
        else{
            this.checkmandatory_Form = true;
        }
    }

    deleteUser(configid: any, i: number) {
        if (this.recsourceConsultUser.length <= 1 && configid) {
            this._alertService.error('Minimum one user required!');
        } else {
            if (configid) {
                this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.DeleteResourceUserURL;
                this._service.remove(configid).subscribe(
                    (response: any) => {
                        this.recsourceConsultUser.splice(i, 1);
                        this.recsourceConsultUser$ = observableOf(this.recsourceConsultUser);
                        this._alertService.success('Resource consult review user deleted successfully');
                    },
                    (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                this.recsourceConsultUser.splice(i, 1);
                this.recsourceConsultUser$ = observableOf(this.recsourceConsultUser);
                this._alertService.success('Resource consult review user deleted successfully');
            }
        }
    }

    deleteUsercheck(i: number) {
        this.recsourceConsultUser[i].onDelete = true;
    }

    cancelDelete(i: number) {
        this.recsourceConsultUser[i].onDelete = false;
    }

    saveResourceConsult(resourceCOnsult: any) {
        if ((!this.recsourceConsultForm.pristine || !this.recsourceConsultForm.invalid) && this.recsourceConsultForm.controls?.notes?.value && 
        (this.recsourceConsultForm.get('time')?.value && this.recsourceConsultForm.get('date')?.value)) {
            if (this.recsourceConsultUser.length < 1) {
                this._alertService.error('Minimum one user required!');
                return;
            } 
            // else {
            this.handleRecsourceConsultUserFn(resourceCOnsult);
            const requestParam = this.getRequestParam();
            resourceCOnsult.objectid = requestParam.objectid;
            resourceCOnsult.objecttypekey = requestParam.objecttypekey;
            resourceCOnsult.intakeservicerequestconsultreviewid = this.intakeservicerequestconsultreviewid;
            resourceCOnsult.date = moment(resourceCOnsult.date).format('MM/DD/YYYY HH:mm')
            this._commonHttpService.create(resourceCOnsult, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.AddResourceConsultURL).subscribe(
                _result => {
                    this._alertService.success('Resource consult details saved successfully!');
                    this.getPage(1);
                    ($('#cls-add-resource')).click();
                    this.clearItem();
                },
                _error => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
            this.checkmandatory = false;
        } else {
            this.checkmandatory = true;
        }
    // }else{
    //     this.checkmandatory = true;
    // }
    }
    // Assosiated with saveResourceConsult function
    private handleRecsourceConsultUserFn(resourceCOnsult: any) {
        if (this.recsourceConsultUser) {
            this.recsourceConsultUser.forEach(element => {
                delete element.consultreviewusertype;
                delete element.onDelete;
            });
            resourceCOnsult.resourceConsultUser = Object.assign(this.recsourceConsultUser);
        }
        if (resourceCOnsult.date) {
            const timeSplit = resourceCOnsult.time.split(':');
            if (!(resourceCOnsult.date instanceof Date)) {
                resourceCOnsult.date = new Date(resourceCOnsult.date);
            }
            resourceCOnsult.date.setHours(timeSplit[0]);
            resourceCOnsult.date.setMinutes(timeSplit[1]);
        }
    }

    clearItem() {
        this.recsourceConsultForm.reset();
        this.recsourceConsultForm.enable();
        this.recsourceConsultUserForm.reset();
        this.recsourceConsultUserForm.enable();
        this.recsourceConsultUser = [];
        this.recsourceConsultUser$ = EMPTY;
        this.popUpText = 'Add';
        this.btnName = 'Add';
        this.resourceID = null;
        this.intakeservicerequestconsultreviewid = null;
        this.isView = false;
    }
    showDeletePop(resourceid: { intakeservicerequestconsultreviewid: string | null; }) {
        this.resourceID = resourceid.intakeservicerequestconsultreviewid;
        $(this.deleteresourcepopupid).modal('show');
    }

    showEditPopup(resource: any) {
        this.resourceID = resource.objectid;
        if (this.resourceID) {
            this.popUpText = 'Edit';
            this.btnName = 'Update';
            this.intakeservicerequestconsultreviewid = resource.intakeservicerequestconsultreviewid;
        } else {
            this.intakeservicerequestconsultreviewid = null;
        }

        resource.time = moment(resource.reviewdate).format('HH:mm');
        resource.date = resource.reviewdate;
        this.recsourceConsultUser = [...resource.resourceconsultuser];
        this.recsourceConsultUser.forEach(data => {
            data.onDelete = false;
        });
        this.recsourceConsultUser$ = observableOf(this.recsourceConsultUser);
        this.recsourceConsultForm.patchValue(resource);
        this.recsourceConsultForm.enable();
        this.isView = false;
        $('#add').modal('show');
    }

    showViewPopup(resource: any) {
        this.popUpText = 'View';
        resource.time = moment(resource.reviewdate).format('HH:mm');
        resource.date = resource.reviewdate;
        this.recsourceConsultUser = resource.resourceconsultuser;
        this.recsourceConsultUser$ = observableOf(this.recsourceConsultUser);
        this.recsourceConsultForm.patchValue(resource);
        this.recsourceConsultForm.disable();
        this.isView = true;
        $('#add').modal('show');
    }

    deleteResource() {
        this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.DeleteResourceURL;
        if(this.resourceID) {
            this._service.remove(this.resourceID).subscribe(
                (response: any) => {
                    this.getPage(1);
                    this._alertService.success('Resource consult review deleted successfully');
                    this.resourceID = null;
                    $(this.deleteresourcepopupid).modal('hide');
                },
                (error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    $(this.deleteresourcepopupid).modal('hide');
                }
            );
        }
    }
    private mergeDateTime(dateobj: any, timeobj: any) {
        const Dateobj: any = new Date(dateobj);
        const timeSplit = timeobj.split(':');
        const TimeHour = timeSplit[0];
        const TimeMin = timeSplit[1];

        Dateobj.setHours(TimeHour);
        Dateobj.setMinutes(TimeMin);

        return Dateobj;
    }

    listDropdown() {
        this.selectType$ = this._commonHttpService.getArrayList(
            {
                method: 'get',
                where: {},
                order: 'description ASC' // cw-006 : Ascending order list
            },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetSelectTypeURL + '?filter').pipe(map(items => {
            return items.map(
                list =>
                    new DropdownModel({
                        text: list.description,
                        value: list.consultreviewusertypekey
                    })
            );
        }));
    }

    getPage(page: number) {
        const source = this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest(
                    {
                        method: 'get',
                        where: this.getRequestParam(),
                        page: this.paginationInfo.pageNumber,
                        limit: this.paginationInfo.pageSize,
                    }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetResourceConsultURL + '?filter'
            ).pipe(map((result: any) => {
                return {
                    data: result,
                    count: result.length > 0 ? result[0].totalcount : 0,
                    canDisplayPager: result.length > 0 ? result[0].totalcount > this.paginationInfo.pageSize : false
                };
            }),share(),);
        this.resourceList$ = source.pipe(pluck('data'));
        if (page === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }


    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    getRequestParam() {
        let inputRequest;
        const caseID = this.getCaseUuid();
        this.source = this.getSource();
        if (this.isServiceCaseData()) {
            inputRequest = {
                objectid: caseID,
                objecttypekey: 'servicecase'
            };
        } else if (this.isIntakeMode()) {
            inputRequest = {
                objectid: this.getIntakeNumber(),
                objecttypekey: 'intake'
            };

        } else {
            inputRequest = {
                objectid: caseID,
                objecttypekey: 'servicerequest'
            };
        }

        return inputRequest;
    }

    getCaseUuid() {
        const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        let caseUUID = null;
        if (caseInfo) {
            caseUUID = caseInfo.intakeserviceid;
            this.caseNumber = caseInfo.da_number;
            if (this.isServiceCaseData()) {
                this.caseType = 'Service Case';
            } else {
                this.caseType = caseInfo.da_subtype;
            }
        }
        if (caseID) {
            return caseID;
        }
        return caseUUID;
    }

    isServiceCaseData() {
        return this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    }

    isIntakeMode() {
        return this.getIntakeNumber() ? true : false;
    }

    getIntakeNumber() {
        const intakeStore = this._dataStoreService.getObj('intake');
        if (intakeStore && intakeStore.number) {
            return intakeStore.number;
        } else {
            return null;
        }
    }
    getSource() {

        if (this.isServiceCaseData()) {
            return AppConstants.CASE_TYPE.SERVICE_CASE;
        } else if (this.isIntakeMode()) {
            return AppConstants.CASE_TYPE.INTAKE;
        } else {
            return AppConstants.CASE_TYPE.CPS_CASE;
        }
        // need to add condition for adoption case
    }
/*
    getAssignmentsList() {
        this._commonHttpService.getArrayList(
          {
            where: { servicecaseid: this.id },
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
}