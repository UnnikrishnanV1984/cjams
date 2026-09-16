--------------------------------------

-- 06/11/2024 - CIDM-10568 - Psychotropic screen Review status dropdown values

-----------------------------------------

DELETE FROM cjams.referencevalues
WHERE referencetypeid = 500608 and value_text='coordinator_assignment_pending';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CAP', 500608, 'coordinator_assignment_pending', 'Coordinator Assignment Pending', 'CW', 1, 3, 'CIDM-10568', now(), 'CIDM-10568', now(), NULL, NULL, NULL);