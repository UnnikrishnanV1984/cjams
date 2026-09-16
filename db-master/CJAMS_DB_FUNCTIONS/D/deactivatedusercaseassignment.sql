DROP FUNCTION IF EXISTS cjams.deactivatedusercaseassignment(v_securityusersid character varying);
CREATE OR REPLACE FUNCTION cjams.deactivatedusercaseassignment(v_securityusersid character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Revisions
---- 10/08/2024 - Manasa Kasula - CIDM-9543- On deactivating worker from the Application, Assigned assignment should be assigned to there respective supervisor
------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	DECLARE 
	v_message character varying;
    v_activecasescount integer;
    v_supervisorid character varying;
    v_activesupervisorid character varying;
    v_activecountyid uuid;
    v_activeteamid uuid;
	 
	BEGIN
	v_message:= 'Success';

    /*Update Userprofile*/
    IF (v_securityusersid != '') THEN 

        select count(*) into v_activecasescount from caseassignment where toworkeridno  = v_securityusersid 
        and activeflag = 1 and (enddate is null or enddate > now());

        IF(v_activecasescount > 0) then 

            select supervisorid into v_supervisorid from userprofile 
            where securityusersid = v_securityusersid;

            select securityusersid , countyid ,teamid  into v_activesupervisorid, v_activecountyid,v_activeteamid from v_userprofile where securityusersid = v_supervisorid;		

            If (v_activesupervisorid is null) THEN
                select supervisorid into v_supervisorid from userprofile 
                where securityusersid = v_supervisorid;

                select securityusersid , countyid ,teamid  into v_activesupervisorid, v_activecountyid,v_activeteamid from v_userprofile where securityusersid = v_supervisorid;

            END IF;

            IF(v_activesupervisorid is not null) THEN 

                INSERT INTO cjams.caseassignment
                (caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, old_id, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype)
                select gen_random_uuid(), eventidno_fk, eventdttmkey_fk, v_activesupervisorid, null, null, v_activesupervisorid, null, old_id, 'deactivateuser', 'deactivateuser', now(), now(), objecttypekey, objectid, responsibilitytypekey, 1, now(), null, v_activeteamid, v_activeteamid, remarks, NULL, v_activecountyid, v_activecountyid, assignmenttype 
                from caseassignment ca 
                where ca.toworkeridno  = v_securityusersid 
                and ca.activeflag = 1 and (ca.enddate is null or ca.enddate > now());
            
                update caseassignment
                set enddate = now(), updatedon = now(), updatedby = 'deactivateuser' 
                where toworkeridno  = v_securityusersid 
                and activeflag = 1 and (enddate is null or enddate > now());
            END IF;

        END IF;
                    
    END IF;	
	
    return v_message;
END  
$function$
;
