/*
   Issue Description: CDM-39960 FC Case number belongs to sibling
   Category/ Module  : IV-E Foster care 
   Root cause: Incorrect Foster care link shown for the following case
                Service Case(bio) -3051264
                Client id(Bio) -4424024 (ARIAH)
                Adopted Client id -201891995/251670
                Adoption case - 231040191779
                It showing the wrong foster care link (Sibling id) - FOSTERCARE - 4150071 (JACE) due to incorrect mapping of intakeservicerequestactorid
   Fix provided : Data fix has been promoted to update the correct intakeservicerequestactorid for the adoption case.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update adoptionplanning 
set intakeservicerequestactorid  = 'd2dff014-da56-4258-ade9-1064a57ae08f',
    updatedby = 'CDM-39960',
    updatedon = now()
where intakeservicerequestactorid ='360751c2-7fdd-4f5d-873c-4468b8877837' and alternateid='1058132'
