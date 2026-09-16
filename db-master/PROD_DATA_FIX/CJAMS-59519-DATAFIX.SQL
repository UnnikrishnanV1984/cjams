--CJAMS-59519  remove/delete

/*
--	Issue Description: 
	User request to delete Intake - I251013281691

-- Category/ Module: Documents
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to delete Intake - I251013281691
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59519'
where intakenumber = 'I251013281691' and activeflag=1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59519'
where intakenumber = 'I251013281691'and activeflag=1;
