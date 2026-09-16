import { Injectable } from '@angular/core';
import { initializeObject } from '../../../../@core/common/initializer';
@Injectable()
export class MasterCatelogConfig {

    BlockTitle: string | null = null;
    LabelNameTitle: string | null = null;
    LabelDescriptionTitle: string | null = null;
    TableHeaderName: string | null = null;
    TableHeaderDescription: string | null = null;
    RouteUrl: string | null = null;
    constructor(initializer: MasterCatelogConfig) {
        initializeObject(this, initializer);
    }
}

@Injectable()
export class CatelogConfig extends MasterCatelogConfig {
    LabelBeginDateTitle: Date | null = null;
    LabelEndDateTitle: Date | null = null;
}

export class GeneralConfig {
    id!: number | string | undefined;
    sequencenumber!: number | string;
    activeflag?: number;
    datavalue?: number;
    editable?: number;
    effectivedate?: Date;
    expirationdate?: Date | null;
    name?: string;
    description?: string;
    constructor(initializer?: GeneralConfig) {
        initializeObject(this, initializer);
    }
}
export class EthnicGroupType extends GeneralConfig {
    ethnicgrouptypekey?: string;
    typedescription?: string;
    constructor(initializer: EthnicGroupType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.ethnicgrouptypekey;
        super(initializer);
    }
}
export class LanguageType extends GeneralConfig {
    languagetypeid?: string;
    languagetypename?: string | undefined;
    constructor(initializer: LanguageType) {
        initializer.id = initializer.languagetypeid;
        initializer.name = initializer.languagetypename;
        super(initializer);
    }
}
export class MaritalStatusType extends GeneralConfig {
    maritalstatustypekey?: string | undefined;
    typedescription?: string | undefined;
    constructor(initializer: MaritalStatusType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.maritalstatustypekey;
        super(initializer);
    }
}
export class RaceType extends GeneralConfig {
    racetypekey!: string | undefined;
    typedescription!: string | undefined;
    constructor(initializer: RaceType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.racetypekey;
        super(initializer);
    }
}
export class GenderType extends GeneralConfig {
    gendertypekey?: string | undefined;
    typedescription?: string | undefined;
    constructor(initializer: GenderType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.gendertypekey;
        super(initializer);
    }
}
export class IncomeType extends GeneralConfig {
    incometypekey?: string | undefined;
    typedescription?: string | undefined;
    constructor(initializer: IncomeType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.incometypekey;
        super(initializer);
    }
}
export class AddressType extends GeneralConfig {
    currentlocationflag!: number;
    personaddresstypekey?: string | undefined;
    typedescription?: string | undefined;
    personid!: string;
    danger!: boolean;
    dangerreason!: string;
    address!: string;
    address2!: string;
    zipcode!: number;
    state!: string;
    city!: string;
    county!: string;
    directions!: string;
    countydescription!: string;
    addressstartdate!: Date;
    personaddressid: any;
    Personaddresstype: any;
    durationDay:any;
    personadrenddate:any;
    constructor(initializer: AddressType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.personaddresstypekey;
        super(initializer);
    }
}
export class PhoneType extends GeneralConfig {
    personphonetypekey?: string | undefined;
    phonenumber!: number;
    personid!: string;
    ismobile!: boolean;
    typedescription?: string | undefined;
    personphonenumberid: any;
    constructor(initializer: PhoneType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.personphonetypekey;
        super(initializer);
    }
}
export class EmailType extends GeneralConfig {
    personemailtypekey!: string;
    email!: string;
    personid!: string;
    typedescription!: string;
    type!: string;
    personemailid: any;
    constructor(initializer: EmailType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.personemailtypekey;
        super(initializer);
    }
}
export class PersonRole extends GeneralConfig {
    actortype?: string | undefined;
    typedescription?: string | undefined;
    tasktype!: number;
    constructor(initializer: PersonRole) {
        initializer.description = initializer.typedescription;
        initializer.id = initializer.actortype;
        initializer.name = initializer.actortype;
        initializer.datavalue = initializer.tasktype;
        super(initializer);
    }
}
export class EmployeeType extends GeneralConfig {
    employeetypeid?: number | undefined;
    employeetypename?: string | undefined;
    constructor(initializer: EmployeeType) {
        initializer.id = initializer.employeetypeid;
        initializer.name = initializer.employeetypename;
        super(initializer);
    }
}
export class LivingArrangementType extends GeneralConfig {
    livingarrangementtypekey?: string | undefined;
    constructor(initializer: LivingArrangementType) {
        initializer.name = initializer.livingarrangementtypekey;
        super(initializer);
    }
}
export class IdentifierType extends GeneralConfig {
    personidentifiertypekey?: string | undefined;
    typedescription?: string | undefined;
    constructor(initializer: IdentifierType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.personidentifiertypekey;
        super(initializer);
    }
}

export class EntityAddressType extends GeneralConfig {
    agencyaddresstypekey?: string | undefined;
    typedescription?: string | undefined;
    constructor(initializer: EntityAddressType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.agencyaddresstypekey;
        super(initializer);
    }
}
export class EntityPhoneType extends GeneralConfig {
    agencyphonenumbertypekey?: string | undefined;
    typedescription?: string | undefined;
    constructor(initializer: EntityPhoneType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.agencyphonenumbertypekey;
        super(initializer);
    }
}
export class EntityType extends GeneralConfig {
    agencytypekey?: string | undefined;
    typedescription?: string | undefined;
    oldId!: string;
    agencycategorykey!: string;
    constructor(initializer: EntityType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.agencytypekey;
        super(initializer);
    }
}
export class EntityRoleType extends GeneralConfig {
    agencytypekey?: string | undefined;
    typedescription?: string | undefined;
    constructor(entityRoleInitializer: EntityRoleType) {
        entityRoleInitializer.description = entityRoleInitializer.typedescription;
        entityRoleInitializer.name = entityRoleInitializer.agencytypekey;
        super(entityRoleInitializer);
    }
}
export class ContactAddressType extends GeneralConfig {
    caregiveraddresstypekey?: string | undefined;
    typedescription?: string | undefined;
    constructor(initializer: ContactAddressType) {
        initializer.description = initializer.typedescription;
        initializer.name = initializer.caregiveraddresstypekey;
        super(initializer);
    }
}
export class ContactPhoneType extends GeneralConfig {
    agencyphonenumbertypekey?: string | undefined;
    typedescription?: string | undefined;
    constructor(contactPhoneTypeInitializer: ContactPhoneType) {
        contactPhoneTypeInitializer.description = contactPhoneTypeInitializer.typedescription;
        contactPhoneTypeInitializer.name = contactPhoneTypeInitializer.agencyphonenumbertypekey;
        super(contactPhoneTypeInitializer);
    }
}
export class DispositionCodeType extends GeneralConfig {
    dispositioncode!: string;
    dispositioncodeid!: string;
    insertedby?: string;
    updatedby!: string;
    intakeservreqtypeid!: string;
    constructor(initializer: DispositionCodeType) {
        super(initializer);
    }
}

export class DaStatusType {

    intakeserreqstatustypeid!: string;
    intakeserreqstatustypekey!: string;
    description!: string;
    insertedby?: string;
    updatedby!: string;
    activeflag!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    name!: string;
    constructor(initializer: DaStatusType) {
        initializeObject(this, initializer);
    }
}


export class Military extends GeneralConfig
{

}


export class Education extends GeneralConfig
{

}