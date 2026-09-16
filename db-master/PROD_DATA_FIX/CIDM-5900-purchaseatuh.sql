 /*
  Issue Description:  CIDM-5900 Accidentally Submit Request in Production Environment
   Category/ Module  :  Purchase auth
   Root cause: wrongly created
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/

update cjams.routing set activeflag=0, updatedby='CIDM-5900', updatedon=now()  where objectid=1786732 and eventcode='PCAUTH';
