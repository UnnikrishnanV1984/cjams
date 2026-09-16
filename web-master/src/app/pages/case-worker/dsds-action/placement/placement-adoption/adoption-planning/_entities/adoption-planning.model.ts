export interface EffortDetail {
    notes: string;
    effortdate: string;
    efforttypekey: string;
    efforttype: any;
}

export interface AdoptionPlanningEffort {
    adoptionefforts: EffortDetail[];
    intakeserviceid: string;
    intakeservicerequestactorid: string;
    isnoeffort: string;
    remarks: string;
    adoptionplanningid?: any;
}
