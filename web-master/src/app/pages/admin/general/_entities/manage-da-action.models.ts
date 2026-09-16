export class ManageDAAction {
    intakeservreqtypeid!: string;
    intakeservreqtypekey!: string;
    description!: string;
    insertedby!: string;
    updatedby!: string;
    archiveon!: Date;
    archiveby!: Date;
    workloadweight!: number;
    investigatable!: boolean;
    Servicerequestsubtype!: ManageDAActionSubtype[];
}
export class ManageDAActionSubtype {
    servicerequestsubtypeid!: string;
    intakeservreqtypeid!: string;
    classkey!: string;
    description!: string;
    insertedby!: string;
    updatedby!: string;
    workloadweight!: number;
    investigatable!: boolean;
}
