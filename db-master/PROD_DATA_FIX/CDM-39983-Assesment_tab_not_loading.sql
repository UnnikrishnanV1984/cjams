/*
-- CDM-39983 - 

-- Issue Description: 
 User not able to see all the assesments in assesment tab.
-- Root cause: Data fix to change user role.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update teammember 
set roletypekey ='CWCW',updatedby ='CDM-39983',updatedon =now()
where teammemberid ='75ddf0db-fb83-45fd-b831-d7514bcec7da' and activeflag =1;