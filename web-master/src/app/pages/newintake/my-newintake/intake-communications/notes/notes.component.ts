
import {map, pluck, share} from 'rxjs/operators';
import { DatePipe } from '@angular/common';
import { Component, OnInit, OnDestroy, ViewEncapsulation, Injector } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import moment from 'moment';
import { Observable ,  forkJoin ,  Subject } from 'rxjs';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, ValidationService, DataStoreService } from '../../../../../@core/services';
import { 
    CaseWorkerContactRoles,
    CaseWorkerRecording,
    CaseWorkerRecordingEdit,
    CaseWorkerRecordingType,
    ProgressNoteRoleType,
    SearchRecording,
    ParticipantType,
    ReasonForContact,
    RecordingNotes
} from '../../_entities/newintakeModel';
import { NewUrlConfig } from '../../../newintake-url.config';
import { Attachment } from '../../../attachment/_entities/attachment.data.models';
import * as category from '../_configurations/category.json';
import * as status from '../_configurations/status.json';
import * as type from '../_configurations/type.json';
import { SpeechRecognitionService } from '../../../../../@core/services/speech-recognition.service';
import { SpeechRecognizerService } from '../../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { IntakeStoreConstants } from '../../my-newintake.constants';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    encapsulation: ViewEncapsulation.None,
    selector: 'notes',
    templateUrl: './notes.component.html',
    styleUrls: ['./notes.component.scss'],
    standalone: false
})
export class NotesComponent implements OnInit, OnDestroy {
    attachmentGrid$: Observable<Attachment[]>;
    viewEdit: string;
    categoryForm: FormGroup;
    updateAppend: FormGroup;
    courtForm: FormGroup;
    // isOthers: boolean;
    id: string;
    daNumber: string;
    multipleRoles: string;
    recordingForm: FormGroup;
    selectedIndex: any;
    searchCategoryForm: FormGroup;
    saveButton: boolean;
    isCW: boolean;
    isInvolvePerson: boolean;
    isotherPerson: boolean;
    isUploadClicked: boolean;
    recording: any;
    totalRecords: any;
    recordingCategory = false;
    recordDate = false;
    contactDate = false;
    paginationInfo: PaginationInfo = new PaginationInfo();
    recordingedit: CaseWorkerRecordingEdit = new CaseWorkerRecordingEdit();
    editRecord: RecordingNotes = new RecordingNotes();
    appendNoteControl: AbstractControl;
    typeDropdown: DropdownModel[];
    statusDropdown: DropdownModel[];
    categoryDropdown: DropdownModel[];
    userInfo: AppUser;
    addNotes: RecordingNotes = new RecordingNotes();
    recordingDetail$: Observable<CaseWorkerRecording>;
    recording$: Observable<RecordingNotes[]>;
    totalRecords$: Observable<number>;
    canDisplayPager$: Observable<boolean>;
    recordingType$: Observable<CaseWorkerRecordingType[]>;
    contactRoles$: Observable<CaseWorkerContactRoles[]>;
    participantType$: Observable<ParticipantType[]>;
    recordingSubTypeDropDown$: Observable<CaseWorkerRecordingType[]>;
    progressNoteRoleType: ProgressNoteRoleType[] = [];
    personNameDescription: string[] = [];
    duration: string;
    isCourtDetails = false;
    progressNoteActor : Array<any> = [];
    private readonly pageSubject$ = new Subject<number>();
    private recordSearch = new SearchRecording();
    reasonForContact$: Observable<ReasonForContact[]>;
    reasonForContact: ReasonForContact[];
    personRoles : Array<any> = [];
    edittimeduration = false;
    isSerachResultFound: boolean;
    minDate = new Date();
    maxDate = new Date();
    actors = [];
    Others = { intakeservicerequestactorid: 'Others' };
    initiateText: boolean;
    attempText: boolean;
    initialFace = false;
    max = new Date();
    stateValuesDropdownItems$: Observable<DropdownModel[]>;
    CountyValuesDropdownItems$: Observable<DropdownModel[]>;
    recognizing = false;
    speechRecogninitionOn: boolean;
    speechData: string;
    // isInvolvedPerson: string;
    notification: string;
    agency: string;
    currentLanguage: string;
    enableAppend = false;
    store: any;
    personinvolved = [];
    selectedNotes: string;
    private readonly formBuilder: FormBuilder;
    private readonly route: ActivatedRoute;
    private readonly _commonHttpService: CommonHttpService;
    private readonly _authService: AuthService;
    private readonly _alertService: AlertService;
    private readonly _route: Router;
    private readonly datePipe: DatePipe;

    constructor(
        private readonly injector : Injector,
        private readonly _speechRecognitionService: SpeechRecognitionService,
        private readonly speechRecognizer: SpeechRecognizerService,
        private readonly _dataStoreService: DataStoreService
    ) {
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._route = this.injector.get<Router>(Router);
        this.datePipe = this.injector.get<DatePipe>(DatePipe);
        
        const intakeNum = this._dataStoreService.getData(IntakeStoreConstants.intakenumber);
        this.id = (intakeNum) ? intakeNum : null;
        this.store = this._dataStoreService.getCurrentStore();

        this.daNumber = this.route.snapshot.parent.parent.parent.params['daNumber'];
    }

    ngOnInit() {
        this.viewEdit = 'Add';
        this.selectedIndex  = -1;

        this.daNumber = this.route.snapshot.parent.parent.parent.parent.params['daNumber'];

        const personrolesdata = (this.store[IntakeStoreConstants.addedPersons]) ? this.store[IntakeStoreConstants.addedPersons] : [];
        personrolesdata.forEach(element => {
            this.personRoles.push({
                intakeservicerequestactorid: element.Pid,
                displayname: element.Firstname + ' ' + element.Lastname + '('
                 + ( (element.personRole && element.personRole.length && element.personRole[0].description)  ? element.personRole[0].description : '' ) + ')',
                personname: element.Firstname + ' ' + element.Lastname,
                role: element.Role
            });
        });

        this.agency = this._authService.getAgencyName();
        this.currentLanguage = 'en-US';
        this.isUploadClicked = false;
        this.speechRecognizer.initialize(this.currentLanguage);
        this.statusDropdown = <any>status;
        this.typeDropdown = <any>type;
        this.categoryDropdown = <any>category;
        this.isCW = this._authService.isCW();
        this.getStateDropdown();
        this.getCountyDropdown();
        this.formInitilize();

        this.pageSubject$.subscribe((pageNumber) => {
            this.paginationInfo.pageNumber = pageNumber;
            this.getPage(this.paginationInfo.pageNumber);
        });
        this.getPage(1);
        this.recordingDropDown();
        this.attachmentDropdown();
        this.getReasonForContact();
        this.appendNoteControl = this.recordingForm.get('appendtitle');
        this.userInfo = this._authService.getCurrentUser();
        this.recording  = this._dataStoreService.getData(IntakeStoreConstants.communications);

    }

    setNotes(record) {
        if (record && record.description) {
           this.selectedNotes =  record.description;
        } else {
         this.selectedNotes = '';
        }
    }

    private formInitilize() {
        this.recordingForm = this.formBuilder.group(
            {
                progressnotetypeid: ['', Validators.required],
                progressnotesubtypeid: [null],
                contactdate: ['', Validators.required],
                // contactname: [null],
                locationname: [''],
                documentpropertiesid: [''],
                firstname: [''],
                lastname: [''],
                address1: [''],
                address2: '',
                city: [''],
                state: '',
                county: '',
                zipcode: [''],
                email: [''],
                phonenumber: [''],
                initiationindicator: ['', Validators.required],
                attemptindicator: [''],
                description: [''],
                appendtitle: [''],
                starttime: [null],
                endtime: [null],
                participanttypekey: [null],
                intakeservicerequestactorid: [''],
                progressnotereasontypekey: ['', Validators.required],
                travelhours: ['', Validators.maxLength(3)],
                travelminutes: ['', Validators.maxLength(2)],
                durationhours: [null, Validators.maxLength(3)],
                durationminutes: ['', Validators.maxLength(2)],
                progressnotepurposetypekey: [null],
                progressnoteroletype: [null],
                progressnoteid: [null],
                others: '',
                RecordingType: [null],
                RecordingsubType: [null]
            }
        );
        this.courtForm = this.formBuilder.group({
            issuedesc: [''],
            safetydesc: [''],
            services_childdesc: [''],
            services_parentdesc: [''],
            permanencystepdesc: [''],
            placementdesc: [''],
            educationdesc: [''],
            healthdesc: [''],
            socialareadesc: [''],
            financialliteracydesc: [''],
            familyplanningdesc: [''],
            skillissuedesc: [''],
            transitionplandesc: ['']
        });
        this.updateAppend = this.formBuilder.group({
            appendtitle: ['', Validators.required]
        });
        this.searchCategoryForm = this.formBuilder.group(
            {
                draft: [''],
                type: [''],
                datefrom: [new Date(), Validators.required],
                dateto: [new Date(), Validators.required],
                contactdatefrom: [new Date(), Validators.required],
                contactdateto: [new Date(), Validators.required]
            },
            {
                validators: Validators.compose([ValidationService.checkDateRange('starttime', 'endtime')])
            }
        );
        this.categoryForm = this.formBuilder.group({
            category: ['']
        });
    }

    private getInvolvedPerson() {
        this._commonHttpService
            .getPagedArrayList(
                {
                    where: { intakeserviceid: this.id },
                    page: 1,
                    limit: 10,
                    method: 'get'
                },
                NewUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
            )
            .subscribe((itm) => {
                if (itm.data) {
                    this.personRoles = [];
                    itm.data.forEach((list) => {
                        return this.personRoles.push({
                            intakeservicerequestactorid: list.roles[0].intakeservicerequestactorid,
                            displayname: list.firstname + ' ' + list.lastname + '(' + list.roles[0].typedescription + ')',
                            personname: list.firstname + ' ' + list.lastname,
                            role: list.roles
                        });
                    });
                }
            });
    }

    getStateDropdown() {
        this.stateValuesDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                'States?filter'
            ).pipe(
            map(result => {
                return result.map(
                    res =>
                        new DropdownModel({
                            text: res.statename,
                            value: res.stateid
                        })
                );
            }));
    }
    getCountyDropdown() {
        this.CountyValuesDropdownItems$ = this._commonHttpService
            .create(
                {
                    where: {
                        activeflag: '1',
                        state: 'MD'
                    },
                    order: 'countyname asc',
                    nolimit: true
                },
                'admin/county/countylist'
            ).pipe(
            map(result => {
                return result.map(
                    res =>
                        new DropdownModel({
                            text: res.countyname,
                            value: res.countyid
                        })
                );
            }));
    }

    getReasonForContact() {
        this.reasonForContact$ = this._commonHttpService.getSingle({}, 'Progressnotereasontypes?filter={"nolimit":true}').pipe(map((itm) => {
            return itm;
        }));
        this.reasonForContact$.subscribe(data => {
            this.reasonForContact = data;
        });
    }
    getPage(page: number) {
        this.recording = this._dataStoreService.getData(IntakeStoreConstants.communications);
        if (this.recording && this.recording.length) {
            this.totalRecords = this.recording.length;
        }
        this.cancelRecording();
    }
    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageSubject$.next(this.paginationInfo.pageNumber);
    }
    changeCategory(event: any) {
        this.isSerachResultFound = true;
        this.searchCategoryForm.reset();
        this.recordSearch = Object.assign({});
        if (event.value === 'RecordingCategory') {
            this.recordingCategory = true;
            this.recordDate = false;
            this.contactDate = false;
        } else if (event.value === 'RecordingDate') {
            this.recordDate = true;
            this.contactDate = false;
            this.recordingCategory = false;
        } else if (event.value === 'ContactDate') {
            this.contactDate = true;
            this.recordDate = false;
            this.recordingCategory = false;
        } else {
            this.recordDate = false;
            this.recordingCategory = false;
            this.contactDate = false;
            this.getPage(1);
        }
        this.searchCategoryForm.patchValue({ draft: '', type: '' });
    }
    recordingSubType(progressnotetypeid: string) {
        const progressNoteTypeKey = progressnotetypeid.split('~');
        if (progressNoteTypeKey[1] === 'Court approved Trial Home Visit') {
            this.isCourtDetails = true;
        } else {
            this.isCourtDetails = false;
        }
        if (progressNoteTypeKey[1] === 'Email' || progressNoteTypeKey[1] === 'Hand deliverd') {
            this.recordingForm.get('progressnotesubtypeid').reset();
            this.recordingForm.get('progressnotesubtypeid').disable();
        } else {
            this.recordingForm.get('progressnotesubtypeid').enable();
        }
        if (progressNoteTypeKey[0]) {
            this.recordingSubTypeDropDown$ = this._commonHttpService
                .getArrayList({}, NewUrlConfig.EndPoint.DSDSAction.Contact.ListProgressSubTypeUrl + '?prognotetypeid=' + progressNoteTypeKey[0]).pipe(
                map((result) => {
                    return result;
                }));
        }
        if (progressNoteTypeKey[1] !== 'Initialfacetoface') {
            this.initialFace = false;
        } else {
            this.initialFace = true;
        }
    }
    searchRecording(modal: SearchRecording) {
        if (modal.contactdateto) {
            modal.contactdateto = moment(modal.contactdateto) 
                .format();
        }
        if (modal.contactdatefrom) {
            modal.contactdatefrom = moment(modal.contactdatefrom) 
                .format();
        }
        if (modal.dateto) {
            modal.dateto = moment(modal.dateto) 
                .format();
        }
        if (modal.datefrom) {
            modal.datefrom = moment(modal.datefrom) 
                .format();
        }
        this.recordSearch = modal;
        this.getPage(1);
    }
    personRoleTypeChange(model) {
        if (model === 'IP') {
            this.recordingForm.controls['intakeservicerequestactorid'].setValidators([Validators.required]);
            this.recordingForm.controls['intakeservicerequestactorid'].updateValueAndValidity();
        } else {
            this.recordingForm.controls['intakeservicerequestactorid'].clearValidators();
            this.recordingForm.controls['intakeservicerequestactorid'].updateValueAndValidity();
        }
    }

    changePersonInvolved(item) {
        this.personinvolved = item.map((res) => {
            return {
                subtancekey: res,
                others: ''
            };
        });
    }

    personRoleList(model) {
        if (model) {
            const removalReasonItems = this.personRoles.filter((item) => {
                if (model.includes(item.intakeservicerequestactorid)) {
                    return item;
                }
            });
            this.changePersonInvolved(model);
            this.personNameDescription = removalReasonItems.map((res) => {
                return res.displayname;
            });
                this.multipleRoles = '';
                const progressNoteRoleType = model.map((res) => {
                    if (res && res.intakeservicerequestactorid === 'Others') {
                        // (<any>$('#myModal-recordings')).modal('hide');
                        // this._speechRecognitionService.destroySpeechObject();
                        // (<any>$('#personsTab')).click();
                        // this._route.routeReuseStrategy.shouldReuseRoute = function() {
                        //     return false;
                        // };
                        // const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/involved-person';
                        // this._route.navigateByUrl(currentUrl).then(() => {
                        //     this._route.navigated = false;
                        //     this._route.navigate([currentUrl]);
                        // });
                        // this._route.navigate([currentUrl], { relativeTo: this.route });
                    }
                    if (this.multipleRoles === '') {
                        this.multipleRoles = this.multipleRoles + '' + res;
                    } else {
                        this.multipleRoles = this.multipleRoles + ', ' + res;
                    }
                    return { intakeservicerequestactorid: res, participanttypekey: 'IP' };
                });
                this.progressNoteRoleType = progressNoteRoleType;
        }
    }
    timeDuration() {
        const start_date = moment(this.recordingForm.value.starttime, 'HH:mm a');
        const end_date = moment(this.recordingForm.value.endtime, ' HH:mm a');
        const duration = moment.duration(end_date.diff(start_date));
        if (duration['_data'] && this.recordingForm.value.starttime && this.recordingForm.value.endtime) {
            this.recordingForm.get('durationhours').reset();
            this.recordingForm.get('durationminutes').reset();
            this.duration = duration['_data'].hours + ' Hr :' + duration['_data'].minutes + ' Min';
        }
    }

    checkTimeValidation(group) {
        return null;
    }
    saveRecording(recording, saveType: string) {
        if (!this.recordingForm.valid) {
            this._alertService.error('Please fill the required fields');
            return;
        }
        if (!this.checkParticipantsRole(saveType)) {
            return;
        }
        if (recording.contactdate) {
            recording.contactdate = moment(recording.contactdate).format();
        }
        this.recordingForm.patchValue({ 'RecordingType': this.recordingForm.value.progressnotetypeid });
        this.recordingForm.patchValue({ 'RecordingsubType': this.recordingForm.value.progressnotesubtypeid });
        const progressNoteTypeKey = this.recordingForm.get('progressnotetypeid').value.split('~');
        recording.progressnotetypeid = progressNoteTypeKey[0];
        recording.recordingtype = progressNoteTypeKey[1];

        const progressnotesubtype = this.returnProgressnotesubtypeFn();
        if (progressnotesubtype.length > 0) {
            recording.progressnotesubtypeid = progressnotesubtype[0];
            recording.recordingsubtype = progressnotesubtype[1];
        }
        recording.contactpurposeList = this.recordingForm.get('progressnotereasontypekey').value.map(item => {
            const part = this.reasonForContact.find(ele => item === ele.progressnotereasontypekey);
            return part.typedescription;
        });
        recording.recordingdate = new Date();
        const user = this._authService.getCurrentUser().user.userprofile;
        recording.author = user.displayname;
        recording.team = user.teammemberassignment.teammember.teammemberroletype.description;
        if (recording.attemptindicator !== null) {
            recording.attemptindicator = this.returnAttemptindicatorFn(recording);
        }
        if (recording.initiationindicator !== null) {
            recording.initiationindicator = this.returnInitiationindicatorFn(recording);
        }
        this.addNotes = Object.assign(
            {
                contactparticipant: this.progressNoteRoleType,
                entitytypeid: this.id,
                savemode: saveType === 'SAVE' ? 1 : 0,
                contacttrialvisit: this.courtForm.value,
                entitytype: 'intakeservicerequest',
                stafftype: 1,
                instantresults: 1,
                contactstatus: false,
                drugscreen: false,
                // RecordingType:  this.recordingForm.value.progressnotetypeid ? this.recordingForm.value.progressnotetypeid : null,
                // RecordingsubType: this.recordingForm.value.progressnotesubtypeid ?  this.recordingForm.value.progressnotesubtypeid : null ,
                description: recording.detail,
                traveltime: this.returnTraveltimeFn(recording),
                totaltime: this.returnTotaltimeFn(recording)
            },
            recording
        );

        if (!this.recordingForm.value.documentpropertiesid) {
            delete this.addNotes.documentpropertiesid;
        }
        this.recording = this._dataStoreService.getData(IntakeStoreConstants.communications);
        if (!this.recording) {
            this.recording = [];
        }
        this.addNotes['RecordingType'] = this.returnRecordingTypeFn();
        this.addNotes['RecordingsubType'] = this.returnRecordingsubTypeFn();
        if (this.selectedIndex >= 0) {
            this.recording[this.selectedIndex] = this.addNotes;
        } else {
            this.recording.push(this.addNotes);
        }
        this._dataStoreService.setData(IntakeStoreConstants.communications, this.recording);
        this.recording = this._dataStoreService.getData(IntakeStoreConstants.communications);
        this.cancelRecording();


        // this._commonHttpService.create(this.addNotes, NewUrlConfig.EndPoint.DSDSAction.Contact.AddRecordingUrl).subscribe(
        //     (result) => {
        //         this.cancelRecording();
        //         this.getPage(1);
        if (this.isUploadClicked) {
            this.isUploadClicked = false;
            this._route.navigate(['/pages/newintake/my-newintake/attachment']);
        }


        if (this.selectedIndex) {
            this._alertService.success('Contact details updated successfully!');
            (<any>$('#myModal-recordings')).modal('hide'); // NOSONAR
            this.resetNotesForm();
        } else {
            this._alertService.success('Contact details saved successfully!');
            this.resetNotesForm();
        }
        //     },
        //     (error) => {
        //         this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        //     }
        // );
        //}
    }

    private returnRecordingsubTypeFn(): any {
        return (this.addNotes['progressnotesubtypeid'] ? this.addNotes['progressnotesubtypeid'] : null);
    }

    private returnRecordingTypeFn(): any {
        return (this.addNotes['progressnotetypeid'] ? this.addNotes['progressnotetypeid'] : null);
    }

    private returnInitiationindicatorFn(recording: any): any {
        return recording.initiationindicator ? true : false;
    }

    private returnAttemptindicatorFn(recording: any): any {
        return recording.attemptindicator ? true : false;
    }

    private returnProgressnotesubtypeFn() {
        return (this.recordingForm.get('progressnotesubtypeid').value) ? this.recordingForm.get('progressnotesubtypeid').value.split('~') : [];
    }

    private returnTotaltimeFn(recording: any): string {
        return recording.durationhours ? recording.durationhours + ':' + recording.durationminutes : null;
    }

    private returnTraveltimeFn(recording: any): string {
        return recording.travelhours ? recording.travelhours + ':' + recording.travelminutes : '';
    }

    editNotes(recording, index: number) {
        this.recordingForm.patchValue(recording);
        this.viewEdit = 'Edit';
        this.selectedIndex = index;
        if (recording.progressnotetypeid) {
            this.recordingSubType(recording.progressnotetypeid);
            this.recordingForm.patchValue({
                progressnotetypeid: recording.progressnotetypeid + '~' + recording.recordingtype,
                // description: recording.progressnotepurposetypekey
            });
        }
        if(recording.intakeservicerequestactorid && Array.isArray(recording.intakeservicerequestactorid))  {
            const involvedPersons = recording.intakeservicerequestactorid;
            this.personRoleList(involvedPersons);
        
            
        }
        if (recording.progressnotesubtypeid) { 
            this.recordingForm.patchValue({
                progressnotesubtypeid: recording.progressnotesubtypeid + '~' + recording.recordingsubtype,
                
            });
        }
    }

    // updateNotes() {
    //    const notes = this.recordingForm.getRawValue();
    //    if(this.selectedIndex !== null) {
    //    this.recording[this.selectedIndex] = notes;
    //    }
    //    this._alertService.success('Contact details updated successfully!');
    //    (<any>$('#myModal-recordings')).modal('hide');
    //    this.resetNotesForm();
    // }

    resetNotesForm() {
        this.viewEdit = null;
        this.selectedIndex  = -1;
        this.recordingForm.reset();
    }

    getPersonInfo(pid, role) {
        if(this.personRoles && Array.isArray(this.personRoles)) {
            const personInfo = this.personRoles.filter(person => person.intakeservicerequestactorid === pid);
            if(personInfo && personInfo.length) {
                switch(role) {
                    case 'dispName': return personInfo[0].personname;
                                   
                    case 'role': return personInfo[0].role;
                                 
                    default: return personInfo[0].displayname;
                    
                     
                }
                
            }
            return null;  
        }
      return null;  
 
        
    }

    editRecording(recording, viewEdit: string, typeOfEdit: string, index: number) {

        this.editRecord = recording;
        this.viewEdit = viewEdit;
        if (viewEdit === 'View') {
            this.updateAppend.disable();
        } else {
            this.updateAppend.enable();
        }
        if (typeOfEdit === 'draftEdit') {
            this.draftEditFn(recording);
        } else {
            this.recordingForm.reset();
        }
        const start_date = this.datePipe.transform(recording.starttime, 'hh:mm a');
        const end_date = this.datePipe.transform(recording.endtime, 'hh:mm a');
        this.recordingForm.controls['starttime'].patchValue(start_date);
        this.recordingForm.controls['endtime'].patchValue(end_date);
        this.timeDuration();
        if (recording.attemptind !== null) {
            this.recordingForm.patchValue({
                attemptindicator: recording.attemptind === true ? 'yes' : 'no'
            });
            this.attempText = false;
        } else {
            this.attempText = true;
        }
        if (recording.initiateind !== null) {
            this.recordingForm.patchValue({
                initiationindicator: recording.initiateind === true ? 'yes' : 'no'
            });
            this.initiateText = false;
        } else {
            this.initiateText = true;
        }
    }
    private draftEditFn(recording: any) {
        const address = this.returnIfParticipanttypekeyIsOth(recording);
        this.recordingForm.patchValue(
            Object.assign(
                {
                    participanttypekey: recording.contactparticipant && recording.contactparticipant.length > 0 && recording.contactparticipant[0].participanttypekey,
                    progressnotereasontypekey: recording.progressnotereasontypekey,
                    description: recording.detail,
                    travelhours: this.returnTravelhoursFn(recording, 0),
                    travelminutes: this.returnTravelhoursFn(recording, 1),
                    durationhours: this.returnDurationhoursFn(recording, 0),
                    durationminutes: this.returnDurationhoursFn(recording, 1)
                },
                recording,
                address && address.length > 0 && address[0] ? address[0] : ''
            )
        );
        const contactDate = (recording.contactdate) ? new Date(recording.contactdate) : null;
        this.recordingForm.patchValue({ 'contactDate': contactDate });
        if (recording.progressnotetypeid) {
            this.recordingForm.patchValue({
                progressnotetypeid: recording.progressnotetypeid + '~' + recording.recordingtype,
                description: recording.progressnotepurposetypekey
            });
        }
        if (recording.progressnotecontacttrialvisit && recording.progressnotecontacttrialvisit.length) {
            this.courtForm.patchValue(recording.progressnotecontacttrialvisit[0]);
        }
        const serviceReqId = [];
        recording.contactparticipant && recording.contactparticipant.map((res) => {
            serviceReqId.push(res.intakeservicerequestactorid);
            this.personRoleList(serviceReqId);
        });
        this.recordingForm.controls['intakeservicerequestactorid'].patchValue(serviceReqId);
        if (recording.progressnotesubtypeid) {
            this.recordingSubType(recording.progressnotesubtypeid);
        }

        if (recording.recordingtype === 'Court approved Trial Home Visit') {
            this.isCourtDetails = true;
        } else {
            this.isCourtDetails = false;
        }
    }

    private returnDurationhoursFn(recording: any, index: number): any {
        return recording.totaltime ? recording.totaltime.split(':')[index] : '';
    }

    private returnTravelhoursFn(recording: any, index: number): any {
        return recording.traveltime ? recording.traveltime.split(':')[index] : '';
    }

    private returnIfParticipanttypekeyIsOth(recording: any) {
        return recording.contactparticipant && recording.contactparticipant.map((res) => {
            if (res.participanttypekey === 'Oth') {
                return {
                    firstname: res.firstname,
                    lastname: res.lastname,
                    address1: res.address1,
                    address2: res.address2,
                    city: res.city,
                    state: res.state,
                    zipcode: res.zipcode,
                    email: res.email,
                    phonenumber: res.phonenumber
                };
            }
        });
    }

    changeMinit(model, name) {
        const minit = Number(model);
        if (minit && minit > 59) {
            this._alertService.warn('Please enter valid time');
            if (name === 'duration') {
                this.recordingForm.controls['durationminutes'].reset();
                this.setEndData();
            } else if (name === 'travel') {
                this.recordingForm.controls['travelminutes'].reset();
            }
        } else {
            if (name === 'duration') {
                this.setEndData();
            }
        }
    }

    setEndData() {
        const minit = this.recordingForm.controls['durationminutes'].value;
        const hour = this.recordingForm.controls['durationhours'].value;
        const calminits = (hour * 60) + Number(minit);
        const start_date = moment(this.recordingForm.value.starttime, 'HH:mm a');
        if (minit && hour && start_date) {
            const enddate = start_date.add(moment.duration(calminits, 'minutes'));
            this.recordingForm.controls['endtime'].setValue(enddate);
        }
    }
    updateRecording(recording, updateType: string) {
        if (recording.attemptindicator !== null) {
            recording.attemptindicator = recording.attemptindicator === 'yes' ? true : false;
        }
        if (recording.initiationindicator !== null) {
            recording.initiationindicator = recording.initiationindicator === 'yes' ? true : false;
        }
        if (updateType === 'darft') {
            const progressNoteTypeKey = this.recordingForm.get('progressnotetypeid').value.split('~');
            recording.progressnotetypeid = progressNoteTypeKey[0];
        } else {
            this.recordingForm.get('progressnotetypeid').reset();
        }
        if (recording.contactdate) {
            recording.contactdate = moment(recording.contactdate) 
                .format();
        }
        this.updateRecordingApiFn(recording);
    }

    private updateRecordingApiFn(recording: any) {
        const data = Object.assign({
            intakeservicerequestactorid: null,
            participanttypekey: this.recordingForm.value.participanttypekey,
            firstname: this.recordingForm.value.firstname ? this.recordingForm.value.firstname : '',
            lastname: this.recordingForm.value.lastname ? this.recordingForm.value.lastname : '',
            address1: this.recordingForm.value.address1 ? this.recordingForm.value.address1 : '',
            address2: this.recordingForm.value.address2 ? this.recordingForm.value.address2 : '',
            city: this.recordingForm.value.city ? this.recordingForm.value.city : '',
            state: this.recordingForm.value.state ? this.recordingForm.value.state : '',
            zipcode: this.recordingForm.value.zipcode ? this.recordingForm.value.zipcode : '',
            email: this.recordingForm.value.email ? this.recordingForm.value.email : '',
            phonenumber: this.recordingForm.value.phonenumber ? this.recordingForm.value.phonenumber : ''
        });
        const otherPerson = [];
        otherPerson.push(data);
        this.recordingedit = Object.assign(
            {
                contactparticipant: this.recordingForm.value.participanttypekey === 'IP' ? this.progressNoteRoleType : otherPerson,
                entitytypeid: this.id,
                savemode: this.editRecord.draft ? 1 : 0,
                contacttrialvisit: this.courtForm.value,
                entitytype: 'intakeservicerequest',
                stafftype: 1,
                instantresults: 1,
                contactstatus: false,
                drugscreen: false,
                description: recording.appendtitle,
                traveltime: recording.travelhours ? recording.travelhours + ':' + recording.travelminutes : '',
                totaltime: recording.durationhours ? recording.durationhours + ':' + recording.durationminutes : null
            },
            recording
        );
        this._commonHttpService.patch(this.editRecord.progressnoteid, this.recordingedit, NewUrlConfig.EndPoint.DSDSAction.Contact.UpdateRecordingUrl).subscribe(
            (result) => {
                this.cancelRecording();
                this.getPage(1);
                this._alertService.success('Contact details updated successfully!');
                (<any>$('#myModal-recordings-edit')).modal('hide'); // NOSONAR
                this._speechRecognitionService.destroySpeechObject();
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    cancelRecording() {
        (<any>$('#myModal-recordings')).modal('hide'); // NOSONAR
        (<any>$('#myModal-recordings-edit')).modal('hide'); // NOSONAR
        this._speechRecognitionService.destroySpeechObject();
        this.recordingForm.reset();
        this.courtForm.reset();
        this.progressNoteActor = [];
        this.updateAppend.reset();
        this.duration = '';
        this.isSerachResultFound = false;
        this.isCourtDetails = false;
        this.viewEdit = 'Add';
    }
    private recordingDropDown() {
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                new PaginationRequest({
                    where: { activeflag: 1 },
                    method: 'get',
                    nolimit: true
                }),
                NewUrlConfig.EndPoint.DSDSAction.Contact.ListProgressTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                new PaginationRequest({
                    where: { activeflag: 1 },
                    method: 'get',
                    nolimit: true
                }),
                'Contactroletypes' + '?filter'
            ),
            this._commonHttpService.getArrayList({ where: { objecttypekey: 'CPT' }, nolimit: true, method: 'get' }, 'Participanttypes' + '?filter')
        ]).pipe(
            map((result) => {
                return {
                    recordingType: result[0],
                    contactRoles: result[1],
                    participantType: result[2]
                };
            }),
            share(),);
        this.recordingType$ = source.pipe(pluck('recordingType'));
        this.contactRoles$ = source.pipe(pluck('contactRoles'));
        this.participantType$ = source.pipe(pluck('participantType'));
    }
    private attachmentDropdown() {
        this.attachmentGrid$ = this._commonHttpService.getArrayList(
            new PaginationRequest({
                nolimit: true,
                method: 'get'
            }),
            NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentGridUrl + '/' + this.id + '?data'
        );
    }
    checkInitialFaceToFace() {
        let isInitialFTF: RecordingNotes[] = [];
        this.recording$.subscribe((result) => {
            isInitialFTF = result.filter((res) => res.recordingtype === 'Initialfacetoface');
            this.recordingType$.subscribe((res) => {
                const progressnote = res.filter((item) => item.progressnotetypekey === 'Initialfacetoface');
                if (!isInitialFTF.length && progressnote.length && this.userInfo.role.teamtypekey === 'CW') {
                    this.initialFace = true;
                    this.recordingForm.get('progressnotesubtypeid').enable();
                    this.isCourtDetails = false;
                    this.recordingForm.patchValue({
                        progressnotetypeid: progressnote[0].progressnotetypeid + '~' + progressnote[0].progressnotetypekey
                    });
                    this._alertService.error('Initial Face to Face is Mandatory');
                }
            });
        });
    }
    checkParticipantsRole(saveType) {
        return true;
    }

    ngOnDestroy() {
        this._speechRecognitionService.destroySpeechObject();
    }

    activateSpeechToText(): void {
        this.recognizing = true;
        this.speechRecogninitionOn = !this.speechRecogninitionOn;
        if (this.speechRecogninitionOn) {
            this._speechRecognitionService.record().subscribe(
                // listener
                (value) => {
                    this.speechData = value;
                    if (this.viewEdit === 'Edit') {
                        this.enableAppend = true;
                        this.updateAppend.patchValue({ appendtitle: this.speechData });
                    } else {
                        this.recordingForm.patchValue({ description: this.speechData });
                    }
                },
                // errror
                (err) => {
                    this.recognizing = false;
                    if (err.error === 'no-speech') {
                        this.notification = `No speech has been detected. Please try again.`;
                        this._alertService.warn(this.notification);
                        this.activateSpeechToText();
                    } else if (err.error === 'not-allowed') {
                        this.notification = `Your browser is not authorized to access your microphone. Verify that your browser has access to your microphone and try again.`;
                        this._alertService.warn(this.notification);
                    } else if (err.error === 'not-microphone') {
                        this.notification = `Microphone is not available. Plese verify the connection of your microphone and try again.`;
                        this._alertService.warn(this.notification);
                    }
                },
                // completion
                () => {
                    this.speechRecogninitionOn = true;
                    this.activateSpeechToText();
                }
            );
        } else {
            this.recognizing = false;
            this.deActivateSpeechRecognition();
        }
    }
    deActivateSpeechRecognition() {
        this.speechRecogninitionOn = false;
        this._speechRecognitionService.destroySpeechObject();
    }


    startDateChanged(investigationForm) {
        const empForm = investigationForm.getRawValue();
        this.minDate = new Date(empForm.contactdatefrom);
    }

    endDateChanged(investigationForm) {
        const empForm = investigationForm.getRawValue();
        this.maxDate = new Date(empForm.contactdateto);
    }

    redirectToUpload() {
        this.isUploadClicked = true;
        this.saveRecording(this.recordingForm.value, 'SAVE');
    }
}
