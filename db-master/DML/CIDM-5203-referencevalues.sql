
delete from cjams.referencevalues where ref_key in('ATIAM','ATIAN','NOAGR','STAAA','ATGAA','TIAAA','TIGAA') and referencetypeid=5465;

delete from cjams.referencetype where  referencetypeid=5465;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ATIAM', 5465, 'Adoption Title IV-E Agreement Medicaid Only', 'Adoption Title IV-E Agreement Medicaid Only', 'CW', 1, 1, 'CIDM-5203', '2022-07-28 12:06:52.951', 'CIDM-5203', '2022-07-28 12:06:52.951', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ATIAN', 5465, 'Adoption Title IV-E Agreement non-recurring expense only', 'Adoption Title IV-E Agreement non-recurring expense only', 'CW', 1, 2, 'CIDM-5203', '2022-07-28 12:06:52.951', 'CIDM-5203', '2022-07-28 12:06:52.951', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NOAGR', 5465, 'No Agreement', 'No Agreement', 'CW', 1, 3, 'CIDM-5203', '2022-07-28 12:06:52.951', 'CIDM-5203', '2022-07-28 12:06:52.951', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('STAAA', 5465, 'State/Tribal Adoption Assistance Agreement', 'State/Tribal Adoption Assistance Agreement', 'CW', 1, 4, 'CIDM-5203', '2022-07-28 12:06:52.951', 'CIDM-5203', '2022-07-28 12:06:52.951', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ATGAA', 5465, 'State/Tribal Guardianship Assistance Agreement', 'State/Tribal Guardianship Assistance Agreement', 'CW', 1, 5, 'CIDM-5203', '2022-07-28 12:06:52.951', 'CIDM-5203', '2022-07-28 12:06:52.951', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TIAAA', 5465, 'Title IV-E Adoption assistance agreement', 'Title IV-E Adoption assistance agreement', 'CW', 1, 6, 'CIDM-5203', '2022-07-28 12:06:52.951', 'CIDM-5203', '2022-07-28 12:06:52.951', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TIGAA', 5465, 'Title IV-E Guardianship Assistance Agreement', 'Title IV-E Guardianship Assistance Agreement', 'CW', 1, 7, 'CIDM-5203', '2022-07-28 12:06:52.951', 'CIDM-5203', '2022-07-28 12:06:52.951', NULL, NULL, NULL);

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(5465, 'Assistance Agreement Type', 'Adoption Agreement & GAP Agreement', 1, 'CIDM-5203', '2022-07-28 12:06:52.951', 'CIDM-5203', '2022-07-28 12:06:52.951', NULL);

