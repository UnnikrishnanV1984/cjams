/*
Issue Description:CJAMS-60997 Adption Subsisdy Payment issue
Category/Module: Adoption Subsidy 
Root cause: The agreement end date need to be updated as 3/31/2026.
            As per the system design, the placement end date should not overlap with the adoption agreement start date. 
            In this case, the  adoption agreement start date is 08/08/2008 but the placement end dated on 08/20/2008. 
            This is a know in issue and a user story is created for the same.
Fix provided: Data fix has been done to update the adotion subsidy end date as  3/31/2026 for the case 3164615.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a know issue and User story is created to address it.
*/

update adoptioncaseagreement 
set enddate = '2026-03-31 00:00:00',
	updatedby = 'CJAMS-60997',
	updatedon = now()
where adoptionagreementid='159c1ec4-15e5-47a9-9629-5e79dcf045dc'
and activeflag = 1;

-- To Trigger the payments batch
update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-60997'
where adoptionagreementrateid = 'd2c6f6fa-8ead-4b99-85b9-2f2910253ff0'
and activeflag = 1;    


update adoptioncase
set enddate = '2026-03-31 00:00:00',
	updatedby = 'CJAMS-60997',
	updatedon = now()
where adoptioncaseid='75e38ffb-b21d-4f43-b5e6-a24e74b417ef'
and activeflag = 1;