-- CDM-33928 - Delete stuck Approvals
/*
-- Issue Description: 
   User request to delete pending approvals from Inactive supervisor Sharon Pilachowski.
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Routing table is having no active record)
-- Fix Provided: Datafix has been promoted to remove the requested pending approvals.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove the pending routing records (CDM-33799)
select objectid, eventcode, routingstatustypeid, remarks, tosecurityusersid , activeflag , updatedby, updatedon
	from routing 
where routingid 
	in (	'1452571e-c80d-457f-905b-bf96d2585e15',
			'32a5e31f-4432-4b6a-ab6b-4cc0043cdcf4',
			'7f68d95a-e7f1-412c-9770-fc1cf5f14cac',
			'81e43ba5-6c4b-4952-a99a-37fe23c692f9',
			'b1356fa0-2dcb-40ac-8a03-7d269072efa0',
			'c9fa95ea-9600-438c-916d-aee821f5ff87',
			'db8ed846-33e2-4f07-9dc7-d411272eaf25',
			'fec0c764-84c5-425a-9b62-47695b2c956f' 
		)
	and routingstatustypeid = 15
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedby = 'CDM-33928',
	updatedon = now()
where routingid 
	in (	'1452571e-c80d-457f-905b-bf96d2585e15',
			'32a5e31f-4432-4b6a-ab6b-4cc0043cdcf4',
			'7f68d95a-e7f1-412c-9770-fc1cf5f14cac',
			'81e43ba5-6c4b-4952-a99a-37fe23c692f9',
			'b1356fa0-2dcb-40ac-8a03-7d269072efa0',
			'c9fa95ea-9600-438c-916d-aee821f5ff87',
			'db8ed846-33e2-4f07-9dc7-d411272eaf25',
			'fec0c764-84c5-425a-9b62-47695b2c956f' 
		)
	and routingstatustypeid = 15
	and activeflag = 1 ;

