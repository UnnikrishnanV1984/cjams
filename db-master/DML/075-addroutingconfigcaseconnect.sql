INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
values
(gen_random_uuid(), 'SCCR', 'CWSP', 1, 'admin', now(), 'admin', now(), now(), null, null, 'CWCW', null, null, null);

INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
values
(gen_random_uuid(), 'SCCR', 'CWSP', 1, 'admin', now(), 'admin', now(), now(), null, null, 'CWSP', null, null, null);
