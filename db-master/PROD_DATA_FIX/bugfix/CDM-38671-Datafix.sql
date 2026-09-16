/* 
    Issue Description: CDM-38671
   Category/ Module  : 
   Root cause:remove the intake # CW10067216 from the supervisor pending intake approval dashboard as it has been approved (migrated data).
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/



update routing set activeflag =0 where objectid ='CW10067216' and eventcode ='INTR' and activeflag =1;


