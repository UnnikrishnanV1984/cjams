-- CDM-27547 - Alert for POSC for Incorrect Case Type
/*
-- Issue Description: 
   POSC user notification for Incorrect Case Type

-- Case ID:202100505194 
  
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: CJAMS user notification batch logic was incorrect 
-- Fix Provided: CJAMS user notification batch code was modified to look SEN info in the Person table 
--    and the datafix has been promoted to remove the incorrect POSC user notifications of Case # 202100505194
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select usernotificationid, old_id, activeflag, updatedby, updatedon, subject
from usernotification
where objectcasenumber = '202100505194'
	and old_id like 'POSC%'
	and activeflag = 1 ;

update usernotification
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-27547'
where objectcasenumber = '202100505194'
	and old_id like 'POSC%'
	and activeflag = 1 ;
