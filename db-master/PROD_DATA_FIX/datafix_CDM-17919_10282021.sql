-- CDM-17919 - Duplicate Removals
/*
-- Issue Description: 
    User request to delete the Duplicate OOH Program Assignment  
    
-- Case ID: 3003543
-- Client ID: 1496467 (ISAIAH E	ANDERSON) - 46211393-0431-47e9-af7c-91ca1e9b53b0
-- OOH - 2015-12-29 To Current - 7f309d41-f3f6-444a-ba3b-96000345f868

-- Category/ Module: Child Removal (Case Management) 
-- Root cause: Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select personprogramid , programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personid = '46211393-0431-47e9-af7c-91ca1e9b53b0'
	and personprogramid = '7f309d41-f3f6-444a-ba3b-96000345f868'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
update personprogramarea
set activeflag = 0,
	enddate = startdate,
	updatedby = 'CDM-17919',
	updatedon = now()
where personid = '46211393-0431-47e9-af7c-91ca1e9b53b0'
	and personprogramid = '7f309d41-f3f6-444a-ba3b-96000345f868'
	and programkey = 'OOH'
	and activeflag = 1 ;
