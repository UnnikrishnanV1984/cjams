/*
Issue Description:CJAMS-63784 Extend GAP agreement
Category/Module: GAP 
Root cause: User was trying to extend the GAP agreement and While analyzing we found that there is an initial subsidy rate with start date is 01/17/2023 
            and rate start date is prior to the GAP agreement start date.
            Need data fix to change the GAP Agreement Start Date to 01/17/2023.
            Case ID: 3231587
            Client ID: 3597446 (ROWAN HEINER)
            Provider ID: 6007621 (Katelyn Davis)
            GAP Agreement Start Date: 01/17/2023 
Fix provided: Data fix has been done to change the GAP Agreement Start Date to 01/17/2023.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested for a data fix to continue the GAP flow.
*/

update gapagreement
set startdate = '2023-01-17 10:00:00',
    updatedby = 'CJAMS-63784',
    updatedon = now()
where gapagreementid='24d3379c-95a7-4750-b485-4ca6398ccfcf'
and activeflag = 1;

--  Trigger payment batch
update gapratesrevision
set approvaldate = now(),
updatedby = 'CJAMS-63784',
updatedon = now()
where gaprateid in ('bd03f55e-2e51-4b1f-83b7-1059fa94e9ec','4b22509c-0a58-4084-a511-6dc6238e98a1','46253c4d-93ad-40b1-8c94-1f95439dfc66')
and activeflag = 1;