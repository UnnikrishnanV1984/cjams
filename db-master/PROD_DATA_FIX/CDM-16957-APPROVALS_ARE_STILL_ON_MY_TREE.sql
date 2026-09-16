/*
   Issue Description: CDM-16957
   Category/ Module  : Approval removal
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/


update routing  set activeflag =0 , updatedby ='CDM-16957',updatedon = now() 
	where routingid in ('d1c29f05-7e56-471f-aa2a-0047f9a9626b');