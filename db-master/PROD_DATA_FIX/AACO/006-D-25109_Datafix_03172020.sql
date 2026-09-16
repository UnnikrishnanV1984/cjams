-- D-25109 - Datafix for pending migrated Purchase Authorization; Not coming on Fiscal supervisor’s  dashboard 
-- To update Eventcode = 'PCAUTHR' and Team id: '4cde989e-2c03-40af-b733-a9e9e17310fd' (AA County Finance Team)


-- Authorization ID: 742364	'9a82346f-661c-478f-8c65-3169676516ee'
-- Before
select objectid, routingstatustypeid, eventcode, teamid, updatedon  
	from routing
where routingid::character varying = '9a82346f-661c-478f-8c65-3169676516ee'
	and activeflag = 1 ;

-- Update
Update routing
	set eventcode = 'PCAUTHR',
		teamid = '4cde989e-2c03-40af-b733-a9e9e17310fd',
		updatedon = current_timestamp
where routingid::character varying = '9a82346f-661c-478f-8c65-3169676516ee'
	and activeflag = 1 ;	

	
-- After
select objectid, routingstatustypeid, eventcode, teamid, updatedon  
	from routing
where routingid::character varying = '9a82346f-661c-478f-8c65-3169676516ee'
	and activeflag = 1 ;

	
-- Authorization ID: 742375	'502c845d-b677-450e-b443-c98f7e20cfc9'
-- Before
select objectid, routingstatustypeid, eventcode, teamid, updatedon  
	from routing
where routingid::character varying = '502c845d-b677-450e-b443-c98f7e20cfc9'
	and activeflag = 1 ;

-- Update
Update routing
	set eventcode = 'PCAUTHR',
		teamid = '4cde989e-2c03-40af-b733-a9e9e17310fd',
		updatedon = current_timestamp
where routingid::character varying = '502c845d-b677-450e-b443-c98f7e20cfc9'
	and activeflag = 1 ;	
	
-- After
select objectid, routingstatustypeid, eventcode, teamid, updatedon  
	from routing
where routingid::character varying = '502c845d-b677-450e-b443-c98f7e20cfc9'
	and activeflag = 1 ;

