-- CDM-26110 - Reason for Visit change to Monthly Visit
/*
-- Issue Description: 
   User requested to change the Worker Visit to Monthly Visit
   
-- Case ID: 3161012

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Data Issue (Exception scenario)
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

select 	progressnotereasontypekey
from 	ProgressNote 
where 	progressnoteid = 'c5ec7f51-a42d-4be6-8304-6ea267352ba1';

update 	ProgressNote 
set 	progressnotereasontypekey = 'MV',
		updatedby = 'CDM-26110',
		updatedon = now()
where 	progressnoteid = 'c5ec7f51-a42d-4be6-8304-6ea267352ba1';
