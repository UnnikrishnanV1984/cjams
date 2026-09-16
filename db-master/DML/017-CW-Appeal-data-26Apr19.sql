delete from cjams.referencevalues where ref_key='ST' and referencetypeid=157;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ST', 157, 'Stayed', 'Stayed', 'CW', 1, NULL, 'Admin', '2019-04-12 15:54:02.620', NULL, '2019-04-12 15:54:02.620', NULL, NULL, NULL);

delete from cjams.referencevalues where ref_key='MG' and referencetypeid=157;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MG', 157, 'Motion Granted', 'Motion Granted', 'CW', 1, NULL, 'Admin', '2019-04-12 15:54:02.620', NULL, '2019-04-12 15:54:02.620', NULL, NULL, NULL);

delete from attorneyaddress where attorneyname='Other';
INSERT INTO cjams.attorneyaddress
(attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES( 'Other', '', '', '', '', 1, now(), 'admin', NULL, now(), NULL, NULL, '', '', NULL, '');

