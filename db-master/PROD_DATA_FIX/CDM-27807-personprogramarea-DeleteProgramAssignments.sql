-- CDM-27807-ProgramAssignments
/*
File Name: CDM-27807-personprogramarea-DeleteProgramAssignments
-- Issue Description: 
   Darrick Davis Program Assignment's 221020271200:221020271200 which has open dates as 1/3/2023 need to be deleted.

-- Resolution: Updated the activeflag to zero in the personprogramarea table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
	personprogramarea
set
	activeflag = 0,
	updatedby = 'CDM-27807',
	updatedon = now()
where
	personprogramid in ('f4bc5cef-08ff-4137-afc6-a653a9601575', 'ef7253da-1a93-45b4-8e99-cb67758c3bb1')
	and activeflag = 1;
