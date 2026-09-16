-- 03/11/2023 prasanna sai kommineni - CIDM-10188 B-215263 : Psychotropic Prescription Review Report Dashboard
-- CIDM-10782 - Veera Nadimpalli 09-03 Postgresql version typecast issue fix
DROP FUNCTION IF EXISTS getpsychotropiccalculateavgtimebusinessdays(
    v_medicationname character varying,
    v_prescribername character varying,
    v_dateprescribed date,
    v_submissiondate date,
    filterdatetype character varying,
    v_clientname character varying,
    v_age int,
    v_countyid character varying,
    startdate date,
    enddate date,
    v_teamid character varying
);
DROP FUNCTION IF EXISTS getpsychotropiccalculateavgtimebusinessdays(
    v_medicationname character varying,
    v_prescribername character varying,
    v_dateprescribed date,
    v_submissiondate date,
    filterdatetype character varying,
    v_clientname character varying,
    v_age int,
    v_countyid character varying,
    startdate date,
    enddate date,
    v_teamid character varying,
    v_caseworkid character varying
);

CREATE OR REPLACE FUNCTION cjams.getpsychotropiccalculateavgtimebusinessdays(v_medicationname character varying DEFAULT NULL::character varying, v_prescribername character varying DEFAULT NULL::character varying, v_dateprescribed date DEFAULT NULL::date,v_submissiondate date DEFAULT NULL, filterdatetype character varying DEFAULT NULL::character varying, v_clientname character varying DEFAULT NULL::character varying, v_age integer DEFAULT NULL::integer, v_countyid character varying DEFAULT NULL::character varying, startdate date DEFAULT NULL::date, enddate date DEFAULT NULL::date, v_teamid character varying DEFAULT NULL::character varying,v_caseworkid character varying DEFAULT NULL)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
--------------------------------------------------------------------------------------------------
-- 03/11/2023 prasanna sai kommineni - CIDM-10188 B-215263 : Psychotropic Prescription Review Report Dashboard

-----------------------------------------------------------------------------------------------------
DECLARE
    avg_time_reviewcoordinator TEXT;
    avg_time_psychiatrist TEXT;
    avg_time_pharmacist TEXT;
    avg_time_caseworker TEXT;
    v_enddate DATE;
    v_startdate DATE;
    v_filterdatetype character varying;
    v_filterdatetypeforrouting INTEGER[];
BEGIN
    -- Assign start and end dates
    v_startdate := startdate::DATE;
    IF enddate IS NULL THEN
        v_enddate := CURRENT_DATE::DATE;
    ELSE
        v_enddate := enddate::DATE;
    END IF;

    -- Handle filterdatetype input
    IF filterdatetype IS NULL THEN
        v_filterdatetype := 'all';
    ELSE
        v_filterdatetype := filterdatetype;
    END IF;

    -- Populate routing type array based on filterdatetype
    CASE v_filterdatetype
        WHEN 'all' THEN
            v_filterdatetypeforrouting := ARRAY[900, 901, 902, 903, 904, 905, 906, 907, 16, 908];
        WHEN 'awaiting_assignment' THEN
            v_filterdatetypeforrouting := ARRAY[ 900];
        WHEN 'information_incomplete' THEN
            v_filterdatetypeforrouting := ARRAY[906];
        WHEN 'pending_peer_review' THEN
            v_filterdatetypeforrouting := ARRAY[907];
        WHEN 'pending_pharmacist_review' THEN
            v_filterdatetypeforrouting := ARRAY[901];
        WHEN 'pending_cap_review' THEN
            v_filterdatetypeforrouting := ARRAY[903];
        WHEN 'return_worker' THEN
            v_filterdatetypeforrouting := ARRAY[904];
        WHEN 'approved' THEN
            v_filterdatetypeforrouting := ARRAY[16];
        WHEN 'rejected' THEN
            v_filterdatetypeforrouting := ARRAY[905];
         WHEN 'initial_submission' THEN
            v_filterdatetypeforrouting := ARRAY[908,902];
        ELSE
            v_filterdatetypeforrouting := ARRAY[]::INTEGER[];
    END case;

    -- Calculate average time for Review Coordinator
    SELECT
       COALESCE(
        FLOOR(SUM( cjams.getcalculatebusinessdays(r.insertedon::timestamp,(CASE WHEN r.insertedon = r.updatedon THEN now() ELSE r.updatedon END)::timestamp ,'psychotropic_business_hour_start','psychotropic_business_hour_end'  )) 
             / COUNT(DISTINCT psm.psychotropicid) / (8 * 3600)), 0
    )::TEXT || ' D, ' ||
 COALESCE(
        FLOOR(MOD(SUM( cjams.getcalculatebusinessdays(r.insertedon::timestamp,(CASE WHEN r.insertedon = r.updatedon THEN now() ELSE r.updatedon END)::timestamp , 'psychotropic_business_hour_start','psychotropic_business_hour_end'   )) 
                 / COUNT(DISTINCT psm.psychotropicid), (8 * 3600)) / 3600), 0
    )::TEXT || ' H, ' ||
 COALESCE(
        FLOOR(MOD(SUM( cjams.getcalculatebusinessdays(r.insertedon::timestamp,(CASE WHEN r.insertedon = r.updatedon THEN now() ELSE r.updatedon END)::timestamp ,'psychotropic_business_hour_start','psychotropic_business_hour_end'  )) 
                 / COUNT(DISTINCT psm.psychotropicid), 3600) / 60), 0
    )::TEXT || ' M '
    INTO avg_time_reviewcoordinator
    FROM cjams.routing r
    LEFT JOIN psychotropicmedications psm ON psm.psychotropicid::VARCHAR = r.objectid
    LEFT JOIN person p ON p.personid = psm.personid::uuid
    LEFT JOIN userprofileaddress upa ON upa.securityusersid = psm.insertedby AND upa.activeflag = 1
    LEFT JOIN cjams.teammemberassignment tma ON tma.securityusersid = psm.insertedby AND tma.activeflag = 1
    LEFT JOIN cjams.teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag = 1
    LEFT JOIN cjams.team t ON t.teamid = tm.teamid AND t.activeflag = 1
    WHERE eventcode = 'PSY' 
      AND toroleid = 'CWPSYCOORD'
      AND (CASE WHEN v_medicationname IS NOT NULL THEN psm.medicationname ILIKE '%' || v_medicationname || '%' ELSE TRUE END)
      AND (CASE WHEN v_prescribername IS NOT NULL THEN psm.prescribername ILIKE '%' || v_prescribername || '%' ELSE TRUE END)
      AND (CASE WHEN v_countyid IS NOT NULL THEN upa.countyid = v_countyid::uuid ELSE TRUE END)
      AND (CASE WHEN v_caseworkid IS NOT NULL THEN psm.insertedby = v_caseworkid ELSE TRUE END)
      AND (CASE WHEN v_dateprescribed IS NOT NULL THEN psm.dateprescribed::DATE = v_dateprescribed::DATE ELSE TRUE END)
         AND (CASE WHEN v_submissiondate IS NOT NULL THEN  (SELECT r3.insertedon 
         FROM routing r3 
         WHERE r3.objectid = psm.psychotropicid::VARCHAR 
           AND r3.eventcode = 'PSY' 
           AND r3.routingstatustypeid = 908 
         ORDER BY r3.insertedon DESC 
         LIMIT 1)::date = v_submissiondate::DATE  ELSE TRUE END)
      	AND (CASE WHEN v_age IS NOT NULL 
    THEN DATE_PART('year', AGE(CURRENT_DATE, p.dob)) <= v_age 
    ELSE TRUE  END)
      AND (CASE WHEN v_clientname IS NOT NULL THEN CONCAT(p.firstname,' ', p.lastname) ILIKE '%' || v_clientname || '%' ELSE TRUE END)
      AND (v_startdate IS NULL OR psm.insertedon::DATE >= v_startdate::DATE)
      AND (v_enddate IS NULL OR psm.insertedon::DATE <= v_enddate::DATE)
      AND (CASE WHEN (v_teamid IS NOT NULL AND v_teamid != '') THEN t.teamid = v_teamid::uuid ELSE TRUE END)
      AND (CASE WHEN v_filterdatetype = 'all' THEN 
                (r.routingstatustypeid IN (900, 901, 902, 903, 904, 905, 906, 907, 16, 908) OR COALESCE(r.routingstatustypeid, 1) = 1)
            WHEN v_filterdatetype = 'draft' THEN COALESCE(r.routingstatustypeid, 1) = 1
            ELSE r.routingstatustypeid = ANY(v_filterdatetypeforrouting)
           END);
 SELECT
          COALESCE(
        FLOOR(SUM( cjams.getcalculatebusinessdays(r.insertedon::timestamp,(CASE WHEN r.insertedon = r.updatedon THEN now() ELSE r.updatedon END)::timestamp ,'psychotropic_business_hour_start','psychotropic_business_hour_end'  )) 
             / COUNT(DISTINCT psm.psychotropicid) / (8 * 3600)), 0
    )::TEXT || ' D, ' ||
 COALESCE(
        FLOOR(MOD(SUM( cjams.getcalculatebusinessdays(r.insertedon::timestamp,(CASE WHEN r.insertedon = r.updatedon THEN now() ELSE r.updatedon END)::timestamp ,'psychotropic_business_hour_start','psychotropic_business_hour_end' )) 
                 / COUNT(DISTINCT psm.psychotropicid), (8 * 3600)) / 3600), 0
    )::TEXT || ' H, ' ||
 COALESCE(
        FLOOR(MOD(SUM( cjams.getcalculatebusinessdays(r.insertedon::timestamp,(CASE WHEN r.insertedon = r.updatedon THEN now() ELSE r.updatedon END)::timestamp,'psychotropic_business_hour_start','psychotropic_business_hour_end' )) 
                 / COUNT(DISTINCT psm.psychotropicid), 3600) / 60), 0
    )::TEXT || ' M '
    INTO avg_time_psychiatrist
    FROM cjams.routing r

       LEFT JOIN psychotropicmedications psm ON psm.psychotropicid::VARCHAR = r.objectid
    LEFT JOIN person p ON p.personid = psm.personid::uuid
    LEFT JOIN userprofileaddress upa ON upa.securityusersid = psm.insertedby AND upa.activeflag = 1
    LEFT JOIN cjams.teammemberassignment tma ON tma.securityusersid = psm.insertedby AND tma.activeflag = 1
    LEFT JOIN cjams.teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag = 1
    LEFT JOIN cjams.team t ON t.teamid = tm.teamid AND t.activeflag = 1
    WHERE eventcode = 'PSY' 
      AND toroleid = 'CWPSYPSYCH'
      AND (CASE WHEN v_medicationname IS NOT NULL THEN psm.medicationname ILIKE '%' || v_medicationname || '%' ELSE TRUE END)
      AND (CASE WHEN v_prescribername IS NOT NULL THEN psm.prescribername ILIKE '%' || v_prescribername || '%' ELSE TRUE END)
      AND (CASE WHEN v_countyid IS NOT NULL THEN upa.countyid = v_countyid::uuid ELSE TRUE END)
      AND (CASE WHEN v_caseworkid IS NOT NULL THEN psm.insertedby = v_caseworkid ELSE TRUE END)
      AND (CASE WHEN v_dateprescribed IS NOT NULL THEN psm.dateprescribed::DATE = v_dateprescribed::DATE ELSE TRUE END)
         AND (CASE WHEN v_submissiondate IS NOT NULL THEN  (SELECT r3.insertedon 
         FROM routing r3 
         WHERE r3.objectid = psm.psychotropicid::VARCHAR 
           AND r3.eventcode = 'PSY' 
           AND r3.routingstatustypeid = 908 
         ORDER BY r3.insertedon DESC 
         LIMIT 1)::date = v_submissiondate::DATE  ELSE TRUE END)
      	AND (CASE WHEN v_age IS NOT NULL 
    THEN DATE_PART('year', AGE(CURRENT_DATE, p.dob)) <= v_age 
    ELSE TRUE  END)
      AND (CASE WHEN v_clientname IS NOT NULL THEN CONCAT(p.firstname,' ', p.lastname) ILIKE '%' || v_clientname || '%' ELSE TRUE END)
      AND (v_startdate IS NULL OR psm.insertedon::DATE >= v_startdate::DATE)
      AND (v_enddate IS NULL OR psm.insertedon::DATE <= v_enddate::DATE)
      AND (CASE WHEN (v_teamid IS NOT NULL AND v_teamid != '') THEN t.teamid = v_teamid::uuid ELSE TRUE END)
      AND (CASE WHEN v_filterdatetype = 'all' THEN 
                (r.routingstatustypeid IN (900, 901, 902, 903, 904, 905, 906, 907, 16, 908) OR COALESCE(r.routingstatustypeid, 1) = 1)
            WHEN v_filterdatetype = 'draft' THEN COALESCE(r.routingstatustypeid, 1) = 1
            ELSE r.routingstatustypeid = ANY(v_filterdatetypeforrouting)
           END);
        -- Calculate average time for Pharmacist
    SELECT
           COALESCE(
        FLOOR(SUM(  cjams.getcalculatebusinessdays(r.insertedon::timestamp,(CASE WHEN r.insertedon = r.updatedon THEN now() ELSE r.updatedon END)::timestamp ,'psychotropic_business_hour_start','psychotropic_business_hour_end'  )) 
             / COUNT(DISTINCT psm.psychotropicid) / (8 * 3600)), 0
    )::TEXT || ' D, ' ||
 COALESCE(
        FLOOR(MOD(SUM( cjams.getcalculatebusinessdays(r.insertedon::timestamp,(CASE WHEN r.insertedon = r.updatedon THEN now() ELSE r.updatedon END)::timestamp  ,'psychotropic_business_hour_start','psychotropic_business_hour_end' )) 
                 / COUNT(DISTINCT psm.psychotropicid), (8 * 3600)) / 3600), 0
    )::TEXT || ' H, ' ||
 COALESCE(
        FLOOR(MOD(SUM( cjams.getcalculatebusinessdays( r.insertedon::timestamp, (CASE WHEN r.insertedon = r.updatedon THEN now() ELSE r.updatedon END)::timestamp ,'psychotropic_business_hour_start','psychotropic_business_hour_end'  )) 
                 / COUNT(DISTINCT psm.psychotropicid), 3600) / 60), 0
    )::TEXT || ' M '
    INTO avg_time_pharmacist
    FROM cjams.routing r
    
       LEFT JOIN psychotropicmedications psm ON psm.psychotropicid::VARCHAR = r.objectid
    LEFT JOIN person p ON p.personid = psm.personid::uuid
    LEFT JOIN userprofileaddress upa ON upa.securityusersid = psm.insertedby AND upa.activeflag = 1
    LEFT JOIN cjams.teammemberassignment tma ON tma.securityusersid = psm.insertedby AND tma.activeflag = 1
    LEFT JOIN cjams.teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag = 1
    LEFT JOIN cjams.team t ON t.teamid = tm.teamid AND t.activeflag = 1
    WHERE eventcode = 'PSY' 
      AND toroleid = 'CWPSYPHARM'
      AND (CASE WHEN v_medicationname IS NOT NULL THEN psm.medicationname ILIKE '%' || v_medicationname || '%' ELSE TRUE END)
      AND (CASE WHEN v_prescribername IS NOT NULL THEN psm.prescribername ILIKE '%' || v_prescribername || '%' ELSE TRUE END)
      AND (CASE WHEN v_countyid IS NOT NULL THEN upa.countyid = v_countyid::uuid ELSE TRUE END)
      AND (CASE WHEN v_caseworkid IS NOT NULL THEN psm.insertedby = v_caseworkid ELSE TRUE END)
      AND (CASE WHEN v_dateprescribed IS NOT NULL THEN psm.dateprescribed::DATE = v_dateprescribed::DATE ELSE TRUE END)
         AND (CASE WHEN v_submissiondate IS NOT NULL THEN  (SELECT r3.insertedon 
         FROM routing r3 
         WHERE r3.objectid = psm.psychotropicid::VARCHAR 
           AND r3.eventcode = 'PSY' 
           AND r3.routingstatustypeid = 908 
         ORDER BY r3.insertedon DESC 
         LIMIT 1)::date = v_submissiondate::DATE  ELSE TRUE END)
      	AND (CASE WHEN v_age IS NOT NULL 
    THEN DATE_PART('year', AGE(CURRENT_DATE, p.dob)) <= v_age 
    ELSE TRUE  END)
      AND (CASE WHEN v_clientname IS NOT NULL THEN CONCAT(p.firstname,' ', p.lastname) ILIKE '%' || v_clientname || '%' ELSE TRUE END)
      AND (v_startdate IS NULL OR psm.insertedon::DATE >= v_startdate::DATE)
      AND (v_enddate IS NULL OR psm.insertedon::DATE <= v_enddate::DATE)
      AND (CASE WHEN (v_teamid IS NOT NULL AND v_teamid != '') THEN t.teamid = v_teamid::uuid ELSE TRUE END)
      AND (CASE WHEN v_filterdatetype = 'all' THEN 
                (r.routingstatustypeid IN (900, 901, 902, 903, 904, 905, 906, 907, 16, 908) OR COALESCE(r.routingstatustypeid, 1) = 1)
            WHEN v_filterdatetype = 'draft' THEN COALESCE(r.routingstatustypeid, 1) = 1
            ELSE r.routingstatustypeid = ANY(v_filterdatetypeforrouting)
           END);


    -- Calculate average time for Caseworker
    SELECT
        COALESCE(
            FLOOR(AVG(EXTRACT(epoch FROM (COALESCE(r.updatedon, now()) - COALESCE(r.insertedon, now())))) / 86400), 0)::TEXT || ' D, ' ||
        COALESCE(
            FLOOR(MOD(AVG(EXTRACT(epoch FROM (COALESCE(r.updatedon, now()) - COALESCE(r.insertedon, now()))))::integer, 86400) / 3600), 0)::TEXT || ' H, ' ||
        COALESCE(
            FLOOR(MOD(AVG(EXTRACT(epoch FROM (COALESCE(r.updatedon, now()) - COALESCE(r.insertedon, now()))))::integer, 3600) / 60), 0)::TEXT || ' M, ' ||
        COALESCE(
            FLOOR(MOD(AVG(EXTRACT(epoch FROM (COALESCE(r.updatedon, now()) - COALESCE(r.insertedon, now()))))::integer, 60)), 0)::TEXT || ' S'
    INTO avg_time_caseworker
    FROM cjams.routing r
       LEFT JOIN psychotropicmedications psm ON psm.psychotropicid::VARCHAR = r.objectid
    LEFT JOIN person p ON p.personid = psm.personid::uuid
    LEFT JOIN userprofileaddress upa ON upa.securityusersid = psm.insertedby AND upa.activeflag = 1
    LEFT JOIN cjams.teammemberassignment tma ON tma.securityusersid = psm.insertedby AND tma.activeflag = 1
    LEFT JOIN cjams.teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag = 1
    LEFT JOIN cjams.team t ON t.teamid = tm.teamid AND t.activeflag = 1
    WHERE eventcode = 'PSY' 
      AND toroleid = 'CWCW'
      AND (CASE WHEN v_medicationname IS NOT NULL THEN psm.medicationname ILIKE '%' || v_medicationname || '%' ELSE TRUE END)
      AND (CASE WHEN v_prescribername IS NOT NULL THEN psm.prescribername ILIKE '%' || v_prescribername || '%' ELSE TRUE END)
      AND (CASE WHEN v_countyid IS NOT NULL THEN upa.countyid = v_countyid::uuid ELSE TRUE END)
      AND (CASE WHEN v_caseworkid IS NOT NULL THEN psm.insertedby = v_caseworkid ELSE TRUE END)
      AND (CASE WHEN v_dateprescribed IS NOT NULL THEN psm.dateprescribed::DATE = v_dateprescribed::DATE ELSE TRUE END)
         AND (CASE WHEN v_submissiondate IS NOT NULL THEN  (SELECT r3.insertedon 
         FROM routing r3 
         WHERE r3.objectid = psm.psychotropicid::VARCHAR 
           AND r3.eventcode = 'PSY' 
           AND r3.routingstatustypeid = 908 
         ORDER BY r3.insertedon DESC 
         LIMIT 1)::date = v_submissiondate::DATE  ELSE TRUE END)
     	AND (CASE WHEN v_age IS NOT NULL 
    THEN DATE_PART('year', AGE(CURRENT_DATE, p.dob)) <= v_age 
    ELSE TRUE  END)
      AND (CASE WHEN v_clientname IS NOT NULL THEN CONCAT(p.firstname,' ', p.lastname) ILIKE '%' || v_clientname || '%' ELSE TRUE END)
      AND (v_startdate IS NULL OR psm.insertedon::DATE >= v_startdate::DATE)
      AND (v_enddate IS NULL OR psm.insertedon::DATE <= v_enddate::DATE)
      AND (CASE WHEN (v_teamid IS NOT NULL AND v_teamid != '') THEN t.teamid = v_teamid::uuid ELSE TRUE END)
      AND (CASE WHEN v_filterdatetype = 'all' THEN 
                (r.routingstatustypeid IN (900, 901, 902, 903, 904, 905, 906, 907, 16, 908) OR COALESCE(r.routingstatustypeid, 1) = 1)
            WHEN v_filterdatetype = 'draft' THEN COALESCE(r.routingstatustypeid, 1) = 1
            ELSE r.routingstatustypeid = ANY(v_filterdatetypeforrouting)
           END);
    -- Return the JSON object with all averages
    RETURN json_build_object(
        'avg_time_reviewcoordinator', avg_time_reviewcoordinator,
        'avg_time_psychiatrist', avg_time_psychiatrist,
        'avg_time_pharmacist', avg_time_pharmacist,
        'avg_time_caseworker', avg_time_caseworker
    );
END;
$function$
;