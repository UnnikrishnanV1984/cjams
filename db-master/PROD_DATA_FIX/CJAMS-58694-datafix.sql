/*
Issue Description: Data fix  to remove the intake# I251013251586 connection with service case # 3276317 
and connected the intake with service case #3263423.
Category/Module: Bug
Root cause: Data fix  to remove the intake# I251013251586 connection with service case # 3276317 
        and connected the intake with service case #3263423.
Fix provided: Data fix  to remove the intake# I251013251586 connection with service case # 3276317 
and connected the intake with service case #3263423.
Data/Code fix ticket#: CJAMS-58694
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

UPDATE cjams.intakeservicerequest
SET servicecaseid=NULL, updatedby='CJAMS-58694', updatedon=now() 
WHERE intakeserviceid='1415b6d2-3522-46f4-a517-c5a898fa3d67' and intakenumber = 'I251013251586';

select * from cjams.createservicecase('1415b6d2-3522-46f4-a517-c5a898fa3d67','5f7a55b9-f41d-46dc-bde2-f2defb06dc5b', 0, 'bacaf254-49bb-4df0-9ea1-c23cfd696d2a');



--3276317

update caseassignment set activeflag = 0
where caseassignmentid = '5c6f23aa-5846-4f65-9c29-e4fcdaf32e3d';

UPDATE
	servicecasedisposition
SET
	activeflag = 0,
	updatedby = 'CJAMS-58694',
	updatedon = now()
WHERE
	servicecasedispositionid = 'a0f450a4-9f29-481e-8bc3-e176179276ad';

UPDATE
	servicecase
SET
	statustypekey = 'Closed',
	dispositioncode = 'Closed',
	updatedon = now(),
	updatedby = 'CJAMS-58694'
WHERE
	servicecaseid = '0cd105a9-702a-4f97-846c-49db2ec8d50a';
    
    
INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), '7bafbfa1-78d9-4be8-9a01-2093f0f891e0'::uuid, NULL, '72439d81-dfaa-46d0-a372-f90eb16f75fd', NULL, NULL, 'bacaf254-49bb-4df0-9ea1-c23cfd696d2a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '72439d81-dfaa-46d0-a372-f90eb16f75fd', '72439d81-dfaa-46d0-a372-f90eb16f75fd', '2025-03-28 08:20:58.888', '2025-03-28 08:20:58.888', 'servicecase', '5f7a55b9-f41d-46dc-bde2-f2defb06dc5b'::uuid, 'family', 1, '2025-03-28 08:20:58.888', NULL, '92c70062-0598-4c20-b853-b701430ab353'::uuid, '92c70062-0598-4c20-b853-b701430ab353'::uuid, NULL, NULL, '9f60d4f1-4004-474f-a432-a19da7b1efe0'::uuid, '9f60d4f1-4004-474f-a432-a19da7b1efe0'::uuid, 'W', NULL, '2025-03-28 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '5f7a55b9-f41d-46dc-bde2-f2defb06dc5b', '2025-03-28 08:20:35.954', 'Open', 'Inprogress', 'Case Reopened', '2025-03-28 08:20:35.954', 1, '72439d81-dfaa-46d0-a372-f90eb16f75fd', '2025-03-28 08:20:35.954', '72439d81-dfaa-46d0-a372-f90eb16f75fd', '2025-03-28 08:20:35.954', NULL, NULL, NULL, NULL, NULL, NULL);


