-- CDM-34391 - Carlee Scott
/*
-- Issue Description: 
   Active OOH program assignment with closed Child removal (Data Issue)

-- Case ID: 3110043
-- Client ID: 3850695 (CARLEE E	SCOTT) - 1c839355-6278-456c-8b13-a4f4baaae4b0
-- Removal ID: 251943 - 2021-04-19 To 2023-06-27 - 970b8969-d032-4e08-bb72-f8e90edde4cf
-- OOH: 2021-04-19 To current - d6b7bb21-c787-4b14-b264-ca1bec3d28cf

-- Category/ Module: GAP (Case Management) 
-- Root cause: Active OOH program assignment with closed Child removal (Data Issue)
-- Fix Provided: Datafix has been promoted to end date the OOH program assignment.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update OOH end date as 2023-06-27 00:00:00 (CDM-34391)
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = 'd6b7bb21-c787-4b14-b264-ca1bec3d28cf'
	and programkey = 'OOH'
	and enddate is null ;
	
update personprogramarea
set enddate = '2023-06-27 00:00:00', -- Removal end date
	updatedon = now() 
	-- updatedby = 'dca1e216-73df-4fe5-9e24-aae5d37bffda' - sherri.chester@maryland.gov
where personprogramid = 'd6b7bb21-c787-4b14-b264-ca1bec3d28cf'
	and programkey = 'OOH'
	and enddate is null ;

