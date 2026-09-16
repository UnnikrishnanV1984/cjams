/*
   Issue Description: CDM-34989
   Category/ Module  :Persons 
   Root cause: Head of Household missing
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/
update intakeservicerequestactor
set isprimary = true, updatedby = 'CDM-34989', updatedon =now() 
where intakeservicerequestactorid = '81dc72b2-364e-460d-953f-f772a46330ab';

update intakeservicerequestactor
set isprimary = false, updatedby = 'CDM-34989', updatedon =now() 
where intakeservicerequestactorid = '6b06db5a-e928-482a-9c67-acfd6b5bd49a';