DELETE FROM cjams.routingconfig where targetrolekey = 'CWAPPEALCO' and sourcerolekey='CWSP' and eventcode = 'INVR' and activeflag=1;
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES(gen_random_uuid(), 'INVR', 'CWAPPEALCO', 1, 'admin', now(), 'admin', now(), now(), null, '', 'CWSP', '', '', '', null); 