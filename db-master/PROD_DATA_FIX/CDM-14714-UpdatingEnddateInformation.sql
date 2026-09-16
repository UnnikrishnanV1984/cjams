
/*
   Issue Description: CDM-14714
   Category/ Module  :  Updating the End date for person program
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2020-11-09 00:00:00
update personprogramarea set enddate = '2020-11-04 00:00:00', updatedon = now(), updatedby = 'CDM-14714' where personprogramid  = 'def54443-a3b1-44c2-b595-658ddb68ea5c';
update intakeservreqchildremoval set exitdate = '2020-11-04 00:00:00',removaltime = '2020-11-04 10:00:00',removalexitreason = 'REUNIF', updatedby ='CDM-14714', updatedon = now() where removalid = '198593';
