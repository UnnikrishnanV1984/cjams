/*
   Issue Description: CDM-32522
   Category/ Module  : Removal duplicate cases display 
   Root cause:In servicecaserequest table 2 records were inserted wrongly 
  Fix Provided: Removed Empty programkey, subprogram key record from servicecaserequest table 
   
*/


update cjams.servicecaserequest set activeflag =0,
updatedby ='CDM-32522', updatedon = now()
where servicecaserequestid ='3fb8984e-91d1-4f8a-a598-b56d9f8bd755';