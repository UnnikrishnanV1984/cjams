/*
   Issue Description: CJAMS-58015
   Category/ Module  : service log
   Root cause: User requested to add two clients (Ella Hamidi; PID 204073222 & Naia Hamidi; PID: 204073227 ) in the Contact ID: 14784772
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--Ella Hamidi

INSERT INTO cjams.contactparticipant
(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), 'e9aae7ea-7fd5-4f2e-be27-58c7e6113d73', 'IP', '3cb6aae2-1c02-46b2-92ad-ee4eaee1541d', 'Ella', 'Hamidi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-02-03 15:31:58', 'CDM-58015', now(), 'CDM-58015', now(), NULL, '3cb6aae2-1c02-46b2-92ad-ee4eaee1541d', NULL, NULL);

--Naia Hamidi

INSERT INTO cjams.contactparticipant
(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), 'e9aae7ea-7fd5-4f2e-be27-58c7e6113d73', 'IP', 'dba0b5ce-0f1e-4257-a36c-bc0d8d88509b', 'Naia', 'Hamidi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-02-03 15:31:58', 'CDM-58015', now(), 'CDM-58015', now(), NULL, 'dba0b5ce-0f1e-4257-a36c-bc0d8d88509b', NULL, NULL);
