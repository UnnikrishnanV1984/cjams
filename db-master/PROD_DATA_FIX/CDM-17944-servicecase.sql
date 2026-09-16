UPDATE cjams.servicecase
SET startdate='2021-10-27 17:00:40.919', insertedon='2021-10-27 17:00:40.919', updatedon=now(), updatedby='CDM-17944', effectivedate = '2021-10-27 17:00:40'
where servicecaseid = '4019246d-6674-4833-bffa-a8e31b99cb20';


UPDATE cjams.servicecasedisposition
SET statusdate='2021-10-27 17:00:40.919', effectivedate='2021-10-27 17:00:40.919', insertedon='2021-10-27 17:00:40.919', updatedby='CDM-17944', updatedon=now()
WHERE servicecasedispositionid='f8b84395-ee3a-427b-90b2-4794b9f2afa9' and servicecaseid='4019246d-6674-4833-bffa-a8e31b99cb20';

UPDATE cjams.intakeservicerequest
SET reporteddate='2021-10-27 17:00:40.919', reportedtime='2021-10-27 17:00:40.919', updatedby='CDM-17944', updatedon=now(), insertedon='2021-10-27 17:00:40.919', effectivedate='2021-10-27 17:00:40.919'
WHERE intakeserviceid='f86b5feb-c6e8-47dc-a8c1-dd991a29a82d'::uuid;

