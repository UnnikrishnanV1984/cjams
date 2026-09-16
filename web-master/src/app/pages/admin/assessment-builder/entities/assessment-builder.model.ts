export class AssessmentBuilder {
    assessmenttemplateid!: string;
    name!: string;
    description!: string;
    titleheadertext!: string;
    instructions!: string;
    activeflag!: number;
    insertedby?: string;
    insertedon!: string;
    updatedby!: string;
    updatedon!: string;
    effectivedate!: Date;
    expirationdate?: Date;
    target!: string;
    subcategory!: string;
    category!: string;
    assessmenttemplatetarget!: string;
    external_templateid!: string;
}
