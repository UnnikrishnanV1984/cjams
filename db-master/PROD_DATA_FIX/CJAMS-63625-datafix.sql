/*
Issue Description: CJAMS-63625
Category/Module: Change Rate Begin Date
Root cause: User requested data fix to update the respective subsidy rate start date.
Case ID: 3300701
Client ID: 2384440 (CALLEN BROWN)
Provider ID: 5094587 (Jaquisa Nash)
Fix provided: Data fix has been promoted to update the respective subsidy rate start date.
Case ID: 3300701
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/

update gapagreementrate
set startdate = '2025-10-01 00:00:00.000',
    updatedby = 'CJAMS-63625',
    updatedon = now()
where gapagreementrateid = '3a10e862-7162-4b22-a845-e96fef7c3ae2'
and activeflag=1;

update gapratesrevision
set ratestartdate = '2025-10-01 00:00:00.000',
    approvaldate = now(), 
    updatedon = now(),
    updatedby = 'CJAMS-63625'
where gaprateid = '3a10e862-7162-4b22-a845-e96fef7c3ae2'
and activeflag =1;
