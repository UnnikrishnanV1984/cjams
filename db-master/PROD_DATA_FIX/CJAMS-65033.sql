/*
   Ticket: CJAMS-65033
   Issue Description: Need to close case / remove assignmen 
   Category/ Module: Case Assignment 
   Root cause: The CPS IR case (# 251023123251) was closed on 11/13/2025 and there is an active Family assignment available with start date is 11/26/2025.
   Fix Provided: Data fix to delete case assignment as requested by user
   Pull request# for code fix: NA
   Reason why no related code fix: Data issues. Not able to reproduce.
*/

UPDATE caseassignment
SET activeflag = 0, updatedby= 'CJAMS-65033', updatedon = now()
WHERE caseassignmentid in ('0f884dc8-44d6-470c-a99c-7ecfecac8275','29af7322-609f-495d-b421-4896888f3f0d');