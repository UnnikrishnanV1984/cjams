

delete from referencevalues where referencetypeid=750;

delete from referencetype where referencetypeid=750 and tablename='homeapprovaltypes';

delete from referencevalues where referencetypeid=46 and ref_key='PRRHSW' and teamtypekey='LDSS';


INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(750, 'Home Approval Types', 'homeapprovaltypes', 1, 'admin', now(), 'admin', now(), NULL);



INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('RH', 750, 'Restricted Home', 'Restricted Home', NULL, 1, NULL, NULL, now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TR', 750, 'Treatment Resource Home', 'Treatment Resource Home', NULL, 1, NULL, NULL, now(), NULL, now(), NULL, NULL, NULL);


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PRRHSW', 46, 'Restricted Kinship Request', 'Restricted Kinship Request', 'LDSS', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

delete from routingconfig where eventcode='PRRHSW' and routingconfigid in ('0c217898-6c6d-45fd-b5e4-86a21bb9963e','f9701e87-f7ba-4719-9c6f-6f1afd2adad4',
'14b2a657-7346-428c-b10e-3ec7a3c57a4e');


INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('0c217898-6c6d-45fd-b5e4-86a21bb9963e', 'PRRHSW', 'LDSSSP', 1, 'admin', now(), NULL, now(), now(), NULL, NULL, 'LDSSHSW', NULL, NULL, NULL);
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('f9701e87-f7ba-4719-9c6f-6f1afd2adad4', 'PRRHSW', 'LDSSSP', 1, 'admin', now(), NULL, now(), now(), NULL, NULL, 'LDSSRW', NULL, NULL, NULL);
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('14b2a657-7346-428c-b10e-3ec7a3c57a4e', 'PRRHSW', 'LDSSSP', 1, 'admin', now(), NULL, now(), now(), NULL, NULL, 'LDSSSP', NULL, NULL, NULL);
