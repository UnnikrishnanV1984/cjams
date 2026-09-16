/*
 Issue Description: CIDM-9882
-- Category/ Module: View Charts
-- Root cause: Component name change in JIRA is not reflecting in supportlog table after batch run.
-- Fix Provided: Datafix provided to correct the component (application) name in table for pulling view chart
-- Pull request# N/A
-- Reason why no related code fix: Stored proc fix also fixed which will start updating this column after JIRA load batch script is fixed
-- Status of the code fix if already submitted and expected prod fix date: N/A    
*/

update defecttracking.supportlog
	set application = 'PROV',
		updatedon = now(),
		updatedby = 'CIDM-9882'
	where cdmticketno = 'CDM-42885';