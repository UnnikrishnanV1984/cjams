Delete from cjams.routingconfig where targetrolekey in ('IVEEA','IVEQA','IVEADMIN') or sourcerolekey in ('IVEEA','IVEQA','IVEADMIN');
INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('PLTR', 'IVEEA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEQA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('PLTR', 'IVESP', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEQA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('PLTR', 'IVEEA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEADMIN', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('PLTR', 'IVESP', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEADMIN', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('PLTR', 'IVEADMIN', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEEA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('PLTR', 'IVEQA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEEA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('PLTR', 'IVEADMIN', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVESP', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('PLTR', 'IVEQA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVESP', NULL, NULL, NULL, NULL);


INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('GAAR', 'IVEEA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEQA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('GAAR', 'IVESP', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEQA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('GAAR', 'IVEEA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEADMIN', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('GAAR', 'IVESP', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEADMIN', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('GAAR', 'IVEADMIN', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEEA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('GAAR', 'IVEQA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEEA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('GAAR', 'IVEADMIN', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVESP', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('GAAR', 'IVEQA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVESP', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ABLR', 'IVEEA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEQA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ABLR', 'IVESP', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEQA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ABLR', 'IVEEA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEADMIN', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ABLR', 'IVESP', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEADMIN', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ABLR', 'IVEADMIN', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEEA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ABLR', 'IVEQA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEEA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ABLR', 'IVEADMIN', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVESP', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ABLR', 'IVEQA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVESP', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ADAP', 'IVEEA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEQA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ADAP', 'IVESP', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEQA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ADAP', 'IVEEA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEADMIN', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ADAP', 'IVESP', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEADMIN', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ADAP', 'IVEADMIN', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEEA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ADAP', 'IVEQA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVEEA', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ADAP', 'IVEADMIN', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVESP', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ADAP', 'IVEQA', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'IVESP', NULL, NULL, NULL, NULL);
