-- CIDM-7923 - To fix the Provider Vacancy errors for any discrepancy.
/*
-- Issue Description: 
   Document table Data Cleanup
   
-- Update provider vacancy to sync with Approved beds and active approved placements/ Placement Entries in Review status

-- Category/ Module: Documents (Case Document Management) 
-- Root cause: Data Cleanup (TBD)
-- Fix Provided: Generic datafix has been promoted to sync up the provider vacancy with Approved beds and active approved placements/ Placement Entries in Review status 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select al_sqlcode, as_mess 
from cjams.sp_provider_vacancy_data_sync('CIDM-7923'::character varying, 'N'::character varying) ;
