/*
   Issue Description: CDM-22491
   Category/ Module  : Prod data fix to update the age column
   Root cause: 
   Pull request# for code fix: Having the special characters in age field
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update adoptioninitialeligibilityinfo set age = '4', updatedby = 'CDM-22899', updatedon = now() where clientid = '200833150';
