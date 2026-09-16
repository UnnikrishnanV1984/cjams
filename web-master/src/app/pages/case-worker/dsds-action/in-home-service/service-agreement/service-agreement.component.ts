import { Component, OnInit, Injector } from '@angular/core';
import { PersonService } from '../person.service';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { DataStoreService, CommonHttpService, AlertService, SessionStorageService, AuthService, CommonDropdownsService } from '../../../../../@core/services';
import { RouteToSupervisor } from '../../placement/_entities/placement.model';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DynamicObject, PaginationRequest, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { IntakeUtils } from '../../../../_utils/intake-utils.service';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';

@Component({
    selector: 'service-agreement',
    templateUrl: './service-agreement.component.html',
    styleUrls: ['./service-agreement.component.scss'],
    standalone: false
})
export class ServiceAgreementComponent implements OnInit {
  personList: any[] = [];
  personidlist: any[] = [];
  showSignedPanel = false;
  serviceAgreementFormGroup!: FormGroup;
  maxDate = new Date();
  agreementDate = new Date();
  householdName!: string;
  //@TM: Agreement related properties
  approvalStatusForm!: FormGroup;
  submitStatus!: RouteToSupervisor;
  agreementList: any = [];
  agreementid: any;
  id!: string;
  daNumber!: string;
  roleId!: AppUser;
  isSupervisor = false;
  isApproved = false;
  agreement: any;
  isEnableComments = false;
  gapAlertMessage!: string;
  isShowAgreementForm = false;
  newBtnDisabled = false;
  agreementDetail: any;
  store: DynamicObject;
  placementAgreementRateId: any;
  checkValidation!: boolean;
  approveAgreementResponse: any;
  approvalStatus!: boolean;
  supervisorsList: any[] = [];
  workerList: any[] = [];
  currentWorker: any;
  collaterals: any;
  isClosed = false;
  agreementMinDate!: Date;
  isEditable = false;
  paginationInfo: PaginationInfo = new PaginationInfo();
  fcpaginationInfo: PaginationInfo = new PaginationInfo();
  fcTotal!: number;
  isEditDisabled = false;
  selectPersonNameList: string[] = [];
  isReadonly!: boolean;
  checkmandatory: boolean = false;
  allusers :any =[];

  private readonly _personService: PersonService;
  private readonly formBuilder: FormBuilder;
  private readonly _dataStoreService: DataStoreService;
  private readonly _formBuilder: FormBuilder;
  private readonly _commonHttpService: CommonHttpService;
  private readonly _alertService: AlertService;
  public _authService: AuthService;
  private readonly storage: SessionStorageService;
  private readonly _route: Router;
  private readonly _intakeUitls: IntakeUtils;
  private readonly _commondDDService: CommonDropdownsService;

  constructor(private injector: Injector){
    this._personService = this.injector.get<PersonService>(PersonService);
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._route = this.injector.get<Router>(Router);
    this._intakeUitls = this.injector.get<IntakeUtils>(IntakeUtils);
    this._commondDDService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);

    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.isEditDisabled = this._authService.isDisabled('serviceagreement','serviceagreement.serviceagreements.edit');
    const actionSummary = this._dataStoreService.getData('dsdsActionsSummary');
    if (actionSummary) {
      this.agreementMinDate = new Date(actionSummary.da_receiveddate);
    }
    this.getusers();
    this.maxDate.setHours(0, 0, 0, 0);
    this.agreementMinDate.setHours(0, 0, 0, 0);
    this.agreementDate.setHours(0, 0, 0, 0);
    this.paginationInfo.sortColumn = 'agreementdate';
    this.paginationInfo.sortBy = 'desc';
    this.paginationInfo.pageNumber = 0;
    this.buildFormGroup();
    this.setCurrentLoggedInWorker();
    this._personService.getPersonsList().subscribe((item) => {
      this.personList = item.data;

      const hoh = this.personList.find(person => person.isheadofhousehold);
      if (hoh) {
        this.householdName = hoh.fullname;
      }
      this.getAgreement();
    });


    //@TM: Get Case ID, Check for Supervisor role
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.roleId = this._authService.getCurrentUser();

    if (this.roleId.role.name === 'apcs') {
      this.isSupervisor = true;
    } else {
      this.isSupervisor = false;
    }
    this.loadSupervisor();
    this.getcollateral();
    const da_status = this.storage.getItem('da_status');
    if (da_status) {
     if (da_status === 'Closed' || da_status === 'Completed') {
         this.isEditable = false;
         this.isClosed = true;
     } else {
         this.isClosed = false;
     }
    }
    const activeModuleRole = this.storage.getItem('activeModuleRole');
    if (activeModuleRole === 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole === 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole === 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
    this.isReadonly =  this._authService.readonlyButton('read_only_access','caseworker-service-agreement-add');}
  }

  setCurrentLoggedInWorker() {
    const currentUser = this._authService.getCurrentUser();
    if(currentUser){
      const loggedInUserProfile = currentUser.user?currentUser.user.userprofile:null;
      if(loggedInUserProfile){
      this.currentWorker = {userid: loggedInUserProfile.securityusersid,username: loggedInUserProfile.fullname};  
      }
    }
  }

  buildFormGroup() {
    this.serviceAgreementFormGroup = this.formBuilder.group({
      agreementid: [null],
      persons: [null],
      attentiontx: ['', Validators.required],
      agreementdate: [null, Validators.required],
      signeddate: [null],
      signatureobtflag: [false],
      supervisorid: [null, Validators.required],
      staffid: [null],
      collateralid: [null],
      associateid: [null],
      approvalstatustypekey: [null]
    });

    //@TM: Approval Status FormGroup
    this.approvalStatusForm = this._formBuilder.group({
      routingstatus: [''],
      comments: ['']
    });
  }

  onPersonChecked(event: { checked: any; }, person: { isSingned: any; }) {
    person.isSingned = event.checked;
    if (this.checkProperty() >= 1) {
      this.showSignedPanel = true;
    } else {
      this.showSignedPanel = false;
    }
  }

  checkProperty() {
    let count = 0;
    this.personList.forEach(o => {
      if (o.isSingned) {
        count++;
      }
    });


    return count;
  }

  onSorted($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.getAgreement();
  }

  // @TM: Methods for Service Agreement -----

  private getAgreement() {
    this._commonHttpService
      .getArrayList(
     
        {
          method:'get',
          page:this.paginationInfo.pageNumber,
          limit:10,
          where:
          { caseid: this.id, 
          sortdirection:this.paginationInfo.sortBy,sortcolumn:this.paginationInfo.sortColumn}},
        'serviceagreement/list?filter'
      )
      .subscribe(res => {
        if (res && (res instanceof Array)) {
          if(res.length) {
            this.fcTotal = res[0].totalcount;
          }
          this.agreementList = res.map(item => {
            item.agreementdate = this._commondDDService.getValidDate(item.agreementdate);
            return item;
          });
        }
      });
  }

  patchAgreement(modal: any) {
    this.agreementList = modal;
    this.serviceAgreementFormGroup.patchValue(this.agreementList);
    this.approvalStatusForm.patchValue({
      routingstatus: this.agreementList.routingstatus ? this.agreementList.routingstatus : '',
      comments: this.agreementList.comments ? this.agreementList.comments : ''
    });

    if (this.approvalStatusForm.value.routingstatus === 'Approved' || this.approvalStatusForm.value.routingstatus === 'Rejected') {
      this.isApproved = true;
      this.rejectComments(this.approvalStatusForm.value.routingstatus);
    }
    this.agreementList = Object.assign({});
  }

  conditionValidation(): boolean {
    if (this.serviceAgreementFormGroup.value.approvaldate !== null && this.serviceAgreementFormGroup.value.agreementdate !== null &&
      this.serviceAgreementFormGroup.value.approvaldate < this.serviceAgreementFormGroup.value.agreementdate) {
      this._alertService.error('Agreement Signed Date should be greater than Date of Agreement');
      return false;
    }
    return true;
  }

  rejectComments(status: string) {
    if (status === 'Rejected') {
      this.isEnableComments = true;
    } else {
      this.isEnableComments = false;
      this.approvalStatusForm.patchValue({ comments: '' });
      this.serviceAgreementFormGroup.disable();
    }
  }

  addAgreement(agreement: any, status: any) {
    this.personidlist = [];
    const validation = this.conditionValidation();
    let personObj, activeflag;
    for (const person of this.personList) {

      if (person.isSingned) {
        activeflag = 1;
      } else {
        activeflag = 0;
      }

      personObj = {
        "personid": person.personid,
        "activeflag": activeflag
      }
      this.personidlist.push(personObj);
    }
    this.agreement = Object.assign(
      {
        caseid: this.id,
        personidlist: this.personidlist,
        approvalstatustypekey: status ? status : 'pending',
      },
      agreement
    );

    if (validation) {
      this._commonHttpService.create(this.agreement, 'serviceagreement/add').subscribe(
        res => {
          if (status) {
            this._alertService.success('Operation completed Successfully!');
          } else {
            this._alertService.success('Saved Successfully!');
          }
          this.getAgreement();
          this.serviceAgreementFormGroup.disable();
          this.newBtnDisabled = true;
        },
        err => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
    }
  }


  showApproveAgreementAckmnt(approveResponse: any) {
    this.approveAgreementResponse = approveResponse;
    this._alertService.success('Completed successfully.');
    const url = `/pages/case-worker/dsds-action/in-home-service`;
    this._route.navigate([url]);
    (<any>$('#approve-agreement-ackmt')).modal('show');
  }

  openAgreement(mode: string) {
    if (mode === 'ADD') {
      this.serviceAgreementFormGroup.reset();
      this.serviceAgreementFormGroup.enable();
      this.selectPersonNameList = [];
      this.setCurrentLoggedInWorker();
      this.isEditable = this.isClosed ? false : true;
    }
    (<any>$('#agreement-form')).modal('show');
    this.loadSupervisor();
  }

  loadSupervisor() {
    this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'CWIF' },
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe(result => {
        this.supervisorsList = result.data;
        this.supervisorsList = this.supervisorsList.filter(
          users => users.issupervisor === true
        );
        
        this.workerList = result.data.filter(
          users => users.issupervisor !== true && users.username
        );
      });
  }

  getCaseUuid() {
    const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    if (caseID) {
      return caseID;
    }
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    let caseUUID = null;
    if (caseInfo) {
      caseUUID = caseInfo.intakeserviceid;
    }
    return caseUUID;
  }

  getcollateral() {
    const data = {
      caseid: this.getCaseUuid(),
      objecttype: 'servicecase',
      intakenumber: null,
    };
    const request = {
      objectid: data.caseid,
      objecttype: 'case'
    };
    this._commonHttpService.getArrayList(
      {
        where: request,
        method: 'get',
        nolimit: true
      },
      'collateral/list?filter'
    ).subscribe(dataCollateral => {
      if (dataCollateral && dataCollateral.length && dataCollateral[0].getcollateraldetails && dataCollateral[0].getcollateraldetails.length) {
        this.collaterals = dataCollateral[0].getcollateraldetails;
      } else {
        this.collaterals = [];
      }
    });
  }

  closeAgreement() {
    this.serviceAgreementFormGroup.reset();
    this.checkmandatory =false;
    (<any>$('#agreement-form')).modal('hide');
  }

  saveAgreement(status: string) {
    this.checkmandatory =true;
    this.serviceAgreementFormGroup.patchValue({staffid:this.currentWorker.userid})
    const agreementData = this.serviceAgreementFormGroup.getRawValue();
    if (this.serviceAgreementFormGroup.invalid) {
      this._alertService.error('Please fill required fields');
      return;
    }
    if (agreementData.signatureobtflag && !agreementData.signeddate) {
      this._alertService.error('Please fill required fields');
      return;
    }

    if (!agreementData.persons && !agreementData.collateralid) {
      this._alertService.error('Please select Family Member/Collateral');
      return;
    }
    agreementData.signatureobtflag = agreementData.signatureobtflag ? 1 : 0;
    agreementData.caseid = this.getCaseUuid();
    agreementData.approvalstatustypekey = status;
    if (status === 'approved') {
      agreementData.approvaldate = new Date();
    }
    this._commonHttpService.create(agreementData, 'serviceagreement/add').subscribe(
      _ => {
        this._alertService.success('Saved Successfully!');
        this.closeAgreement();
        this.getAgreement();
      },
      err => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  agreementDateChanged() {
    this.agreementDate = new Date(this.serviceAgreementFormGroup.getRawValue().agreementdate);
    this.agreementDate.setHours(0, 0, 0, 0);
    this.serviceAgreementFormGroup.patchValue({signeddate : null});
  }

  viewAgreement(data: any) {
    this.openAgreement('VIEW');
    this.patchServiceAgreement(data);
    this.isEditable = false;
    this.serviceAgreementFormGroup.disable();
  }

  reviewAgreement(data: any) {
    this.openAgreement('VIEW');
    this.isEditable = this.isClosed ? false : true;
    this.patchServiceAgreement(data);
  }

  patchServiceAgreement(data: { [x: string]: any; agreementdate?: any; serviceagreementlist?: any; persons?: any; signatureobtflag?: any; signeddate?: any; collateralid?: any; staffid?: any; staffname?: any; }) {
    this.agreementDate = new Date(data.agreementdate);
    this.agreementDate.setHours(0, 0, 0, 0);
    if (Array.isArray(data.serviceagreementlist) && data.serviceagreementlist.length) {
      const person: any[] = [];
      data.serviceagreementlist.forEach(item =>{
        person.push(item.personid);
      });
      const participant = data.serviceagreementlist[0];
      data.persons = person;
      data.signatureobtflag = data.signatureobtflag ? true : false;
      data.signeddate = this._commondDDService.getValidDate(participant.signeddate);
      data.collateralid = participant.collateralid;
    }
    this.serviceAgreementFormGroup.patchValue(data);
    this.getPersonNameList(this.serviceAgreementFormGroup.getRawValue().persons, this.personList)
    this.currentWorker = {userid: data.staffid,username: data.staffname}; 
  }

  downloadAgreement(data: { agreementid: any; }) {

    const modal = {
      count: -1,
      where: {
        documenttemplatekey: ['agreement'],
        agreementid: data.agreementid,
      },
      method: 'post'
    };
    this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
        .subscribe(res => {
          const blob = new Blob([new Uint8Array(res)]);
          const link = document.createElement('a');
          link.href = window.URL.createObjectURL(blob);
          link.download = 'Serivce Agreement.pdf';
          document.body.appendChild(link);
          link.click();
          document.body.removeChild(link);
        });

  }

  fcPageChanged(pageEvent: { page: number; }) {
    this.paginationInfo.pageNumber = pageEvent.page;
    this.getAgreement();
  }

  editAgreement(data: any) {
    this.patchServiceAgreement(data);
    this.isEditable = true;
    this.serviceAgreementFormGroup.enable();
  }	
  getPersonNameList(id: any, list: any) {	
    const selectPersonList = list.filter((f: { personid: any; }) => id?.includes(f.personid));	
    this.selectPersonNameList = selectPersonList.map((item: { fullname: any; }) => item.fullname);
  }
  getusers(){
    
     this._commonHttpService.getArrayList(
      { nolimit: true, method: 'get' }, 
        'users/list?filter'
    ).subscribe(result => {
      this.allusers =result;
     
    });
  }
   
  
}
