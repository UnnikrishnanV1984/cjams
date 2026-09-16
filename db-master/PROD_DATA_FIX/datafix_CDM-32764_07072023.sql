-- CDM-32764 - CLONE - Unable to close adoption case - For Data Fix
/*
-- Issue Description: 
   To Close the Adoption Program Assignment with end date as 07/05/2023

-- 2023-07-05 00:00:00
-- Adoption Case ID: 3260003
-- Client ID: 3873316 (SIRA	M SALLAH) - bb03b95a-d84f-47da-97bf-3b6627ddffe3
-- Adoption Program Assignment: ADP - 2015-11-03 To Current - 41b1f844-3646-4cc1-ae1f-3056a8c11fd6

-- Category/ Module: GAP (Case Management) 
-- Root cause: The code was having a flaw in code validation for Adoption Program Assignment closure.
			   Code fix has been promoted as a prt of CDM-32742
-- Fix Provided: With this tikct the Datafix has been promoted to End date the Adoption Program Assignment
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To End Date the Adoption Program Assignment (CDM-32764)
select programkey, startdate, enddate, endreasonkey, activeflag, updatedon, updatedby  
	from personprogramarea
where personprogramid = '41b1f844-3646-4cc1-ae1f-3056a8c11fd6'
	and activeflag = 1
	and programkey = 'ADP';
	
update personprogramarea
set enddate = '2023-07-05 00:00:00',
	endreasonkey = '3400', -- Age Out, Individual Turned 21 Years Old
	updatedon = now(), 
	updatedby = '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b'	-- 	Laura Joiner Case worker  
where personprogramid = '41b1f844-3646-4cc1-ae1f-3056a8c11fd6'
	and activeflag = 1
	and programkey = 'ADP'
	and enddate is null ;
	
	