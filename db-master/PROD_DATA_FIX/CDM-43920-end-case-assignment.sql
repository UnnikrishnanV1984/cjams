/*
   Issue Description: CDM-43920 241022051617:assignment needs to be ended as case was closed.
   Category/ Module  : Assignments
   Root cause: CPS AR is closed on 07/02/2024 and the Administrative assignment is not getting ended when supervisor approved the case closure on 07/02/2024.
   Fix Provided: Data fix has been done to endate the case assignment  
   Data/Code fix ticket#: CDM-43920
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User error
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/


update caseassignment
set enddate='2024-07-02 00:00:00', updatedby='CDM-43920', updatedon=now()
where caseassignmentid='9b0572fd-f827-4c9e-a917-073face09969' and activeflag=1;