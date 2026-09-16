update servicecasedisposition
set statusdate = effectivedate, updatedon = now(), updatedby = 'Datafix as per CDM-1546'
where servicecaseid = '3dd8bf7e-4426-4af7-91a5-d8626ce40603';