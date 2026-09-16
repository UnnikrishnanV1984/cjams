/*
-- CJAMS-68482
-- Issue Description: Requested to remove intake from My Intakes Pending Dashboard
-- Customer Email ID: karol.alston@maryland.gov
-- Root Cause: Requested to remove intake from My Intakes Pending Dashboard
-- Fix Provided: Data fix has been provide by changing the status to Complete
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

 select * from CW_transactions_dataclenup('INTKE','I261014104670','CJAMS-68482');