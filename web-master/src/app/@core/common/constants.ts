export class AppConstants {

    public static PERSON = {
        TEMP_ID: 'tempid_'
    };

    public static ITRETOR = {
        POLING_COUNT: 5,
    };
    
    public static GLOBAL_KEY = {
        SELECTED_PERSON_ID: 'SELECTED_PERSON_ID',
        PERSON_HEALTH_INFO: 'PERSON_HEALTH_INFO',
        PERSON_NAVIGATION_INFO: 'PERSON_NAVIGATION_INFO',
        SOURCE_PAGE: 'SOURCE_PAGE'
    };

    public static CASE_TYPE = {
        INTAKE: 'INTAKE',
        CPS_CASE: 'CPS_CASE',
        CPS_IR: 'CPS_IR',
        CPS_AR: 'CPS_AR',
        SERVICE_CASE: 'SERVICE_CASE',
        ADOPTION_CASE: 'ADOPTION_CASE'
    };

    public static MODULE_TYPE = {
        INTAKE: 'INTAKE',
        CASE: 'CASE',
        ADOPTION_CASE: 'ADOPTION_CASE',
        PUBLIC_PROVIDER_REFERRAL: 'PUBLIC_PROVIDER_REFERRAL',
        PUBLIC_PROVIDER_APPLICATION: 'PUBLIC_PROVIDER_APPLICATION',
        PUBLIC_PROVIDER: 'PUBLIC_PROVIDER'
    };
    public static DA_TYPE_TEXT = {
            // INTAKE: '',
            CPS_CASE: 'CHILD',
            SERVICE_CASE: 'Service Case',
            ADOPTION_CASE: 'Adoption Case'
        };
    public static DA_SUBTYPE_TEXT = {
            // INTAKE: '',
            CPS_IR: 'CPS-IR',
            CPS_AR: 'CPS-AR'
       };

    public static ACTIONS = {
        'ADD': 'ADD',
        'EDIT': 'EDIT',
        'VIEW': 'VIEW',
    };

    public static INTAKE_CONSTANTS = {
        'ROUTED_CLW': 'RCL', // 1 Routed to Court Liason worker
        'SAO_DOUCUMENT_GENERATED': 'DG',  // DG	Document Generated
        'SAO_RESPONSED': 'SAOPF',
        'SAO_RESPONSE_CLOSED': 'SAORC',
        'HEARING_SCHEDULED': 'HS',  // HEARING SCHEDULED
        'COURT_ACTIONS_TO_BE_UPDATED': 'CHU',
        'COURT_HEARING_CONTINUANCE': 'CHCT',
        'COURT_ACTION_SUSTAINED': 'CAS',
        'HEARING_DETAILS': '5',
        'PETTIION_SUBMITED': 'PS',
        'WAITNG_FOR_COURT_HEARING': '7',
        'WAITNG_FOR_CASE_WORKER': '8',
        'SAO_CLOSED': 'CHC',
        'SUSTAINED': 'S',
        'RESTITUTION_COMPLETED': 'RCAS'
    };

    public static INTAKE_TABS = {
        'SAO_RESPONSE': 'SAO_RESPONSE',
        'PETITTION_DETAILS': 'PETITTION_DETAILS',
        'HEARING_DETIALS': 'HEARING_DETIALS',
        'COURT_ACTIONS': 'COURT_ACTIONS',
        'NARRATIVE': 'NARRATIVE',
        'PERSONS_INVOLVED': 'PERSONS_INVOLVED',
        'SDM': 'SDM',
        'EVALUATION_FIELDS': 'EVALUATION_FIELDS',
        'APPOINTMENTS': 'APPOINTMENTS',
        'ENTITIES': 'ENTITIES',
        'SERVICE_SUB_TYPE': 'SERVICE_SUB_TYPE',
        'COMPLAINTS_TYPE': 'COMPLAINTS_TYPE',
        'ASSESSMENTS': 'ASSESSMENTS',
        'CROSS_REFERENCE': 'CROSS_REFERENCE',
        'NOTES': 'NOTES',
        'DJS_NOTES': 'DJS_NOTES',
        'INTAKE_REFERRAL': 'INTAKE_REFERRAL',
        'ATTACHMENTS': 'ATTACHMENTS',
        'DISPOSITION': 'DISPOSITION',
        'DECISION': 'DECISION',
        'LEGAL_ACTION': 'LEGAL_ACTION',
        'RELATIONSHIP': 'RELATIONSHIP',
        'PARTICIPATIONS': 'PARTICIPATIONS',
    };

    /*  PS	Petition Submitted
    CAS	Court Action Sustained
    CHU	Court Hearing to be Updated
    CHC	Court Hearing Closed
    RCL	Routed to Court Liason worker
    SAOPF	SAO Petition Filed
    SAORC	SAO Response

    1 = RCL
    2 = DG
    3 = PS
    4 = CAS
    5 = CHU
    6 = CHC */

    // "SCRNW","apcs","field","Intake Worker","Court Liaison Worker"
    public static ROLES = {
        'OFFICE_PROFFESSIONAL': 'SCRNW',
        'INTAKE_WORKER': 'Intake Worker',
        'SUPERVISOR': 'apcs',
        'CASE_WORKER': 'field',
        'COURT_WORKER': 'Court Liaison Worker',
        'RESTITUTION_COORDINATOR': 'RTCD',
        'PROVIDER': 'provider',
        'IV_E_WORKER': 'ivew',
        'KINSHIP_INTAKE_WORKER': 'Kinship Intake Worker',
        'KINSHIP_SUPERVISOR': 'Kinship Supervisor',
        'IHAS_SUPERVISOR': 'IHASSP',
        'FINANCE_WORKER': 'FW',
        'CENTRAL_OFFICE_FISCAL': 'central office fiscal staff',
        'CENTRAL_OFFICE_SUPERVISOR': 'central office fiscal supervisor',
        'FINANCE_WORKER_DJS': 'FU',
        'RESTITUTION_SUPERVISOR': 'RTS',
        'LDSS_FISCAL_SUPERVISOR': 'FS',
        'DIRECTOR_OF_FINANCE': 'DF',
        'LICENSING_ADMINISTRATOR': 'Licensing Administrator',
        'QUALITY_ASSURANCE': 'Quality Assurance',
        'PROGRAM_MANAGER': 'Program Manager',
        'EXECUTIVE_DIRECTOR': 'Executive Director',
        'DEPUTY_DIRECTOR': 'Deputy Director',
        'DESIGNEE': 'Designee (Support Staff)',
        'PRIVATE_SUPERVISOR': 'apcs - privateportal',
        'PROVIDER_STAFF_ADMIN': 'Provider Staff Admin',
        'TITLE_IVE_SPECIALIST': 'IVESP',
        'TITLE_IVE_SUPERVISOR': 'IVESV',
        'TITLE_IVE_ANALYST': 'IVEEA',
        'TITLE_IVE_Quality_Assurance': 'IVEQA',
        'TITLE_IVE_ADMINISTRATOR': 'IVEADMIN',
        'IVE_SPECIALIST': 'IV-E Specialist',
        'IVE_SUPERVISOR': 'IV-E Supervisor',
        'LDSS_DIRECTOR': 'LDSS_DIRECTOR',
        'LDSS_SUPERVISOR': 'LDSS_SUPERVISOR',
        'LDSS_RESOURCE_WORKER': 'LDSS_RESOURCE_WORKER',
        'LDSS_HOMESTUDY_WORKER': 'LDSS_HOMESTUDY_WORKER',
        'LDSS_RECRUITER_TRAINER': 'LDSS_RECRUITER_TRAINER',
        'CJAMS_SSA_FTDM_FACILITATOR': 'CJAMS_SSA_FTDM_FACILITATOR',
        'CJAMS_SSA_QUALIFIED_INDIVIDUAL': 'CJAMS_SSA_QUALIFIED_INDIVIDUAL',
        'CJAMS_SSA_FTDM_QI_SUPERVISOR': 'CJAMS_SSA_FTDM_QI_SUPERVISOR',
        'TRANSPORTATION_OFFICER': 'TO',
        'APPEAL_WORKER': 'Appeal Work',
        'APPEAL_USER': 'APPEALCO',
        'DHS_LEGAL_ATTORNEY' : 'DHS Legal Attorney',
        'APPEALCO': 'APPEALCO',
        'CJAMS_CENTRAL_POLICY_STAFF': 'Central Policy Staff',
        'CJAMS_Legal_Rep': 'Legal Rep-Agency Attorney',
        'CJAMS_Independent_Living': 'Independent Living Coordinator',
        'CPS_CLEARANCE_STAFF': 'CPS Clearance Staff',
        'LEGAL_REP_ATTORNEY' : 'Legal Rep-Agency Attorney',
        'SSA_Placement_Manager': 'SSA Placement Manager',
        'CWPS_CENTRAL_POLICY_STAFF': 'central_policy_staff',
        'PSYCH_PHARMACIST': 'CJAMS_CW_PSYCH_PHARMACIST',
        'PSYCH_PSYCHIARIST': 'CJAMS_CW_PSYCH_PSYCHIARIST',
        'PSYCH_COORDINATOR': 'CJAMS_CW_PSYCH_COORDINATOR',
        'Citizens_Review_Board': 'Citizens Review Board for Children'
    };

    public static INVOLVED_PERSON_ROLE = {
        'YOUTH': 'Youth',
        'FATHER': 'father',
        'MOTHER': 'mother',
        'GUARDIAN': 'guardian'
    };

    public static PERSON_IDENTIFIER = {
        'SSN': 'SSN',
        'HEIGHT': 'Ht',
        'WEIGHT': 'Wt',
        'TATTOO': 'Tattoo',
        'PHYSICAL_MARK': 'PhyMark',
        'DRIVING_LICENSE': 'DL'
    };

    public static PERSON_SEARCH = {
        'SEARCH_FORM': 'SEARCH_FORM',
        'RELATION_SEARCH_FORM': 'RELATION_SEARCH_FORM'
    };

    // public static ACTIONS = {
    //     'VIEW': 'view',
    //     'EDIT': 'edit'
    // };

    public static PAGES = {
        'INTAKE_PAGE': 'INTAKE_PAGE',
        'CASE_PAGE': 'CASE_PAGE',
        'COURT_PAGE': 'COURT_PAGE',
        'RESTITUTION_COORDINATOR': 'RESTITUTION_COORDINATOR',
        'DJS_PLACEMENT_WORKER': 'DJS_PLACEMENT_WORKER'
    };

    public static PERSON_ALERT_TYPE = {
        'RESTITUION': 'REST'
    };

    public static AGENCY = {
        'DJS': 'DJS',
        'AS': 'AS',
        'CW': 'CW',
        'PRIVATE_PROVIDER': 'PVPROV'
    };

    public static NARRATIVE = {
        TOOLBAR_CONFIG: {
            toolbar: [
                ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
                ['blockquote', 'code-block'],

                [{ 'header': 1 }, { 'header': 2 }],               // custom button values
                [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                [{ 'script': 'sub' }, { 'script': 'super' }],      // superscript/subscript
                [{ 'indent': '-1' }, { 'indent': '+1' }],          // outdent/indent
                [{ 'direction': 'rtl' }],                         // text direction

                [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
                [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

                [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
                [{ 'font': [] }],
                [{ 'align': [] }],

                ['clean'],                                         // remove formatting button

                //   ['link', 'image', 'video']                         // link and image, video
            ]
        }
    };


    public static NARRATIVE_TEMP = {
        TOOLBAR_CONFIG: {
            toolbar: [
                ['bold', 'italic', 'underline', 'strike'],    
                [{ 'header': 1 }, { 'header': 2 }],                           // remove formatting button

                //   ['link', 'image', 'video']                         // link and image, video
            ]
        }
    };

}