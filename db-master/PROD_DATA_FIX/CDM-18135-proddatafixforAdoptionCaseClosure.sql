
/*
   Issue Description: CDM-18135
   Category/ Module  : Case Closure for Adoption Case
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- Open
update adoptioncase set statustypekey = 'Closed', updatedby =  'CDM-18135', updatedon = now() where adoptioncaseid = '1a1cabd2-2cca-43b4-a0de-ff2301322dbc';


INSERT INTO cjams.adoptioncasedisposition
(adoptioncasedispositionid, adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('36f33cac-8a78-4b6a-832a-a30a93dd791e', '1a1cabd2-2cca-43b4-a0de-ff2301322dbc', '2021-10-31 00:00:00', 'Closed', 'Closed', 'Child re-entered care through VPA after being adopted. Will need additional services and time in care. Adoptive Parent approved of adoption case closure.', '2021-10-31 00:00:00', 1, 'f2440224-ed75-43d4-969b-d0b027eab9ea', now() , 'CDM-18135', now() , null, null, null, null)ON CONFLICT DO NOTHING;

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ACDR', '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', NULL, NULL, NULL, NULL, '36f33cac-8a78-4b6a-832a-a30a93dd791e', 16, 1, 'CDM-18135', now(), 'CDM-18135', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
