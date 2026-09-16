/*
   Issue Description: CJAMS-66485
   Category/ Module  : payments
   Root cause: Service auth approved, not showing to pay
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing 
set activeflag = 0, updatedby='CJAMS-66485', updatedon = now()
where routingid ='faead887-1830-42d4-80f6-50e330e98b2a' and objectid  ='061b9dc7-e692-4094-87f0-72e929b9d1a6' and
     routingstatustypeid = 15 and eventcode ='YTP' and activeflag = 1;

