CREATE OR REPLACE FUNCTION cjams.getexpungementreviewstatus(
	v_intakeserviceid uuid)
RETURNS TABLE(investigationfindingid uuid, status text)
 LANGUAGE plpgsql 
AS $function$ 
DECLARE
    v_isexpunged integer;
BEGIN
    SELECT iscaseexpunged
      INTO v_isexpunged
      FROM iscaseexpunged('Case', v_intakeserviceid::character varying);

    -- FULLY EXPUNGED (ENCR)
    IF v_isexpunged = 1 THEN
        RETURN QUERY
        SELECT
            invf.investigationfindingid,
            (
                SELECT rst.typedescription
                FROM expungement expg
                INNER JOIN routing r
                    ON r.objectid = expg.expungementid::character varying
                   AND r.activeflag = 1
                INNER JOIN routingstatustype rst
                    ON rst.sequencenumber = r.routingstatustypeid
                   AND rst.activeflag = 1
                WHERE expg.investigationfindingid = invf.investigationfindingid
                  AND expg.activeflag = 1
                ORDER BY expg.insertedon DESC, r.insertedon DESC
                LIMIT 1
            ) AS status
        FROM expunge.investigation_expunge inv
        INNER JOIN expunge.investigationallegation_expunge inva
            ON inva.investigationid = inv.investigationid
           AND inva.activeflag = 1
        INNER JOIN expunge.investigationfinding_expunge invf
            ON invf.investigationallegationid = inva.investigationallegationid
           AND invf.activeflag = 1
        WHERE inv.intakeserviceid = v_intakeserviceid
          AND inv.activeflag = 1;

    -- PARTIAL EXPUNGED (UNION ENCR + NORMAL for investigationallegation & investigationfinding only)
    ELSIF v_isexpunged = 2 THEN
RETURN QUERY 
SELECT invf.investigationfindingid, 
    (SELECT rst.typedescription as status 
     FROM expungement expg
     INNER JOIN routing r 
         ON r.objectid = expg.expungementid :: character varying 
        AND r.activeflag = 1
     INNER JOIN routingstatustype rst 
         ON rst.sequencenumber = r.routingstatustypeid  
        AND rst.activeflag = 1
     WHERE expg.investigationfindingid = invf.investigationfindingid 
       AND expg.activeflag = 1
     ORDER BY expg.insertedon DESC, r.insertedon DESC 
     LIMIT 1) 
FROM investigation inv
INNER JOIN (
    SELECT inva.investigationallegationid, inva.investigationid
    FROM expunge.investigationallegation_expunge inva
    WHERE inva.activeflag = 1

    UNION ALL

    SELECT inva.investigationallegationid, inva.investigationid
    FROM investigationallegation inva
    WHERE inva.activeflag = 1
) inva 
    ON inva.investigationid = inv.investigationid
INNER JOIN (
    SELECT invf.investigationfindingid, invf.investigationallegationid
    FROM expunge.investigationfinding_expunge invf
    WHERE invf.activeflag = 1

    UNION ALL

    SELECT invf.investigationfindingid, invf.investigationallegationid
    FROM investigationfinding invf
    WHERE invf.activeflag = 1
) invf 
    ON invf.investigationallegationid = inva.investigationallegationid
WHERE inv.intakeserviceid = v_intakeserviceid
  AND inv.activeflag = 1;


    -- NORMAL (NO EXPUNGEMENT) - NORMAL TABLES
    ELSE
 
	RETURN  QUERY 
		SELECT invf.investigationfindingid, 
			(SELECT rst.typedescription as status FROM expungement expg
			INNER JOIN routing r ON r.objectid = expg.expungementid :: character VARYING AND r.activeflag = 1
			INNER JOIN routingstatustype rst ON rst.sequencenumber = r.routingstatustypeid  AND rst.activeflag = 1
			WHERE expg.investigationfindingid = invf.investigationfindingid AND expg.activeflag = 1
			ORDER BY expg.insertedon DESC, r.insertedon DESC LIMIT 1) 
		FROM investigation inv
		INNER JOIN investigationallegation inva ON inva.investigationid = inv.investigationid AND inv.activeflag = 1
		INNER JOIN investigationfinding invf ON invf.investigationallegationid = inva.investigationallegationid AND inva.activeflag = 1 AND invf.activeflag = 1
		WHERE inv.intakeserviceid = v_intakeserviceid;
    END IF;

END;
	
$function$