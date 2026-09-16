 /*
   Issue Description: CDM-34348
   Category/ Module  : permanencyplan
   Root cause: Review date inserted wrong one, for this code fix already done long time back 
   Fix Privided: Did data fix to update the correct review date 
*/

update cjams.permanencyplan
set reviewdate  ='2023-06-05 04:00:00.000', updatedby  ='CDM-34348', updatedon  = now()
where permanencyplanid  in ('f855a4cb-8c2b-435d-8797-60a492684e31','f89ff0ab-80d6-40e9-aab9-c35793ca5f13');