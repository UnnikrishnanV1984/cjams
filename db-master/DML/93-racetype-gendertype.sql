INSERT INTO cjams.gendertype
(sequencenumber, gendertypekey, activeflag, datavalue,
editable, typedescription, effectivedate, expirationdate, 
 insertedby, updatedby, insertedon, updatedon, old_id)
SELECT 
	displayorder AS sequencenumber,
	ref_key AS gendertypekey,
	activeflag,
	0 AS datavalue,
	15 AS editable,
	description AS typedescription,
	updatedon AS effectivedate,
	updatedon + interval '1 year' AS expirationdate,
	insertedby,
	updatedby,
	insertedon,
	updatedon,
	NULL AS old_id
	FROM referencevalues WHERE referencetypeid=301
    AND ref_key NOT IN(
     SELECT gendertypekey FROM cjams.gendertype 
    );
Delete from referencevalues where ref_key= 'LA';
INSERT INTO cjams.referencevalues(
                ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
                VALUES ('LA', 171,'Latino' ,'Latino',null, 1, 12,null,'2019-06-05 00:09:00.000003',null, '2019-06-05 00:09:00.000003', null, null,'LA');
Delete from referencevalues where ref_key= 'OT';
INSERT INTO cjams.referencevalues(
                ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
                VALUES ('OT', 171,'Others' ,'Others',null, 1, 13,null,'2019-06-05 00:09:00.000003',null, '2019-06-05 00:09:00.000003', null, null,'OT');
INSERT INTO cjams.racetype
(sequencenumber, racetypekey, activeflag, datavalue, 
editable, typedescription, effectivedate, expirationdate, 
insertedby, updatedby, insertedon, updatedon, old_id)
SELECT DISTINCT
	displayorder AS sequencenumber,
	ref_key AS racetypekey,
	activeflag,
	0 AS datavalue,
	15 AS editable,
	description AS typedescription,
	updatedon AS effectivedate,
	updatedon + interval '1 year' AS expirationdate,
	insertedby,
	updatedby,
	insertedon,
	updatedon,
	NULL AS old_id
	FROM referencevalues WHERE referencetypeid=171 AND 
    ref_key NOT IN(
     SELECT racetypekey FROM cjams.racetype 
    );
COMMIT;
