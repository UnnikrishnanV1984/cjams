-- CDM-24832-missing-case-id
/*
   File Name: CDM-24832-missing-case-id.sql
-- Issue Description: 
  Case id is not being populated 
    
  
-- Resolution: Updated case id as requested

-- Category/ Module: 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea 
set objectid = '4e1c0c3b-60b1-46e0-bcb1-705ec1cfb1bb', 
entityid = '211030012878',
updatedon = now(),
updatedby = 'CDM-24832'
where personprogramid = '981efacd-48cb-4962-bb14-48ef51dbeedf'