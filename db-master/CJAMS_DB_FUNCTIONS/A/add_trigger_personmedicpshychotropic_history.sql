CREATE OR REPLACE FUNCTION cjams.add_trigger_personmedicpshychotropic_history()
RETURNS trigger AS $$

DECLARE
	modifieddata_v jsonb;	
 
BEGIN
	
	IF(new.personmedicpshychotropicid is not null) THEN

	 	IF(TG_OP = 'INSERT' or  TG_OP = 'UPDATE') THEN 
	      INSERT INTO personmedicpshychotropic_history 
		      SELECT gen_random_uuid ()
		      		, 'HISTORY'::character varying
	                , *
		      FROM personmedicpshychotropic 
		      WHERE personmedicpshychotropicid = new.personmedicpshychotropicid;
	 	END IF;
	 
	END IF;

  RETURN null;
END;
$$
LANGUAGE 'plpgsql';
   
DROP TRIGGER IF EXISTS add_personmedicpshychotropic_history ON cjams.personmedicpshychotropic;
 
CREATE TRIGGER add_personmedicpshychotropic_history
  AFTER INSERT OR UPDATE
  ON cjams.personmedicpshychotropic
  FOR EACH ROW
EXECUTE PROCEDURE cjams.add_trigger_personmedicpshychotropic_history();

