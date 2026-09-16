DROP FUNCTION IF EXISTS convertRemovalCodeFromPlacToChldRmvl(CHARACTER VARYING);

CREATE OR REPLACE FUNCTION cjams.convertRemovalCodeFromPlacToChldRmvl(v_plCode CHARACTER VARYING)
RETURNS CHARACTER VARYING
LANGUAGE plpgsql
AS $function$ 
DECLARE
v_rmvlCode CHARACTER VARYING;

BEGIN

SELECT 
(CASE WHEN v_plCode ='PLCCAD' THEN 'ADPDIS'
        WHEN v_plCode = 'PLCCAF' THEN 'ADPFIN'
        WHEN v_plCode = 'PLCCCORH' THEN 'CORHADR'
        WHEN v_plCode = 'PLCCGNR' THEN 'CGUARDNR'
        WHEN v_plCode = 'PLCCGR' THEN 'CGUARDREL'
        WHEN v_plCode = 'PLCCCNR' THEN 'CUSNONR'
        WHEN v_plCode = 'PLCCDOC' THEN 'DEATHOC'
        WHEN v_plCode = 'PLCCE' THEN 'EMANIND'
        WHEN v_plCode = 'PLCCGSNR' THEN 'GNONREL'
        WHEN v_plCode = 'PLCCMRG' THEN 'EMANMAR'
        WHEN v_plCode = 'PLCCM' THEN 'EMANMIL'
        WHEN v_plCode = 'PLCCRS' THEN 'REFSERV'
        WHEN v_plCode = 'PLCCR' THEN 'REUNIF'
        WHEN v_plCode = 'PLCCRA' THEN 'RNAWAY'
        WHEN v_plCode = 'PLCCTTO' THEN 'TTONDA'
        WHEN v_plCode = 'TTONDA' THEN 'TTONDA'
ELSE
    v_plCode
END) INTO v_rmvlCode;

RETURN v_rmvlCode;

END;

 $function$;;
