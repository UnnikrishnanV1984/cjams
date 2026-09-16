delete from referencevalues where referencetypeid=55 and ref_key='BTN';
delete from referencevalues where referencetypeid=55 and ref_key='BTNR';
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('BTN', 55, 'Baby test Negative', 'Baby test Negative', NULL, 1, 22, 'admin', '2019-01-29 12:34:03.778', 'admin', '2019-01-29 12:34:03.778', NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('BTNR', 55, 'Baby test results not yet Retrieved', 'Baby test results not yet Retrieved', NULL, 1, 23, 'admin', '2019-01-29 12:34:03.778', 'admin', '2019-01-29 12:34:03.778', NULL, NULL, NULL);