import { Subject } from 'rxjs';

import { initializeObject } from '../../../@core/common/initializer';

export class DashboardInputs {
    constructor(initializer?: DashboardInputs) {
        initializeObject(this, initializer);
    }
}

export class HighChartOptions {
    chart!: {
        plotBackgroundColor: any;
        plotBorderWidth: number;
        plotShadow: boolean;
        height: number;
        width: number;
    };
    colors!: any[];
    exporting!: { enabled: boolean; };
    title!: { text: any; };
    tooltip!: { enabled: boolean; };
    credits!: { enabled: boolean; };
    plotOptions!: {
        pie: {
            dataLabels: { enabled: boolean; };
            startAngle: number;
            endAngle: number;
            center: string[];
        };
    };
    series!: { type: string; name: string; innerSize: string; data: ((string | number)[] | { dataLabels: { enabled: boolean; }; })[]; states?: { hover: { enabled: boolean; }; }; }[];

    constructor(initializer?: HighChartOptions) {
        initializeObject(this, initializer);
    }
}
export class TeamStatisticsData {
    totalcount!: string;
    closed!: string;
    overdue!: string;
    unallocated!: string;
    allocated!: string;
    unacknowledged!: number;
    open!: string;
    cancelled!: string;
    constructor(initializer?: TeamStatisticsData) {
        initializeObject(this, initializer);
    }
}

export class BroadCostMessage {
    userannouncementid!: string;
    details!: string;
    isaccepted!: boolean;
}
export class CheckListNotificationDetails {
    totalcount!: string;
    activityid!: string;
    activitytaskid!: string;
    actvityname!: string;
    duedate!: Date;
    task!: string;
    required!: boolean;
    assignedon!: Date;
    taskstatustype!: string;
    completeddate?: Date;
    activitytasktypekey!: string;
    insertedon!: Date;
    assignloadnumber!: string;
    location?: string;
    outofoffice?: string;
    activitytaskstatustypekey!: string;
    activitytaskdispositiontypekey?: any;
    taskdescription!: string;
    startdatetime?: string;
    enddatetime?: string;
    reminderdate!: Date;
}
