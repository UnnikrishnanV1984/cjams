/*
-- CDM-21146 - 

-- Issue Description: 
 Update the living arrangement end date
  
-- Customer Email ID:candi.bennett@maryland.gov

-- Root cause: Data fix to update the end date of living arrangment
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update livingarrangement 
set livingenddate = '2021-12-08 00:00:00', updatedon = now(), updatedby = 'CDM-21146' 
where placementid in ('ab8f2dd9-27bb-4a37-bf19-fdeb9290fcc9', '0a1b8707-a68e-4306-846f-954a4b575f5d');

update placement 
set enddatetime = '2021-12-08 00:00:00', updatedon = now(), updatedby = 'CDM-21146' 
where placementid in ('ab8f2dd9-27bb-4a37-bf19-fdeb9290fcc9', '0a1b8707-a68e-4306-846f-954a4b575f5d');