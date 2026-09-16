/*
   Issue Description: CDM-17627
   Category/ Module  : Service case assignment
   Root cause: User wants to remove the case from their dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag = 0, updatedby = 'CDM-17627', updatedon = now() where routingid = '1e66a455-8dd0-4298-a6ea-060517913a6f'	