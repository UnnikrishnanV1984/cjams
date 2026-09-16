/*
Issue Description: Please add the respective client ID to the mentioned contact ID as below.
Category/Module: User Error
Root cause: User request add 204123755 in contacts in Contact ID: 15049879
Fix provided: DB query to insert missing participant into the note
Data/Code fix ticket#: CJAMS-59912
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:

*/


--Inserting participant into contactparticipant
insert into contactparticipant
(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, activeflag, insertedby,
insertedon, updatedby, updatedon, participantid)
values (gen_random_uuid(), '4216a6f3-5b74-479f-bcd6-c1e4601e2213', 'IP', '6a91301a-7ffa-430b-9040-7604af60ac49', 1,
'CJAMS-59912', now(), 'CJAMS-59912', now(), '6a91301a-7ffa-430b-9040-7604af60ac49');