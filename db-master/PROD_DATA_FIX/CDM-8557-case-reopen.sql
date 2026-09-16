
INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), 'a0374b0f-5cbe-4fa1-a735-44f0a2022a87', now(), 'Open', 'Inprogress', 'Case Reopened', now(), 1, 'CDM-8557', now(), 'CDM-8557', now(), null, null, null, null);

