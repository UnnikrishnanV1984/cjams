import { Injectable } from '@angular/core';
import { initializeObject } from '../../../../@core/common/initializer';
@Injectable()
export class BatchAnnualApplication {
    provideragreementtypekey!: string;
    description!: string;
    contactname!: string;
    updatedon!: Date;
    isSelected = false;
}

export class PreviousActivity {
    providername!: string;
    action!: string;
    type!: string;
    assignedca!: string;
    progressnoteid!: string;
}
export class AnnualApplication {
    text!: string;
    value!: string;
    constructor(initializer?: AnnualApplication) {
        initializeObject(this, initializer);
    }
}
