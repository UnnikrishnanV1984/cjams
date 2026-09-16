-- CDM-19212-court
/*
   File Name: CDM-19212-court-01-19.sql
-- Issue Description: 
   User wants to remove in hering details

-- Resolution: 

-- Category/ Module: 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update hearingclients 
set activeflag = 1,
updatedby = 'CDM-19212', 
updatedon = now()
where hearingclientid  in ('e499a9fc-27e8-45e8-8a27-73c15fe586cb', '8a486e7b-e95f-40b8-bbb4-14fa26266ea8');