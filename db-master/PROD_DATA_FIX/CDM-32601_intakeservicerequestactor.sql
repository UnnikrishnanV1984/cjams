UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-32601', updatedon=now(), activeflag=0
WHERE intakeservicerequestactorid in ('ccda20f2-e708-4fb8-8a9e-d447fdd4eff6', '4977c441-87be-4545-9d7f-4af3d2463a19')
and actorid='679d688e-a4a0-4cd1-a637-62da3bb722e3' and personid='ba249fdf-9454-4541-b853-e834e88a9613';

UPDATE cjams.actor
SET updatedby='CDM-32601', updatedon=now(), activeflag=0
WHERE actorid='679d688e-a4a0-4cd1-a637-62da3bb722e3' and personid='ba249fdf-9454-4541-b853-e834e88a9613';

UPDATE cjams.personrole
SET updatedby='CDM-32601', updatedon=now(), activeflag=0
WHERE personid='ba249fdf-9454-4541-b853-e834e88a9613';

UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-32601', updatedon=now(), intakenumber='I231010637289'
WHERE intakeserviceid='09ba3593-7d17-49ac-8f8b-290593f8e215' and personid='1a92510f-0099-48ce-a289-b62768c84a0b';

UPDATE cjams.actor
SET updatedby='CDM-32601', updatedon=now(), intakenumber='I231010637289'
WHERE intakeserviceid='09ba3593-7d17-49ac-8f8b-290593f8e215' and personid='1a92510f-0099-48ce-a289-b62768c84a0b';

UPDATE cjams.personrole
SET updatedby='CDM-32601', updatedon=now(), intakenumber='I231010637289'
WHERE intakeserviceid='09ba3593-7d17-49ac-8f8b-290593f8e215' and personid='1a92510f-0099-48ce-a289-b62768c84a0b';

UPDATE cjams.contactparticipant
SET intakeservicerequestactorid=(select intakeservicerequestactorid from intakeservicerequestactor WHERE intakeserviceid='09ba3593-7d17-49ac-8f8b-290593f8e215' and personid='1a92510f-0099-48ce-a289-b62768c84a0b' and activeflag = 1 limit 1), updatedby='CDM-32601', updatedon=now(), 
participantid=(select intakeservicerequestactorid from intakeservicerequestactor WHERE intakeserviceid='09ba3593-7d17-49ac-8f8b-290593f8e215' and personid='1a92510f-0099-48ce-a289-b62768c84a0b' and activeflag = 1 limit 1)
WHERE contactparticipantid='1d1463eb-ff7a-481e-8ff3-f7db79744ee3' and progressnoteid='c4318f33-4391-4cd4-81fd-3220ff1e84e5';
