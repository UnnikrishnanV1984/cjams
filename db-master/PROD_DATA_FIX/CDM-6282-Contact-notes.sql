 /*  Issue Description:CDM-6282-Unable to add contact person on contact note
   Category/ Module  :  Contact notes
   Root cause: Root cause fixed. Making data fix for this.
   Pull request# for code fix: N/A.
   Reason why no related code fix: N/A.
   Status of the code fix if already submitted and expected prod fix date:Already in prod.

*/
 INSERT INTO cjams.contactparticipant
(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), 'e6e051fd-9f86-41d0-82ff-a2dd3f383c6d', 'IP', '8db2d786-e826-432a-8a32-a3856d7cf7c5', 'BENTLEY', 'GRANT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, now(), 'CDM-6282',now(), 'CDM-6282', now(), NULL, '8db2d786-e826-432a-8a32-a3856d7cf7c5', NULL, NULL);
