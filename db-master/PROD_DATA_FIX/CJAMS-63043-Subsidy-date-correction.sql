/*
Issue:CJAMS-63043 Subsidy Start Date.
Category/Module: Adoption Subsisdy rate
Root cause:User entered Subsidy start date incorrectly and Data fix needed to correct the adoption subsidy rate start date and trigger the subsidy payment batch.
Fix provided: Data fix has been done to correct the subsidy start date and trigger the adoption payment batch.
Data/Code fix ticket#: CJAMS-63043
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:  User error and data fix should resolve it.
*/

update adoptioncaseagreementrate
set startdate = '2025-07-27T04:00:00',
    updatedon = now(),
    updatedby = 'CJAMS-63043'
where adoptionagreementrateid = '96689c66-c7b3-4c54-af7e-e8a659fc70c3'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-63043'
where adoptionagreementrateid = 'f6141206-79d0-492a-b30d-8b145add7fb8'
and activeflag = 1;