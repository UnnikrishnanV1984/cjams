/*
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UUHF', 164, 'Unsub-Unnamed Hearing form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381778_Unsub-Unnamed Hearing form.docx', 'CW', 1, NULL, 'Admin', '2019-05-02 15:04:31.827', NULL, '2019-05-02 15:04:31.827', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UUCRF', 164, 'Unsub-Unnamed Conference  Request Form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381764_Unsub-Unnamed Conference  Request Form.docx', 'CW', 1, NULL, 'Admin', '2019-05-02 15:04:31.828', NULL, '2019-05-02 15:04:31.828', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UNHR', 164, 'Unsub-Named Hearing form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381741_Unsub-Named Hearing form.docx', 'CW', 1, NULL, 'Admin', '2019-05-02 15:04:31.828', NULL, '2019-05-02 15:04:31.828', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UNCR', 164, 'Unsub-Named Conference Request Form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381773_Unsub-Named Conference Request Form.docx', 'CW', 1, NULL, 'Admin', '2019-05-02 15:04:31.828', NULL, '2019-05-02 15:04:31.828', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SOC', 164, 'Summary of Conference Form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381745_Summary of Conference Form.doc', 'CW', 1, NULL, 'Admin', '2019-05-02 15:04:31.829', NULL, '2019-05-02 15:04:31.829', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NOC', 164, 'Notice of Conference 1-2019', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381776_Notice of Conference 1-2019.doc', 'CW', 1, NULL, 'Admin', '2019-05-02 15:04:31.829', NULL, '2019-05-02 15:04:31.829', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('IUNAM', 164, 'Indicated-Unnamed - Hearing Form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381757_Indicated-Unnamed - Hearing Form.docx', 'CW', 1, NULL, 'Admin', '2019-05-02 15:04:31.829', NULL, '2019-05-02 15:04:31.829', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('INAM', 164, 'Indicated Named- Hearing form', 'https://s3.us-east-1.amazonaws.com/s3-cjams/20190115012810/1556253381770_Indicated Named- Hearing form.docx', 'CW', 1, NULL, 'Admin', '2019-05-02 15:04:31.829', NULL, '2019-05-02 15:04:31.829', NULL, NULL, NULL);
*/

update referencevalues set description='Indicated Named- Hearing form.docx' where referencetypeid=164 and ref_key='INAM';
update referencevalues set description='Indicated-Unnamed - Hearing Form.docx' where referencetypeid=164 and ref_key='IUNAM';
update referencevalues set description='Notice of Conference 1-2019.doc' where referencetypeid=164 and ref_key='NOC';
update referencevalues set description='New Summary of Conference 1-2019.doc' where referencetypeid=164 and ref_key='SOC';
update referencevalues set description='Unsub-Named Conf. Request (new).docx' where referencetypeid=164 and ref_key='UNCR';
update referencevalues set description='Unsub-Named Hearing Request form.docx' where referencetypeid=164 and ref_key='UNHR';
update referencevalues set description='Unsub Unnamed Hearing Request form.docx' where referencetypeid=164 and ref_key='UUHF';
update referencevalues set description='Unsub-Unnamed Conf. Request(new).docx' where referencetypeid=164 and ref_key='UUCRF';