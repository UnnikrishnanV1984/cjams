/*
   Issue Description: CDM-41347
   Category/ Module  :Person Contacted Needs to be added.
   Root cause: worker forgot to list the child, Jasper Thompson as a participant for the visit with the Contact ID: 14160553 and clientID: 4215598 (Jasper Thompson)
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



INSERT 
INTO cjams.contactparticipant
(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date)
VALUES
(gen_random_uuid(), '4b7c0fb1-4b93-4753-ba54-c1ce4cd568e3', 'IP', 'ae9f6d5e-b548-4fd7-8864-e0e469bc538c', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2024-08-14T14:22:18.900Z', 'CDM-41347', now(), 'CDM-41347', now(), NULL, 'ae9f6d5e-b548-4fd7-8864-e0e469bc538c', NULL, NULL);
