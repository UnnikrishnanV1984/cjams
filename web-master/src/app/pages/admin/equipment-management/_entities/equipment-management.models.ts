

export class EquipmentManagement {
    typekey!: string;
    manufactur!: string;
    model!: string;
    serialno!: string;
    whitetagnumber!: string;
    yellowtagno!: string;
    loadno!: string;
    organisationno!: string;
    found!: boolean;
    disposed!: boolean;
    upforrep!: boolean;
}
// tslint:disable-next-line:class-name
export class Equipment {
    equipmentid?: string;
    equipmenttypekey?: string;
    manufacturer!: string;
    model!: string;
    serialnumber!: string;
    whitetagnumber!: string;
    yellowtagnumber!: string;
    found!: boolean;
    disposed!: boolean;
    upforreplacement!: boolean;
    unit!: string;
    description!: string;
    comments!: string;
    dh60date?: Date;
    sutnumber!: string;
    locationcode!: string;
    roomnumber!: string;
    primarymachine!: boolean;
    transfer!: boolean;
    activeflag?: number;
    updatedby?: string;
    insertedby?: string;
    effectivedate?: Date;
    notfound?: boolean;
    loadnumber?: string;
    displayname?: string;
}

export class SelectedEquipmentManagementDetail {
    teammemberequipmentid!: string;
    teammemberid!: string;
    equipmentid!: string;
    teammember!: {
        effectivedate: Date;
        loadnumber: string;
        positioncode: string;
        roletypekey: string;
        team: {
            id: string;
            region: string;
            teamname: string;
            teamnumber: string;
            name?: string;
        };
        teamid: string;
        teammemberassignment: TeamMemberAssignment[];
    };
    equipment!: Equipment;
}
export class TeamMemberAssignment {
    securityusers!: SecurityUsers;
    securityusersid!: string;
    teammemberid!: string;
}
export class SecurityUsers {
        securityusersid!: string;
        userprofile!: UserProfile;
}
export class UserProfile {
    displayname!: string;
    firstname!: string;
    fullname!: string;
    lastname!: string;
    orgname!: string;
    orgnumber!: string;
    securityusersid!: string;
}
export class EquipmentPositionDetail {
    team!: Team;
    teammembers!: TeamMembers[];
}

export class TeamMembers {
    displayname!: string;
    firstname!: string;
    fullname!: string;
    id!: string;
    isavailable!: boolean;
    isexpired!: boolean;
    lastname!: string;
    orgname!: string;
    orgnumber!: string;
    positioncode!: string;
    roletype!: string;
    userworkstatustypekey!: string;
    workstatustype!: string;
}

export class Team {
    id!: string;
    name!: string;
    officetimingfrom!: string;
    officetimingto!: string;
    region!: string;
    teamnumber!: string;
    teamtype!: TeamType;
    teamtypekey!: string;
}

export class TeamType {
    teamtypekey!: string;
    description!: string;
}

export class TeamMember {
    region!: string;
    effectivedate?: Date;
    loadnumber?: string;
    positioncode!: string;
    roletypekey?: string;
    displayname?: string;
    teamname!: string;
    orgname!: string;
    orgnumber!: string;
}
export class TeamPosition {
    equipmentid!: string;
    positioncode!: string;
    activeflag!: number;
    insertedby!: string;
    updatedby!: string;
    effectivedate?: Date;
    region!: string;
    loadnumber?: string;
    roletype?: string;
    displayname?: string;
    teamname?: string;
    orgname?: string;
    orgnumber?: string;
    id?: string;
    lastname?: string;
    firstname?: string;
    fullname?: string;
    isavailable?: boolean;
    isexpired?: boolean;
    userworkstatustypekey?: string;
    workstatustype?: string;
}


export class EquipmentAssignment {
    equipmentid!: string;
    positioncode!: string;
    activeflag!: number;
    insertedby!: string;
    updatedby!: string;
    effectivedate?: Date;
    expirationdate?: Date;
    region!: string;
    loadnumber?: string;
    roletypekey?: string;
    displayname?: string;
    teamname?: string;
    orgname?: string;
    orgnumber?: string;
    fullname?: string;
}
