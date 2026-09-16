/*
   Issue Description: CDM-43917 241022230459:assignment needs to be ended as appeal has been completed.
   Category/ Module  : Assignments
   Root cause: CPS AR is closed on 07/23/2024 and  the Family assignment is not getting ended when supervisor approved the case closure on 07/21/2024.
               We are unable to replicate this issue our local and will try to investigate further on this.
   Fix Provided: Data fix has been done to endate the case assignment  
   Data/Code fix ticket#: CDM-43917
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: We are unable to replicate this issue our local and will try to investigate further on this.
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/


update caseassignment
set enddate='2024-07-23 17:45:00', updatedby='CDM-43917', updatedon=now()
where caseassignmentid='c3e62b13-0b46-4c90-b6b1-daf8fe447b8d' and activeflag=1;