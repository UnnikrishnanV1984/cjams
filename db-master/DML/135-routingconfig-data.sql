INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey )
VALUES('3c84e74e-ecb2-4cc9-9324-ed4ebc42cf2d', 'PRASS', 'LDSSSP', 1, 'admin', now(), NULL, now(), now(), NULL, NULL, 'CWCW', NULL, NULL );
 
 DELETE FROM  cjams.routingconfig WHERE routingconfigid= '59f834c5-8171-4d37-b67c-e444f0973162' ;
 INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,resourceid )
VALUES('59f834c5-8171-4d37-b67c-e444f0973162', 'PRRWHW', 'CWCW', 1, 'admin', now(), NULL, now(), now(), NULL, NULL, 'LDSSSP', NULL, NULL,'3d325c19-099b-4259-a895-65c0ac8beb09' );
 
