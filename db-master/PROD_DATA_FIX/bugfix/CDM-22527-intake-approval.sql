/*
--CDM-22527-intake-approval

-- Issue Description: 
 Intake approval to be updated as required
-- Root cause: Updated the appprover name as required
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cjams.routing 
set updatedby = '5584f32e-f6d8-4960-8e66-081aac2d35c8',
	updatedon = now()
where routingid = '1b098328-2357-45e4-9bb7-eb21fca04360';