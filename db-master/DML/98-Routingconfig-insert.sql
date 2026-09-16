INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('EXPR', 'CWSP', 1, NULL, '2018-11-02 16:10:14.517', NULL, '2018-11-02 16:10:14.517', '2018-11-02 16:10:14.517',
NULL, NULL, 'CWCW', NULL, NULL, NULL);

 delete from cjams.referencevalues where value_text = 'Expungement Approval';