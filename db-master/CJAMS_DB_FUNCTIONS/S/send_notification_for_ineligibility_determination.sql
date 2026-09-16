CREATE OR REPLACE FUNCTION cjams.send_notification_for_ineligibility_determination(v_casenumber character varying, v_clientid character varying, securityuserid character varying, v_endDate character varying, childname character varying, v_removalid bigint)
  returns text
 LANGUAGE plpgsql
AS $function$
   
DECLARE
	v_date timestamp without time zone;
	v_usernotificationid uuid;
	v_subject character varying;
	v_count int;
	rec RECORD;

	
BEGIN                                                                                                                                                                                                                                                                                                   
	v_date:= now();
    v_subject = 'Please end-date the current placement for  ' || childname || ' / Child CJAMS PID ' || (v_clientid)::character varying || ', as the agency has lost placement and care responsibility effective  ('|| v_endDate ||'). Do not validate the placement beyond this date.';


	IF v_removalid IS NOT NULL THEN
		SELECT count(*) 
			INTO v_count
		FROM intakeservreqchildremoval icr
		WHERE icr.removalid = v_removalid and icr.activeflag = 1 and icr.exitdate is null;

	END IF;

	RAISE NOTICE 'v_count >> %',v_count;

			
	IF v_count > 0 THEN

	FOR rec IN 
	SELECT toworkeridno  
		FROM caseassignment
		WHERE objectid = (	SELECT sc.servicecaseid  
		        FROM servicecase sc
		        WHERE sc.servicecasenumber = v_casenumber
		        and  sc.activeflag = 1)
		and activeflag = 1 and enddate is null
		
	LOOP

	raise notice 'test %',rec.toworkeridno;


	INSERT INTO usernotification 
		(	securityusersid,usernotificationtypekey,                                                                                                                                                                                                                                                                                   
			objectid,activeflag,subject,priorityleveltypekey,body,isexternalentity,updatedby,                                                                                                                                                                                                                                                                        
			updatedon,insertedby,insertedon,effectivedate,ismailsent, objecttype, objectcasenumber, 
			teamtypekey,old_id, entityid
		) 
		(select rec.toworkeridno, 'System',
    		rm.servicecaseid,
    		1, v_subject,                                                       
    		'High', v_subject,false, securityuserid,
    		v_date, securityuserid,v_date,v_date,false, 'servicecase', v_casenumber, 'CW', 'IVEPH0',
    		rm.intakeservreqchildremovalid
			FROM intakeservreqchildremoval rm
   			WHERE rm.removalid = v_removalid 
    		and rm.activeflag = 1
		)  RETURNING "usernotificationid" INTO  v_usernotificationid;                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                                                          
	INSERT INTO usernotificationmap
		(	usernotificationid,fromsecurityusersid,tosecurityusersid,isread,
			effectivedate,activeflag,updatedby,updatedon,insertedby,insertedon
		)
	VALUES 
		(	v_usernotificationid, securityuserid, rec.toworkeridno, false,
			v_date, 1, securityuserid,v_date, securityuserid,v_date
		);

	END LOOP;
		
	END IF;     
    
	RETURN 'success'; 
                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                          
END;                                                                                                                                                                                                                                                                                                                                                     

$function$
;