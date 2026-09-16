/*
   Issue Description: CDM-31893
   Category/ Module  : 
   Root cause: case is not available in the supervisor approval dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update cjams.routing set activeflag=1,fromroleid='CWCW',updatedby='CDM-31893',updatedon=now() 
where routingid='ca1f004d-1179-403e-9dd2-2fed52084ce4';


