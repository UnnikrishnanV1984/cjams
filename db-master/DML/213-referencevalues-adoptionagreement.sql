DELETE FROM referencevalues WHERE referencetypeid=900;
DELETE FROM referencevalues WHERE referencetypeid=901;
DELETE FROM referencetype WHERE referencetypeid=900;
DELETE FROM referencetype WHERE referencetypeid=901;

INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(900, 'Adoption Agreement Placed From', 'adoptionagreementplacedfrom', 1, 'admin', '2019-08-26 12:06:32.649', 'admin', '2019-08-26 12:06:32.649', NULL);
INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(901, 'Adoption Agreement Placed By', 'adoptionagreementplacedby', 1, 'admin', '2019-08-26 12:06:32.649', 'admin', '2019-08-26 12:06:32.649', NULL);

INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('anldss', 900, 'Another LDSS', 'Another LDSS', 'CW', 1, 4, 'admin', '2019-08-26 12:06:32.649', 'admin', '2019-08-26 12:06:32.649', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('wtinst', 900, 'Within State', 'Within State', 'CW', 1, 3, 'admin', '2019-08-26 12:06:32.649', 'admin', '2019-08-26 12:06:32.649', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('anst', 900, 'Another State', 'Another State', 'CW', 1, 2, 'admin', '2019-08-26 12:06:32.649', 'admin', '2019-08-26 12:06:32.649', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ancn', 900, 'Another Country', 'Another Country', 'CW', 1, 1, 'admin', '2019-08-26 12:06:32.649', 'admin', '2019-08-26 12:06:32.649', NULL, NULL, NULL);

INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('pubagy', 901, 'Public Agency', 'Public Agency', 'CW', 1, 6, 'admin', '2019-08-26 12:06:32.649', 'admin', '2019-08-26 12:06:32.649', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('triagy', 901, 'Tribal Agency', 'Tribal Agency', 'CW', 1, 5, 'admin', '2019-08-26 12:06:32.649', 'admin', '2019-08-26 12:06:32.649', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('priagy', 901, 'Private Agency', 'Private Agency', 'CW', 1, 4, 'admin', '2019-08-26 12:06:32.649', 'admin', '2019-08-26 12:06:32.649', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('legargrd', 901, 'Legal Guardian', 'Legal Guardian', 'CW', 1, 3, 'admin', '2019-08-26 12:06:32.649', 'admin', '2019-08-26 12:06:32.649', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('indtsr', 901, 'Independent Source', 'Independent Source', 'CW', 1, 2, 'admin', '2019-08-26 12:06:32.649', 'admin', '2019-08-26 12:06:32.649', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('bipar', 901, 'Birth Parent', 'Birth Parent', 'CW', 1, 1, 'admin', '2019-08-26 12:06:32.649', 'admin', '2019-08-26 12:06:32.649', NULL, NULL, NULL);
