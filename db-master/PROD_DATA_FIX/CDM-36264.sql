/*
 Issue Description: CDM-36264
 Category/ Module : Work Load Management
 Root cause: users who left aganecy are still active in database.
 Fix: Soft delete users from database.
 Pull request# for code fix: N/A
 Reason why no related code fix: 
 Need to do data fix
 */
  -- Notes: Checked with Ravali and these are inactive users

UPDATE teammember
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36264'
	WHERE teammemberid IN 
		(select tm.teammemberid
			from userprofile  up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid in (
						'21ffc97a-5341-4824-874f-685fb8e04d95',   					-- Carl Whitehead
						'0c65ba76-5587-4b57-82c0-f85baa7ab918',						-- Sara Volk
						'fde29563-3bdd-45e1-9aac-1af55f69d1f4',						-- Courtney Tipton
						'e12e983a-4c24-4e47-9f26-d235639c0305',						-- Lynette Ellsworth
						'a3f20e36-6ad7-4de9-8288-8ab8155c136b',						-- Barbara Thomas  
						'd3ab36a2-d7a8-43f4-ad52-74c0647ddc3d',						-- Sharon Bailey
						'e1dfbbfe-e188-4532-a93f-a51ae76702e0',						-- Marlene Comer
						'b65af552-0e15-483e-9f1b-d6ffdd2ebced'));    				-- Rhonda Frankenberry
						
					
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36264'
	WHERE teammemberassignmentid IN 
		(select tma.teammemberassignmentid
			from cjams.userprofile  up 
				join cjams.teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
			where up.securityusersid in (
						'21ffc97a-5341-4824-874f-685fb8e04d95',   					-- Carl Whitehead
						'0c65ba76-5587-4b57-82c0-f85baa7ab918',						-- Sara Volk
						'fde29563-3bdd-45e1-9aac-1af55f69d1f4',						-- Courtney Tipton
						'e12e983a-4c24-4e47-9f26-d235639c0305',						-- Lynette Ellsworth
						'a3f20e36-6ad7-4de9-8288-8ab8155c136b',						-- Barbara Thomas  
						'd3ab36a2-d7a8-43f4-ad52-74c0647ddc3d',						-- Sharon Bailey
						'e1dfbbfe-e188-4532-a93f-a51ae76702e0',						-- Marlene Comer
						'b65af552-0e15-483e-9f1b-d6ffdd2ebced'));    				-- Rhonda Frankenberry	


-- Below users are still active in DB
UPDATE userprofile 
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36264'
	WHERE securityusersid in (
		'21ffc97a-5341-4824-874f-685fb8e04d95',
		'fde29563-3bdd-45e1-9aac-1af55f69d1f4',
		'0c65ba76-5587-4b57-82c0-f85baa7ab918',
		'e12e983a-4c24-4e47-9f26-d235639c0305')
		and activeflag = 1;
		
UPDATE muser 
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36264'
	WHERE securityusersid in (
		'21ffc97a-5341-4824-874f-685fb8e04d95',
		'fde29563-3bdd-45e1-9aac-1af55f69d1f4',
		'0c65ba76-5587-4b57-82c0-f85baa7ab918',
		'e12e983a-4c24-4e47-9f26-d235639c0305')
		and activeflag = 1;
		
UPDATE securityusers
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36264'	
	where securityusersid in (
		'21ffc97a-5341-4824-874f-685fb8e04d95',   					
		'0c65ba76-5587-4b57-82c0-f85baa7ab918',						
		'fde29563-3bdd-45e1-9aac-1af55f69d1f4',						
		'e12e983a-4c24-4e47-9f26-d235639c0305',						
		'a3f20e36-6ad7-4de9-8288-8ab8155c136b',						
		'd3ab36a2-d7a8-43f4-ad52-74c0647ddc3d',						
		'e1dfbbfe-e188-4532-a93f-a51ae76702e0',						
		'b65af552-0e15-483e-9f1b-d6ffdd2ebced')
		and activeflag = 1;

UPDATE rolemapping 
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36264'
	where principalid in ('4125', '2934', '11905', '4011', '14725', '4114', '19232', '29051')
		and activeflag = 1;

						
