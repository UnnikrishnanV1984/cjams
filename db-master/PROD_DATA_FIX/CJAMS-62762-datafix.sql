/*
-- Issue Description:  CJAMS-62762
   data fix to remove Intake referral # I251013379048
-- Category/ Module: Services: Other
-- Root cause: User requested to do data fix to remove Intake referral # I251013379048
-- Fix Provided: Data fix has been promoted to remove Intake referral # I251013379048
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-62762'
where intakenumber = 'I251013379048';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-62762'
where intakenumber = 'I251013379048'
	and activeflag=1;