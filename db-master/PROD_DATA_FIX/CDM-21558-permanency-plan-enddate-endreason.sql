/*
-- CDM-21558 - 

-- Issue Description: 
 Update Enddate and End Reason on Permanency Plan
  
-- Customer Email ID: cecelia.partee@maryland.gov

-- Root cause: Data fix to update Enddate and End Reason on Permanency Plan
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select enddate,reason, * from permanencyplan p where permanencyplanid in ('5329f585-fffd-434f-980d-3c212e70b29e', '6117258c-3c19-4c54-a23d-485d90107b90');


update permanencyplan set enddate = '2022-03-29 00:00:00', reason = 'A new permanency plan needs to be completed.', updatedby = 'CDM-21558',updatedon = now() 
where permanencyplanid in ('5329f585-fffd-434f-980d-3c212e70b29e', '6117258c-3c19-4c54-a23d-485d90107b90');