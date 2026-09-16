
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(2011, 'livingarrangementstates', 'livingarrangementstates', 1, 'CIDM-5210', '2022-07-27 17:51:10.037', 'CIDM-5210', '2022-07-27 17:51:10.037', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NS', 2011, 'Not in the USA', 'Not in the USA', NULL, 1, 60, NULL, now(), NULL, now(), NULL, NULL, '') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LA', 2011, 'Louisiana', 'Louisiana', NULL, 1, 19, 'CIDM-5210', '2021-02-02 19:42:25.791', 'CIDM-5210', '2021-02-02 19:42:25.791', NULL, NULL, 'LA') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TN', 2011, 'Tennessee', 'Tennessee', NULL, 1, 43, NULL, now(), NULL, now(), NULL, NULL, 'TN') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MI', 2011, 'Michigan', 'Michigan', NULL, 1, 23, NULL, now(), NULL, now(), NULL, NULL, 'MI') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('WY', 2011, 'Wyoming', 'Wyoming', NULL, 1, 51, NULL, now(), NULL, now(), NULL, NULL, 'WY') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('WI', 2011, 'Wisconsin', 'Wisconsin', NULL, 1, 50, NULL, now(), NULL, now(), NULL, NULL, 'WI') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('WV', 2011, 'West Virginia', 'West Virginia', NULL, 1, 49, NULL, now(), NULL, now(), NULL, NULL, 'WV') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('WA', 2011, 'Washington', 'Washington', NULL, 1, 48, NULL, now(), NULL, now(), NULL, NULL, 'WA') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VA', 2011, 'Virginia', 'Virginia', NULL, 1, 47, NULL, now(), NULL, now(), NULL, NULL, 'VA') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VT', 2011, 'Vermont', 'Vermont', NULL, 1, 46, NULL, now(), NULL, now(), NULL, NULL, 'VT') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UT', 2011, 'Utah', 'Utah', NULL, 1, 45, NULL, now(), NULL, now(), NULL, NULL, 'UT') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TX', 2011, 'Texas', 'Texas', NULL, 1, 44, NULL, now(), NULL, now(), NULL, NULL, 'TX') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SD', 2011, 'South Dakota', 'South Dakota', NULL, 1, 42, NULL, now(), NULL, now(), NULL, NULL, 'SD') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SC', 2011, 'South Carolina', 'South Carolina', NULL, 1, 41, NULL, now(), NULL, now(), NULL, NULL, 'SC') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('RI', 2011, 'Rhode Island', 'Rhode Island', NULL, 1, 40, NULL, now(), NULL, now(), NULL, NULL, 'RI') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PA', 2011, 'Pennsylvania', 'Pennsylvania', NULL, 1, 39, NULL, now(), NULL, now(), NULL, NULL, 'PA') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OR', 2011, 'Oregon', 'Oregon', NULL, 1, 38, NULL, now(), NULL, now(), NULL, NULL, 'OR') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OK', 2011, 'Oklahoma', 'Oklahoma', NULL, 1, 37, NULL, now(), NULL, now(), NULL, NULL, 'OK') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OH', 2011, 'Ohio', 'Ohio', NULL, 1, 36, NULL, now(), NULL, now(), NULL, NULL, 'OH') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ND', 2011, 'North Dakota', 'North Dakota', NULL, 1, 35, NULL, now(), NULL, now(), NULL, NULL, 'ND') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NC', 2011, 'North Carolina', 'North Carolina', NULL, 1, 34, NULL, now(), NULL, now(), NULL, NULL, 'NC') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NY', 2011, 'New York', 'New York', NULL, 1, 33, NULL, now(), NULL, now(), NULL, NULL, 'NY') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NM', 2011, 'New Mexico', 'New Mexico', NULL, 1, 32, NULL, now(), NULL, now(), NULL, NULL, 'NM') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NJ', 2011, 'New Jersey', 'New Jersey', NULL, 1, 31, NULL, now(), NULL, now(), NULL, NULL, 'NJ') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NH', 2011, 'New Hampshire', 'New Hampshire', NULL, 1, 30, NULL, now(), NULL, now(), NULL, NULL, 'NH') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NV', 2011, 'Nevada', 'Nevada', NULL, 1, 29, NULL, now(), NULL, now(), NULL, NULL, 'NV') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NE', 2011, 'Nebraska', 'Nebraska', NULL, 1, 28, NULL, now(), NULL, now(), NULL, NULL, 'NE') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MT', 2011, 'Montana', 'Montana', NULL, 1, 27, NULL, now(), NULL, now(), NULL, NULL, 'MT') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MO', 2011, 'Missouri', 'Missouri', NULL, 1, 26, NULL, now(), NULL, now(), NULL, NULL, 'MO') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MS', 2011, 'Mississippi', 'Mississippi', NULL, 1, 25, NULL, now(), NULL, now(), NULL, NULL, 'MS') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MN', 2011, 'Minnesota', 'Minnesota', NULL, 1, 24, NULL, now(), NULL, now(), NULL, NULL, 'MN') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MA', 2011, 'Massachusetts', 'Massachusetts', NULL, 1, 22, NULL, now(), NULL, now(), NULL, NULL, 'MA') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MD', 2011, 'Maryland', 'Maryland', NULL, 1, 21, NULL, now(), NULL, now(), NULL, NULL, 'MD') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ME', 2011, 'Maine', 'Maine', NULL, 1, 20, NULL, now(), NULL, now(), NULL, NULL, 'ME') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('KY', 2011, 'Kentucky', 'Kentucky', NULL, 1, 18, NULL, now(), NULL, now(), NULL, NULL, 'KY') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('KS', 2011, 'Kansas', 'Kansas', NULL, 1, 17, NULL, now(), NULL, now(), NULL, NULL, 'KS') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('IA', 2011, 'Iowa', 'Iowa', NULL, 1, 16, NULL, now(), NULL, now(), NULL, NULL, 'IA') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('IN', 2011, 'Indiana', 'Indiana', NULL, 1, 15, NULL, now(), NULL, now(), NULL, NULL, 'IN') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('IL', 2011, 'Illinois', 'Illinois', NULL, 1, 14, NULL, now(), NULL, now(), NULL, NULL, 'IL') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ID', 2011, 'Idaho', 'Idaho', NULL, 1, 13, NULL, now(), NULL, now(), NULL, NULL, 'ID') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HI', 2011, 'Hawaii', 'Hawaii', NULL, 1, 12, NULL, now(), NULL, now(), NULL, NULL, 'HI') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('GA', 2011, 'Georgia', 'Georgia', NULL, 1, 11, NULL, now(), NULL, now(), NULL, NULL, 'GA') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FL', 2011, 'Florida', 'Florida', NULL, 1, 10, NULL, now(), NULL, now(), NULL, NULL, 'FL') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DC', 2011, 'District of Columbia', 'District of Columbia', NULL, 1, 9, NULL, now(), NULL, now(), NULL, NULL, 'DC') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DE', 2011, 'Delaware', 'Delaware', NULL, 1, 8, NULL, now(), NULL, now(), NULL, NULL, 'DE') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CT', 2011, 'Connecticut', 'Connecticut', NULL, 1, 7, NULL, now(), NULL, now(), NULL, NULL, 'CT') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CO', 2011, 'Colorado', 'Colorado', NULL, 1, 6, NULL, now(), NULL, now(), NULL, NULL, 'CO') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CA', 2011, 'California', 'California', NULL, 1, 5, NULL, now(), NULL, now(), NULL, NULL, 'CA') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AR', 2011, 'Arkansas', 'Arkansas', NULL, 1, 4, NULL, now(), NULL, now(), NULL, NULL, 'AR') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AZ', 2011, 'Arizona', 'Arizona', NULL, 1, 3, NULL, now(), NULL, now(), NULL, NULL, 'AZ') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AK', 2011, 'Alaska', 'Alaska', NULL, 1, 2, NULL, now(), NULL, now(), NULL, NULL, 'AK') on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AL', 2011, 'Alabama', 'Alabama', NULL, 1, 1, NULL, now(), NULL, now(), NULL, NULL, 'AL') on conflict do nothing;
