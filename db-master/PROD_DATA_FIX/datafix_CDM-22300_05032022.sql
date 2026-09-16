-- CDM-22300 - Receiving Error Message
/*
-- Issue Description: 
	For the case 3072323 there are no pending placement to approve. 
	But still displaying review record under supervisor case pending approval dashboard.

-- Case ID: 3072323
-- Deleted Placement ID: d48d69a7-cb7b-4e19-9b7b-2b997ba5e8ea

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Data issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select routingid, eventcode, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = 'd48d69a7-cb7b-4e19-9b7b-2b997ba5e8ea'
	and eventcode = 'PLTR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-22300',
	updatedon = now()
where objectid = 'd48d69a7-cb7b-4e19-9b7b-2b997ba5e8ea'
	and eventcode = 'PLTR'
	and activeflag = 1 ;
