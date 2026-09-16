/*
-- CDM-37797 - No Removal Date
-- Category/ Module: Child Removal
-- Root cause: 3267817: User attempting to close this case however the removal date is not appearing even after the placement has been ended and approved.
-- Fix Provided: Datafix has been done.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from intakeservreqchildremoval where intakeservicerequestactorid = 'e13afb76-aedf-45b4-ab1f-85df88b827ea';

update intakeservreqchildremoval
set intakeservicerequestactorid = 'e13afb76-aedf-45b4-ab1f-85df88b827ea', 
	updatedby = 'CDM-37797', 
	updatedon = now()
where intakeservreqchildremovalid = '65358fae-c11a-4a98-8d0d-672262bb337e';