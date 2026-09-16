

delete from referencetype where tablename='jurilocation';
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(158, 'jurilocation', 'jurilocation', 1, 'admin', '2019-04-13 13:53:13.124', 'admin', '2019-04-13 13:53:13.124', NULL);

delete from referencevalues where referencetypeid=158 and teamtypekey='CW';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OD', 158, 'Old District Court Bldg.,3 Pershing St., Room 105 Cumberland, MD 21502', 'Old District Court Bldg.,3 Pershing St., Room 105 Cumberland, MD 21502', 'CW', 1, NULL, 'Admin', '2019-04-13 13:55:44.934', NULL, '2019-04-13 13:55:44.934', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('RR', 158, '2666 Riva Road, Suite 390 Annapolis, MD 21401', '2666 Riva Road, Suite 390 Annapolis, MD 21401', 'CW', 1, NULL, 'Admin', '2019-04-13 13:57:05.425', NULL, '2019-04-13 13:57:05.425', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('GR', 158, 'OAH 1101 Gilroy Road,Hunt Valley, MD 21031-8201', 'OAH 1101 Gilroy Road,Hunt Valley, MD 21031-8201', 'CW', 1, NULL, 'Admin', '2019-04-13 13:58:38.872', NULL, '2019-04-13 13:58:38.872', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CC', 158, 'Calvert County DSS, 200 Duke Street, Prince Frederick, MD 20678', 'Calvert County DSS, 200 Duke Street, Prince Frederick, MD 20678', 'CW', 1, NULL, 'Admin', '2019-04-13 13:59:38.463', NULL, '2019-04-13 13:59:38.463', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TD', 158, '207 S. Third St. Denton, MD 21629', '207 S. Third St. Denton, MD 21629', 'CW', 1, NULL, 'Admin', '2019-04-13 14:00:33.593', NULL, '2019-04-13 14:00:33.593', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TC', 158, '1232 Tech Court, Westminster, MD  21157', '1232 Tech Court, Westminster, MD  21157', 'CW', 1, NULL, 'Admin', '2019-04-13 14:01:07.293', NULL, '2019-04-13 14:01:07.293', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MS', 158, '170 E. Main Street,Elkton, MD 21921', '170 E. Main Street,Elkton, MD 21921', 'CW', 1, NULL, 'Admin', '2019-04-13 14:01:54.953', NULL, '2019-04-13 14:01:54.953', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('KA', 158, '200 Kent Avenue,LaPlata, MD 20646', '200 Kent Avenue,LaPlata, MD 20646', 'CW', 1, NULL, 'Admin', '2019-04-13 14:02:34.594', NULL, '2019-04-13 14:02:34.594', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('RS', 158, '627 Race Street,Cambridge, MD 21613', '627 Race Street,Cambridge, MD 21613', 'CW', 1, NULL, 'Admin', '2019-04-13 14:03:17.634', NULL, '2019-04-13 14:03:17.634', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FC', 158, 'FCDSS,1888 N. Market Street, Frederick, MD 21701', 'FCDSS,1888 N. Market Street, Frederick, MD 21701', 'CW', 1, NULL, 'Admin', '2019-04-13 14:06:32.790', NULL, '2019-04-13 14:06:32.790', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('BS', 158, '2 S. Bond Street, Suite 300,Bel Air MD 21014', '2 S. Bond Street, Suite 300,Bel Air MD 21014', 'CW', 1, NULL, 'Admin', '2019-04-13 14:10:10.758', NULL, '2019-04-13 14:10:10.758', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HC', 158, 'Howard County Dept. of Soc Serv,9780 Patuxent Woods Drive Columbia, MD 21046', 'Howard County Dept. of Soc Serv,9780 Patuxent Woods Drive Columbia, MD 21046', 'CW', 1, NULL, 'Admin', '2019-04-13 14:10:53.258', NULL, '2019-04-13 14:10:53.258', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TP', 158, ' 751 Twinbrook Parkway Rockville, MD 20851 (Temporary)', '751 Twinbrook Parkway Rockville, MD 20851 (Temporary)', 'CW', 1, NULL, 'Admin', '2019-04-13 14:13:18.434', NULL, '2019-04-13 14:13:18.434', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PG', 158, 'Prince George''s County DSS,925 Brightseat Road,Landover, MD 20785', 'Prince George''s County DSS,925 Brightseat Road,Landover, MD 20785', 'CW', 1, NULL, 'Admin', '2019-04-13 14:15:33.195', NULL, '2019-04-13 14:15:33.195', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CD', 158, '125 Comet Dr. Centreville, Md.', '125 Comet Dr. Centreville, Md.', 'CW', 1, NULL, 'Admin', '2019-04-13 14:16:23.596', NULL, '2019-04-13 14:16:23.596', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SC', 158, 'SCDSS 30397 Mt. Vernon Road,Princess Anne, MD  21853', 'SCDSS 30397 Mt. Vernon Road,Princess Anne, MD  21853', 'CW', 1, NULL, 'Admin', '2019-04-13 14:17:28.956', NULL, '2019-04-13 14:17:28.956', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SM', 158, 'SMCDSS 23110 Leonard Hall Drive Leonardtown, MD 20650', 'SMCDSS  23110 Leonard Hall Drive Leonardtown, MD 20650', 'CW', 1, NULL, 'Admin', '2019-04-13 14:18:01.527', NULL, '2019-04-13 14:18:01.527', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('BSM', 158, '301 Bay Street, Unit 5,Easton, Maryland 21581', '301 Bay Street, Unit 5,Easton, Maryland 21581', 'CW', 1, NULL, 'Admin', '2019-04-13 14:18:47.307', NULL, '2019-04-13 14:18:47.307', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PSH', 158, 'WCDSS 122 N. Potomac Street,Hagerstown, MD 21740', 'WCDSS 122 N. Potomac Street,Hagerstown, MD 21740', 'CW', 1, NULL, 'Admin', '2019-04-13 14:19:46.959', NULL, '2019-04-13 14:19:46.959', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FS', 158, 'ACDSS 1 Frederick Street,Cumberland, MD 21502', 'ACDSS 1 Frederick Street,Cumberland, MD 21502', 'CW', 1, NULL, 'Admin', '2019-04-13 14:24:54.078', NULL, '2019-04-13 14:24:54.078', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('GH', 158, 'GCDSS 12578 Garrett Hwy.,Oakland, MD 21550', 'GCDSS 12578 Garrett Hwy.,Oakland, MD 21550', 'CW', 1, NULL, 'Admin', '2019-04-13 14:25:38.968', NULL, '2019-04-13 14:25:38.968', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PD', 158, '1301 Piccard Drive, 4th Floor Rockville, MD 20850', '1301 Piccard Drive, 4th Floor Rockville, MD 20850', 'CW', 1, NULL, 'Admin', '2019-04-13 14:26:14.210', NULL, '2019-04-13 14:26:14.210', NULL, NULL, NULL);



delete from attorneyaddress where attorneyaddressid in ('28550ca4-1015-4853-b7be-039112372e25',
'badedd8b-80f1-4a2e-9830-4bf706c0cf49',
'8c72ec7c-7c91-4745-86d8-60c7a4bc5468',
'8fbb18e9-815f-418d-85da-b66f59661d46',
'2843f79b-dd80-4318-98d1-30e01a60e538',
'7b0f2f79-0795-403b-a689-f78a6a8c37bd',
'6d470135-fafd-4779-b6e6-d1defd205524',
'75ad3bb9-91a3-40b7-a56b-60612a7942d0',
'b2aebc05-dba5-4443-b641-893f6df9a75d',
'a5bbe132-b97a-46f7-8f1b-0814f0d381aa',
'97cdd1c3-0d33-4d22-8030-aea8801a3634',
'e753d05d-b61c-44d0-8ef0-128a4b952a6b',
'5ae809a8-5313-428a-9e11-426b133d4671',
'1644b2aa-6607-4f49-8f01-f144d88d8e02',
'0b3638f5-99f1-42b2-8edd-faef0290f738',
'4295fc4a-133e-46ed-bad5-e15ec34c731d',
'78a2ba70-3699-49de-9bb6-3e57e64b8860',
'2a00b464-dc1e-452f-8caa-b0768d5eb8d6',
'd369f87e-16eb-4dea-b10a-c69fa1df1426',
'21d7dddb-be69-4cb9-b8f8-cec0348fd718',
'eeb33c86-1c23-4300-9022-86fe7987d004',
'7cb3047f-3af3-400e-be49-9cadec89085c',
'36b5e73d-5247-4996-9431-b53f63e6eefe',
'0088558b-d5c5-4e81-9b14-79eb70a65315');

INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('28550ca4-1015-4853-b7be-039112372e25', 'Tiffany Reiff', '122 N. Potomac Street', '240-420-2367', '240-420-2549', 'tiffany.reiff@maryland.gov', 1, '2019-04-13 14:55:15.783', 'admin', NULL, '2019-04-13 14:55:15.783', NULL, NULL, 'Hagerstown', 'MD', 21741, NULL);
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('badedd8b-80f1-4a2e-9830-4bf706c0cf49', 'David Dunwiddie', '80 West Street', '240-466-1450', '301-352-8494', 'david.dunwiddie@maryland.gov', 1, '2019-04-13 14:56:29.713', 'admin', NULL, '2019-04-13 14:56:29.713', NULL, '', 'Annapolis', 'MD', 21401, 'Anne Arundel Co. DSS');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('8c72ec7c-7c91-4745-86d8-60c7a4bc5468', 'Marie Foreman', '1510 Guilford Avenue', '443-378-4194', '443-378-4200', 'marie.foreman@maryland.gov', 1, '2019-04-13 14:59:07.254', 'admin', NULL, '2019-04-13 14:59:07.254', NULL, '', 'Baltimore', 'MD', 21202, 'Legal Services Division-BCDSS');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('8fbb18e9-815f-418d-85da-b66f59661d46', 'Felicia Ciesla', '1510 Guilford Avenue', '443-378-4150', NULL, 'felicia.ciesla@maryland.gov', 1, '2019-04-13 15:06:29.919', 'admin', NULL, '2019-04-13 15:06:29.919', NULL, '4th Floor', 'Baltimore', 'MD', 21202, 'Legal Services Division - BCDSS');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('2843f79b-dd80-4318-98d1-30e01a60e538', 'Julie Dyer', 'Drumcastle Government Center', '410-853-3970', '410-853-3097', 'julie.dyer@maryland.gov', 1, '2019-04-13 15:08:32.351', 'admin', NULL, '2019-04-13 15:08:32.351', NULL, '6401 York Road ', 'Baltimore', 'MD', 21212, 'Assistant County Attorney');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('7b0f2f79-0795-403b-a689-f78a6a8c37bd', 'Sam Moxley', 'Drumcastle Government Center', NULL, '410-853-3097', 'sam.moxley@maryland.gov', 1, '2019-04-13 15:09:22.729', 'admin', NULL, '2019-04-13 15:09:22.729', NULL, '6401 York Road ', 'Baltimore', 'MD', 21212, 'Assistant County Attorney');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('6d470135-fafd-4779-b6e6-d1defd205524', 'David Dunwiddie', '80 West Street', '240-466-1450', '301-352-8494', 'david.dunwiddie@maryland.gov', 1, '2019-04-13 15:11:14.920', 'admin', NULL, '2019-04-13 15:11:14.920', NULL, NULL, 'Annapolis', 'MD', 21401, 'Anne Arundel Co. DSS');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('75ad3bb9-91a3-40b7-a56b-60612a7942d0', 'Bruce Edwards', 'P.O. Box 400', '410-819-4534', '410-819-4501', 'bruce.edwards@maryland.gov', 1, '2019-04-13 15:12:38.351', 'admin', NULL, '2019-04-13 15:12:38.351', NULL, NULL, 'Denton', 'MD', 21629, NULL);
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('b2aebc05-dba5-4443-b641-893f6df9a75d', 'Lisa Snyder', '1232 Tech Court', '410-386-3313', '410-386-3476', 'lisap.snyder@maryland.gov', 1, '2019-04-13 15:14:16.094', 'admin', NULL, '2019-04-13 15:14:16.094', NULL, NULL, 'Westminster', 'MD', 21157, 'Carroll Co. DSS');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('a5bbe132-b97a-46f7-8f1b-0814f0d381aa', 'Mary Englehart', 'P.O. Box 1160', '410-996-0172', '410-996-0228', 'mary.englehart@maryland.gov', 1, '2019-04-13 15:15:44.215', 'admin', NULL, '2019-04-13 15:15:44.215', NULL, NULL, 'Elkton', 'MD', 21921, NULL);
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('97cdd1c3-0d33-4d22-8030-aea8801a3634', 'David Dunwiddie', '80 West Street', '240-466-1450', '301-352-8494', 'david.dunwiddie@maryland.gov', 1, '2019-04-13 15:17:37.036', 'admin', NULL, '2019-04-13 15:17:37.036', NULL, NULL, 'Annapolis', 'MD', 21401, 'Anne Arundel Co. DSS');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('e753d05d-b61c-44d0-8ef0-128a4b952a6b', 'Robert Collison', '627 Race Street', '410-901-4275', '410-901-1121', 'rob.collison@maryland.gov', 1, '2019-04-13 15:18:51.257', 'admin', NULL, '2019-04-13 15:18:51.257', NULL, NULL, 'Cambridge', 'MD', 21613, 'Dorchester Co. DSS');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('5ae809a8-5313-428a-9e11-426b133d4671', 'Tiffany Reiff', '122 N. Potomac Street', '240-420-2367', '240-420-2549', 'tiffany.reiff@maryland.gov', 1, '2019-04-13 15:20:44.095', 'admin', NULL, '2019-04-13 15:20:44.095', NULL, NULL, 'Hagerstown', 'MD', 21741, NULL);
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('1644b2aa-6607-4f49-8f01-f144d88d8e02', 'Mary Englehart', '2 S. Bond Street Suite 300', '410-836-4775', '410-836-4930', 'mary.englehart@maryland.gov', 1, '2019-04-13 15:22:55.616', 'admin', NULL, '2019-04-13 15:22:55.616', NULL, NULL, 'Bel Air', 'MD', 21014, NULL);
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('0b3638f5-99f1-42b2-8edd-faef0290f738', 'Beverly Heydon', '3430 Court House Drive', '410-313-3087 or 410-313-2103', '410-313-3292', 'bheydon@howardcountymd.gov', 1, '2019-04-13 15:24:37.588', 'admin', NULL, '2019-04-13 15:24:37.588', NULL, NULL, 'Ellicott City', 'MD', 21043, 'Office of Law');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('4295fc4a-133e-46ed-bad5-e15ec34c731d', 'Thomas Yeager', '350 High Street', '410-810-0428', '410-778-1497', 'tom.yeager@maryland.gov or yeagerlawoffice@baybroadband.net', 1, '2019-04-13 15:26:42.909', 'admin', NULL, '2019-04-13 15:26:42.909', NULL, NULL, 'Chestertown', 'MD', 21620, 'Kent Co. DSS');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('78a2ba70-3699-49de-9bb6-3e57e64b8860', 'Danielle Wete', '101 Monroe Street', '240-777-6763', '240-777-6758', 'danielle.wete@montgomerycountymd.gov', 1, '2019-04-13 15:28:10.641', 'admin', NULL, '2019-04-13 15:28:10.641', NULL, NULL, 'Rockville', 'MD', 20850, 'Office of the County Attorney');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('2a00b464-dc1e-452f-8caa-b0768d5eb8d6', ' Johnine N. Clark', '7833 Walker Drive', '(301)336-4900', '(301)336-9046', 'info@jnclarklaw.com ', 1, '2019-04-13 15:29:27.651', 'admin', NULL, '2019-04-13 15:29:27.651', NULL, NULL, 'Greenbelt', 'MD', 20700, NULL);
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('d369f87e-16eb-4dea-b10a-c69fa1df1426', 'E. Sean Poltrack', '101 Chester Station Lane', '410-643-4110', '410-604-0400', 'spoltrack@bt-lawyer.com ', 1, '2019-04-13 15:30:40.461', 'admin', NULL, '2019-04-13 15:30:40.461', NULL, NULL, 'Chester', 'MD', 21619, 'Braden, Thompson & Poltrack, LLP');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('21d7dddb-be69-4cb9-b8f8-cec0348fd718', 'Jenifer S. Goolie', '30397 Mt. Vernon Road', '410-677-4224', '410-677-4300', 'jenifer.goolie@maryland.gov ', 1, '2019-04-13 15:32:10.182', 'admin', NULL, '2019-04-13 15:32:10.182', NULL, NULL, 'Princess Anne', 'MD', 21853, 'Somerset Co. DSS');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('eeb33c86-1c23-4300-9022-86fe7987d004', 'Michael T. Anne Mundy', '101 Chester Station Lane', '410-643-4110', '410-604-0400', 'mmundy@bt-lawyer.com', 1, '2019-04-13 15:34:23.223', 'admin', NULL, '2019-04-13 15:34:23.223', NULL, NULL, 'Chester', 'MD', 21619, 'Braden, Thompson & Poltrack, LLP');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('7cb3047f-3af3-400e-be49-9cadec89085c', 'Tiffany Reiff', '122 N. Potomac Street', '240-420-2367', '240-420-2549', 'tiffany.reiff@maryland.gov', 1, '2019-04-13 15:36:51.455', 'admin', NULL, '2019-04-13 15:36:51.455', NULL, NULL, 'Hagerstown', 'MD', 21740, 'Washington Co. DSS');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('36b5e73d-5247-4996-9431-b53f63e6eefe', 'Mike Geleta', '201 Baptist Street, Suite 27', '410-713-3904', '410-572-2796', 'mike.geleta@maryland.gov', 1, '2019-04-13 15:38:12.485', 'admin', NULL, '2019-04-13 15:38:12.485', NULL, NULL, 'Salisbury', 'MD', 21804, 'Wicomico Co. DSS');
INSERT INTO cjams.attorneyaddress
(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES('0088558b-d5c5-4e81-9b14-79eb70a65315', 'Jeffrey B. Cropper', '299 Commerce Street', '410-677-6888', '410-677-6810', 'jeffrey.cropper@maryland.gov', 1, '2019-04-13 15:40:05.567', 'admin', NULL, '2019-04-13 15:40:05.567', NULL, NULL, 'Snow Hill', 'MD', 21863, 'Worcester Co. DSS');
