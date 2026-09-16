DROP TRIGGER IF EXISTS add_permanencyplan_history ON cjams.permanencyplan;
-- DROP FUNCTION IF EXISTS cjams.add_trigger_permanencyplan_history();

CREATE OR REPLACE FUNCTION cjams.add_trigger_permanencyplan_history()
RETURNS trigger AS $$

---------------------------------------
-- CDM-34552 Permaneny plan exist issue fix
---------------------------------------

DECLARE
	modifieddata_v jsonb;	
 
BEGIN
	
	IF(new.actualdata is not null) THEN

		IF (TG_OP = 'UPDATE' and old.actualdata is not null) then
			SELECT * INTO modifieddata_v FROM get_audittrail_field_difference(new.actualdata, old.actualdata, 'permanencyplan');
	 	ELSE 
			SELECT * INTO modifieddata_v FROM get_audittrail_field_difference(new.actualdata, null, 'permanencyplan');
		END IF;

	 	IF(TG_OP = 'INSERT' or (jsonb_array_length(modifieddata_v) > 0 and TG_OP = 'UPDATE')) THEN 
	      INSERT INTO permanencyplan_history 
		      SELECT gen_random_uuid ()
		      		, ('{"status": ' || case when TG_OP = 'INSERT' then '"Inserted"' else '"Updated"' end || ', "data": ' || modifieddata_v || '}')::json 
		      		, 'HISTORY'::character varying
	                , *
		      FROM permanencyplan 
		      WHERE permanencyplanid = new.permanencyplanid;
	 	END IF;
	 
	END IF;

  RETURN null;
END;
$$
LANGUAGE 'plpgsql';
   
DROP TRIGGER IF EXISTS add_permanencyplan_history ON cjams.permanencyplan;
-- DROP TRIGGER IF EXISTS add_childremoval_history ON cjams.permanencyplan;
 
CREATE TRIGGER add_permanencyplan_history
  AFTER INSERT OR UPDATE
  ON cjams.permanencyplan
  FOR EACH ROW
EXECUTE PROCEDURE cjams.add_trigger_permanencyplan_history();