DROP FUNCTION IF EXISTS cjams.gethealthappointmentdates(
    p_personid character varying,
    p_securityuserid character varying,
    p_servicecaseid character varying,
    p_intakeserviceid character varying,
    p_datatype character varying,
    p_eventdate character varying,
    p_eventtitle character varying,
    p_attendees character varying
);

CREATE OR REPLACE FUNCTION cjams.gethealthappointmentdates(
    p_personid character varying,
    p_securityuserid character varying DEFAULT NULL,
    p_servicecaseid character varying DEFAULT NULL,
    p_intakeserviceid character varying DEFAULT NULL,
    p_datatype character varying DEFAULT NULL,
    p_eventdate character varying DEFAULT NULL,
    p_eventtitle character varying DEFAULT NULL,
    p_attendees character varying DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
AS $$
DECLARE
    v_examination jsonb := '[]'::jsonb;
    v_meeting jsonb := '[]'::jsonb;
    v_hearingdetails jsonb := '[]'::jsonb;
      ------------------------------------------------------------------------------------------------------------
-- Function: gethealthappointmentdates
-- Description:
-- This function retrieves a person's scheduled health appointments in JSON format.
-- It includes appointment date, start time, end time, and the nature of the examination.
-- The function can filter by person ID and security user ID (optional).

-- Revision(s)
-- CIDM-10298 Umasankar Raavi - get_health_appointment_dates function added
-- CIDM-11294 Umasankar Raavi - Added meetings and hearing details along with examination 
------------------------------------------------------------------------------------------------------------
BEGIN

    IF p_datatype IS NULL OR lower(p_datatype) IN ('examination', 'all') THEN

        SELECT COALESCE(
                 jsonb_agg(
                   jsonb_build_object(
                     'personid', pe.personid,
                     'casenumber', pe.casenumber,
                     'fullname', trim(coalesce(p.firstname, '') || ' ' || coalesce(p.lastname, '')),
                     'apptDate', to_char(pe.appoinmentdate::timestamp, 'YYYY-MM-DD"T"HH24:MI:SS'),
                     'starttime', to_char(pe.starttime::time, 'HH24:MI:SS'),
                     'endtime', to_char(pe.endtime::time, 'HH24:MI:SS'),
                     'examinationtypekey', pe.examinationtypekey,
                     'nextappointmentdate', to_char(pe.nextappointmentdate::timestamp, 'YYYY-MM-DD"T"HH24:MI:SS'),
                     'natureofexamdesc', (
                          SELECT value_tx
                          FROM tb_picklist_values
                          WHERE trim(picklist_value_cd) = trim(pe.examinationtypekey)
                          AND picklist_type_id = 320
                          LIMIT 1
                     ),
                     'eventdate', to_char(pe.appoinmentdate::timestamp, 'YYYY-MM-DD"T"HH24:MI:SS'),
                     'eventtitle', (
                          SELECT value_tx
                          FROM tb_picklist_values
                          WHERE trim(picklist_value_cd) = trim(pe.examinationtypekey)
                          AND picklist_type_id = 320
                          LIMIT 1
                     ),
                     'attendees', '[]'::jsonb
                   )
                   ORDER BY pe.appoinmentdate, pe.starttime
                 ),
                 '[]'::jsonb
               )
          INTO v_examination
        FROM personexamination pe
        INNER JOIN person p ON p.personid = pe.personid
        WHERE pe.activeflag = 1
AND (
    (NULLIF(trim(p_personid), '') IS NOT NULL 
        AND pe.personid = NULLIF(trim(p_personid), '')::uuid)
    OR (
        NULLIF(trim(p_personid), '') IS NULL 
        AND p_securityuserid IS NOT NULL 
        AND pe.insertedby = p_securityuserid
    )
)
AND pe.examinationtypekey IN ('3257', '32926')
AND (
    (
        NULLIF(trim(p_servicecaseid), '') IS NULL
        AND NULLIF(trim(p_intakeserviceid), '') IS NULL
    )
    OR trim(pe.casenumber) = trim(
        COALESCE(
            (
                SELECT sc.servicecasenumber
                FROM cjams.servicecase sc
                WHERE sc.servicecaseid = NULLIF(trim(p_servicecaseid), '')::uuid
                LIMIT 1
            ),
            (
                SELECT isr.servicerequestnumber
                FROM cjams.intakeservicerequest isr
                WHERE isr.intakeserviceid = NULLIF(trim(p_intakeserviceid), '')::uuid
                LIMIT 1
            )
        )
    )
)
        AND (
            p_eventdate IS NULL
            OR to_char(pe.appoinmentdate::date, 'YYYY-MM-DD') = p_eventdate
        )
        AND (
            p_eventtitle IS NULL
            OR (
                SELECT value_tx
                FROM tb_picklist_values
                WHERE trim(picklist_value_cd) = trim(pe.examinationtypekey)
                AND picklist_type_id = 320
                LIMIT 1
            ) ILIKE '%' || p_eventtitle || '%'
        )
        AND (
            p_attendees IS NULL
        );

    END IF;

    IF p_datatype IS NULL OR lower(p_datatype) IN ('meeting', 'all') THEN

        SELECT COALESCE(
                 jsonb_agg(
                     jsonb_build_object(
                         'meetingrecordingid', mr.meetingrecordingid,
                         'personid', null,
                         'servicecaseid', mr.servicecaseid,
                         'intakeserviceid', mr.intakeserviceid,
                         'casenumber', coalesce(sc.servicecasenumber, isr.servicerequestnumber, isr.intakenumber),
                         'meetingdate', to_char(mr.meetingdate::timestamp, 'YYYY-MM-DD"T"HH24:MI:SS'),
                         'meetingcomments', mr.meetingcomments,
                         'iscompleted', mr.iscompleted,
                         'meetingtypekey', mr.meetingtypekey,
                         'meetingtype', mt.typedescription,
                         'recordingactor', ra.recordingactor,
                         'participants', mp.participants,
                         'eventdate', to_char(mr.meetingdate::timestamp, 'YYYY-MM-DD"T"HH24:MI:SS'),
                         'eventtitle', mt.typedescription,
                         'attendees', mp.attendees
                     )
                     ORDER BY mr.meetingdate DESC, mr.insertedon DESC
                 ),
                 '[]'::jsonb
               )
          INTO v_meeting
        FROM cjams.meetingrecording mr
        LEFT JOIN cjams.meetingtype mt
            ON mt.meetingtypekey = mr.meetingtypekey
        LEFT JOIN cjams.servicecase sc
            ON sc.servicecaseid = mr.servicecaseid
        LEFT JOIN cjams.intakeservicerequest isr
            ON isr.intakeserviceid = mr.intakeserviceid
        LEFT JOIN LATERAL (
            SELECT
                COALESCE(
                    jsonb_agg(
                        jsonb_build_object(
                            'meetingrecordingid', mra.meetingrecordingid,
                            'personid', mra.personid,
                            'firstname', p.firstname,
                            'lastname', p.lastname,
                            'actorid', isra.actorid,
                            'actortype', at.actortype,
                            'typedescription', at.typedescription
                        )
                    ),
                    '[]'::jsonb
                ) AS recordingactor
            FROM cjams.meetingrecordingactor mra
            INNER JOIN cjams.person p
                ON p.personid = mra.personid
            INNER JOIN cjams.intakeservicerequestactor isra
                ON isra.intakeservicerequestactorid = mra.intakeservicerequestactorid
            INNER JOIN cjams.actortype at
                ON at.actortype = isra.intakeservicerequestpersontypekey
            WHERE mra.meetingrecordingid = mr.meetingrecordingid
            AND mra.activeflag = 1
        ) ra ON true
        LEFT JOIN LATERAL (
            SELECT
                COALESCE(
                    jsonb_agg(
                        jsonb_build_object(
                            'participanttype', mp.participanttype,
                            'participantkey', mp.participantkey,
                            'participantroledesc', mp.participantroledesc,
                            'firstname', mp.firstname,
                            'lastname', mp.lastname,
                            'emailid', mp.emailid,
                            'personid', mp.personid,
                            'isinvited', mp.isinvited,
                            'isattended', mp.isattended,
                            'isaccpted', mp.isaccpted,
                            'electronicsignature', mp.electronicsignature
                        )
                    ),
                    '[]'::jsonb
                ) AS participants,
                COALESCE(
                    jsonb_agg(
                        jsonb_build_object(
                            'firstname', mp.firstname,
                            'lastname', mp.lastname,
                             'fullname', trim(coalesce(mp.firstname, '') || ' ' || coalesce(mp.lastname, '')),
                            'personid', mp.personid
                        )
                    ),
                    '[]'::jsonb
                ) AS attendees
            FROM cjams.meetingparticipants mp
            WHERE mp.meetingrecordingid = mr.meetingrecordingid
            AND mp.activeflag = 1
        ) mp ON true
        WHERE mr.activeflag = 1
        AND mr.iscompleted = 1
        AND mr.insertedby = p_securityuserid
        AND (p_servicecaseid IS NULL OR mr.servicecaseid = p_servicecaseid::uuid)
        AND (p_intakeserviceid IS NULL OR mr.intakeserviceid = p_intakeserviceid::uuid)
        AND (
            p_eventdate IS NULL
            OR to_char(mr.meetingdate::date, 'YYYY-MM-DD') = p_eventdate
        )
        AND (
            p_eventtitle IS NULL
            OR mt.typedescription ILIKE '%' || p_eventtitle || '%'
        )
        AND (
            p_attendees IS NULL
            OR EXISTS (
                SELECT 1
                FROM cjams.meetingparticipants mp2
                WHERE mp2.meetingrecordingid = mr.meetingrecordingid
                AND mp2.activeflag = 1
                AND trim(coalesce(mp2.firstname, '') || ' ' || coalesce(mp2.lastname, '')) ILIKE '%' || p_attendees || '%'
            )
        );

    END IF;

    IF p_datatype IS NULL OR lower(p_datatype) IN ('hearing', 'hearingdetails', 'all') THEN

        SELECT COALESCE(
                 jsonb_agg(
                   jsonb_build_object(
                     'intakeservicerequestcourthearingid', ch.intakeservicerequestcourthearingid,
                     'personid', null,
                     'intakeservicerequestpetitionid', ch.intakeservicerequestpetitionid,
                     'servicecaseid', ch.servicecaseid,
                     'intakeserviceid', ch.intakeserviceid,
                     'casenumber', COALESCE(sc.servicecasenumber, isr.servicerequestnumber, isr.intakenumber, ch.courtcasenumber),
                     'hearingdatetime', to_char(ch.hearingdatetime::timestamp, 'YYYY-MM-DD"T"HH24:MI:SS'),
                     'hearingnotes', ch.hearingnotes,
                     'hearingclientdetails', hcd.hearingclientdetails,
                     'eventdate', to_char(ch.hearingdatetime::timestamp, 'YYYY-MM-DD"T"HH24:MI:SS'),
                     'eventtitle', ch.hearingnotes,
                     'attendees', hcd.attendees
                   )
                   ORDER BY ch.hearingdatetime DESC, ch.insertedon DESC
                 ),
                 '[]'::jsonb
               )
          INTO v_hearingdetails
        FROM cjams.intakeservicerequestcourthearing ch
        LEFT JOIN cjams.servicecase sc
            ON sc.servicecaseid = ch.servicecaseid
        LEFT JOIN cjams.intakeservicerequest isr
            ON isr.intakeserviceid = ch.intakeserviceid
        LEFT JOIN LATERAL (
            SELECT
                COALESCE(
                    jsonb_agg(
                        jsonb_build_object(
                            'hearingclientid', hc.hearingclientid,
                            'personid', hc.personid,
                            'casenumber', hc.courtcasenotx,
                            'clientname', concat_ws(' ', p.prefx, p.firstname, p.middlename, p.lastname, p.suffix),
                            'otherclientflag', hc.otherclientflag,
                            'annualnoticebenefitdt', hc.annualnoticebenefitdt,
                            'intakeservicerequestactorid', (
                                SELECT isra.intakeservicerequestactorid
                                FROM cjams.intakeservicerequestactor isra
                                WHERE isra.personid = hc.personid
                                AND (
                                    isra.servicecaseid = ch.servicecaseid
                                    OR isra.intakeserviceid = ch.intakeserviceid
                                )
                                AND isra.activeflag = 1
                                LIMIT 1
                            ),
                            'dob', p.dob
                        )
                    ),
                    '[]'::jsonb
                ) AS hearingclientdetails,
                COALESCE(
                    jsonb_agg(
                        jsonb_build_object(
                            'clientname', concat_ws(' ', p.prefx, p.firstname, p.middlename, p.lastname, p.suffix),
                            'hearingclientid', hc.hearingclientid,
                            'otherclientflag', hc.otherclientflag,
                            'personid', hc.personid
                        )
                    ),
                    '[]'::jsonb
                ) AS attendees
            FROM cjams.hearingclients hc
            INNER JOIN cjams.person p
                ON p.personid = hc.personid
            WHERE hc.courthearingid = ch.intakeservicerequestcourthearingid
            AND hc.activeflag = 1
        ) hcd ON true
        WHERE ch.activeflag = 1
         AND COALESCE(ch.insertedby, ch.updatedby) = p_securityuserid
        AND (p_servicecaseid IS NULL OR ch.servicecaseid = p_servicecaseid::uuid)
        AND (p_intakeserviceid IS NULL OR ch.intakeserviceid = p_intakeserviceid::uuid)
        AND (
            p_personid IS NULL
            OR EXISTS (
                SELECT 1
                FROM cjams.hearingclients hc1
                WHERE hc1.courthearingid = ch.intakeservicerequestcourthearingid
                AND hc1.personid = p_personid::uuid
                AND hc1.activeflag = 1
            )
        )
        AND (
            p_eventdate IS NULL
            OR to_char(ch.hearingdatetime::date, 'YYYY-MM-DD') = p_eventdate
        )
        AND (
            p_eventtitle IS NULL
            OR coalesce(ch.hearingnotes, '') ILIKE '%' || p_eventtitle || '%'
        )
        AND (
            p_attendees IS NULL
            OR EXISTS (
                SELECT 1
                FROM cjams.hearingclients hc2
                INNER JOIN cjams.person p2
                    ON p2.personid = hc2.personid
                WHERE hc2.courthearingid = ch.intakeservicerequestcourthearingid
                AND hc2.activeflag = 1
                AND concat_ws(' ', p2.prefx, p2.firstname, p2.middlename, p2.lastname, p2.suffix) ILIKE '%' || p_attendees || '%'
            )
        );

    END IF;

    RETURN jsonb_build_object(
        'examination', v_examination,
        'meeting', v_meeting,
        'hearingdetails', v_hearingdetails
    );

END;
$$;