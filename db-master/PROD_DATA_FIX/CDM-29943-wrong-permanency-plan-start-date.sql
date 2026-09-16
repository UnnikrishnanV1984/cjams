/*
-- CDM-29943- 

-- Issue Description: 
update permanency plan Start date
  
-- Customer Email ID: tailer.speight@maryland.gov
-- Root cause: Data fix to update the permanency plan establish date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
    permanencyplan
set
    establisheddate = '2022-01-27 00:00:00.000',
    updatedon = now(),
    updatedby = 'CDM-29943'
where
    permanencyplanid = '34610cd2-4697-41c8-abe8-5123deb623dd';