import { Injectable } from '@angular/core';

import { initializeObject } from '../../../../../@core/common/initializer';


Injectable();
export class PersonRolesConfigData {
    servicerequesttypeconfigroleid?: string = '';
    servicerequesttypeconfigid: string = '';
    entityroletype: string = 'PersonRole';
    entityroletypekey: string = '';
    activeflag: 0;
    effectivedate?: Date;
    expirationdate?: Date;
    insertedby?: string = '';
    updatedby?: string = '';
    constructor(initializer?: PersonRolesConfigData) {
        initializeObject(this, initializer);
    }
}


