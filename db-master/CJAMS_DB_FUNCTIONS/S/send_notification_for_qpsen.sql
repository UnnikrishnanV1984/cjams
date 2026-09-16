DROP FUNCTION IF EXISTS cjams.send_notification_for_qpsen(character varying,character varying,character varying,character varying);
DROP FUNCTION IF EXISTS cjams.send_notification_for_qpsen(character varying,character varying,character varying,character varying,character varying,boolean);

CREATE OR REPLACE FUNCTION cjams.send_notification_for_qpsen(from_userid character varying, v_objectid character varying, babyname character varying, v_objecttype character varying, fromuserrole character varying, isnew boolean)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

--------------------------------------------------
-- Revisions
-- Veera 01/25 - Notifications issue for Quick person search

--------------------------------------------------

DECLARE
v_usernotificationid character varying;
v_usercwnotificationid character varying;
v_userspnotificationid character varying;
v_date timestamp without time zone;  
v_notifystatusclw character varying;
v_msg character varying;  
v_servicerequestnumber character varying;  
begin
v_notifystatusclw := 'SEN Baby Notification ';
 
	v_date:= now() ;


	if (v_objecttype = 'intake') then
		SELECT insertedby INTO v_usernotificationid FROM intakedastatus where intakenumber = v_objectid and activeflag = 1 order by updatedon desc limit 1;
		if(isnew) then
		v_msg = 'SEN Baby Infant ' || babyname || ' needs to be Converted as a client in Intake ('|| v_objectid || ').';
		else 
		v_msg = 'SEN Baby Infant '|| babyname || ' added as a Client in Case ('|| v_objectid || '). All rules pertaining to Substance Exposed Newborns must be enforced. Refer to Policy - SSA 21-05.';
	
		end if; 
        RAISE NOTICE 'v_roletypekey: % ', fromuserrole ;

		IF v_usernotificationid IS NULL OR v_usernotificationid = '' THEN 
			v_usernotificationid =  from_userid ;
		END IF;
        
		SELECT send_notification INTO v_notifystatusclw    
		FROM send_notification(v_usernotificationid, from_userid, v_usernotificationid,'System', 'High', v_msg, v_msg, v_objectid,false);
	
		SELECT vup.supervisorid INTO v_userspnotificationid FROM v_userprofile vup WHERE vup.securityusersid = from_userid limit 1;
		
		SELECT send_notification INTO v_notifystatusclw    
		FROM send_notification(v_userspnotificationid, from_userid, v_userspnotificationid,'System', 'High', v_msg, v_msg, v_objectid,false);
		
		RAISE NOTICE 'v_tosupervisorid: % ', v_userspnotificationid ;
	
	elsif(v_objecttype = 'servicerequest') then

		select servicerequestnumber into v_servicerequestnumber from intakeservicerequest where intakeserviceid::character varying = v_objectid::character varying;
		 select fromsecurityusersid INTO v_userspnotificationid from routing where (objectid = v_objectid::character varying or servicerequestnumber = v_servicerequestnumber) and fromroleid = 'CWSP';
		 select tosecurityusersid INTO v_usercwnotificationid from routing where (objectid = v_objectid::character varying or servicerequestnumber = v_servicerequestnumber) and toroleid = 'CWCW'; 

		v_msg = 'SEN Baby Infant '|| babyname || ' added as a Client in Case ('|| v_servicerequestnumber || '). All rules pertaining to Substance Exposed Newborns must be enforced. Refer to Policy - SSA 21-05.';
	
		SELECT send_notification INTO v_notifystatusclw    
			FROM send_notification(v_usercwnotificationid, from_userid, v_usercwnotificationid,'System', 'High', v_msg, v_msg, v_objectid,false);
		
		SELECT send_notification INTO v_notifystatusclw    
			FROM send_notification(v_usercwnotificationid, from_userid, v_userspnotificationid,'System', 'High', v_msg, v_msg, v_objectid,false);
		
	elsif (v_objecttype = 'servicecase') then
		select servicecasenumber into v_servicerequestnumber from servicecase where servicecaseid::character varying = v_objectid::character varying;
		
		 select fromsecurityusersid INTO v_userspnotificationid from routing where (objectid = v_objectid::character varying or servicerequestnumber = v_servicerequestnumber) and fromroleid = 'CWSP';
		 select tosecurityusersid INTO v_usercwnotificationid from routing where (objectid = v_objectid::character varying or servicerequestnumber = v_servicerequestnumber) and fromroleid = 'CWCW'; 
	
		v_msg = 'SEN Baby Infant '|| babyname || ' added as a Client in Case ('|| v_servicerequestnumber || '). All rules pertaining to Substance Exposed Newborns must be enforced. Refer to Policy - SSA 21-05.';
	
		SELECT send_notification INTO v_notifystatusclw    
			FROM send_notification(v_usercwnotificationid, from_userid, v_usercwnotificationid,'System', 'High', v_msg, v_msg, v_objectid,false);
		
		SELECT send_notification INTO v_notifystatusclw    
			FROM send_notification(v_usercwnotificationid, from_userid, v_userspnotificationid,'System', 'High', v_msg, v_msg, v_objectid,false);
		 
	end if;
	
	 
RETURN v_notifystatusclw ;
END;
$function$
;
