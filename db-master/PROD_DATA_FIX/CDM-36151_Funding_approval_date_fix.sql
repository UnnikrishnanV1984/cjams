-- CDM-36151 - Payment
/*
-- Issue Description: 
   Dashboard:2803216 was approved and is showing that is is not approved Screen URL:
   
-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Data migration issue
-- Fix Provided: Datafix has been promoted to fix the routing data.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select activeflag, routingstatustypeid, remarks,  * from routing 
where objectid = '2803216' and routingid='d6d6075a-9d74-4f91-83e7-a07cfe9c5459';

update routing
set activeflag = 1,
	updatedby = 'CDM-36151',
	updatedon = now()
where routingid = 'd6d6075a-9d74-4f91-83e7-a07cfe9c5459' and objectid='2803216';