delete from referencetype where referencetypeid in (760,762);

delete from referencevalues where referencetypeid in (760,762);

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(762, 'Foster Carehome picklist', 'fostercarehomepicklist', 1, 'CIDM-6996', now(), 'CIDM-6996', now(), NULL);

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(760, 'Foster Care Nonfoster home', 'fostercarenonfosterhome', 1, 'CIDM-6996', now(), 'CIDM-6996', now(), NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HOTEL', 760, 'Hotel - provide name, address, and justification for why this is the most appropriate living arrangement', 'Hotel - provide name, address, and justification for why this is the most appropriate living arrangement', 'CW', 1, 1, 'CIDM-6996', now(), 'CIDM-6996', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OFFICE', 760, 'Office - provide name, address, and justification for why this is the most appropriate living arrangement', 'Office - provide name, address, and justification for why this is the most appropriate living arrangement', 'CW', 1, 2, 'CIDM-6996', now(), 'CIDM-6996', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OTHER', 760, 'Other - please explain in the comments below and provide name and address', 'Other - please explain in the comments below and provide name and address', 'CW', 1, 3, 'CIDM-6996', now(), 'CIDM-6996', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UPPHO', 762, 'Unable to place in provider home - no opening in CJAMS, provide name and address for child’s location', 'Unable to place in provider home - no opening in CJAMS, provide name and address for child’s location', 'CW', 1, 1, 'CIDM-6996', now(), 'CIDM-6996', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UPPHP', 762, 'Unable to place in provider home - provider not in CJAMS, provide name and address for child’s location', 'Unable to place in provider home - provider not in CJAMS, provide name and address for child’s location', 'CW', 1, 2, 'CIDM-6996', now(), 'CIDM-6996', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UOther', 762, 'Other - please explain in comments below and provide name and address', 'Other - please explain in comments below and provide name and address', 'CW', 1, 3, 'CIDM-6996', now(), 'CIDM-6996', now(), NULL, NULL, NULL);