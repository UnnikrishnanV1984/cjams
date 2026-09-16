
import {EMPTY,  Observable ,  forkJoin ,  Subject } from 'rxjs';

import {pluck, share, map} from 'rxjs/operators';
import { DatePipe } from '@angular/common';
import { AfterViewChecked, ChangeDetectorRef, Component, OnInit, OnDestroy, AfterViewInit, Injector } from '@angular/core';
import { FormArray, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { AppConstants } from '../../../../@core/common/constants';
import { ControlUtils } from '../../../../@core/common/control-utils';
import { ObjectUtils } from '../../../../@core/common/initializer';
import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, DataStoreService, GenericService, SessionStorageService } from '../../../../@core/services';
import { DSDSActionSummary } from '../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import * as status from './_configurations/status.json';
import { ActivityGoalModal, ActivityTaskModal, IntakeActivityTask, InvestigationPlanCaseCount, InvestigationPlanSummary } from './_entities/investigationplan.data.models';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { DsdsService } from '../_services/dsds.service';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { MatRadioChange } from '@angular/material/radio';

declare const $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'investigation-plan',
    templateUrl: './investigation-plan.component.html',
    styleUrls: ['./investigation-plan.component.scss'],
    providers: [DatePipe],
    standalone: false
})
export class InvestigationPlanComponent implements OnInit, AfterViewInit, AfterViewChecked, OnDestroy {
    id: string;
    daNumber: string;
    investigationId!: string;
    startdate!: string;
    starttime!: string;
    starttimeformat!: string;
    enddate!: string;
    endtime!: string;
    endtimeformat!: string;
    showTime!: boolean;
    isServiceCase!: boolean;
    openTasks: any = 8;
    closedTasks: any = 0;
    involvedPersonList: any[] = [];
    isKinshipNavigator: boolean = false;
    showKinshipTab: boolean = false;
    kinshipChecklistComplete = false;
    source!: string;
    caregiversInCase: any[] = [];
    legalGaurdianPersonId: any[] = [];
    isServicePlanPresent: boolean = false;
    isCaregiverContactComplete: boolean = false;
    houseHoldPersonDemographicInfo: boolean = false;
    parentOrLegalGaurdianDemographicInfo: boolean = false;
    isSaftyAssessmentDone: boolean = false;
    isMFIRAAssessmentDone: boolean = false;
    isKinshipNavigationTransitionLetterPresent: boolean = false;
    servicelogcompleted: boolean = false;
    checklistItems: any[] = [];
    personlistforservicelog: any[] = [];
    houseHoldPersonList: any[] = [];
    parentOrLegalGaurdian: any[] = [];
    kinshipChecklist: any[] = [
        {key:'initialContactCaregiver',description:"Make a contact with all caregivers", value: false},
        {key:'familyDemographics', description:"Family Demographics like age, sex, race/ethnicity must be filled", value: false},
        {key:'parentDemographics', description:"Biological Parents/ Legal gaurdian Demographics like age, sex, race/ethnicity must be filled", value: false},
        {key:'saftyAssessments', description:"Safety Assessment(s) of all children Completed.", value: false},
        {key:'mfira', description:"MFIRA mst be completed", value: false},
        {key:'serviceplan', description:"A service plan must be created", value: false},
        {key:'servicelog', description:"All Service Log (Agency and Vendor) updated with end dates.", value: false},
        {key:'kinshipnavigatorletter', description:" Check Kinship Navigator Services Transition Letter must be completed under the documents / forms.", value: false}
    ];
    statusSearchForTask = false;
    taskstatus!: string | null;
    editLabel!: string;
    caseStatus!: string;
    userType = false;
    activityTask = new ActivityTaskModal();
    taskUpdate = new IntakeActivityTask();
    activityGoal = new ActivityGoalModal();
    paginationInfo: PaginationInfo = new PaginationInfo();
    activityGoal$!: Observable<ActivityGoalModal[]>;
    activityTask$!: Observable<ActivityTaskModal[]>;
    activityTasks: ActivityTaskModal[] = [];
    dsdsActionsSummary = new DSDSActionSummary();
    investigationPlanCaseCount$!: Observable<InvestigationPlanCaseCount>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    dsdsActionsSummary$!: Observable<any>;
    statusDropdown!: DropdownModel[];
    goalTypeDropdownItems$!: Observable<DropdownModel[]>;
    goalStatusTypeDropdownItems$!: Observable<DropdownModel[]>;
    dispositionDropdownItems$!: Observable<DropdownModel[]>;
    taskDispositionDropdownItems$!: Observable<DropdownModel[]>;
    activityDropdownItems$!: Observable<DropdownModel[]>;
    taskDropdownItems$!: Observable<DropdownModel[]>;
    usersProfileDropdownItems$!: Observable<DropdownModel[]>;
    taskTypeStatusDropdownItems$!: Observable<DropdownModel[]>;
    activityGoalsFormGroup!: FormGroup;
    activityTaskFormGroup!: FormGroup;
    investigationPlanSearchFormGroup!: FormGroup;
    activityTaskStatusFormGroup!: FormGroup;
    forkedResult$!: Observable<any>;
    maxDate = new Date();
    private pageSubject$ = new Subject<number>();
    agency = '';
    userInfo!: AppUser;
    dispositionStatusDetails: any[] = [];
    isAS!: boolean;
    isDJS = false;
    isInHomeservice = false;
    isInHomeActive!: boolean;
    sortBy = false;
    sortCategoryForm!: FormGroup;
    sortDropDown!: { 'value': string; 'text': string; }[];
    selectedActionType!: string | null;
    isClosed = false;
    moduleview: any;
    isReadonly!: boolean;

    orderbyfield = 'typedescription asc';
    investigationpopupid = '#myModal-conclude-investigation';
    goalspopupid = '#myModal-edit-goal-details';
    iscaseexpunged: any = 0;

    private route: ActivatedRoute;
    private _router: Router;
    private formBuilder: FormBuilder;
    private _formBuilder: FormBuilder;
    private _service: GenericService<IntakeActivityTask>;
    private _commonHttpService: CommonHttpService;
    private _planSummaryService: GenericService<InvestigationPlanSummary>;
    private _taskService: GenericService<ActivityTaskModal>;
    private _goalsService: GenericService<ActivityGoalModal>;
    public _authService: AuthService;
    private _alertService: AlertService;
    private datePipe: DatePipe;
    private _changeDetect: ChangeDetectorRef;
    private _dataStoreService: DataStoreService;
    private _dsdsService: DsdsService;
    private storage: SessionStorageService;

    constructor(private injector : Injector){
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._router = this.injector.get<Router>(Router);
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._service = this.injector.get<GenericService<IntakeActivityTask>>(GenericService);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._planSummaryService = this.injector.get<GenericService<InvestigationPlanSummary>>(GenericService);
        this._taskService = this.injector.get<GenericService<ActivityTaskModal>>(GenericService);
        this._goalsService = this.injector.get<GenericService<ActivityGoalModal>>(GenericService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this.datePipe = this.injector.get<DatePipe>(DatePipe);
        this._changeDetect = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._dsdsService = this.injector.get<DsdsService>(DsdsService);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);


        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.route.data.subscribe((data :any) => {
            if (data && data.hasOwnProperty('result')) {
                this._authService.setAuthDetail('checklist', data.result);
            }
        }); 
    }
    ngOnInit() {
        this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.moduleview = this._authService.isModuleAccessable('checklist', 'checklist');
        this.isServiceCase = this._dsdsService.isServiceCase();
        this.initiateFormGroup();
        this.statusDropdown = <any>status;
        this.getActionSummary();
        this.loadDropdown();
        this.getActivityDropdown();
        this.getDispositionStatus();
        this.activityTaskFormGroup.get('loadnumber')?.disable();
        this.activityTaskFormGroup.get('assignedon')?.disable();
        this.activityTaskFormGroup.get('activitytasktypekey')?.disable();
        this.dsdsActionsSummary = this._dataStoreService.getData('dsdsActionsSummary');
        if (this.dsdsActionsSummary && this.dsdsActionsSummary.da_subtype && this.dsdsActionsSummary.da_subtype === 'IHS'
            && this.dsdsActionsSummary.teamtypekey && this.dsdsActionsSummary.teamtypekey === 'CW') {
            this.isInHomeservice = true;
        }
        this.agency = this._authService.getAgencyName();
        this.userInfo = this._authService.getCurrentUser();
        if (this.userInfo.role.teamtypekey === 'AS') {
            this.isAS = true;
        }
        if (this.userInfo.role.teamtypekey === 'DJS') {
            this.isDJS = true;
        }
        const da_status = this.storage.getItem('da_status');
        if (da_status) {
        if (da_status === 'Closed' || da_status === 'Completed') {
            this.isClosed = true;
        } else {
            this.isClosed = false;
        }
        }
        this._authService.readonlyPage('read_only_access', 'investigation-edit-mode',
            [this.activityGoalsFormGroup,
             this.activityTaskFormGroup,
             this.investigationPlanSearchFormGroup ,
             this.activityTaskStatusFormGroup
            ]);
    this.getInvolvedPerson(); 
    const activeModuleRole = this.storage.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
    this.isReadonly =  this._authService.readonlyButton('read_only_access','investigation-edit-mode');}
    }
    ngAfterViewInit() {
        const intakeCaseStore = this._dataStoreService.getData('IntakeCaseStore');
        if (this._authService.isDJS() && intakeCaseStore && intakeCaseStore.action === 'view') {
           $(':button').prop('disabled', true);
           $('.hidefromview').css({'pointer-events': 'none',
                        'cursor': 'default',
                        'opacity': '0.5',
                        'text-decoration': 'none'});
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
    ngAfterViewChecked() {
        this._changeDetect.detectChanges();
    }
    ngOnDestroy() {
        if (this.activityTaskStatusFormGroup.dirty) {
            this.saveTask();
        }
    }
    initiateFormGroup() {
        this.activityGoalsFormGroup = this.formBuilder.group({
            activitygoalid: [''],
            goal: [''],
            goalType: [''],
            duedate: ['', [Validators.required, Validators.minLength(1)]],
            status: [''],
            disposition: [''],
            completiondate: [null, [Validators.required, Validators.minLength(1)]]
        });

        this.activityTaskFormGroup = this.formBuilder.group(
            {
                task: [''],
                activitytaskid: [''],
                taskdescription: [''],
                activitytasktypekey: [''],
                insertedon: new Date(),
                required: [true],
                duedate: new Date(),
                loadnumber: [''],
                assignedon: new Date(),
                location: [''],
                outofoffice: [''],
                activitytaskstatustypekey: ['', Validators.required],
                completeddate: [new Date()],
                activitytaskdispositiontypekey: ['', Validators.required],
                starttimeformat: [''],
                startdate: [''],
                starttime: [''],
                enddate: [''],
                endtime: [''],
                endtimeformat: [''],
                tasktype: ['']
            }
        );
        this.investigationPlanSearchFormGroup = this.formBuilder.group({
            invesplansearch: [''],
            activityname: [''],
            taskname: [''],
            statustype: [''],
            taskagainst: ['']
        });
        this.activityTaskStatusFormGroup = this._formBuilder.group({
            task: this._formBuilder.array([this.createTaskForm()])
        });
        this.sortCategoryForm = this.formBuilder.group({
        sortBy: [''],
        sortDir: ['']
        });
    }
    createTaskForm() {
        return this._formBuilder.group({
            assignedon: [''],
            activitytypekey: [''],
            taskdescription: [''],
            duedate: [''],
            activitytaskid: [''],
            activitytaskstatustypekey: [''],
            activitytaskdispositiontypekey: null,
            completeddate: [''],
            tasktype: [''],
            taskdispositiontypekey: [''],
            iseditable: [''],
            notes: ['']
        });
    }
    addNewTask() {
        const control = <FormArray>this.activityTaskStatusFormGroup.controls['task'];
        control.push(this.createTaskForm());
    }
    showKinshipChecklist(event: any){
        this.openTasks = 8;
        this.closedTasks = 0;
        if(event){
            this.loadKinshipChecklists();
            this.isKinshipNavigator = true;
        } else {
            this.isKinshipNavigator = false; 
        }
    }
    setFormValues(isInHome: number) {
        this.activityTaskStatusFormGroup.setControl('task', this._formBuilder.array([]));
        const control = <FormArray>this.activityTaskStatusFormGroup.controls['task'];

        if (this.isServiceCase || this.isInHomeservice) {
            let filterActivityTasks = [];
            if (isInHome === 1) {
                this.showKinshipTab = true;
                filterActivityTasks = this.activityTasks.filter(task => task.checklisttype === 'IHM');
            } else {
                this.showKinshipTab = false;
                filterActivityTasks = this.activityTasks.filter(task => task.checklisttype !== 'IHM');
            }
            filterActivityTasks.forEach((x) => {
                control.push(this.buildTaskForm(x));
            });
        } else {
            this.activityTasks.forEach((x) => {
                control.push(this.buildTaskForm(x));
            });
        }
    }

    changeSelectedActionType(event: MatRadioChange) {
        if (event.value === 'SORT') {
            this.sortBy = true;
         }
    }

    private buildTaskForm(x: any): FormGroup {
        return this._formBuilder.group({
            assignedon: x.assignedon,
            activitytypekey: x.activitytypekey,
            actvityname: x.actvityname ? x.actvityname : '',
            taskdescription: x.task,
            duedate: x.duedate,
            completeddate: x.completeddate,
            activitytaskid: x.activitytaskid,
            activitytaskstatustypekey: x.activitytaskstatustypekey,
            activitytaskdispositiontypekey: x.activitytaskdispositiontypekey,
            tasktype: x.tasktype,
            taskdispositiontypekey: x.taskdispositiontypekey,
            iseditable: x.iseditable,
            isstatustype: x.isstatustype,
            notes: x.notes
        });
    }
    filterHouseHold() {
        this.houseHoldPersonList = this.involvedPersonList.filter(person => person.ishousehold === 1);
      }
    getInvolvedPersonWithPersonID(personid: any) {
        this._commonHttpService
          .getPagedArrayList(
            new PaginationRequest({
              page: 1,
              limit: 200,
              nolimit: true,
              method: 'get',
              where: this.getRequestParam(personid)
            }),
            'People/getallpersonrelationbyprovidedpersonid?filter'
          ).subscribe(response => {
            if (response && Array.isArray(response)) {
              const bilogicalParents = response.filter(element => ((element.relationshiptypekey === 'BGMTHR' || element.relationshiptypekey === 'BGFTHR') && !this.legalGaurdianPersonId.includes(element.person2id)));
              this.parentOrLegalGaurdian = this.parentOrLegalGaurdian.concat(bilogicalParents);
               const caregiver = response.find(element => element.caregiverflag === 1);
               if(caregiver){
               this.caregiversInCase.push(caregiver.person2id);
               }
            }});
      }
    
      getInvolvedPerson() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        let url = '';
        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        this._commonHttpService
          .getPagedArrayList(
            new PaginationRequest({
              page: 1,
              limit: 200,
              nolimit: true,
              method: 'get',
              where: this.getRequestParams()
            }),
            url + '?filter'
          ).subscribe(result => {
            if(result.data && Array.isArray(result.data) && result.data.length > 0){
            result.data.forEach(person => {
               this.involvedPersonList.push(person);
               this.personlistforservicelog.push(person.cjamspid);
               const roles = (Array.isArray(person.roles)) ? person.roles : [];
               const isLegalGaurdian = roles.some((item: { intakeservicerequestpersontypekey: string; }) => ['LG'].includes(item.intakeservicerequestpersontypekey));
                if(isLegalGaurdian){
                this.parentOrLegalGaurdian.push(person);
                this.legalGaurdianPersonId.push(person.personid);
            }
            });
            this.filterHouseHold();
            this.houseHoldPersonList.forEach(element => {
                this.getInvolvedPersonWithPersonID(element.personid);
            });
        }
          });
    
    
      }
      
      getIntakeNumber() {
        const intakeStore = this._dataStoreService.getObj('intake');
        if (intakeStore && intakeStore.number) {
          return intakeStore.number;
        } else {
          return null;
        }
      }
      
      getRequestParams() {
        let inputRequest: any;
        const caseID = this.getCaseUuid();
        const source = this._dataStoreService.getData(AppConstants.GLOBAL_KEY.SOURCE_PAGE);
        switch (source) {
          case AppConstants.MODULE_TYPE.CASE:
            if (this.isServiceCase) {
              inputRequest = {
                objectid: caseID,
                objecttypekey: 'servicecase',
                servicecaseid: caseID
              };
            } else {
              inputRequest = {
                intakeserviceid: caseID
              };
            }
            break;
          case AppConstants.MODULE_TYPE.ADOPTION_CASE:
              inputRequest = {
                intakeserviceid: caseID
              };
            break;
          case AppConstants.MODULE_TYPE.INTAKE:
            inputRequest = {
              intakenumber: this.getIntakeNumber()
            };
            break;
          case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER:
            inputRequest = {
              intakenumber: this._dataStoreService.getData('PROVIDER_ID'),
              providerid: this._dataStoreService.getData('PROVIDER_ID')
            };
            break;
          case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_APPLICATION:
            inputRequest = {
              intakenumber: this._dataStoreService.getData('APPLICANT_NUMBER'),
              applicantNumber: this._dataStoreService.getData('APPLICANT_NUMBER')
            };
            break;
          case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_REFERRAL:
            inputRequest = {
              intakenumber: this._dataStoreService.getData('REFERRAL_NUMBER'),
              referralNumber: this._dataStoreService.getData('REFERRAL_NUMBER')
            };
            break;
          default:
            if (caseID) {
              if (this.isServiceCase) {
                inputRequest = {
                  objectid: caseID,
                  objecttypekey: 'servicecase',
                  servicecaseid: caseID
                };
              } else {
                inputRequest = {
                  intakeserviceid: caseID
                };
              }
            } else if (this.getIntakeNumber()) {
              inputRequest = {
                intakenumber: this.getIntakeNumber()
              };
            }
            break;
        }

        inputRequest['isExpungementSuperUser'] = this._authService.isExpungementSuperUser();
        inputRequest['iscaseexpunged'] = this.iscaseexpunged;
        
        return inputRequest;
      }

      isIntakeMode() {
        return this.getIntakeNumber() ? true : false;
      }

      getSource() {
        if (this.isServiceCase) {
         return AppConstants.CASE_TYPE.SERVICE_CASE;
        } else if (this.isIntakeMode()) {
          return AppConstants.CASE_TYPE.INTAKE;
        } else {
          return AppConstants.CASE_TYPE.CPS_CASE;
        }
      }

      getRequestParam(personid: string) {
        let inputRequest: any;
        const caseID = this.getCaseUuid();
        this.source = this.getSource();
        if (this.isServiceCase) {
          inputRequest = {
            objectid: caseID,
            objecttypekey: 'servicecase',
          };
        } else if (this.isIntakeMode()) {
          inputRequest = {
            intakenumber: this.getIntakeNumber()
          };
         
        } else {
          inputRequest = {
            intakeserviceid: caseID
          };
        }
        if(personid) {
          inputRequest.personid=personid;
        }

        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        inputRequest.isExpungementSuperUser= isExpungementSuperUser;
        inputRequest.iscaseexpunged= this.iscaseexpunged;
        return inputRequest;
      }
    
      findCaregiverContact(){
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this._commonHttpService
                  .getPagedArrayList(
                      new PaginationRequest({
                          page: null,
                          limit: null,
                          nolimit: true,
                          where: {isExpungementSuperUser,iscaseexpunged: this.iscaseexpunged},
                          method: 'get'
                      }),
                      CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetAllDaRecordingUrl + '/' + this.id + '?data'
                  )
                  .subscribe((result) => {
                      const recording = result.data;
                      let contactparticpants = [];
                      let allCaregivers = 0;
                    this.caregiversInCase.forEach( caregiver =>{
                        for(const element of recording){
                            contactparticpants = element.contactparticipant;
                            const caregiverContact = this.getCareGiverContact(contactparticpants, caregiver)
                            if(caregiverContact){
                              allCaregivers++;
                              this.setTaskCount(allCaregivers);
                              break;
                            }
                        }
                    });
                  });
      }

    getCareGiverContact(contactparticpants: any, caregiver: any){
        return contactparticpants ? this.checkcontactparticpants1(contactparticpants, caregiver): null;
    }

    checkcontactparticpants1(contactparticpants: any, caregiver: any){
        return Array.isArray(contactparticpants) ? this.checkcontactparticpants2(contactparticpants, caregiver): null
    }

    checkcontactparticpants2(contactparticpants: any, caregiver: any){
        return (contactparticpants.length > 0) ? contactparticpants.find((particpant: { personid: any; }) => particpant.personid === caregiver): null
    }


    setTaskCount(allCaregivers: any) {
        if (allCaregivers === this.caregiversInCase.length) {
            this.isCaregiverContactComplete = true;
            this.kinshipChecklist.forEach(item => {
                if (item.key === 'initialContactCaregiver') {
                    item.value = this.isCaregiverContactComplete;
                    if (item.value) {
                        this.openTasks--;
                        this.closedTasks++;
                    }
                }
            });
        }
    }

      getAssessments() {        
        let inputRequest: Object;
        if (this.isServiceCase) {
            inputRequest = {
                objecttypekey: 'servicecase',
                objectid: this.id
            };
        } else {
            const isExpungementSuperUser = this._authService.isExpungementSuperUser();
            inputRequest = {
                servicerequestid: this.id,
                categoryid: null,
                subcategoryid: null,
                targetid: null,
                assessmentstatus: null,
                isExpungementSuperUser:isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            };
        }
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    nolimit: true,
                    where: inputRequest,
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.ListAssessment + '?filter'
            )
            .subscribe(result => {
                const list = result.data;
                const safec = list.filter(item => item.description.toUpperCase() === 'SAFE-C');
                let safecList = safec && safec.length && safec[0].intakassessment ? safec[0].intakassessment : [];
                safecList = safecList.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey === 'Accepted');
                const safecohp = list.filter(item => item.description.toUpperCase() === 'SAFE-C OHP');
                let safecohpList = safecohp && safecohp.length && safecohp[0].intakassessment ? safecohp[0].intakassessment : [];
                safecohpList = safecohpList.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey === 'Accepted');
                let isSafeAssDone = false;
                if (safecohpList.length > 0 || safecList.length > 0)
                {
                    isSafeAssDone = true;
                }
                const ismifradone = this.assessmentCompletion(list, 'MFIRA');
                this.isSaftyAssessmentDone= isSafeAssDone;
                this.isMFIRAAssessmentDone = ismifradone;
                this.updateTaskCounts();
              });
      }

    updateTaskCounts() {
        this.kinshipChecklist.forEach(item => {
            if (item.key === 'saftyAssessments') {
                item.value = this.isSaftyAssessmentDone;
                if (item.value) {
                    this.openTasks--;
                    this.closedTasks++;
                }
            }
            else if (item.key === 'mfira') {
                item.value = this.isMFIRAAssessmentDone;
                if (item.value) {
                    this.openTasks--;
                    this.closedTasks++;
                }
            }
        });
    }
    
    assessmentCompletion(list: any, assessmentname: any) {
        const assessment = list.find((item: { description: string; }) => item.description.toUpperCase() === assessmentname);
        let submissionlist = assessment && Array.isArray(assessment.intakassessment) ? assessment.intakassessment : [];
        submissionlist = submissionlist.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey === 'Accepted');
        return (submissionlist.length > 0);
    }
    
    getServicePlans() {
        const payload = {
          method: 'get',
          where: {
            caseid : this.getCaseUuid()
          }
        };
        this._commonHttpService.getArrayList(payload, 'serviceplan/listbyallrelation?filter').subscribe(
          response => {
              if (response && response.length && response.length !== 0) {
                this.isServicePlanPresent = true;
                this.kinshipChecklist.forEach(item => {
                    if(item.key === 'serviceplan'){
                        item.value = this.isServicePlanPresent;
                        if(item.value){
                            this.openTasks--;
                            this.closedTasks++;
                        }
                    }
                });
              }
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

    getServiceLogList(cids: any) {
        return this._commonHttpService.getArrayList(
          {
            where: { daNumber: this.daNumber, client_id: cids },
            method: 'get',
            nolimit: true
          },
          CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.servicelogmultipelist + '?filter'
        );
    }

    getVendorList(personlist: any) {

        return this._commonHttpService.getArrayList(
            {
                where: { daNumber: this.daNumber, clientid: personlist, nolimit: true },
                method: 'get'
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.multivendorServiceLog + '?filter'
        );
    }

    checkallservicelog() {
        let vendorlist: any[] = [];
        let agencylist: any[] = [];
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        const slsource = this.getServiceLogList(this.personlistforservicelog);
        const vssource = this.getVendorList(this.personlistforservicelog);
        vssource.subscribe((data: any) => {
          vendorlist = data['servicelogData'];
                          });
        slsource.subscribe((data: any) => {
          const list = Array.isArray(data['servicelogData']) ? data['servicelogData'] : [];
          agencylist = list;
                           });
        setTimeout(()=>{ 
        if (vendorlist && agencylist) {
            let agencylistcompleted = false;
            let vendorlistcompleted = false;
            if (agencylist.length) {
                const valid = agencylist.some(item => item.actual_end_date === null);
                agencylistcompleted = !valid;
            } else {
                agencylistcompleted = true;
            }
      
            if (vendorlist.length) {
                const valid = vendorlist.some(item => item.actual_end_date === null);
                vendorlistcompleted = !valid;
            } else {
                vendorlistcompleted = true;
            }
            if (vendorlistcompleted && agencylistcompleted){
            this.servicelogcompleted = true;
            }else{
              this.servicelogcompleted = false;
            }
            this.taskcountUpdate();
        }
    }, 3000);
    }

    taskcountUpdate() {
        this.kinshipChecklist.forEach(item => {
            if (item.key === 'servicelog') {
                item.value = this.servicelogcompleted;
                if (item.value) {
                    this.openTasks--;
                    this.closedTasks++;
                }
            }
        });
    }

    listAffidavit() {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    where: { objectid: this.id },
                    method: 'post'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Affidavit.List
            )
            .subscribe((result) => {
                if(result && Array.isArray(result) && result.length > 0){
                  this.isKinshipNavigationTransitionLetterPresent = true;
                  
                this.kinshipChecklist.forEach(item => {
                    if(item.key === 'kinshipnavigatorletter'){
                        item.value = this.isKinshipNavigationTransitionLetterPresent;
                        if(item.value){
                        this.openTasks--;
                        this.closedTasks++;
                        }
                    }
                });
                }
            });
    
    }

    checkHouseHoldPersonDemographicInfo(){
        if (this.houseHoldPersonList && Array.isArray(this.houseHoldPersonList)) {
          const personInfo = this.houseHoldPersonList.find(person => person.age === null || person.gender === null || ((Array.isArray(person.race) && person.race.length === 0) && person.ethinicity === null));
          this.houseHoldPersonDemographicInfo = personInfo ? false : true;
          this.kinshipChecklist.forEach(item => {
            if(item.key === 'familyDemographics'){
                item.value = this.houseHoldPersonDemographicInfo;
                if(item.value){
                    this.openTasks--;
                    this.closedTasks++;
                }
            }
        });
        } 
    }
    checkLegalGaurdianDemographicInfo(){
        if (this.parentOrLegalGaurdian && Array.isArray(this.parentOrLegalGaurdian)) {
          const personInfo = this.parentOrLegalGaurdian.find(person => person.age === null || person.gender === null || ((Array.isArray(person.race) && person.race.length === 0) && person.ethinicity === null));
          this.parentOrLegalGaurdianDemographicInfo = personInfo ? false : true;
          this.kinshipChecklist.forEach(item => {
            if(item.key === 'parentDemographics'){
                item.value = this.parentOrLegalGaurdianDemographicInfo;
                if(item.value){
                    this.openTasks--;
                    this.closedTasks++;
                }
            }
        });
        } 
    }

    loadKinshipChecklists(){
    this.findCaregiverContact();
    this.checkHouseHoldPersonDemographicInfo();
    this.checkLegalGaurdianDemographicInfo();
    this.getAssessments();
    this.getServicePlans();
    this.checkallservicelog();
    }

    addTask(i: number) {
        const val = this.activityTaskStatusFormGroup.value.task[i];
        if (val.activitytaskstatustypekey === 'InvOpen') {
            this._alertService.warn('Please fill Details');
            return true;
        } else {
            if (!val.notes) {
                this._alertService.warn('Please fill Notes');
                return true;
            }
            if (!val.completeddate) {
                this._alertService.warn('Please fill completed date');
                return true;
            }
            this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.ActivitySaveUrl;
            let requestData = this.activityTaskStatusFormGroup.value.task
                .filter((item: { activitytaskid: any; }) => item.activitytaskid === val.activitytaskid)
                .map((item: any) => this.updateTaskMapRequest(item));
            requestData = {
                intakeserviceid: this.id,
                task: requestData
            };
            this._service.create(requestData).subscribe(
                (response: any) => {
                    if (response) {
                        this.updateTaskResponse();
                    }
                },
                (error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    saveTask() {
        const validateCompleteDate = this.activityTaskStatusFormGroup.value.task.filter((res: { completeddate: any; }) => res.completeddate);
        let isvalidCompleteDate = true;
        let isvalidDispostionClosedScenario = true;
        validateCompleteDate.forEach((element: any) => {
            const completedate = new Date(element.completeddate).setHours(0, 0, 0, 0);
            const Assigneddate = new Date(element.assignedon).setHours(0, 0, 0, 0);
            if (completedate < Assigneddate) {
                isvalidCompleteDate = false;
            }
            if (element.taskdispositiontypekey == "Completed") {
                if (element.activitytaskstatustypekey != "InvClosed") {
                    isvalidDispostionClosedScenario = false;
                }
            }
        });
        if (!isvalidCompleteDate) {
            this._alertService.warn('Please provide valid completed date.');
            return;
        }
        if (!isvalidDispostionClosedScenario) {
            this._alertService.warn('Please provide valid status and disposition.');
            return;
        }

        const agency = this._authService.getAgencyName();
        let toSaveTasks = false;
        if (agency === 'CW') {
            toSaveTasks = validateCompleteDate.length > 0 ? true : false;
        } else if (agency === 'AS') {
            toSaveTasks = true;
        }

        this.updateTask(toSaveTasks);
    }

    updateTaskMapRequest(item: any){
        return {
            activitytaskid: item.activitytaskid,
            activitytaskstatustypekey: item.activitytaskstatustypekey,
            activitytaskdispositiontypekey: item.activitytaskdispositiontypekey,
            completeddate: item.completeddate,
            taskdispositiontypekey: item.taskdispositiontypekey,
            duedate: item.duedate,
            notes: this.isDJS ? item.notes : ''
        };
    }

    updateTaskResponse(){
        this._alertService.success('Task updated successfully');
        this.getInvestigationPlanSummary(this.investigationId);
        this.getActivityTask(1, this.investigationId);
    }

    updateTask(toSaveTasks: any){
        if (toSaveTasks) {
            this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.ActivitySaveUrl;
            let requestData = this.activityTaskStatusFormGroup.value.task
                .filter((item: { activitytaskstatustypekey: string; completeddate: any; }) => (item.activitytaskstatustypekey === 'InvClosed' && item.completeddate) || item.activitytaskstatustypekey !== 'InvClosed')
                .map((item: any) => this.updateTaskMapRequest(item));
            requestData = {
                intakeserviceid: this.id,
                task: requestData
            };
            this._service.create(requestData).subscribe(
                (resp: any) => {
                    if (resp) {
                      this.updateTaskResponse();
                    }
                },
                (error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._alertService.warn('Please fill completed date');
        }
    }

    checkDateRange(activityTaskFormGroup: any) {
        if (activityTaskFormGroup.controls.duedate.value) {
            if (activityTaskFormGroup.controls.insertedon.value > activityTaskFormGroup.controls.duedate.value) {
                return { notValid: true };
            }
            return null;
        }
    }
    checkCompletedDate(activityTaskFormGroup: any) {
        if (new Date(activityTaskFormGroup.controls.assignedon.value) > new Date(activityTaskFormGroup.controls.completeddate.value)) {
            return { notValidCompletedDate: true };
        }
    }
    searchByActivity() {
        this.statusSearchForTask = false;
        this.investigationPlanSearchFormGroup.get('taskname')?.disable();
        this.investigationPlanSearchFormGroup.get('taskagainst')?.disable();
        this.investigationPlanSearchFormGroup.patchValue({ taskname: '' });
        this.investigationPlanSearchFormGroup.get('activityname')?.enable();
    }
    searchByTask() {
        this.statusSearchForTask = true;
        this.investigationPlanSearchFormGroup.get('activityname')?.disable();
        this.investigationPlanSearchFormGroup.patchValue({ activityname: '' });
        this.investigationPlanSearchFormGroup.get('taskname')?.enable();
        this.investigationPlanSearchFormGroup.get('taskagainst')?.enable();
        this.getTaskTypeDropdown('Investigation');
        this.taskTypeStatusDropdown('Investigation');
    }
    taskSearchBy(tasksearchby: any) {
        this.getTaskTypeDropdown(tasksearchby);
        this.taskTypeStatusDropdown(tasksearchby);
    }
    clearInvestigationSearch() {
        this.investigationPlanSearchFormGroup.patchValue({ invesplansearch: 'Activity', taskname: '', activityname: '', statustype: '' });
        this.searchByActivity();
        this.statusSearchForTask = false;
        this.getActivityTask(1, this.investigationId);
        this.getActivityGoal(this.investigationId);
    }
    searchInvestigationPlan() {
        this.getActivityTask(1, this.investigationId);
        this.getActivityGoal(this.investigationId);
    }
    getActionSummary() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this.dsdsActionsSummary$ = this._commonHttpService
            .getById(this.daNumber + `?isExpungementSuperUser=${isExpungementSuperUser}&iscaseexpunged=${this.iscaseexpunged}`, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).pipe(
            map((res) => {
                return res[0];
            }),
            share(),);
        this.dsdsActionsSummary$.subscribe((response) => {
            if (!response) {
                return;
            }
            this.investigationId = response['da_investigationid']  ? response['da_investigationid'] : this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
            this.caseStatus = response['da_status'] === 'Closed' ? 'hide' : '';
            this.pageSubject$.subscribe((pageNumber) => {
                this.paginationInfo.pageNumber = pageNumber;
                this.getActivityTask(this.paginationInfo.pageNumber, this.investigationId);
            });
            this.getActivityTask(1, this.investigationId);
            this.getActivityGoal(this.investigationId);
            this.getInvestigationPlanSummary(this.investigationId);
            return response;
        });
    }

    getInvestigationPlanSummary(investigationid: any) {
        this.investigationPlanCaseCount$ = this._planSummaryService
            .getPagedArrayList(
                {
                    method: 'get',
                    where: {
                        investigationid: this.isServiceCase ?  this.getInvestigationId(investigationid) : investigationid
                    }
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.PlanSummaryUrl + '?data'
            ).pipe(
            map((result) => {
                return result.data[0];
            }),
            share(),);
    }

    getInvestigationId(investigationid: any){
        return this.dsdsActionsSummary.da_investigationid ? this.dsdsActionsSummary.da_investigationid : investigationid;
    }
    serachByActivityId(goal: any) {
        this.clearInvestigationSearch();
        this.activityGoal = Object.assign({}, goal);
        this.investigationPlanSearchFormGroup.patchValue({
            activityname: this.activityGoal.activityid
        });
        this.getActivityTask(1, this.investigationId);
    }
    sortactivity() {
        this.getActivityTask(1,this.investigationId);
    }

    resetSelectedActionType() {
        this.sortBy = false;
        this.selectedActionType = null;
        this.sortCategoryForm.controls['sortBy'].reset();
        this.getActivityTask(1,this.investigationId);
    }
    getActivityTask(page: number, investigationid: any) {
        this.paginationInfo.pageNumber = page;
        this.setTaskStatus();
        const requestParam = this.getRequestparm(investigationid);
        const source = this._taskService
            .getPagedArrayList(
                {
                    method: 'get',
                    where: requestParam,
                    limit: 15,
                    page: this.paginationInfo.pageNumber
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.ActivityTaskUrl + '?data'
            ).pipe(
            map((result) => {
                return {
                    data: result.data,
                    count: result.count,
                    canDisplayPager: result.count > this.paginationInfo.pageSize
                };
            }),
            share(),);
        this.activityTask$ = source.pipe(pluck('data'));
        this.activityTask$.subscribe((res) => {
            if (res && res.length) {
                res.forEach((item) => {
                    if (!item.activitytypekey) {
                        item.activitytypekey =  'Investigation';
                    }
                    if (item.activitytaskstatustypekey === 'InvClosed') {
                        item.isstatustype = false;
                    } else {
                        item.isstatustype = true;
                    }
                    return res;
                });
            }
            this.setActivitytasks(res);
            this._dataStoreService.setData('ACTIVITY_TASK', this.activityTasks, true, 'ACTIVITY_TASK_LOAD');
            this.setFormValues(1);
            const statusCalls = [];
            for (const id of res) {
                statusCalls.push(this.taskTypeStatusDropdown(id.activitytypekey).pipe(share()));
            }
            this.forkedResult$ = forkJoin(statusCalls);
        });
        if (page === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    setTaskStatus(){
        this.taskstatus = null;
        if (this.investigationPlanSearchFormGroup.value.invesplansearch === 'Task') {
            if (this.investigationPlanSearchFormGroup.value.statustype === '') {
                if (this.investigationPlanSearchFormGroup.value.taskagainst === 'Allegation') {
                    this.taskstatus = 'alleg';
                } else {
                    this.taskstatus = 'inv';
                }
            } else {
                this.taskstatus = this.investigationPlanSearchFormGroup.value.statustype;
            }
        } else {
            this.taskstatus = this.investigationPlanSearchFormGroup.value.statustype ? this.investigationPlanSearchFormGroup.value.statustype : null;
        }
    }
    getRequestparm(investigationid: any){
        let requestParam;
        if (this.isServiceCase) {
            requestParam = { objectid: this.id, objecttypekey: 'servicecacse', sortBy: this.sortCategoryForm.value.sortBy,
            sortDir: this.sortCategoryForm.value.sortDir };
        } else {
            requestParam = {
                investigationid: this.isServiceCase ? this.dsdsActionsSummary.da_investigationid : investigationid,
                activitiesid: this.investigationPlanSearchFormGroup.value.activityname ? this.investigationPlanSearchFormGroup.value.activityname : null,
                taskid: this.investigationPlanSearchFormGroup.value.taskname ? this.investigationPlanSearchFormGroup.value.taskname : null,
                taskstatus: this.taskstatus,
                sortBy: this.sortCategoryForm.value.sortBy,
                sortDir: this.sortCategoryForm.value.sortDir
            };
        }
        return requestParam;
    }
    setActivitytasks(res: any){
        if (res && res.length) {
            this.activityTasks = res.map((item: { taskdescription: string; iseditable: boolean; }) => {
                if (item.taskdescription === 'Project Home Registered Nurse Consultant Assessment  Quarterly/Interim Review') {
                    item.iseditable = true;
                }
                return item;
            });
        } else {
            this.activityTasks = [];
        }
    }
    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageSubject$.next(this.paginationInfo.pageNumber);
    }

    getActivityGoal(investigationid: any) {
        const source = this._goalsService
            .getPagedArrayList(
                {
                    method: 'get',
                    where: {
                        investigationid: investigationid,
                        activitiesid: this.investigationPlanSearchFormGroup.value.activityname ? this.investigationPlanSearchFormGroup.value.activityname : null,
                        goalid: null
                    },
                    page: 1,
                    limit: 10
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.ActivityGoalUrl + '?data'
            ).pipe(
            share());
        this.activityGoal$ = source.pipe(pluck('data'));
    }

    loadDropdown() {
      this.sortDropDown = [ { 'value': 'task', 'text': 'Sort By Task' },
                            { 'value': 'duedate', 'text': 'Sort By Due Date' }
                            ];
        this.activityDropdownItems$ = EMPTY;
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: 1, activitytypekey: 'Investigation' },
                    order: this.orderbyfield,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.ActivityGoalTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: 1, activitytypekey: 'Investigation' },
                    order: this.orderbyfield,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.ActivityGoalStatusTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    nolimit: true,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.UserProfilekUrl + '?filter'
            )
        ]).pipe(
            map((result) => {
                return {
                    goaltype: result[0].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.activitygoaltypekey
                            })
                    ),
                    goalstatus: result[1].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.activitygoalstatustypekey
                            })
                    ),
                    usersProfile: result[2].map(
                        (res) =>
                            new DropdownModel({
                                text: res.displayname,
                                value: res.loadnumber
                            })
                    )
                };
            }),
            share(),);
        this.goalTypeDropdownItems$ = source.pipe(pluck('goaltype'));
        this.goalStatusTypeDropdownItems$ = source.pipe(pluck('goalstatus'));
        this.activityDropdownItems$ = source.pipe(
            pluck('activity'),
            map((items:any) => items as DropdownModel[])
          );
        this.usersProfileDropdownItems$ = source.pipe(pluck('usersProfile'));
    }
    getActivityDropdown() {
        this.activityDropdownItems$ = EMPTY;
        this.activityDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.InvestigationActivitiesUrl + '/' + this.id + '?filter'
            ).pipe(
            map((result: any) => {
                return result['investigation'][0]['activity'].map(
                    (res: { description: any; activityid: any; }) =>
                        new DropdownModel({
                            text: res.description,
                            value: res.activityid
                        })
                );
            }));
    }
    getDispositionStatus() {
        this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    where: {
                        referencetypeid: 24,
                        teamtypekey: 'AS'
                    }
                },
                'referencetype/gettypes' + '?filter'
            )
            .subscribe((item: any) => {
                this.dispositionStatusDetails = item;
            });
    }
    getTaskTypeDropdown(activitytypekey: any) {
        this.taskDropdownItems$ = EMPTY;
        this.taskDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: { activeflag: 1, activitytypekey: activitytypekey },
                    order: this.orderbyfield,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.ActivityAllTaskUrl + '?filter'
            ).pipe(
            map((result) => {
                return result.map(
                    (res) =>
                        new DropdownModel({
                            text: res.typedescription,
                            value: res.activitytasktypekey
                        })
                );
            }),
            share(),);
    }
    taskTypeStatusDropdown(activitytypekey: any) {
        return this._commonHttpService
            .getArrayList(
                {
                    where: { activeflag: 1, activitytypekey: activitytypekey },
                    order: this.orderbyfield,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.TaskStatusTypeUrl + '?filter'
            ).pipe(
            map((result) => {
                return result.map(
                    (res) =>
                        new DropdownModel({
                            text: res.typedescription,
                            value: res.activitytaskstatustypekey
                        })
                );
            }));
    }

    getGoalDisposition(goaltypekey: any, goalstatustypekey: any) {
        this.activityGoalsFormGroup.patchValue({
            disposition: ''
        });
        this.dispositionDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        activitygoaltypekey: goaltypekey,
                        activitygoalstatustypekey: goalstatustypekey,
                        activitytypekey: 'Investigation'
                    },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.GoalDispositionUrl + '?filter'
            ).pipe(
            map((result) => {
                return result.map(
                    (res) =>
                        new DropdownModel({
                            text: res.typedescription,
                            value: res.activitygoaldispositiontypekey
                        })
                );
            }));
    }
    changeGoalStatusType() {
        this.getGoalDisposition(this.activityGoalsFormGroup.value.goalType, this.activityGoalsFormGroup.value.status);
    }
    getTaskDisposition(tasktypekey: any, taskstatustypekey: any) {
        return this._commonHttpService
            .getArrayList(
                {
                    where: {
                        activitytasktypekey: tasktypekey,
                        activitytaskstatustypekey: taskstatustypekey,
                        activitytypekey: 'Investigation'
                    },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.InvestigationDispositionUrl + '?filter'
            ).pipe(
            map((result) => {
                return result.map(
                    (res) =>
                        new DropdownModel({
                            text: res.typedescription,
                            value: res.activitytaskdispositiontypekey
                        })
                );
            }));
    }
    changeTaskStatusType() {
        this.getTaskDisposition(this.activityTask.activitytasktypekey, this.activityTaskFormGroup.value.activitytaskstatustypekey);
    }

    editGoal(currentGoal: any, editStatus: any) {
        this.activityGoal = Object.assign({}, currentGoal);
        if (editStatus === 1) {
            this.editLabel = 'Edit';
            this.populateActivityGoal(currentGoal);
            ControlUtils.enableElements($(this.investigationpopupid).children());
        } else {
            this.editLabel = 'View';
            this.populateActivityGoal(currentGoal);
            ControlUtils.disableElements($(this.investigationpopupid).children(), ['btnClose']);
        }
    }
    populateActivityGoal(_goal: any) {
        this.getGoalDisposition(this.activityGoal.activitygoaltypekey, this.activityGoal.activitygoalstatustypekey);
        this.activityGoalsFormGroup.patchValue({
            goal: this.activityGoal.goal,
            activitygoalid: this.activityGoal.activitygoalid,
            goalType: this.activityGoal.activitygoaltypekey,
            required: this.activityGoal.required,
            duedate: new Date(this.activityGoal.duedate),
            status: this.activityGoal.activitygoalstatustypekey,
            disposition: this.activityGoal.activitygoaldispositiontypekey,
            completiondate: new Date(this.activityGoal.completiondate)
        });
        if (!this.activityGoal.completiondate) {
            this.activityGoalsFormGroup.patchValue({
                completiondate: this.activityGoal.completiondate
            });
        }
    }
    updateGoal() {
        this.activityGoal = Object.assign({}, new ActivityGoalModal());
        this.activityGoal.activitygoalid = this.activityGoalsFormGroup.value.activitygoalid;
        this.activityGoal.completiondate = this.activityGoalsFormGroup.value.completiondate;
        this.activityGoal.activitygoalstatustypekey = this.activityGoalsFormGroup.value.status;
        this.activityGoal.activitygoaldispositiontypekey = this.activityGoalsFormGroup.value.disposition;
        this.activityGoal.duedate = this.activityGoalsFormGroup.value.duedate;
        this._goalsService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.GoalUpdateUrl;
        this._goalsService.patch(this.activityGoal.activitygoalid, this.activityGoal).subscribe(
            (response: any) => {
                if (response) {
                    this._alertService.success('Goal updated successfully');
                   $(this.investigationpopupid).modal('hide');
                    this.getActivityTask(1, this.investigationId);
                    this.getActivityGoal(this.investigationId);
                }
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    enableAssignedTo() {
        this.activityTaskFormGroup.get('loadnumber')?.enable();
        this.activityTaskFormGroup.get('assignedon')?.enable();
    }
    editActivityTask(currentTask: any, editStatus: any) {
        this.activityTask = Object.assign({}, currentTask);
        if (editStatus === 1) {
            this.editLabel = 'Edit';
            this.populateActivityTask(currentTask);
            ControlUtils.enableElements($(this.goalspopupid).children());
            this.activityTaskFormGroup.get('activitytaskstatustypekey')?.enable();
            this.activityTaskFormGroup.get('activitytaskdispositiontypekey')?.enable();
        } else {
            this.editLabel = 'View';
            this.populateActivityTask(currentTask);
            ControlUtils.disableElements($(this.goalspopupid).children(), ['btnClose']);
            this.activityTaskFormGroup.get('activitytaskstatustypekey')?.disable();
            this.activityTaskFormGroup.get('activitytaskdispositiontypekey')?.disable();
        }
    }
    populateActivityTask(currentTask: any) {
        if (currentTask.tasktype === 'Contact') {
            this.activityTaskFormGroup.get('loadnumber')?.disable();
            this.showTime = true;
            if (this.activityTask.startdatetime !== null) {
                (this.startdate = new Date(this.activityTask.startdatetime).toLocaleDateString());
                    (this.starttime = new Date(this.activityTask.startdatetime).getHours() + ':' + new Date(this.activityTask.startdatetime).getMinutes());
                    (this.starttimeformat = new Date(this.activityTask.startdatetime).getHours() >= 12 ? 'PM' : 'AM');
            }
            if (this.activityTask.enddatetime !== null) {
                (this.enddate = new Date(this.activityTask.enddatetime).toLocaleDateString());
                    (this.endtime = new Date(this.activityTask.enddatetime).getHours() + ':' + new Date(this.activityTask.enddatetime).getMinutes());
                    (this.endtimeformat = new Date(this.activityTask.enddatetime).getHours() >= 12 ? 'PM' : 'AM');
            }
        } else {
            this.showTime = false;
        }
        this.getTaskTypeDropdown(this.activityTask.activitytypekey);
        this.taskTypeStatusDropdown(this.activityTask.activitytypekey);
        this.getTaskDisposition(this.activityTask.activitytasktypekey, this.activityTask.activitytaskstatustypekey);
        this.activityTaskFormGroup.patchValue(this.activityTask);
        if (currentTask.tasktype === 'Contact') {
            this.activityTaskFormGroup.patchValue({
                startdate: this.startdate,
                starttime: this.starttime,
                starttimeformat: this.starttimeformat,
                enddate: this.enddate,
                endtime: this.endtime,
                endtimeformat: this.endtimeformat,
                insertedon: new Date(this.activityTask.insertedon)
            });
        }
    }
    updateActivityTask() {
        if (this.activityTaskFormGroup.dirty && this.activityTaskFormGroup.valid) {
            this.activityTask = Object.assign({}, this.activityTaskFormGroup.value);
            this.activityTask.assignedto = this.activityTaskFormGroup.value.loadnumber;
            if (this.activityTaskFormGroup.value.startdate) {
                this.activityTask.startdatetime = this.datePipe.transform(this.activityTaskFormGroup.value.startdate, 'yyyy-MM-dd') + ' ' + this.activityTaskFormGroup.value.starttime;
                this.activityTask.enddatetime = this.datePipe.transform(this.activityTaskFormGroup.value.enddate, 'yyyy-MM-dd') + ' ' + this.activityTaskFormGroup.value.endtime;
            }
            ObjectUtils.removeEmptyProperties(this.activityTask);
            this.activityTask.required = this.activityTaskFormGroup.get('required')?.value;
            this._taskService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.ActivityTaskUpdateUrl;
            this._taskService.patch(this.activityTaskFormGroup.value.activitytaskid, this.activityTask).subscribe(
                (response: any) => {
                    if (response) {
                        this._alertService.success('Activity Task updated successfully');
                       $(this.goalspopupid).modal('hide');
                        this.getActivityTask(this.paginationInfo.pageNumber, this.investigationId);
                        this.getActivityGoal(this.investigationId);
                        this.getInvestigationPlanSummary(this.investigationId);
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._alertService.error('Please fill mandatory fields');
        }
    }
    routeToChecklist(da_investigationid: any) {
        const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/investigation-plan/plan-suggested/' + da_investigationid;
        this._router.navigate([currentUrl]);
    }
    navigateToTask(type: string) {
        if (type === 'Assessment') {
            $('#adultassessmentsTab').click();
        }
        if (type === 'Placement') {
            $('#placementTab').click();
        }
    }

    getControlByIndexFn(index: string): FormControl {
        return this.activityTaskFormGroup.controls[index] as FormControl;
    }

    get taskFormArrayList(): FormArray {
        return this.activityTaskStatusFormGroup.get('task') as FormArray;
    }
}
