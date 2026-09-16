DROP FUNCTION IF EXISTS cjams.addbeaconaudit(v_event character varying ,v_eventpage character varying ,v_eventid character varying,v_userid character varying);
DROP FUNCTION IF EXISTS cjams.addbeaconaudit(v_event character varying ,v_eventpage character varying ,v_eventid character varying,v_userid character varying,v_ssn character varying);
DROP FUNCTION IF EXISTS cjams.addbeaconaudit(v_event character varying ,v_eventpage character varying ,v_eventid character varying,v_userid character varying,v_ssn character varying,v_personid uuid);
--------------------------------------------------------------------------------------------------
-- 04/10/2025 prasanna sai kommineni - CIDM-9736 BEACON Interface
--04/15/2025 prasanna sai kommineni - CIDM-9736 BEACON Interface remove the insertedby from where and updated ssn
-----------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION cjams.addbeaconaudit(v_event character varying ,v_eventpage character varying ,v_eventid character varying,v_userid character varying,v_ssn character varying, v_personid uuid)
RETURNS uuid
LANGUAGE plpgsql
AS $function$
DECLARE
    v_beaconaudittrailid uuid;
BEGIN
    INSERT INTO cjams.beaconaudittrail (
    event,
    eventpage,
    eventid,
    activeflag,
    updatedby,
    updatedon,
    insertedby,
    insertedon,
    personid
) 
VALUES (
    v_event,
    v_eventpage ,  
    v_eventid, 
    1,                        
    v_userid,      
    NOW(),                   
    v_userid,     
    NOW() ,
    v_personid                 
)RETURNING beaconaudittrailid::uuid INTO v_beaconaudittrailid;  
RETURN v_beaconaudittrailid;
END;
$function$;