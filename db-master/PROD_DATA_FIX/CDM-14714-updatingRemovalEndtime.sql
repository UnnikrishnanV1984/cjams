
/*
   Issue Description: CDM-14714
   Category/ Module  :  Updating Removal end time
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval set returntime = '2020-11-04 10:00:00', updatedby = 'CDM-14714', updatedon = now() where removalid = '198593';
