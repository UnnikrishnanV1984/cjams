/*
   Issue Description: CDM-19288
   Category/ Module  :  Persons
   Root cause: User requested to remove the individual
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



select * from intakeservicerequestactor where personid='946fadbf-577d-46ca-b35f-3b84295d5c31' 
and intakeservicerequestactorid in ('3fc0927a-5ffb-4006-8ac7-3c87ee41961d');

update intakeservicerequestactor set activeflag =0, updatedby='CDM-19288', 
updatedon=now() where intakeservicerequestactorid in ('3fc0927a-5ffb-4006-8ac7-3c87ee41961d');

select * from actor where personid='946fadbf-577d-46ca-b35f-3b84295d5c31';

update actor set activeflag =0, updatedby='CDM-19288', updatedon=now() 
where actorid in ('a34f0455-a52d-4570-a1ec-9f940ff91c2a');
 
