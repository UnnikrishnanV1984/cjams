-- CJAMS-59661 Intake

/*
--	Issue Description: 
	User requested to remove the intake that was created by error
-- Category/ Module: Services: Other
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to remove the intake that was created by error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastatus
    set    activeflag = 0,
        updatedon = now(),
        updatedby = 'CJAMS-59661'
    where intakenumber in ('I251013283080')
        and activeflag = 1;
    
update intakedastaging
    set activeflag = 0,
        updatedon = now(),
        updatedby = 'CJAMS-59661'
    where intakenumber in ('I251013283080')
        and activeflag = 1;