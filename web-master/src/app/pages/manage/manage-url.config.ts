export class ManageUrlConfig {
    public static EndPoint = {

        Manage: { 
            Team: {
                TeamDetailsUrl: 'manage/team/details',
                TeamMemberDetailsUrl: 'admin/teammember/details',
                TeamUserUpdateUrl: 'admin/userprofile/updatestatus',
                ZipAssignmentUrl: 'admin/teammember/countylist'
            },
            RegulationLibrary: 'manage/statestatutes',
            News: 'manage/news',
            ReferenceLink: 'manage/Configurablelinks',
            SignificantEvent: 'manage/servicerequestincidenttype',
            getHelpDocuments:'manage/helpdocuments',
            saveHelpDocuments:'manage/helpdocuments/save',
            deleteHelpDocuments:'manage/helpdocuments/delete',
            updateHelpDocuments:'manage/gethelpdocuments/update'
        }
    };
}
