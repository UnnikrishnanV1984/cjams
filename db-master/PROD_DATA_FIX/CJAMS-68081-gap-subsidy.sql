/*
   Issue Description: CJAMS-68081
   Category/ Module: gap rejection
   Root cause:User requested to delete the rejected gap record
   Fix Provided: Fix Provided by deleting the rejected gap record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing
set activeflag =0, updatedby='CJAMS-68081', updatedon=now()
where routingid='7033fb00-2cc3-4cea-856b-f5b94b4beec2' and objectid='8027440a-d3f9-4ecf-8e3c-922e25f54be6' and eventcode='GAAP' and activeflag=1;