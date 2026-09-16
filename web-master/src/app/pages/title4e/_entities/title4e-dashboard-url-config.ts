export class Titile4eUrlConfig {
    public static EndPoint = {
        slaCompliance: {
            slaComplianceURL: `/manage/team/`
        },
        teamStatistics: {
            teamStatisticsURL: `Usernotifications/getTeamCaseCountByUser`
        },
        myDsdsActions: {
            myDsdsActionsURL: `servicerequestsearches/getDetails`,
            DSDSActionDetailsUrl: 'servicerequestsearches/usersservicerequest'
        },
        myTasks: {
            myTasksURL: `Usernotifications/getActivityTasksByUser`
        },
        restoreWidget: {
            widgetURL: `Usernotifications/getCaseCountByUser`,
            taskCloseureURL: 'Usernotifications/getTasksCountByUser',
            caseworkerDashboardURL: 'Usernotifications/getcaseworkerdashboard'
        },
        Attachment: {
            UploadAttachmentUrl: 'attachments/uploadsFile',
            AttachmentUploadUrl: 'attachments/uploadsFile',
            AttachmentTypeUrl: 'Intake/attachmenttype',
            AttachmentClassificationTypeUrl: 'Intake/attachmentclassificationtype',
            DeleteAttachmentUrl: 'Documentproperties/delete',
            AttachmentGridUrl: 'Documentproperties/getcaseworkerattachments',
            PersonAttachmentGridUrl: 'Documentproperties/getpersonattachments',
            PersonAttachmentGridIveUrl: 'Documentproperties/getpersonattachmentsive',
            PersonAttachmentUpdate: 'Documentproperties/updatepersonattachments',
            SaveAttachmentUrl: 'Documentproperties/addcaseworkerattachment',
        },
        getiveassignment: 'titleive/ive/getiveassignment/',
        getEligibilityWorksheet: 'titleivefc/fc/eligibility-worksheet/',
        getLegalInfo: 'titleivefc/fc/getlegalinfo/',
        getGuardianInfo: 'ivegap/gap/getguardianinfo',
        postGapEligibilityNExtension: 'ivegap/gap/audit',
        updategapsiblingInfo: 'ivegap/gap/eligibility-worksheet/sibling',
        deletegapsiblinginfo: 'ivegap/gap/eligibilityworksheet/sibling/delete',
        postAdoptionApplicability: 'iveadoption/adoption/audit',
        postAdoptionApplicabilityToDB: 'iveadoption/adoption/adoption-applicability',
        savegapeligibility: 'ivegap/gap/savegapdata',
        saveadoptioneligibility: 'iveadoption/adoption/saveadoptiondata',
        getPeriods: 'titleivefc/fc/get-periods',
        auditPeriods: 'titleivefc/fc/audit-periods',
        eligibilityHistory: 'titleivefc/fc/eligibility-history',
        caseSubmit: 'titleivefc/fc/determination-transaction-id',
        updateRemoval: 'titleivefc/fc/worksheet/updateRemoval',
        deprivationUpdate: 'titleivefc/fc/worksheet/deprivation',
        deprivationDelete: 'titleivefc/fc/worksheet/deprivation/delete',
        incomeUpdate: 'titleivefc/fc/worksheet/income',
        courtOrderUpdate: 'titleivefc/fc/worksheet/updateCourt',
        placementUpdate: 'titleivefc/fc/worksheet/placements',
        livingArrangementUpdate: 'titleivefc/fc/worksheet/livingarrangement',
        judicial: 'titleivefc/fc/worksheet/judicial',
        ssiSsaUpdate: 'titleivefc/fc/worksheet/ssissa',
        ivesignatureupdate: 'titleivefc/fc/worksheet/ivesignature',
        getivesignature: 'titleivefc/fc/getivesignature',
        ivecsmsinformation: 'titleive/ive/ivecsms-data',
        gapsignatureupdate: 'ivegap/gap/ivegapsignature',
        getgapsignature: 'ivegap/gap/getgapsignature',
        saveSpecificRelative: 'titleivefc/fc/worksheet/specified-relative',
        saveIncomeSummary: 'titleivefc/fc/worksheet/income-type/create',
        PersonList: 'People/getpersondetail',
        addUpdateNarrative: 'admin/progressnote/addrecordingsive',
        getNarrative: 'admin/progressnote/getrecordingsive',
        getGAPEligibilityDetails: 'tb_ive_gapaudit/list'
    };
}
