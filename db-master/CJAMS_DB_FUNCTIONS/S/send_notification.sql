DROP FUNCTION  IF EXISTS cjams.send_notification(character varying, character varying, character varying,  character varying, character varying, character varying,  text, character varying,  boolean) ;
DROP FUNCTION  IF EXISTS cjams.send_notification(character varying, character varying, character varying,  character varying, character varying, character varying,  text, character varying,  boolean,uuid) ;
CREATE OR REPLACE FUNCTION cjams.send_notification(notificationuserid character varying, from_userid character varying, to_userid character varying, usernotificationtypekey character varying, priorityleveltypekey character varying, subject character varying, body text, l_intakeserviceid character varying, isexternalentity boolean DEFAULT false,entityid uuid DEFAULT NULL::uuid)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 11/10/2021 Vineet Tirodkar - Modifications for CJAMS - Performance Issue (CIDM-4060)
-- 11-23-2022 - Veera Aurora Performance issue fix
-- 11-30-2022 - Vijaya Laxmi Devunoori - CDM-26893
-- 7/19/2024 - Smitha Somasekharan-  MOdifications for Luggage indicator in Placement(CIDM-9031)
-- 07/17/2026 - Veera Nadimpalli to Fix support log email notifications - CIDM-11585 
------------------------------------------------------------------------    
DECLARE
	v_usernotificationid uuid;
	v_date timestamp without time zone;
	v_isexternalentity boolean;
	v_objecttype CHARACTER VARYING;
	v_objectcasenumber CHARACTER VARYING; 
    l_intakeserviceid_uuidornot character varying(50);
	 
	
BEGIN                                                                                                                                                                                                                                                                                                   
	v_date:= now();
	
	-- Verify if l_intakeserviceid is uuid
	SELECT * into l_intakeserviceid_uuidornot from uuid_or_null(l_intakeserviceid);
		
	
	IF v_objecttype IS NULL and l_intakeserviceid_uuidornot is not null THEN
		SELECT 'cps', isr.servicerequestnumber 
			INTO v_objecttype, v_objectcasenumber
		FROM intakeservicerequest isr 
		WHERE isr.intakeserviceid = l_intakeserviceid::uuid 
			AND isr.activeflag = 1;
	END IF;

	IF v_objecttype IS NULL and l_intakeserviceid_uuidornot is not null THEN
		SELECT 'servicecase', sc.servicecasenumber 
			INTO v_objecttype, v_objectcasenumber
		FROM servicecase sc 
		WHERE sc.servicecaseid = l_intakeserviceid::uuid 
			AND sc.activeflag = 1;
	END IF;

	IF v_objecttype IS NULL and l_intakeserviceid_uuidornot is not null THEN
		SELECT 'adoptioncase', ac.adoptioncasenumber 
			INTO v_objecttype, v_objectcasenumber
		FROM adoptioncase ac 
		WHERE ac.adoptioncaseid  = l_intakeserviceid::uuid 
			AND ac.activeflag = 1;
	END IF;

	IF v_objecttype IS NULL and l_intakeserviceid_uuidornot is not null THEN
		SELECT 'adoptioncase', ac.adoptioncasenumber 
			INTO v_objecttype, v_objectcasenumber
		FROM adoptioncasedisposition acd
			JOIN adoptioncase ac ON ac.adoptioncaseid = acd.adoptioncaseid 
				AND ac.activeflag = 1
		WHERE adoptioncasedispositionid = l_intakeserviceid::uuid 
			AND acd.activeflag = 1;
	END IF;

	IF v_objecttype IS NULL THEN
		SELECT 'intake', ids.intakenumber 
			INTO v_objecttype, v_objectcasenumber
		FROM intakedastaging ids 
		WHERE ids.intakenumber = l_intakeserviceid 
			AND ids.activeflag = 1 
			and ids.teamtypekey = 'CW';
	END IF;

    IF v_objecttype IS NULL and uuid_or_null(l_intakeserviceid) is null and l_intakeserviceid ~ '^[0-9]+$' then 
        SELECT 'servicecase', tsl.case_id :: CHARACTER VARYING 
            INTO v_objecttype, v_objectcasenumber
        FROM tb_service_log tsl
            INNER JOIN servicecase sc ON sc.servicecasenumber = tsl.case_id::character varying
            INNER JOIN tb_service_purchase_authorization tspa ON tspa.service_log_id = tsl.service_log_id
        WHERE tspa.authorization_id = l_intakeserviceid::int
        ORDER BY sc.insertedon LIMIT 1;
    END IF;

    IF v_objecttype IS NULL and uuid_or_null(l_intakeserviceid) is null and l_intakeserviceid ~ '^[0-9]+$' THEN
        SELECT 'cps', tsl.case_id::CHARACTER VARYING 
            INTO v_objecttype, v_objectcasenumber
        FROM tb_service_log tsl
            INNER JOIN intakeservicerequest isr ON isr.servicerequestnumber = tsl.case_id::character varying
            INNER JOIN tb_service_purchase_authorization tspa ON tspa.service_log_id = tsl.service_log_id
        WHERE tspa.authorization_id = l_intakeserviceid::int
        ORDER BY isr.insertedon LIMIT 1;
    END IF;

	IF v_objecttype IS NULL and l_intakeserviceid_uuidornot is not null THEN
		SELECT 'cps', isr.servicerequestnumber 
			INTO v_objecttype, v_objectcasenumber
		FROM intakeservicerequest isr
			INNER JOIN guardianship gp ON gp.intakeserviceid = isr.intakeserviceid 
			INNER JOIN gapagreement ga ON gp.gapid = ga.gapid
		WHERE ga.gapagreementid = l_intakeserviceid::uuid
		ORDER BY isr.insertedon LIMIT 1;
	END IF;

	IF v_objecttype IS NULL and l_intakeserviceid_uuidornot is not null THEN
		SELECT 'cps', isr.servicerequestnumber 
			INTO v_objecttype, v_objectcasenumber		
		FROM intakeservicerequest isr 
			JOIN intakeservreqchildremoval isrcr ON isr.intakeserviceid = isrcr.intakeserviceid 
				AND isrcr.servicecaseid IS NULL
		WHERE isrcr.intakeservreqchildremovalid = l_intakeserviceid::uuid ;
	END IF;

	IF v_objecttype IS NULL and l_intakeserviceid_uuidornot is not null THEN
		SELECT 'servicecase', sc.servicecasenumber 
			INTO v_objecttype, v_objectcasenumber		
		FROM servicecase sc 
			JOIN intakeservreqchildremoval isrcr ON sc.servicecaseid = isrcr.servicecaseid
		WHERE isrcr.intakeservreqchildremovalid = l_intakeserviceid::uuid ;
	END IF;

	IF v_objecttype IS NULL and l_intakeserviceid_uuidornot is not null THEN
		SELECT 'servicecase', sc.servicecasenumber 
			INTO v_objecttype, v_objectcasenumber		
		FROM servicecase sc 
			JOIN servicecasedisposition scd ON sc.servicecaseid = scd.servicecaseid
		WHERE scd.servicecasedispositionid = l_intakeserviceid::uuid ;
	END IF;

	IF v_objecttype IS NULL and l_intakeserviceid_uuidornot is not null THEN
		SELECT 'servicecase', sc.servicecasenumber 
			INTO v_objecttype, v_objectcasenumber		
		FROM servicecase sc 
			JOIN placement pl ON sc.servicecaseid = pl.servicecaseid
		WHERE pl.placementid = l_intakeserviceid::uuid ;
	END IF;

	IF v_objecttype IS NULL and l_intakeserviceid_uuidornot is not null THEN
		SELECT 'servicecase', sc.servicecasenumber 
			INTO v_objecttype, v_objectcasenumber		
		FROM servicecase sc 
			JOIN permanencyplan pp ON sc.servicecaseid = pp.servicecaseid
		WHERE pp.permanencyplanid = l_intakeserviceid::uuid ;
	END IF;

	IF v_objecttype IS NULL and l_intakeserviceid_uuidornot is not null THEN
		SELECT 'servicecase', sc.servicecasenumber INTO v_objecttype, v_objectcasenumber		
			FROM servicecase sc 
		JOIN permanencyplan pp ON sc.servicecaseid = pp.servicecaseid
		WHERE pp.permanencyplanid = l_intakeserviceid::uuid ;
	END IF;

	IF v_objecttype IS NULL THEN
		SELECT 'TicketNo', sl.supportno 
			INTO v_objecttype, v_objectcasenumber		
		FROM defecttracking.supportlog sl 	
		WHERE sl.activeflag = 1 
			and supportno = l_intakeserviceid;
		
		IF notificationuserid IS NULL OR notificationuserid = '' THEN 
			SELECT supervisorid 
				INTO notificationuserid 
			FROM cjams.userprofile 
			where securityusersid =  from_userid and activeflag=1;		
		END IF;
		
		IF notificationuserid IS NULL OR notificationuserid = '' THEN 
			notificationuserid =  from_userid ;
		END IF;
		to_userid = notificationuserid;
	END IF;
	
		INSERT INTO usernotification 
		(	securityusersid,usernotificationtypekey,                                                                                                                                                                                                                                                                                   
			objectid,activeflag,subject,priorityleveltypekey,body,isexternalentity,updatedby,                                                                                                                                                                                                                                                                        
			updatedon,insertedby,insertedon,effectivedate,ismailsent, objecttype, objectcasenumber, 
			teamtypekey,entityid
		)
	VALUES 
		(	notificationuserid, usernotificationtypekey, l_intakeserviceid, 1, subject,                                                                                                                                                                                                                                                                        
			priorityleveltypekey, body,isexternalentity, from_userid,                                                                                                                                                                                                                                                                                        
			v_date, from_userid,v_date,v_date,false, v_objecttype, v_objectcasenumber, 'CW',entityid
		)  RETURNING "usernotificationid" INTO  v_usernotificationid;                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                                                          
	INSERT INTO usernotificationmap
		(	usernotificationid,fromsecurityusersid,tosecurityusersid,isread,
			effectivedate,activeflag,updatedby,updatedon,insertedby,insertedon
		)
	VALUES 
		(	v_usernotificationid, from_userid,to_userid, false,
			v_date, 1, from_userid,v_date, from_userid,v_date
		);
		
	RETURN 'success' ;                                                                                                                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                                                                                          
END;                                                                                                                                                                                                                                                                                                                                                     

$function$
;