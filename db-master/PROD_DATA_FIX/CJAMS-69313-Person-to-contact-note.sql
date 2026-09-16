/*
-- Issue Description: 
   -- CJAMS-69313 - Monthly Visit Participant
   Received approval from supervisor do the data fix

        Please add Alaida Kelley - CJAMS PID - 200156734 , to the Contact ID 16385698 as person contacted, for case ID - 202102505582

-- Category/ Module: Contacts  (Case Management) 
-- Root cause: Data Issue (Exception scenario)
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

INSERT INTO contactparticipant
(progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date)
VALUES('5ea0b441-d252-49df-bd7a-37e8941e4e95'::uuid, 'IP', '4a0bd815-9e3c-4fb0-ba85-364ba37f32ce'::uuid, 'Alaida', 'Kelley', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-06-30 14:33:39.828', 'CJAMS-69313', now(), 'CJAMS-69313', NOW(), NULL, '4a0bd815-9e3c-4fb0-ba85-364ba37f32ce'::uuid, NULL, NULL);
