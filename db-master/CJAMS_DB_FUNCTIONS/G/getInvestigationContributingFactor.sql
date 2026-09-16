DROP FUNCTION if exists getInvestigationContributingFactor(uuid);
CREATE OR REPLACE FUNCTION cjams.getInvestigationContributingFactor(v_personid uuid)
 RETURNS TABLE(labeltext Text , value integer)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 07/22/2025 - To get investigation finding contributing value - (CIDM-10473) - Naveenkumar Chemutu
------------------------------------------------------------------------------------------------------------ 
 begin
	 RETURN QUERY

	
	SELECT  'ischildfatality' as labeltext,
	CASE
		WHEN MIN(ia.ischildfatality) = 1 THEN 1
		WHEN MIN(ia.ischildfatality) = 0 THEN 0
		WHEN MIN(ia.ischildfatality) = 2 THEN 2
		ELSE NULL
		END AS Value

	FROM intakeservicerequestactor acr
	JOIN actor ac
	ON ac.actorid = acr.actorid AND ac.intakeserviceid = acr.intakeserviceid AND ac.activeflag = 1
	JOIN intakeservicerequest isr
	ON isr.intakeserviceid = ac.intakeserviceid AND isr.activeflag = 1 AND coalesce(isr.actiontype, '') IN ('IR', 'AR') AND isr.servicerequestnumber is not null
	JOIN investigation iv
	ON iv.intakeserviceid = isr.intakeserviceid AND iv.activeflag = 1
	JOIN investigationallegation ia
	ON ia.investigationid = iv.investigationid AND ia.activeflag = 1
	JOIN allegation alg
	ON alg.allegationid = ia.allegationid AND alg.activeflag = 1
	LEFT JOIN investigationfinding inf
	ON inf.investigationallegationid = ia.investigationallegationid AND inf.activeflag = 1
	JOIN investigationmaltreatmentactor ima
	ON ima.maltreatmentid = ia.maltreatmentid AND ima.activeflag = 1
	JOIN intakeservicerequestactor acr_vic
	ON acr_vic.intakeservicerequestactorid = ima.intakeservicerequestactorid AND acr_vic.activeflag = 1
	LEFT JOIN investigationmaltreatment imt
	ON imt.maltreatmentid = ima.maltreatmentid AND imt.activeflag = 1 AND coalesce(imt.isnotapplicable, 0) <> 1
	JOIN investigationallegationmaltreators im
	ON im.investigationallegationid = ia.investigationallegationid AND im.activeflag = 1
	JOIN intakeservicerequestactor acr_malt
	ON acr_malt.intakeservicerequestactorid = im.intakeservicerequestactorid AND acr_malt.activeflag = 1
	WHERE acr.personid = v_personid
	AND acr.intakeservicerequestpersontypekey = 'AV'
	AND acr.activeflag = 1;

end;

$function$
;


