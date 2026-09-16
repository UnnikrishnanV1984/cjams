/*
   Issue Description: CDM-20681
   Category/ Module  : intake referral approval
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4969
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-20681'
where intakenumber = 'I221010243431' and activeflag = 1;
        
update routing 
set routingstatustypeid = 1,
updatedon = now(),
updatedby = 'CDM-20681'
where routingid = 'c5371935-9bff-4acc-9a32-43a2810fc2f7';