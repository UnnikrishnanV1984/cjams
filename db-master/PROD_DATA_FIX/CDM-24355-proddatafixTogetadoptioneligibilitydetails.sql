/*
   Issue Description: CDM-24355
   Category/ Module  : Prod data fix to screenout Intake
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update adoptioninitialeligibilityinfo set age='3', updatedon= now(),updatedby='CDM-24355' where clientid= 200858308;