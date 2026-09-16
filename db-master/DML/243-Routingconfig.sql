INSERT INTO cjams.routingconfig(
	routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, 
	targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
	VALUES (cjams.gen_random_uuid(), 'ADAP', 'IVESP', 1, 'admin', current_timestamp, 'admin', current_timestamp, current_timestamp, null, null, 'IVESV', null, null, null, null);
	
	