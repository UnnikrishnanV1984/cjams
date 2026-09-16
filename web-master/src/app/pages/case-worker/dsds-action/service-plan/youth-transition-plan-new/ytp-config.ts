export const YTP_TABS = [{
    tabName: 'summary',
    title: 'SUMMARY',
    path: 'ytp-summary',
    keyName: 'new_summary_json',
    isCompleted: true,
},
{
    tabName: 'education',
    title: 'EDUCATION & EMPLOYMENT',
    path: 'ytp-education',
    keyName: 'education_json',
    isCompleted: false,
    subTabs: [
        {
            tabName: 'education',
            title: 'EDUCATION',
            path: 'ytp-education',
            keyName: 'new_education_json',
            isCompleted: false,
        },
        {
            tabName: 'employment',
            title: 'EMPLOYMENT',
            path: 'ytp-employment',
            keyName: 'new_employ_json',
            isCompleted: false,
        },
        {
            tabName: 'transportation',
            title: 'TRANSPORTATION',
            path: 'ytp-transport',
            keyName: 'new_transportation_json',
            isCompleted: true,
        },
        {
            tabName: 'documentation',
            title: 'DOCUMENTATION',
            path: 'ytp-documentation',
            keyName: 'new_documentation_json',
            isCompleted: true,
        },
    ]
},
{
    tabName: 'money-management',
    title: 'FINANCIAL EMPOWERMENT',
    path: 'ytp-money-management',
    keyName: 'new_financial_empowerment_json',
    isCompleted: false
},
{
    tabName: 'housing',
    title: 'SAFE & STABLE Housing',
    path: 'ytp-housing',
    keyName: 'new_housing_json', 
    isCompleted: false
},
{
    tabName: 'supportive',
    title: 'WELL-BEING & CIVIC ENGAGEMENT',
    path: 'ytp-community',
    keyName: 'new_community_json',
    isCompleted: false,
    subTabs: [
        {
            tabName: 'education',
            title: 'Community, Culture & Social Life',
            path: 'ytp-community',
            keyName: 'new_community_json',
            isCompleted: false,
        },
        {
            tabName: 'employment',
            title: 'SELF-CARE & HEALTH',
            path: 'ytp-health',
            keyName: 'new_health_json',
            isCompleted: false,
        },
    ]
},
{
    tabName: 'health',
    title: 'PERMANENT & SUPPORTIVE CONNECTIONS',
    path: 'ytp-supportive-relationships',
    keyName: 'new_connections_json',
    isCompleted: false
},
{
    tabName: 'documentation',
    title: 'YTP MEETING',
    path: 'ytp-meeting',
    keyName: 'new_meeting_json',
    isCompleted: false
},
{
    tabName: 'fc-gs-checklist',
    title: 'FOSTER CARE TO ADULT GUARDIANSHIP CHECKLIST',
    path: 'ytp-fc-gs-checklist',
    keyName: 'new_fc_gs_checklist_json',
    isCompleted: false,
    subTabs: [
        {
            tabName: 'audit',
            title: 'Audit Log',
            path: 'fcgs-audit',
            keyName: 'fcgs_audit',
            isCompleted: false
          }
    ]
}
];