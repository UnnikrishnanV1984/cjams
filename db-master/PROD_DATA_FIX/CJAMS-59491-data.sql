-- CJAMS-59491  Overdue Reason Box Change
/*
--	Issue Description: 
	User requested to update the Overdue Reason drop down 
-- Category/ Module: Contact Notes 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to update the Overdue Reason drop down 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VISR',
    cpsresponsetimerreason2 = null,
    updatedby ='CJAMS-59491',
    updatedon =now()
where intakeserviceid = '6da3c853-d378-40bb-8354-d918f5774bf5'
and cpsresponsetimeractionsid = '3a80264f-63bc-4b5d-8a20-fc7324a41fb1'
and activeflag = 1;