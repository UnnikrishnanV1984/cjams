/*
   Issue Description: CDM-34739
   Category/ Module  : Prod data fix to get the assessment details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


 -- 3f37c2ea-2be9-4e6e-979a-9f4db4dc650e
 update assessment set servicecaseid = '14118f9f-ef92-4b24-9206-36839be1429d', updatedby = 'CDM-34739', updatedon = now()
 where assessmentid in ('f3663409-0bee-4f7a-a031-221ca5ec98e7','0332484c-579e-4144-a288-e5d4bb8c6693');