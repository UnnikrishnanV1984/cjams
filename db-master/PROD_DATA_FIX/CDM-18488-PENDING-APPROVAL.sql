/*
   Issue Description: CDM-18488
   Category/ Module  : approval screen 
   Root cause: user requeseted to remove pending  apporval 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update routing
	set activeflag = 0, updatedby = 'CDM-18488', updatedon = now()
	where routingid in ('02ad9585-c116-42ca-abae-c22b92055a55',
'4eac89b6-c949-482d-a472-c3dfadca616e',
'7250fa1b-cd40-4d57-8ece-bac74152f46c');
