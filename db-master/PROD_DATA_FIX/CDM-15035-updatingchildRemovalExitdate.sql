/*
   Issue Description: CDM-15035
   Category/ Module  :  Updating the Exit date for Removal Record
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval set exitdate = '2020-09-18 00:00:00', returntime = '2020-09-18 12:00:00', updatedby = 'CDM-15035', updatedon = now() where removalid = '181221';
