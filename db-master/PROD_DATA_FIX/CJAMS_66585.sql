/* 
Root Cause: There is a duplicate maltreatment type for the same alleged victim & alleged maltreator.
Fix Provided: Data fix was provided by deleting the duplicate record from maltreatment type.
Code Fix: Not Required
*/ 

update investigationmaltreatment 
set activeflag =0, updatedby ='CJAMS-66585', updatedon =now()
where investigationid ='d88d16d8-e981-4f80-9d60-5befb256558f' and maltreatmentid ='e44e1565-7b23-4789-84e7-1044139373a1';
