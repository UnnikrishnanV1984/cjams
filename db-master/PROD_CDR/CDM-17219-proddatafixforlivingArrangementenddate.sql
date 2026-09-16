 /*
  Issue Description: CDM-17219
   Category/ Module  : Updating placement End date
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-08-04 00:00:00
update placement set enddatetime = '2021-08-25 00:00:00', updatedby = 'CDM-17219', updatedon = now() where placementid = 'ad9fe84f-2163-4aee-be81-796f86fb35e1';
update livingarrangement set livingenddate = '2021-08-25 00:00:00', updatedby = 'CDM-17219', updatedon = now() where placementid = 'ad9fe84f-2163-4aee-be81-796f86fb35e1';
