
/*
   Issue Description: CDM-15687
   Category/ Module  :  Update removal information
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval set isbothparentssigned = 1, updatedby = 'CDM-15687', updatedon = now() where removalid = '251887';