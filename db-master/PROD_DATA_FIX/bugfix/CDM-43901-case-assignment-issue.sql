/*
   Issue Description: CDM-43901 The case assignment created with start date on 01/17/2025. Need technical investigation why the system creating a Family assignment for this case.
   Category/ Module  : Assignments
   Root cause: The family assignment was created as the part of user story CIDM-9543 which created a family assignment for the case
                   When opening or reopening a case, family caseworker assignment must be mandatory.
                   No worker of any type (Child, Admin) can be assigned to a case until a family worker has been assigned
   Fix Provided: Data fix has remove the case assignment record that was created as the part of user story  
   Data/Code fix ticket#: CDM-43901
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: This is impacted due to CIDM-9543 user story and data fix should resolve it.  
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/


update caseassignment set activeflag = 0, updatedby = 'CDM-43901', updatedon = now()
where objectid = '1d537064-7651-4df1-8cea-67b7a411d4ed';

update routing set activeflag=0, updatedby = 'CDM-43901', updatedon = now()
where objectid = '1d537064-7651-4df1-8cea-67b7a411d4ed';