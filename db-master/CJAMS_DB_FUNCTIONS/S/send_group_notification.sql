CREATE OR REPLACE FUNCTION cjams.send_group_notification(v_fromuserid uuid, v_objectid uuid, v_touserid uuid, v_actiontype character varying )
 RETURNS text
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vijaya Laxmi Devunoori
-- Date Created : 04/04/2023 

-- Stored Procedure to Send group notifications to multiple users 
-- -- 02/11/2026 - Veera - CIDM-11127 - long running Query tunning

------------------------------------------------------------------------  

DECLARE
	v_data record;
    v_fromuser text;
    v_ftdmuser text;
    v_servicerequestno text;
BEGIN
    -- Facilitated Meeting Referral Form is approved
    if v_actiontype = 'fmrfapproved' then

        SELECT cast( lastname ||',' || firstname as character varying) INTO v_fromuser 
        FROM userprofile 
        WHERE securityusersid = $1 AND activeflag =1;

        SELECT cast( lastname ||',' || firstname as character varying) INTO v_ftdmuser 
        FROM userprofile 
        WHERE securityusersid = $3 AND activeflag =1;

        select servicecasenumber INTO v_servicerequestno
        from servicecase 
        where servicecaseid = $2  and activeflag = 1;
        
        FOR v_data IN 
                select distinct vu.securityusersid
                from caseassignment ca
                inner join v_userprofile vu on ca.toworkeridno = vu.securityusersid 
                where ca.objectid = $2 and ca.enddate is null
        LOOP	
            PERFORM send_notification(v_data.securityusersid::character varying, $1::character varying, v_data.securityusersid,   
                    'System', 'Normal', 'FACILITATED MEETING REFERRAL FORM is Approved by ' || v_fromuser || ' and Assigned to ' || v_ftdmuser,
                    'Case #' || v_servicerequestno || ' - FACILITATED MEETING REFERRAL FORM is Approved by '|| v_fromuser || ' and Assigned to ' || v_ftdmuser ,
                    cast(v_objectid as character varying));
        END LOOP;

    end if; 

RETURN 'success';

END;

$function$
;
