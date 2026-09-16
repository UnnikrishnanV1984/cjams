/*
Issue: CJAMS-65867 Need subsidy rate deleted; duplicate
Category/Module: Payments/Adoption
Root cause:Duplicate Adoption subsidy payment rate was entered and data fix is needed to remove it.
Fix provided:  Data fix has been done to delete the duplicate adoption subsidy rates
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix is needed to delete the duplicate adoption subsidy rate.
*/

update adoptioncaseagreementrate
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CJAMS-65867'
where adoptionagreementrateid = '0ced3737-e422-45a7-9a42-ad8739462cca'
and activeflag=1;


update routing
set activeflag = 0,
    updatedon = now(), 
	updatedby = 'CJAMS-65867'
where objectid = '0ced3737-e422-45a7-9a42-ad8739462cca'
and activeflag=1; 


update adoptioncaseagreementrate
set approvaldate = now(),
    updatedon = now(), 
	updatedby = 'CJAMS-65867'
where adoptionagreementrateid in ('0ced3737-e422-45a7-9a42-ad8739462cca');


update adoptioncaserevision 
set activeflag = 0, updatedby = 'CJAMS-65867',updatedon = now() 
where adoptionagreementrateid = '0ced3737-e422-45a7-9a42-ad8739462cca'
and activeflag = 1;

