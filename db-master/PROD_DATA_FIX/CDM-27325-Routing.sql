/*
   Issue Description: CDM-27325
   Category/ Module  :  Approval inbox
   Root cause: case is closed so user is requeting to remove this record  
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.routing set activeflag =0, updatedby ='CDM-27325', updatedon = now()

where routingid ='0f9cef67-cdbe-4a16-8c51-1536a69b27e9';
