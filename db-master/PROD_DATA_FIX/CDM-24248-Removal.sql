/*
   Issue Description: CDM-24248
   Category/ Module  :  Updating Removal End date
   Root cause: user requeseted to end date
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

update cjams.intakeservreqchildremoval set exitdate  = '2021-07-30 00:00:00',updatedby = 'CDM-24248',updatedon = now() 

where intakeservreqchildremovalid = 'a0d732fd-309f-486c-87f9-0df2498e51ea';