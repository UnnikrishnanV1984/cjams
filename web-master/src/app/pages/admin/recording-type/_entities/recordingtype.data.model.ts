
export class MasterRecordingTypesConfig {
    id!: number;
    name!: string;
    description!: string;
    activeflag!: number;
    updatedby!: string;
    updatedon!: Date;
    insertedby!: string;
    insertedon!: Date;
    effectivedate: Date = new Date();
    expirationdate: Date = new Date();
    timestamp!: Date;
}


export class RecordingType {

    progressnotetypeid!: string | number | null;
    progressnotetypekey?: any;
    progressnotesubtypekey!: string;
    parentid: string | number | null | undefined;
    progressnoteclassificationtypekey!: string;
    progressnotetype!: any[];
    progressnoteclassificationtype!: string;
    description!: string;
    insertedby?: string;
    updatedby!: string;
    activeflag!: 1;
    effectivedate: Date = new Date();
    expirationdate!: Date;
    subeexpirationdate!: Date;
    name!: string;
}
