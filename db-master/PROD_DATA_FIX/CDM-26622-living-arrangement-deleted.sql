/*
   Issue Description: CDM-26622
   Category/ Module  : Living Arrangement Deleted
   Root cause: user wants Living Arrangement needs to be Deleted
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placement set activeflag = 0, updatedby = 'CDM-26622', updatedon= now() 
where placementid = '6db236d3-9f9f-4215-beac-946e53ac29f5' and activeflag = 1;

update livingarrangement set activeflag = 0, updatedby = 'CDM-26622', updatedon= now() 
where placementid = '6db236d3-9f9f-4215-beac-946e53ac29f5' and activeflag = 1;

update
   routing
set
   activeflag = 0,
   updatedby = 'CDM-26622',
   updatedon = now()
where
   objectid = '6db236d3-9f9f-4215-beac-946e53ac29f5'
   and activeflag = 1;