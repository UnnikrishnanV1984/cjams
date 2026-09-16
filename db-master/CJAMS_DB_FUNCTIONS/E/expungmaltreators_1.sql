DROP FUNCTION IF EXISTS cjams.expungmaltreators();

CREATE OR REPLACE FUNCTION cjams.expungmaltreators(
	)
RETURNS TABLE(status character varying) 
    LANGUAGE 'plpgsql'
    VOLATILE 
    COST 100
    ROWS 1000
AS $BODY$
	DECLARE v_brundate DATE;
	DECLARE v_bstatus character varying;
	DECLARE v_starttime timestamp;
BEGIN

	DROP TABLE IF EXISTS tmp_batchtorun;
	CREATE TEMP TABLE tmp_batchtorun (batchrundate date, status character varying);
	INSERT INTO tmp_batchtorun (batchrundate, status)
	SELECT generate_series(
			COALESCE((SELECT MAX(rundate) + INTERVAL '1 day' lastrundate FROM expungementstatus WHERE jobid = 2), NOW()::DATE), 
			NOW()::DATE, 
			'1 day'), 'pending'; 
		
	FOR v_brundate, v_bstatus IN SELECT * FROM tmp_batchtorun
		LOOP
			v_starttime := NOW();
			RAISE NOTICE '%', v_brundate;
			PERFORM expungmaltreators(v_brundate);
			UPDATE tmp_batchtorun SET status = 'SUCCESS' WHERE batchrundate = v_brundate;
			INSERT INTO expungementstatus (jobid, rundate, status, starttime, endtime, expungmaltreatment, expunginvestigation, expungperson) 
				VALUES (2, v_brundate, 'SUCCESS', v_starttime, NOW()
						, (SELECT JSON_AGG(T) FROM (SELECT * FROM  tmp_expungmaltreators) T) 
						, (SELECT JSON_AGG(T) FROM (SELECT * FROM  tmp_expunginvestigation) T)
						, (SELECT JSON_AGG(T) FROM (SELECT * FROM tmp_expungperson ) T)	
				);

		END LOOP;

END

$BODY$;

