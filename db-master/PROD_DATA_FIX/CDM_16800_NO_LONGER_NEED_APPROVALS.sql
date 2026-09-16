/*
   Issue Description: CDM-16800
   Category/ Module  : No longer need approvals
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/




update routing set activeflag  = 0, updatedby = 'CDM-16800', updatedon = now()
	where routingid = 'c99f119d-2d69-4154-a743-bbd5e342123b';