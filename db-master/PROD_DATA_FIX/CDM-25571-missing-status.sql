
/*
   Issue Description: CDM-25571
   2020014701295:I sent this YTP for approval but it never went to my supervisor and she cannot see it on her end.
   Category/ Module  : Missing Status
   Reason why no related code fix: need to do datafix case worker Sent YTP for approval but supervisor cannot see it on her end
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


INSERT INTO cjams.routing (
  routingid, eventcode, fromsecurityusersid, 
  tosecurityusersid, teamid, fromroleid, 
  toroleid, objectid, routingstatustypeid, 
  activeflag, insertedby, insertedon, 
  updatedby, updatedon, isreviewrequest, 
  remarks, old_id, routeddescription, 
  servicerequestnumber, objecttypekey, 
  old_from_id, old_to_id, principaltype, 
  actiondatetime, etl_userid, etl_load_date, 
  entityid, reassignnotes
) 
VALUES 
  (
    gen_random_uuid(),  
    'YTP', '0d779838-1a77-4a43-a950-c5b598377623', 
    '78b57aee-1753-49f0-bef9-7224205e22ce', 
    '1c28acd6-9ef9-4b46-9ab3-a3dfc386bacd', 
    'CWCW', 'CWSP', '38b7f365-7b21-4631-bed1-6e4a7bb0d7f7', 
    15, 1, 'CDM-25571', 
    current_timestamp, 'CDM-25571', 
    current_timestamp, false, 
    NULL, NULL, 
    NULL, '2020014701295', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, NULL, 
    NULL
  );