/*
Issue Description:CJAMS-62218 241022584459 data fix to retrieve the information in both the tabs so that 
the user can update the appeal and finalize.
Category/Module: Maltreatment Allegation
Root cause: No information was shown in the Investigation findings as there was Incorrect mapping in the investigation allegation as Neglect where as SDM was having it as Neglect.
            We are investigating on how this has happened and will be closely monitoring the scenarios.
Fix provided: Data fix has been done to update allegation id as Physical abuse in the investigation allegation related tables.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We will closely monitor this issue and try to replicate it again in stage-3 for further analysis
*/

update investigationallegation
set allegationid = '627b574e-aa98-48c1-98c3-cf6f5d155eff',
    updatedby = 'CJAMS-62218',
    updatedon = now()
where investigationid='893e910f-236d-40df-800f-a8b375e883a4'
and activeflag = 1;  