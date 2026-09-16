/*
Issue Description:CJAMS-60446 251023059081:Nothing is showing up under the Investigation Finding tab.
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
    updatedby = 'CJAMS-60446',
    updatedon = now()
where investigationid='9ef76d76-b2ee-48be-9393-8583e9c800df'
and activeflag = 1;   
