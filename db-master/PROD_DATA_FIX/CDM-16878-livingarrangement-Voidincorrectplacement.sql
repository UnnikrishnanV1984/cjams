-- CDM-16878-Need to Void an incorrect placement entered but no button available 
/*
File Name: CDM-16878-livingarrangement-Voidincorrectplacement
-- Issue Description: 
   For the Case Id 3245439 Need to Void an incorrect placement.
   CLient Email ID : danielle.burkey@maryland.gov

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
	updatedby = 'CDM-16878',
	updatedon = now()
where
	placementid = '5e4d91fa-5ab1-44c0-a24d-d6864d4088c8'
	and activeflag = 1;

update
	livingarrangement
set
	activeflag = 0,
	updatedby = 'CDM-16878',
	updatedon = now()
where
	placementid = '5e4d91fa-5ab1-44c0-a24d-d6864d4088c8'
	and activeflag = 1;
