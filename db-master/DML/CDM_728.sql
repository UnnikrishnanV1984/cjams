update servicecase
set enddate = '2018-10-25 00:00:00', updatedby = 'Datafix user', updatedon = now()
where servicecaseid  =  '8a04153f-9767-4c34-b30a-5e5da4b43bb3';

DELETE from servicecasedisposition
where servicecaseid='8a04153f-9767-4c34-b30a-5e5da4b43bb3' and statusdate ='2018-10-25 00:00:00' and dispositioncode = 'Closed';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '8a04153f-9767-4c34-b30a-5e5da4b43bb3', '2018-10-25 00:00:00', 'Closed', 'Closed', 'Closing Case as per CDM-728 request', '2018-10-25 00:00:00', 1, 'Datafix user', now(), 'Datafix user', now(), null, '3254574', '', null);