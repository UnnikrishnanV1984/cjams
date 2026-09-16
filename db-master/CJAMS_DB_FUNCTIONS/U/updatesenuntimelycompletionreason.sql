DROP FUNCTION IF EXISTS cjams.updatesenuntimelycompletionreason(json);
DROP FUNCTION IF EXISTS cjams.updatesenuntimelycompletionreason(json, character varying);
CREATE OR REPLACE FUNCTION cjams.updatesenuntimelycompletionreason(v_data json, v_userid character varying)
RETURNS text
LANGUAGE plpgsql
AS $function$
DECLARE
    rec json;

    v_servicecaseid uuid;
    v_personid uuid;
    v_rohsenuntimelycompletionreasonid uuid;
    v_f2fcontactuntimelydonereason varchar;
    v_otherf2fcomments text;
    v_safecuntimelydonereason varchar;
    v_othersafeccomments text;
    v_mfirauntimelydonereason varchar;
    v_othermfiracomments text;
BEGIN
    FOR rec IN
        SELECT * FROM json_array_elements(v_data)
    LOOP
        v_servicecaseid := rec ->> 'servicecaseid';
        v_personid := rec ->> 'personid';
        v_f2fcontactuntimelydonereason := rec ->> 'f2fcontactuntimelydonereason';
        v_otherf2fcomments := rec ->> 'otherf2fcomments';
        v_safecuntimelydonereason := rec ->> 'safecuntimelydonereason';
        v_othersafeccomments := rec ->> 'othersafeccomments';
        v_mfirauntimelydonereason := rec ->> 'mfirauntimelydonereason';
        v_othermfiracomments := rec ->> 'othermfiracomments';

        SELECT rohsenuntimelycompletionreasonid
        INTO v_rohsenuntimelycompletionreasonid
        FROM cjams.rohsenuntimelycompletionreasons
        WHERE servicecaseid = v_servicecaseid
          AND personid = v_personid
          AND activeflag = 1;

        IF v_rohsenuntimelycompletionreasonid IS NOT NULL THEN
            
            UPDATE cjams.rohsenuntimelycompletionreasons
            SET
                updatedby = v_userid,
                updatedon = now(),
                f2fcontactuntimelydonereason = v_f2fcontactuntimelydonereason,
                otherf2fcomments = v_otherf2fcomments,
                safecuntimelydonereason = v_safecuntimelydonereason,
                othersafeccomments = v_othersafeccomments,
                mfirauntimelydonereason = v_mfirauntimelydonereason,
                othermfiracomments = v_othermfiracomments
            WHERE rohsenuntimelycompletionreasonid = v_rohsenuntimelycompletionreasonid;
        END IF;
    END LOOP;

    RETURN 'Success';
    
    EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Internal error: %', SQLERRM;
        RAISE EXCEPTION 'Unable to process untimely completion reason. Please try again later.';

END;
$function$;
