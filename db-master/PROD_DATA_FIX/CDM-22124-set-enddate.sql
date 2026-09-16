/*
-- CDM-22124- 

-- Issue Description: 
 Unable to update the end date
  
-- Customer Email ID: caroline.brouse1@maryland.gov

-- Root cause: Data fix to set the enddate
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea set enddate = '2022-03-20 00:00:00', updatedby ='CDM-22124', updatedon = now() 
where personprogramid = 'ccbee170-ac7f-4c8a-8547-6878780fdcbe';