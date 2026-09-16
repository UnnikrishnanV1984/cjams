--1)Race & Ethnicity  should not have "Abandoned" and "Declined" in drop down values
update referencevalues set activeflag = 0 where referencetypeid = 300 and value_text = 'Declined';
update referencevalues set activeflag = 0 where referencetypeid = 300 and value_text = 'Abandoned';
update referencevalues set activeflag = 0 where referencetypeid = 171 and value_text = 'Declined';
update referencevalues set activeflag = 0 where referencetypeid = 171 and value_text = 'Abandoned';
-- 2)Prefix, Dr is missing
DELETE FROM referencevalues WHERE  ref_key = 'Dr.' and referencetypeid= 309;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('Dr.', 309, 'Dr.', 'Dr.', NULL, 1, 1, NULL, '2019-04-16 17:04:20.079', NULL, '2019-04-16 17:04:20.079', NULL, NULL, 'Dr.');
