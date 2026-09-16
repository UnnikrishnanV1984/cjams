/*
Issue:CJAMS-66976 Subsidy rate.
Category/Module: Adoption Subsisdy rate
Root cause:User requested to update the payment amount.
Fix provided: Data fix has been done to correct the subsidy payment amount
Data/Code fix ticket#: CJAMS-66976
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:  User error and data fix should resolve it.
*/


update adoptioncaseagreementrate
set paymentamout =800, updatedby='CJAMS-66976', updatedon =now()
where adoptionagreementrateid='c48478ed-7e2b-4066-873e-de2a9b76cc67' and adoptionagreementid ='1f5846d2-bd8b-4009-9482-ff47d07ed85d';

update adoptioncaseagreementrate
set updatedby='CJAMS-66976', updatedon =now()
where adoptionagreementrateid = 'c9ba9344-9582-494b-9e00-da625755de75' 
and adoptionagreementid ='1f5846d2-bd8b-4009-9482-ff47d07ed85d';