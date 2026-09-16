/*
   Issue Description: CDM-15891
   Category/ Module  :placement removal
   Root cause: user wants to change
   Pull request# for code fix: 
   Reason why no related code fix: 
   user is asked to remove the placement which is not required and there is another fix where user cannot able to edit the placement whcih 
   was already addressed as a part of another ticket
*/

update placement 
set activeflag = 0, updatedby = 'CDM-15891', updatedon = now()
where placementid = '44b28b57-27d1-42d7-82cd-a7bc63ab92ea';