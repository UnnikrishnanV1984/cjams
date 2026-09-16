-- CDM-34782 - Flex fund
/*
-- Issue Description: 
   User unable to request a flex fund for 2023 for 2 clients.
   OOH program assignment with end date prior to start date (Data issue).

-- Case ID: 231030133153 - 60318bcc-aed0-4bcb-b6cd-589722a9aa2e
-- Client ID: 4021576 (MALIK BROWN) - 24c09b05-73cc-459f-b1db-864bd15ac600
-- OOH: 2023-09-03 To 2020-08-05 - 9a485501-3813-4ab9-a20b-9f4239d6cd05	

-- Client ID: 4403457 (MAKHI BROWN) - 1c3673db-75b4-44d6-bcac-412b150eed59
-- OOH:	2023-09-03 To 2020-08-05 - 6684b2aa-083d-47a2-9513-082d07551ee1

-- Category/ Module: GAP (Case Management) 
-- Root cause: OOH program assignment with end date prior to start date (Data issue).
-- Fix Provided: Datafix has been promoted to re-open OOH program assignments.
-- And code fix has been promoted to end date the corresponding OOH program assignment for PLCC scenario.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update re-open OOH program assignments (CDM-34782)
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid in (	'9a485501-3813-4ab9-a20b-9f4239d6cd05',
							'6684b2aa-083d-47a2-9513-082d07551ee1'
						 )	
	and programkey = 'OOH'
	and enddate::date = '2020-08-05'::date ;
	
update personprogramarea
set enddate = NULL, -- Removal is Active
	updatedon = now() 
where personprogramid in (	'9a485501-3813-4ab9-a20b-9f4239d6cd05',
							'6684b2aa-083d-47a2-9513-082d07551ee1'
						 )	
	and programkey = 'OOH'
	and enddate::date = '2020-08-05'::date ;

