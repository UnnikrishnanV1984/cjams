DELETE FROM cjams.routingconfig
where eventcode in ('FNSWO','MANREC') and targetrolekey = 'FNSFS' and sourcerolekey in ('CWCW', 'CWSP');
 
INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('FNSWO', 'FNSFS', 1, 'CDM-28859', now(), 'CDM-28859', now(), now(), NULL, NULL, 'CWCW', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('FNSWO', 'FNSFS', 1, 'CDM-28859', now(), 'CDM-28859', now(), now(), NULL, NULL, 'CWSP', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('MANREC', 'FNSFS', 1, 'CDM-28859', now(), 'CDM-28859', now(), now(), NULL, NULL, 'CWCW', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('MANREC', 'FNSFS', 1, 'CDM-28859', now(), 'CDM-28859', now(), now(), NULL, NULL, 'CWSP', NULL, NULL, NULL, NULL);
