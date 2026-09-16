--Deactivating the duplicate removal
update servicecasedisposition set activeflag = 0, updatedby =  'CDM-14190', updatedon = now() where servicecasedispositionid in ('276d059c-c843-4b53-a130-bed53212590b');

-- 1420d507-675b-418b-a253-61be20ecc7f0
update routing set tosecurityusersid = 'cbcdca4f-040a-4210-96ec-871b466d1188', updatedby =  'CDM-14190', updatedon = now() where routingid = '738dbe93-7e6c-4b2c-9c2e-0e75788ee4c2'; 
