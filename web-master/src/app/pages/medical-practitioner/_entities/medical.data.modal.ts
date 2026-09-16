export class Age {
    months: number;
    days: number;
}

export class MedicalDashboard {
    totalcount: string;
    assessmenttempalteid: string;
    name: string;
    titleheadertext: string;
    duedays?: any;
    displayname: string;
    age: Age;
    intakeassessment?: any;
}

export class Person {
    personid: string;
    height: string;
    weight: string;
}
