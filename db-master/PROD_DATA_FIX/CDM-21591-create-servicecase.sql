/*
-- CDM-21591 - 

-- Issue Description: 
 Please open a Service Case for the intake
  
-- Customer Email ID: marjuin.massalee@maryland.gov

-- Root cause: Data fix to create a new service case
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from cjams.createservicecase('ddeb161e-aaaf-4e3b-af93-4d352dd9149e', null, 1, '8d192f5a-28fa-4a57-8c27-345e61ceb8f7', 'intake', '');