/*
-- CDM-22948- 

-- Issue Description: 
 Unable to set the updatedby
  
-- Customer Email ID: jamie.cugler@maryland.gov

-- Root cause: Data fix to set the updatedby
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--527e483b-5108-4906-b2bb-6fdbc317f03e
update personprogramarea  set updatedby = 'e4018de0-28aa-499d-886c-3ebcc314a109', updatedon = now()
where personprogramid  = '079b6f4c-ee67-459a-9b93-c86e0a84ad48';