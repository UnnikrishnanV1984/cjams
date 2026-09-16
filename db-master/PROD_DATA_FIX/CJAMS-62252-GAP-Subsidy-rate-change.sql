/*
Issue Description: CJAMS-62252 Subsidy Date off
Category/Module: GAP Subsidy
Root cause: User error  subsidy rate start date with 08/23/2025 and data fix needed to correct it to 08/01/2025
            Client ID: 3282652 (DEIDRA WHITE)
            Provider ID: 5054615 (Jean Jackson)
Fix provided: Data fix has been done to correct the subsidy date to 08/01/2025 and trigger the payments batch.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix to correct it.
*/

update gapagreementrate
set startdate = '2025-08-01 00:00:00',
    updatedby = 'CJAMS-62252',
    updatedon = now()
where gapagreementrateid = '08464e73-28fe-4d4d-9fca-e2891911e992'
and activeflag=1;

update gapratesrevision
set ratestartdate = '2025-08-01 00:00:00',
    approvaldate = now(), /*Triggering the payment batch*/
    updatedon = now(),
    updatedby = 'CJAMS-62252'
where gaprateid = '08464e73-28fe-4d4d-9fca-e2891911e992'
and activeflag =1;