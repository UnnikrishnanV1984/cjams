import { Component, OnInit, AfterViewInit, Injector } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable } from 'rxjs';
import { AuthService, CommonHttpService, AlertService, DataStoreService, CommonDropdownsService } from '../../../../@core/services';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { RoutingUser } from '../../../cjams-dashboard/_entities/dashBoard-datamodel';
import moment from 'moment';

import { IntakeAppointment, TitleDetails } from '../../../newintake/my-newintake/_entities/newintakeSaveModel';
import { InvolvedPerson } from '../../_entities/caseworker.data.model';
import { GenericService } from '../../../../@core/services/generic.service';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { ActivatedRoute } from '@angular/router';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AppConstants } from '../../../../@core/common/constants';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
declare var $: any;
const APPOINTMENT_SCHEDULED = 'Scheduled';
const APPOINTMENT_COMPLETED = 'Completed';
const APPOINTMENT_RESCHEDULED = 'Rescheduled';
const DEFAULT_APPOINTMENT_TITLE = 'Intake interview';
const SCREENING_WORKER = 'SCRNW';
const OTHER_APPOINTMENT_TITLE = 'OTHER';
const YOUTH_ORIENTATION_TITLE = 'YOP';
const ADMISSION_APPOINTMENT_TITLE = 'ADM_INTW';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'appointment',
    templateUrl: './appointment.component.html',
    styleUrls: ['./appointment.component.scss'],
    standalone: false
})
export class AppointmentComponent implements OnInit, AfterViewInit {
    id!: string;
    daNumber!: string;
    addedPersons: InvolvedPerson[] = [];
    appointmentForm!: FormGroup;
    currentUser!: AppUser;
    intakeWorkers$!: Observable<RoutingUser[]>;
    intakeWorkerList: RoutingUser[] = [];
    times: any[] = [];
    titleDropdown: TitleDetails[] = [];
    appointments: IntakeAppointment[] = [];
    isEditAppointment = false;
    isViewAppointment = false;
    isNotesRequired = false;
    showyouth = false;
    actionText = 'Create';
    titleText = 'Create';
    isYouthSelectedforAppmnt!: boolean;
    isParentSelectedforAppmnt!: number;
    appointmentInAction!: IntakeAppointment;
    maxDate = new Date();
    minDate = new Date();
    relations: any[] = [];
    roles: any[] = [];
    completionNotes = '';
    appointmentHistoryObj: IntakeAppointment[] = [];
    notes = 'Notes...';
    readOnly = false;
    token!: AppUser;
    isOtherAppointmentTitle = false;
    isDjs!: boolean;
    private formBuilder: FormBuilder;
    private _httpService: CommonHttpService;
    private _authService: AuthService;
    private _commonHttpService: CommonHttpService;
    private _alertService: AlertService;
    private _dataStoreService: DataStoreService;
    private _service: GenericService<InvolvedPerson>;
    private route: ActivatedRoute;
    private _dropDownService: CommonDropdownsService;

    constructor(private injector : Injector) {
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._httpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
		this._service = this.injector.get<GenericService<InvolvedPerson>>(GenericService);
		this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
		this._dropDownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
      }

    ngOnInit() {
        this.loadIntakeWorkers();
        this.getTitle();
        this.maxDate.setDate(new Date().getDate() + 10);
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.currentUser = this._authService.getCurrentUser();
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.initializeAppointmentForm();
        this.isYouthSelectedforAppmnt = false;
        this.isParentSelectedforAppmnt = 0;

        this.getAppointments();
        this.getInvolvedPerson();
        this.times = this.generateTimeList(false);
        this.token = this._authService.getCurrentUser();
        this.isDjs = this._authService.isDJS();
    }
    ngAfterViewInit() {
        const intakeCaseStore = this._dataStoreService.getData('IntakeCaseStore');
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
    private initializeAppointmentForm() {
        this.token = this._authService.getCurrentUser();
        this.appointmentForm = this.formBuilder.group({
            id: [''],
            title: [''],
            titleid: [''],
            appointmentdate: [''],
            appointmentDate: [''],
            appointmentTime: ['08:00'],
            appointmentworkerid: null,
            actors: [''],
            notes: [''],
            worker: [''],
            youthid: [''],
            youthssn: [''],
            youthname: ['']
        });
    }
    getAppointments() {
        this._dataStoreService.currentStore.subscribe(store => {
            if (store['dsdsActionsSummary']) {
                const actionSummary = store['dsdsActionsSummary'];
                const jsonData = actionSummary['intake_jsondata'];
                const appointments = jsonData ? jsonData['appointments'] : [];
                appointments.forEach((appointmentObj: any) => {
                    const app = this.appointments.find(appmntObj => appmntObj.id === appointmentObj.id);
                    if (!app) {
                        this.appointments.push(appointmentObj);
                    }
                });
            }
        });
        this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    method: 'get',
                    where: {
                        intakeserviceid: this.id,
                        appointmentid: null
                    }
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.appointment.getAppointmentList + '?filter'
            )
            .subscribe(caseworkerAppointments => {
                if (caseworkerAppointments) {
                    this.appointments = [...this.appointments, ...caseworkerAppointments];
                }
            });
    }

    getTitle() {
        if (this._authService.isDJS()) {
            this._dropDownService.getListByTableID('135').subscribe(result => {
                this.titleDropdown = result.map(data => {
                    return {titleid: data.ref_key, titlekey: data.description};
                });
            });
        } else {
            this.titleDropdown = [
                {
                    titleid: 'YOP',
                    titlekey: ' Youth Orientation Program'
                },
                {
                    titleid: 'COP',
                    titlekey: 'Community Orientation Appointment'
                },
                {
                    titleid: 'ADM_INTW',
                    titlekey: 'Admissions Interview'
                },
                {
                    titleid: 'OTHER',
                    titlekey: 'Other'
                }
            ];
        }
    }

    getInvolvedPerson() {
        this._service
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: { intakeservreqid: this.id }
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            )
            .subscribe(response => {
                if (response.data) {
                    this.addedPersons = response.data;
                }
            });
    }
    getPersonName(personId: any) {
        const person = this.addedPersons.find(p => p.personid === personId);
        if (person) {
            return person.lastname + ',' + person.firstname;
        }
    }
    generateAppointmentID() {
        return new Date().getTime();
    }

    resetForm() {
        this.appointmentForm.enable();
        this.appointmentForm.reset();
        this.appointmentForm.patchValue({ appointmentTime: '08:00' });
        this.isEditAppointment = false;
        this.isViewAppointment = false;
        this.isParentSelectedforAppmnt = 0;
        this.isYouthSelectedforAppmnt = false;
        this.showyouth = false;
    }

    showHistory(appointment: { history: any; }) {
        this.appointmentHistoryObj = appointment.history;
    }

    getCWAppointmentHistory(appointment: any) {
        this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    method: 'get',
                    where: {
                        intakeserviceid: appointment.intakeserviceid,
                        appointmentid: appointment.id
                    }
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.appointment.getAppointmentHistory + '?filter'
            )
            .subscribe(response => {
                if (response) {
                    if (this._authService.isDJS()) {
                        this.appointmentHistoryObj = response.map(data => {
                            data.titleid = data.title;
                            return data;
                        });
                    } else {
                        this.appointmentHistoryObj = response;
                    }
                }
            });
    }

    updateRescheduledAppointmentWithHistory(rescheduledAppointment: any) {
        const appointmentIndex = this.appointments.findIndex(appointment => rescheduledAppointment.id === appointment.id);
        const histories = [...this.appointmentInAction.history];
        this.appointmentInAction.history = [];
        histories.push(this.appointmentInAction);
        rescheduledAppointment.history = [...histories];
        this.appointments[appointmentIndex] = rescheduledAppointment;
    }

    updateScheduledAppointment(scheduledAppointment: any) {
        const appointmentIndex = this.appointments.findIndex(appointment => scheduledAppointment.id === appointment.id);
        this.appointments[appointmentIndex] = scheduledAppointment;
    }

    private setFormValidity() {
        if (this.isEditAppointment) {
            this.isNotesRequired = true;
        } else {
            this.isNotesRequired = false;
        }
    }

    getappointmentDate(date: any) {
        return moment(date).format('YYYY-MM-DD');
    }

    getappointmentTime(date: any) {
        return moment(date).format('hh:mm A');
    }

    onEditAppointment(appointment: any) {
        this.actionText = 'Update';
        this.titleText = 'Edit';
        this.isEditAppointment = true;
        this.appointmentInAction = appointment;
        appointment.appointmentTime = moment(appointment.appointmentdate).format('HH:mm');
        appointment.appointmentDate = moment(appointment.appointmentdate).format('YYYY-MM-DD');
        appointment.titleid = appointment.title;
        this.appointmentForm.patchValue(appointment);

        this.appointmentForm.patchValue({ actors: appointment.actors.map((actor: { actorid: any; }) => actor.actorid) });
        this.setFormValidity();
        this.processTitle();
    }

    confirmDelete(appointment: any) {
        this.appointmentInAction = appointment;
    }

    isDateTimeChanged(appointment: { appointmentDate: string; appointmentTime: string; }) {
        if (appointment.appointmentDate === this.appointmentInAction.appointmentDate && appointment.appointmentTime === this.appointmentInAction.appointmentTime) {
            return false;
        }

        return true;
    }

    processTitle() {
        const tilteID = this.appointmentForm.getRawValue().titleid;
        switch (tilteID) {
            case ADMISSION_APPOINTMENT_TITLE:
                this.showyouth = true;
                this.appointmentForm.controls['worker'].disable();
                this.appointmentForm.controls['youthid'].disable();
                this.appointmentForm.controls['youthname'].disable();
                this.appointmentForm.controls['youthssn'].disable();
                this.appointmentForm.controls['actors'].clearValidators();
                const data: any = this.addedPersons.find((res) => res.rolename === 'Youth');
                this.appointmentForm.patchValue({
                    worker: this.token.user.userprofile.displayname,
                    youthid: data.cjamspid,
                    youthname: data.firstname + ' ' + data.lastname,
                    youthssn: data.ssn,
                    title: this.titleDropdown
                });
                break;
            case OTHER_APPOINTMENT_TITLE:
                this.isOtherAppointmentTitle = true;
                this.showyouth = false;
                break;

            default:
                this.showyouth = false;
                this.isOtherAppointmentTitle = false;
                this.appointmentForm.controls['actors'].setValidators(Validators.required);


        }

        this.appointmentForm.controls['actors'].updateValueAndValidity();
        if (tilteID !== OTHER_APPOINTMENT_TITLE) {
            const title: any = this.titleDropdown.find(appointmentTitle => appointmentTitle.titleid === tilteID);
            this.appointmentForm.patchValue({
                title: title.titlekey
            });
        } else {
            this.appointmentForm.patchValue({
                title: ''
            });
        }
    }
    initAppointmentForm() {
        this.actionText = 'Create';
        this.titleText = 'Create';
        this.appointmentForm.patchValue({ titleid: YOUTH_ORIENTATION_TITLE, appointmentTime: '08:00' });
        this.processTitle();
    }

    hasYouthAndParentOrGaurdian() {
        return this.hasYouth() && this.hasParentOrGaurdian();
    }

    getSelectedPersons() {
        const appointmentForm = this.appointmentForm.getRawValue();
        const selectedActors = appointmentForm.actors;
        if (selectedActors) {
            return selectedActors.map((actorid: string) => this.getPerson(actorid));
        }
        return null;
    }

    hasPersonObject(propertyKey: string, role: string) {
        const persons = this.getSelectedPersons();
        let isRoleFound = false;
        if (persons) {
            const involvedperson = persons.find((person: any) => person[propertyKey] === role);
            if (involvedperson) {
                isRoleFound = true;
            } 
        }
        return isRoleFound;

    }

    hasYouth() {
        return this.hasPersonObject('rolename', AppConstants.INVOLVED_PERSON_ROLE.YOUTH);
    }

    hasParentOrGaurdian() {
        const father = this.hasPersonObject('relationship', AppConstants.INVOLVED_PERSON_ROLE.FATHER);
        const mother = this.hasPersonObject('relationship', AppConstants.INVOLVED_PERSON_ROLE.MOTHER);
        const guardian = this.hasPersonObject('relationship', AppConstants.INVOLVED_PERSON_ROLE.GUARDIAN);
        return father || mother || guardian;
    }

    createOrUpdateAppointment() {
        if (this.appointmentForm.valid) {
            const appointmentForm = this.appointmentForm.getRawValue();
            const titleID = this.appointmentForm.getRawValue().titleid;
            if (!this.hasYouthAndParentOrGaurdian() && titleID !== ADMISSION_APPOINTMENT_TITLE) {
                this._alertService.error('Please Choose Parent / Guardian and Youth');
            } else {
                if (this.isEditAppointment) {
                    this.updateAppointment(appointmentForm);
                } else {
                    this.createAppointment();
                }
                this.resetForm();
                $('#intake-appointment').modal('hide');
            }
        } else {
            this._alertService.error('Please fill the required fields');
        }
        this.getAppointments();
    }

    updateAppointment(appointmentForm: any) {
        const appointmentId = this.appointments.findIndex(appointment => appointment.id === this.appointmentInAction.id);
        const AppointmentAction = this.isDateTimeChanged(appointmentForm) ? APPOINTMENT_RESCHEDULED : APPOINTMENT_SCHEDULED;
        const editAppointment = this.createAppointmentObject(AppointmentAction);
        editAppointment.servreqaptmtid = this.appointmentInAction.servreqaptmtid;
        editAppointment.id = this.appointmentInAction.id;
        editAppointment.title = editAppointment.titleid;
        this._commonHttpService.create(editAppointment, CaseWorkerUrlConfig.EndPoint.DSDSAction.appointment.addupdateAppointment).subscribe(
            res => {
                if (appointmentId !== -1) {
                    this.appointments[appointmentId] = res;
                }

                this._alertService.success('Appointment Updated successfully!');
                this.appointmentForm.reset();
            },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    createAppointment() {
        const newAppointment = this.createAppointmentObject(APPOINTMENT_SCHEDULED);
        newAppointment.id = this.generateAppointmentID();
        newAppointment.title = newAppointment.titleid;
        this._commonHttpService.create(newAppointment, CaseWorkerUrlConfig.EndPoint.DSDSAction.appointment.addupdateAppointment).subscribe(
            res => {
                this.appointments.push(res);
                this.appointmentForm.reset();
                this._alertService.success('Appointment Created successfully!');
            },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    createAppointmentObject(status: any) {
        let actors = [];
        if (this.appointmentForm.getRawValue().titleid === ADMISSION_APPOINTMENT_TITLE) {
            const youth: any = this.addedPersons.find((res) => res.rolename === 'Youth');
            actors = [{ actorid: youth.personid, isoptional: false }];
        } else {
            actors = this.createActors();
        }

        const appointmentObject = new IntakeAppointment();
        const appointmentForm = this.appointmentForm.getRawValue();
        appointmentObject.title = appointmentForm.title;
        appointmentObject.titleid = appointmentForm.titleid;
        appointmentObject.youthid = appointmentForm.youthid;
        appointmentObject.youthname = appointmentForm.youthname;
        appointmentObject.youthssn = appointmentForm.youthssn;
        appointmentObject.worker = appointmentForm.worker;
        appointmentObject.status = status;
        appointmentObject.intakeserviceid = this.id;
        appointmentObject.notes = appointmentForm.notes;
        appointmentObject.isChanged = false;
        appointmentObject.appointmentworkerid = appointmentForm.appointmentworkerid;
        appointmentObject.appointmentworkername = this.token.user.userprofile.displayname;
        appointmentObject.scheduledBy = this.currentUser.user.userprofile.fullname;
        appointmentObject.appointmentdate = moment(this.appointmentForm.value.appointmentDate).format('YYYY/MM/DD') + ' ' + this.appointmentForm.value.appointmentTime;
        appointmentObject.actors = actors;

        return appointmentObject;
    }

    createActors() {
        return this.appointmentForm.value.actors.map((actor: string) => {
            const person: any = this.getPerson(actor);
            return { actorid: actor, isoptional: false, firstName: person.firstname, lastName: person.lastname };
        });
    }

    getPerson(personId: string) {
        const person = this.addedPersons.find(p => p.personid === personId);
        if (person) {
            return person;
        }
        return null;
    }

    deleteAppointmentConfirm() {
        const appointmentIndex = this.appointments.findIndex(appointment => appointment.id === this.appointmentInAction.id);
        this._commonHttpService.remove(this.appointmentInAction.servreqaptmtid, this.appointmentInAction, CaseWorkerUrlConfig.EndPoint.DSDSAction.appointment.deleteAppointment).subscribe(
            () => {
                this._alertService.success('Deleted Successfully');
                this.appointments.splice(appointmentIndex, 1);
                this.resetForm();
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    isCaseWorkerAppointment(appointment: any) {
        return !appointment.intakeWorkerId;
    }

    onCompleteAppointment(appointment: any) {
        this.completionNotes = '';
        this.appointmentInAction = appointment;
        this.readOnly = false;
    }

    appointmentCompleteConfirm() {
        if (this.appointmentInAction) {
            const appointmentIndex = this.appointments.findIndex(appointment => this.appointmentInAction.id === appointment.id);
            if (this.completionNotes !== '') {
                this.appointments[appointmentIndex].notes = this.completionNotes;
                this.appointments[appointmentIndex].status = APPOINTMENT_COMPLETED;
                this._commonHttpService.create(this.appointments[appointmentIndex], CaseWorkerUrlConfig.EndPoint.DSDSAction.appointment.addupdateAppointment).subscribe(
                    res => {
                        this.appointmentForm.reset();
                        this._alertService.success('Appointment Completed successfully!');
                        $('#complete-appointment-popup').modal('hide');
                    },
                    error => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                this._alertService.error('Completion notes is required');
            }
        }
    }

    openAppointmentComments(appointment: { notes: string; }) {
        this.completionNotes = appointment.notes;
        this.readOnly = true;
    }

    private loadIntakeWorkers() {
        this._commonHttpService
            .getPagedArrayList(
                {
                    method: 'get',
                    nolimit: true,
                    page: 1,
                    limit: 50,
                    order: 'username'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.appointment.intakeWorkerList + '?filter'
            )
            .subscribe(response => {
                this.intakeWorkerList = response.data;
            });
    }

    getIntakeWorkerName(appointmentworkerid: string) {
        const intakeWorker = this.intakeWorkerList.find(iw => iw.userid === appointmentworkerid);
        if (intakeWorker) {
            return intakeWorker.username;
        }
        return null;
    }

    private generateTimeList(is24hrs = true) {
        const x = 15;
        const times = []; 
        const ap = [' AM', ' PM']; 

        for (let tt = 0; tt < 24 * 60; tt+=x) {
            const hh = Math.floor(tt / 60); 
            const mm = tt % 60; 
            if (is24hrs) {
                times.push(('0' + (hh % 24)).slice(-2) + ':' + ('0' + mm).slice(-2)); 
            } else {
                times.push(('0' + (hh % 12)).slice(-2) + ':' + ('0' + mm).slice(-2) + ap[Math.floor(hh / 12)]); 
            }
        }
        return times;
    }
}
