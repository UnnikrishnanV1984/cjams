/*
Issue: CJAMS-65868 Need subsidy rate deleted; duplicate
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
	updatedby = 'CJAMS-65868'
where adoptionagreementrateid = '07aa0b96-6cc6-4c01-9972-7f6d1a9508c5'
and activeflag=1;


update routing
set activeflag = 0,
    updatedon = now(), 
	updatedby = 'CJAMS-65868'
where objectid = '07aa0b96-6cc6-4c01-9972-7f6d1a9508c5'
and activeflag=1; 


update adoptioncaseagreementrate
set approvaldate = now(),
    updatedon = now(), 
	updatedby = 'CJAMS-65868'
where adoptionagreementrateid in ('07aa0b96-6cc6-4c01-9972-7f6d1a9508c5');

update adoptioncaserevision 
set activeflag = 0, updatedby = 'CJAMS-65868',updatedon = now() 
where adoptionagreementrateid = '07aa0b96-6cc6-4c01-9972-7f6d1a9508c5'
and activeflag = 1;

