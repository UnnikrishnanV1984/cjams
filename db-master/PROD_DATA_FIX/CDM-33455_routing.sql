/*
  Issue Description: CDM-33455 stuck approval
   Category/ Module:  Approval Inbox
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.routing
SET activeflag = 0, updatedby='CDM-33455', updatedon=now()
WHERE routingid='4d338af4-2307-4735-8b53-c2b697535876' and eventcode='CPLAN2' and  routingstatustypeid=15 and activeflag=1 and servicerequestnumber='3127157';

