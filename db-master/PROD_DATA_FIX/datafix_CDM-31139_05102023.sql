-- CDM-31139 - OHP Program assignment closed
/*
-- Issue Description: 
   User reuest to re-open the Placement / Child Removal / OOH   

-- Case ID: 3187372
-- Client ID: 4018812 (JOHNOVAN	CHARDON	HOWARD) - 6f7fa680-dc81-46fe-b3c2-6142de8a341c
-- OOH: 2016-11-14 To 2020-08-03 - 2d1426cf-03fb-410e-902a-e0df1f36bd5b

-- Category/ Module: Removal (Case Management) 
-- Root cause: Migrated OOH Data
-- Fix Provided: Datafix has been promoted to re-open the OOH Program assignment.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open OOH 
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '2d1426cf-03fb-410e-902a-e0df1f36bd5b'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-31139',
	updatedon = now()
where personprogramid = '2d1426cf-03fb-410e-902a-e0df1f36bd5b'
	and activeflag = 1 ;
