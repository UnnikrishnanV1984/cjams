-- CIDM-4857 - GAP Program Assignment Issue
/*
-- Issue Description: 
	To update GAP Program Assignment End date as GAP Aggrement End date 
   
	Case ID: 3282223
	Provider ID: 5088094  (Loretta Bowman) - Local Department Home
	Client ID: 3983716 (CAMBRIA HOPE BOWMAN) - e9e4db26-5582-459d-838c-200f4610eb87
	GAP ID: 5059 - 11/20/2018 To 04/04/2023

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid  = 'f8fe284f-dab6-4ae8-9235-cb67d3f3bb7a'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = '2023-04-04 00:00:00', -- 2022-04-04 00:00:00
	updatedby = 'CIDM-4857',
	updatedon = now()
where  personprogramid = 'f8fe284f-dab6-4ae8-9235-cb67d3f3bb7a'
	and activeflag = 1 ;
