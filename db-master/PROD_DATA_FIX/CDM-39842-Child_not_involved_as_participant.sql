/*
   Issue Description: CDM-39842
   Category/ Module  :Person Contacted Needs to be added.
   Root cause: Needed to add FABIOLA LOPEZLOPEZ to the Person Contacted on the Contact ID: 13276876
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.contactparticipant
(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '811908ff-7a45-4f60-b2a1-c816b0fcd150', 'IP', 'a4177455-03f4-415a-87d5-4e6a0f7ed4a4', 'Shauna', 'Lee', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2024-06-05 17:30:46.518', 'CDM-39842', now(), 'CDM-39842', now(), NULL, 'a4177455-03f4-415a-87d5-4e6a0f7ed4a4', NULL, NULL);
