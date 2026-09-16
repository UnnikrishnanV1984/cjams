CREATE OR REPLACE FUNCTION cjams.permanencygapvalidation(v_intakeservicerequestactorid uuid, v_intakeserviceid uuid)
 RETURNS SETOF integer
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- Revisions:
-- Vineet Tirodkar - 05/04/2021 - Modifications for New Provider Category 3794 - Residential Treatment Center (B-102022)
------------------------------------------------------------------------------------------------
BEGIN

RETURN QUERY  
SELECT
	(CASE WHEN tbp.provider_category_cd = '3274' THEN 
		0 
	WHEN tbp.provider_category_cd = '3794' THEN 
		0
	ELSE 
		1 
	END ) AS iseligible
FROM tb_placement pl
INNER JOIN tb_provider tbp ON tbp.provider_id=pl.provider_id AND pl.intakeservicerequestactorid=v_intakeservicerequestactorid
INNER JOIN intakeservicerequest isr ON isr.servicerequestnumber=pl.case_id :: character varying AND isr.intakeserviceid=v_intakeserviceid
LIMIT 1;

END;

$function$
;
