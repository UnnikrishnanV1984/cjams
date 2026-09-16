INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('priaug', 901, 'Private agency under agreement', 'Private agency under agreement', 'CW', 1, 4, 'admin', now(), 'CIDM-5153', now(), NULL, NULL, NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('iveag', 901, 'Title IV-E Agency', 'Title IV-E Agency', 'CW', 1, 4, 'admin', now(), 'CIDM-5153', now(), NULL, NULL, NULL) on conflict do nothing;
