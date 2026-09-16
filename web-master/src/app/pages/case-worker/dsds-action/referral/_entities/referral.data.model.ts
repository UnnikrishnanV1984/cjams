export class ReferralsResponse {
    referralid!: string;
    intakeserviceid!: string;
    danumber!: string;
    documentdate!: Date;
    reason!: string;
    referredto!: string;
    status!: string;
    disposition!: string;
    assignedto!: string;
    referralnote!: string;
    activeflag!: number;
    updatedon!: Date;
    insertedon!: Date;
}

export class Referrals {
    intakeserviceid!: string;
    reason!: string;
    referredto!: string;
    status!: string;
    disposition!: string;
    assignedto!: string;
    referralnote!: string;
    referralid!: string;
}
