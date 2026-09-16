DROP FUNCTION IF EXISTS cjams.handlelistotherchildrenhousehold1080forma(data json, form_id uuid, user_id uuid);
CREATE OR REPLACE FUNCTION cjams.handlelistotherchildrenhousehold1080forma(data json, form_id uuid, user_id uuid)
 RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    item json;
    ids_in_payload uuid[] := '{}';
    person_id uuid;
    BEGIN
        FOR item IN SELECT * FROM json_array_elements(data)
     LOOP
        person_id := (item ->> 'personid')::uuid;
        ids_in_payload := array_append(ids_in_payload, person_id);

        IF EXISTS (
        SELECT 1 FROM cjams.listotherchildrenhousehold1080forma
        WHERE form1080aid = form_id AND personid = person_id
        ) THEN
        UPDATE cjams.listotherchildrenhousehold1080forma
        SET
        fullname = item ->> 'fullname',
        cjamspid = item ->> 'cjamspid',
         dob = (item ->> 'dob')::date,
 relationshiptovictim = item ->> 'relationshiptovictim',
        activeflag = 1,
        updatedby = user_id,
        updatedon = now()
        WHERE form1080aid = form_id AND personid = person_id;
        ELSE
        INSERT INTO cjams.listotherchildrenhousehold1080forma (
        form1080aid, personid, fullname, cjamspid, dob, relationshiptovictim,
        activeflag, insertedby, insertedon, updatedby, updatedon
        ) VALUES (
        form_id, person_id, item ->> 'fullname', item ->> 'cjamspid', (item ->> 'dob')::date, item ->> 'relationshiptovictim',
        1, user_id, now(), user_id, now()
        );
        END IF;
    END LOOP;

    UPDATE cjams.listotherchildrenhousehold1080forma
    SET activeflag = 0, updatedby = user_id, updatedon = now()
    WHERE form1080aid = form_id AND (personid IS NULL OR personid NOT IN (SELECT unnest(ids_in_payload)));

END;
$$;