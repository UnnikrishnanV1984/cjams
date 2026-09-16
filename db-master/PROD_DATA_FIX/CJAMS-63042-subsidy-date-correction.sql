/*
Issue:CJAMS-63042 Subsidy Start Date.
Category/Module: Adoption Subsisdy rate
Root cause:User enter Subsidy start date incorrectly and Data fix needed to correct the adoption subsidy rate start date and trigger the subsidy payment batch.
Fix provided: Data fix has been done to correct the subsidy start date and trigger the adoption payment batch.
Data/Code fix ticket#: CJAMS-63042
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:  User error and data fix should resolve it.
*/

update adoptioncaseagreementrate
set startdate = '2025-07-27T04:00:00',
    updatedon = now(),
    updatedby = 'CJAMS-63042'
where adoptionagreementrateid = '4a31d0b5-b9e2-45e5-9b32-0fe57ec58378';

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-63042'
where adoptionagreementrateid = '5869d166-d615-4ed6-b47f-c3530d07a520';