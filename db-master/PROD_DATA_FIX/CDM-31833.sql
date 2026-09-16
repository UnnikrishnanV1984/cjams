/*
   Issue Description: CDM-31833
   Category/ Module  : 
   Root cause: update the caseworker name from Megan Swindell to Amanda C Kerstetter on the SAFE-C assessment.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing set fromsecurityusersid='98413a3a-704d-4adf-82fd-d14233e08b2b',updatedby='CDM-31833',updatedon=now() where routingid='80ed2eb2-0214-4508-a7ab-e50841d5a77b';
update  usernotification  set securityusersid='98413a3a-704d-4adf-82fd-d14233e08b2b'  where usernotificationid='96005b39-dfb5-4bb9-ab36-8610f2129194';

