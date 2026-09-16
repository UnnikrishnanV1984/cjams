-- CDM-25655 - AMIYA COOPER CASE WILL NOT POPULATE THE CUSTODY AND GUARDIANSHIP MONIES.
/*
-- Issue Description: 
	AMIYA COOPER CASE WAS OPENED, HOWEVER THE CUSTODY AND GUARDIANSHIP MONIES WILL NOT POPULATE, 
	WE CAN NOT FIND ANYTHING WRONG.

-- Case ID: 3122016 - 91050bf0-71f6-46bb-ab72-b95ac10c7eec
-- Client ID: 200138012 (Amiyah Cooper) - b8b4f878-ce3e-4936-bce9-0409a7b367c3
-- GAP ID: 1006156 - 2022-08-24 to 2038-07-27 - 321d1dae-ad2c-404c-acd3-ab0491af1306
-- Provider ID: 6006752 (JENELLE J ALEXANDRE)
-- permanencyplanid = '8579ca37-ad32-4208-af15-80931affd41d'
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan
-- 1	e797fabd-e360-4dea-bedc-132435a9ae11	653e543e-b5db-4ecc-bf5f-552fecce6190	CHILD
-- 0	b6eccdd4-8f13-4723-8ce7-16401843f895	653e543e-b5db-4ecc-bf5f-552fecce6190	AV

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = '8579ca37-ad32-4208-af15-80931affd41d'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = 'e797fabd-e360-4dea-bedc-132435a9ae11',
	updatedby = 'CDM-25655',
	updatedon = now()
where permanencyplanid = '8579ca37-ad32-4208-af15-80931affd41d'
	and activeflag  = 1 ;
	
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where gaprateid = '2aac3f4d-ab77-4cd6-92a4-8ad916a783e0' ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-25655',
	updatedon = now()
where gaprateid = '2aac3f4d-ab77-4cd6-92a4-8ad916a783e0' ;
