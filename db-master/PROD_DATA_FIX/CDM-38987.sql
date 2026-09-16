/*
 * CDM-38987 - CPS Documents
 * Customer Email ID:lori.engle@maryland.gov
 * Description - CW2859008:We have received an order to expunge any police/criminal related documents from this case. 
 * We need the PAPD report and MD Judiciary deleted from the record. 
 * 
 */

UPDATE cjams.documentproperties
SET activeflag=0, updatedby='CDM-38987', updatedon=now() 
WHERE documentpropertiesid in ('45f5daec-af30-465b-8b2b-51dea82628a8'::uuid, '97dbee23-9164-4db1-b3e5-b194899d2229'::uuid);

update cjams.documentattachment 
SET activeflag =0, updatedby='CDM-38987', updatedon = now()
where documentpropertiesid in ('45f5daec-af30-465b-8b2b-51dea82628a8'::uuid, '97dbee23-9164-4db1-b3e5-b194899d2229'::uuid);