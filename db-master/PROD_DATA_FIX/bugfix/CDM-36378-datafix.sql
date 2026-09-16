/*
-- Issue Description: CDM-36378
-- Category/ Module  :  child welfare/ Payments
-- Root cause: Data issue (Routing table is having no active record)
-- Fix Provided: Datafix has been done to fix the routing data.
*/

-- Backup
select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = 'b390f064-2848-47c9-9154-59a9cfde400c'
	and objectid = '2836523'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' );

-- Updatation
update routing
set activeflag = 1,
	updatedby = 'CDM-36378',
	updatedon = now()
where routingid = 'b390f064-2848-47c9-9154-59a9cfde400c'
	and objectid = '2836523'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' );