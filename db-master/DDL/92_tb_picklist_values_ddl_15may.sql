UPDATE tb_picklist_values
SET update_ts=now(), update_user_id='cadmin', delete_sw='N'
WHERE picklist_type_id=320 AND picklist_value_cd='3257 ';

INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LA', 171, 'Latino', 'Latino', NULL, 1, 12, NULL, now(), NULL, now(), NULL, NULL, 'LA');

INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OT', 171, 'Others', 'Others', NULL, 1, 13, NULL, now(), NULL, now(), NULL, NULL, 'OT');
