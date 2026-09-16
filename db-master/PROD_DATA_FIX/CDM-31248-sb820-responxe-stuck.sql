/*
   Issue Description: CDM-31248
   Category/ Module  : Prod data fix to remove pending response timer approval
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing set activeflag =0 ,updatedby ='CDM-31248',updatedon =now() where routingid = 'b69d6db4-c292-4ca5-b802-1a1e05e467f1';

update routing set activeflag =0 ,updatedby ='CDM-31248',updatedon =now() where routingid = '21b407cd-5152-4ef8-9a6d-ace54634b7c0';

update routing set activeflag =0 ,updatedby ='CDM-31248',updatedon =now() where routingid = '887bd42b-3a50-4c7c-a3dc-c5c9d8a7c0b8';