
DROP FUNCTION IF EXISTS cjams.getusersemailbyrole(v_roletypekey character varying);

-- ---------------------------------------------------------------------------------------------------------
-- 06/27/2025 Prasanna Sai Kommineni - Utility function to fetch alternate emails by team role

-- ---------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION cjams.getusersemailbyrole(v_roletypekey character varying)
RETURNS json
LANGUAGE plpgsql
AS $function$
DECLARE
  v_result json;
BEGIN
  SELECT json_agg(row_data) INTO v_result
  FROM (
    SELECT up.alternateemailid
    FROM cjams.userprofile up
    inner join cjams.muser mu on mu.securityusersid = up.securityusersid
    INNER JOIN cjams.teammemberassignment tma ON tma.securityusersid = up.securityusersid
    INNER JOIN cjams.teammember tm ON tm.teammemberid = tma.teammemberid
    INNER join cjams.rolemapping rm on rm.principalid:: int  = mu.id
    WHERE rm.teamtypekey = 'CW'
      AND tm.roletypekey = v_roletypekey
      AND up.alternateemailid IS NOT NULL
  ) AS row_data;

  RETURN v_result;
END;
$function$;