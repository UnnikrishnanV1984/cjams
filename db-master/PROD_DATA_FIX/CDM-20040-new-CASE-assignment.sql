/*
   Issue Description: CDM-20040
   Category/ Module  : not able to do assignment
   Root cause: user requeseted to add case assignment
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.caseassignment
( caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype)
VALUES( gen_random_uuid (), '3b401cfc-8af9-4c82-81df-cabb0fdbaf47'::uuid, NULL, '6e0584d0-90b0-4d46-87ce-004e6b740419', NULL, NULL, '8cb570ed-39e2-4a95-8089-76f5951d3c33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3243416', NULL, NULL, 'CDM-20040', 'CDM-20040', now(), now(), 'servicecase', '3b401cfc-8af9-4c82-81df-cabb0fdbaf47'::uuid, 'administrative', 1, '2022-01-28 00:00:00.000', NULL, 'b8d4d6d4-bd06-4087-b38a-b085abb266db'::uuid, 'b8d4d6d4-bd06-4087-b38a-b085abb266db'::uuid, NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c'::uuid, '7665ca54-5374-4174-be07-a687b811a82c'::uuid, 
'W', '4390476', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
