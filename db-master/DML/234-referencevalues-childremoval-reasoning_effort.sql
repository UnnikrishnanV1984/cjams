UPDATE cjams.referencevalues
SET activeflag=0
WHERE ref_key='NREM' AND referencetypeid=69 AND value_text='Due to the Emergent Nature of the Situation, Reasonable Efforts could not be made' AND description='Due to the Emergent Nature of the Situation, Reasonable Efforts could not be made';

delete from cjams.referencevalues  where ref_key = 'DAESRSC';
delete from cjams.referencevalues  where ref_key = 'REPERCH';


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DAESRSC', 69, 'Due to an alleged emergency situation, removal from the home is reasonable under the circumstances to provide for the safety of the child', 'Due to an alleged emergency situation, removal from the home is reasonable under the circumstances to provide for the safety of the child', 'CW', 1, 28, 'Admin', '2019-02-12 23:10:00.385', 'Admin', '2019-02-12 23:10:00.385', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('REPERCH', 69, 'Reasonable efforts have been made but have been unsuccessful in preventing or eliminating the need for removal of child from childs home', 'Reasonable efforts have been made but have been unsuccessful in preventing or eliminating the need for removal of child from childs home', 'CW', 1, 28, 'Admin', '2019-02-12 23:10:00.385', 'Admin', '2019-02-12 23:10:00.385', NULL, NULL, NULL);
