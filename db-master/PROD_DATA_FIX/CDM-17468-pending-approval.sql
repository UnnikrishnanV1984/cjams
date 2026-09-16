/*
   Issue Description: CDM-17468
   Category/ Module  :  Pending approval for that particular case
   Root cause: user have a pending approval and cannot update or deny
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag =0, updatedby = 'CDM-17468', updatedon = now() where routingid = 'dede0b61-2211-4640-bf35-6272b4336bf9';