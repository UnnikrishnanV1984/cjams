/*
   Issue Description: CDM-43921 241022060987:assignment needs to be ended as case was closed
   Category/ Module  : Assignments
   Root cause: CPS AR is closed on 07/02/2024 and the Administrative assignment is not getting ended when supervisor approved the case closure on 07/02/2024.
               We are unable to replicate this issue our local and will try to investigate further on this.
   Fix Provided: Data fix has been done to endate the case assignment  
   Data/Code fix ticket#: CDM-43921
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: We are unable to replicate this issue our local and will try to investigate further on this.
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/


update caseassignment
set enddate='2024-07-03 00:00:00', updatedby='CDM-43921', updatedon=now()
where caseassignmentid='ee5b304e-5e71-4ae6-a212-68ba0172fc60' and activeflag=1;