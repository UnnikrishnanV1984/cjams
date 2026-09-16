/*
   Issue Description: CDM-35391
   Category/ Module  : Service Log
   Root cause: No active flag record for routing 
   Pull request# for code fix: 
   Reason why no related code fix:  
   Changed the active flag status to 1 to get the approved user details in history: 
*/

update routing set activeflag  = 1, updatedby = 'CDM-35391', updatedon = now() 
where objectid  = '2328557' and routingstatustypeid  = 39 and eventcode  = 'PCAUTHR';
