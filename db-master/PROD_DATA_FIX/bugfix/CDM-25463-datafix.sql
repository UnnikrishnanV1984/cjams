-- CDM-25463 - duplicate note
/*
-- Issue Description: 
	1. User requested to delete the duplicate note entered on 09/28/2022
	
-- Category/ Module: Contact notes
-- Root cause: Duplicate note
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select 	activeflag, insertedon, updatedon 
from 	progressnote 
where 	progressnoteid = 'd563a22e-42b6-4b48-990f-3e29293a2df7';

update 	progressnote 
set 	activeflag = 0,
		updatedby = 'CDM-25463',
		updatedon = now()
where 	progressnoteid = 'd563a22e-42b6-4b48-990f-3e29293a2df7' and activeflag = 1;