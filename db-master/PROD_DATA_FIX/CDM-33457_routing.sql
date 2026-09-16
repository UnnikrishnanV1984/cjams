/*
  Issue Description: CDM-33457 stuck approval
   Category/ Module:  Approval Inbox
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.routing
SET activeflag = 0, updatedby='CDM-33457', updatedon=now()
WHERE routingid='0ad034b7-2491-40ea-b808-58ce7984e659' and eventcode='PPLR' and  routingstatustypeid=15 and activeflag=1 and servicerequestnumber='3153533';
