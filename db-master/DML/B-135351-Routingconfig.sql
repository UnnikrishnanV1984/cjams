delete from cjams.routingconfig where targetrolekey in ('FTDMFW','QUINW','FTDMQIS');


INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('CWIF', 'FTDMFW', 1, 'CIDM-5675', now(), 'CIDM-5675', now(), now(), NULL, NULL, 'FTDMFS', NULL, NULL, NULL, NULL);


INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('CWIF', 'QUINW', 1, 'CIDM-5675', now(), 'CIDM-5675', now(), now(), NULL, NULL, 'FTDMFS', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('CWIF', 'FTDMQIS', 1, 'CIDM-5675', now(), 'CIDM-5675', now(), now(), NULL, NULL, 'FTDMFS', NULL, NULL, NULL, NULL);