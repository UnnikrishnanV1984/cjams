
/*
   Issue Description: CDM-22674
   Category/ Module  : Approval Inbox  
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update routing set activeflag =0, updatedby ='CDM-22674', updatedon = now()

where routingid in('ce4decb1-dedb-4f74-a1d0-d5cff9571786','b452421c-4b61-4445-bc78-5b13464da124');