/*
   Issue Description: CDM-31011
   Category/ Module  : PLacement
   Root cause: user wants Living Arrangement  to be Deleted
   Pull request #:8881
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placement set activeflag = 0, updatedby = 'CDM-31011', updatedon= now() 
where placementid = '67f633e3-0224-4052-b3f2-e5bd5e61cb92' and activeflag = 1;

update livingarrangement set activeflag = 0, updatedby = 'CDM-31011', updatedon= now() 
where placementid = '67f633e3-0224-4052-b3f2-e5bd5e61cb92' and activeflag = 1;

update
   routing
set
   activeflag = 0,
   updatedby = 'CDM-31011',
   updatedon = now()
where
   objectid = '67f633e3-0224-4052-b3f2-e5bd5e61cb92'
   and activeflag = 1;