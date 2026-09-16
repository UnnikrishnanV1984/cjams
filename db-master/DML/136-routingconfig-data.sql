
 INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey ,resourceid)
VALUES('7a011650-f118-4a3a-b165-f525e3f6aa96', 'PRASS', 'LDSSSP', 1, 'admin', now(), NULL, now(), now(), NULL, NULL, 'CWSP', NULL, NULL,'871e4b80-08cf-424d-b43c-037aff311aa9' );
 
 
 INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey  )
VALUES('5907f4d6-5749-4851-88bf-0e4096336c77', 'PRRWHW', 'CWSP', 1, 'admin', now(), NULL, now(), now(), NULL, NULL, 'LDSSSP', NULL, NULL  );
 
 update routingconfig set resourceid='3d325c19-099b-4259-a895-65c0ac8beb09' where eventcode='PRRWHW';
 update routingconfig set resourceid='871e4b80-08cf-424d-b43c-037aff311aa9' where targetrolekey ='LDSSSP' ;