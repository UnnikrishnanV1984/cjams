-- CDM-32895 - Provider Placement Vacancy issue data clean-up activity
/*
-- Issue Description: 
   Document table Data Cleanup
   
-- Update provider vacancy to sync with Approved beds and active approved placements/ Placement Entries in Review status (CDM-32895)

-- Category/ Module: Documents (Case Document Management) 
-- Root cause: The code is having a flaw in Placement flow while updating provider vacancy.
			Smitha/Chandra are working on the Code fix with CDM-32894
			   Manasa/Chandra are working on the Code fix.
-- Fix Provided: Generic datafix has been promoted to 
--				 sync up the provider vacancy with Approved beds and active approved placements/ Placement Entries in Review status 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

@Devops:

This fix is having new Stored Procedure and a datafix script 

So, the order of deployment is 
1) Deploy SP first sp_provider_vacancy_data_sync.sql
2) then run datafix_CDM-32895_07122023.sql
*/

select al_sqlcode, as_mess 
from cjams.sp_provider_vacancy_data_sync('CDM-32895'::character varying, 'N'::character varying) ;

