/*
   Issue Description: CDM-16952
   Category/ Module  : Approval removal
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/

update routing  set activeflag =0 , updatedby ='CDM-16952',updatedon = now() 
where routingid in ('0e3b2c59-3d9f-4d1e-bc52-5af7ebd128c1');