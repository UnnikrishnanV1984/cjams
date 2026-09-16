-- CDM-33943 - Old Placement Approval Stuck
/*
-- Issue Description: 
   An old placement for client #1682049 that was prevously rejected and resubmitted, 
   and supervisor is unable to get approval to close out the placement.
   
-- Case ID: 3120466
-- Client ID: 1682049 (CEDRIC D	THOMAS) - de87be84-b6f3-4d49-97f7-3edf71970cc5
-- Placement ID: 339721 - 2020-03-08 To Current - 09746637-dcb1-4eff-a27f-22c526e35aa2
-- Private Organization: 5001391 (Jumoke, Inc.)
-- Provider ID: 5001427	(Jumoke, Inc. Independent Living Program) - CPA Office	
-- Program ID: 1713	(Jumoke, Independent Living Program)

-- Category/ Module: Child Placement (Case Management) 
-- Root cause: Placement exit was rejected but never User Error
-- Fix Provided: Datafix has been promoted to update the placement exit date and forward the supervisory approval request to LePaul Morceau.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update exit date and fix routing record  (CDM-33943)
-- New Exit Date : 10/24/2020 and Exit Time: 08:00 AM
-- Supervisor LePaul Morceau (lepaul.morceau@maryland.gov)

-- Placement Revision
select alternateid, entrydate, entrytime, exitdate, exittime, 
	exitreasontypkey, exittypekey, activeflag, updatedon, updatedby  
from placementrevision  
where placementrevisionid = '1b90dd9e-b5e9-423f-98e1-107807bbca25'
	and placementid = '09746637-dcb1-4eff-a27f-22c526e35aa2'
	and activeflag = 1 ;

update placementrevision  
set exitdate = '2020-10-24 00:00:00.000',
	exittime = '08:00',
	updatedon = now(), 
	updatedby = 'CDM-33943'
where placementrevisionid = '1b90dd9e-b5e9-423f-98e1-107807bbca25'
	and placementid = '09746637-dcb1-4eff-a27f-22c526e35aa2'
	and activeflag = 1 ;

-- Routing
select routingstatustypeid, routeddescription, remarks, activeflag, updatedby, updatedon  
	from routing 
where routingid = 'c87fc934-49d0-4b29-8b6a-fc8e51117d36'
	and objectid = '09746637-dcb1-4eff-a27f-22c526e35aa2'
	and activeflag = 0 ;
	
update routing	
set activeflag = 1,
	updatedon = now(), -- 2021-12-01 22:57:44.728
	updatedby = 'CDM-33943'	-- CDM-18194
where routingid = 'c87fc934-49d0-4b29-8b6a-fc8e51117d36'
	and objectid = '09746637-dcb1-4eff-a27f-22c526e35aa2'
	and activeflag = 0 ;
	
