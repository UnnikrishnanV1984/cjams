/*
   Issue Description: CJAMS-60028
   Category/ Module  : Prod data fix to duplicate ACA
   Root cause:  User Error
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update adoptionapplicabilityinfo set activeflag = 0 , updatedby = 'CJAMS-60028', updatedon = now() 
where adoptionapplicabilityid = 'e3255af6-d848-489e-b8cb-e4a56c94e92a' and activeflag = 1;


update routing set activeflag = 0 , updatedby = 'CJAMS-60028', updatedon = now() 
where routingid = 'b77255e3-9cfb-4c6b-a941-40cdb0c5f071' and activeflag = 1;