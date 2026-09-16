update cjams.servicecase
set enddate = now(), updatedby = 'Datafix user', updatedon = now()
where servicecaseid  = 'd57cf897-f758-42bf-80ff-64ad9b70e418';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), 'd57cf897-f758-42bf-80ff-64ad9b70e418', now(), 'Closed', 'Closed', 'Closing Case as per CDM-1168 request', now(), 1, 'Datafix user', now(), 'Datafix user', now(), null, null, '', null);