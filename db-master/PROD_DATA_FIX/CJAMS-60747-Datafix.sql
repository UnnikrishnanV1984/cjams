-- CJAMS-60747 Assignment date needs to be back dated

/*
-- Issue Description: 
Re-opened date from 07/16/2025 to 07/01/2025 01:53 PM.
Update date and time in global search.
Add assignment as shown in screenshot with back date 07/01/2025.
Add record to decision tab as reopened by Jill Taylor (Supervisor)

-- Category/ Module: Persons
-- Root cause: User requested to do data fix to be back dated to 7/1/25
-- Resolution: Data fix has been made to case assignment date needs to be back dated to 7/1/25
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update servicecase
  set startdate = '2025-07-01 13:53:00',
      updatedby = 'CJAMS-60747',
	  updatedon = now() 
where servicecasenumber = '3291659'
  and activeflag = 1;

update servicecasedisposition
 set activeflag = 0,
     updatedby = 'CJAMS-60747',
	 updatedon = now() 
where  servicecaseid = '495005e1-fc57-46d9-ac19-aa03ead6d02a'
  and servicecasedispositionid = '2b1960c2-c72b-4cf0-ac36-c4ada072f837'
  and activeflag = 1;

INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(cjams.gen_random_uuid(), cjams.gen_random_uuid(), NULL, '72439d81-dfaa-46d0-a372-f90eb16f75fd', NULL, NULL, 'bacaf254-49bb-4df0-9ea1-c23cfd696d2a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '72439d81-dfaa-46d0-a372-f90eb16f75fd', 'CJAMS-60747', '2025-07-01 13:53:00', now(), 'servicecase', '495005e1-fc57-46d9-ac19-aa03ead6d02a', 'family', 1, '2025-07-01 13:53:00', NULL, '92c70062-0598-4c20-b853-b701430ab353', '92c70062-0598-4c20-b853-b701430ab353', '', 'OPEN', '9f60d4f1-4004-474f-a432-a19da7b1efe0', '9f60d4f1-4004-474f-a432-a19da7b1efe0', 'W', NULL, '2025-07-18 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES('c80b7539-9b6f-47f9-bace-e9ed82bc942b'::uuid, '495005e1-fc57-46d9-ac19-aa03ead6d02a'::uuid, '2025-07-01 13:53:00.000', 'Open', 'Inprogress', 'Case Reopened', '2025-07-01 13:53:00.000', 1, '72439d81-dfaa-46d0-a372-f90eb16f75fd', '2025-07-01 13:53:00.000', 'CJAMS-60747', '2025-07-01 13:53:00.000', NULL, NULL, NULL, NULL, 'Reopen', '');
