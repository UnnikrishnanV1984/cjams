/*
Issue Description:CJAMS-64393 sara.savanuck@maryland.gov is listed in the Wrong Unit CJAMS.
Category/Module: Placement 
Root cause: Sara Savnuck (sara.savanuck@maryland.gov) is listed in the In Home Unit in Sailpoint for CJAMS (see attached screenshot).
However when her supervisor looks in CJAMS, she is still listed under the Out of Home unit.
Fix provided: Data fix has been done to correct the team assignment
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
*/

update cjams.teammember 
	set teamid = 'b8d4d6d4-bd06-4087-b38a-b085abb266db',
		updatedby = 'CJAMS-64393',
		updatedon = now()
	where teammemberid = '7dcecbe3-4a78-498f-9f21-cf507c3a603b';