/*
-- Issue Description: 
   User requested to change the Worker Visit to Monthly Visit
   
-- Category/ Module: Contacts
-- Root cause: Data Issue (Exception scenario)
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: 
*/

update 	ProgressNote 
set 	progressnotereasontypekey = 'CM,MV',
		updatedby = 'CDM-29648',
		updatedon = now()
		where 	progressnoteid = '5de0576d-7077-4407-9c28-3b8a81625bbc' and witsid='10640768';