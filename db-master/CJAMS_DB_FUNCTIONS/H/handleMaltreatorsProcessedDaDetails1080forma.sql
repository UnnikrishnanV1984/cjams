DROP FUNCTION IF EXISTS cjams.handleMaltreatorsProcessedDaDetails1080forma(data json, form_id uuid, person_id uuid, user_id uuid, v_type varchar);
CREATE OR REPLACE FUNCTION cjams.handleMaltreatorsProcessedDaDetails1080forma(data json, form_id uuid, person_id uuid, user_id uuid, v_type varchar)
RETURNS text
LANGUAGE plpgsql
AS $$
DECLARE
  item json;
  ids_in_payload uuid[] := '{}';
  case_number text;
  error_message text;
BEGIN
  FOR item IN SELECT * FROM json_array_elements(data)
  LOOP

    ids_in_payload := array_append(ids_in_payload, person_id);
    case_number := NULLIF(trim(item ->> 'casenumber'), '');

    IF EXISTS (
      SELECT 1
      FROM cjams.listMaltreatorsClearanceHistory1080forma
      WHERE form1080aid = form_id AND personid = person_id and persontype = v_type and casenumber = case_number
    ) THEN
      UPDATE cjams.listMaltreatorsClearanceHistory1080forma
      SET
        casenumber = item->>'casenumber',
        intakedate = (item->>'intakedate')::date,
        programarea = item->>'programarea',
        subprogramarea = item->>'subprogramarea',
        personrole = item->>'role',
        persontype = v_type,
        activeflag = 1,
        updatedby = user_id,
        updatedon = now()
      WHERE form1080aid = form_id AND personid = person_id  and persontype = v_type and casenumber = case_number;
    ELSE
      INSERT INTO cjams.listMaltreatorsClearanceHistory1080forma (
        form1080aid, personid, casenumber, intakedate, programarea, subprogramarea, personrole, persontype,
        activeflag, insertedby, insertedon, updatedby, updatedon
      ) VALUES (
        form_id, person_id, 
        item->>'casenumber',
        (item->>'intakedate')::date,
        item->>'programarea',
        item->>'subprogramarea',
        item->>'role',
        v_type,
        1, user_id, now(), user_id, now()
      );
    END IF;
    
  END LOOP;
  RETURN 'Success';

	EXCEPTION WHEN OTHERS THEN
		error_message := SQLERRM;
        RETURN 'Failure: ' || error_message;

END;
$$;