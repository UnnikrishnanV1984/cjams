/*
   Issue Description: CDM-33941val, Person programarea,Placement
   Root cause: User requested toremove pending approvals
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing set activeflag =0, updatedby ='CDM-33941',updatedon =now() where
 routingid in('2460cd34-7b1e-43ed-b38e-a192bd5dbebb','4aed0c33-b4d9-4e47-912c-d89da4cfe251','cf34854d-26dc-4ae8-8e69-2a66b30386a3');