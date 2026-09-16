INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('a2a85af2-a43a-42d0-a494-3fed698d76a5','PCAUTH', 'CWSP', 1, 'admin', now(), 'CDM-22644', now(), now(), NULL, NULL, 'CWPS', NULL, NULL, 'USER', '031b845a-66e1-4e71-9585-eff2e17681d6') on conflict do nothing;
