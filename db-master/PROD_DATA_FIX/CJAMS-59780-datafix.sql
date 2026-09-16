-- CJAMS-59780  Delete intake
/*
--	Issue Description: 
	 delete intake I251013286601 as it was created in error on 05/14/2025
-- Category/ Module: Persons: Others
-- Root cause: User request to delete intake I251013286601 as it was created in error on 05/14/2025
-- Fix Provided: Datafix has been promoted to delete intake I251013286601 as it was created in error on 05/14/2025
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59780'
where intakenumber = 'I251013286601'
	and activeflag = 1 ;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59780'
where intakenumber = 'I251013286601'
	and activeflag = 1 ;


update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59780'
where intakenumber = 'I251013286601'
	and activeflag = 1 ;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59780'
where intakenumber = 'I251013286601'
	and activeflag = 1 ;