import { initializeObject } from '../common/initializer';

export class PaginationInfo {
    sortBy:string | null = 'desc';
    sortColumn: string | null = 'receiveddate';
    pageSize = 10;
    pageSize20 = 20;
    pageSize25 = 25;
    pageSize50 = 50;
    pageSize250 = 250;
    pageNumber = 1;
    pagenumber = 1;
    total = -1;
    loading = true;
    where?: any;
}

export class PaginationRequest {
    count?= -1;
    limit?: number | null;
    personpagelimit?: number;
    nolimit?: boolean;
    page?: number | null;
    order?: string | null;
    where?: any;
    include?: any;
    method?: string;
    securityuserid?: string;
    constructor(initializer?: PaginationRequest) {
        initializeObject(this, initializer);
    }
}


export class PersonPaginationRequest {
    count?= -1;
    limit?: number;
    personpagelimit?: number;
    nolimit?: boolean;
    page?: number;
    order?: string;
    where?: any;
    include?: any;
    method?: string;
    constructor(initializer?: PersonPaginationRequest) {
        initializeObject(this, initializer);
    }
}


export class ListDataItem<T> {
    data!: T[];
    count!: number;
}

export class DropdownModel {
    text: any;
    value: any;
    parent_provider_name?: any;
    additionalProperty?: any;
    description?: any;
    ref_key?: any;
    picklist_value_cd?:any;
    value_tx?:any;
    isencryptedpersonrole?: any;
    constructor(initializer?: DropdownModel) {
        initializeObject(this, initializer);
    }
}

export class CheckboxModel extends  DropdownModel {
    isSelected!: boolean;
    constructor(initializer?: CheckboxModel) {
        super(initializer);
        initializeObject(this, initializer);
    }
}

export class TreeViewModel {
    id!: string;
    name!: string;
    children!: TreeViewModel[];
}
export class Alert {
    type!: AlertType;
    message!: string;
    keepAlive: boolean = false;
}

export enum AlertType {
    Success,
    Error,
    Info,
    Warning
}

export interface DynamicObject {
    [key: string]: any;
}
