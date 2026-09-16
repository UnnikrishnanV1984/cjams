/*
-- CDM-41072 - Monthly Visit Participant

-- Issue Description: 
   User requested to add the child 201475659
   
-- Case ID: 2020030403942

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Data Issue (Exception scenario)
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB

*/

INSERT INTO cjams.contactparticipant
(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '7249b1c8-7cb2-47b1-99ab-da7c1cf99c25', 'IP', 'f60aa88c-8302-4535-af27-42b6462faa39', 'KEITH', 'BENTLEY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2024-07-10 10:41:40.052', 'CDM-41072', now(), 'CDM-41072', now(), NULL, 'f60aa88c-8302-4535-af27-42b6462faa39', NULL, NULL);
