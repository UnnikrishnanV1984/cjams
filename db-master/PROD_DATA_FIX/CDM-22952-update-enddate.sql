/*
-- CDM-22901- 

-- Issue Description: 
 Unable to set the end date
  
-- Customer Email ID: vivian.mayo@maryland.gov

-- Root cause: Data fix to set the end date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placement set enddatetime = '2017-12-20 05:00:00.000', updatedby = 'CDM-22952', updatedon = now()
 where placementid in ('c0dd2371-1924-41a4-a2f8-36a402504240',
'07ef9969-ef4c-4fa6-ad8a-9d7f26a7c0b2',
'1cd89185-7e5f-4529-918c-eff558b8b299',
'd14b9430-c6bd-4935-a1de-5f572bf51ef7');


 update placementrevision  set enddate  = '2017-12-20 05:00:00.000', updatedby = 'CDM-22952', updatedon = now()
 where placementid in ('c0dd2371-1924-41a4-a2f8-36a402504240',
'07ef9969-ef4c-4fa6-ad8a-9d7f26a7c0b2',
'1cd89185-7e5f-4529-918c-eff558b8b299',
'd14b9430-c6bd-4935-a1de-5f572bf51ef7') and activeflag =1;