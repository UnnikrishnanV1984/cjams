-- CDM-34095 - FC Milestone Showing Incorrect Placement/LA
/*
-- Issue Description: 
   The FC Milestone is displaying closed LAs instead of active Placement/LA. 
   See PID 1389316 for example.
   
   Inactive (activeflag = 0) placements with active living arrangement records.

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: All these placements/Living Arrangements are soft deleted with the user requests/CDM tickets, in which the living arrangement record(s) update was missed.
-- Fix Provided: Datafix has been promoted to soft-delete the living arrangement record(s).
-- Note: Code fix is not required as CJAMS is updating the active flag correctly in the placement and livingarrangement tables.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To soft-delete the living arrangement records (CDM-34095).

-- Before
select la.livingid, 
	pl.placementtypekey,
	la.livingarrangementtypekey, 
	la.activeflag as la_activeflag, 
	la.updatedby as pl_updatedby, 
	la.updatedon as pl_updatedon, 
	pl.activeflag as pl_activeflag, 
	pl.updatedby as pl_updatedby, 
	pl.updatedon as pl_updatedon 
from placement pl
	join livingarrangement la on la.placementid  = pl.placementid 
where pl.activeflag = 0
	and la.activeflag = 1
order by pl.updatedon desc ;
 
update livingarrangement la1
set activeflag = 0,
	updatedby = 'CDM-34095',
	updatedon = now()
where la1.activeflag = 1 
	and la1.livingid 
		in (  select la.livingid
				from placement pl
					join livingarrangement la on la.placementid  = pl.placementid 
			  where pl.activeflag = 0
				and la.activeflag = 1
            ); 

-- After
select la.livingid, 
	pl.placementtypekey,
	la.livingarrangementtypekey, 
	la.activeflag as la_activeflag, 
	la.updatedby as pl_updatedby, 
	la.updatedon as pl_updatedon, 
	pl.activeflag as pl_activeflag, 
	pl.updatedby as pl_updatedby, 
	pl.updatedon as pl_updatedon 
from placement pl
	join livingarrangement la on la.placementid  = pl.placementid 
where pl.activeflag = 0
	and la.activeflag = 1
order by pl.updatedon desc ;
