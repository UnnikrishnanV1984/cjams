
delete from cjams.routingconfig where  eventcode='PCAUTHR' and targetrolekey='FNSFW' and sourcerolekey='FNSFS';
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES(gen_random_uuid(), 'PCAUTHR', 'FNSFW', 1, 'admin', now(), 'admin', now(), '2020-02-10 00:00:00.000', NULL, NULL, 'FNSFS', NULL, NULL, 'ROLE', 'd5ca77df-42c1-4329-a09f-6b7d99b45143');
