-- CDM-7722 - Add Removal Enddate for closed case

update intakeservreqchildremoval 
SET 
returndate = '2020-08-17 13:30:00', 
returntime = '2020-08-17 13:30:00',
exitdate = '2020-08-17 13:30:00',
removalexitreason = 'REUNIF',
updatedon = now(),
updatedby = 'CDM-7722'
where intakeservreqchildremovalid = '864c8b2f-6bd6-4006-8706-c286e9fc5aa8';