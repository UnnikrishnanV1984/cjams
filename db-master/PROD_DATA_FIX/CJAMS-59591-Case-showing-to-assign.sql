/*
   Issue Description: CJAMS-59591 Case is open in a Family Perseveration but keeps ending up on my to be assigned dashboard 
   Category/ Module  : Assign case
   case is already assigned but keep appearing in "To Be Assigned" inbox.
   Root cause: user wants to remove
   Pull request# for code fix: CIDM-10492
   Reason why no related code fix:  
   
*/
update routing 
set activeflag = 0, updatedby = 'CJAMS-59591', updatedon = now() 
where servicerequestnumber = '231030170322' and activeflag = 1
and eventcode = 'SRVC' and routingid = '55a9238d-5ad4-4043-91fd-28d5f58f9e98';