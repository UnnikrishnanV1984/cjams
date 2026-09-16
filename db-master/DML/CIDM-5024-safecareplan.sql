DELETE FROM referencevalues where ref_key = 'SENSCP' and referencetypeid = 46;

INSERT INTO referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey)
VALUES('SENSCP', 46, 'Plan of Safe Care', 'Plan of Safe Care', 'CW', 1, 1, 'Admin', now(), NULL, now(), NULL, NULL);
