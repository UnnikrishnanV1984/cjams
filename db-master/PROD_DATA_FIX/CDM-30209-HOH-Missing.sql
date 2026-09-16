/*
   Issue Description: CDM-30209
   Category/ Module  : Persons tab head of the household
   Root cause: user added multiple times so the system did not take the primary as true
   Pull request# for code fix: 8608
   Reason why no related code fix: 
    requested a data fix to resolve
--------------------------------------------------------------

select isprimary , activeflag , *
from intakeservicerequestactor 
where actorid  ='2bd87121-1f4e-4264-8378-64049f862628'
and intakeservicerequestactorid  = '2e2b65fc-c23e-4044-8585-dd0753656a08'
and activeflag  = 1   
*/


update intakeservicerequestactor set isprimary = 'true', updatedon = now(), updatedby = 'CDM-30209'
where intakeservicerequestactorid = '2e2b65fc-c23e-4044-8585-dd0753656a08' and activeflag  = 1;