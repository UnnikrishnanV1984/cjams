/*
   Issue Description: CJAMS-66477
   Category/ Module:  Missed child to person contacted list
   Root Cause: User requested to add the child to contact persons as they missed to add.
   Fix provided: Data fix has been done by add the clientAubrielle Mitchem (PID# 200244044) to persons contacted list.
*/

INSERT 
INTO cjams.contactparticipant
(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date)
VALUES
(gen_random_uuid(), 'a28dcd99-4ab5-40c4-bf6a-11dcd6af4a01', 'IP', '7e9423df-7a14-4834-a903-e41d373beb3a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-03-10 16:08:39.505', 'CJAMS-66477', now(), 'CJAMS-66477', now(), NULL, '7e9423df-7a14-4834-a903-e41d373beb3a', NULL, NULL);
