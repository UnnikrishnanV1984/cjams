DROP FUNCTION IF EXISTS cjams.add_trigger_safecassessment_history() CASCADE;
CREATE OR REPLACE FUNCTION cjams.add_trigger_safecassessment_history()
RETURNS trigger AS $$

----------------------------------------------------------
-- CIDM-9537 - Added Trigger for Safec-ohp assessment
---------------------------------------------------------

DECLARE
	modifieddata_v jsonb;	
	l_fmrf_referral json;
	l_fmrf_familyaccess json;
	l_text_json json;
 
BEGIN
	
		IF(new.actualdata is not null and new.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418') THEN

			IF TG_OP = 'UPDATE' then
				SELECT * INTO modifieddata_v FROM get_audittrail_field_difference(new.actualdata, old.actualdata, 'safecassessment');
			ELSE 
				SELECT * INTO modifieddata_v FROM get_audittrail_field_difference(new.actualdata, null, 'safecassessment');
			END IF;
		ELSIF (new.actualdata is not null and new.assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035') THEN

			IF TG_OP = 'UPDATE' then
				SELECT * INTO modifieddata_v FROM get_audittrail_field_difference(new.actualdata, old.actualdata, 'safecohpassessment');
			ELSE 
				SELECT * INTO modifieddata_v FROM get_audittrail_field_difference(new.actualdata, null, 'safecohpassessment');
			END IF;
		ELSIF (new.actualdata is not null and new.assessmenttemplateid = '1ce7d8ae-e13f-4ed3-a074-ea203935a1aa') THEN
			IF TG_OP = 'UPDATE' then
				SELECT * INTO l_fmrf_referral FROM get_audittrail_field_difference(new.actualdata->'referralinformation', old.actualdata->'referralinformation', 'fmrfassessment');
				SELECT * INTO l_fmrf_familyaccess FROM get_audittrail_field_difference(new.actualdata->'familyAccess', old.actualdata->'familyAccess', 'fmrfassessment');
				-- SELECT * INTO l_fmrf_familyaccess FROM get_audittrail_field_difference(new.actualdata->'referralinformation'->'SubChildarray', old.actualdata, 'fmrfassessment');

				SELECT * INTO l_text_json FROM get_audittrail_field_difference(new.actualdata, old.actualdata, 'fmrfassessment');				 

			ELSE 
				SELECT * INTO l_fmrf_referral FROM get_audittrail_field_difference(new.actualdata->'referralinformation',NULL, 'fmrfassessment');
				SELECT * INTO l_fmrf_familyaccess FROM get_audittrail_field_difference(new.actualdata->'familyAccess',NULL, 'fmrfassessment');
				SELECT * INTO l_text_json FROM get_audittrail_field_difference(new.actualdata,NULL, 'fmrfassessment');		
					
			END IF;
			SELECT json_agg(t.value) INTO modifieddata_v FROM (
				SELECT t.value FROM json_array_elements(l_fmrf_referral::json) t UNION ALL 
				SELECT t.value FROM json_array_elements(l_fmrf_familyaccess::json) t UNION ALL 
				SELECT t.value FROM json_array_elements(l_text_json::json)  t 
			) t; 
 


		END IF ;

	 	IF(TG_OP = 'INSERT' or (jsonb_array_length(modifieddata_v) > 0 and TG_OP = 'UPDATE')) THEN 
	      INSERT INTO assessment_history 
		      SELECT gen_random_uuid ()
		      		, ('{"status": ' || case when TG_OP = 'INSERT' then '"Inserted"' else '"Updated"' end || ', "data": ' || modifieddata_v || '}')::json 
		      		, 'HISTORY'::character varying
	                , *
		      FROM assessment 
		      WHERE assessmentid = new.assessmentid;	 
		END IF;

  RETURN null;
END;
$$
LANGUAGE 'plpgsql';
   
DROP TRIGGER IF EXISTS add_trigger_safecassessment_history ON cjams.assessment;
 
CREATE TRIGGER add_trigger_safecassessment_history
  AFTER INSERT OR UPDATE
  ON cjams.assessment
  FOR EACH ROW
EXECUTE PROCEDURE cjams.add_trigger_safecassessment_history();