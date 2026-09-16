-- CDM-27160 - Service case being flagged as SEN's
/*
-- Issue Description: 
   POSC user notification for Incorrect Case Type

-- Case ID: 211030010113 - e3f899f1-cbd3-45d6-a2ba-b641e5f3dab9
-- Client ID: 200794138 (Nova L Stafford) - 2829177b-71ae-459d-b6bf-6400466b5a1c

  
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: CJAMS user notification batch logic was incorrect 
-- Fix Provided: CJAMS user notification batch code was modified to look SEN info in the Person table as a part of CDM-27547 
--    and the datafix has been promoted to remove the incorrect POSC user notifications of Case # 211030010113
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select usernotificationmapid, activeflag, updatedby, updatedon 
	from usernotificationmap
where activeflag = 1
	and usernotificationid in (
								select usernotificationid
									from usernotification
								where objectcasenumber = '211030010113'
									and old_id like 'POSC%'
									and activeflag = 1 
								);
								
update usernotificationmap
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-27160'
where activeflag = 1
	and usernotificationid in (
								select usernotificationid
									from usernotification
								where objectcasenumber = '211030010113'
									and old_id like 'POSC%'
									and activeflag = 1 
								);

select usernotificationid, old_id, activeflag, updatedby, updatedon, subject
from usernotification
where objectcasenumber = '211030010113'
	and old_id like 'POSC%'
	and activeflag = 1 ;

update usernotification
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-27160'
where objectcasenumber = '211030010113'
	and old_id like 'POSC%'
	and activeflag = 1 ;
