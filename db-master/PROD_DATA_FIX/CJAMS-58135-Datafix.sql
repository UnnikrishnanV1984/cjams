/*
   Issue Description: CJAMS-58135
   Category/ Module  : Assignments
   Root cause: Data fix has been done to appear the cases on My Adoption Case dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update adoptioncase set statustypekey = 'Open',updatedby = 'CJAMS-58135', updatedon = now()
where adoptioncaseid in ('a7e06c31-a1a1-4d7b-860a-edf48b56692b','443aa341-c66e-43c4-96be-5901cbacd977') 
and activeflag = 1;

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('a7e06c31-a1a1-4d7b-860a-edf48b56692b'::uuid, now(), 'Open', 'Inprogress', 'ADOPTION', now(), 1, 'CJAMS-58135', now(), 'CJAMS-58135', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('443aa341-c66e-43c4-96be-5901cbacd977'::uuid, now(), 'Open', 'Inprogress', 'ADOPTION', now(), 1, 'CJAMS-58135', now(), 'CJAMS-58135', now(), NULL, NULL, NULL, NULL);

