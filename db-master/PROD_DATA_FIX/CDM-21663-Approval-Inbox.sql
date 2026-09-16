/*
   Issue Description: CDM-21618
   Category/ Module  : Approval Inbox
   Root cause: user requeseted to remove it
   Pull request# for code fix: 7449
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update routing set activeflag = 0, updatedby = 'CDM-21663', updatedon = now()
where routingid = '45b7715e-6ec4-4103-8433-69ae8490f1cf';