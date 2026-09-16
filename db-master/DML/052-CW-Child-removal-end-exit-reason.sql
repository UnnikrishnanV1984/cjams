
delete from referencetype where referencetypeid = 343;
delete from referencevalues where referencetypeid = 343;



INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(343, 'Child Removal End Reason', 'crendreason', 1, NULL, now(), NULL,now(), NULL);
--Child reunified with parents/Family
--Child's guardianship program approved
--Child adoption finalized
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('CHREUNIFWF',343,'Child reunified with parents/Family','Child reunified with parents/Family','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('CGPGAP',343,'Child''s guardianship program approved','Child''s guardianship program approved','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('CADOFIN',343,'Child adoption finalized','Child adoption finalized','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);