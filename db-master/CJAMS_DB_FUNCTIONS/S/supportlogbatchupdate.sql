DROP FUNCTION IF EXISTS cjams.supportlogbatchupdate(uuid, character varying, character varying, character varying,character varying);
CREATE OR REPLACE FUNCTION cjams.supportlogbatchupdate(i_supportlogid uuid, i_status character varying, i_resolution character varying, i_focusarea character varying, i_cdmticketno character varying)
 RETURNS CHARACTER VARYING
 LANGUAGE plpgsql
AS $function$

DECLARE
	
BEGIN
	IF (i_status IS NOT NULL OR i_resolution IS NOT NULL 
		OR i_focusarea IS NOT NULL OR i_cdmticketno IS NOT NULL) THEN

		IF EXISTS (SELECT * FROM defecttracking.supportlog
					WHERE supportlogid=i_supportlogid
						AND ((i_status IS NOT NULL AND status != i_status)
							OR (status IS NULL AND i_status IS NOT NULL)
							OR (i_resolution IS NOT NULL AND jiraticketresolution != i_resolution)
							OR (jiraticketresolution IS NULL AND i_resolution IS NOT NULL)
							OR (i_focusarea IS NOT NULL AND focus != i_focusarea)
							OR (focus IS NULL AND i_focusarea IS NOT NULL)
							OR (cdmticketno IS NULL AND i_cdmticketno IS NOT NULL)
							OR (i_cdmticketno IS NOT NULL AND cdmticketno != i_cdmticketno))) THEN
			UPDATE defecttracking.supportlog 
				SET status = COALESCE(i_status, status),
					jiraticketresolution = COALESCE(i_resolution, jiraticketresolution), 
					focus = i_focusarea,
					cdmticketno = COALESCE(i_cdmticketno, cdmticketno),
					updatedon = now(), 
					updatedby = 'batch_run'  
				WHERE supportlogid=i_supportlogid; 
		END IF;
	END IF;
		
	RETURN 'Success';
			
END;

$function$
;
