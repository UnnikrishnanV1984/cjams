-- CDM-28562 - GUARDIAN, HAS NOT BEEN PAID, THE START DATE IS 12-7-22 FOR CUSTODY AND GUARDIANSHIP
/*
-- Issue Description: 
	The GAP was completed on Kaiden Brown and the payments have not been generated.

-- Case ID: 3169787
-- Client ID: 3944338 (NOAH	M WESTMORELAND) - acbd92ae-7f74-46a0-8a29-2ef55f192b72
-- GAP ID: 1006941 - 2022-12-07 To 2033-07-29 - daf57166-df68-48bb-9c88-a881300128ad
-- Provider ID: 5093784	(Norma Degourville) 
-- permanencyplanid: f72cf21a-bee4-4a61-b6b6-bf3efc8d5e2c
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Fix Provided: Datafix has been promoted to resolve the data discrepancy (update active intakeservicerequestactorid in permanencyplan table)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP permanencyplan
-- 0	6cb0259a-0fdb-4b81-93a6-fc90936be409	AV
-- 1	cd0f349a-e2ba-49b5-a3f7-bd2a682314f6	CHILD

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = 'f72cf21a-bee4-4a61-b6b6-bf3efc8d5e2c'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = 'cd0f349a-e2ba-49b5-a3f7-bd2a682314f6',
	updatedby = 'CDM-28562',
	updatedon = now()
where permanencyplanid = 'f72cf21a-bee4-4a61-b6b6-bf3efc8d5e2c'
	and activeflag  = 1 ;
	
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where gaprateid = 'd887887a-4ea7-4f6a-8963-fdab21a8b257' ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-28562',
	updatedon = now()
where gaprateid = 'd887887a-4ea7-4f6a-8963-fdab21a8b257' ;
