/*
   Issue Description: CDM-34359
   Category/ Module  : Person
   Root cause:  User request to replace person
   Fix Provide: Did data fix to replace person in all tabs 
*/

UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-34359', updatedon=now(), personid='bf717215-45e4-4c77-9229-4b9cd40075e7'
WHERE intakeservicerequestactorid in ('eda7d288-a1f5-4f49-b89e-16d692888545' , '5514b5b0-eb8a-4ac8-861f-58ef4e9256cb')
and actorid='a81a1097-ea15-49d4-87de-b3569e715515';

UPDATE cjams.actor
SET updatedby='CDM-34359', updatedon=now(), personid='bf717215-45e4-4c77-9229-4b9cd40075e7'
WHERE actorid='a81a1097-ea15-49d4-87de-b3569e715515';

UPDATE cjams.personprogramarea
SET updatedby='CDM-34359', updatedon=now(), personid='bf717215-45e4-4c77-9229-4b9cd40075e7'
WHERE personprogramid='113d5edf-772d-498d-8744-494637578762';

update cjams.personrole 
set personid ='bf717215-45e4-4c77-9229-4b9cd40075e7',updatedby ='CDM-34359', updatedon = now()
where personroleid ='6a4c1dce-60a2-4fe3-b6c6-04f2c7d2aca4';

UPDATE cjams.actorrelationship
SET updatedby='CDM-34359', updatedon=now(), person2id='bf717215-45e4-4c77-9229-4b9cd40075e7'
WHERE actorrelationshipid='dea26bc8-e45e-45ac-9ded-9cf0e7ae0f6c';

UPDATE cjams.actorrelationship
SET updatedby='CDM-34359', updatedon=now(), person1id='bf717215-45e4-4c77-9229-4b9cd40075e7'
WHERE actorrelationshipid='2bc4068b-b8c4-43d0-9712-05cb6d65d434';


update assessment 
set submissiondata = replace(submissiondata::text, 'Sherri Williams', 'SHERRI WILLIAMS ')::json
WHERE assessmentid in ('91dcf0dd-1f92-4ad4-860b-40dcc242a85d', '6c04bf72-ae25-406f-ac3b-e8b22451b78a','173ce0b8-2e91-42ab-80a5-e61c1c39a64d') AND activeflag = 1;

update assessment 
set submissiondata = replace(submissiondata::text, 'Sherri L Williams', 'SHERRI L WILLIAMS ')::json
WHERE assessmentid in ('91dcf0dd-1f92-4ad4-860b-40dcc242a85d', '6c04bf72-ae25-406f-ac3b-e8b22451b78a','173ce0b8-2e91-42ab-80a5-e61c1c39a64d') AND activeflag = 1;

update progressnote set 
focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"1d24a19a-6652-4667-b3c6-0d55150f9aaf","participantid":"1d24a19a-6652-4667-b3c6-0d55150f9aaf","firstname":"AMIA","lastname":"BATSON","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"5514b5b0-eb8a-4ac8-861f-58ef4e9256cb","participantid":"5514b5b0-eb8a-4ac8-861f-58ef4e9256cb","firstname":"SHERRI","lastname":"WILLIAMS","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}',
updatedon = now(),
updatedby = 'CDM-34359'
where progressnoteid = '5b9cf471-7677-4743-b645-15d1d87a8a64';

update progressnote set 
focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"1d24a19a-6652-4667-b3c6-0d55150f9aaf","participantid":"1d24a19a-6652-4667-b3c6-0d55150f9aaf","firstname":"AMIA","lastname":"BATSON","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"5514b5b0-eb8a-4ac8-861f-58ef4e9256cb","participantid":"5514b5b0-eb8a-4ac8-861f-58ef4e9256cb","firstname":"SHERRI","lastname":"WILLIAMS","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}',
updatedon = now(),
updatedby = 'CDM-34359'
where progressnoteid = '51fff3c3-7c7d-4b63-90a7-a45e547ee267';

update progressnote set 
focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"1d24a19a-6652-4667-b3c6-0d55150f9aaf","participantid":"1d24a19a-6652-4667-b3c6-0d55150f9aaf","firstname":"AMIA","lastname":"BATSON","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"5514b5b0-eb8a-4ac8-861f-58ef4e9256cb","participantid":"5514b5b0-eb8a-4ac8-861f-58ef4e9256cb","firstname":"SHERRI","lastname":"WILLIAMS","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}',
updatedon = now(),
updatedby = 'CDM-34359'
where progressnoteid = 'f0c71b48-0141-49e7-9e10-c9f110a8b5e3';

update progressnote set 
focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"1d24a19a-6652-4667-b3c6-0d55150f9aaf","participantid":"1d24a19a-6652-4667-b3c6-0d55150f9aaf","firstname":"AMIA","lastname":"BATSON","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"eda7d288-a1f5-4f49-b89e-16d692888545","participantid":"eda7d288-a1f5-4f49-b89e-16d692888545","firstname":"SHERRI","lastname":"WILLIAMS","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}',
updatedon = now(),
updatedby = 'CDM-34359'
where progressnoteid = 'de75efdf-4b13-4f7c-abc8-a1916b4def31';