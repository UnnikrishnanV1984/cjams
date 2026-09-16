/*
-- CDM-22217 - 

-- Issue Description: 
 AR case opened on 2/10/22, closed on 3/8/22. It shows closed but there is no end date and all household members continue to show an open AR program assignment, including in the current open service case.
  
-- Customer Email ID:

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# 4934
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update IntakeServiceRequest set exitdate = '2020-08-03 05:44:00',
updatedby='CDM-22217' where  intakeserviceid='0f37866c-0376-4381-8d1f-1e86f6c5e815';