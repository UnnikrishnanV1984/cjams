/*
-- CDM-21283 - 

-- Issue Description: 
 Update OOH End Date
  
-- Customer Email ID:teresa.boston@maryland.gov

-- Root cause: Data fix to updated the end date
-- Pull request# 5083
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea set enddate = '2021-09-30 00:00:00', updatedby = 'CDM-21283', updatedon = now() 
where personprogramid = '2e0f7a24-fa02-4359-84ae-1212c8670c51'; 

update personprogramarea set entityid = '3149309', updatedby = 'CDM-21283', updatedon = now(),
objectid = '776f3ba7-5a8e-4e82-a258-642cc729372b'
where personprogramid = 'c4bbcf7b-31a5-4b9b-adfc-0c31d9868050'; 