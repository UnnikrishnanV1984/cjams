const domesticviolencelethalityscreenfordhs = 'DOMESTIC VIOLENCE LETHALITY SCREEN FOR DHS LEGACY';
const marylandfamilyriskreassessment = 'Maryland Family Risk Reassessment';
const homehealthreport = 'HOME HEALTH REPORT';
const safecohp = 'SAFE-C OHP';
const cansoutofhomeplacementservice = 'CANS-OUT OF HOME PLACEMENT SERVICE';
const bestinterestdeterminationforeducationalplacement = 'BEST INTEREST DETERMINATION FOR EDUCATIONAL PLACEMENT';
const transportationplanformattendingschooloforiginfromoutofhomeplacement = 'TRANSPORTATION PLAN FORM ATTENDING SCHOOL OF ORIGIN FROM OUT-OF-HOME PLACEMENT';
const MARYLANDFAMILYRISKREASSESSMENT = 'MARYLAND FAMILY RISK REASSESSMENT';
const notificationofplacemententryandexitreceipt = 'NOTIFICATION OF PLACEMENT-ENTRY AND EXIT RECEIPT';
const readyby21exitsurvey = 'Ready by 21 Exit Survey';
const riskassessmentlegacy = 'Risk Assessment Legacy';
const sextraffickingscreeninginterview = 'SEX TRAFFICKING(CST) SCREENING INTERVIEW';
const caseylifeskillsassessment = 'Casey Life Skills Assessment';
const placementrequestform = 'PLACEMENT REQUEST FORM - ATTACHMENT A';

export const CASE_STORE_CONSTANTS = {
    DA_NUMBER: 'DANUMBER',
    CASE_UID: 'CASEUID',
    IS_SERVICE_CASE: 'ISSERVICECASE',
    PLACEMENT_CHILD: 'placement_child',
    PLACED_CHILD: 'placed_child',
    CASE_TYPE: 'CASE_TYPE',
    FOLDER_CHANGED: 'FOLDER_CHANGED',
    FOLDER_CHANGE_INITIATED: 'FOLDER_CHANGE_INITIATED',
    CASE_DASHBOARD: 'CASE_DASHBOARD',
    ADOPTION_PLANNING_ID: 'ADOPTION_PLANNING_ID',
    TPR_RECOMMENDATION_ID: 'TPR_RECOMMENDATION_ID',
    ADOPTION_AGREEMENT_ID: 'ADOPTION_AGREEMENT_ID',
    PERMANENCY_PLAN_ID: 'PERMANENCY_PLAN_ID',
    DISPOSITIONID_FOR_APPROVAL: 'DISPOSITIONID_FOR_APPROVAL',
    YTP_PERSON_ID: 'YTP_PERSON_ID',
    DSDS_ACTIONS_SUMMARY: 'dsdsActionsSummary',
    COUNTY_LIST: 'COUNTY_LIST',
    Adoption_START_DATE: 'ADOPTION_START_DATE',
    PRO_NOTE_ID: 'progress_note_id',
    GAP_APPLICATION_ID: 'GAP_APPLICATION_ID',
    GAP_PERMANENCYPLANID: 'GAP_PERMANENCYPLANID',
    ADOPTION_PERMANENCYPLANID: 'ADOPTION_PERMANENCYPLANID',
    ALL_DASHBOARD_DTA_LIST: 'ALL_DASHBOARD_DTA_LIST',
    CPS_CASE_ID: 'CPS_CASE_ID',
    APPROVAL_EVENT_CODE: 'APPROVAL_EVENT_CODE',
    INTAKE_NUMBER: 'INTAKE_NUMBER',
    SC_INTAKE_NUMBER: 'SC_INTAKE_NUMBER',
    SERVICEPLAN_ID: 'SERVICEPLAN_ID',
    CHILDREMOVAL_ID: 'CHILDREMOVAL_ID',
    PERSON_MOVE_ID: 'PERSON_MOVE_ID',
    AR_REFERRAL_REASON: 'ARReferralReason',
    AR_CLOSURE_DATE: 'ARClosureDate',
    AR_ASSESSMENT_DATE: 'ARAssessmentDate',
    AR_RECOMMENDATION: 'ARRecommendation',
    AR_REASON_TEXT: 'ARReasonText',
    AR_CLOSURE_TYPE: 'ARClosureType',
    AR_RISK_ISSUES: 'ARRiskIssues',
    AR_NOTES: 'ARNotes',
    AR_STATUS: 'ARNarrativeStatus',
    AR_SERVICES_INTERVENTIONS: 'ARServicesInterventions',
    AR_CHILDREN_PARTICIPATED: 'ChildrenInvolved',
    AR_OTHERS_PARTICIPATED: 'OthersInvolved',
    AR_SUPERVISOR_APPROVAL: 'SupervisorApprovalDetails',
    CHILD_REMOVAL_ASSESSMENT: 'ChildRemovalAssessment',
    SHELTER_ASSESSMENT_ISRACTORID: 'IntakeservicerequestactoridOfChildForWhomShelterAssessmentIsCreated',
    CONTACT_NOTES_SAVE_ENABLED: 'CONTACT_NOTES_SAVE_ENABLED',
    PSYCHOTRPIC_ID:'PSYCHOTRPIC_ID',
    FROM_NOTIFICATION:'FROM_NOTIFICATION',
    FROM_REPORT:'FROM_REPORT',
    PSYCHOTRPIC_REQUEST_ID :'PSYCHOTRPIC_REQUEST_ID',
    PSYCHOTRPIC_FULLNAME:'PSYCHOTRPIC_FULLNAME',
    PSYCHOTRPIC_CJAMSPID:'PSYCHOTRPIC_CJAMSPID',
    PSYCHOTRPIC_GENDER:'PSYCHOTRPIC_GENDER',
    PSYCHOTRPIC_DOB:'PSYCHOTRPIC_DOB',
    PSYCHOTRPIC_COUNTY:'PSYCHOTRPIC_COUNTY',
    PSYCHOTRPIC_RACE:'PSYCHOTRPIC_RACE',
    PSYCHOTRPIC_PERSONID :'PSYCHOTRPIC_PERSONID',
    PSYCHOTRPIC_CASEID:'PSYCHOTRPIC_CASEID',
    PSYCHOTRPIC_FROMMEDICATION:'PSYCHOTRPIC_FROMMEDICATION',
    ADOPTED_PERSON_ID : 'ADOPTED_PERSON_ID'
};

export const CASE_TYPE_CONSTANTS = {
    ADOPTION: 'ADOPTION',
    SERVICE_CASE: 'SERVICE_CASE',
    SC_SERVICE_CASE: 'Service Case'
};

export const CASE_ASSESSMENT_FORMS_CONSTANTS = {
    CPS_IR: [domesticviolencelethalityscreenfordhs, 'AOD Form', 'MFIRA', marylandfamilyriskreassessment, 'SAFE-C', homehealthreport, safecohp, 'AOP', 'cans-v2', 'SAFE-C', safecohp, cansoutofhomeplacementservice, bestinterestdeterminationforeducationalplacement, transportationplanformattendingschooloforiginfromoutofhomeplacement, MARYLANDFAMILYRISKREASSESSMENT, homehealthreport, notificationofplacemententryandexitreceipt, readyby21exitsurvey, riskassessmentlegacy, 'NCFAS', sextraffickingscreeninginterview, caseylifeskillsassessment,'LAP (Lethality Assessment Program)','Quick Youth Indicators for Trafficking (QYIT)', 'PADS Form', placementrequestform, ''],
    CPS_AR: [domesticviolencelethalityscreenfordhs, 'AOD Form', 'MFIRA', marylandfamilyriskreassessment, 'SAFE-C', homehealthreport, safecohp, 'AOP', 'cans-v2', 'SAFE-C', safecohp, cansoutofhomeplacementservice, bestinterestdeterminationforeducationalplacement, transportationplanformattendingschooloforiginfromoutofhomeplacement, MARYLANDFAMILYRISKREASSESSMENT, homehealthreport, notificationofplacemententryandexitreceipt, readyby21exitsurvey, riskassessmentlegacy, 'NCFAS', sextraffickingscreeninginterview, caseylifeskillsassessment, 'LAP (Lethality Assessment Program)','Quick Youth Indicators for Trafficking (QYIT)','PADS Form', placementrequestform, ''],
    SC_IN_HOME_PLAN: ['MFIRA', marylandfamilyriskreassessment, 'SAFE-C', homehealthreport, safecohp, 'AOP', 'cans-v2', riskassessmentlegacy, 'NCFAS', placementrequestform],
    SC_OUT_OF_HOME: ['cans-v2', 'SAFE-C', safecohp, cansoutofhomeplacementservice, bestinterestdeterminationforeducationalplacement, transportationplanformattendingschooloforiginfromoutofhomeplacement, MARYLANDFAMILYRISKREASSESSMENT, homehealthreport, notificationofplacemententryandexitreceipt, readyby21exitsurvey, riskassessmentlegacy, 'NCFAS', caseylifeskillsassessment, placementrequestform],
    SERVICE_CASE: ['SILA', domesticviolencelethalityscreenfordhs, 'AOD Form', 'MFIRA', marylandfamilyriskreassessment, 'SAFE-C', homehealthreport, safecohp, 'AOP', 'cans-v2', 'SAFE-C', safecohp, cansoutofhomeplacementservice, bestinterestdeterminationforeducationalplacement, transportationplanformattendingschooloforiginfromoutofhomeplacement, MARYLANDFAMILYRISKREASSESSMENT, homehealthreport, notificationofplacemententryandexitreceipt, readyby21exitsurvey, riskassessmentlegacy, 'NCFAS',
        sextraffickingscreeninginterview, caseylifeskillsassessment, 'PADS Form',
        placementrequestform, 'QUALIFIED INDIVIDUAL (QI) ASSESSMENT - ATTACHMENT B',
        'FACILITATED MEETING REFERRAL FORM','LAP (Lethality Assessment Program)','Quick Youth Indicators for Trafficking (QYIT)' ]
};