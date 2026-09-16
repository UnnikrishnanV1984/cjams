/*
   Issue Description: CDM-23943
   Category/ Module  : Remove assignment form dashboard
   Root cause: Case is displayed in assignment after assigned
   Pull request# for code fix: 5311
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.routing set activeflag =0,  updatedby = 'CDM-23943', updatedon = now() 
where routingid ='757520cc-5743-4c8f-875b-c1273032c95a'