/* 
    Issue Description: CDM-39029
    Category/ Module  : Approval stuck
    Root cause: remove the case from the supervisor pending approval dashboard.
    Pull request# for code fix: 
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 
*/


update routing  set activeflag =0 where routingid ='3e05d693-8b83-4c65-bc08-c819f6f3a4e1'
and activeflag =1 and eventcode ='YTP';