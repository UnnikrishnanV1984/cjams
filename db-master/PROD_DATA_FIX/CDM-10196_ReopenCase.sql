-- CDM-10196 - Reopen closed case

INSERT INTO cjams.servicecasedisposition
( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('79a6ed0b-8a4f-42d2-b179-24a6ecbea038', now(), 'Reopen', 'Inprogress', 'Case Re-Opened', now(), 1, 
'CDM-10196', now(), 'CDM-10196', now(), NULL, null, NULL, null);

UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-10196',updatedon = now() WHERE servicecaseid = '79a6ed0b-8a4f-42d2-b179-24a6ecbea038';
