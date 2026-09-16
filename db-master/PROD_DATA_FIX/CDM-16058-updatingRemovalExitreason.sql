
/*
   Issue Description: CDM-16058
   Category/ Module  :  Update removal information
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE intakeservreqchildremoval SET removalexitreason= 'REUNIF', exitdate = '2021-07-01 14:30:00', updatedon = now(), 
updatedby = 'CDM-16058' WHERE removalid =  191982 AND activeflag = 1;