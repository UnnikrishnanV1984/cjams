/*
-- Issue Description: 
	User request To Expunge CPS IR Case CW2184997

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: 
-- Fix Provided: Datafix has been promoted to expunge the CPS-IR # CW2184997
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


--88991cae-596a-4f7f-bb48-07e8169e25ff
 update permanencyplan
set intakeservicerequestactorid='8dffb583-8bd8-4c68-b051-5111538669fd', updatedby = 'CDM-29323', updatedon= now ()
where permanencyplanid='78b3abc8-0794-4a3c-9a5e-1b825203cf14';
