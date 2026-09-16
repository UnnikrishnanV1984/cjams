CREATE OR REPLACE FUNCTION cjams.publicproviderrouting(v_objectid character varying, v_securityuserid character varying, v_tosecurityusersid character varying, v_routingstatusid integer, appeventcode character varying, v_notifymsg character varying DEFAULT ''::character varying, v_routeddescription character varying DEFAULT ''::character varying, v_typeofobject character varying DEFAULT ''::character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE 
 v_date timestamp without time zone; 
 v_msg character varying;
 v_username character varying;
 v_returnstatus character varying;
 v_teamid uuid;
 v_roletypekey text;
 v_routing_rec record;
 v_routingid uuid;
 BEGIN
 v_date:= now();
    SELECT tm.teamid,  tm.roletypekey INTO 
			v_teamid, v_roletypekey 
			FROM    teammemberassignment tma 
			INNER JOIN  teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
			WHERE  tma.SecurityUsersId = v_securityuserid AND   tma.activeflag =1;
 	RAISE NOTICE 'v_teamid;:%', v_teamid ;
    RAISE NOTICE 'v_roletypekey;:%', v_roletypekey ;
    RAISE NOTICE 'appeventcode;:%', appeventcode ;
    
    FOR v_routing_rec IN SELECT routingstatustypekey,sourcerolekey,targetrolekey,
							 ftmrt.teamtypekey frmteamtypekey, ttmrt.teamtypekey  toteamtypekey,
                             CASE ftmrt.teamtypekey WHEN ttmrt.teamtypekey THEN 0 ELSE 1 END isotheragency
                             FROM routingconfig  rc
                    		 INNER JOIN teammemberroletype ftmrt   on  ftmrt.roletypekey  = rc.sourcerolekey AND ftmrt.activeflag =1
                    		 INNER JOIN teammemberroletype ttmrt   on  ttmrt.roletypekey  = rc.targetrolekey AND ttmrt.activeflag =1
					 		 WHERE  eventcode = appeventcode AND  sourcerolekey =v_roletypekey   
                             AND rc.activeflag =1
    loop
        IF COALESCE(v_tosecurityusersid,'') = '' THEN
			    SELECT tma.SecurityUsersId , COALESCE(up.firstname,'') || ' ' || COALESCE(up.lastname,'')  
			    INTO v_tosecurityusersid, v_username
			    FROM teammemberassignment tma
				INNER JOIN teammember tm
					ON tm.teammemberid = tma.teammemberid  AND tm.activeflag= 1 
				INNER JOIN userprofile up 
					ON up.securityusersid = tma.securityusersid AND up.activeflag= 1
				INNER JOIN routingcONfig rc  
					ON rc.targetrolekey = tm.roletypekey   AND rc.activeflag= 1
					AND rc.sourcerolekey =v_routing_rec.sourcerolekey
                    AND rc.targetrolekey   =v_routing_rec.targetrolekey
				WHERE rc.eventcode =appeventcode AND tm.teamid =v_teamid
                AND tm.isdefaultroute  =1
				AND tma.activeflag =1 limit 1;
		 ELSE  
		        SELECT v_tosecurityusersid , COALESCE(up.firstname,'') || ' ' || COALESCE(up.lastname,'')  
			    INTO v_tosecurityusersid, v_username
			    FROM userprofile up 
				WHERE up.securityusersid = v_securityuserid;
		 END if;
			
		IF COALESCE(v_tosecurityusersid,'') <>'' then
		                SELECT routingid into v_routingid
			            FROM routing r WHERE tosecurityusersid = v_securityuserid 
			            AND activeflag =1
			            AND r.objectid  = v_objectid
			            ORDER BY insertedon desc limit 1;
				   
						UPDATE routing SET activeflag =0 ,remarks =v_notifymsg,updatedon= v_date 
						WHERE routingid = v_routingid;               
		
		                INSERT INTO routing(
									eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
									FROMroleid, toroleid,objectid , routingstatustypeid,
									insertedby,  updatedby,insertedon,updatedon,  
									servicerequestnumber,routeddescription)
		
						VALUES( appeventcode, v_securityuserid,
								v_tosecurityusersid   , v_teamid,
								v_routing_rec.sourcerolekey, v_routing_rec.targetrolekey,
								v_objectid,v_routingstatusid,
								v_securityuserid,v_securityuserid,
								v_date,v_date, null,v_routeddescription);
				 
		               v_msg:=  v_notifymsg || ' by '  ||   v_username;
		              
		  			SELECT send_notIFication INTO v_returnstatus FROM send_notIFication(v_tosecurityusersid
		                                                                      ,v_securityuserid, v_tosecurityusersid,
						'System', 'High', v_msg,
						 v_msg , v_objectid);
		                 v_returnstatus:='Success';
		ELSE
			v_returnstatus:='User not available for this role';
		
		END IF;
END LOOP;
-- 15 Review - 16 Approved - 17-reject
--IF v_typeofobject='Application' THEN
--   IF v_routingstatusid = 15 THEN
--    UPDATE tb_public_provider_applicant
--	SET application_status = 'Pending',
--	    update_user_id = v_securityuserid,
--        update_ts = v_date
--	WHERE applicant_id=v_objectid;
--   ELSIF v_routingstatusid = 16 THEN
--    UPDATE tb_public_provider_applicant
--	SET application_status = 'Approved',
--	    update_user_id = v_securityuserid,
--        update_ts = v_date
--	WHERE applicant_id=v_objectid;
--   ELSIF v_routingstatusid = 17 THEN
--    UPDATE tb_public_provider_applicant
--	SET application_status = 'Rejected',
--	    update_user_id = v_securityuserid,
--        update_ts = v_date
--	WHERE applicant_id=v_objectid;
--   END IF;
--END IF;
IF v_typeofobject='Pre-App' and v_routingstatusid=16 THEN
   UPDATE tb_public_provider_applicant
	SET phase = 'Application',
	    update_user_id = v_securityuserid,
        update_ts = v_date
	WHERE applicant_id=v_objectid;
END IF;
RETURN  v_returnstatus::text;
END;                 
 
$function$;


