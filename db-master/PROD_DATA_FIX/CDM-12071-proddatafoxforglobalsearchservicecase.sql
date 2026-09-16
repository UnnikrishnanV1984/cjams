-- CDM-12071 servicecasedisposition record
INSERT INTO cjams.servicecasedisposition
( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('7f0ca5d9-d4df-4144-af49-0e32cd41fc32', now(), 'Reopen', 'Inprogress', 'Case Re-Opened', now(), 1, 
'CDM-12071', now(), 'CDM-12071', now(), NULL, null, NULL, null);