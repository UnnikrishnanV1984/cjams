import { AppConstants } from '../../../@core/common/constants';
const personsinvolved = 'Persons Involved';
const adultscreen = 'Adult Screen';
const complainttype = 'complaint-type';
const crossreference = 'Cross Reference';
const peaceorderid = 'peace-order';
const peaceordertitle = 'Peace Order';
const legalaction = 'legal-action';
const legalactionstitle = 'Legal Actions';
const saoresponse = 'SAO Response';
const servicetype = 'service-type';
const paymentschedule = 'payment-schedule';
const paymentscheduletitle = 'Payment Schedule';
const adoptionsubsidy = 'Adoption Subsidy';
export const IntakeTabConfig = [
    {
        id: 'narrative',
        title: 'Narrative',
        name: 'Narrative',
        resource:['intake_full_access', 'intake_read_only_access'],
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_INTAKE_WORKER, AppConstants.ROLES.KINSHIP_SUPERVISOR,
            AppConstants.ROLES.APPEALCO, AppConstants.ROLES.CJAMS_CENTRAL_POLICY_STAFF,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: 'narrative',
        securityKey: 'myintake-narrative-screen'
    },
    {
        id: 'person',
        title: personsinvolved,
        name: personsinvolved,
        resource:['intake_full_access', 'intake_read_only_access'],
        // tslint:disable-next-line:max-line-length
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER, AppConstants.ROLES.KINSHIP_INTAKE_WORKER, AppConstants.ROLES.KINSHIP_SUPERVISOR,
            AppConstants.ROLES.APPEALCO,AppConstants.ROLES.CJAMS_CENTRAL_POLICY_STAFF,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: 'person',
        securityKey: 'myintake-persons-involved'
    },
    {
        id: 'relation',
        title: 'Relationship',
        name: 'Relationship',
        resource:['intake_full_access', 'intake_read_only_access'],
        // tslint:disable-next-line:max-line-length
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER, AppConstants.ROLES.KINSHIP_INTAKE_WORKER, AppConstants.ROLES.KINSHIP_SUPERVISOR,
            AppConstants.ROLES.APPEALCO,AppConstants.ROLES.CJAMS_CENTRAL_POLICY_STAFF,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: 'relationship',
        securityKey: 'myintake-persons-involved'
    },
    {
        id: 'person-cw',
        title: personsinvolved,
        name: personsinvolved,
        resource:['intake_full_access', 'intake_read_only_access'],
        // tslint:disable-next-line:max-line-length
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER, AppConstants.ROLES.KINSHIP_INTAKE_WORKER, AppConstants.ROLES.KINSHIP_SUPERVISOR,
            AppConstants.ROLES.APPEALCO,AppConstants.ROLES.CJAMS_CENTRAL_POLICY_STAFF,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: 'person-cw'
    },
    {
        id: 'ast',
        // D-07004 Start
        title: adultscreen,
        name: adultscreen,
        resource:[adultscreen],
        // D-07004 End
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
        route: 'ast',
        securityKey: ''
    },
    {
        id: 'appointment',
        title: 'Appointment',
        name: 'Appointment',
        resource:['Appointment'],
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER],
        route: 'appointment',
        securityKey: ''
    },
    {
        id: 'assessment',
        title: 'Assessment',
        name: 'Assessment',
        resource:['Assessment'],
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER],
        route: 'assessment',
        securityKey: ''
    },
    {
        id: 'attachment',
        title: 'Document',
        name: 'Document',
        resource:['intake_full_access', 'intake_read_only_access'],
        // tslint:disable-next-line:max-line-length
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER, AppConstants.ROLES.KINSHIP_INTAKE_WORKER, AppConstants.ROLES.KINSHIP_SUPERVISOR,
            AppConstants.ROLES.APPEALCO,AppConstants.ROLES.CJAMS_CENTRAL_POLICY_STAFF,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: 'attachment',
        securityKey: 'myintake-attachement'
    },
    {
        id: 'document',
        title: 'Document',
        name: 'Document',
        resource:['intake_full_access', 'intake_read_only_access'],
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER,
            AppConstants.ROLES.APPEALCO,AppConstants.ROLES.CJAMS_CENTRAL_POLICY_STAFF,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: 'attachment',
        securityKey: ''
    },
    {
        id: 'contact',
        title: 'Contact',
        name: 'contact',
        resource:['intake_full_access', 'intake_read_only_access'],
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER, AppConstants.ROLES.KINSHIP_INTAKE_WORKER,
             AppConstants.ROLES.KINSHIP_SUPERVISOR, AppConstants.ROLES.APPEALCO,AppConstants.ROLES.CJAMS_CENTRAL_POLICY_STAFF,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: 'contact/notes',
        securityKey: 'myintake-contact'
    },
    {
        id: complainttype,
        title: 'Case',
        name: 'Complaints',
        resource:['Complaints'],
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER],
        route: complainttype,
        securityKey: ''
    },
    {
        id: 'cross-reference',
        title: crossreference,
        name: crossreference,
        resource:[crossreference],
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER],
        route: 'cross-reference',
        securityKey: ''
    },
    {
        id: 'decision',
        title: 'Decision',
        name: 'Decision',
        resource:['Decision'],
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.SUPERVISOR],
        route: 'decision',
        securityKey: ''
    },
    {
        id: 'disposition',
        title: 'Decision',
        name: 'Disposition',
        resource:['intake_full_access', 'intake_read_only_access'],
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.KINSHIP_INTAKE_WORKER, AppConstants.ROLES.KINSHIP_SUPERVISOR,
            AppConstants.ROLES.APPEALCO,AppConstants.ROLES.CJAMS_CENTRAL_POLICY_STAFF,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: 'disposition',
        securityKey: 'myintake-disposition'
    },
    {
        id: 'caseaudittrail',
        title: 'Case Audit Trail',
        name: 'caseaudittrail',
        resource:['intake_full_access', 'intake_read_only_access'],
        role: [AppConstants.ROLES.SUPERVISOR],
        route: 'caseaudittrail',
        securityKey: ''
    },
    {
        id: 'djs-notes',
        title: 'Notes',
        name: 'DJS Notes',
        resource:['DJS Notes'],
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER],
        route: 'djs-notes',
        securityKey: ''
    },
    {
        id: 'entity',
        title: 'Entity',
        name: 'Entity',
        resource:['Entity'],
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER],
        route: 'entity',
        securityKey: ''
    },
    {
        id: 'evaluation',
        title: 'Complaints',
        name: 'Evaluation',
        resource:['Evaluation'],
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER],
        route: 'evaluation',
        securityKey: ''
    },
    {
        id: peaceorderid,
        title: peaceordertitle,
        name: peaceordertitle,
        resource:[peaceordertitle],
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
        route: peaceorderid,
        securityKey: ''
    },
    {
        id: legalaction,
        title: legalactionstitle,
        name: legalactionstitle,
        resource:[legalactionstitle],
        role: [AppConstants.ROLES.SUPERVISOR],
        route: legalaction,
        securityKey: ''
    },
    {
        id: 'sao-hearing',
        title: 'Hearing Details',
        name: 'SAO Hearing',
        resource:['SAO Hearing'],
        role: [AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER],
        route: 'sao-hearing',
        securityKey: ''
    },
    {
        id: 'sao-petition',
        title: 'Petition Details',
        name: 'SAO Petition',
        resource:['SAO Petition'],
        role: [AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER],
        route: 'sao-petition',
        securityKey: ''
    },
    {
        id: 'sao-response',
        title: saoresponse,
        name: saoresponse,
        resource:[saoresponse],
        role: [AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER],
        route: 'sao-response',
        securityKey: ''
    },
    {
        id: 'sao-schedule',
        title: 'Schedule Hearings',
        name: 'SAO Schedule',
        resource:['SAO Schedule'],
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL, AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR, AppConstants.ROLES.COURT_WORKER],
        route: 'sao-schedule',
        securityKey: ''
    },
    {
        id: 'sdm',
        title: 'SDM',
        name: 'SDM',
        resource:['intake_full_access', 'intake_read_only_access'],
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR,
            AppConstants.ROLES.APPEALCO,AppConstants.ROLES.CJAMS_CENTRAL_POLICY_STAFF,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: 'sdm',
        securityKey: 'myintake-sdm'
    },
    {
        id: servicetype,
        title: 'Service/Sub-type',
        name: 'Service Type',
        resource:['intake_full_access', 'intake_read_only_access'],
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: servicetype,
        securityKey: ''
    },
    {
        id: 'social-history',
        title: 'Social History',
        name: 'Social History',
        resource:['intake_full_access', 'intake_read_only_access'],
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: 'social-history',
        securityKey: ''
    },
    {
        id: 'intake-refferal',
        title: 'Intake Referral',
        name: 'Intake Refferal',
        resource:['Intake Refferal'],
        role: [AppConstants.ROLES.COURT_WORKER],
        route: 'intake-referral',
        securityKey: ''
    },
    {
        id: paymentschedule,
        title: paymentscheduletitle,
        name: paymentscheduletitle,
        resource:[paymentscheduletitle],
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
        route: paymentschedule,
        securityKey: ''
    },
    {
        id: 'placement',
        title: 'Placement',
        name: 'Placement',
        resource:['Placement'],
        role: [AppConstants.ROLES.OFFICE_PROFFESSIONAL],
        route: 'placement',
        securityKey: ''
    },
    {
        id: 'roa',
        title: 'ROA CPS',
        name: 'ROA CPS',
        resource:['intake_full_access', 'intake_read_only_access'],
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR,
            AppConstants.ROLES.APPEALCO,AppConstants.ROLES.CJAMS_CENTRAL_POLICY_STAFF,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: 'roa'
    },
    {
        id: 'history-clearance',
        title: 'History Clearance',
        name: 'History Clearance',
        resource:['intake_full_access', 'intake_read_only_access'],
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR,AppConstants.ROLES.CPS_CLEARANCE_STAFF],
        route: 'history-clearance'
    },
    {
        id: 'adoption-subsidy',
        title: adoptionsubsidy,
        name: adoptionsubsidy,
        resource:[adoptionsubsidy],
        role: [AppConstants.ROLES.INTAKE_WORKER, AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR],
        route: 'adoption-subsidy'
    }
];

export const IntakeTabOrderConfig = [
    {
        agency: 'CW',
        order: ['narrative', 'person-cw', 'relation', 'sdm', 'contact', 'attachment', 'disposition']
    },
    {
        agency: 'DJS',
        order: ['person', 'evaluation', 'appointment', complainttype, 'assessment', /*'cross-reference',*/ 'djs-notes', 'document', 'decision', legalaction],
    },
    {
        agency: 'AS',
        order: ['narrative', 'person', 'ast', 'entity', servicetype, 'assessment', 'contact', 'attachment', 'disposition']
    }
];

const  person_tab_name = 'person-cw';
export const CW_TAB_ORDER = {
    COMMON_ORDER: ['narrative', person_tab_name, 'relation', 'sdm', 'contact', 'attachment', 'disposition'],
    CPS_ORDER: ['narrative', person_tab_name, 'relation', 'sdm', 'contact', 'attachment', 'disposition'],
    ROA_CPS: ['narrative', person_tab_name, 'relation', 'sdm', 'roa', 'contact', 'attachment', 'disposition'],
    RISK_HARM_ORDER: ['narrative', person_tab_name, 'relation', 'sdm', 'contact', 'attachment', 'disposition'],
    NON_CPS_ORDER: ['narrative', person_tab_name, 'relation', 'contact', 'attachment', 'disposition']
};

export const DJS_TAB_ORDER = {
    COMMON_ORDER: ['person', 'evaluation', 'appointment', complainttype, 'assessment', /*'cross-reference',*/ 'djs-notes', 'document', 'decision', paymentschedule, legalaction],
    // Peace order
    PO_ORDER: ['person', peaceorderid, 'appointment', complainttype, 'assessment', /*'cross-reference',*/ 'djs-notes', 'document', 'decision', legalaction],
    WAIVER_FROM_ADUL_COURT_ORDER: ['person', 'evaluation', complainttype, 'djs-notes', 'document', 'decision'],
    ADULT_HOLD_DETENTION: ['person', complainttype, 'assessment', 'placement', 'djs-notes', 'document', 'decision'],
    INTERSTATE_COMPACT: ['person', complainttype, 'djs-notes', 'document', 'decision']
};




