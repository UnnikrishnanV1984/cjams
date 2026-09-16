/*
   Issue Description: CDM-34812
   Category/ Module  : Persons
   Root cause: User wants to delete the person
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update cjams.intakeservicerequestactor  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-34812'
where intakeservicerequestactorid= 'ea098b9e-dd3c-499b-9aca-b96a82fde5ad';

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-34812'
where actorid ='def8cfa9-8bbc-406d-a99b-708829959355';

update cjams.personrole 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-34812'
where personroleid  = '6c515168-8fea-4567-8e23-563d693877b3';


update cjams.actorrelationship 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-34812'
where intakeservicerequestactorid ='ea098b9e-dd3c-499b-9aca-b96a82fde5ad';

update contactparticipant  set activeflag  =0 ,updatedby ='CDM-34812',updatedon =now() where progressnoteid  in('53e6f33c-f7c8-499f-8d5f-ddfd5d42fac6','505861f7-4b32-45e4-89ad-22ac86e6527f','e83ea546-5632-4ea5-856e-11633d629a0a','5f8c4540-2fbe-4eb8-895b-f053d15db4e7','88d84eb5-b856-4401-801d-e634b6d00a09') and intakeservicerequestactorid ='ea098b9e-dd3c-499b-9aca-b96a82fde5ad' and activeflag  =1;

update progressnote set otherpersonname  = null,updatedby ='CDM-34812',updatedon =now() where progressnoteid ='53e6f33c-f7c8-499f-8d5f-ddfd5d42fac6' ;