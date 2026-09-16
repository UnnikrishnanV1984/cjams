/*
   Issue Description: CDM-30753
   Category/ Module  : Persons missing in persons tab (Intake)
   Root cause: user wants to add persons (Parent) 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/

update     intakeservicerequestactor
set     isprimary = true,
        updatedby = 'CDM-30753', 
        updatedon = now()
where     actorid = '7ad3addb-66de-42c4-9570-f4df19ed04dd' 
        and intakeservicerequestactorid ='34754538-a337-447d-b2ec-ce4b1fa0684b';