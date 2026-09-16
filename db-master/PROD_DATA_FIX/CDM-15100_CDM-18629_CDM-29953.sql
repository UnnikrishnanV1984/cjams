--CDM-15100
--cjamspid: 200773973
--No MDM ID & No CIS#
--select cisclientid, cjamspid, * from cjams.person where cjamspid=200773973

-- SELECT json_agg(a) from sp_get_person_mdm('098baa54-9ed9-4742-ab76-eedb71922b44') a;
--   Select * from cjams.personidentifier where personid='098baa54-9ed9-4742-ab76-eedb71922b44' and personidentifiertypekey='MDM_ID' and activeflag =1;
   delete from cjams.personidentifier where personid='098baa54-9ed9-4742-ab76-eedb71922b44' and personidentifiertypekey='MDM_ID'
   and activeflag =1;
    
   INSERT INTO cjams.personidentifier
(personidentifierid, personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '098baa54-9ed9-4742-ab76-eedb71922b44', 'MDM_ID', 'MDT-152561370', 'CDM-15100', now(), 'CDM-15100', now(), 1, now(), NULL, NULL, NULL, NULL, NULL);

update cjams.person set cisclientid='547064900' , updatedby='CDM-15100', updatedon=now() where personid = '098baa54-9ed9-4742-ab76-eedb71922b44'
and cjamspid =200773973;


---------------------


--CDM-18629
--No MDM ID & No CIS#
--select cisclientid, cjamspid, * from cjams.person where cjamspid=200821356

-- SELECT json_agg(a) from sp_get_person_mdm('9f76459c-874f-44f7-b9ce-f251b3d2e4e9') a;
-- select * from cjams.personidentifier where personid='9f76459c-874f-44f7-b9ce-f251b3d2e4e9' and personidentifiertypekey='MDM_ID' and activeflag =1;
   delete from cjams.personidentifier where personid='9f76459c-874f-44f7-b9ce-f251b3d2e4e9' and personidentifiertypekey='MDM_ID'
   and activeflag =1;
   INSERT INTO cjams.personidentifier
(personidentifierid, personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '9f76459c-874f-44f7-b9ce-f251b3d2e4e9', 'MDM_ID', 'MDT-152561375', 'CDM-18629', now(), 'CDM-18629', now(), 1, now(), NULL, NULL, NULL, NULL, NULL);

update cjams.person set cisclientid='544064977' , updatedby='CDM-18629', updatedon=now() where personid = '9f76459c-874f-44f7-b9ce-f251b3d2e4e9'
and cjamspid =200821356;

-----------------------

--CDM-29953
--No CIS# only. MDM ID is there 
--200929055
--select cisclientid, cjamspid, * from cjams.person where cjamspid=200929055
--MDM ID MDT-146504145

update cjams.person set cisclientid='408063273' , updatedby='CDM-18629', updatedon=now() where personid = 'c3c4a514-23a5-44b3-a87d-c386da6f02c5'
and cjamspid =200929055;

