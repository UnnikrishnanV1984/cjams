/*
   Issue Description: CDM-23598
    Category/ Module  : Prod data fix to remove the to get adoption details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

      -- 15fd5769-6bfb-407a-b036-033ec6d4934f
      update adoptionplanning set intakeservicerequestactorid = 'ee609c98-60cf-4e09-9453-bdbb34e5cddd', updatedby = 'CDM-23598', updatedon = now()
      where adoptionplanningid = '19abd0ed-d86b-4e13-9c96-4c683349f49b';