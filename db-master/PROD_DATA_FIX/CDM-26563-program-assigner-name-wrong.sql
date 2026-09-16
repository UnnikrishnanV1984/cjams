/*
   Issue Description: CDM-26563
    221030019637:Ronda Lewis was program assigning client ID 200770612 for In Home Services, Services to Intake however it has 
    updated by Kimberly Cochran vs Ronda Lewis which it should be.
   Category/ Module  : Program Assigner Name Wrong 
   Reason why no related code fix: datafix 
   Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/

update personprogramarea set updatedby = '299210ac-c6df-4985-a02b-bdeda0cdad67' , updatedon =  now()
where personprogramid = 'ed9e3458-5a81-4cf0-a804-0f42ec16748c';