/*
   Issue Description: CDM-34484
   Category/ Module  : person
   Root cause: user want to update data in contact
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update progressnote set activeflag =0, updatedby='CDM-34484',updatedon =now() where 
progressnoteid in ('3c0cc456-53a0-402d-9a2e-de329170ce6d');

update contactparticipant set activeflag =0, updatedby='CDM-34484',updatedon =now() where 
progressnoteid in ('3c0cc456-53a0-402d-9a2e-de329170ce6d') and activeflag =1;

update contactparticipant set intakeservicerequestactorid='21170e26-c9ad-4382-99b2-bb9401366b41', updatedby='CDM-34484',updatedon =now() where 
contactparticipantid  in ('7b80779b-65c5-4260-8330-6ebb95bc2e61') and activeflag =1;