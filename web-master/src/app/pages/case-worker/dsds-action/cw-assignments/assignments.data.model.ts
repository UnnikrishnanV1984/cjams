export class FromworkerDetail {
    fromworkername!: string;
    email!: string;
    cjamspid!: number;
    county?: any;
    phonenumber?: any;
}

export class ToworkerDetail {
    toworkername!: string;
    email!: string;
    cjamspid!: number;
    county!: string;
    phonenumber!: string;
}

export class Assignments {
    responsibilitytypekey!: string;
    casetype!: string;
    countyname?: any;
    teamname?: any;
    startdate?: any;
    enddate?: any;
    fromworkerdetails!: FromworkerDetail[];
    toworkerdetails!: ToworkerDetail[];
    loadnumber!: string;
    statustypekey!: string;
    localdepartment!: string;
    childinfo: any;
}
