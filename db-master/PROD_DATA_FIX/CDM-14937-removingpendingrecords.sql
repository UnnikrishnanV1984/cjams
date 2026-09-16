/*
-- Issue Description: 
   
-- Category/ Module: Approval Dashboard
-- Root cause: Need to Remove the pending case from dashboard
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/


update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-14937' where routingid = '7c026606-0a03-48d1-b118-2d40bf0f8413';
