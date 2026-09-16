/*
   Issue Description: CDM-16705
   Category/ Module  :  pending assesment
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/

update routing set activeflag  = 0, updatedby = 'CDM-16705', updatedon = now()
	where routingid = 'f74ec49a-98b2-4c64-b6fb-54a9bd058a7d';