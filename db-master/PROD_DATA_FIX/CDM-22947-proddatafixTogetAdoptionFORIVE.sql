/*
   Issue Description: CDM-22947
   Category/ Module  : Prod data fix to Adoption ACA
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

      -- -- ab498646-148f-4280-b478-3f1f3e5df329
      update intakeservreqchildremoval set intakeservicerequestactorid = 'f2d843b4-304e-4f12-a1d8-1b4a123ac9ec', updatedby = 'CDM-22947', updatedon = now()
      where intakeservreqchildremovalid = '247cf872-b376-465d-b032-2bf673972ca7';