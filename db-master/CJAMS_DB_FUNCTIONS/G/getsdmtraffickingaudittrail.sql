DROP FUNCTION IF EXISTS cjams.getsdmtraffickingaudittrail(intakenumber character varying ,servicerequestnumber character varying );
DROP FUNCTION IF EXISTS cjams.getsdmtraffickingaudittrail(intakenumber character varying ,servicerequestnumber character varying, servicecasenumber character varying );

--Revision(s)
--  -01/23/2026 - Vamshikri.byreddy --CIDM-10829-SDM story- Capturing audit trail for service case
CREATE OR REPLACE FUNCTION cjams.getsdmtraffickingaudittrail(intakenumber character varying DEFAULT NULL::character varying, servicerequestnumber character varying DEFAULT NULL::character varying,servicecasenumber character varying DEFAULT NULL::character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_sdmtraffickingaudittrail json;
BEGIN
    SELECT coalesce(json_agg(jsonb_set(to_jsonb(row), '{updatedby}', to_jsonb(row.fullname))),'[]'::json)
    INTO v_sdmtraffickingaudittrail
    FROM (
        SELECT t.*, u.fullname
        FROM cjams.sdmtraffickingaudittrail t
        LEFT JOIN userprofile u ON t.updatedby = u.securityusersid
        WHERE t.objectid in(intakenumber,servicerequestnumber, servicecasenumber) order by t.updatedon desc 
    ) AS row;

    RETURN v_sdmtraffickingaudittrail;
END 
$function$
;