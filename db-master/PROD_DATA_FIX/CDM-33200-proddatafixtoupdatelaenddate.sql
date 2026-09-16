
/*
   Issue Description: CDM-33200
   Category/ Module  :  Person
   Root cause: user asked to delete the pending intake and remove the case connect
    Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

 -- 2023-07-17 00:00:00, 13:00
 update placement set enddatetime = '2023-06-22 00:00:00', endtime = '08:00', updatedby = 'CDM-33200', updatedon = now()
 where placementid = 'c120f556-bc76-4bee-9f9c-2c409cbc7bda';

-- 2023-07-17 01:00:00
 update livingarrangement set livingenddate = '2023-06-22 08:00:00', updatedby = 'CDM-33200', updatedon = now()
 where placementid = 'c120f556-bc76-4bee-9f9c-2c409cbc7bda';