import { Component, ViewChild, TemplateRef, OnInit } from '@angular/core';
import { addDays } from 'date-fns';
import { Subject } from 'rxjs';
import { CalendarEvent, CalendarEventAction, CalendarEventTimesChangedEvent, CalendarView } from 'angular-calendar';
import { AlertService, GenericService, AuthService, CommonHttpService, DataStoreService } from '../../@core/services';
import { PaginationRequest } from '../../@core/entities/common.entities';
import { CalendarEvents } from './_entities/usercalendar-entity.module';
import { Router } from '@angular/router';
import { CaseWorkerUrlConfig } from '../case-worker/case-worker-url.config';
import { AppConstants } from '../../@core/common/constants';
import _ from 'lodash';
import { FormBuilder, FormGroup} from '@angular/forms';
import { GLOBAL_MESSAGES } from '../../../app/@core/entities/constants';
const colors: any = {
    blue: {
        primary: '#1e90ff',
        secondary: '#D1E8FF'
    },
    green: {
        primary: '#2e7d32',
        secondary: '#C8E6C9'
    },
    orange: {
        primary: '#ef6c00',
        secondary: '#FFE0B2'
    },
    purple: {
        primary: '#6a1b9a',
        secondary: '#E1BEE7'
    },
    pink: {
        primary: '#c2185b',
        secondary: '#F8BBD0'
    }
};

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'user-calendar',
    standalone: false,
    templateUrl: './user-calendar.component.html',
    styleUrls: ['./user-calendar.component.scss']
})
export class UserCalendarComponent implements OnInit {
    CalendarView = CalendarView;
    view: CalendarView = CalendarView.Month;
    @ViewChild('modalContent') modalContent!: TemplateRef<any>;
    deletepopupid = '#delete-popup';
    activeDayIsOpen = false;

    viewDate: Date = new Date();
    clickedDate: Date = new Date();

    modalData!: {
        action: string;
        event: CalendarEvent;
    };
    calendarEvent!: CalendarEvents[];
    actions: CalendarEventAction[] = [
        {
            label: '',
            onClick: ({ event, sourceEvent }: { event: CalendarEvents, sourceEvent: MouseEvent }): void => {
                this.handleEvent('Edited', event);
            }
        }
    ];

    refresh: Subject<any> = new Subject();
    
    events: CalendarEvent[] = [];
    psychotropicprescriptionreviewForm!:FormGroup ;
    addeventid = '#add-event';
    
    
    event: any = {
                id: '',
                title:'',
                appointmenttype:'',
                appointmentdate:'',
                starttime:'',
                endtime:'',
                locationtype: 0,
                address: { address1: '', address2: '', city: '', state: '', zipcode: '', county: ''},
                attendees:'',
                appointmentdetails:'',
                other:null,
                isinperson:null
            };
    attendeesList: any = [];
    popupPosition = { x: "", y: "" };
    eventsToBeShownOnDialog: CalendarEvent[] = [];
    selectedDay:any;
    selectedDate:any;
    days = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
    eventsObjDate :any;
    userInfo: any;
    selectType: any;
    clearData = false;
    eventColorList = [
        colors.blue,
        colors.green,
        colors.orange,
        colors.purple,
        colors.pink
    ];
    attendeesDropdownList: any[] = [];
    weekEvents: any = [];
    dayEvents:any = [];
    filteredCases: any[] = [];
    filteredCasesPopup: any[] = [];
    caseSearchText: string = "";
    constructor(
        private readonly _service: GenericService<CalendarEvents>,
         private readonly router: Router,
         private readonly authService: AuthService,
         private readonly commonHttpService: CommonHttpService,
         private readonly _formBuilder: FormBuilder,
         private readonly dataStoreService: DataStoreService,
         private readonly _alertService: AlertService,
         private readonly _genericservice: GenericService<any>
         ) {}

    // tslint:disable-next-line:use-life-cycle-interface
    ngOnInit() {
        this.userInfo = this.authService.getCurrentUser();
        this.getNotificationData();
        this.psychotropicprescriptionreviewForm = this._formBuilder.group({
            casenumber:[""],
            personid:[""],
            countytypekey:[""],
            type:[""],
            eventdate:[""],
            eventtitle:[""],
            attendees:[""]
        });
        this.loadclientlist();
    }
    
    objectid:any;
    objecttypekey:any;
    selectedCaseNumber:any;
    objecttypeid:any;
    caseChanged(value:any) {
        this.selectedCaseNumber = value;
        const selectedcase = this.cases.find((c: any) => c.casenumber === value);

        this.objectid = selectedcase?.objectid;
        this.objecttypekey = selectedcase?.objecttypekey;
        this.objecttypeid = selectedcase?.intakeservreqtypeid;
        this.clientlist = this.clients.filter((item:any)=> item.casenumber === value);
        this.psychotropicprescriptionreviewForm.patchValue({
          countytypekey:selectedcase?.countyid
        })
        if (this.psychotropicprescriptionreviewForm.value.casenumber || this.selectedCaseNumber || this.personid) {
            this.events = [];
            this.weekEvents = [];
            this.dayEvents = [];
            this.applySearchFilter();
            this.gethealthpassportcollateral();
        }
    }
      selectedclient:any;
      personid = null;
    clientselected(client: any, isPopup = false) {
        this.dataStoreService.setData('personid', client);

        this.selectedclient = this.clientlist?.filter((cl: any) => cl.personid === client)
        if (this.selectedclient) {
            this.personid = this.selectedclient[0]?.personid;

        }
        if (!this.clientlist) {
            this.personid = client;

        }

        if (this.psychotropicprescriptionreviewForm.value.personid || this.personid || this.selectedCaseNumber) {
            this.events = [];
            this.weekEvents = [];
            this.dayEvents = [];
            this.applySearchFilter();
            this.gethealthpassportcollateral();
        }

        this.loadcasenumber(client, isPopup);
    }
    loadcasenumber(personid?:any, isPopup:boolean = false) {
        if (personid == null || personid == undefined) {
            this.cases = this.clientlist
        } else {
            this.cases = this.clientlist?.filter((item: any) => item?.personid == personid);
        }
        if (isPopup) {
            this.filteredCasesPopup = [...this.cases];
        } else {
            this.filteredCases = [...this.cases];
        }
    }
      cancelAddEvent(clearData: boolean = false) {
          if (this.clearData || clearData) {
              this.personid = null;
              this.selectedCaseNumber = null;
          }
          this.getNotificationData();
          this.loadclientlist(true);
          (<any>$(this.addeventid)).modal('hide');
      }
      getNotificationData() {
        const getCalenderEventAPI = CaseWorkerUrlConfig.EndPoint.UserCalendar.CalendarEventsUrl;  
    
        this._service
            .getArrayList(
                new PaginationRequest({
                    method: 'get',
                    nolimit: true
                }),
                getCalenderEventAPI + '?filter'
            )
            .subscribe((Response) => {
                this.calendarEvent = Response;
                let events = this.calendarEvent.map((item, index) => {
                    return {
                        start: addDays(new Date(item.targetdate), 0),
                        title: item.comments + ' (' + item.servicerequestnumber + ')',
                        color: this.eventColorList[index % this.eventColorList.length],
                        servicerequestnumber: item.servicerequestnumber,
                        intakeservicereqid: item.intakeservicereqid
                    } as CalendarEvents;
                });
                this.gethealthpassportcalendardata(events, true);
                this.refresh.next(true);
            });
    }
    
    gethealthpassportcalendardata(eve1?: any, isExam?: any) {
        const getNewCalenderEventAPI = CaseWorkerUrlConfig.EndPoint.UserCalendar.healthpassportcalendarUrl; 
    
        this._service
            .getArrayList(
                new PaginationRequest({
                    method: 'get',
                    nolimit: true,
                    where: this.getCalendarFilterPayload()
                }),
                getNewCalenderEventAPI + '?filter'
            )
            .subscribe((Response: any) => {
                this.calendarEvent = Response[0]?.gethealthpassportcalendardata || [];
                let eve:any[] = [];
    

                if (this.calendarEvent.length > 0) {
                   eve = this.calendarEvent.map((item, index) => {
                        let appDate = item.appointmentdate;
                        let a= {
                            id: item.calendardetailsid ||item.id,
                            start: this.getDateTime(new Date(appDate),item.starttime),
                            end: this.getDateTime(new Date(appDate),item.endtime),
                            title: this.convertTimeToAM_PM(item.starttime) + " " + item.title,
                            meta: {
                                title: item.title,
                                type: 'manual'
                            },
                            color:  this.eventColorList[index % this.eventColorList.length], //colors.blue,
                            appointmenttype: item.appointmenttype,
                            appointmentdate: new Date(appDate),
                            starttime: item.starttime,
                            endtime: item.endtime,
                            address: item.address,
                            attendees: item.attendees,
                            appointmentdetails: item.appointmentdetails,
                            locationtype: item.locationtype,
                            casenumber: item.casenumber,
                            personid: item.personid,
                            other:item.other,
                            isinperson:item.isinperson
                        } as CalendarEvents;
                        return a;
                    });
                }
                eve1 = eve1 ?? [];
                if (
                    this.psychotropicprescriptionreviewForm.value.casenumber ||
                    this.psychotropicprescriptionreviewForm.value.personid ||
                    this.psychotropicprescriptionreviewForm.value.type ||
                    this.psychotropicprescriptionreviewForm.value.eventdate ||
                    this.psychotropicprescriptionreviewForm.value.eventtitle ||
                    this.psychotropicprescriptionreviewForm.value.attendees ||
                    isExam
                ) {
                    this.loadHealthAppointmentList([...eve, ...eve1]);
                } else {
                    this.events = [...eve, ...eve1];
                    this.events.sort((a, b) => new Date(a.start).getTime() - new Date(b.start).getTime());
                    this.weekEvents = this.getWeekViewEvents();
                    this.dayEvents = this.getDayViewEvents();
                }
                this.refresh.next(true);
            });
    }

    getCalendarFilterPayload() {
        const formValue = this.psychotropicprescriptionreviewForm.value;
        const user = this.authService.getCurrentUser().user.userprofile;
    
        let selectedCase = null;
        let selectedClient = null;
    
        if (formValue?.casenumber) {
            selectedCase = this.cases?.find((c: any) => c.casenumber === formValue.casenumber);
        }
    
        if (formValue?.personid) {
            selectedClient = this.clientlist?.find((c: any) => c.personid === formValue.personid);
        }
    
        let servicecaseid = null;
        let intakeserviceid = null;
    
        if (selectedCase?.objecttypekey === 'servicecase') {
            servicecaseid = selectedCase?.objectid;
        }
    
        if (selectedCase?.objecttypekey === 'servicerequest') {
            intakeserviceid = selectedCase?.objectid;
        }
    
        if (selectedClient?.objecttypekey === 'servicecase') {
            servicecaseid = selectedClient?.objectid;
        }
    
        if (selectedClient?.objecttypekey === 'servicerequest') {
            intakeserviceid = selectedClient?.objectid;
        }
    
        return {
            personid: formValue.attendees ? null : (this.personid ?? formValue.personid ?? null),
            securityusersid: user.securityusersid,
            servicecaseid: formValue.attendees ? null : servicecaseid,
            intakeserviceid: formValue.attendees ? null : intakeserviceid,
            datatype: formValue.type || null,
            eventdate: formValue.eventdate ? this.formatDate(new Date(formValue.eventdate)) : null,
            eventtitle: formValue.eventtitle || null,
            attendees: formValue.attendees || null
        };
    }

    onCalendarNavigation() {
        this.activeDayIsOpen = false;
        this.getNotificationData();
    }


    reset(){
        this.selectedCaseNumber = null;
        this.selectType ="";
        this.personid = null;
        this.psychotropicprescriptionreviewForm.reset();
         this.getNotificationData();
         this.loadclientlist();
        this.attendeesDropdownList = [];
        this.caseSearchText = '';
        this.filteredCases = [...this.cases];
    }
    
    gethealthpassportcollateral() {
        this.attendeesList = [];
        if ((this.psychotropicprescriptionreviewForm.value.casenumber && 
            this.psychotropicprescriptionreviewForm.value.personid) ||
            ( this.personid && this.selectedCaseNumber)
            ) {
            const getCollateralAPI = CaseWorkerUrlConfig.EndPoint.UserCalendar.HealthPassportCollateralUrl; 
    
            this._service
            .getArrayList(
                new PaginationRequest({
                    method: 'get',
                    nolimit: true,
                    where: { objectid: this.objectid, objecttypekey:this.objecttypekey }
                }),
                getCollateralAPI + '?filter'
            )
                .subscribe((response: any) => {
                    if (response?.[0]?.healthpassportcollateral?.collateralList) {
                        this.attendeesList = [...response[0].healthpassportcollateral.collateralList];
                    }

                    if (response?.[0]?.healthpassportcollateral?.personList) {
                        
                        const personList = response[0].healthpassportcollateral.personList;
                        personList.map((person:any) => person.roles.map((role:any)=>{ role.description =  role.typedescription; return role }))

                        this.attendeesList = [...personList];
                    }

                   

                    
                    
                    if(response[0].healthpassportcollateral.workerList) {
                        const workerList = response[0].healthpassportcollateral.workerList.map((e:any)=> {
                            return { fullname: e.fullname, roles:e.roles.map((role:any)=> {role.description = role.role; return role}) }
                        })
                        this.attendeesList = [...this.attendeesList, ...workerList]
                    }
                });
        }
    }
    formatDate(d: any) {
            let month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();
    
        if (month.length < 2) 
            month = '0' + month;
        if (day.length < 2) 
            day = '0' + day;
    
        return [year, month, day].join('-');
    }
    checkAppointmentBtn() {

        return !this.personid
            || !this.event.title
            || !this.event.appointmenttype
            || !this.event.appointmentdetails
            || !this.event.appointmentdate
            || !this.event.starttime
            || (this.event.appointmenttype == 'other' && !this.event.other)
            || this.getDateTimeForCheck();

    }
    getDateTimeForCheck() {

        if (!this.event.endtime) {
            return false;
        }

        let dateAppStartTime = new Date(this.event.appointmentdate).toISOString().split('T')[0] + 'T' + this.event.starttime + ':00';
        let dateAppEndTime = new Date(this.event.appointmentdate).toISOString().split('T')[0] + 'T' + this.event.endtime + ':00';

        return new Date(dateAppStartTime).getTime() >= new Date(dateAppEndTime).getTime();
    }
    confrimDelete(flag?: boolean) {
        (<any>$(this.deletepopupid)).modal('show');
    }
    declineDelete() {
        (<any>$(this.deletepopupid)).modal('hide');
    }
    deleteEvent() {
        this.saveEvent(true);
    }
    setDefaultEndTime() {
        if (!this.event.endtime && this.event.starttime) {

            const start = this.event.starttime.split(':');

            let hour = Number.parseInt(start[0], 10) + 1;
            const minutes = start[1];

            if (hour > 23) {
                hour = 23;
            }

            this.event.endtime = (hour < 10 ? '0' + hour : hour) + ':' + minutes;
        }
    }
    saveEvent(isDelete: any = false) {
        if (this.personid) {
            const updateCalenderDetailsAPI = CaseWorkerUrlConfig.EndPoint.UserCalendar.AddUpdateHealthPassportUrl;

            this.setDefaultEndTime();

            this._genericservice.create(
                {
                    data: {
                         calendardetailsid: this.event.calendardetailsid || this.event.id || undefined,
                        casenumber: this.psychotropicprescriptionreviewForm.value.casenumber ? this.psychotropicprescriptionreviewForm.value.casenumber : this.selectedCaseNumber,
                        personid: this.psychotropicprescriptionreviewForm.value.personid ? this.psychotropicprescriptionreviewForm.value.personid : this.personid,
                        objectid: this.objectid,
                        objecttype: this.objecttypekey,
                        eventtimstamp: this.clickedDate,
                        title: this.event.title,
                        locationtype: this.event.locationtype ?? null,
                        appointmenttype: this.event.appointmenttype,
                        appointmentdate: new Date(this.event.appointmentdate).toISOString().split('T')[0] + 'T00:00:00',
                        starttime: this.event.starttime,
                        endtime: this.event.endtime,
                        address: JSON.stringify(this.event.address),
                        attendees: JSON.stringify(this.event.attendees),
                        appointmentdetails: this.event.appointmentdetails,
                        isDelete: (isDelete === true) ? true : undefined,
                        other: this.event.other,
                        isinperson: this.event.isinperson
                    }
                },
                updateCalenderDetailsAPI
            ).subscribe(
                (res: any) => {
                    const msg = isDelete ? "Event Deleted Successfully!" : "Event added successfully";
                    this._alertService.success(msg);

                    this.event = {
                        title: '',
                        appointmenttype: '',
                        appointmentdate: '',
                        starttime: '',
                        endtime: '',
                        address: '',
                        attendees: '',
                        locationtype: 0,
                        appointmentdetails: '',
                        other: null,
                        isinperson: null
                    };

                    this.personid = null;
                    this.cancelAddEvent();
                    (<any>$(this.deletepopupid)).modal('hide');
                },
                (err: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    openAppointmentFromCalendar(selectedDateTime?: Date, includeTime: boolean = false): void {
        this.dayClicked(selectedDateTime, includeTime);
    }

    dayClicked(selectedDateTime?: Date, includeTime: boolean = false): void {
        this.isViewOnly = false;
        this.caseSearchText = '';
        this.filteredCases = [...this.cases];
        this.filteredCasesPopup = [...this.cases];

        this.clickedDate = selectedDateTime ? new Date(selectedDateTime) : new Date();

        const appointmentDate = selectedDateTime
            ? this.formatDate(new Date(selectedDateTime))
            : '';

        const startTime = selectedDateTime && includeTime
            ? this.getTimeFromDate(new Date(selectedDateTime))
            : '';

        this.event = {
            id: '',
            calendardetailsid: '',
            title:'',
            appointmenttype:'',
            appointmentdate: appointmentDate,
            starttime: startTime,
            endtime:'',
            address:'',
            attendees:'',
            locationtype: null,
            appointmentdetails:'',
            other:null,
            isinperson:null
        };
       (<any>$(this.addeventid)).modal('show');
    }

    getTimeFromDate(date: Date): string {
        const hours = date.getHours().toString().padStart(2, '0');
        const minutes = date.getMinutes().toString().padStart(2, '0');

        return `${hours}:${minutes}`;
    }

    eventTimesChanged({ event, newStart, newEnd }: CalendarEventTimesChangedEvent): void {
        event.start = newStart;
        event.end = newEnd;
        this.handleEvent('Dropped or resized', event as CalendarEvents);
        this.refresh.next(true);
    }
    updateAddress(add: any) {
        this.event.address = add;
    }

    openPopAppEvent(eventDetail: any) {
        this.caseSearchText = '';
        this.filteredCasesPopup = [...this.cases]; // reset filtered cases

        this.selectedCaseNumber = eventDetail.casenumber;
        this.personid = eventDetail.personid;

        if (this.selectedCaseNumber) {
            this.clientlist = this.clients.filter((item: any) => item.casenumber === this.selectedCaseNumber);
        }

        const selectedcase = this.cases.find((c:any) => c.casenumber === eventDetail.casenumber);
        if (selectedcase) {
            this.objectid = selectedcase?.objectid;
            this.objecttypekey = selectedcase?.objecttypekey;
        }
            this.gethealthpassportcalendardata();
            setTimeout(() => {
                this.gethealthpassportcollateral();
                this.event = {
                    id: eventDetail.calendardetailsid || eventDetail.id,
                    title:eventDetail.meta.title,
                    appointmenttype: eventDetail.appointmenttype,
                    locationtype: eventDetail.locationtype,
                    appointmentdate: this.formatDate(eventDetail.appointmentdate),
                    starttime: eventDetail.starttime,
                    endtime: eventDetail.endtime,
                    address: eventDetail.address,
                    attendees:  eventDetail.attendees,
                    appointmentdetails: eventDetail.appointmentdetails,
                    other:eventDetail.other,
                    isinperson:eventDetail.isinperson
                };
                this.event.title = this.event.title.replace(/\b\d{1,2}(:\d{2})?\s?(AM|PM)\b/i, '').trim();
                (<any>$("#event-popup")).modal('hide');
                (<any>$(this.addeventid)).modal('show');
            }, 0);

            
    }
    isViewOnly = false;
    openPopAppEventView(eventDetail: any) {
        this.isViewOnly = true;
    
    
        this.personid = eventDetail?.meta?.personid || eventDetail?.personid?.[0]?.personid || null;
        this.selectedCaseNumber = eventDetail?.meta?.casenumber;
    
        setTimeout(() => {
            if (eventDetail?.meta?.type === 'meeting') {
                this.event = {
                    title: eventDetail?.meta?.title || eventDetail?.title || '',
                    appointmentdate: eventDetail?.meta?.meetingdate 
                        ? this.formatDate(new Date(eventDetail.meta.meetingdate)) : '',
                    starttime: '09:00',
                    endtime: '10:00',
                    attendees: eventDetail?.meta?.participants || '',
                    clientname: eventDetail?.meta?.selectclient || '',
                    appointmenttype: 'meeting',
                    appointmentdetails: eventDetail?.meta?.appointmentdetails || ''
                };
            } else if (eventDetail?.meta?.type === 'hearingdetails') {
                this.event = {
                    title: eventDetail?.title || '',
                    appointmentdate: eventDetail?.appointmentdate ? this.formatDate(new Date(eventDetail.appointmentdate)) : '',
                    starttime: eventDetail?.starttime || '',
                    endtime: eventDetail?.endtime || '',
                    attendees: eventDetail?.attendees || '',
                    clientname: eventDetail?.clientname || '',
                    appointmentdetails: eventDetail?.appointmentdetails || '',
                    appointmenttype: 'hearingdetails',
                    hearingtype: true
                };
            } else {
                this.event = {
                    title: eventDetail?.title,
                    casenumber:eventDetail?.meta.casenumber,
                    appointmentdate: eventDetail?.meta?.apptDate ? this.formatDate(new Date(eventDetail.meta.apptDate)) : '',
                    starttime: eventDetail?.start ? this.getTime(eventDetail.start) : '',
                    endtime: eventDetail?.end ? this.getTime(eventDetail.end) : '',
                    clientname: eventDetail?.meta?.fullname || '',
                    appointmentdetails: eventDetail?.meta?.natureofexamdesc || '',
                    appointmenttype: 'examination'
                };
            }
            this.event.title = this.event.title.replace(/\b\d{1,2}(:\d{2})?\s?(AM|PM)\b/i, '').trim();
            (<any>$("#event-popup")).modal('hide');
            (<any>$(this.addeventid)).modal('show');
        }, 0);
    }

    getTime(dateTime: string) {
        const dateStr = dateTime;
        const date = new Date(dateStr);

        const hours = date.getHours().toString().padStart(2, '0');
        const minutes = date.getMinutes().toString().padStart(2, '0');
        
        const time = `${hours}:${minutes}`;
        return time;
    }

    getModuleType(source:any) {
        
        let moduleTsourceype = '';
        if (source) {
          switch (source) {
            case "Intake":
              moduleTsourceype = AppConstants.CASE_TYPE.INTAKE;
              break;
            case "servicerequest":
                moduleTsourceype =  AppConstants.CASE_TYPE.CPS_CASE;
              break;
            case "servicecase":
                moduleTsourceype =  AppConstants.CASE_TYPE.SERVICE_CASE;
              break;
          }
    
          return moduleTsourceype;
        }
      }
    navigateEvent(eventDetail: any) {
        if (eventDetail?.intakeservicereqid) {
            const currentUrl = '/pages/case-worker/' + eventDetail.intakeservicereqid + '/' +
                eventDetail.servicerequestnumber + '/dsds-action/report-summary';

            this.router.navigateByUrl(currentUrl).then(() => {
                this.router.navigated = true;
                this.router.navigate([currentUrl]);
            });
        } else {
            const caseElement = this.clientlist.find(
                (el: any) => el["personid"] == eventDetail.meta.personid
            );

            const personInfo = {
                source: this.getModuleType(caseElement.objecttypekey),
                sourceID: this.objectid ?? caseElement["objectid"],
                personId: this.personid ?? caseElement["personid"],
                action: "EDIT",
                data: {
                    purposeId: this.objecttypeid ?? caseElement["intakeservreqtypeid"],
                    caseNumber: this.selectedCaseNumber ?? caseElement["casenumber"],
                }
            };

            this.dataStoreService.setObj("PERSON_NAVIGATION_INFO", personInfo);
            localStorage.setItem('navigationInfo', JSON.stringify(personInfo));
        }
    }

    handleEvent(action: string, eventDetail: any): void {
        this.isViewOnly = false;

        this.clearData = !(
            this.psychotropicprescriptionreviewForm.value.casenumber &&
            this.psychotropicprescriptionreviewForm.value.personid
        );

        if (
            eventDetail?.meta?.type === 'meeting' ||
            eventDetail?.meta?.type === 'examination' ||
            eventDetail?.meta?.type === 'hearingdetails'
        ) {
            this.openPopAppEventView(eventDetail);
        } else if (eventDetail?.meta?.type === 'manual') {
            this.openPopAppEvent(eventDetail);
        } else {
            this.modalData = { event: eventDetail, action: action };

            this.router.routeReuseStrategy.shouldReuseRoute = function () {
                return false;
            };

            this.navigateEvent(eventDetail);
        }
    }

    user:any;
    clientlist:any =[];
    caselist:any[] =[];
    clients:any = [];
    cases:any =[];
loadclientlist(isPopup:boolean = false) {
    this.user = this.authService.getCurrentUser().user.userprofile;
    const getCaseNumbersCalenderAPI = CaseWorkerUrlConfig.EndPoint.UserCalendar.CaseNumberHealthPassportUrl;  

    this.commonHttpService.getArrayList(
        { where: { securityusersid: this.user.securityusersid }, method: 'get' },
        getCaseNumbersCalenderAPI + '?filter' 
        ).subscribe(result => {
          this.clientlist =result[0]?.getcasenumberhealthpassport;
          this.clients =this.clientlist;
          this.caselist =_.uniqBy(this.clientlist ,"casenumber");
          this.cases = this.caselist;
          if(!isPopup) {this.filteredCases = [...this.cases];}
          this.filteredCasesPopup = [...this.cases];
        })
    
      }

    filterCases() {
        const search = (this.caseSearchText || '').toLowerCase();

        this.filteredCases = this.cases.filter((c: any) =>
            c.casenumber?.toLowerCase().includes(search) ||
            c.hoh?.toLowerCase().includes(search)
        );
    }

    loadHealthAppointmentList(eve: any) {
        const getCalderlistAPI = CaseWorkerUrlConfig.EndPoint.UserCalendar.HealthAppointmentListUrl;
        const filterPayload = this.getCalendarFilterPayload();
    
        this.commonHttpService.getPagedArrayList(
            new PaginationRequest({
                method: 'get',
                where: filterPayload
            }),
            getCalderlistAPI
        ).subscribe((response: any) => {
            if (response?.[0]?.gethealthappointmentdates) {
                let healthAppointmentList = response[0].gethealthappointmentdates;
    
                this.setAttendeesDropdownList(healthAppointmentList, this.calendarEvent);
    
                if (healthAppointmentList.examination?.length) {
                    healthAppointmentList.examination.forEach((element: any) => {
                        let endDatetime;
                        if (element.starttime && !element.endtime) {
                            endDatetime = this.getDateTime(new Date(element.apptDate), element.starttime);
                            endDatetime.setHours(endDatetime.getHours() + 1);
                        } else if (!element.starttime && !element.endtime) {
                            endDatetime = this.getDateTime(new Date(element.apptDate), "10:00:00");
                            element.starttime = "09:00:00";
                        } else {
                            endDatetime = this.getDateTime(new Date(element.apptDate), element.endtime);
                        }
                        eve.push({
                            title: this.convertTimeToAM_PM(element.starttime) + " " + element.natureofexamdesc,
                            start: this.getDateTime(new Date(element.apptDate), element.starttime),
                            end: endDatetime,
                            color: this.eventColorList[eve.length % this.eventColorList.length],
                            meta: {
                                personid: element.personid,
                                casenumber: element.casenumber,
                                apptDate: element.apptDate,
                                fullname: element.fullname,
                                natureofexamdesc: element.natureofexamdesc,
                                type: 'examination'
                            }
                        });
                        if (element.nextappointmentdate) {
                            eve.push({
                                title: "8 AM " + element.natureofexamdesc,
                                start: this.getDateTime(new Date(element.nextappointmentdate), "08:00:00"),
                                end: this.getDateTime(new Date(element.nextappointmentdate), "10:00:00"),
                                color: this.eventColorList[eve.length % this.eventColorList.length],
                                meta: {
                                    personid: element.personid,
                                    casenumber: element.casenumber,
                                    apptDate: element.nextappointmentdate,
                                    fullname: element.fullname,
                                    natureofexamdesc: element.natureofexamdesc,
                                    type: 'examination'
                                }
                            });
                        }
                    });
                }
    
                if (healthAppointmentList.meeting?.length) {
                    healthAppointmentList.meeting.forEach((element: any) => {
    
                        const meetingDate = element.meetingdate;
                        const startDatetime = this.getDateTime(new Date(meetingDate), "09:00:00");
                        const endDatetime = this.getDateTime(new Date(meetingDate), "10:00:00");
    
                        const selectClient = element.recordingactor?.map((a: any) => a.firstname + ' ' + a.lastname).join(', ') || '';
                        const attendees = element.attendees?.map((p: any) => p.fullname).join(', ') || '';
    
                        eve.push({
                            title: "9 AM " + element.meetingtype,
                            start: startDatetime,
                            end: endDatetime,
                            color: this.eventColorList[eve.length % this.eventColorList.length],
                            meta: {
                                meetingrecordingid: element.meetingrecordingid,
                                servicecaseid: element.servicecaseid,
                                intakeserviceid: element.intakeserviceid,
                                casenumber: element.casenumber,
                                meetingdate: element.meetingdate,
                                participants: attendees,
                                selectclient: selectClient, 
                                appointmentdetails: element.meetingtype,
                                type: 'meeting'
                            }
                        });
                    });
                }
    
                if (healthAppointmentList.hearingdetails?.length) {
                    healthAppointmentList.hearingdetails.forEach((element: any) => {
    
                        const hearingDateTime = new Date(element.hearingdatetime);
    
                        const hearingEndDateTime = new Date(hearingDateTime);
                        hearingEndDateTime.setHours(hearingEndDateTime.getHours() + 2);
    
                        const appointmentdate = new Date(
                            hearingDateTime.getFullYear(),
                            hearingDateTime.getMonth(),
                            hearingDateTime.getDate()
                        );
    
                        const starttime =
                            hearingDateTime.getHours().toString().padStart(2, '0') + ':' +
                            hearingDateTime.getMinutes().toString().padStart(2, '0') + ':00';
    
                        const endtime =
                            hearingEndDateTime.getHours().toString().padStart(2, '0') + ':' +
                            hearingEndDateTime.getMinutes().toString().padStart(2, '0') + ':00';
    
                        const selectClient = element.attendees?.filter((item: any) => item.otherclientflag == 0) || [];
                        const attendees = element.attendees?.filter((item: any) => item.otherclientflag == 1) || [];
    
                        eve.push({
                            title: this.convertTimeToAM_PM(starttime) + " Court/Hearing",
                            start: hearingDateTime,
                            end: hearingEndDateTime,
                            meta: {
                                type: 'hearingdetails',
                                casenumber: element.casenumber
                            },
                            appointmentdate: appointmentdate,
                            starttime: starttime,
                            endtime: endtime,
                            attendees: attendees.map((item: any) => item.clientname).join(', '),
                            clientname: selectClient.map((item: any) => item.clientname).join(', '),
                            appointmentdetails: "Court/Hearing"
                        });
                    });
                }
            }
    
            eve.sort((a: any, b: any) => new Date(a.start).getTime() - new Date(b.start).getTime());
            this.events = eve;
            this.events.sort((a, b) => new Date(a.start).getTime() - new Date(b.start).getTime());
            this.weekEvents = this.getWeekViewEvents();
            this.dayEvents = this.getDayViewEvents();
        });
    }
    getDateTime(date: Date, time: string = "00:00"): Date {
        const [hours, minutes] = time.split(":").map(Number);
        date.setHours(hours, minutes, 0, 0);

        return date;
    }
    compareAttendees(a: any, b: any): boolean {
        if (!a || !b) {
            return a === b;
        }

        if (a.email && b.email) {
            return a.email === b.email;
        }

        return a.fullname === b.fullname;
    }
    convertTimeToAM_PM(time: any = "00:00") {
        const [hours] = time.split(":").map(Number);

        if (hours === 0) {
            return "12 AM";
        } else if (hours === 12) {
            return "12 PM";
        }

        return (hours < 12) ? (hours + " AM") : (hours - 12 + " PM");
    }
    openAlertPop(day: any, popupEvent:any,isOpenPop:any) {
        this.eventsToBeShownOnDialog = [];
        this.selectedDate = new Date(day.date).getDate();
        this.selectedDay = this.days[new Date(day.date).getDay()];
        this.eventsToBeShownOnDialog = this.events.filter(e => 
            this.getDateFormat(e.start) === this.getDateFormat(day.date)
        );
        if(isOpenPop) {
            const popupWidth = 250;
            const popupHeight = (this.eventsToBeShownOnDialog.length * 50) + 10;

            let left = popupEvent.clientX - 65;
            let top = popupEvent.clientY - popupHeight;

            if ((left + popupWidth) > window.innerWidth) {
                left = window.innerWidth - popupWidth - 20;
            }

            if (left < 10) {
                left = 10;
            }

            if (top < 10) {
                top = popupEvent.clientY + 20;
            }

            this.popupPosition = {
                x: "left : " + left + "px !important;",
                y: "top : " + top + "px !important;"
            };
            (<any>$("#event-popup")).modal('show');
        } else {
            this.navigate(day)
        }

       

    }
    getDateFormat(date:any) {
        return new Date(date).getFullYear() + "" + new Date(date).getMonth() + "" + new Date(date).getDate();
    }
    


    navigate(event:any){
            (<any>$("#event-popup")).modal('hide');


         if (event?.intakeservicereqid) {
            const currentUrl = '/pages/case-worker/' + event.intakeservicereqid + '/' + event.servicerequestnumber + '/dsds-action/report-summary'
            this.router.navigateByUrl(currentUrl).then(() => {
                this.router.navigated = true;
                 this.router.navigate([currentUrl]);
             });
         } else {
            const caseElement =  this.clientlist.find((el:any)=> el["personid"] == event.meta.personid )
            const personInfo = {
                source : this.getModuleType(caseElement.objecttypekey),
               sourceID : this.objectid ? this.objectid : caseElement["objectid"],
               personId : this.personid ?? caseElement["personid"],
               action : "EDIT",
               data : {
                purposeId:this.objecttypeid ? this.objecttypeid :  caseElement["intakeservreqtypeid"],
                caseNumber:this.selectedCaseNumber ? this.selectedCaseNumber:  caseElement["casenumber"],
               }
            }
            this.dataStoreService.setObj("PERSON_NAVIGATION_INFO", personInfo);
            localStorage.setItem('navigationInfo',JSON.stringify(personInfo));
            this.router.navigateByUrl('pages/person-info-cw/health/examination').then(() => {
                this.router.navigated = true;
                 this.router.navigate(['pages/person-info-cw/health/examination']);
             });
         }      
    }

    displayRoles(roles:any, key:any){

        return roles && roles.length > 0 ? roles.map(((role:any)=>role[`${key}`])).join(",") : ""
        
    }
    

    isManualEvent(event: any): boolean {
        return event?.meta?.type === "manual";
    }
    
    getOtherEventTitleClass(event: any): string {
        if (event?.meta?.type === 'examination') {
            return 'examination-title-box';
        }
    
        if (event?.meta?.type === 'meeting') {
            return 'contact-title-box';
        }
    
        if (event?.meta?.type === 'hearingdetails') {
            return 'hearing-title-box';
        }
    
        return '';
    }

    setAttendeesDropdownList(healthAppointmentList: any, healthPassportCalendarList: any[] = []) {
        let attendees: any[] = [];
    
        if (healthAppointmentList?.meeting?.length) {
            healthAppointmentList.meeting.forEach((item: any) => {
                if (item.attendees?.length) {
                    item.attendees.forEach((att: any) => {
                        const fullName = [att.firstname, att.lastname].filter(Boolean).join(' ').trim();
                        if (fullName) {
                            attendees.push(fullName);
                        }
                    });
                }
            });
        }
    
        if (healthAppointmentList?.hearingdetails?.length) {
            healthAppointmentList.hearingdetails.forEach((item: any) => {
                if (item.attendees?.length) {
                    item.attendees.forEach((att: any) => {
                        const fullName = (att.clientname || '').trim();
                        if (fullName) {
                            attendees.push(fullName);
                        }
                    });
                }
            });
        }
    
        if (healthPassportCalendarList?.length) {
            healthPassportCalendarList.forEach((item: any) => {
                if (item.attendees?.length) {
                    item.attendees.forEach((att: any) => {
                        const fullName = (att.fullname || '').trim();
                        if (fullName) {
                            attendees.push(fullName);
                        }
                    });
                }
            });
        }
    
        this.attendeesDropdownList = [...new Set(
            attendees
                .map((name: any) => (name || '').trim().replace(/\s+/g, ' '))
                .filter(Boolean)
        )];
    }

    applySearchFilter() {
        this.events = [];
        this.weekEvents =[]
        this.dayEvents = []
        this.gethealthpassportcalendardata([]);
    }

    ////////////////////////////week view functionalites starts/////////////////////////////////////////////
    getWeekViewEvents(): CalendarEvent[] {
        const groupedEvents: any = {};
    
        this.events.forEach((event: any) => {
            const key = this.getWeekEventGroupKey(event);
    
            if (!groupedEvents[key]) {
                groupedEvents[key] = [];
            }
    
            groupedEvents[key].push(event);
        });
    
        const weekEvents: CalendarEvent[] = [];
    
        Object.keys(groupedEvents).forEach(key => {
            const eventsList = groupedEvents[key].sort((a: any, b: any) =>
                new Date(a.start).getTime() - new Date(b.start).getTime()
            );
    
            weekEvents.push({
                ...eventsList[0],
                meta: {
                    ...eventsList[0].meta,
                    moreCount: eventsList.length > 1 ? eventsList.length - 1 : 0,
                    moreEvents: eventsList.length > 1 ? eventsList.slice(1) : []
                }
            });
        });
    
        return weekEvents;
    }
    
    getWeekEventGroupKey(event: any) {
        const date = new Date(event.start);
    
        return date.getFullYear() + '-' +
            date.getMonth() + '-' +
            date.getDate() + '-' +
            date.getHours() + '-' +
            date.getMinutes();
    }
    
    handleWeekEventClick(eventDetail: any) {
        this.handleEvent('Clicked', eventDetail);
    }
    
    openWeekMorePop(eventDetail: any, popupEvent: any) {
        popupEvent.stopPropagation();
    
        this.eventsToBeShownOnDialog = eventDetail?.meta?.moreEvents || [];
        this.selectedDate = new Date(eventDetail.start).getDate();
        this.selectedDay = this.days[new Date(eventDetail.start).getDay()];
    
        const popupWidth = 250;
        const popupHeight = (this.eventsToBeShownOnDialog.length * 50) + 10;
    
        let left = popupEvent.clientX - 65;
        let top = popupEvent.clientY - popupHeight;
    
        if ((left + popupWidth) > window.innerWidth) {
            left = window.innerWidth - popupWidth - 20;
        }
    
        if (left < 10) {
            left = 10;
        }
    
        if (top < 10) {
            top = popupEvent.clientY + 20;
        }
    
        this.popupPosition = {
            x: "left : " + left + "px !important;",
            y: "top : " + top + "px !important;"
        };
    
        (<any>$("#event-popup")).modal('show');
    }

    ////////////////////////////////dayView functionalities starts/////////////////////////////////////////////
    getDayViewEvents() {
        const dayEvents = this.events.filter(event =>
          new Date(event.start).toDateString() === new Date(this.viewDate).toDateString()
        );
      
        const groupedEvents: any[] = [];
      
        const timeGroups = dayEvents.reduce((groups:any, event) => {
          const timeKey = new Date(event.start).getTime();
      
          if (!groups[timeKey]) {
            groups[timeKey] = [];
          }
      
          groups[timeKey].push(event);
          return groups;
        }, {});
      
        Object.keys(timeGroups).forEach(timeKey => {
          const eventsByTime = timeGroups[timeKey];
      
          eventsByTime.slice(0, 3).forEach((event:any, index:any) => {
            if (index === 2 && eventsByTime.length > 3) {
              groupedEvents.push({
                ...event,
                meta: {
                  ...event.meta,
                  dayHiddenEvents: eventsByTime.slice(3),
                  dayMoreCount: eventsByTime.length - 3
                }
              });
            } else {
              groupedEvents.push(event);
            }
          });
        });
      
        return groupedEvents;
      }
      
      handleDayEventClick(event:any) {
        if (event?.meta?.dayMoreCount > 0) {
          return;
        }
      
        this.handleEvent('Clicked', event);
      }
      
      openDayMorePop(event:any, mouseEvent:any) {
        mouseEvent.stopPropagation();
      
        this.eventsToBeShownOnDialog = event?.meta?.dayHiddenEvents || [];
      
        this.popupPosition = {
          x: 'left:' + mouseEvent.clientX + 'px;',
          y: 'top:' + mouseEvent.clientY + 'px;'
        };
      
        (<any>$("#event-popup")).modal('show');
      }

      getShortTitle(title:any) {
        const actualTitle = title.split(' ').slice(2).join(' ');
      
        if (actualTitle.length > 12) {
          return actualTitle.substring(0, 12) + '...';
        }
      
        return actualTitle;
      }
}