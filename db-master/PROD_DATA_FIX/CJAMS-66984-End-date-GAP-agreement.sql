/*
Issue Description: CJAMS-61613 Returned service log
Category/Module: GAP Agreement
Root cause: User requested to update the gap agreement start date as 10/05/2017 as provided.
Fix provided: Data fix has been done to update the servicelog status to denied Case ID: 3303415
Data/Code fix ticket#: CJAMS-61613
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: To be Decided
Reason why no related code fix: 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

update gapagreement
set startdate = '2017-10-05 00:00:00.000',
    updatedby = 'CJAMS-66984',
    updatedon = now()
where gapagreementid = 'f81c9d6f-96ad-47ed-914a-fde7d1e10a47' and activeflag = 1;


--  Trigger payment batch
update gapratesrevision
set approvaldate = now(),
updatedby = 'CJAMS-66984',
updatedon = now()
where gaprateid in ('f79dee4b-4b49-4be0-9765-e04806ca3433',
'8356298b-234b-4f9f-8182-5c9e75415e6f',
'35969cf0-ab41-4af3-a567-27e1937964e3',
'56a0a448-7713-4b07-bab9-8795c8d178f6',
'2790c0a8-e3e5-49f7-bba6-738e42fd9dee',
'afc0ec0f-f1d5-4f7c-854a-87eda2de940a',
'43f8a4c8-ba40-4387-beaf-e3664bf60516')
and activeflag = 1;