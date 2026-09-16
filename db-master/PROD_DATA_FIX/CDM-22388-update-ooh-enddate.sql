/*
-- CDM-22388- 

-- Issue Description: 
 Unable to update ooh end date
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to update the end date on OOH PA
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea set enddate = '2021-09-30 05:00:00.000', updatedon = now(), updatedby = 'CDM-22388' where personprogramid  = 'bc46d002-19c0-4f63-b1fc-2e49bf6fcb8d';