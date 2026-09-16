DELETE FROM cjams.progressnotereasontype WHERE typedescription='Biological Family Visits' and progressnotereasontypekey='BFV';
DELETE FROM cjams.progressnotereasontype WHERE typedescription='Child/Bio Family Visits Weekly' and progressnotereasontypekey='CBFV';
DELETE FROM cjams.progressnotereasontype WHERE typedescription='Child/Caretaker/Worker Visits Monthly' and progressnotereasontypekey='CCWVM';
DELETE FROM cjams.progressnotereasontype WHERE typedescription='School Visits' and progressnotereasontypekey='SCHV';
DELETE FROM cjams.progressnotereasontype WHERE typedescription='IEP' and progressnotereasontypekey='IEP';

INSERT INTO cjams.progressnotereasontype
( progressnotereasontypekey, activeflag, typedescription, 
effectivedate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('BFV', 1, 'Biological Family Visits', '2019-05-12 22:17:06.709', 'admin', 'admin', null, null, '');

INSERT INTO cjams.progressnotereasontype
( progressnotereasontypekey, activeflag, typedescription, 
effectivedate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('CBFV', 1, 'Child/Bio Family Visits Weekly', '2019-05-12 22:17:06.709', 'admin', 'admin', null, null, '');

INSERT INTO cjams.progressnotereasontype
( progressnotereasontypekey, activeflag, typedescription, 
effectivedate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('CCWVM', 1, 'Child/Caretaker/Worker Visits Monthly', '2019-05-12 22:17:06.709', 'admin', 'admin', null, null, '');

INSERT INTO cjams.progressnotereasontype
( progressnotereasontypekey, activeflag, typedescription, 
effectivedate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('SCHV', 1, 'School Visits', '2019-05-12 22:17:06.709', 'admin', 'admin', null, null, '');

INSERT INTO cjams.progressnotereasontype
( progressnotereasontypekey, activeflag, typedescription, 
effectivedate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IEP', 1, 'IEP', '2019-05-12 22:17:06.709', 'admin', 'admin', null, null, '');


DELETE FROM cjams.referencevalues where ref_key='YOU' and referencetypeid=52;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag,
displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('YOU', 52, 'Youth', 'Youth', 'CW', 1, 
6, 'Admin', '2019-02-12 23:10:00.385', 'Admin', '2019-02-12 23:10:00.385', NULL, NULL, NULL);

DELETE FROM cjams.removalreasontype where removalreasontypekey='VP' and description='Voluntary Placement';

INSERT INTO cjams.removalreasontype
(removalreasontypekey, description, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES( 'VP', 'Voluntary Placement', 1, '2019-02-12 23:10:00.385', 'Admin', NULL, '2019-02-12 23:10:00.385', NULL, NULL);
