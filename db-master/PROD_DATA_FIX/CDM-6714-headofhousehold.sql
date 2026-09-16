
 /*  Issue Description: CDM-6714-Wrong Head of Household
   Category/ Module  :  service case
   Root cause: It is migration issue and head of household is true for this client 1069353.
   Pull request# for code fix: N/A.
   Reason why no related code fix: N/A.
   Status of the code fix if already submitted and expected prod fix date: N/A 

*/
update intakeservicerequestactor set isheadofhousehold=false, updatedby='CDM-6714', updatedon=now() where
servicecaseid='c884312c-c825-4c0f-a247-a0eaf8016bac'  and personid='8d074444-9d86-41ce-be19-c910e1eebed5' and intakeservicerequestactorid='797b3c31-c2ca-417b-84fc-177288a33614';

