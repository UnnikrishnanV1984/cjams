
/*
-- Issue Description: YTP cannot be approved
-- Root cause: No longer a signature box on YTP, can not save the entered date YTP signed. Also both YTP as approved but the dates and signatures are not patched it seems.
-- Fix Provided: Datafix has been provided to update the YTP meeting json to have the youth sign date and caseworker.
-- Regression Impacts: N/A
-- Is Code fix Required?: No
-- Code fix ticket#: N/A
-- Reason why no related code fix: Updated the YTP meeting json to have the youth sign date and caseworker through the database.
-- Status of the code fix: Data fix completed, PR raised for documentation.
*/
update youthtransitionplan 
set new_meeting_json  = '{
    "goals": [],
    "actions": [],
    "youthsign": "",
    "isYouthSign": true,
    "nextMeeting": "0",
    "nextMeetingDt": null,
    "youthsignDate": "2026-02-09T07:58:06.839Z",
    "caseworkerSign": "data:image/png;base64,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",
    "nextMeetingTime": null,
    "ytpMeetingNotes": null,
    "caseworkerSignDate": "2026-02-10T07:58:06.839Z",
    "nextMeetingLocation": null,
    "youthSignedDocument": [{"documentpropertiesid": "9df8570f-5c4b-4dae-8f48-ab3e58758ce7",
                "objecttypekey": "Person",
                "title": "My Youth Transition Plan and Meeting Summary",
                "documenttypekey": "Attachment",
                "insertedon": "2026-02-09T19:43:42",
                "updatedon": "2026-02-09T19:41:35",
                "insertedby": "Toya Spicer",
                "updatedby": "1bf6d09f-8265-46bc-90e1-49806b76e527",
                "documentdate": "2026-02-10T00:44:00.77",
                "mime": "application/*",
                "s3bucketpathname": "/attachments/downloadFileFromECMS?docId=698a7f3eb1b2e06b098968c5&filename=YTP signed and dated -07-22-25.pdf",
                "description": null,
                "other": "",
                "filename": "698a7f3eb1b2e06b098968c5",
                "numberofbytes": 426068,
                "originalfilename": "YTP signed and dated -07-22-25.pdf",
                "servicecaseid": null,
                "displayname": "ToyaSpicer",
                "ecmsdocumentid": "698a7f3eb1b2e06b098968c5",
                "actualdocumentdate": "2025-07-22T00:00:00",
                "activeflag": 1,
                "uploadstatus": null,
                "finalstatus": null,
                "documentattachment": [
                    {
                        "documentpropertiesid": "9df8570f-5c4b-4dae-8f48-ab3e58758ce7",
                        "attachmenttypekey": "Document",
                        "attachmentclassificationtypekey": "Ready by 21",
                        "assessmenttemplateid": null,
                        "attachmentclassificationsubtypekey": "My Youth Transition Plan and Meeting Summary",
                        "activeflag": 1
                    }
                ]}],
    "ytpMeetingFacilitated": null
}',
 updatedon = now(), updatedby = 'CJAMS-65112'
where youthtransitionplanid  IN ('fca23aa7-669d-4413-a8a1-670e4564da34','eed4bc3d-f38e-4105-8c9d-d4b8aa8973dd');

update documentproperties
set objecttypekey ='Person',
objectid ='b3f2340f-d1fa-4db9-aabc-2ec32720f2ea',
updatedon = now(), updatedby = 'CJAMS-65112'
where documentpropertiesid ='9df8570f-5c4b-4dae-8f48-ab3e58758ce7';