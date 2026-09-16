-- a.Exact Match

-- b. Fuzzy Match

-- c.Soundex match

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(500200, 'Search Type', 'Search Type', 1, 'CIDM-8201', now(), 'CIDM-8201', now(), NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('EXM', 500200, 'Exact Match', 'Exact Match', 'CW', 1, 1, 'CIDM-8201', now(), 'CIDM-8201', now(), NULL, NULL, NULL)on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FZM', 500200, 'Fuzzy Match', 'Fuzzy Match', 'CW', 1, 2, 'CIDM-8201', now(), 'CIDM-8201', now(), NULL, NULL, NULL)on conflict do nothing;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SXM', 500200, 'Soundex match', 'Soundex match', 'CW', 1, 3, 'CIDM-8201', now(), 'CIDM-8201', now(), NULL, NULL, NULL)on conflict do nothing;
