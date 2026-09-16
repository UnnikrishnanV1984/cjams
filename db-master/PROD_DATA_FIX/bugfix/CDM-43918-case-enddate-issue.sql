/*
   Issue Description: CDM-43918 241022207912:assignment needs to be ended as case has been completed. Will not allow family assignment to be closed.
   Category/ Module  : Assignments
   Root cause: CPS AR is closed on 07/21/2024 and  the Family assignment is not getting ended when supervisor approved the case closure on 07/21/2024.
   Fix Provided: Data fix has been done to endate the case assignment  
   Data/Code fix ticket#: CDM-43918
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: We are unable to replicate this issue our local and will try to investigate further on this.
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/


update caseassignment
set enddate='2024-07-21 00:00:00', updatedby='CDM-43918', updatedon=now()
where caseassignmentid='58d9694f-f2cd-4993-9bc7-26b5dd7f62fd' and activeflag=1;