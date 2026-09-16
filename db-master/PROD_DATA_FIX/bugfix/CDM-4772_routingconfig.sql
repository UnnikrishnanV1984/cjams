DELETE FROM cjams.routingconfig
where eventcode = 'RVRSL' and targetrolekey = 'FNSCOFS' and sourcerolekey in ('FNSCOFS', 'FNSCOFW');
 
INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('RVRSL', 'FNSCOFS', 1, 'CDM-4772', now(), 'CDM-4772', now(), now(), NULL, NULL, 'FNSCOFS', NULL, NULL, 'ROLE', NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('RVRSL', 'FNSCOFS', 1, 'CDM-4772', now(), 'CDM-4772', now(), now(), NULL, NULL, 'FNSCOFW', NULL, NULL, 'ROLE', NULL);
