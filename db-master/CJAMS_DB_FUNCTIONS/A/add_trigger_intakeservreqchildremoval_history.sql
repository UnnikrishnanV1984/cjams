CREATE OR REPLACE FUNCTION cjams.add_trigger_intakeservreqchildremoval_history()
RETURNS trigger AS $$

DECLARE
	modifieddata_v jsonb;	
 
BEGIN
	
	IF(new.actualdata is not null) THEN

		IF TG_OP = 'UPDATE' then
			SELECT * INTO modifieddata_v FROM get_audittrail_field_difference(new.actualdata, old.actualdata, 'childremoval');
	 	ELSE 
			SELECT * INTO modifieddata_v FROM get_audittrail_field_difference(new.actualdata, null, 'childremoval');
		END IF;

	 	IF(TG_OP = 'INSERT' or (jsonb_array_length(modifieddata_v) > 0 and TG_OP = 'UPDATE')) THEN 
	      INSERT INTO intakeservreqchildremoval_history 
		      SELECT gen_random_uuid ()
		      		, ('{"status": ' || case when TG_OP = 'INSERT' then '"Inserted"' else '"Updated"' end || ', "data": ' || modifieddata_v || '}')::json 
		      		, 'HISTORY'::character varying
	                , *
		      FROM intakeservreqchildremoval 
		      WHERE intakeservreqchildremovalid = new.intakeservreqchildremovalid;
	 	END IF;
	 
	END IF;

  RETURN null;
END;
$$
LANGUAGE 'plpgsql';
   
DROP TRIGGER IF EXISTS add_childremoval_history ON cjams.intakeservreqchildremoval;
 
CREATE TRIGGER add_childremoval_history
  AFTER INSERT OR UPDATE
  ON cjams.intakeservreqchildremoval
  FOR EACH ROW
EXECUTE PROCEDURE cjams.add_trigger_intakeservreqchildremoval_history();
