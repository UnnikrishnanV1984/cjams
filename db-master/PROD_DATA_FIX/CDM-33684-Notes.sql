
/*
   Issue Description: CDM-33684
   Category/ Module  : contact note 
   Root cause:  User request 
   Fix Provide: Did data fix to add that child to that contact note 
*/


--removing the wrong updated record
update cjams.contactparticipant set activeflag  =0, updatedby  ='CDM-33684' , updatedon  = now()
where contactparticipantid  ='bd26f188-8da4-4719-9752-cf805488086d';

--updatating the correct person 
INSERT INTO cjams.contactparticipant
(progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date)
VALUES('34845e80-fc6a-47da-8597-e01f618e7a83', 'IP', '97765899-2585-4430-8a22-b281c23d4489', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, now(), 
'1e94770a-45d5-47d3-b036-4bbaa46c2d86', now(), 'CDM-33684', now(), NULL, '97765899-2585-4430-8a22-b281c23d4489', NULL, NULL);
