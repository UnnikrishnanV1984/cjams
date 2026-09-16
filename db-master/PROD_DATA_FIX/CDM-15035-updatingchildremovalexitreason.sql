
/*
   Issue Description: CDM-15035
   Category/ Module  :  Updating the Exit date for Removal Record
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval set removalexitreason = 'EMANIND', updatedby = 'CDM-15035', updatedon = now() where removalid = '181221';
