INSERT INTO cjams.caseassignment
(eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, 
toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, 
old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon,
objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, fromteamid, toteamid, 
remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, 
assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype)

VALUES('bf54d78f-455b-43c2-8020-cce1417e457a'::uuid, NULL, '849553e6-ffd6-44d5-97f4-0a4ec90a4422', '6010879', NULL, 
'630385e1-9785-404a-899d-1e7bd95c8368', '6010744', NULL, NULL, NULL, NULL, NULL, NULL, '3114631', NULL, NULL,
'CDM-13923', 'CDM-13923', now(), now(), 'servicecase',
'bf54d78f-455b-43c2-8020-cce1417e457a'::uuid, 'family', 1, '2021-06-11 00:00:00.000', 
'b9c90194-1469-4f10-91c5-2e8406c52871'::uuid, '09ce26f0-d0d2-4a57-8f93-1fb31aa3b2fe'::uuid, 
'Family Service case assigned in CHESSIE to family preservation worker.',
NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad'::uuid, 'f5214cb2-953e-41a9-a4ad-71341501e2ad'::uuid, 'W',
'2393535', NULL, NULL, NULL, NULL, NULL, NULL, NULL, null, null, NULL);