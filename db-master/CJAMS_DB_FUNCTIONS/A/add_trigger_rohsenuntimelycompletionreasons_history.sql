DROP FUNCTION IF EXISTS cjams.add_trigger_rohsenuntimelycompletionreasons_history();

CREATE OR REPLACE FUNCTION cjams.add_trigger_rohsenuntimelycompletionreasons_history()
RETURNS trigger AS $$

DECLARE
	modifieddata_v jsonb;	
 
BEGIN
	
	IF(new.rohsenuntimelycompletionreasonid is not null) THEN

	 	IF(TG_OP = 'INSERT' or  TG_OP = 'UPDATE') THEN 
	      INSERT INTO rohsenuntimelycompletionreasons_history
		      SELECT gen_random_uuid ()
		      		, 'HISTORY'::character varying
	                , *
		      FROM rohsenuntimelycompletionreasons 
		      WHERE rohsenuntimelycompletionreasonid = new.rohsenuntimelycompletionreasonid;
	 	END IF;
	 
	END IF;

  RETURN null;
END;
$$
LANGUAGE 'plpgsql';
   
DROP TRIGGER IF EXISTS add_rohsenuntimelycompletionreasons_history ON cjams.rohsenuntimelycompletionreasons;
 
CREATE TRIGGER add_rohsenuntimelycompletionreasons_history
  AFTER INSERT OR UPDATE
  ON cjams.rohsenuntimelycompletionreasons
  FOR EACH ROW
EXECUTE PROCEDURE cjams.add_trigger_rohsenuntimelycompletionreasons_history();