DROP FUNCTION IF EXISTS cjams.handlemaltreators1080forma(data json, form_id uuid, user_id uuid);
CREATE OR REPLACE FUNCTION cjams.handlemaltreators1080forma(data json, form_id uuid, user_id uuid)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
  item json;
  ids_in_payload uuid[] := '{}';
  person_id uuid;
  cjamspid_val text;
  maltreatorsProcessedDaDetails1080forma_result text;
BEGIN
  FOR item IN SELECT * FROM json_array_elements(data)
  LOOP
    person_id := NULLIF(trim(item ->> 'personid'), '')::uuid;
    cjamspid_val := NULLIF(trim(item ->> 'cjamspid1'), '');

    IF person_id IS NULL OR cjamspid_val IS NULL THEN
      CONTINUE;
    END IF;

    ids_in_payload := array_append(ids_in_payload, person_id);

    IF EXISTS (
      SELECT 1
      FROM cjams.parentmaltreator1080forma
      WHERE form1080aid = form_id AND personid = person_id
    ) THEN
      UPDATE cjams.parentmaltreator1080forma
      SET
        fullname = item ->> 'allegedmaltreatorname',
        cjamspid = item ->> 'cjamspid1',
        aliases = item ->> 'aliases',
        dob = (item ->> 'dob1')::date,
        relationshiptovictim = item ->> 'relationshiptovictim',
        anychildwelfarehistoryinvolvingthisperson = (item ->> 'anychildwelfarehistoryinvolvingthisperson')::boolean,
        iscasehead = (item ->> 'parentrole')::boolean,
        isallegedmaltreator = (item ->> 'parentrole1')::boolean,
        isthisalsothecasehead = (item ->> 'isthisalsothecasehead')::boolean,
        activeflag = 1,
        isMaltreator = 1,
        updatedby = user_id,
        updatedon = now()
      WHERE form1080aid = form_id AND personid = person_id;
    ELSE
      INSERT INTO cjams.parentmaltreator1080forma (
        form1080aid, personid, fullname, cjamspid, aliases, dob,
        relationshiptovictim, anychildwelfarehistoryinvolvingthisperson,
         iscasehead, isallegedmaltreator,isthisalsothecasehead,
        activeflag, insertedby, insertedon, updatedby, updatedon, isMaltreator
      ) VALUES (
        form_id, person_id, item ->> 'allegedmaltreatorname', cjamspid_val,
        item ->> 'aliases', (item ->> 'dob1')::date,
        item ->> 'relationshiptovictim',
        (item ->> 'anychildwelfarehistoryinvolvingthisperson')::boolean,
        (item ->> 'parentrole')::boolean,
        (item ->> 'parentrole1')::boolean,
        (item ->> 'isthisalsothecasehead')::boolean,
        1, user_id, now(), user_id, now(), 1
      );
    END IF;

    IF item ->> 'processedDaDetails' IS NOT NULL THEN
      maltreatorsProcessedDaDetails1080forma_result := cjams.handleMaltreatorsProcessedDaDetails1080forma((item ->> 'processedDaDetails')::json, form_id, person_id, user_id, 'maltreators');
     
      IF maltreatorsProcessedDaDetails1080forma_result = 'Success' THEN
        -- Execute the main function's logic when success
        RAISE NOTICE 'maltreatorsProcessedDaDetails1080forma function succeeded. Proceeding with main operations.';
      ELSE
        RAISE exception 'MaltreatorsProcessedDaDetails1080forma_maltr function failed. Aborting main function.';
      END IF;
    END IF;
  END LOOP;

  -- Deactivate removed records
  UPDATE cjams.parentmaltreator1080forma
  SET activeflag = 0, updatedby = user_id, updatedon = now()
  WHERE form1080aid = form_id AND isMaltreator = 1
  AND (personid IS NULL OR personid NOT IN (SELECT unnest(ids_in_payload)));
END;
$$;