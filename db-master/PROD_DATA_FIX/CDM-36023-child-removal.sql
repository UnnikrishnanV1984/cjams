    /*
   Issue Description: CDM-36023
   Category/ Module  : person
   Root cause: As requested by user
   Fix Privided: Did data fix to remove the requested child   
*/

select servicecaseid,intakenumber,activeflag,* from actor where personid ='a1860109-649b-4e18-871d-6c12d85119d9';

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-36023'
where actorid in ('a15b7f7e-4349-4cb6-b65e-15e31d08d03c', 'ee12b8b1-a266-47f0-82c6-096d2b9a392d');

select servicecaseid,intakenumber,activeflag,* from intakeservicerequestactor where personid ='a1860109-649b-4e18-871d-6c12d85119d9';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-36023'
where intakeservicerequestactorid in('87eebcf6-a08e-4053-a163-42882fee97f3', '8a5fb4ee-9ad3-4fda-803b-7d7fc28c0c02');

select servicecaseid,* from personrole where personid ='a1860109-649b-4e18-871d-6c12d85119d9';

select * from personrole where personroleid ='57d6228c-558f-4bc4-85cc-7146fb697062';

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-36023'
where personroleid in ('57d6228c-558f-4bc4-85cc-7146fb697062', 'f1b0daf0-d83a-40da-90ea-776fc2144db4');

select servicecaseid,intakenumber,* from actorrelationship where intakeservicerequestactorid in('87eebcf6-a08e-4053-a163-42882fee97f3') and activeflag ='1';

select * from actorrelationship where actorrelationshipid ='40050fcc-ddc8-4c36-ad3b-7d3f90e68336';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-36023'
where intakeservicerequestactorid in('87eebcf6-a08e-4053-a163-42882fee97f3', '8a5fb4ee-9ad3-4fda-803b-7d7fc28c0c02');

select * from personroletype 
where personroleid in ('57d6228c-558f-4bc4-85cc-7146fb697062', 'f1b0daf0-d83a-40da-90ea-776fc2144db4');

update cjams.personroletype
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-36023'
where personroleid in ('57d6228c-558f-4bc4-85cc-7146fb697062', 'f1b0daf0-d83a-40da-90ea-776fc2144db4');