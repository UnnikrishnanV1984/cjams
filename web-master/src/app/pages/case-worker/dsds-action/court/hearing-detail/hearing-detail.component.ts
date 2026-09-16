
import {pluck, share, map} from 'rxjs/operators';
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormArray } from '@angular/forms';
import moment from 'moment';
import { Observable ,of as observableOf,  forkJoin } from 'rxjs';
import _ from 'lodash';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, DataStoreService, CommonDropdownsService, SessionStorageService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { CourtAction, PetitionList } from '../_entities/court.data.model';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { CourtResolverService } from '../court-resolver-service';

const PETITION_ID_UPDATE_WINDOW = 30;
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'hearing-detail',
    templateUrl: './hearing-detail.component.html',
    styleUrls: ['./hearing-detail.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    standalone: false
})
export class HearingDetailComponent implements OnInit {
    offenceCategories$!: Observable<DropdownModel[]>;
    courtActionsType$!: Observable<DropdownModel[]>;
    conditionTypes$!: Observable<DropdownModel[]>;
    courtOrder$!: Observable<DropdownModel[]>;
    findingsType$!: Observable<DropdownModel[]>;
    adijuctedDecisions$!: Observable<DropdownModel[]>;
    hearingStatusTypeItem$!: Observable<DropdownModel[]>;
    hearingType$!: Observable<DropdownModel[]>;
    stateList$!: Observable<DropdownModel[]>;
    countyList$!: Observable<DropdownModel[]>;
    courtDetailsForm!: FormGroup;
    hearingForm!: FormGroup;
    userInfo!: AppUser;
    times: any[] = [];
    hours: any[] = [];
    mins: any[] = [];
    meridiem: any[] = [];
    modalInt!: number;
    isPetitionFilled!: boolean;
    isUpcomingHearing!: boolean;
    id!: string;
    maxDate: any;
    courtDetails: any;
    courtAction: CourtAction[] = [];
    petitionDetails: PetitionList = new PetitionList();
    hearingData: any[] = [];
    hearingstatustypeArray: any[] = [];
    daNumber!: string;
    hearingDetails: any[] = [];
    courtActionDescription: any[] = [];
    courtOrderDescription: any[] = [];
    courtConditionnDescription: any[] = [];
    hearingtypeArray: any[] = [];
    reportMode!: string;
    editMode!: boolean;
    hearingId!: string;
    datechangeofpermanency:any;
    hearingIndexselected!: number;
    isHearingDetailsForm!: boolean;
    petitonListDetails: PetitionList = new PetitionList();
    petitionInfo!: PetitionList[];
    isNextHearingScheduled = false;
    hearingDetailAlert: any;
    hearingTypeList: any[] = [];
    selectedPetionDate: any;
    hearingMaxDate!: Date | null;
    isClosed = false;
    savenexthearingflag = false;
    viewEditLabel!: string;
    //court numbers
    //court numbers
    courtNumbersForm!: FormGroup;
    courtcasenumbers: any[] = [];
    personList: any[] = [];
    showCourtNumbersForm = false;
    deleteCourtNumberId!: string;
    isDeleteDisabled = false;
    isEditDisabled = false;
    selectedPersonName = '';

    //hearing clients
    hearingDetailsInfo: any;
    intakeservicereqid = 'deda9fed-a731-4151-ab8b-5f6cef7b60c4';
    filteroptn = '?filter={"nolimit":true}';
    deletecourthearingpopupid = '#deleteCourtHearing';
    deletecourtnopopupid = '#deleteCourtNumber';
    masterParentDetails: any[] = [];
    isTPR : boolean = false;
    isReadonly = false;
    displayValidationMessages = false;
    iscaseexpunged: any = 0;
    private readonly _commonHttpService: CommonHttpService;
    private readonly _formBuilder: FormBuilder;
    public _authService: AuthService;
    private readonly _datastore: DataStoreService;
    private readonly _alertService: AlertService;
    private readonly storage: SessionStorageService;
    private cdr: ChangeDetectorRef;

    constructor(
        private injector: Injector,
        private readonly _commonDDservice: CommonDropdownsService,
        private readonly _courtResolverService: CourtResolverService,
    ) {
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._datastore = this.injector.get<DataStoreService>(DataStoreService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
    }

    ngOnInit() {
        this.iscaseexpunged = this._datastore.getData('iscaseexpunged');
        this.maxDate = new Date();
        this.isDeleteDisabled = this._authService.isDisabled('court','court.hearingdetails.delete');
        this.isEditDisabled = this._authService.isDisabled('court','court.hearingdetails.edit');
        this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);

        this.modalInt = -1;
        this.reportMode = 'add';
        this.isPetitionFilled = false;
        this.editMode = true;
        this.userInfo = this._authService.getCurrentUser();
        this.hearingId = '';
        this.initiateFormGroup();

        this.initCourtNumbersForm();
        this.getCourtCaseNumbers();

        this.getPersons();
        this.gethearingDetails();
        this.getPetitionDetails();
        this.loadDroddowns();
        this.times = this._courtResolverService.generateTimeList(false);

        this.isClosed = this._authService.iscaseclosed('courthearing');
        const activeModuleRole = this.storage.getItem('activeModuleRole');
        if (activeModuleRole === 'CJAMS_SSA_FTDM_FACILITATOR' ||
         activeModuleRole === 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole === 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
          this.isReadonly = false;
        } else {
        this.isReadonly =  this._authService.readonlyButton('read_only_access','caseworker-court-case-numbers');}
    }

initiateFormGroup() {
    this.courtDetailsForm = this._formBuilder.group({
        legalcounselname: [''],
        intakeservicerequestid: [''],
        hearingtypekey: [''],
        hearingtype: ['', Validators.required],
        datenoticehearing: [' '],
        changeofpermanency: [],
        hearingdatetime: [''],
        hearingDate: [''],
        hearingTime: ['08:00', Validators.required],
        statekey: [''],
        countyid: null,
        focusname: [''],
        judgename: [''],
        hearingstatustypekey: ['', Validators.required],
        hearingdetails: this.hearingDetails,
        hearingnotes: [''],
        intakeservicerequestpetitionid: null,
        nofurtherinvolvementflag: [false],
        exceptionappealfiledflag: [false],
        exceptionappealflag: [false],
        nexthearingdate: [''],
        nexthearingtime: ['08:00'],
        nexthearingtype: [''],
        hearingClients: this._formBuilder.array([]),
        hearingParents: this._formBuilder.array([])
    });

    this.hearingForm = this._formBuilder.group({
        legalcounselname: null,
        intakeservicerequestid: [''],
        hearingtypekey: [''],
        hearingtype: ['', Validators.required],
        datenoticehearing: [' '],
        changeofpermanency: [],
        hearingdatetime: ['08:00'],
        hearingDate: ['', Validators.required],
        hearingTime: ['', Validators.required],
        statekey: null,
        countyid: null,
        focusname: null,
        judgename: null,
        hearingstatustypekey: null,
        hearingnotes: null,
        intakeservicerequestpetitionid: [null, Validators.required],
        hearingClients: this._formBuilder.array([]),
        hearingParents: this._formBuilder.array([])
    });
}


    initCourtNumbersForm() {
        this.courtNumbersForm = this._formBuilder.group({
            courtnumberid: null,
            personid: null,
            courtcaseno: [''],
            startdate: null,
            enddate: null
        });
    }

    getPersons() {
        let inputRequest = {};
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        if (isServiceCase) {
            inputRequest = {
                objectid: this.id,
                objecttypekey: 'servicecase'
            };
        } else {
            inputRequest = {
                intakeserviceid: this.id
            };
        }
        const payload = {
            method: 'get',
            count: -1,
            page: 1,
            limit: 20,
            where: inputRequest
        };
        this._commonHttpService.getPagedArrayList(payload, 'People/getpersondetail?filter').subscribe(
            response => {
                this.personList = response.data;
            });
    }


    patchForm(data: any) {
        this.courtDetailsForm.reset();
        this.courtDetailsForm.controls.hearingClients = this._formBuilder.array([]);
        if (data) {
            this.pettionChanged(data.intakeservicerequestpetitionid);
            this.hearingMaxDate = this._commonDDservice.getValidDate(data.hearingdatetime);
            data.hearingDate = this._commonDDservice.getValidDate(data.hearingdatetime);
            data.hearingTime = moment(data.hearingdatetime).format('HH:mm');
            if (data.nexthearingtime) {
                data.nexthearingtime = moment(data.nexthearingtime).format('HH:mm');
            }
            data.nofurtherinvolvementflag = data.nofurtherinvolvementflag ? true : false;
            data.exceptionappealfiledflag = data.exceptionappealfiledflag ? true : false;
            data.exceptionappealflag = data.exceptionappealflag ? true : false;

            this.courtDetailsForm.patchValue(data);
            this.loadCounty();
            if(data.hearingclientdetails) {
                this.setCourtHearingClientsForm(data.hearingclientdetails);
            }
            this.processNextHearingDate();
        }
    }
    patchHearingForm() {
        ['intakeservicerequestpetitionid', 'hearingtype', 'hearingDate','hearingTime'].forEach((item) => {
            this.hearingForm.get(item)?.setValidators([Validators.required]);
            this.hearingForm.get(item)?.updateValueAndValidity();
        });
        this.resetForm();
        if (!this.isPetitionFilled) {
            this._alertService.error('Please Fill Petition Details to proceed');
        } else {
            this.hearingForm.reset();
            this.hearingForm.patchValue({ hearingTime: '08:00' });
            $('#add-hearing').modal('show');
        }

    }
    addHearingDetail() {
        if (this.hearingForm.invalid) {
            this.displayValidationMessages =true;
            this.hearingForm.markAllAsTouched();
            return;
          }
        if (this.courtDetailsForm.valid) {
            this.saveToAddHearingDetail();
        } else {
            this._alertService.error('Please fill all fields');
        }
    }
    saveToAddHearingDetail() {
        this.courtDetails = Object.assign({}, this.courtDetailsForm.getRawValue());

        this.setServiceCaseDetails();

        // @Simar - date time issue
        this.courtDetails.hearingdatetime = this.convertDateTimeToTimestamp(this.courtDetailsForm.value.hearingDate, this.courtDetailsForm.value.hearingTime);
        if (this.isNextHearingScheduled && this.courtDetails.nexthearingtime) {
                this.courtDetails.nexthearingtime = this.convertDateTimeToTimestamp(this.courtDetails.nexthearingdate, this.courtDetails.nexthearingtime);
        }
        this.courtDetails.hearingdetails = this.hearingDetails;
        this.courtDetails.courtaction = this.courtAction;
        this.courtDetails.intakeservicerequestpetitionid = this.petitionDetails.intakeservicerequestpetitionid;
        this.courtDetails.nofurtherinvolvementflag = this.courtDetails.nofurtherinvolvementflag ? 1 : 0;
        this.courtDetails.exceptionappealfiledflag = this.courtDetails.exceptionappealfiledflag ? 1 : 0;
        this.courtDetails.exceptionappealflag = this.courtDetails.exceptionappealflag ? 1 : 0;
        this.courtDetails.petitionType = this.petitionDetails.petitiontypekey;
        if (this.hearingData.length <= 0) {
            this._commonHttpService.create(this.courtDetails, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.HearingAddUrl).subscribe(result => {
                this._alertService.success('Hearing details saved successfully!');
                this.gethearingDetails();
                this.hearingData[0] = result;
                this.resetForm();
            },
                _error => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                });
        } else {
            this._alertService.error('Hearing already Exists');
            this.resetForm();
        }
    }
    private setServiceCaseDetails() {
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        if (isServiceCase) {
            delete this.courtDetails.intakeservicerequestid;
            this.courtDetails.servicecaseid = this.id;
            // Sending Default value for intakeservicerequestid as the API throws error for null value
            this.courtDetails.intakeservicerequestid = this.intakeservicereqid;
        } else {
            delete this.courtDetails.servicecaseid;
            this.courtDetails.intakeservicerequestid = this.id;
        }
    }
    updateHearingDetail() {
        if (this.courtDetailsForm.invalid) {
            this.displayValidationMessages =true;
            this.courtDetailsForm.markAllAsTouched();
            return;
          }
        this.courtDetails = Object.assign({}, this.courtDetailsForm.getRawValue());
        this.setServiceCaseDetails();

        // @Simar: date time issue
        this.courtDetails.hearingdatetime = this.convertDateTimeToTimestamp(this.courtDetailsForm.value.hearingDate, this.courtDetailsForm.value.hearingTime);

        if (this.isNextHearingScheduled && this.courtDetails.nexthearingtime) {
                this.courtDetails.nexthearingtime = this.convertDateTimeToTimestamp(this.courtDetails.nexthearingdate, this.courtDetails.nexthearingtime);
        } else  {
            this.courtDetails.nexthearingtime = null;
        }
        this.courtDetails.hearingdetails = this.hearingDetails;
        this.courtDetails.courtaction = this.courtAction;
        this.courtDetails.intakeservicerequestcourthearingid = this.hearingId;
        this.setCourtDetailsFlags();
        this.courtDetails.nexthearingtype = this.courtDetails.nexthearingtype ? { "data" : this.courtDetails.nexthearingtype } : null;
        this._commonHttpService.patch(this.hearingId, this.courtDetails, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.HearingUpdateUrl).subscribe(_result => {
            this._alertService.success('Hearing details updated successfully!');
            this.courtDetails.nexthearingtype = (this.courtDetails.nexthearingtype && this.courtDetails.nexthearingtype.data) ? this.courtDetails.nexthearingtype.data : null;
            this.hearingData[this.modalInt] = this.courtDetails;
            this.resetForm();
            this.isHearingDetailsForm = false;
            this.gethearingDetails();
            if (this.isNextHearingScheduled) {
                this.cloneHearing(this.courtDetails);
            }
            $('#legal-custody-alert-box').modal('show');
        },
            _error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }
    saveUpdatedHearingDetail() {
        this.courtDetails = Object.assign({}, this.courtDetailsForm.getRawValue());
        this.setServiceCaseDetails();
        // @Simar: date time issue
        this.courtDetails.hearingdatetime = this.convertDateTimeToTimestamp(this.courtDetailsForm.value.hearingDate, this.courtDetailsForm.value.hearingTime);
        if (this.isNextHearingScheduled && this.courtDetails.nexthearingtime) {
                this.courtDetails.nexthearingtime = this.convertDateTimeToTimestamp(this.courtDetails.nexthearingdate, this.courtDetails.nexthearingtime);
        } else {
            this.courtDetails.nexthearingtime = null;
        }
        this.courtDetails.hearingdetails = this.hearingDetails;
        this.courtDetails.courtaction = this.courtAction;
        this.courtDetails.intakeservicerequestcourthearingid = this.hearingId;
        this.setCourtDetailsFlags();
        this.courtDetails.nexthearingtype = this.courtDetails.nexthearingtype ? { "data": this.courtDetails.nexthearingtype } : null;
        this._commonHttpService.patch(this.hearingId, this.courtDetails, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.HearingUpdateUrl).subscribe(_result => {
            this._alertService.success('Hearing details updated successfully!');
            this.courtDetails.nexthearingtype = (this.courtDetails.nexthearingtype && this.courtDetails.nexthearingtype.data) ? this.courtDetails.nexthearingtype.data : null;
            this.hearingData[this.modalInt] = this.courtDetails;
            this.resetForm();
            this.isHearingDetailsForm = false;
            this.gethearingDetails();
            if (this.isNextHearingScheduled) {
                this.cloneHearing(this.courtDetails);
            }
        },
            _error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }
    setCourtDetailsFlags(){
        this.courtDetails.nofurtherinvolvementflag = this.courtDetails.nofurtherinvolvementflag ? 1 : 0;
        this.courtDetails.exceptionappealfiledflag = this.courtDetails.exceptionappealfiledflag ? 1 : 0;
        this.courtDetails.exceptionappealflag = this.courtDetails.exceptionappealflag ? 1 : 0;
    }

    addnextHearing() {
        this.displayValidationMessages = false;
        ['intakeservicerequestpetitionid', 'hearingtype', 'hearingDate', 'hearingTime'].forEach((item) => {
            this.hearingForm?.get(item)?.setValidators([Validators.required]);
            this.hearingForm?.get(item)?.updateValueAndValidity();
        });
        if (this.hearingForm && this.hearingForm.invalid) {
            this.displayValidationMessages = true;
            this.hearingForm.markAllAsTouched();
            return;
        }
            this.hearingForm['controls'].hearingstatustypekey.setValue('SCHULD');
            
            this.courtDetails = Object.assign({
            }, this.hearingForm.getRawValue());

            this.setServiceCaseDetails();
            // 2019-03-17T17:24:07.000Z expected format
            // @Simar: Changing all the time logic
            this.courtDetails.hearingdatetime = this.convertDateTimeToTimestamp(this.hearingForm.value.hearingDate, this.hearingForm.value.hearingTime);

            this.courtDetails.hearingdetails = this.hearingDetails;
            this.courtDetails.courtaction = this.courtAction;
        this.petitionDetails = this.petitionInfo.find(
            pet => pet.intakeservicerequestpetitionid === this.hearingForm.value.intakeservicerequestpetitionid
        )!;
            this.courtDetails.petitionType = this.petitionDetails.petitiontypekey;
            this._commonHttpService.create(this.courtDetails, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.HearingAddUrl)
            .subscribe(_result => {
                this._alertService.success('Hearing details saved successfully!');
                this.hearingForm.reset();
                $('#add-hearing').modal('hide');
                this.gethearingDetails();
                $('#legal-custody-alert-box').modal('show');
            },
                _error => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                });
    }

    selectCourtActionType(event: any) {
        this._courtResolverService.selectCourtType(event, 'courtAction', 'courtactiontypekey', this.courtActionsType$, 'courtActionDescription');
      }

    private loadDroddowns() {
        const source = forkJoin([
            this._commonHttpService.getArrayList({}, `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Allegation.AllegationURL}?filter={"nolimit":true,"order":"name asc"}`),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.CourtActionTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.ConditionTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.CourtOrderTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.FindingTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.AdjudicatedDecisionTypeUrl + this.filteroptn),
            this._commonHttpService.getArrayList({}, 'hearingstatustype' + '?filter={"nolimit":true,"order":"description"}'),
            this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.StateListUrl + this.filteroptn),

            this._commonHttpService.getArrayList({}, 
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.HearingTypeUrl}?filter={"where": {"teamtypekey": "CW"},"nolimit":true,"order":"description"}`),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: 1 },
                    method: 'get',
                    nolimit: true,
                    order: 'description'
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionTypeUrl}?filter`
            )
        ]).pipe(
            map(([offenceCategories, courtActionsType, conditionTypes, courtOrder, findingsType, adijuctedDecisions, hearingStatusType, stateList, hearingType, petitionType]: any) => {
                hearingType.forEach((type: any) => {
                    this.hearingtypeArray[type.hearingtypekey] = type.description;
                    
                });
                hearingStatusType.forEach((type: any) => {
                    this.hearingstatustypeArray[type.hearingstatustypekey] = type.description;
                });
                petitionType.forEach((type: any) => {
                    this.hearingstatustypeArray[type.petitiontypekey] = type.description;
                });
                this.cdr.detectChanges();
                return {
                    offenceCategories: this._courtResolverService.mapToDropdownModel(offenceCategories['data'], 'name', 'allegationid'),
                    courtActionsType: this._courtResolverService.mapToDropdownModel(courtActionsType, 'description', 'courtactiontypekey'),
                    conditionTypes: this._courtResolverService.mapToDropdownModel(conditionTypes, 'description', 'conditiontypekey'),
                    courtOrder: this._courtResolverService.mapToDropdownModel(courtOrder, 'description', 'courtordertypekey'),
                    findingsType: this._courtResolverService.mapToDropdownModel(findingsType, 'description', 'findingtypekey'),
                    adijuctedDecisions: this._courtResolverService.mapToDropdownModel(adijuctedDecisions, 'description', 'adjudicateddecisiontypekey'),
                    stateList: this._courtResolverService.mapToDropdownModel(stateList, 'statename', 'stateabbr'),
                    hearingStatusType: this._courtResolverService.mapToDropdownModel(hearingStatusType, 'description', 'hearingstatustypekey'),
                    hearingType: this._courtResolverService.mapToDropdownModel(hearingType, 'description', 'hearingtypekey')
                  };
                  
            }),
            
            share(),);
            
        this.offenceCategories$ = source.pipe(pluck('offenceCategories'));
        this.courtActionsType$ = source.pipe(pluck('courtActionsType'));
        this.conditionTypes$ = source.pipe(pluck('conditionTypes'));
        this.courtOrder$ = source.pipe(pluck('courtOrder'));
        this.findingsType$ = source.pipe(pluck('findingsType'));
        this.adijuctedDecisions$ = source.pipe(pluck('adijuctedDecisions'));
        this.hearingStatusTypeItem$ = source.pipe(pluck('hearingStatusType'));
        this.stateList$ = source.pipe(pluck('stateList'));
        this.hearingType$ = source.pipe(pluck('hearingType'));
        this.hearingType$.subscribe(hl => {
            this.hearingTypeList = hl;
        });

        this.courtActionsType$.subscribe(data => {
            if (data) {
                const courtActionValue = this.courtAction.map(res => res.courtactiontypekey);
                const getActiontems = data.filter(item => {
                    return courtActionValue.includes(item.value);
                });
                this.courtActionDescription = getActiontems.map(res => res.text);
            }
        });
        this.cdr.markForCheck();
    }

    gethearingDetails() {
        if (this.id) {
            let isExpungementSuperUser= this._authService.isExpungementSuperUser(); 
            const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
            let courtReqObj = {};
            if (isServiceCase) {
                courtReqObj = {
                    objectid: this.id,
                    objecttype: 'servicecase',
                    isExpungementSuperUser: isExpungementSuperUser,
                    iscaseexpunged: this.iscaseexpunged
                };
            } else {
                courtReqObj = { 
                    intakeservicerequestid: this.id,
                    isExpungementSuperUser: isExpungementSuperUser,
                    iscaseexpunged: this.iscaseexpunged
                };
            }
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    where: courtReqObj
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court
                    .getHearingUrl}?filter`
            )
                .subscribe(
                    (result) => {
                        if (result && result[0]) {
                            this.hearingData = result;
                            this.checkhearingData(result);
                        } else {
                            this.isHearingDetailsForm = false;
                        }
                        this.cdr.markForCheck();
                    },
                    (_error) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
        }
    }
    checkhearingData(result: any) {
        this.hearingData = _.orderBy(this.hearingData, ['hearingdatetime'], ['desc']);
        this.hearingData = this.hearingData.map(hearing => this.updatehearing(hearing));
        this.checkIsUpcomingHearing(result);
    }
    updatehearing(hearing: any) {
        hearing.nexthearingtype = (hearing.nexthearingtype && hearing.nexthearingtype.data) ? hearing.nexthearingtype.data : null;
        if (hearing.intakeservicerequestpetition &&
            hearing.intakeservicerequestpetition.petitionid === 'To be confirmed') {
            const daysTogo = moment().diff(hearing.hearingdatetime, 'day', false) * -1;
            hearing.daysTogo = daysTogo;
            if (hearing.daysTogo <= PETITION_ID_UPDATE_WINDOW) {
                hearing.petitionUpdateAlertMessage = 
                                        `You have an upcoming hearing within the next ${PETITION_ID_UPDATE_WINDOW} days, 
                                        and have not yet filled the petition ID. Please fill the Petition ID.`;
                hearing.hasPetitionIDUpdateAlert = true;
            }
             else {
                hearing.daysTogo = 0;
                hearing.hasPetitionIDUpdateAlert = false;
            }

        } else {
            hearing.daysTogo = 0;
            hearing.hasPetitionIDUpdateAlert = false;
        }
        if (hearing.hearingclientdetails) {
            hearing.hearingclientdetails.forEach((hearingclient: any) => {
                if (hearingclient.annualnoticebenefitdt) {
                    hearingclient.annualnoticebenefitdt = moment(hearingclient.annualnoticebenefitdt).format("YYYY-MM-DDTHH:mm:ssZ");
                }
            });
        }
        hearing.petitionActors = this.hearingPetitionActors(hearing);
        return hearing;
    }

    setCourtHearingParentsFromHearing(hearingParents: any[]): void {
        this.courtDetailsForm.setControl(
            'hearingParents',
            new FormArray<FormGroup>([])
        );
        const parentArray = new FormArray<FormGroup>([]);

        hearingParents.forEach((parent: any) => {
            parentArray.push(this._formBuilder.group({
                intakeservicerequestactorid: [parent.intakeservicerequestactorid],
                petitionactortype: [parent.petitionactortype],
                personid: [parent.personid || parent.intakeservicerequestactor?.personid || null],
                name: [parent.name || parent.clientname || this.getParentDisplayName(parent)]
            }));
        });

        this.courtDetailsForm.setControl('hearingParents', parentArray);
         this.courtDetailsForm.get('hearingParents')?.updateValueAndValidity();
    }

    hearingPetitionActors(hearing: any){
        if (hearing.intakeservicerequestpetition &&
             hearing.intakeservicerequestpetition.intakeservicerequestpetitionactor &&
             hearing.intakeservicerequestpetition.intakeservicerequestpetitionactor.length) {
            const petitionActors = hearing.intakeservicerequestpetition.intakeservicerequestpetitionactor
                                                            .filter((actor: any) => actor.petitionactortype === 'PA');
            if (petitionActors && petitionActors.length) {
                petitionActors.forEach((actor: any) => {
                    if (actor.intakeservicerequestactor && actor.intakeservicerequestactor.person) {
                        actor.fullName = this.getFullName(actor.intakeservicerequestactor.person);
                    }
                });
                return petitionActors;
            } else {
                return hearing.petitionActors;
            }
        } else {
            return hearing.petitionActors;
        }  
    }
    checkIsUpcomingHearing(result: any){
        if (result[0].hearingdetails) {
            this.hearingDetails = result[0].hearingdetails;
        }
        const contuce = result.filter(((item: { hearingstatustypekey: string; }) => item.hearingstatustypekey === 'DISMIS' || item.hearingstatustypekey === 'CONCULD'));
        if (contuce && contuce.length) {
            this.isUpcomingHearing = true;
        } else {
            this.isUpcomingHearing = false;
        }
        this.cdr.markForCheck();
    }

    private mapActorToPetitionDetails(actor: any) {
        const petitionDetails: any = {
            intakeservicerequestpetitionid: actor.intakeservicerequestpetitionid,
            associatedattorneys: actor.associatedattorneys,
            petitionid: actor.petitionid,
            petitiontypekey: actor.petitiontypekey,
            actordetails: actor.intakeservicerequestpetitionactor,
            parentdetails: actor.intakeservicerequestpetitionactor.filter((act:any)=>{return act.petitionactortype == 'PARENT1' || act.petitionactortype == 'PARENT2' }) || [],
            petitiondate: actor.petitiondate
        };
    
        this.petitonListDetails = petitionDetails;
    
        return petitionDetails;
    }

    private getPetitionDetails() {
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        const isExpungementSuperUser= this._authService.isExpungementSuperUser();
        let courtReqObj = {};
        if (isServiceCase) {
            courtReqObj = {
                objectid: this.id,
                objecttype: 'servicecase'
            };
        } else {
            courtReqObj = { intakeservicerequestid: this.id,isExpungementSuperUser: isExpungementSuperUser, iscaseexpunged: this.iscaseexpunged };
        }
        this._commonHttpService
            .getArrayList(
                {
                    where: courtReqObj,
                    method: 'get'
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court
                    .PetitionListUrl}?filter`
            )
            .subscribe(res => {
                if (res) {
                    this.isPetitionFilled = res[0] ? true : false;
                    this.petitionInfo = res.map(actor => this.mapActorToPetitionDetails(actor));
                }
            });
    }

    resetForm() {
        this.displayValidationMessages = false;
        this.masterParentDetails = [];
        this.hearingForm.reset();
        this.hearingForm.setControl('hearingClients', this._formBuilder.array([]));
        this.hearingForm.setControl('hearingParents', this._formBuilder.array([]));
        this.hearingForm.patchValue({ hearingTime: '08:00' });

        this.courtDetailsForm.reset();
        this.courtDetailsForm.setControl('hearingClients', this._formBuilder.array([]));
        this.courtDetailsForm.setControl('hearingParents', this._formBuilder.array([]));
        this.courtDetailsForm.patchValue({ hearingTime: '08:00' });

        this.modalInt = -1;
        this.editMode = false;
        this.reportMode = 'add';
        this.courtDetailsForm.enable();
        this.hearingId = '';
    }

    viewHearing(modal: any, _i: any) {
        this.prepareHearingDetails(modal, "View", false);
        this.courtDetailsForm.disable();
    }
    
    editHearing(modal: any, i: any) {
        this.prepareHearingDetails(modal, "Update", true);
        this.modalInt = i;
        this.courtDetailsForm.enable();
    }
    
    prepareHearingDetails(modal: any, viewEditLabel: any, editMode: any) {
        this.viewEditLabel = viewEditLabel;
        this.petitionInfo.forEach((res) => {
            if (res.petitionid === modal.intakeservicerequestpetition.petitionid) {
                this.petitonListDetails = res;
            }
        });
        this.hearingId = modal.intakeservicerequestcourthearingid;
        this.datechangeofpermanency = modal.datechangeofpermanency || null;
        this.hearingDetailsInfo = modal;
        this.reportMode = 'edit';
        this.editMode = editMode;
        this.isHearingDetailsForm = true;
        this.patchForm(modal);
        //mock hearing parent here
        this.setCourtHearingParentsFromHearing(modal.hearingparents || []);
        const selectedPetition = this.petitionInfo?.find(
            p => p.petitionid === modal.intakeservicerequestpetition?.petitionid
        );

       /*  if (selectedPetition?.parentdetails) {
            this.setCourtHearingParentsForm(selectedPetition.parentdetails);
        } */
        setTimeout(() => {
            window.scrollTo(0, document.body.scrollHeight);
        }, 300);
    }

    setCourtHearingParentsForm(parentDetails: any[]): void {
  const parentArray = new FormArray<FormGroup>([]);

  parentDetails.forEach((parent: any) => {
    parentArray.push(this._formBuilder.group({
      intakeservicerequestactorid: [parent.intakeservicerequestactorid],
      petitionactortype: [parent.petitionactortype],
      personid: [parent.intakeservicerequestactor?.personid || null],
      name: [this.getParentDisplayName(parent)]
    }));
  });

  this.courtDetailsForm.setControl('hearingParents', parentArray);
}

    deleteHearing(index: any, hearingId: any) {
        this._commonHttpService.remove(hearingId, this.courtDetails, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.deleteHearing).subscribe(_result => {
            this._alertService.success('Hearing details deleted successfully');
            this.isUpcomingHearing = false;
            this.hearingData.splice(index, 1);
            this.gethearingDetails();
            this.resetForm();
        },
            _error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }

    deleteCourtHearing(item: any, hearingId: any) {
        this.hearingId = hearingId;
        this.hearingIndexselected = item;
        $(this.deletecourthearingpopupid).modal('show');
    }

    confirmDeleteCourtHearing() { 
        this.deleteHearing(this.hearingIndexselected, this.hearingId); 
        $(this.deletecourthearingpopupid).modal('hide');
    }

    cancelDeleteCourtHearing() {
        $(this.deletecourthearingpopupid).modal('hide');
    }

    processNextHearingDate() {
        this.isNextHearingScheduled = this.isNextHearingSelected();
        if (this.isNextHearingScheduled) {
            this.courtDetailsForm.get('nexthearingdate')?.setValidators(Validators.required);
            this.courtDetailsForm.get('nexthearingdate')?.updateValueAndValidity();
            this.courtDetailsForm.get('nexthearingtime')?.setValidators(Validators.required);
            this.courtDetailsForm.get('nexthearingtime')?.updateValueAndValidity();
        } else {
            this.courtDetailsForm.get('nexthearingdate')?.reset();
            this.courtDetailsForm.get('nexthearingdate')?.clearValidators();
            this.courtDetailsForm.get('nexthearingdate')?.updateValueAndValidity();
            this.courtDetailsForm.get('nexthearingtime')?.reset();
            this.courtDetailsForm.get('nexthearingtime')?.clearValidators();
            this.courtDetailsForm.get('nexthearingtime')?.updateValueAndValidity();
        }
    }
    isNextHearingSelected() {
        return this.courtDetailsForm.getRawValue().exceptionappealflag;
    }

    cloneHearing(hearingDetails: any) {
        hearingDetails.hearingDate = this._commonDDservice.getValidDate(hearingDetails.nexthearingdate);
        hearingDetails.hearingTime = moment(hearingDetails.nexthearingtime).format('HH:mm');
        hearingDetails.hearingdatetime = hearingDetails.nexthearingtime;
        hearingDetails.hearingtype = hearingDetails.nexthearingtype;
        this.hearingForm.patchValue(hearingDetails);
        if(hearingDetails.hearingClients) {
            this.hearingForm.controls.hearingClients = this._formBuilder.array([]);
            const control = this.hearingForm.controls.hearingClients as FormArray;
            hearingDetails.hearingClients.forEach((x: any) => {
            control.push(this._formBuilder.group({
                personid: x.personid,
                name: x.name,
                courtcasenotx: x.courtcasenotx,
                otherclientflag: x.otherclientflag
                    })
                );
             });
        }
        this.addnextHearing();
    }

    showPetitionUpdateAlert(hearingDetail: any) {
        this.hearingDetailAlert = hearingDetail;
        $('#alert-box').modal('show');
    }

    pettionChanged(value: any) {
        const selectedPetition = this.petitionInfo ? this.petitionInfo.find(p => p.intakeservicerequestpetitionid === value) : null;
        this.isTPR = selectedPetition?.petitiontypekey  === 'GAPTPR';
        if (selectedPetition && selectedPetition.petitiondate) {
             this.selectedPetionDate =moment(selectedPetition.petitiondate).format('MM/DD/YYYY');
        }
        if (selectedPetition?.parentdetails) {
             this.setHearingParentsForm(
                 (selectedPetition.parentdetails || []).filter(
                     (parent: any) => parent.intakeservicerequestpetitionid != null
                 )
            );
        }
    }

    isTprPetition(hearing:any):boolean{
         const selectedPetition = this.petitionInfo ? this.petitionInfo.find(p => p.intakeservicerequestpetitionid === hearing.intakeservicerequestpetitionid) : null;
         return selectedPetition?.petitiontypekey  === 'GAPTPR';
    }

    // Date and time
    convertDateTimeToTimestamp(date: any, time: any) {
        return moment(`${moment(date).format('MM/DD/YYYY')} ${time}`).format();
    }
    

    //set next hearing flag
    saveNextHearing() {
        this.savenexthearingflag = !this.savenexthearingflag;
    }

    getFullName(person: any) {
        const nameKeys = [ 'prefix' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
        let name = '';
        nameKeys.forEach(key => {
          if(person && person.hasOwnProperty(key)){
          if ( person[key] !== null && person[key] !== 'null' && person[key] !== '' ) {
            name = `${name}${person[key]} `;
          }}
        });
        return name.trim();
      }

    /**
     * Court case numbers
     */
    showCourtCaseNumbers() {
        $('#court-numbers').modal('show');
    }

    getCourtCaseNumbers() {
        const payload = {
            method: 'get',
            where: {
                caseid: this.id
            }
        };
        this._commonHttpService.getArrayList(payload, 'courtnumbers/listallcourtnumbers?filter').subscribe(
            response => {
                this.courtcasenumbers =  response;
            }
        );
    }

    addNewCourtNumber() {
        this.showCourtNumbersForm = true;
        this.courtNumbersForm.reset();
    }

    cancelCourtNumber() {
        this.showCourtNumbersForm = false;
        this.courtNumbersForm.reset();
    }

    cancel() {
        this.resetForm();
        this.isHearingDetailsForm = false;
    }

    editCourtNumber(item: any) {
        this.showCourtNumbersForm = true;
        this.getPersonNameList(item.personid);
        this.courtNumbersForm.reset();
        const formdata = item;
        this.courtNumbersForm.patchValue(formdata);
        this.courtNumbersForm.enable();
    }

    deleteCourtNumber(item: any) {
        this.deleteCourtNumberId = item.courtnumberid;
        $(this.deletecourtnopopupid).modal('show');
    }

    saveCourtNumber() {
        // Save the visitation log details
        const courtNumberDetails = this.courtNumbersForm.getRawValue();
        courtNumberDetails.caseid = this.id;
        this._commonHttpService.create(courtNumberDetails, 'courtnumbers/addupdate').subscribe(
            _response => {
                this.getCourtCaseNumbers();
                this.cancelCourtNumber();
                this._alertService.success('Court case number details saved successfully!');

            }
        );
    }

    confirmDelete() {
        const payload: any = {}
        payload['courtnumberid'] = this.deleteCourtNumberId;
        this._commonHttpService.create(payload, 'courtnumbers/deletecourtnumber').subscribe(
            _response => {
                this.getCourtCaseNumbers();
                $(this.deletecourtnopopupid).modal('hide');
                this._alertService.success('Court case number deleted successfully!');
            }
        );
    }

    cancelDelete() {
        $(this.deletecourtnopopupid).modal('hide');
    }

    
    /**
     *  Hearing Clients
     */
    setHearingClients(event: any) {
        const selectedPetition = this.petitionInfo.find(p => p.intakeservicerequestpetitionid === event.value);
        if (selectedPetition && selectedPetition.actordetails) {
            this.setHearingClientsForm(selectedPetition.actordetails);
        }

    if (selectedPetition?.parentdetails) {
        this.setHearingParentsForm(selectedPetition.parentdetails);
    }
    
    }

isMasterParent(client: any): boolean {
 const clientActorId = client.intakeservicerequestactorid;

  const matchedParent = this.masterParentDetails?.find((parent: any) =>
    String(parent.intakeservicerequestactorid).trim() ===
    String(clientActorId).trim()
  );
  console.log('returning ....',!!matchedParent);
  return !!matchedParent;
}

   /*  setHearingParentsForm(parentDetails: any[]) {
         this.masterParentDetails = _.cloneDeep(parentDetails || []);
    this.hearingForm.setControl('hearingParents', this._formBuilder.array([]));

    const control = this.hearingForm.get('hearingParents') as FormArray;

    parentDetails.forEach((parent: any) => {
        control.push(this._formBuilder.group({
            intakeservicerequestactorid: parent.intakeservicerequestactorid,
            petitionactortype: parent.petitionactortype,
            personid: parent.intakeservicerequestactor?.personid || null,
            name: this.getParentDisplayName(parent)
            }));
        });
    } */


    setHearingParentsForm(parentDetails: any[]) {
        parentDetails = _.sortBy(parentDetails, (p: any) =>
            p.petitionactortype === 'PARENT1' ? 1 :
                p.petitionactortype === 'PARENT2' ? 2 : 99
        );
        this.masterParentDetails = _.cloneDeep(parentDetails || []);
        const hearingControl = new FormArray<FormGroup>([]);
        const courtControl = new FormArray<FormGroup>([]);

        parentDetails.forEach((parent: any) => {

            const parentGroup = this._formBuilder.group({
                intakeservicerequestactorid: [parent.intakeservicerequestactorid],
                petitionactortype: [parent.petitionactortype],
                personid: [parent.intakeservicerequestactor?.personid || null],
                name: [this.getParentDisplayName(parent)]
            });

            hearingControl.push(parentGroup);

            courtControl.push(
                this._formBuilder.group({
                    intakeservicerequestactorid: [parent.intakeservicerequestactorid],
                    petitionactortype: [parent.petitionactortype],
                    personid: [parent.intakeservicerequestactor?.personid || null],
                    name: [this.getParentDisplayName(parent)]
                })
            );
        });

        this.hearingForm.setControl('hearingParents', hearingControl);
        
    }

    getParentDisplayName(parent: any): string {
        if (!parent?.intakeservicerequestactorid) {
            return 'Unknown';
        }

        const person = parent?.intakeservicerequestactor?.person;

        if (person) {
            return this.getFullName(person);
        }

        return parent.petitionactortype === 'PARENT1'
            ? 'Parent 1'
            : 'Parent 2';
    }

    setHearingClientsForm(hearingClients: any) {
    this.hearingForm.controls.hearingClients = this._formBuilder.array([]);
    const control = this.hearingForm.controls.hearingClients as FormArray;

    hearingClients.forEach((x: any) => {
        const actor = x?.intakeservicerequestactor;
        const person = actor?.person;
       if(actor){
      control.push(this._formBuilder.group({
            personid: actor?.personid || null,
            name: person ? this.getFullName(person) : ('Unknown'),
            courtcasenotx: [''],
            otherclientflag: x.petitionactortype === 'PA' ? 0 : 1
        }));
       }
  
    });
}

    setCourtHearingClientsForm(data: any) {
        this.courtDetailsForm.controls.hearingClients = this._formBuilder.array([]);
        const control = this.courtDetailsForm.controls.hearingClients as FormArray;
        
        data.forEach((x: any) => {
            control.push(this._formBuilder.group({
                hearingclientid: x.hearingclientid,
                personid: x.personid,
                name: x.clientname,
                courtcasenotx: x.casenumber,
                annualnoticebenefitdt: x.annualnoticebenefitdt,
                otherclientflag: x.otherclientflag
                })
            );
        });    
    }

    getClientCaseNumbers(personid: any) {
        var response = []
        if (this.courtcasenumbers) {
            response = this.courtcasenumbers.filter(x => x.personid === personid).map(y => y.courtcaseno);
        }
        return response;
    }

    getDateTimeFormatted(date:any){
        if(date && moment(date).isValid()){
          return moment(date).format('MM/DD/YYYY, hh:mm A');
        }else{
          return '';}
    }

    getPersonNameList(id: any) {
        const selectPersonList = this.personList.find(f => f.personid === id);
        this.selectedPersonName = selectPersonList.fullname;
    }
    loadCounty(_change?: any) {
        
        const stateKey = this.courtDetailsForm.getRawValue().statekey;
        this._commonDDservice.getPickListByMdmcode(stateKey).subscribe(countyList => {
          this.countyList$ = observableOf(countyList);
        });
      }

      getErrorsMessage(ControlName: any, displayName: any){
        return this.hearingForm.controls[ControlName].status ==='INVALID' ? `Please enter valid ${displayName}` : null
    }

    getCourtDetailsFormErrorsMessage(ControlName: any, displayName: any){
        return this.courtDetailsForm.controls[ControlName].status ==='INVALID' ? `Please enter valid ${displayName}` : null
    }

    get hearingClients(): any {
        return this.hearingForm.get('hearingClients') as any;
    }

    get courtHearingClients(): any {
        return this.courtDetailsForm.get('hearingClients') as any;
    }

   get hearingParents(): FormArray<FormGroup> {
        return this.hearingForm.get('hearingParents') as FormArray<FormGroup>;
    }

    get courtHearingParents(): FormArray {
        return this.courtDetailsForm.get('hearingParents') as FormArray;
    }

private buildParentGroup(parent: any): FormGroup {
    return this._formBuilder.group({
        personid: [parent?.personid || null],
        name: [parent?.name || ''],
        parenttype: [parent?.parenttype || null]
    });
}

private setMockHearingParents(): void {
    const parentArray: FormArray<FormGroup> = this._formBuilder.array<FormGroup>([]);

    parentArray.push(this.buildParentGroup({
        personid: 'mock-parent-1',
        name: 'Mock Parent 1',
        parenttype: 'PARENT1'
    }));

    parentArray.push(this.buildParentGroup({
        personid: 'mock-parent-2',
        name: 'Mock Parent 2',
        parenttype: 'PARENT2'
    }));

    this.hearingForm.setControl('hearingParents', parentArray);
}


addParent(): void {
    const selectedIds = this.hearingParents.value
        .map((p: any) => p.petitionactortype)
        .filter(Boolean);

    const availableParent = this.masterParentDetails.find((parent: any) =>
        !selectedIds.includes(parent.petitionactortype)
    );

    if (!availableParent) {
        this._alertService.warn('No more parents available to add.');
        return;
    }

    this.hearingParents.push(this.buildParentGroupFromPetition(availableParent));
}

private buildParentGroupFromPetition(parent: any): FormGroup {
    return this._formBuilder.group({
        intakeservicerequestactorid: [parent.intakeservicerequestactorid || null],
        petitionactortype: [parent.petitionactortype || null],
        personid: [parent.intakeservicerequestactor?.personid || null],
        name: [this.getParentDisplayName(parent)]
    });
}

removeParent(index: number): void {
    this.hearingParents.removeAt(index);
    this.courtHearingParents.removeAt(index);
    this.courtDetailsForm.markAsDirty();
}


}