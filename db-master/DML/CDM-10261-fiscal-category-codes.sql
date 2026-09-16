   delete from cjams.programcategorylink where fiscalcategoryid=48 and agencyprogramareaid ='55d88702-193b-40b5-9b98-93d8c492ba4f'; 
        INSERT INTO cjams.programcategorylink
( agencyprogramareaid, insertedby, insertedon, updatedby, updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date)
VALUES( '55d88702-193b-40b5-9b98-93d8c492ba4f', 'CDM-10261', current_date, 'CDM-10261', now(), 1, NULL, 48, NULL, NULL);
