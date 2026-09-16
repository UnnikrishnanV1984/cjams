INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, resourceid  )
VALUES('17cda755-4ad9-4aab-82bd-6e8bd14a70f8', 'PRRWHW', 'CWCW', 1, 'admin', now(), NULL, now(), now(), NULL, NULL, 'CWSP', NULL, NULL,'3d325c19-099b-4259-a895-65c0ac8beb09'  ) ON CONFLICT DO NOTHING;

INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, resourceid  )
VALUES('711ade9e-656c-4cfc-a424-b451d071a59d', 'PRWS', 'CWCW', 1, 'admin', now(), NULL, now(), now(), NULL, NULL, 'CWSP', NULL, NULL,'3d325c19-099b-4259-a895-65c0ac8beb09'  ) ON CONFLICT DO NOTHING;

 INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey  )
VALUES('27a58113-2896-406c-afa2-6536848bfb81', 'PRWS', 'LDSSSP', 1, 'admin', now(), NULL, now(), now(), NULL, NULL, 'CWSP', NULL, NULL   )ON CONFLICT DO NOTHING; 

