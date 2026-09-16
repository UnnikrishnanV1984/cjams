/*
    CIDM-5328 - A new role has been added to the person profile role picklist 
*/

DELETE FROM cjams.referencevalues WHERE  ref_key = 'FICTIVEKIN' and referencetypeid = 176;

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FICTIVEKIN', 176, 'Fictive Kin', 'Fictive Kin', NULL, 1, 31, NULL, now(), NULL, now(), NULL, NULL, 'FICTIVEKIN');
