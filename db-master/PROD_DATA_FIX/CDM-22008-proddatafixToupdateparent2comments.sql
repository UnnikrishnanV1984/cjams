/*
   Issue Description: CDM-22008
   Category/ Module  : Prod data fix to update removalinfo
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval set parent2comments = 'There is a single adoptive parent', updatedby = 'CDM-22008', updatedon= now()
where intakeservreqchildremovalid = 'c7ebd152-3b10-4b1b-8642-d329afb4ab09';