
import {pluck, map, share} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable ,  forkJoin } from 'rxjs';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import { DropdownModel, PaginationRequest, PaginationInfo } from '../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, SessionStorageService, DataStoreService } from '../../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { AgencyCategories, AgencyServices } from '../../../../_entities/caseworker.data.model';
import { DatePipe } from '@angular/common';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { ColumnSortedEvent } from '../../../../../../shared/modules/sortable-table/sort.service';
@Component({
    selector: 'agency-provided-services',
    templateUrl: './agency-provided-services.component.html',
    styleUrls: ['./agency-provided-services.component.scss'],
    providers: [DatePipe],
    standalone: false
})
export class AgencyProvidedServicesComponent implements OnInit {

  agencyServiceList$!: Observable<any[]>;
  totalRecord$!: Observable<number>;
  paginationInfo: PaginationInfo = new PaginationInfo();
  agencyService: any;
  id!: string;
  // D-06581
  // D-06581
  daNumber!: string;
  addNewProviderForm!: FormGroup;
  viewProviderForm!: FormGroup;
  clientProgramNames$!: Observable<DropdownModel[]>;
  agencyServiceNames$!: Observable<DropdownModel[]>;

  frequencyCds$!: Observable<DropdownModel[]>;
  durationCds$!: Observable<DropdownModel[]>;

  agencyCategories$!: Observable<AgencyCategories[]>;
  agencyServices$!: Observable<AgencyServices[]>;
  agencyDetailsFirstDiv!: boolean;
  agencyDetailsSecondDiv!: boolean;
  private token: AppUser;
  a2eOptions: any;

  addEditlabel!: string;
  childList: any[] = [];
  personInvolved$!: Observable<DropdownModel[]>;
  firstChild: any;
  rcCjamsID: any;
  clientDob: any;
  clientGender: any;
  clientAge: any;
  clientName!: string;
  minActDate!: Date;
  minEstDate!: Date;
  personid: any;
  activityService!: any[];
  activityServicePlan!: any[];
  servicePlan!: any[];
  clientProgramNames!: any[];
  clientprogramselection: any;
  startdate!: Date;
  enddate!: Date;
  isServiceCase: any;
  serviceCase!: boolean;
  mandatoryField!: boolean;
  isClosed = false;
  disbleService!: boolean;
  listPageInfo: PaginationInfo = new PaginationInfo();
  isReadonly = true;
  isEditDisabled = false;
  isDeleteDisabled = false;
  isAdoptionCase = false;
  isCpsIRorAR =false;
  dtformat = 'yyyy-MM-dd';
  twelvehour: boolean = true;
  timeInterval: number = 5;
 
    private formBuilder: FormBuilder;
    private _commonHttpService: CommonHttpService;
    private _authService: AuthService;
    private _alertService: AlertService;
    private datePipe: DatePipe;
    private _dataStoreService: DataStoreService;
    private _session: SessionStorageService;

    constructor( private injector: Injector) {
      this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
      this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
      this._authService = this.injector.get<AuthService>(AuthService);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this.datePipe = this.injector.get<DatePipe>(DatePipe);
      this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
      this._session = this.injector.get<SessionStorageService>(SessionStorageService);

      this.formInitialize();
      this.token = this._authService.getCurrentUser();
      this.a2eOptions = { format: 'MM/DD/YYYY', useCurrent: false };
  }

  private formInitialize() {
    this.addNewProviderForm = this.formBuilder.group(
      {
        // intakeservicerequestactorid: ['', Validators.required],
        clientprogramnameid: ['', Validators.required],
        servicetypeid: ['', Validators.required],
        frequencyCdId: ['', Validators.required],
        durationCdId: ['', Validators.required],
        estbegindate: ['', Validators.required],
        actbegindate: [''],
        estenddate: ['', Validators.required],
        actenddate: [''],
        actbegintime: [''],
        actendtime: [''],
        agencynotes: [''],
        serviceplanactionid: [null],
        serviceplanid: [null],
        serviceplanname: ''
      });
  }

  public selectService() {
    this.agencyDetailsFirstDiv = false;
    this.agencyDetailsSecondDiv = true;
  }

  private clientProgramDropdown() {
    this._commonHttpService.getArrayList(
      {
      where: {intakeserviceid: this.id, person_id: this.personid},
      order: 'agency_program_nm',
      method: 'get'
    },
    CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.ClientProgramName + '?filter',

  ).subscribe(response => {
      if (response && response.length) {
          this.clientProgramNameApiResponseFn(response);
      } else {
        this.disbleService = true;
        this.clientprogramselection = null;
        this._alertService.warn('Please add required program service for the selected client');
      }
  });
    const source = forkJoin([
      this._commonHttpService.getArrayList({
        order: 'SERVICE_NM'
      }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.ClientprogramServices),
      this._commonHttpService.getArrayList({
        order: 'value_tx'
      }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.Frequency),
      this._commonHttpService.getArrayList({
        order: 'value_tx'
      }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.Duration)
    ]).pipe(
      map((result: any) => {
        return {
          servicetypeid: result[0]['UserToken'].map(
            (res: { SERVICE_NM: any; SERVICE_ID: any; }) =>
              new DropdownModel({
                text: res.SERVICE_NM,
                value: res.SERVICE_ID
              })
          ),
          frequencyCdId: result[1]['UserToken'].map(
            (res: { value_tx: any; picklist_value_cd: any; }) =>
              new DropdownModel({
                text: (res.value_tx),
                value: (res.picklist_value_cd),
              })
          ),
          durationCdId: result[2]['UserToken'].map(
            (res1: { value_tx: any; picklist_value_cd: any; }) =>
              new DropdownModel({
                text: (res1.value_tx),
                value: (res1.picklist_value_cd),
              })
          )
        };
      }),
      share(),);

    this.agencyServiceNames$ = source.pipe(pluck('servicetypeid'));
    this.frequencyCds$ = source.pipe(pluck('frequencyCdId'));
    this.durationCds$ = source.pipe(pluck('durationCdId'));
  }
  // Associated with clientProgramDropdown function
  private clientProgramNameApiResponseFn(response: any[]) {
    let arrayProg = [];
    this.clientProgramNames = response;
    arrayProg = response.filter((item) => !item.enddate);
    if (arrayProg && arrayProg.length) {
      this.startdate = arrayProg[0].startdate;
      this.enddate = arrayProg[0].enddate;
      this.clientprogramselection = arrayProg[0].agency_program_area_id ? arrayProg[0].agency_program_area_id : null;
    } else {
      this.startdate = response[0].startdate;
      this.enddate = response[0].enddate;
      this.clientprogramselection = response[0].agency_program_area_id ? response[0].agency_program_area_id : null;
    }
    const currDate = new Date();
    if (this.enddate) {
      if (new Date(this.enddate) < currDate) {
        this.disbleService = true;
        this._alertService.warn('Please add required Program Service for the selected client');
      } else {
        this.disbleService = false;
      }
    } else {
      this.disbleService = false;
    }
  }

  ngOnInit() {
    this.isEditDisabled = this._authService.isDisabled('services','services.servicelog.editagencyservice');
    this.isDeleteDisabled = this._authService.isDisabled('services','services.servicelog.deleteagencyservice');
    this.isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    const caseType = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    if(caseInfo && (caseInfo.da_subtype==='CPS-IR'||caseInfo.da_subtype==='CPS-AR')){
      this.isCpsIRorAR=true;
    }

        if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
            this.isAdoptionCase = true;
        }  
    // D-06581
    const activeModuleRole = this._session.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
    this.isReadonly =  this._authService.readonlyButton('read_only_access','readonly-agency-serlog');}
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.getInvolvedPerson();
    this.listPageInfo.sortBy = 'desc';
    this.listPageInfo.sortColumn = 'actual_begin_date';

    const da_status = this._session.getItem('da_status');
    if (da_status) {
     if (da_status === 'Closed' || da_status === 'Completed') {
         this.isClosed = true;
     } else {
         this.isClosed = false;
     }
    }
  }

  getInvolvedPerson() {
    let personDetail = {};
    if (this.isServiceCase) {
      this.serviceCase = true;
      personDetail = {
          objectid: this.id,
          objecttypekey: 'servicecase'
      };
    } else {
        this.serviceCase = false;
        personDetail = {
            intakeserviceid: this.id
        };
    }
    this.childList = [];
    this._commonHttpService
        .getPagedArrayList( new PaginationRequest({
            method: 'get',
            page: 1, limit : 100,
            nolimit: true,
            where: personDetail
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
        )
       /* .map((res) => {
            console.log('res', res);
            return res['data'].filter((item) => item.intakeservicerequestpersontypekey === 'CHILD');
        })*/.subscribe((response: any) => {
            if (response && response.data.length) {
                for (const element of response.data) {
                    if (element.roles) {
                                this.childList.push(element);
                                this.firstChild = element;
                                this.rcCjamsID = element.cjamspid;
                                this.clientDob = element.dob;
                                this.clientGender = element.gender;
                                this.clientAge = element.age;
                                this.clientName = element.firstname + ' ' + element.lastname;
                                this.personid = element.personid;
                    }
                  }
                this.getList();
                this.clientProgramDropdown();
            }
        });
}

getActivityService() {
  this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
        where: {personid: this.personid},
        limit : 10,
        page: 1,
        method: 'get'
      }), 'serviceLogs/getServicePlanActionList' + '?filter'
    ).subscribe((result: any) => {
      this.activityService = result.data;
    });
}

onActivityService(serviceplanactionid: any) {
  this.addNewProviderForm.get('serviceplanname')?.reset();
  this.getServicePlan(serviceplanactionid);
}

getServicePlan(serviceplanactionid: any) {
  this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
        where: {serviceplanactionid: serviceplanactionid},
        limit : 10,
        page: 1,
        method: 'get'
      }), 'serviceLogs/getServicePlanList' + '?filter'
    ).subscribe((result: any) => {
      this.servicePlan = result.data;
      if  (this.servicePlan && this.servicePlan.length) {
        this.addNewProviderForm.patchValue({
            serviceplanid: this.servicePlan[0].serviceplanid,
            serviceplanname: this.servicePlan[0].serviceplanname
        });
        this.addNewProviderForm.get('serviceplanname')?.disable();
    }
    });
}
  getFullName(person: any) {
    const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
    let name = '';
    nameKeys.forEach(key => {
      if(person && person.hasOwnProperty(key)){
        if ( (person[key] !== null) && (person[key] !== 'null') && (person[key] !== '') ) {
          name = name + person[key] + ' ';
        }}
    });
    return name;
  }
  pageChanged(page: number) {
    this.getList(page);
  }

  getList(pageNo = 1) {

    // D-06581
    this.agencyServiceList$ = this._commonHttpService.getArrayList(
      {
        where: { daNumber: this.daNumber, client_id: this.rcCjamsID,
        sortcolumn: this.listPageInfo.sortColumn, sortorder: this.listPageInfo.sortBy },
        method: 'get',
        nolimit: true
      },

      CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.agencyServiceLog + '?filter'

    ).pipe(
      map((res: any) => {
        return res['servicelogData'];
      }));
  }

  initaddNewProviderForm() {
    this.minActDate = new Date();
    this.minActDate = new Date();
    this.agencyDetailsFirstDiv = true;
    this.agencyDetailsSecondDiv = false;
    this.agencyService = null;
    this.addEditlabel = 'Add';
    this.addNewProviderForm.reset();
    this.addNewProviderForm.reset();
    this.addNewProviderForm.patchValue({
      estbegindate : this.startdate,
      actbegindate: this.startdate
    });
    this.addNewProviderForm.patchValue({
      clientprogramnameid: this.clientprogramselection ? this.clientprogramselection : null
    });
    this.getActivityService();
  }

  formtString(param: string) {
    param = param.replace(',', '');
    param = param.replace('"', '');
    param = param.replace('(', '');
    param = param.replace(')', '');
    return param;
  }
  getValidationMessage(controlName: any,displayname: any){
    if(this.addNewProviderForm.controls[controlName].status == 'INVALID' )
    {
        return 'Please  '+displayname;
    }}

  addAgency() {
    this.mandatoryField=true;
    
    if (this.addNewProviderForm.valid) {
      const url = 'serviceLogs/' + (this.agencyService ? 'update' : 'save');
      const agencyForm = this.addNewProviderForm.getRawValue();

      const model = this.returnModelDataFn(agencyForm);
      const promise = this.agencyService && this.agencyService.service_log_id ? this._commonHttpService.update('', model, url) : this._commonHttpService.create(model, url);
      this.addNewProviderForm.get('serviceplanname')?.disable();

      promise.subscribe((response) => {
        this.promiseResponseFn(response);
      },
        (error) => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);

          this.closeItem();
        });
    } else {
       if(this.addNewProviderForm.value.estbegindate< new Date(this.startdate)){
        this._alertService.warn('Begin date cannot be less than the Case Start Date');
      }else{
        this._alertService.warn('Please fill mandatory fields');
      }
    }
  }
  // Associated with addAgency function
  private returnModelDataFn(agencyForm: any) {
    return {
      'agencyServiceLdssId': this.addNewProviderForm.value.servicetypeid,
      'startDt': this.datePipe.transform(this.addNewProviderForm.value.actbegindate, this.dtformat),
      'endDt': this.datePipe.transform(this.addNewProviderForm.value.actenddate, this.dtformat),
      'descriptionTx': this.addNewProviderForm.value.agencynotes,
      'startTm': (typeof this.addNewProviderForm.value.actbegintime === 'string') ?
        this.addNewProviderForm.value.actbegintime : this.datePipe.transform(this.addNewProviderForm.value.actbegintime, 'hh-mm aa'),
      'endTm': (typeof this.addNewProviderForm.value.actendtime === 'string') ?
        this.addNewProviderForm.value.actendtime : this.datePipe.transform(this.addNewProviderForm.value.actendtime, 'hh-mm aa'),
      'estimatedStartDt': this.datePipe.transform(this.addNewProviderForm.value.estbegindate, this.dtformat),
      'estimatedEndDt': this.datePipe.transform(this.addNewProviderForm.value.estenddate, this.dtformat),
      'frequencyCd': this.addNewProviderForm.value.frequencyCdId,
      'durationCd': this.addNewProviderForm.value.durationCdId,
      // D-06581
      'daNumber': this.daNumber,
      'agencyProgramAreaId': agencyForm.clientprogramnameid,
      'serviceLogId': this.agencyService ? this.agencyService.service_log_id : null,
      'client_id': this.rcCjamsID ? this.rcCjamsID : null,
      serviceplanactionid: this.addNewProviderForm ? this.addNewProviderForm.value.serviceplanactionid : null,
      serviceplanid: agencyForm ? agencyForm.serviceplanid : null,
      serviceplanname: this.addNewProviderForm ? agencyForm.serviceplanname : null,
    };
  }
  // Associated with addAgency function
  private promiseResponseFn(response: any) {
    if (response) {
      if (this.agencyService) {
        this._alertService.success('Agency Service updated successfully');
      } else {
        this._alertService.success('Agency Service saved successfully');
      }
      this.getList();
      this.closeItem();
    }
  }

  closeItem() {
    (<any>$('#add-newagencyprovider')).modal('hide');
  }

  view(agency: any) {
    this.agencyService = agency;
    (<any>$('#view-newagencyprovider')).modal('show');
  }

  delete(agencyService: any) {
    this.agencyService = agencyService;
  }

  edit(agency: any) {
    this.getActivityService();
    this.getServicePlan(agency.serviceplanactionid);
    this.agencyService = agency;
    this.updateForm(agency);
    this.addEditlabel = 'Edit';
  }

  updateForm(agency: any) {
    // Validate against the program assignment recorded on this service log, for both closed and open program assignments ignore other types of Program assignment.
    const arrayProg = this.clientProgramNames?.filter(
      (item) => item.agency_program_area_id == agency.agency_program_area_id);
    if(arrayProg?.length) {
      this.startdate = arrayProg[0].startdate;
      this.enddate = arrayProg[0].enddate;
      this.clientprogramselection = arrayProg[0].agency_program_area_id ? arrayProg[0].agency_program_area_id : null;
      this.widenWindowToServiceLogFn(agency);
    }
    const model = {
      // intakeservicerequestactorid: agency.intakeservicerequestactorid,
      // client_id: this.rcCjamsID ? this.rcCjamsID : null,
      clientprogramnameid: agency.agency_program_area_id,
      servicetypeid: agency.service_id,
      frequencyCdId: agency.frequency_cd,
      durationCdId: agency.duration_cd,
      estbegindate: new Date(agency.estimated_start_date),
      actbegindate: new Date(agency.actual_begin_date),
      estenddate: new Date(agency.estimated_end_date),
      actenddate: agency.actual_end_date ? new Date(agency.actual_end_date) : null,
      actbegintime: agency.actual_start_time,
      actendtime: agency.actual_end_time,
      agencynotes: agency.notes,
      serviceplanactionid: agency ? agency.serviceplanactionid : null,
      serviceplanid: agency ? agency.serviceplanid : null,
      serviceplanname: agency ? agency.serviceplanname :  null
    };
    this.addNewProviderForm.patchValue(model);
    this.addNewProviderForm.get('clientprogramnameid')?.disable();
    this.minEstDate = new Date(this.addNewProviderForm.value.estbegindate);
    this.minActDate = new Date(this.addNewProviderForm.value.actbegindate);
    this.addNewProviderForm.get('serviceplanname')?.disable();
    (<any>$('#add-newagencyprovider')).modal('show');
  }
  // Associated with updateForm function
  // Mirrors handleIfReferredServiceFn in ReferredServicesComponent: an already saved service log may
  // sit outside its program assignment window, so widen the bounds to keep the record editable.
  private widenWindowToServiceLogFn(agency: any) {
    if (this.startdate && agency.estimated_start_date &&
      new Date(agency.estimated_start_date) < new Date(this.startdate)) {
      this.startdate = new Date(agency.estimated_start_date);
    }
    if (this.enddate && agency.estimated_end_date &&
      new Date(agency.estimated_end_date) > new Date(this.enddate)) {
      this.enddate = new Date(agency.estimated_end_date);
    }
  }

  deleteItem() {
    this._commonHttpService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.DelectServiceLog;
        this._commonHttpService.update('',
        {
            service_log_id: this.agencyService.service_log_id,
            case_id: this.daNumber,
            client_id: this.rcCjamsID
        }).subscribe(
            (response) => {
                this._alertService.success('Service has been deleted successfully');
                (<any>$('#Delete-newagencyprovider')).modal('hide');
                this.getList(1);
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );


  }

  childSelect(clientdetail: any) {
    this.clientName = clientdetail.firstname + ' ' + clientdetail.lastname;
    this.rcCjamsID = clientdetail.cjamspid;
    this.clientDob = clientdetail.dob;
    this. clientGender = clientdetail.gender;
    this.clientAge = clientdetail.age;
    this.personid = clientdetail.personid;
    this.getList();
    this.clientProgramDropdown();
  }

  onChangeDate(form: any, field: any) {
    if ( field === 'estbegindate' ) {
        this.minEstDate = new Date(form.value.estbegindate);
        form.get('estenddate').reset();
    } else if ( field === 'actbegindate') {
        this.minActDate = new Date(form.value.actbegindate);
        form.get('actenddate').reset();
    }
  }

  onServiceSorted($event: ColumnSortedEvent) {
    this.listPageInfo.sortBy = $event.sortDirection;
    this.listPageInfo.sortColumn = $event.sortColumn;
    this.getList();
}
onchangeofclientprogramname(_event: any,clientprogram: any){
  this.startdate = clientprogram.startdate;
  this.enddate = clientprogram.enddate;
  this.addNewProviderForm.patchValue({
    estbegindate : this.startdate,
    actbegindate: this.startdate
  });
}

}
