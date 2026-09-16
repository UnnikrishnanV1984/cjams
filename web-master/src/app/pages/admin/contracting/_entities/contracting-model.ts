import { Injectable } from '@angular/core';
import { initializeObject } from '../../../../@core/common/initializer';
@Injectable()
export class ContractSearchModel {
    agency_name!: string;
    type_key!: string;
    ssbg_!: string;
    fiscal_year!: Date;
    agencyname!: string;
    name!: string;
    servicerequestsubtype!: string;
    federaltaxid!: string;
    constructor(initializer?: ContractSearchModel) {
        initializeObject(this, initializer);
    }
}
