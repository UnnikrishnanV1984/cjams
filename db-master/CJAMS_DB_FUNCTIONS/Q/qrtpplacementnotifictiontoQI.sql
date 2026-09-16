DROP FUNCTION IF EXISTS cjams.qrtpplacementnotifictiontoQI(uuid, character varying, uuid);
CREATE OR REPLACE FUNCTION cjams.qrtpplacementnotifictiontoQI(userid uuid, v_message character varying,v_objectid uuid)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Smitha Somasekharan
-- Date Created : 06/11/2024 

-- Stored Procedure to Send Notification to multiple QI
-- Revision(s)
------------------------------------------------------------------------    

DECLARE
	
	v_data record;
	v_date timestamp without time zone;
	v_objecttype CHARACTER VARYING;
	v_objectcasenumber CHARACTER VARYING;
	v_usernotificationid uuid;
    v_countyid character varying;

BEGIN
v_date:= now();
	

 SELECT 'servicecase', sc.servicecasenumber 
			INTO v_objecttype, v_objectcasenumber
		FROM servicecase sc 
		WHERE sc.servicecaseid = v_objectid::uuid 
			AND sc.activeflag = 1;

select t.countyid into v_countyid from teammemberassignment tma join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1                                                                                                                                              
                         join team t on t.teamid = tm.teamid and t.activeflag = 1                                                                                                                                                                                                                                    
                         where tma.activeflag = 1 and tma.securityusersid = userid::character varying limit 1; 
FOR v_data IN 		
			
select * from(
select m.securityusersid,t.countyid  from cjams.userresource u 
inner join muser m on m.id=u.userid  and m.activeflag =1
inner join teammemberassignment tma on tma.securityusersid = m.securityusersid and  tma.activeflag=1
inner join teammember tm on tm.teammemberid =tma.teammemberid and tm.activeflag=1
inner join team t on t.teamid =tm.teamid and t.activeflag  =1
inner join rolemapping r2 on r2.principalid = m.id::varchar and r2.activeflag =1 and r2.teamtypekey ='CW'
--inner join role r3 on r3.id = r2.id  
inner join cjams.permissiongroup p  on p.permissiongroupid = u.permissiongroupid and p.activeflag =1
inner join cjams.role r on r.id = u.roleid 
inner join v_userprofile vu on vu.securityusersid = m.securityusersid 
where p.permissiongroupname  in (
'QUALIFIED_INDIVIDUAL_Worker'
) -- permissiongroupid ='4ba216d8-5eb2-4164-b01b-e19452425387'
and u.activeflag =1


union all

select m.securityusersid , t.countyid

from rolemapping r  
inner join muser m on m.id::varchar = r.principalid 
inner join teammemberassignment tma on tma.securityusersid = m.securityusersid and  tma.activeflag=1
inner join teammember tm on tm.teammemberid =tma.teammemberid and tm.activeflag=1
inner join team t on t.teamid =tm.teamid and t.activeflag  =1
inner join role ro on ro.id = r.roleid and ro.activeflag =1
inner join v_userprofile vu on vu.securityusersid = m.securityusersid 

where r.roleid  in (5988) and r.teamtypekey='CW' and r.activeflag =1
)a 
where a.countyid =v_countyid
		
                    
    LOOP
		--RAISE NOTICE 'v_data.toworkeridno',v_data.toworkeridno;
		RAISE NOTICE 'Test1 >> %',v_data.securityusersid;
    	
		INSERT INTO usernotification 
		(	securityusersid,usernotificationtypekey,                                                                                                                                                                                                                                                                                   
			objectid,activeflag,subject,priorityleveltypekey,body,isexternalentity,updatedby,                                                                                                                                                                                                                                                                        
			updatedon,insertedby,insertedon,effectivedate,ismailsent, objecttype, objectcasenumber, 
			teamtypekey,old_id
		)
	VALUES 
		(	v_data.securityusersid, 'System', v_objectid, 1, v_message,                                                                                                                                                                                                                                                                        
			'High', v_message,false, userid ,                                                                                                                                                                                                                                                                                        
			v_date, userid,v_date,v_date,false, v_objecttype, v_objectcasenumber, 'CW','QRPL01'
		)  RETURNING "usernotificationid" INTO  v_usernotificationid;    

		
		RAISE NOTICE 'Test2 >> %',v_usernotificationid;
		                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                          
	INSERT INTO usernotificationmap
		(	usernotificationid,fromsecurityusersid,tosecurityusersid,isread,
			effectivedate,activeflag,updatedby,updatedon,insertedby,insertedon
		)
	VALUES 
		(	v_usernotificationid, userid,v_data.securityusersid, false,
			v_date, 1, userid,v_date, userid,v_date
		);
  END LOOP;  
    
	

RETURN 'success';

END;

$function$
;
