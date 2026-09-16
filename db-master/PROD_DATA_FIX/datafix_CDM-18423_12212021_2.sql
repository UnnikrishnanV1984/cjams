-- CDM-18423 - GAP date needs to be edited.
/*
-- Issue Description: 
	User request to change the GAP Start date as  9/2/21 (old date 9/15/21)

-- Case ID: 3271184
-- Client ID: 4012238 (ADONIS PARKER) - efacbe8e-b6fe-41f3-aa88-7b5b1c9e767c
-- GAP ID: 1005834 - 2021-09-15 To 2037-10-13 - d32f5f7f-e652-4f1f-b866-f052c17fb932
-- Provider ID: 5078571	(Erica Brooks)

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 2nd script to update the GAP program assignment Start Date as 2021-09-02 (old value is 2021-09-15)
select personid, programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '13d8d3d0-d2ea-4d44-af93-fd564d573641'
	and activeflag = 1 ;

update cjams.personprogramarea 
set startdate = '2021-09-02 00:00:00',
	updatedby = 'CDM-18423_2',
	updatedon = now()
where personprogramid = '13d8d3d0-d2ea-4d44-af93-fd564d573641'
	and activeflag = 1 ;
