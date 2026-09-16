/*
   Issue Description: CDM-22664
   Category/ Module  : Prod data fix to re-open close case 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--Closed        Closed   2021-11-30 00:00:00
UPDATE servicecase 
SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-22664',updatedon = now() 
WHERE servicecaseid = 'c6761e3e-2372-47e5-b069-ac7eabbd9b43';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES('fc6bfa84-3d89-41a4-b7c7-1432b08c9bd5', 'c6761e3e-2372-47e5-b069-ac7eabbd9b43', '2022-08-15 13:46:57.709', 'Open', 'Inprogress', 'In Progress', Now(), 1, 'CDM-22664', Now(), 'CDM-22664', '2022-08-15 13:46:57.709', NULL, NULL, NULL, NULL, NULL, NULL)on conflict do nothing;

INSERT INTO routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
VALUES ('SCDR', 'ce049eee-c805-4af5-954e-f47d023a7a26', 'ce049eee-c805-4af5-954e-f47d023a7a26', 'CWSP', 'CWSP', 'fc6bfa84-3d89-41a4-b7c7-1432b08c9bd5', 16, 1, 'CDM-22664',now(),'CDM-22664', now())on conflict do nothing;