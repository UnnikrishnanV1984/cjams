
/*
   Issue Description: CDM-18146
   Category/ Module  : Approved Inbox 
   Root cause: 
   Pull request# for code fix: 4235
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.routing set activeflag =0, updatedby = 'CDM-18127', updatedon = now() where servicerequestnumber = '2020019201780' and eventcode = 'CPLAN2' and activeflag = 1 and routingstatustypeid = 15;