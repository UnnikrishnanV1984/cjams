/*
Issue Description: Need to add the child to the monthly visit Person Contacted as below;
Client ID: 200938137 (Kaiden Jackson)
Contact ID: 14157312
Category/Module: Error
Root cause: User forgot to add the child as a participant in the visit
Fix provided: DB query to insert child as participant to this visit
Data/Code fix ticket#: CDM-41346
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Inserting child's record into contactparticipant
insert into contactparticipant
	(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, activeflag, effectivedate,
	insertedby, insertedon, updatedby, updatedon, participantid)
values (gen_random_uuid(), 'd0288646-bc6c-4853-8e8c-1dec9ba6c5aa', 'IP', '190d2100-049b-4fcb-a92e-af33cc81c5f4', 1,
    '2024-08-14 10:00:16', 'CDM-41346', now(), 'CDM-41346', now(), '190d2100-049b-4fcb-a92e-af33cc81c5f4');
	
/*
--Backup delete query to revert:
delete from contactparticipant
where
	progressnoteid = 'd0288646-bc6c-4853-8e8c-1dec9ba6c5aa' and
	intakeservicerequestactorid = '190d2100-049b-4fcb-a92e-af33cc81c5f4' and
	activeflag = 1;
*/