/*
Issue Description: CJAMS-63559 unable to case connect/assign to worker
Category/Module: Case connect
Root cause: I251013442039:I251013442039 Supervisor screened in this intake but cancelled out of the Assign box because there were multiple service cases listed. 
            Data fix needed to connect intake to servicecase 251030555159 and assigned Fam worker to Cheryl Hess (under Montgomery County > Foster Care 1
Fix provided: Data fix has been done connect the intake to servicecase 251030555159 and assign Fam Worker to cheryl Hess under  Montgomery County > Foster Care 1
Data/Code fix ticket#: CJAMS-63559
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User didnot do a case connect and data fix should resolve it.
*/


----intakeserviceid -->286b171e-8020-4506-a518-33ffc0acab7c
----servicaseid --> add68969-b18c-4bbf-ba5c-e11d1357765c
--supervisor id --> 'b3b22c73-2132-4a64-bfff-7f353dea75a1' - Julie Boyd
 
select * from createservicecase('286b171e-8020-4506-a518-33ffc0acab7c', 'add68969-b18c-4bbf-ba5c-e11d1357765c',0,'b3b22c73-2132-4a64-bfff-7f353dea75a1',null,'ASSGN','intake',null);

 
--- assigning the case to Fam worker to Cheryl Hess

INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), gen_random_uuid(), NULL, 'b3b22c73-2132-4a64-bfff-7f353dea75a1', NULL, NULL, 'c4810f09-b7e7-45b1-b4fa-41b7e05f0ba1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CJAMS-63559', 'CJAMS-63559', now(),now(), 'servicecase', 'add68969-b18c-4bbf-ba5c-e11d1357765c'::uuid, 'family', 1, '2025-11-18 13:03:00.000', NULL, 'ba7d007f-6f00-43a5-ad02-d82f8e556d68'::uuid, 'd9d7a2e7-e4ce-4eb7-a2d9-aefc0c8a390b'::uuid, '', 'ASSGN', 'f6ab02d5-c386-4659-8810-687fc191a967'::uuid, 'f6ab02d5-c386-4659-8810-687fc191a967'::uuid, 'W', NULL, '2025-11-18 13:03:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

update servicecasedisposition
set statusdate = '2025-11-18 13:03:00.000',
	effectivedate = '2025-11-18 13:03:00.000',
	updatedby = 'CJAMS-63559',
	updatedon = now()
	where dispositioncode = 'Inprogress' and
	comments = 'Case Reopened' and
	servicecaseid = 'add68969-b18c-4bbf-ba5c-e11d1357765c';