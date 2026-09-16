/*
-- CDM-35636' 
-- Issue Description: Needed to update the status to Pending for Funding approval
-- Root cause: The specific routing number or id is not active and is set to 0. 
-- Resolution: Data fix to  set active flag to 1 to update the status to pending for funding approval.so the request will come on the dashboard of Prince George's county finance users.
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update routing set activeflag = 1,updatedby = 'CDM-35636', updatedon = now() 
where routingid = 'aa9820ed-6bc1-4e47-9ef3-8bc72241a0f3';



