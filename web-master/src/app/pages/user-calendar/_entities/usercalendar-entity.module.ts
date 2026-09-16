import { CalendarEvent, EventColor, EventAction } from 'calendar-utils';

export class CalendarEvents implements CalendarEvent {
    targetdate!: Date;
    comments!: string;
    servicerequestnumber?: string;
    intakeservicereqid?: string;
    appointmentdate?: any;
    id?: string | number;
    start!: Date;
    calendardetailsid: string | number | undefined;
    end?: Date;
    title!: string;
    color!: EventColor;
    actions?: EventAction[];
    allDay?: boolean;
    cssClass?: string;
    resizable?: {
        beforeStart?: boolean;
        afterEnd?: boolean;
    };
    draggable?: boolean;
    meta?: any;
    eventtimstamp?: any;
    appointmenttype?: any;
    starttime?: any;
    endtime?: any;
    address?: any;
    attendees: any;
    appointmentdetails?: any;
    locationtype?: any;
    casenumber?: any;
    personid?: any;
    other?: any;
    isinperson?: any;
    
}