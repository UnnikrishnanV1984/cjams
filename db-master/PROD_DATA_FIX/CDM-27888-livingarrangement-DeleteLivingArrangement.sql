-- CDM-27888-Delete Living Arrangement  
/*
File Name: CDM-27888-livingarrangement-DeleteLivingArrangement 
-- Issue Description: 
   For the Case Id 3272368  Eric Smith's  living arrangement start date has to be the same as the removal date.
   Currently in the system his living arrangement start date is 9/6/2022, and his removal date is 11/1/2022. User is unable to delete the 9/6/22 living arrangement
   CLient Email ID :sarah.utz@maryland.gov

-- Resolution: Updated the activeflag to zero in the placement and livingarrangement table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
	placement
set
	activeflag = 0,
	updatedby = 'CDM-27888',
	updatedon = now()
where
	placementid = 'bc3fb9f6-b523-4eda-9410-d1b6dd9e7d72'
	and activeflag = 1;

update
	livingarrangement
set
	activeflag = 0,
	updatedby = 'CDM-27888',
	updatedon = now()
where
	placementid = 'bc3fb9f6-b523-4eda-9410-d1b6dd9e7d72'
	and activeflag = 1;
