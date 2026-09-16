import { initializeObject } from '../../../@core/common/initializer';

export class FinancePlacementSearchEntry {
    activeflag!: string;
    sortcol!: string;
    sortdir!: string;
    placementid!: string;
    caseid!: string;
    providerid!: string;
    providername!: string;
    clientaccountid!: string;
    address!: string;
    zip!: string;
    state!: string;
    county!: string;
    phone!: string;
    city!: string;
    count!: string;
    interfacetype!: string;
    region!: string;
    daterangefrom!: string;
    daterangeto!: string;
    id!: 0;
    pagenumber!: 1;
    provider_category_cd!: string;
    placement_id!: string;
    provider_id!: string;
    provider_last_nm!: string;
    provider_first_nm!: string;
    exit_dt!: string;
    entry_dt!: string;
    payment_header_id!: string;
    client_id!: string;

    constructor(initializer?: FinancePlacementSearchEntry) {
        initializeObject(this, initializer);
    }
}

export class FinanceAccountsPayableSearchEntry {
    activeflag!: string;
    sortcol!: string;
    sortdir!: string;
    paymentid!: string;
    feintaxid!: string;
    providerid!: string;
    providername!: string;
    clientaccountid!: string;
    address!: string;
    zip!: string;
    state!: string;
    county!: string;
    phone!: string;
    city!: string;
    count!: string;
    interfacetype!: string;
    region!: string;
    daterangefrom!: string;
    daterangeto!: string;
    ssn!: string;
    dcn!: string;
    firstname!: string; // REMOVE
    id!: 0;
  providerfirstnm!: string;
  providerlastnm!: string;

    constructor(initializer?: FinanceAccountsPayableSearchEntry) {
        initializeObject(this, initializer);
    }
}

export class FinanceAccountsReceivableSearchEntry {
    activeflag!: string;
    sortcol!: string;
    sortdir!: string;
    paymentid!: string;
    feintaxid!: string;
    providerid!: string;
    providername!: string;
    clientaccountid!: string;
    address!: string;
    zip!: string;
    state!: string;
    county!: string;
    phone!: string;
    city!: string;
    count!: string;
    interfacetype!: string;
    region!: string;
    daterangefrom!: string;
    daterangeto!: string;
    ssn!: string;
    dcn!: string;
    firstname!: string; // REMOVE
    id!: 0;

    constructor(initializer?: FinanceAccountsPayableSearchEntry) {
        initializeObject(this, initializer);
    }
}



export class FinanceGuardianshipSearchEntry {
    activeflag!: string;
    sortcol!: string;
    sortdir!: string;
    placementid!: string;
    caseid!: string;
    providerid!: string;
    providername!: string;
    clientaccountid!: string;
    address!: string;
    zip!: string;
    state!: string;
    county!: string;
    phone!: string;
    city!: string;
    count!: string;
    interfacetype!: string;
    region!: string;
    daterangefrom!: string;
    daterangeto!: string;
    id!: 0;
    pagenumber!: 1;
    provider_id!: string;
    TBD!: string;
    first_nm!: string;
    last_nm!: string;
    guardian_subsidy_id!: string;
    disclosure_dt!: Date;
    subsidy_start_dt!: Date;
    subsidy_end_dt!: Date;
    client_id!: string;
    constructor(initializer?: FinanceGuardianshipSearchEntry) {
        initializeObject(this, initializer);
    }
}

export class FinanceAdoptionSearchEntry {
    TBA?:any;
    payment_amount_no?:any;
    agreement_start_dt?:any;
    agreement_end_dt?:any;
    activeflag!: string;
    sortcol!: string;
    sortdir!: string;
    placementid!: string;
    caseid!: string;
    providerid!: string;
    providername!: string;
    clientaccountid!: string;
    address!: string;
    zip!: string;
    state!: string;
    county!: string;
    phone!: string;
    city!: string;
    count!: string;
    interfacetype!: string;
    region!: string;
    daterangefrom!: string;
    daterangeto!: string;
    id!: 0;
    pagenumber!: 1;
    checked!: true;
    guardian_subsidy_id!:string;
    TBD!:any;
    client_id!:string;
    first_nm!:string;
    last_nm!:string;
    

    constructor(initializer?: FinanceAdoptionSearchEntry) {
        initializeObject(this, initializer);
    }
}

export class AddForm {
    objecttypekey!: string;
    objectid!: string;
    interest_start_dt!: string;
    interest_end_dt!: string;
    interest_amount_no!: string;
    mod_interest_amount_no!: string;
    entered_by!: string;
    notes_tx!: string;
    comm_acct_trans_id!: string;
    comm_account_id!: string;
}

export class FosterCareRate {
    rate_id!: number;
    rate_type_cd!: number;
    service_id!: number;
    start_dt!: Date;
    end_dt!: Date;
    min_age_no!: number;
    max_age_no!: number;
    monthly_rate_no!: string;
    per_diem_rate_no!: number;
    monthly_clothing_no!: string;
    emergency_per_diem_no!: number;
    emergency_bed_fee!: number;
    ratetype!: string;
    difficulty_level_cd!: string;
    max_clothing_no!: string;
    monthly_stipend_no!: string;
    service_nm!: string;
    dirty_status!: string;
    rate_status?: string;
}

export class PurchaseAuthorization {
    reason_tx!: string;
    fiscalcode!: string;
    fiscal_description!: string;
    costnot_exceed!: string;
    justification_text!: string;
    voucher_requested!: string;
    authorization_id!: string;
    service_log_id!: string;
    fiscal_category_cd!: string;
    cost_no!: number;
    fundingstatus!: string;
    paymentstatus!: string;
    startdt!: Date;
    enddt!: Date;
    final_amount_no!: number;
    client_account_no!: string;
    client_id!: number;
    client_name!: string;
    client_account_id!: number;
    dob!: Date;
    gender!: string;
    service_nm!: string;
    provider_nm!: string;
    provider_id!: string;
    service_start_dt!: Date;
    service_end_dt!: Date;
    justification_tx!: string;
    fiscal_category_desc!: string;
    payment_start_dt!: string;
    payment_end_dt!: string;
    status!: number;
    cfecareduration!: string;
    attachments?: any;

}

export class ProviderSearchDetails {
    totalplacement?: any;
    under_payment?:any;
    totalcount!: number;
    provider_id!: string;
    provider_nm!: string;
    tax_id_no!: string;
    taxidtype!: string;
    prov_tax_type_cd!: string;
    mail_code_tx!: string;
    adm_cell_phone_tx!: string;
    adm_home_phone_tx!: string;
    adm_work_phone_tx!: string;
    adm_fax_tx!: string;
    adr_fax_tx!: string;
    adr_cell_phone_tx!: number;
    adr_home_phone_tx!: number;
    adr_work_phone_tx!: number;
    adm_work_xtn_tx!: string;
    adr_work_xtn_tx!: string;
    adr_street_nm!: string;
    adr_city_nm!: string;
    adr_state_cd!: string;
    adr_zip5_no!: number;
    adr_county_cd!: number;
    adr_county_nm!: string;
    totalbalancedue!: number;
    localdept!: LocalDept[];
    receivabletype!: ReceivableType[];
    categorytype!: string;
    provider_category_cd!: string;
    address!: string;
    collectionresp!: string;
    adr_street_tx!: any;
}

export class LocalDept {
    sum!: number;
    county_cd!: number;
    localdept!: string;
}

export class ReceivableType {
    sum!: number;
    receivable_type!: number;
    receivablenm!: string;
}

export class ManualPayment {
    payment_plan_id!: number;
    plan_dt!: Date;
    receivable_id!: number;
    amount_no!: number;
    percentage_no!: number;
    months_no!: number;
    start_dt!: Date;
    end_dt!: Date;
    offset_sw!: string;
    payment_option_sw!: string;
    offset_option_sw!: string;
    current_receivable_amount!: number;
    entered_by!: string;
    placementexists!: boolean;
    securityusersid!: string;
    reasons_tx!: string;

}

export class FinalDisturbance {
    client_acc_sw!: string;
    provider_id!: number;
    assignedtoid!: string;
    client_account_id!: number;
    disbursement_dt!: Date;
    client_id!: number;
    intakeserviceid!: string;
    service_id!: number;
    amount!: number;
    payment_id!: number;
    payee_nm!: string;
    tax_type_cd!: string;
    tax_id_no!: number;
    status!: number;
    eventcode!: string;
    disbursement_id!: number;
    fiscal_category_cd!: number;
    report_1099_sw!: string;
    type_1099_cd!: number;
    payment_method_cd!: string;
    client_account!: string;
    adr_street_no!: string;
    adr_street_nm!: string;
    adr_city_nm!: string;
    adr_county_cd!: string;
    adr_state_cd!: string;
    adr_zip5_no!: string;
    adr_zip4_no!: string;
    create_user_name!:string;
    create_user_id!:string;
    update_user_id!:string;
}

export class ReceiptEntry {
    account_no_tx!: string;
    account_type!: string;
    benefit_end_dt!: Date;
    benefit_start_dt!: Date;
    client_account_id!: number;
    client_id!: number;
    client_name!: string;
    credit_debit_sw!: string;
    notes_tx!: string;
    post_sw!: string | null;
    received_cd!: string;
    ssno!: string;
    total_balance_no!: number;
    totalcount!: number;
    transaction_amount_no!: number;
    transaction_dt!: Date;
    transaction_id!: number | null;
    transaction_source!: string;
    transaction_source_cd!: string;
    transaction_type!: string;
    transaction_type_cd!: string;
    post_dt!: Date;
    create_user_id!: string;
    update_user_id!: string;
    delete_sw!: string;
    frequency_cd!: string;
    fast_entry_id!: string;
}

export class PayableSearchParams {
    paymentid: any;
    taxid: any;
    providerid: any;
    providername!: string;
    clientid: any;
    address!: string;
    zip!: string;
    state!: string;
    daterangeto!: string;
    daterangefrom!: string;
    city!: string;                                                                   
    county!: string;
    region!: string;
    phone!: string;
    ssn!: string;
    dcn!: string;
    firstname!: string;
    clientname!: string;
    dobdaterangefrom!: Date;
    dobdaterangeto!: Date;
    ayear!: string;
    payment_type_cd!: string;
    payment_status_cd!: string;
    sortorder!:string;
    sortcolumn!:string
}
