DROP FUNCTION IF EXISTS cjams.send_qrtppartb_notification(v_fromuserid uuid, v_message character varying, v_objectid character varying, v_assessmentid uuid,v_notificationcode);
DROP FUNCTION IF EXISTS cjams.send_qrtppartb_notification(uuid, character varying, character varying, uuid);
DROP FUNCTION IF EXISTS cjams.send_qrtppartb_notification(uuid, character varying, character varying);
CREATE OR REPLACE FUNCTION cjams.send_qrtppartb_notification(v_fromuserid character varying, v_message character varying, v_objectid character varying,v_assessmentid uuid,v_notificationcode character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vigneshwar Kumar
-- Date Created : 01/11/2023 

-- Stored Procedure to Send Notification to multiple user based on role
-- Revision(s)
-- 04/08/2024 -Smitha Somasekharan - To add  notification when Qualified Individual completes assessment
------------------------------------------------------------------------  

DECLARE
	
	v_data record;
	v_date timestamp without time zone;
	v_objecttype CHARACTER VARYING;
	v_objectcasenumber CHARACTER VARYING;
	v_usernotificationid uuid;

BEGIN
v_date:= now();
	
-- 	FOR v_data IN 
-- 			select distinct vu.securityusersid
-- 			from caseassignment ca
-- 			inner join v_userprofile vu on ca.toworkeridno = vu.securityusersid 
-- 			where (vu.roletypekey in ('QUINW','FTDMQIS') 
-- 							or vu.securityusersid in (
-- 								select distinct vu.securityusersid from v_userprofile vu
-- 								inner join userresource u on u.userid = vu.userid
-- 								inner join permissiongroup pg on pg.permissiongroupid = u.permissiongroupid 
-- 								where pg.activeflag = 1 and permissiongroupname in ('QUALIFIED_INDIVIDUAL_Worker','FTDM_QI_SUPERVISOR')
-- 							)
			
-- 			) and ca.objectid::character varying = $3 and ca.enddate is null
-- 			--order by ca.insertedon
--     LOOP
		
--     	PERFORM send_notification(v_data.securityusersid::character varying, $1::character varying, v_data.securityusersid, 'System', 'High', $2, $2::text, $3, false);
    
--     END LOOP;
-- RETURN 'success';
 SELECT 'servicecase', sc.servicecasenumber 
			INTO v_objecttype, v_objectcasenumber
		FROM servicecase sc 
		WHERE sc.servicecaseid = v_objectid::uuid 
			AND sc.activeflag = 1;
FOR v_data IN 		
			

			select ca.toworkeridno
                        from caseassignment ca  
                        join userprofile up on up.securityusersid = ca.toworkeridno
                            and up.activeflag  = 1
                    where ca.objectid ::character varying = $3
                        and lower(ca.responsibilitytypekey) in ('family', 'child')
                        and ca.activeflag = 1
                        and ca.enddate is null 
                    
    LOOP
		--RAISE NOTICE 'v_data.toworkeridno',v_data.toworkeridno;
		RAISE NOTICE 'Test1 >> %',v_data.toworkeridno;

    	---PERFORM send_notification(v_data.toworkeridno::character varying, $1::character varying, v_data.toworkeridno, 'System', 'High', $2, $2::text, $3, false);
		INSERT INTO usernotification 
		(	securityusersid,usernotificationtypekey,                                                                                                                                                                                                                                                                                   
			objectid,activeflag,subject,priorityleveltypekey,body,isexternalentity,updatedby,                                                                                                                                                                                                                                                                        
			updatedon,insertedby,insertedon,effectivedate,ismailsent, objecttype, objectcasenumber, 
			teamtypekey,old_id,entityid
		)
	VALUES 
		(	v_data.toworkeridno, 'System', v_objectid, 1, v_message,                                                                                                                                                                                                                                                                        
			'High', v_message,false, v_fromuserid ,                                                                                                                                                                                                                                                                                        
			v_date,v_fromuserid,v_date,v_date,false, v_objecttype, v_objectcasenumber, 'CW',v_notificationcode,v_assessmentid
		)  RETURNING "usernotificationid" INTO  v_usernotificationid;    

		--RAISE NOTICE 'v_usernotificationid',v_usernotificationid;
		RAISE NOTICE 'Test2 >> %',v_usernotificationid;
		                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                          
	INSERT INTO usernotificationmap
		(	usernotificationid,fromsecurityusersid,tosecurityusersid,isread,
			effectivedate,activeflag,updatedby,updatedon,insertedby,insertedon
		)
	VALUES 
		(	v_usernotificationid, v_fromuserid,v_data.toworkeridno, false,
			v_date, 1, v_fromuserid,v_date, v_fromuserid,v_date
		);
  END LOOP;
   FOR v_data IN 	
			select up.supervisorid 
                    from caseassignment ca  
                       join userprofile up on up.securityusersid = ca.toworkeridno
                            and up.activeflag  = 1
                    where ca.objectid ::character varying = $3
                        and lower(ca.responsibilitytypekey) in ('family', 'child')
                        and ca.activeflag = 1
                        and ca.enddate is null 
     LOOP		
    	--PERFORM send_notification(v_data.supervisorid::character varying, $1::character varying, v_data.supervisorid, 'System', 'High', $2, $2::text, $3, false);
			INSERT INTO usernotification 
		  (	securityusersid,usernotificationtypekey,                                                                                                                                                                                                                                                                                   
			objectid,activeflag,subject,priorityleveltypekey,body,isexternalentity,updatedby,                                                                                                                                                                                                                                                                        
			updatedon,insertedby,insertedon,effectivedate,ismailsent, objecttype, objectcasenumber, 
			teamtypekey,old_id,entityid
		)
	VALUES 
		(	v_data.supervisorid, 'System', v_objectid, 1, v_message,                                                                                                                                                                                                                                                                        
			'High', v_message,false, v_fromuserid ,                                                                                                                                                                                                                                                                                        
			v_date, v_fromuserid,v_date,v_date,false, v_objecttype, v_objectcasenumber, 'CW',v_notificationcode,v_assessmentid
		)  RETURNING "usernotificationid" INTO  v_usernotificationid;                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                                                          
	INSERT INTO usernotificationmap
		(	usernotificationid,fromsecurityusersid,tosecurityusersid,isread,
			effectivedate,activeflag,updatedby,updatedon,insertedby,insertedon
		)
	VALUES 
		(	v_usernotificationid, v_fromuserid,v_data.supervisorid, false,
			v_date, 1,v_fromuserid,v_date, v_fromuserid,v_date
		);
		    
    END LOOP;
   
    
	

RETURN 'success';

END;

$function$
;