/*
   Issue Description: CDM-16956
   Category/ Module  : Approval removal
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/


update routing  set activeflag =0 , updatedby ='CDM-16956',updatedon = now() 
	where routingid in ('a7edf52b-c39a-417c-8776-f49622772975');