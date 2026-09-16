DROP TRIGGER IF EXISTS add_or_update_personeducation_history ON cjams.personeducation;
-- DROP FUNCTION IF EXISTS cjams.add_trigger_personeducation_history();
CREATE OR REPLACE FUNCTION cjams.add_trigger_personeducation_history()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

---------------------------------------
-- CIDM-8548 PersonEducation History
---------------------------------------
DECLARE
 
BEGIN
	 	IF(TG_OP = 'INSERT' or TG_OP = 'UPDATE') THEN 
	      INSERT INTO personeducation_history 
		      SELECT gen_random_uuid ()
		      		, ('{"status": ' || case when TG_OP = 'INSERT' then '"Inserted"' else '"Updated"' end || '}')::json 
		      		, 'HISTORY'::character varying
	                , *
		      FROM personeducation 
		      WHERE personeducationid = new.personeducationid;
	 
	END IF;

  RETURN null;
END;
$function$
;
create
    trigger add_or_update_personeducation_history after insert
        or update
            on
            cjams.personeducation for each row execute function add_trigger_personeducation_history();