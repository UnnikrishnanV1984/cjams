DELETE FROM cjams.referencetype where referencetypeid = 500503;


INSERT INTO cjams.referencetype (referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag) VALUES(500503, 'Notifications Source', 'notificationsource', 1, 'CIDM-8809', 'now()', 'CIDM-8809', 'now()', NULL);


DELETE FROM cjams.referencevalues WHERE referencetypeid = 500503;

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon) VALUES('1500', 500503, 'CRISP', 'CRISP', 'CW', 1, NULL, 'CIDM-8809', now(), 'CIDM-8809', now());