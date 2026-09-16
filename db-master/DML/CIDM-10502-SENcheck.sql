DELETE FROM cjams.referencetype WHERE referencetypeid = 592;
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(592, 'SEN check', 'sencheck', 1, 'CIDM-10502', now(), 'CIDM-10502', now(), NULL);

DELETE FROM cjams.referencevalues WHERE referencetypeid = 592;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NEG', 592, 'Negative toxicology screen', 'Negative toxicology screen', NULL, 1, 1, 'CIDM-10502', NOW(), NULL, NOW(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('WDL', 592, 'medical personnel',
'Does not display the effects of controlled substance use or symptoms of withdrawal resulting from the prenatal controlled substance exposure as determined by medical personnel',
NULL, 1, 1, 'CIDM-10502', NOW(), NULL, NOW(), NULL, NULL, NULL); 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FASD', 592, 'Does not display the effects of FASD', 'Does not display the effects of FASD', NULL, 1, 1, 'CIDM-10502', NOW(), NULL, NOW(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OTH', 592, 'Other', 'Other', NULL, 1, 1, 'CIDM-10502', NOW(), NULL, NOW(), NULL, NULL, NULL);

DELETE FROM cjams.referencetype WHERE referencetypeid = 593;
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(593, 'SEN check Agency', 'sencheckagencyactions', 1, 'CIDM-10502', now(), 'CIDM-10502', now(), NULL);

DELETE FROM cjams.referencevalues WHERE referencetypeid = 593;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CWS', 593, 'Other child welfare services initiated', 'Other child welfare services initiated', NULL, 1, 1, 'CIDM-10502', NOW(), NULL, NOW(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ROCSP', 593, 'Referrals to other community services provided', 'Referrals to other community services provided', NULL, 1, 1, 'CIDM-10502', NOW(), NULL, NOW(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SCWC', 593, 'Service case will be closed', 'Service case will be closed', NULL, 1, 1, 'CIDM-10502', NOW(), NULL, NOW(), NULL, NULL, NULL);

DELETE FROM cjams.referencetype WHERE referencetypeid = 594;
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(594, 'SEN check supervisor deny', 'senchecksupervisordeny', 1, 'CIDM-10502', now(), 'CIDM-10502', now(), NULL);

DELETE FROM cjams.referencevalues WHERE referencetypeid = 594;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ADN', 594, 'Add contact note', 'Add contact note', NULL, 1, 1, 'CIDM-10502', NOW(), NULL, NOW(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ANCN', 594, 'Add narrative to contact note','Add narrative to contact note',NULL, 1, 1, 'CIDM-10502', NOW(), NULL, NOW(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UNHT', 594, 'Upload newborn medical, hospital, toxicology results, or other related documentation supporting decision', 
'Upload newborn medical, hospital, toxicology results, or other related documentation supporting decision', NULL, 1, 1, 'CIDM-10502', NOW(), NULL, NOW(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OTH', 594, 'Other','Other',NULL, 1, 1, 'CIDM-10502', NOW(), NULL, NOW(), NULL, NULL, NULL);


