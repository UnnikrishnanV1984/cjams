/*
   Issue Description: CDM-36173
   Category/ Module  :  Gurdianship checklist
   Root cause: Deleting the case from pending supervisor approval
   Fix: Changed the routing status to 16 to fix the issue.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  */
update
    routing
set
    routingstatustypeid = 16,
    updatedby = 'CDM-36173',
    updatedon = now()
where
    objectid = '787844aa-4a97-4fe8-8cc6-c8ad27e58a18'
    and activeflag = 1;