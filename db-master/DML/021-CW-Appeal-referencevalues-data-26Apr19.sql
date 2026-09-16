delete from cjams.referencetype where typedescription='appealdocuments';

INSERT INTO cjams.referencetype
(referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(164,'appealdocuments', 'appealdocuments', 1, 'admin', now(), 'admin', now(), NULL);

delete from cjams.referencetype where typedescription='reporterroles';

INSERT INTO cjams.referencetype
(referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(165,'reporterroles', 'reporterroles', 1, 'admin', now(), 'admin', now(), NULL);


delete from cjams.referencevalues where referencetypeid=164;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UUHF', 164, 'Unsub-Unnamed Hearing form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381778_Unsub-Unnamed Hearing form.docx', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UUCRF', 164, 'Unsub-Unnamed Conference  Request Form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381764_Unsub-Unnamed Conference  Request Form.docx', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UNHR', 164, 'Unsub-Named Hearing form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381741_Unsub-Named Hearing form.docx', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UNCR', 164, 'Unsub-Named Conference Request Form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381773_Unsub-Named Conference Request Form.docx', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SOC', 164, 'Summary of Conference Form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381745_Summary of Conference Form.doc', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NOC', 164, 'Notice of Conference 1-2019', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381776_Notice of Conference 1-2019.doc', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('IUNAM', 164, 'Indicated-Unnamed - Hearing Form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381757_Indicated-Unnamed - Hearing Form.docx', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('INAM', 164, 'Indicated Named- Hearing form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381770_Indicated Named- Hearing form.docx', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);

delete from cjams.referencevalues where referencetypeid=165;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SSP', 165, 'Social Services personnel', 'Social Services personnel', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MP', 165, 'Medical personnel', 'Medical personnel', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MHP', 165, 'Mental health personnel', 'Mental health personnel', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LLECJP', 165, 'Legal, law enforcement, or criminal justice person', 'Legal, law enforcement, or criminal justice person', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('EP', 165, 'Education personnel', 'Education personnel', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CDCP', 165, 'Child day care provider', 'Child day care provider', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SCP', 165, 'Substitute care provider', 'Substitute care provider', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AV', 165, 'Alleged victim', 'Alleged victim', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PAT', 165, 'Parent', 'Parent', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OR', 165, 'Other relative', 'Other relative', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FN', 165, 'Friends / neighbour', 'Friends / neighbour', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AP', 165, 'Alleged perpetrator', 'Alleged perpetrator', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OTH', 165, 'Other', 'Other', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UM', 165, 'Unknown or missing', 'Unknown or missing', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AR', 165, 'Anonymous reporter', 'Anonymous reporter', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
