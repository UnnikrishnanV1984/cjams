delete from cjams.routingconfig where eventcode='ADYR';

INSERT INTO cjams.routingconfig
(eventcode, sourcerolekey, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ADYR', 'CWCW', 'CWSP', 1, NULL, '2018-11-02 16:10:14.517', NULL, '2018-11-02 16:10:14.517', '2018-11-02 16:10:14.517', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingconfig
(eventcode, sourcerolekey, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('ADYR', 'CWSP', 'CWSP', 1, NULL, '2018-11-02 16:10:14.517', NULL, '2018-11-02 16:10:14.517', '2018-11-02 16:10:14.517', NULL, NULL, NULL, NULL, NULL, NULL);


delete from cjams.referencevalues  where ref_key = 'ADYR';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ADYR', 46, 'Adoption Annual Review', 'Adoption Annual Review', NULL, 1, 15, 'Admin', '2019-01-14 02:06:10.221', NULL, '2019-01-14 02:06:10.221', NULL, NULL, NULL);
