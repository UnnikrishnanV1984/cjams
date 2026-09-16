/*
Issue Description: Please add the respective client ID to the mentioned contact ID as below.
Category/Module: User Error
Root cause: User request add 204251282 in contacts in Contact ID: 16026849
Fix provided: DB query to insert missing participant into the note
Data/Code fix ticket#: CJAMS-66476
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:

*/



INSERT INTO contactparticipant
(progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date)
VALUES('071ad14a-f7a4-4693-a8ed-8977a1338f65'::uuid, 'IP', 'b3725a18-3d50-47b1-a1ab-1e966aa11800'::uuid, 'Tione', 'Dawkins', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-03-10 13:34:01.163', 'CJAMS-66476', now(), 'CJAMS-66476', NOW(), NULL, 'b3725a18-3d50-47b1-a1ab-1e966aa11800'::uuid, NULL, NULL);

