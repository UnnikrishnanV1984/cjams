/*
Issue Description: Please add the respective client ID to the mentioned contact ID as below.
Category/Module: User Error
Root cause: Code does not allow old contact notes to be edited
Fix provided: DB query to insert missing participant into the note
Data/Code fix ticket#: CDM-43085
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR

Backup before update/ delete:Query:
delete from contactparticipant 
where intakeservicerequestactorid = '9bb5f67a-236c-496a-a487-aba890a0c734'
and progressnoteid = '160b1b84-99a4-4e98-8228-dfae4981a67c';
*/


--Inserting participant into contactparticipant
insert into contactparticipant
(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, activeflag, effectivedate, insertedby,
insertedon, updatedby, updatedon, participantid)
values (gen_random_uuid(), '160b1b84-99a4-4e98-8228-dfae4981a67c', 'IP', '9bb5f67a-236c-496a-a487-aba890a0c734', 1, '2024-11-19 09:18:12',
'CDM-43085', now(), 'CDM-43085', now(), '9bb5f67a-236c-496a-a487-aba890a0c734');