delete from routingconfig where routingconfigid in ('09a6cae1-aa74-4edc-a3b5-84b2816ac168');
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('09a6cae1-aa74-4edc-a3b5-84b2816ac168', 'RVRSL', 'FNSFS', 1, 'admin', '2019-08-23 12:22:25.588', 'admin', '2019-08-23 12:22:25.588', '2019-08-23 12:22:25.588', NULL, NULL, 'FNSFW', NULL, NULL, 'ROLE', NULL);

delete from referencevalues where ref_key='RVRSL';
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('RVRSL', 46, 'Receipt Reversal', 'Receipt Reversal', 'FNS', 1, 1, 'admin', now(), NULL, now(), NULL, NULL, NULL);