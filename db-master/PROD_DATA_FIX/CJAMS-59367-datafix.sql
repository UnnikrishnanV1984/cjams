/*
--	Issue Description: CJAMS-59367  Update Overdue Reason Box

-- Category/ Module: Contact Notes 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to update the LEgislative report.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason3 = 'V34F',
    updatedby ='CJAMS-59367',
    updatedon =now()
where intakeserviceid = '871129ed-b0d8-422f-a360-0a8b2e240dd5'
and cpsresponsetimeractionsid = '9cad542e-40eb-4baf-ae97-edb53b9f18da'
and activeflag = 1;