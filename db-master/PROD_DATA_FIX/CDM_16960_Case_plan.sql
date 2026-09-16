/*
   Issue Description: CDM-16960
   Category/ Module  : Approval inbox 
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  removed from approval inbox as its already approved 
   
*/

update routing  set activeflag =0 , updatedby ='CDM-16960',updatedon = now() 
	where routingid = '9bfafb19-a527-4140-ac39-7f6d34014124';