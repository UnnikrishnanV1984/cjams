/*
Root cause: User requested to add Aaden Mcintosh to the Participants Name along with Shanita Williams as it was missing.
Fix Provided: As requested data fix has been provided by adding Aaden Mcintosh to the Participants Name along with Shanita Williams.
Code Fix: No
*/

DELETE FROM cjams.contactparticipant
WHERE contactparticipantid in ('4600c257-fa9b-4da8-873e-41107da3c911', '553a3669-d6f7-45a3-9baa-54e2534bd9cf', '088f3952-9f7f-4185-887e-8b059063b7b2', 'd83e147e-229d-4d98-bf4b-e31d00e02825');

INSERT INTO cjams.contactparticipant
(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date, isexpunged)
VALUES(gen_random_uuid(), '57cc8981-6ad1-4d8c-82a8-b7d618e54041'::uuid, 'IP', '9dd3bd01-da58-4832-a497-04be281df3c0'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-06-04 12:04:22.543', 'CJAMS-69307', now(), 'CJAMS-69307', now(), NULL, '9dd3bd01-da58-4832-a497-04be281df3c0'::uuid, NULL, NULL, 0);

select *  from cjams.cpsresponsetimerupdate('ba504d0e-f1c2-4257-8ee3-e3dcceb8e5bc'::uuid, 'CJAMS-69307'::character varying);

update cpsresponsetimeractions 
set activeflag =0, updatedby ='CJAMS-69307', updatedon =now()
where intakeserviceid = 'ba504d0e-f1c2-4257-8ee3-e3dcceb8e5bc' and activeflag = 1;
