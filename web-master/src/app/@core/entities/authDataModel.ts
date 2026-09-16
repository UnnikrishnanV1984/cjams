import { Injectable} from '@angular/core';
import { UserProfilePhoneNumber } from '../../pages/admin/user-security-profile/_entites/user-security-profile.data.modal';
import { CountyDetail } from '../../pages/case-worker/dsds-action/as-maltreatment-information/_entities/investigation-finding.data.model';
declare var $: any;

export interface Token {
    id: string;
    ttl: number;
    created: Date;
    userId: string;
}

@Injectable()
export class AppToken implements Token {
    id!: string;
    ttl!: number;
    created!: Date;
    userId!: string;
    user: UserInfo = new UserInfo();
}

@Injectable()
export class AppUser extends AppToken {
    role: AppRole = new AppRole();
    resources: AppResource[] = [];
}

export class UserLogin {
    public email!: string;
    public password!: string;
}

export class AppRole {
    id!: string;
    name!: string;
    description!: string;
    key!: string;
    teamtypekey!: string;
}

export class AppResource {
    id!: string;
    parentid!: string;
    name!: string;
    isallowed: boolean = false;
    resourcetype!: number;
    parentkey?: string;
    resourceid?: string;
    modulekey?: string;
}
export class UserInfo {
    realm!: string;
    username!: string;
    email!: string;
    securityusersid!: string;
    emailVerified: boolean = false;
    id!: number;
    userphoto!: string;
    userprofile: UserProfile = new UserProfile();
    ismanualrouting: boolean = false;
}

export class UserProfile {
    securityusersid!: string;
    firstname!: string;
    lastname!: string;
    displayname!: string;
    primarycountycd!: string;
    fullname!: string;
    activeflag!: number;
    otherfields!: string;
    onprobation: boolean = false;
    expirationdate!: Date;
    email!: string;
    oldId!: string;
    title!: string;
    isavailable: boolean = false;
    userworkstatustypekey!: string;
    voidedby!: string;
    voidedon!: Date;
    voidreasonid!: string;
    calendarkey!: string;
    orgname!: string;
    orgnumber!: string;
    usertypekey!: string;
    autonotification: boolean = false;
    userphoto!: string;
    gendertypekey!: string;
    middlename!: string;
    dob!: Date;
    teammemberassignment: TeamMemberAssignment = new TeamMemberAssignment();
    teamtypekey!: string;
    ismanualrouting: boolean = false;
    cjamspid!: string;
    userprofilephonenumber: UserProfilePhoneNumber[] = [];
    userprofileaddress: UserProfileAddress[] = [];
    viewpreference!: string;
    supervisorid!: string;
    cwlastlogindatetime!: string;
}

export class TeamMemberAssignment {
    teammemberid!: string;
    securityusersid!: string;
    teammember: TeamMember = new TeamMember();
}

export class TeamMember {
    teammemberid!: string;
    teamid!: string;
    loadnumber!: string;
    roletypekey?: string;
    supervisorid?: string;
    team: Team = new Team();
    teammemberroletype: any;
}
export class Team {
    id!: string;
    name!: string;
    teamtypekey!: string;
    teamType: TeamType = new TeamType();
    parentteamid?: string;
    countyid?: string;
    county: CountyDetail = new CountyDetail();
}
export class TeamType {
    teamtypekey!: string;
    description!: string;
}

export interface UserRole {
    id: number;
    name: string;
    description: string;
}

export interface UserResource {
    id: string;
    parentid?: any;
    name: string;
    resourceid: string;
    resourcetype: number;
    isSelected: boolean;
    isallowed: boolean;
    isvisible: boolean;
    isenabled: boolean;
}

export interface ResourceAccess {
    role: UserRole;
    resources: UserResource[];
    parentresource: UserResource[];
}
export class UserProfileAddress {
    activeflag!: string;
    address!: string;
    city!: string;
    country!: string;
    county!: string;
    countyid!: string;
    effectivedate!: string;
    expirationdate!: string;
    oldId!: string;
    pobox!: string;
    securityusersid!: string;
    state!: string;
    userprofileaddressid!: string;
    userprofileaddresstypekey!: string;
    voidedby!: string;
    voidedon!: string;
    voidreasonid!: string;
    zipcode!: string;
    zipcodeplus!: string;
}
