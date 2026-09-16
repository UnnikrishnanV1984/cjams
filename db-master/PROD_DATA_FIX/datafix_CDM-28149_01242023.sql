-- CDM-28149 - Request to remove end date on GAP. It was end dated by error on 01/05/2023
/*
-- Issue Description: 
   User request to update remove the GAP Program Assignment End date

-- Case ID: 3290442
-- Client ID: 4256973 (JOHN	H MCFADDEN) - a2879b38-a108-4598-9409-88cf3b6768e1
-- 2022-11-23 10:44:01 - 3ca8e63d-f885-445b-aab9-24456e91ad4a	Shaquan Brown

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to remove Program Assignment End date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP program assignment 
select programkey, startdate, enddate, endreasonkey, activeflag, updatedon, updatedby  
	from personprogramarea
where personprogramid = 'b201d265-aeba-4b08-ba33-8f60034929ad'
	and activeflag = 1
	and programkey = 'GAP';
	
update personprogramarea
set enddate = NULL,
	endreasonkey = NULL,
	updatedon = now(), 
	updatedby = '3ca8e63d-f885-445b-aab9-24456e91ad4a'	
where personprogramid = 'b201d265-aeba-4b08-ba33-8f60034929ad'
	and activeflag = 1
	and programkey = 'GAP';