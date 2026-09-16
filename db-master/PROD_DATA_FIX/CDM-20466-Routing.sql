
/*
   Issue Description: CDM-20466
   Category/ Module  : Approval Inbox  
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- Updatedby                             Updatedon
--76f79a9d-05aa-406d-a0e8-4278c9e7d060  2021-03-17 15:09:00

update cjams.routing set activeflag =0, updatedby ='CDM-20466', updatedon = now ()

where routingid ='cfe73c82-cb43-40fa-a801-7684b80d2588';