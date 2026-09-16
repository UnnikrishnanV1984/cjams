export class UserRole {
    id?: number;
    name?: string;
    roleid!: number;
    description?: string;
    created?: string;
    modified?: string;
    rolename!: string;
    isSelected?: boolean;
}
export class RoleResourceUpdate {
    id!: string;
    roleid!: number;
    roleresourceid!: string;
    resourceid!: string;
    isallowed!: boolean;
    isvisible!: boolean;
    isenabled!: boolean;
    permissiontype!: number;
}

export class UpdateRoles {
    id!: number | null;
    roleresource!: Resource[];
}
export class Addroles {
    sequencenumber!: number;
    roletypekey!: string;
    activeflag!: number;
    description!: string;
    teamtypekey!: string;
    isroutable!: boolean;
    effectivedate!: string;
    isupervisor!: boolean;
}
export class ProfileUser {
    id!: string;
    securityusersid!: string;
    email!: string;
    displayname!: string;
    userphoto?: string;
    zipcode?: number;
    county?: string;
    countyid?: string;
    phonenumber?: number;
    role!: string;
    userprofile!: UserProfile;
    gender!: string;
    teamname?: string;
    teammemberid?: any;
    teamid?: any;
    activeflagdata: any;
    descriptionpos: any;
}

export class UserProfile {
    securityusersid!: number;
    displayname!: string;
    userphoto!: string;
    role!: string;
    userprofileaddress!: UserProfileAddress[];
    userprofilephonenumber!: UserProfilePhoneNumber[];
}

export class UserProfileAddress {
    securityusersid!: number;
    address!: string;
    zipcode!: number;
    city!: string;
    county!: string;
}

export class UserProfilePhoneNumber {
    securityusersid!: number;
    userprofiletypekey!: string;
    phonenumber!: number;
    phoneextension!: number;
}
export class CreateUser {
    email!: string;
    password!: string;
    securityusersid!: string;
    rolemapping!: {
        roleid: string;
    };
}
export class PermissionRoles {
    id!: string;
    parentid!: string;
    name!: string;
    resourceid!: string;
    resourcetype!: number;
    tooltip?: any;
}
export class UserRoleProfile {
    teammemberid!: string;
    User!: UserDetails;
    Userprofileaddress!: Userprofileaddress;
    Userprofileidentifier!: Userprofileidentifier[];
    Userprofilephonenumber!: Userprofilephonenumber[];
}

export class UserDetails {
    securityusersid?: string;
    firstname!: string;
    lastname!: string;
    displayname!: string;
    fullname!: string;
    email!: string;
    isavailable!: string;
    userworkstatustypekey!: string;
    usertypekey!: string;
    autonotification!: string;
    middlename!: string;
    dob!: Date;
    gendertypekey!: string;
    userphoto!: string;
    teamtypekey!: string;
    jobtitlecd?: string;
    primarycountyid?: string;
}
export class Userprofileaddress {
    securityusersid?: string;
    userprofileaddressid?: string;
    userprofileaddresstypekey!: string;
    address!: string;
    pobox!: number;
    city!: string;
    state!: string;
    zipcode!: string;
    county!: string;
    countyid?: string;
}

export class Userprofileidentifier {
    userprofileidentifierid?: string;
    userprofileidentifiertypekey!: string;
    userprofileidentifiervalue!: string;
}
export class Userprofilephonenumber {
    userprofilephonenumberid?: string;
    userprofiletypekey!: string;
    phonenumber!: number;
}

export class UpdateUser {
    principalid!: number;
    roleid!: number;
    password!: string;
}

export class Gendar {
    activeflag!: number;
    datavalue!: number;
    editable!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    gendertypekey!: string;
    sequencenumber!: number;
    typedescription!: string;
}

export class UserType {
    sequencenumber!: number;
    usertypekey!: string;
    activeflag!: number;
    datavalue!: number;
    editable!: number;
    typedescription!: string;
    effectivedate!: Date;
    expirationdate!: Date;
    timestamp!: Date;
}

export class UserWorkStatus {
    sequencenumber!: number;
    userworkstatustypekey!: string;
    activeflag!: number;
    datavalue!: number;
    editable!: number;
    typedescription!: string;
    effectivedate!: Date;
    expirationdate!: Date;
    timestamp!: Date;
}

export class UserProfileRoles {
    userprofileaddressid!: string;
    securityusersid!: string;
    activeflag!: number;
    userprofileaddresstypekey!: string;
    address!: string;
    zipcode!: string;
    pobox!: number;
    city!: string;
    state!: string;
    effectivedate!: string;
    county!: string;
}

export class UpdateProfileDetails {
    id!: number;
    securityusersid?: string;
    realm!: string;
    username!: string;
    email!: string;
    emailVerified!: string;
    userprofile!: MainUserProfile;
    role!: UserRoles;
    userresource!: PositionAccess[];
}
export class PositionAccess {
    activeflag!: number;
    isallowed: any;
    isenabled: any;
    isvisible: any;
    old_id: any;
    permissiongroupid!: string;
    resourceid: any;
    roleid!: number;
    userid!: string;
    userresourceid!: string;
}
export class UserRoles {
    roleid!: number;
    role!: {
        id: number;
        name: string;
        description: string;
    };
}

export class MainUserProfile {
    securityusersid?: string;
    firstname!: string;
    lastname!: string;
    displayname!: string;
    fullname!: string;
    activeflag!: number;
    otherfields!: string;
    onprobation!: boolean;
    expirationdate!: Date;
    ssn!: string;
    email!: string;
    oldId!: string;
    title!: string;
    isavailable!: string;
    userworkstatustypekey!: string;
    usertypekey!: string;
    autonotification!: boolean;
    voidedby!: string;
    voidedon!: string;
    voidreasonid!: string;
    calendarkey!: string;
    orgname!: string;
    orgnumber!: string;
    userphoto!: string;
    gendertypekey!: string;
    middlename!: string;
    teamtypekey?: string;
    jobtitlecd?: string;
    primarycountyid?: string;
    dob!: Date;
    userprofileaddress!: MainUserProfileAddress[];
    userprofilephonenumber!: MainUserProfilePhonenumber[];
    usertype!: MainUsertype;
    userprofileidentifier!: Userprofileidentifier[];
    teammemberassignment!: TeamMemberAssignment;
}
export class TeamMemberAssignment {
    teammemberid!: string;
    securityusersid!: string;
    teammember!: TeamMember;
}
export class TeamMember {
    teammemberid!: string;
    teamid!: string;
    loadnumber!: string;
    team!: Team;
}
export class Team {
    id!: string;
    name!: string;
    teamtypekey!: string;
    teamtype!: TeamType;
}
export class TeamType {
    teamtypekey!: string;
    description!: string;
}

export class MainUserProfileAddress {
    userprofileaddressid!: string;
    securityusersid!: string;
    userprofileaddresstypekey!: string;
    address!: string;
    zipcode!: string;
    pobox!: string;
    city!: string;
    state!: string;
    country!: string;
    zipcodeplus!: string;
    county!: string;
    countyid?: string;
    activeflag!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    oldId!: string;
    voidedby!: string;
    voidedon!: string;
    voidreasonid!: string;
}
export class MainUserProfilePhonenumber {
    userprofilephonenumberid?: string;
    securityusersid?: string;
    userprofiletypekey!: string;
    phonenumber!: number;
    phoneextension!: string;
    activeflag!: number;
    reversephonenumber!: string;
    effectivedate!: Date;
    expirationdate!: Date;
    oldId!: string;
    voidedby!: string;
    voidedon!: string;
    voidreasonid!: string;
}

export class MainUsertype {
    usertypekey!: string;
    editable!: number;
    typedescription!: number;
    sequencenumber!: number;
    activeflag!: number;
    datavalue!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    timestamp!: Date;
}

export class PermissionGroup {
    permissiongroupid?: string;
    permissiongroupname?: string;
    description?: string;
    activeflag?: number;
    insertedby?: string;
    insertedon?: Date;
    updatedby?: string;
    updatedon?: Date;
    isSelected?: boolean;
    isActive?: boolean;
}
export class RoleName {
    roletypeid!: string;
    roletypecode!: string;
    roletypename!: string;
    shortname!: string;
    effectivedate!: Date;
    expirationdate!: Date;
    activeflag!: number;
}
export interface ResourcePermission {
    id?: string;
    parentid?: string;
    name?: string;
    resourceid?: any;
    resourcetype?: number;
    isSelected?: boolean;
    tooltip?: string;
    rolereSourceId?: string;
}

export class PermissionGroupDetail {
    permissiongroupid!: string;
    permissiongroupname!: string;
    description!: string;
    isSelected!: boolean;
}

export interface ResourceListTree {
    permissiongroupid?: string;
    permissiongroupname?: string;
    parentid?: any;
    parentname?: any;
    resourceid?: string;
    resourcename?: string;
    isvisible?: boolean;
    isenabled?: boolean;
    resourcetype?: number;
    children?: ResourceListTree[];
}
export class SaveResource {
    data?: PermissionGroup;
    permissiongroupname?: string;
    description?: string;
    resource?: Resource[];
}
export class Resource {
    id?: string;
    name!: string;
    resourceid?: string;
    isallowed?: boolean;
    isvisible?: boolean;
    isenabled?: boolean;
    roleid?: string;
    permissiontype?: number;
    roleresourceid?: string;
    temproleresourceid?: string;
    // permission?: string;
}

export class RoleResourceDetail {
    permissiongroup!: any[];
    resource!: MenuDetail[];
}
export class MenuDetail {
    parentid?: any;
    parentname?: any;
    resourceid!: string;
    resourcename!: string;
    isvisible!: boolean;
    isenabled!: boolean;
    resourcetype!: number;
    permissiontype!: number;
    roleresourceid?: string;
    children!: ModuleDetail[];
    id!: string;
}

export interface ModuleDetail {
    parentid?: string;
    parentname?: string;
    resourceid?: string;
    resourcename?: string;
    isvisible?: boolean;
    isenabled?: boolean;
    resourcetype?: number;
    permissiontype?: number;
    children?: ControlDetail[];
}

export class ControlDetail {
    parentid!: string;
    parentname!: string;
    resourceid!: string;
    resourcename!: string;
    isvisible!: boolean;
    isenabled!: boolean;
    resourcetype!: number;
    permissiontype!: number;
    children!: ActionDetail[];
}
export interface ActionDetail {
    parentid?: string;
    parentname?: string;
    resourceid?: string;
    resourcename?: string;
    isvisible?: boolean;
    isenabled?: boolean;
    resourcetype?: number;
    permissiontype?: number;
    children?: any[];
}
export class PositionDetail {
    roletypekey!: string;
    positioncode!: string;
    roleid!: string;
    teammemberid!: string;
}

export class MenuList {
    id!: string;
    resourceid!: string;
    resourcetype!: string;
    isallowed?: boolean;
    isvisible?: boolean;
    isenabled?: boolean;
    permission?: string;
    name!: string;
    isSelected?: boolean;
}

export class RolePermission {
    description!: string;
    isSelected!: boolean;
    permissiongroupid!: string;
    permissiongroupname!: string;
}

export class ResourceTree {
    id!: string;
    parentid!: string;
    name!: string;
    parentkey?: any;
    modulekey?: any;
    resourceid!: string;
    resourcetype!: number;
    activeflag!: number;
    tooltip?: any;
    description?: any;
}

