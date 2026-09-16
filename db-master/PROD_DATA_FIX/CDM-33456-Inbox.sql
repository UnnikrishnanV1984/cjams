/*
   Issue Description: CDM-33456
   Category/ Module  : Approval inbox 
   Root cause:  User request to delte approval from inbox
   Fix Provide: Did data fix to remove that record 
*/
update cjams.routing set activeflag =0, updatedby ='CDM-33456', updatedon = now()
where routingid ='21493bec-3042-4418-bfe6-b8e36677fad3';