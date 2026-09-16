import { Injectable } from '@angular/core';

@Injectable()
export class NonContractingType {
    progressnotetypeid!: string;
    sequencenumber!: number;
    providernonagreementtypekey?: string;
    activeflag!: number;
    insertedby!: string;
    typedescription!: string;
    datavalue!: number;
    editable!: number;
    updatedby!: string;
    effectivedate!: Date;
    expirationdate!: Date;
    progressnoteclassificationtypekey!: string;
    name!: string;
}
