CREATE OR REPLACE VIEW cjams.actortype
AS SELECT 
    distinct on (referencevalues.ref_key) 
	referencevalues.displayorder AS sequencenumber,
    referencevalues.ref_key AS actortype,
    referencevalues.activeflag,
    referencevalues.description AS typedescription,
    referencevalues.updatedon AS effectivedate,
    referencevalues.updatedon + '1 year'::interval AS expirationdate,
    referencevalues.insertedon AS "timestamp",
    1 AS tasktype,
    referencevalues.insertedby,
    referencevalues.updatedby,
    referencevalues.insertedon,
    referencevalues.updatedon,
    NULL::text AS old_id,
        CASE
            WHEN referencevalues.referencetypeid = 175 THEN 'C'::text
            ELSE 'H'::text
        END AS rolegroup
   FROM referencevalues
  WHERE referencevalues.referencetypeid = ANY (ARRAY[175,176]);
