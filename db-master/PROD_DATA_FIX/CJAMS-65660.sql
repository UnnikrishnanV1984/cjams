/*
-- Issue Description: 
   User Request to update the CPA Home Placement exit date from 02/06/2026 to 01/30/2026 for two children in this case. (Kayden Height & Khyon Height)
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: User Error, requested to update the CPA Home Placement exit date from 02/06/2026 to 01/30/2026 for two children in this case. (Kayden Height & Khyon Height)
-- Fix provided: Datafix has been promoted to update the placement exit dates 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update placementcpahomes set exitdt ='2026-01-30 00:00:00.000',
 updatets = now(), updateuserid = 'CJAMS-65660' where placementcpahomeid in ('f30017c8-ec3b-4982-b254-6e594239a2b2','4df230c3-503a-487d-bcf7-65910d73a461') and activeflag =1;