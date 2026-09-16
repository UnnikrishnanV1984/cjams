 /*
  Issue Description: CDM-17405
   Category/ Module  :  Updating User end date for closed case
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 3235800 
update intakeservreqchildremoval set exitdate = '2021-06-10 00:00:00', returntime = '2021-06-10 13:00:00', removalexitreason = 'REUNIF', updatedby = 'CDM-17405', updatedon = now()
where removalid = '195353';