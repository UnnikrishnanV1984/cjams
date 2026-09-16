/*
   Issue Description: CDM-16754
   Category/ Module  : contacts
   Root cause: User requested to remove the role for the person ashley
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



select
    intakeserviceid,
    servicecaseid,
    activeflag,
    *
from
    intakeservicerequestactor
where
    actorid = 'f55bd479-f977-46c9-93e4-e0b1ac4df0c9'
    and intakeservicerequestactorid = '24aaa79d-c3ba-4102-9eb6-b4e72935367d';



update
    intakeservicerequestactor
set
    activeflag = 0,
    updatedby = 'CDM-16754',
    updatedon = now()
where
    actorid = 'f55bd479-f977-46c9-93e4-e0b1ac4df0c9'
    and intakeservicerequestactorid = '24aaa79d-c3ba-4102-9eb6-b4e72935367d';

