-- CDM-25119 - Duplicate Family Assignments
/*
-- Issue Description: 
   Remove the child name from the Family case worker.
-- Case ID: 3279390
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Data Issue (Exception scenario)
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

select 	* 
from 	caseassignmentactor 
where 	caseassignmentid  = '329ffee7-8139-4d25-a0eb-b86df3d0456f' and activeflag = 1;

update 	caseassignmentactor 
set 	activeflag = 0,
		updatedby = 'CDM-25119',
		updatedon = now()
where 	caseassignmentid  = '329ffee7-8139-4d25-a0eb-b86df3d0456f' and activeflag = 1;