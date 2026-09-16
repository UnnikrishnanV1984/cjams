/*
   Issue Description: CDM-22729
   Category/ Module  : Prod data fix to Update Private Adoption Details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--221040016044
INSERT INTO cjams.adoptioncaseagreement
(adoptioncaseid,  startdate, enddate, effectivedate, parent1providerid, parent2providerid,
parent1providername, parent2providername, agreementcomments, activeflag, insertedby, insertedon, updatedby, updatedon, 
providerid,parent1signdate,parent2signdate,ldssdate)
VALUES('a7e06c31-a1a1-4d7b-860a-edf48b56692b', '2022-04-25 00:00:00.000', '2038-12-22 00:00:00.000','2022-04-25 18:08:58.000',
 6006035, 6006035, 'Eric Stevens', 'Abigail Stevens', 'Within state Child placed by Private Agency',
 1, 'a26dcd1d-a287-43bb-afc9-da75f966f69b', now(), 'CDM-22729', now(),6006035,'2022-01-19 00:00:00.000','2022-01-19 00:00:00.000','2022-01-19 00:00:00.000'
);
 
-- 221040016043
INSERT INTO cjams.adoptioncaseagreement
(adoptioncaseid,  startdate, enddate, effectivedate, parent1providerid, parent2providerid,
parent1providername, parent2providername, agreementcomments, activeflag, insertedby, insertedon, updatedby, updatedon, 
providerid,parent1signdate,parent2signdate,ldssdate)
VALUES('443aa341-c66e-43c4-96be-5901cbacd977', '2022-04-25 00:00:00.000', '2038-12-22 00:00:00.000','2022-04-25 18:08:58.000',
 6006035, 6006035, 'Eric Stevens', 'Abigail Stevens', 'Within state Child placed by Private Agency',
 1, 'a26dcd1d-a287-43bb-afc9-da75f966f69b', now(), 'CDM-22729', now(),6006035,'2022-01-19 00:00:00.000','2022-01-19 00:00:00.000','2022-01-19 00:00:00.000'
);
