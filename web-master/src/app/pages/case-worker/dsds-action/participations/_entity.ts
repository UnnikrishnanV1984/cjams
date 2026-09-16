

    export class Servicecase {
        intakeserviceid!: string;
        casenumber!: string;
        intakenumber!: string;
        servicetype!: string;
        dasubtype!: string;
        service?: any;
        subservice?: any;
        role!: string;
        datecreated!: Date;
        dateclosed?: any;
        dispstatus!: string;
    }

    export class ServiceCaseParticipants {
        personid!: string;
        firstname!: string;
        lastname!: string;
        dob!: Date;
        gendertypekey!: string;
        dateofdeath?: any;
        cjamspid!: number;
        role!: string;
        servicecases!: Servicecase[];
        gender: any;
        age: any;
        suffix: any
    }
