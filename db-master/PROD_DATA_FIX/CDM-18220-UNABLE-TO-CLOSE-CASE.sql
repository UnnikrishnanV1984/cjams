/*
   Issue Description: CDM-18220
      Category/ Module  : case
   Root cause: USER ASKED TO update 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update adoptioncase set statustypekey = 'Closed', updatedby =  'CDM-18220', updatedon = now() where adoptioncaseid = 'dd5417eb-7412-40fd-afa0-28dc55b68a6f';

	INSERT INTO cjams.adoptioncasedisposition
	(adoptioncasedispositionid, adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
	VALUES('a83abb25-9fdb-4bd3-b663-151c3ae58710', 'dd5417eb-7412-40fd-afa0-28dc55b68a6f', '2021-09-04 10:00:00', 'Closed', 'Closed', 'Adopted youth reentered out of home care and is now over the age of 18. Adoptive parents are no longer providing financial support through child support.', '2021-09-04 10:00:00', 1, 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', now() , 'CDM-18220', now() , null, null, null, null)ON CONFLICT DO NOTHING;

	INSERT INTO cjams.routing
	(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
	VALUES('ACDR', '73999176-0c94-4d08-9ef2-0efe966ce506', '73999176-0c94-4d08-9ef2-0efe966ce506', NULL, NULL, NULL, 'a83abb25-9fdb-4bd3-b663-151c3ae58710', 16, 1, 'CDM-18220', now(), 'CDM-18220', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;