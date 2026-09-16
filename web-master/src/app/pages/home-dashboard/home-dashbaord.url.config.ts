export class HomeDashboardUrlConfig {
    public static EndPoint = {
        slaCompliance: {
            slaComplianceURL: `/manage/team/`
        },
        teamStatistics: {
            teamStatisticsURL: `Usernotifications/getTeamCaseCountByUser`
        },
        myDsdsActions: {
            myDsdsActionsURL: `servicerequestsearches/getDetails`,
            DSDSActionDetailsUrl: 'servicerequestsearches/usersservicerequest',
            DSDSServiceDetailsUrl: 'servicerequestsearches/getservicecase',
            adoptioncaselist: 'servicerequestsearches/getadoptioncase',
            reportAdoptionORGap: 'servicerequestsearches/getadoptionorgapreport'
        },
        myTasks: {
            myTasksURL: `Usernotifications/getActivityTasksByUser`,
            updateMyTaskURL : `Usernotifications/updateMyTaskbyUser`
        },
        restoreWidget: {
            widgetURL: `Usernotifications/getCaseCountByUser`,
            taskCloseureURL: 'Usernotifications/getTasksCountByUser',
            caseworkerDashboardURL: 'Usernotifications/getcaseworkerdashboard'
        }
    };
}
