-- CJAMS-61986
/*
Issue Description: Intake connected to incorrect case and needs a data fix.
Category/Module: Intake 
Root cause: The intake (I251013345702) was connected to the incorrect service case (3185929)..
Fix provided: Data fix has been to done to connect the right case for this intake. Also detached (3185929) from intake (I251013345702).
    -- Also updated request contact notes and assessments to new service case.
Data/Code fix ticket#: CJAMS-61986
Regression Impacts: No
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This issue is not replicable in stage-3 while new intake creation and service case is getting created. 
    We will monitor it for future replication.
*/

-- intake: I251013345702
--servicerequestnumber: 3185929
--intakeserviceid: 042e00eb-db36-4704-96ce-940d12fa359c
--supervisor id: b9d469b3-1e0e-4299-9199-34e7aca045e4


-- Updating intakeservicerequest table servicecaseid to null to detach the intake(I251013345702) with case.
update intakeservicerequest
set servicecaseid = null,
	updatedby = 'CJAMS-61986',
	updatedon = now() 
where intakenumber = 'I251013345702';

-- Updating intakeservicerequestactor table servicecaseid to null to discord persons from service case matching with intake.
UPDATE intakeservicerequestactor isr
SET
    activeflag = 0,
    updatedby = 'CJAMS-61986',
    updatedon = NOW()
FROM actor a
WHERE isr.actorid = a.actorid
  AND isr.servicecaseid = '1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83'
  AND a.servicecaseid = '1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83'
  AND a.personid = '8595a006-cf82-4cbf-a7f5-b628d964e69f'
  AND a.activeflag = 1
  AND isr.activeflag = 1;

-- Updating actor table servicecaseid to null to discord persons from service case matching with intake.
update cjams.actor 
set 
    activeflag = 0,
    updatedby = 'CJAMS-61986', 
    updatedon = NOW()
where servicecaseid = '1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83' and activeflag = 1 and 
	personid = '8595a006-cf82-4cbf-a7f5-b628d964e69f';

---Person program area:
-- Updating personprogramarea table activeflag to inactive.
update cjams.personprogramarea p set activeflag = 0, updatedby = 'CJAMS-61986', updatedon = NOW()
where personprogramid in ('5c9450c7-b26c-44f7-9ce8-1a9786d6295a', '4b1eea62-89e0-4fae-ae02-a743b9a4143f');

-- Creating a new service case for intake based on intakeserviceid
select * from cjams.createservicecase('042e00eb-db36-4704-96ce-940d12fa359c', null, 1, 'b9d469b3-1e0e-4299-9199-34e7aca045e4', null, 'ASSGN', 'intake', null);

-- Updating progressnote table servicecaseid to the new servicecaseid, custom generated for the intake.
-- we need to update entitytypeid as well as it will be having old servicecaseid
update cjams.progressnote p set  updatedby = 'CJAMS-61986', updatedon = now(),
    servicecaseid = isr.servicecaseid, entitytypeid = isr.servicecaseid
    from intakeservicerequest isr
where isr.intakenumber = 'I251013345702' and p.witsid in ('15291439', '15281277') and p.activeflag = 1;

-- Updating assessment table servicecaseid to the new servicecaseid, for its corresponding intake.
update cjams.assessment a
	set objectid = isr.servicecaseid, servicecaseid = isr.servicecaseid
	from intakeservicerequest isr
 where isr.intakenumber = 'I251013345702' and a.activeflag = 1 and 
 a.assessmentid in ('e4c948cd-9296-4060-a8ed-74cc7256085a', '7fd3c7e2-3b5e-460d-b155-35a98c3637fa');

--  --updating the case start date in service case table
update servicecase set startdate = '2025-08-25 14:01:34.000', insertedon = '2025-08-25 14:01:34.000', updatedon=now(), updatedby='CJAMS-61986'
where servicecaseid in (select servicecaseid from intakeservicerequest where intakeserviceid = '042e00eb-db36-4704-96ce-940d12fa359c');

-- assigning the case to the supervisor for caseworker assignment
INSERT INTO caseassignment
	(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,
	responsibilitytypekey,assignmenttype,assigndate, toteamid)
VALUES('8e3e83ca-0693-4fe5-af19-62ac4a60b5b8', '3d7a1020-9f18-4d13-9426-5ac81dc6cfc1', '8e3e83ca-0693-4fe5-af19-62ac4a60b5b8', 'CJAMS-61986', now(), '2025-08-25 14:01:34', 
    '2025-08-25 14:01:34', 'servicecase', (select servicecaseid from intakeservicerequest where intakeserviceid = '042e00eb-db36-4704-96ce-940d12fa359c'),
	'family', 'W', '2025-08-25 14:01:34', '3783b16b-2c12-4664-a4d8-429a7b933f82');

-- This is for blue banner; opened on date on right hand side.
update servicecasedisposition set effectivedate = '2025-08-25 14:01:34.000', updatedon=now(), updatedby='CJAMS-61986'
where servicecaseid = (select servicecaseid from intakeservicerequest where intakeserviceid = '042e00eb-db36-4704-96ce-940d12fa359c');

-- Remove all migrated data from I251013345702 in the Service Case# 3185929
-- Documents tab, we are deactivating the migrated documents from intake referral in old service case
update cjams.documentproperties set activeflag = 0, updatedby = 'CJAMS-61986', updatedon = NOW()
where servicecaseid = '1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83' and 
documentpropertiesid in ('5cde7c84-31bc-472d-a405-d63cb32670ef', '3f8398b0-50e0-43da-aaad-9f8db75acdab');