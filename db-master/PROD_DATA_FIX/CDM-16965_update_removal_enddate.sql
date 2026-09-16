/*
   Issue Description: CDM-16965
   Category/ Module : Updating the End date for chidle removal
   Root cause: user requeseted to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval 
set exitdate = '2021-09-02 09:00:00', updatedby = 'CDM-16965', updatedon = now() 
where intakeservreqchildremovalid = '96bd1a6a-5ea5-4f90-8f58-06edd7f3bbbf';