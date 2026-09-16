DELETE FROM referencevalues WHERE  ref_key = 'CTDJS' and referencetypeid= 28;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CTDJS', 28, 'Committed to DJS', 'Committed to DJS', NULL, 1, 1, NULL, now(), NULL, null, NULL, NULL, NULL);

DELETE FROM referencevalues WHERE  ref_key = 'DCTDJS' and referencetypeid= 28;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DCTDJS', 28, 'Delinquent - Committed to DSS and DJJ', 'Delinquent - Committed to DSS and DJJ', NULL, 1, 1, NULL, now(), NULL, null, NULL, NULL, NULL);


DELETE FROM referencevalues WHERE  ref_key = 'SHLTRCOO' and referencetypeid= 28;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SHLTRCOO', 28, 'Shelter Care Order to Other', 'Shelter Care Order to Other', NULL, 1, 1, NULL, now(), NULL, null, NULL, NULL, NULL);


DELETE FROM referencevalues WHERE  ref_key = 'VPACD' and referencetypeid= 28;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VPACD', 28, 'Voluntary Placement Agreement - Child Disability', 'Voluntary Placement Agreement - Child Disability', NULL, 1, 1, NULL, now(), NULL, null, NULL, NULL, NULL);


DELETE FROM referencevalues WHERE  ref_key = 'VPAEA' and referencetypeid= 28;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VPAEA', 28, 'Voluntary Placement Agreement - Enhanced Aftercare', 'Voluntary Placement Agreement - Enhanced Aftercare', NULL, 1, 1, NULL, now(), NULL, null, NULL, NULL, NULL);

DELETE FROM referencevalues WHERE  ref_key = 'VPATL' and referencetypeid= 28;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VPATL', 28, 'Voluntary Placement Agreement - Time Limited', 'Voluntary Placement Agreement - Time Limited', NULL, 1, 1, NULL, now(), NULL, null, NULL, NULL, NULL);

DELETE FROM referencevalues WHERE  ref_key = 'VPATC' and referencetypeid= 28;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VPATC', 28, 'Voluntary Placement Agreement to Caregiver', 'Voluntary Placement Agreement to Caregiver', NULL, 1, 1, NULL, now(), NULL, null, NULL, NULL, NULL);

DELETE FROM referencevalues WHERE  ref_key = 'VPATDS' and referencetypeid= 28;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VPATDS', 28, 'Voluntary Placement Agreement to DSS', 'Voluntary Placement Agreement to DSS', NULL, 1, 1, NULL, now(), NULL, null, NULL, NULL, NULL);

