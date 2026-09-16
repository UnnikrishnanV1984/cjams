DROP FUNCTION IF EXISTS cjams.gethealthpassportcalendardata(uuid, varchar, uuid);

DROP FUNCTION IF EXISTS cjams.gethealthpassportcalendardata(varchar, varchar, varchar, varchar, varchar, varchar, varchar, varchar);

CREATE OR REPLACE FUNCTION cjams.gethealthpassportcalendardata(p_personid character varying DEFAULT NULL::character varying, p_securityuserid character varying DEFAULT NULL::character varying, p_servicecaseid character varying DEFAULT NULL::character varying, p_intakeserviceid character varying DEFAULT NULL::character varying, p_datatype character varying DEFAULT NULL::character varying, p_eventdate character varying DEFAULT NULL::character varying, p_eventtitle character varying DEFAULT NULL::character varying, p_attendees character varying DEFAULT NULL::character varying)
 RETURNS jsonb
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_result jsonb := '[]'::jsonb;
    --------------------------------------------------------------------------
-- Function: gethealthpassportcalendardata
-- Description: 
-- This function retrieves health passport calendar events as JSON. 
-- It filters events by person ID, object ID, and security user ID if provided.

-- Revision(s)
-- CIDM-10298 Charan sai - gethealthpassportcalendardata function added 
-- CIDM-10298 Umasankar Raavi -Added fields 'other' and 'isinperson' to the JSON result set
-- CIDM-11294 Umasankar Raavi - Updated function with new filter changes
---------------------------------------------------------------------------
BEGIN

    SELECT COALESCE(
        jsonb_agg(
            jsonb_build_object(
                'calendardetailsid', hpc.calendardetailsid,
                'securityusersid', hpc.securityusersid,
                'casenumber', hpc.casenumber,
                'personid', hpc.personid,
                'objectid', hpc.objectid,
                'objecttype', hpc.objecttype,
                'eventtimstamp', to_char(hpc.eventtimstamp::timestamp, 'YYYY-MM-DD"T"HH24:MI:SS'),
                'insertedby', hpc.insertedby,
                'title', hpc.title,
                'appointmenttype', hpc.appointmenttype,
                'appointmentdate', to_char(hpc.appointmentdate::timestamp, 'YYYY-MM-DD"T"HH24:MI:SS'),
                'starttime', hpc.starttime,
                'endtime', hpc.endtime,
                'address', hpc.address,
                'attendees', hpc.attendees,
                'locationtype', hpc.locationtype,
                'appointmentdetails', hpc.appointmentdetails,
                'insertedon', to_char(hpc.insertedon::timestamp, 'YYYY-MM-DD"T"HH24:MI:SS'),
                'updatedby', hpc.updatedby,
                'updatedon', to_char(hpc.updatedon::timestamp, 'YYYY-MM-DD"T"HH24:MI:SS'),
                'activeflag', hpc.activeflag,
                'other', hpc.other,
                'isinperson', hpc.isinperson,
                'eventdate', to_char(hpc.appointmentdate::timestamp, 'YYYY-MM-DD"T"HH24:MI:SS'),
                'eventtitle', hpc.title
            )
            ORDER BY hpc.appointmentdate, hpc.starttime
        ),
        '[]'::jsonb
    )
    INTO v_result
    FROM cjams.calendardetails hpc
    WHERE hpc.activeflag = 1

    AND (
        p_securityuserid IS NULL
        OR hpc.securityusersid::varchar = p_securityuserid
    )

    AND (
        p_personid IS NULL
        OR hpc.personid::varchar = p_personid
    )

    AND (
        p_servicecaseid IS NULL
        OR (
            lower(hpc.objecttype) = 'servicecase'
            AND hpc.objectid::varchar = p_servicecaseid
        )
    )

    AND (
        p_intakeserviceid IS NULL
        OR (
            lower(hpc.objecttype) = 'servicerequest'
            AND hpc.objectid::varchar = p_intakeserviceid
        )
    )

    AND (
        p_datatype IS NULL
        OR lower(p_datatype) = 'all'
        OR lower(p_datatype) = 'manual'
        OR lower(coalesce(hpc.appointmenttype, '')) = lower(p_datatype)
        OR lower(coalesce(hpc.objecttype, '')) = lower(p_datatype)
    )

    AND (
        p_eventdate IS NULL
        OR to_char(hpc.appointmentdate::date, 'YYYY-MM-DD') = p_eventdate
    )

    AND (
        p_eventtitle IS NULL
        OR coalesce(hpc.title, '') ILIKE '%' || p_eventtitle || '%'
    )

    AND (
        p_attendees IS NULL
        OR hpc.attendees::text ILIKE '%' || p_attendees || '%'
    );

    RETURN v_result;

END;
$function$
;