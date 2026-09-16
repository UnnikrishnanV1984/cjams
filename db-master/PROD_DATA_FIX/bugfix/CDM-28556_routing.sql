/*
   Issue Description: CDM-28556
   Category/ Module  :  Pending Assessment 
   Root cause: user requeseted to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-28556', updatedon=now()
WHERE routingid='f28ce2d3-9512-483b-bb3a-5d54e7ade3c9' and objectid='5be90fd9-e9a7-42a3-b00e-379b42bf128f';
