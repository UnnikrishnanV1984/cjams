-- CDM-34026 - Wrong program end reason
/*
-- Issue Description: 
   User request to change the In-Home Services/Family Preservation program assignment end reason.

-- Case ID: 231030145467
-- Client ID: 201388909	(Lauren	T Lecates) - 64173ec8-9c1d-4980-a1e8-572cc4bb511b
-- referencetypeid = 357
-- 3395	Other DSS Services Offered - Old value: 3389 Parental Rights Terminated

-- Category/ Module: GAP (Case Management) 
-- Root cause: User error.
-- Fix Provided: Datafix has been promoted to update the In-Home program assignment end reason as 'Other DSS Services Offered'.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update program assignment end reason  (CDM-34026)
select programkey, subprogramkey, startdate, enddate, endreasonkey, activeflag, updatedby, updatedon
	from personprogramarea
where personprogramid = '3840c2d0-8d49-4139-9798-df3b425e1eac'
	and activeflag = 1 ;
	
update personprogramarea
set endreasonkey = '3395', -- Other DSS Services Offered
	updatedon = now() 
	-- updatedby = '7a5f24fa-41ee-4e84-bc73-926663389c39' - letasha.harmon2@maryland.gov
where personprogramid = '3840c2d0-8d49-4139-9798-df3b425e1eac'
	and activeflag = 1 ;
