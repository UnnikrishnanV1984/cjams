/*
Issue Description:CJAMS-59115 Drop down reasons missing from Legislative Required Reporting window
Category/Module: Overdue Reason
Root cause: Courtney Holland is the case worker who has created the overdue reason request. This user has been deactivated and we are unable to see the Overdue reason as the request is being pulled from V_userprofile table.
            We need a data fix to update the following information
            Alleged Victim- Alleged Victim Unavailable ->Family was contacted but unavailable to meet within mandate
            Other Children- Other Children Unavailable->family was contacted but unavailable to meet within mandate
            ICC- Initial contact caregiver Unavailable->family was contacted but unavailable to meet within mandate
            Code fix might be needed to show the history information even after the user profile gets deactivated.
Fix provided: Data fix has been done to update the overdue reason as follows 
                Alleged Victim- Alleged Victim Unavailable ->Family was contacted but unavailable to meet within mandate
            Other Children- Other Children Unavailable->family was contacted but unavailable to meet within mandate
            ICC- Initial contact caregiver Unavailable->family was contacted but unavailable to meet within mandate
            This data fix would be reflected only after the code fix CIDM-10519 is deployed.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-10519 
Reason why no related code fix: Data fix needed to correct the user entry error and data fix might be needed to show the history even after the user profile is deactivated.
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VFCM',
    cpsresponsetimerreason4 = 'OOCN',
    cpsresponsetimerreason5 = 'OFMN',
    cpsresponsetimerreason7 = 'CCCN',
    cpsresponsetimerreason8 = 'CFMN',
    updatedon = now(),
    updatedby = 'CJAMS-59115'
where cpsresponsetimeractionsid = 'ca3aa200-db5a-4d70-9c75-0e0f921d5b31'
and intakeserviceid = '904a6cb3-57c7-47ea-b727-b60d96685a0e';