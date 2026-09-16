-- CDM-25795 - Incomplete Determination
/*
-- Issue Description: 
	1. User confirmed to update the 2nd parent missing reason as
		'Father was not available for signature' in removal screen 

-- Category/ Module: Child Removal
-- Root cause: User Request
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
--Client Id 3232890
select 	activeflag , parent2comments , isbothparentssigned, * from Intakeservreqchildremoval
where  	intakeservreqchildremovalid = '7705da6d-1514-4175-9e1b-744cd03b85f5';

update 	Intakeservreqchildremoval
set 	parent2comments = 'Father was not available for signature',
		isbothparentssigned = 2,
		updatedby = 'CDM-25795',
		updatedon = now()
where 	intakeservreqchildremovalid = '7705da6d-1514-4175-9e1b-744cd03b85f5';