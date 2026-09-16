
DELETE FROM cjams.routingconfig where targetrolekey = 'FNSFS' and sourcerolekey='FNSFS' and eventcode = 'ADSR' and activeflag=1;
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES(gen_random_uuid(), 'ADSR', 'FNSFS', 1, 'CDM-12476', now(), 'CDM-12476', now(), now(), null, '', 'FNSFS', '', '', '', null); 
