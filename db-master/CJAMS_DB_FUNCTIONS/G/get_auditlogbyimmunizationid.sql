DROP FUNCTION IF EXISTS cjams.get_auditlogbyimmunizationid(v_column character varying, v_tablename character varying, objectid character varying, v_configid character varying, pagenumber bigint, pagesize bigint);

CREATE OR REPLACE FUNCTION cjams.get_auditlogbyimmunizationid(v_column character varying, v_tablename character varying, objectid character varying, v_configid character varying, pagenumber bigint, pagesize bigint)
 RETURNS json
 LANGUAGE plpgsql
AS $function$  
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 05/24/2026 Manasa Kasula - To fix the security issue (CIDM-11427)
------------------------------------------------------------------------------------------------------------	
 DECLARE    
 v_pageoffset  int;       
 v_pagenumber  int;       
 l_data json;     
 
 BEGIN      
	v_pagenumber  :=  pagenumber-1;     
	v_pageoffset  =  v_pagenumber  *  pagesize;
	l_data := '[]';


	EXECUTE 'SELECT COALESCE(json_agg(e), ''[]'')
			FROM (
				SELECT to_char(i.updatedon, ''mm/dd/yyyy hh:mi AM'' ) as updatedon
				, COALESCE(u.fullname, i.updatedby) as updatedby
				, u.email
				, i.modifieddata 
				FROM ' || quote_ident(v_tablename) || ' i
				LEFT JOIN userprofile u on u.securityusersid = i.updatedby 
				WHERE i.rowtype = ''HISTORY'' and  i.' || quote_ident(v_column) || '::character varying = $1
                and i.personimmunizationid = ''' || $4 || '''
				ORDER BY i.updatedon DESC
				OFFSET ' || v_pageoffset || ' LIMIT ' || pagesize || '
			) e ' INTO l_data
			USING objectid;

 RETURN l_data;

END;

$function$;