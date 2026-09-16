/*
   Issue Description: CDM-33454
   Category/ Module  : Approval inbox 
   Root cause:  User request to delte approval from inbox
   Fix Provide: Did data fix to remove that record 
*/


update cjams.routing set activeflag =0, updatedby ='CDM-33454', updatedon = now()
where routingid in('9629cdcc-a025-445e-8d11-839e202524f5','ac3ffc09-acf3-4ebe-af06-11d4c8c4d017','126c7a46-1807-4821-ab98-4976d12f97d6');

