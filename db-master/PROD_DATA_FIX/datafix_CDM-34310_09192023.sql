-- CDM-34310 - 231020893505 Investigation findings missing
/*
-- Issue Description: 
	CPS IR case with Duplicate Investigation finding

-- CPS-IR: 231020893505 - d8f1ca9a-e873-4b17-9037-a51f812527aa
-- Investigationid:  b62fdf9d-a553-40ce-bf41-e37c838b497a

-- Category/ Module: Maltreatment/Finding (Investigation Management)
-- Root cause: Data Issue (Incorrect investigaton findings)
-- Fix Provided: Datafix has been promoted to remove the Investigation Maltreatment info, 
--				 please ask the user to save the data again on "Maltreatment Allegation" screen.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To remove the remove the Investigation Maltreatment info (CDM-34310)

update investigationmaltreatment 
set activeflag = 0,
	updatedby = 'CDM-34310',
	updatedon = now() 
where investigationid = 'b62fdf9d-a553-40ce-bf41-e37c838b497a' 
	and activeflag = 1 ;

update investigationallegation 
set activeflag = 0,
	updatedby = 'CDM-34310',
	updatedon = now() 
where investigationid = 'b62fdf9d-a553-40ce-bf41-e37c838b497a' 
	and activeflag = 1 ;