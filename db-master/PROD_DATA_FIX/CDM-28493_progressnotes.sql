/*
   Issue Description: CDM-28493
   Category/ Module  :Change contact notes date
   Root cause: ::The CPS referral was not back dated correctly at intake. The referral was received at 4:00pm on 1/24/23 and the intake worker entered today's date, therefore the cps worker's initial F2F contact will not show correctly. 
   Reason why no related code fix:  Data fix
*/

update progressnote 
set updatedby = 'CDM-28493', updatedon = '2023-01-25 12:00:00', insertedon = '2023-01-25 12:00:00', contactdate = '2023-01-24 00:00:00'
where progressnoteid in ('74d06ed1-b4ed-4c81-a484-5bc0825cb613','740e0857-182a-4c04-8802-353bae054d87', '6dfdc319-d4bc-4dd8-a05d-fd53e3533e81');

UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='689a197e-daf0-48c4-98a5-16f9fc4d0db1', participantid='689a197e-daf0-48c4-98a5-16f9fc4d0db1',
updatedby='CDM-28493', updatedon=now()
WHERE contactparticipantid='2388aed6-9add-400f-b47b-3f9d4ff2cf60' and progressnoteid='83fff981-da5e-4551-ba6c-2d966b1023d9';
