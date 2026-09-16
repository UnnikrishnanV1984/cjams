/*
Issue: CJAMS-63853 Need subsidy rate deleted; duplicate
Category/Module: Payments/Adoption
Root cause: 221040029488 Duplicate Adoption subsidy payment rate was entered and data fix is needed to remove it.
Fix provided:  Data fix has been done to delete the duplicate adoption subsidy rates
Data/Code fix ticket#: CJAMS-63853
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix is needed to delete the duplicate adoption subsidy rate.
*/

update adoptioncaseagreementrate
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CJAMS-63853'
where adoptionagreementrateid = 'd4edb6d5-9ee9-4c86-8283-0f36eda4d8d9'
and activeflag=1;


update routing
set activeflag = 0,
    updatedon = now(), 
	updatedby = 'CJAMS-63853'
where objectid = 'd4edb6d5-9ee9-4c86-8283-0f36eda4d8d9'
and activeflag=1; 


update adoptioncaseagreementrate
set approvaldate = now(),
    updatedon = now(), 
	updatedby = 'CJAMS-63853'
where adoptionagreementrateid in ('6334fb6b-3898-4b15-8bbc-82e2b2ef1f63','d4edb6d5-9ee9-4c86-8283-0f36eda4d8d9')
