DROP FUNCTION IF EXISTS cjams.handleparents1080forma(data json, form_id uuid, user_id uuid);
CREATE OR REPLACE FUNCTION cjams.handleparents1080forma(data json, form_id uuid, user_id uuid)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
  item json;
  ids_in_payload uuid[] := '{}';
  person_id uuid;
  maltreatorsProcessedDaDetails1080forma_result text;
BEGIN
  FOR item IN SELECT * FROM json_array_elements(data)
  LOOP
    person_id := (item ->> 'personid')::uuid;
    ids_in_payload := array_append(ids_in_payload, person_id);

    IF EXISTS (
      SELECT 1 FROM cjams.parentmaltreator1080forma
      WHERE form1080aid = form_id AND personid = person_id
    ) THEN
      UPDATE cjams.parentmaltreator1080forma
      SET
        fullname = item ->> 'parentname',
        cjamspid = item ->> 'cjamspid2',
        aliases = item ->> 'aliases1',
        dob = (item ->> 'dob2')::date,
        relationshiptovictim = item ->> 'relationshiptovictim1',      
        anychildwelfarehistoryinvolvingthisperson = (item ->> 'anychildwelfarehistoryinvolvingthisperson1')::boolean,
        iscasehead = (item ->> 'parentrole')::boolean,
        isallegedmaltreator = (item ->> 'parentrole1')::boolean,
        isParent = 1,
        activeflag = 1,
        updatedby = user_id,
        updatedon = now()
      WHERE form1080aid = form_id AND personid = person_id;
    ELSE
      INSERT INTO cjams.parentmaltreator1080forma (
        form1080aid, personid, fullname, cjamspid,
        aliases, dob, relationshiptovictim,
        anychildwelfarehistoryinvolvingthisperson,
        iscasehead, isallegedmaltreator,
        isParent, activeflag,
        insertedby, insertedon, updatedby, updatedon
      ) VALUES (
        form_id, person_id, item ->> 'parentname', item ->> 'cjamspid2',
        item ->> 'aliases1',
        (item ->> 'dob2')::date,
        item ->> 'relationshiptovictim1',
        (item ->> 'anychildwelfarehistoryinvolvingthisperson1')::boolean,
        (item ->> 'parentrole')::boolean,
        (item ->> 'parentrole1')::boolean,
        1, 1, user_id, now(), user_id, now()
      );
    END IF;

     IF item ->> 'processedDaDetails' IS NOT NULL THEN
       maltreatorsProcessedDaDetails1080forma_result := cjams.handleMaltreatorsProcessedDaDetails1080forma((item ->> 'processedDaDetails')::json, form_id, person_id, user_id, 'parents');

      IF maltreatorsProcessedDaDetails1080forma_result = 'Success' THEN
        -- Execute the main function's logic when success
        RAISE NOTICE 'maltreatorsProcessedDaDetails1080forma function succeeded. Proceeding with main operations.';
      ELSE
        RAISE EXCEPTION 'MaltreatorsProcessedDaDetails1080forma function failed. Aborting main function.';
      END IF;
    END IF;
  END LOOP;

  -- Deactivate missing
  UPDATE cjams.parentmaltreator1080forma
  SET activeflag = 0, updatedby = user_id, updatedon = now()
  WHERE form1080aid = form_id AND isParent = 1 AND (personid IS NULL OR personid NOT IN (SELECT unnest(ids_in_payload)));
END;
$$;
