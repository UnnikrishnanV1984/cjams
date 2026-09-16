/*
-- Issue Description: CJAMS-66360
-- Category/ Module: Funding Approval
-- Root cause: Needs the data fix to re route to wanda.nolt@maryland.gov for the approval
-- Fix Provided: Datafix has been promoted to update service logs.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update routing
set tosecurityusersid='d636ac2f-53ff-43e0-adbf-35c97e0427ec', updatedon= now(), updatedby='CJAMS-66360'
where objectid = '391035' and activeflag = 1 and routingstatustypeid = 42;
