-- CDM-32463 - OOH Milestone Report
/*
-- Issue Description: 
	 User request to Change the Permanency Plan Start date and End date

-- Case ID: 221030015387 - 8703515b-acbe-4a54-872c-c3ad0d19e354
-- Client ID: 200858224	(Kehlani Varsanyi) - 52e8897f-0f4b-4885-839a-8ece049a577b
-- Permanency Plan: cc268994-2b21-4394-ad02-b684c6b888ef - 04/08/2023 To 04/08/2023 - Reunification/Guardianship Relative
-- New Start date 4/8/2022 and end date 10/4/2022.
  
-- Category/ Module: Permanency Plan(Case Management)
-- Root cause: User Error.
-- Fix Provided: Datafix has been promoted to update Start and End date of the requested Permanency Plan
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To change the Permanency Plan date (CDM-32463)
select establisheddate, enddate, primarypermanencytype, concurrentpermanencytype, updatedby, updatedon
	from cjams.permanencyplan
where permanencyplanid = 'cc268994-2b21-4394-ad02-b684c6b888ef'
	and activeflag = 1 ;

update cjams.permanencyplan 
set establisheddate = '2022-04-08 04:00:00',
	enddate = '2022-10-04 00:00:00',
	updatedby = 'CDM-32463',
	updatedon = now()
where permanencyplanid = 'cc268994-2b21-4394-ad02-b684c6b888ef'
	and activeflag = 1 ;
