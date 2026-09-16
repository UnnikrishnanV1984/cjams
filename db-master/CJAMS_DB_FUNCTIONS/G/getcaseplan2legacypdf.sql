DROP FUNCTION cjams.getcaseplan2legacypdf(v_caseid uuid, v_caseplan2id uuid);

CREATE OR REPLACE FUNCTION cjams.getcaseplan2legacypdf(v_caseid uuid, v_caseplan2id uuid)
 RETURNS  table (reportdata text  )
 LANGUAGE plpgsql
AS $function$

BEGIN
	RETURN QUERY   
	SELECT	encode((convert(report_blob , 'latin-1', 'utf-8')::bytea ),'escape' )::text reportdata 
	FROM 	tb_saved_reports sv
			INNER JOIN caseplan2 cp2 ON cp2.OLD_ID = sv.entity_link AND cp2.activeflag =1  
	WHERE 	 cp2.caseplan2id = v_caseplan2id ;
  					
END;
$function$
;
