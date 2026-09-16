export class GuardianshipTabInfo {
    id: string;
    name: string;
    isActive: boolean;
}
export class Guardianship {
    guardian: Guardian;
}

export class Guardian {
    WRK: WRK[];
    ATTY: WRK[];
    GOPT: WRK[];
    GOP: WRK[];
    hhsdclient: Hhsdclient;
    codestatus: Codestatus;
    funeral: Funeral[];
}

export class Funeral {
    contact: string;
    contactnumber: string;
    personid: string;
    arrangementsdescription: string;
}

export class Codestatus {
    codestatustypekey: string;
    personid: string;
    othercodestatus: string;
}

export class Hhsdclient {
    hhsclientid: string;
    personid: string;
    notes: string;
}

export class WRK {
    guardianpersontypekey: string;
    personid: string;
    guadianpersonid: string;
    startdate: string;
    enddate?: any;
}
export class GuardianshipSearch {
    personsearch: boolean;
    storeid: string;
}
