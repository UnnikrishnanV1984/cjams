/*
   Issue Description: CDM-22492
   Category/ Module  : Prod data fix to update correct adoption planning id
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptionplanning set intakeservicerequestactorid = '98723abe-8351-4589-b61f-6ba14b32fad3', updatedby = 'CDM-22492', updatedon = now() 
where adoptionplanningid = '965be6d5-45e8-4df5-ac2e-ddc23be80e06';

update adoptionplanning set intakeservicerequestactorid = '4023a9d0-2714-4df6-b29e-c9d2ffc9246c', updatedby = 'CDM-22492', updatedon = now() 
where adoptionplanningid = 'd972059e-e0e9-493b-a8fc-5b72b43286d2';