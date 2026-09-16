/*
   Issue Description: CDM-15045
   Category/ Module  :  change date
   Root cause: user has got glitch and start date has to be changed
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update personprogramarea
set enddate ='2020-12-23'::date, updatedon =now(), updatedby ='CDM-15045'
where personprogramid ='01bc7a06-65f5-4453-a748-7b12d872611d';

UPDATE Intakeservreqchildremoval
SET exitdate = '2020-12-23', updatedby = 'CDM-15045', updatedon = now() 
WHERE intakeservreqchildremovalid = 'dd1bfcb9-d12c-4d09-be86-870357b5dead';
