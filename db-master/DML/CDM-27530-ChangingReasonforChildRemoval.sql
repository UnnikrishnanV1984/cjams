/*
   Issue Description: CDM-27530
   Category/ Module  :  Changing Reason for Child Removal
   Root cause: Changing Reason for Child Removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval set removalexitreason = 'RUF', updatedby = 'CDM-27530', updatedon = now()
where intakeservreqchildremovalid in ('2edcf3db-f684-49e2-a8e4-7a52e7a9fd69', 'd4da40f9-4cee-4f03-b912-68b6a09eb98c');