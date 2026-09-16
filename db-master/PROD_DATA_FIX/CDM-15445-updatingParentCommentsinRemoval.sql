
/*
   Issue Description: CDM-15445
   Category/ Module  :  Updating parent 2 Information
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 1, null
update intakeservreqchildremoval set isbothparentssigned = 2, parent2comments = 'There is not a second parent.', updatedby = 'CDM-15445', updatedon = now() where intakeservreqchildremovalid = 'cd73150c-ec52-4c4d-b8f5-5f7ae592f816';
  