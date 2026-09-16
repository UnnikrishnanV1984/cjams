/*
   Issue Description: CDM-19327
   Category/ Module  : Persons
   Root cause: User requested to remove the individual
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


select * from intakeservicerequestactor where personid='cbea3389-660a-4545-9270-f5b1912d7305' 
and intakeservicerequestactorid in ('995118cd-f230-4621-918b-9c4a20ba8048');

update intakeservicerequestactor set activeflag =0, updatedby='CDM-19327', 
updatedon=now() where intakeservicerequestactorid in ('995118cd-f230-4621-918b-9c4a20ba8048');

select * from actor where personid='cbea3389-660a-4545-9270-f5b1912d7305';

update actor set activeflag =0, updatedby='CDM-19327', updatedon=now() 
where actorid in ('11e35f82-a355-48db-bd7d-fe832b0fd905');
 
 
