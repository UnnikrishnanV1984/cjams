INSERT INTO cjams.personaddresstype
(sequencenumber, personaddresstypekey, activeflag,
datavalue, editable, typedescription, 
effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
SELECT 
	ROW_NUMBER () OVER (ORDER BY ref_key) AS sequencenumber,
	ref_key AS personaddresstypekey,
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
	FROM referencevalues WHERE referencetypeid=305
    AND ref_key NOT IN(
     SELECT personaddresstypekey FROM cjams.personaddresstype 
    );