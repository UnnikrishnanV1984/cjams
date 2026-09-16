DROP FUNCTION IF EXISTS cjams.getpersonmedicalpdf(uuid);
CREATE OR REPLACE FUNCTION cjams.getpersonmedicalpdf(v_personid uuid)
RETURNS json AS $$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 03/28/2025 Simar Singh -- CIDM-10103 add person medications for prinf pdf as part of Health Summary
------------------------------------------------------------------------------------------------------------
DECLARE
    l_medications json;
BEGIN
    SELECT json_agg(e) INTO l_medications
    FROM (
        SELECT DISTINCT ON (pmed.personmedicpshychotropicid) pmed.*, 
            rv.value_text AS frequencytext,
            rv1.value_text AS prescribeddurationtext, 
            mt.description AS methodofdelivery,
            rv2.value_text AS classificationtext,        
            (CASE WHEN pmed.targetedsymptoms IS NOT NULL then
            (SELECT string_agg(description, ', ')
                 FROM referencevalues
                 WHERE referencetypeid = 500120
                   AND ref_key in (select json_array_elements_text(targetedsymptoms::json)
                ))end)  AS targetedsymptomstext,
            (CASE WHEN pmed.informedconsent IS NOT NULL THEN
                (SELECT string_agg(description, ', ')
                 FROM referencevalues
                 WHERE referencetypeid = 500121
                   AND ref_key in (select json_array_elements_text(informedconsent::json) 
)
                )
            END) AS informedconsenttext,
                (case when pmed.uploadedFiles is null then (SELECT json_agg(docs) FROM  (SELECT dp.documentpropertiesid, dp.objecttypekey,dp.activeflag,dp.ecmsdocumentid, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon,
            (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
             dp.uploadstatus, dp.finalstatus, (SELECT row_to_json(x) AS documentattachment FROM (SELECT dat.documentpropertiesid,dat.attachmenttypekey, dat.attachmentclassificationtypekey,dat.activeflag, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
            (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat WHERE dat.documentpropertiesid = dp.documentpropertiesid ) x)
            from documentproperties dp where dp.additionalobjectid = pmed.personmedicpshychotropicid::varchar and dp.additionalobjecttype = 'personmedicpshychotropic' and dp.activeflag in (1,3,4,5) and dp.documentpropertiesid in (
                select    (max(documentpropertiesid::varchar))::uuid  from documentproperties dc where   dc.additionalobjectid::uuid = pmed.personmedicpshychotropicid::uuid and  dc.additionalobjecttype = 'personmedicpshychotropic' group by dc.ecmsdocumentid 
                ) )docs) else pmed.uploadedFiles end) as uploadedFiles
        FROM personmedicpshychotropic pmed
        LEFT JOIN referencevalues rv ON rv.ref_key = pmed.frequency AND rv.activeflag = 1 AND rv.referencetypeid = 311
        LEFT JOIN referencevalues rv1 ON rv1.ref_key = pmed.prescribedduration AND rv1.activeflag = 1 AND rv1.referencetypeid = 334
        LEFT JOIN medicationtype mt ON mt.medicationtypekey = pmed.medicationtype AND mt.activeflag = 1
        LEFT JOIN referencevalues rv2 ON rv2.ref_key = pmed.classification AND rv2.activeflag = 1 AND rv2.referencetypeid = 339
        WHERE pmed.activeflag = 1 AND pmed.personid = v_personid
    ) e;

    RETURN l_medications;
END;
$$ LANGUAGE plpgsql;