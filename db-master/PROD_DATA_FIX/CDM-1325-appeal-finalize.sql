update cjams.intakeservicerequestdispositioncode set intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
                                               servicerequesttypeconfigiddispostionid = 'd90db0d3-f665-49db-b3ad-0edb468bc02d',
                                               updatedby = 'CDM-1325',
                                               updatedon = now()
where old_id = 'CW2927564';

update cjams.intakeservicerequest set intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',updatedby = 'CDM-1325',updatedon = now()
where servicerequestnumber = 'CW2927564';

INSERT INTO cjams.routing (eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid,
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, remarks,
routeddescription, servicerequestnumber, objecttypekey, old_id,etl_userid,etl_load_date)
SELECT  --count(1)
'APPL', fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid,
15, 1, r.insertedby, r.insertedon, r.updatedby, r.updatedon, 'FOWARDED TO APPEAL COORDINATOR',
null,r.old_id, 'servicerequest', r.old_id,'Data Migration',now()::date
FROM cjams.routing r WHERE eventcode = 'INDR' and routingid = '138e1aeb-4e16-49fd-be16-a99477891cf0';

update cjams.routing set activeflag = 0 where routingid = '138e1aeb-4e16-49fd-be16-a99477891cf0';

