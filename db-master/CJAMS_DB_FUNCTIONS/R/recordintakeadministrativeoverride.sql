drop function if exists cjams.recordintakeadministrativeoverride(jsonb);
CREATE OR REPLACE FUNCTION cjams.recordintakeadministrativeoverride(request jsonb)
 RETURNS text
 LANGUAGE plpgsql
AS $function$                                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                          
 DECLARE                                                                                                                                                                                                                                     
 v_intakeserviceid uuid;   
 v_intakeserviceid_forOverride uuid;                                                                                                                                                                                                                     
 v_servicecaseid uuid;
 v_intakesnapshotid character varying;
 l_status text;
 v_fromsecurityusersid uuid;
 v_tosecurityusersid uuid;
v_teamid uuid;
 v_intakenumber character varying;
 v_msg character varying;
 v_cpsstatus character varying;
 v_intakeapproveddate timestamp;
 v_notifystatus character varying;
 v_reviewstatus jsonb;
 v_tonotification character varying;
 v_fromnotification character varying;
 v_contactmadewithhhmember boolean;
 v_intakerecomendation character varying;
 v_supervisoroverridetype character varying;
 v_action character varying;
 v_toroleid character varying;
 v_fromroleid character varying;
 intakedastaging_id bigint;
 intakesnapshot_id uuid;
 V_last_supDisposition character varying;
                                                                                                                                                                                                                                                                         
 begin
	 v_action := request ->> 'supervisoroverridetype';
	  v_fromsecurityusersid := request ->> 'securityusersid';
	 v_intakenumber := request ->> 'intakeNumber';
	  v_contactmadewithhhmember := request ->> 'contactmadewithhhmember';
	   v_intakerecomendation :=request ->> 'intakeRecomendation';
	 v_supervisoroverridetype :=request ->> 'supervisoroverridetype';
	SELECT isr.intakeserviceid, isr.insertedon, isr.servicecaseid,
	( CASE isr.activeflag WHEN 2 THEN 'Closed At Intake' ELSE irst.intakeserreqstatustypekey END )
	into v_intakeserviceid, v_intakeapproveddate, v_servicecaseid, v_cpsstatus
	from intakeservicerequest isr
	JOIN  intakeserreqstatustype  irst  on  irst.intakeserreqstatustypeid  =  isr.intakeserreqstatustypeid
	where isr.intakenumber = v_intakenumber and isr.activeflag in (1, 2) order by isr.updatedon limit 1;

	-- IF (v_cpsstatus='Closed' and  v_action !='worker' & v_action ) THEN		
	-- 	SELECT CASE ((jsondata->>'disposition')::json #>>'{0}')::json->>'DADisposition' 
	-- 		WHEN 'screenout' THEN 'Closed At Intake'
	-- 		WHEN 'OvrScrnout' THEN 'Closed At Intake'
	-- 		WHEN 'ScreenOUT' THEN 'Closed At Intake'
	-- 		ELSE  v_cpsstatus
	-- 		END INTO v_cpsstatus
	-- 	FROM intakesnapshot i WHERE intakenumber = v_intakenumber AND activeflag = 1 ORDER BY insertedon LIMIT 1;
        
	-- 	SELECT CASE ((jsondata->>'disposition')::json #>>'{0}')::json->>'supDisposition' 
	-- 		WHEN 'screenout' THEN 'Closed At Intake'
	-- 		WHEN 'OvrScrnout' THEN 'Closed At Intake'
	-- 		WHEN 'ScreenOUT' THEN 'Closed At Intake'
	-- 		ELSE  v_cpsstatus
	-- 		END INTO v_cpsstatus
	-- 	FROM intakesnapshot i WHERE intakenumber = v_intakenumber AND activeflag = 1 ORDER BY insertedon LIMIT 1;    
	-- END IF;

	IF( v_action='worker' or v_action = 'narrative') THEN
	 select intakesnapshotid into v_intakesnapshotid from intakesnapshot where intakeserviceid=v_intakeserviceid and activeflag = 1 order by updatedon limit 1;
	 select fromsecurityusersid,teamid,fromroleid,toroleid,supervisordecision into v_tosecurityusersid,v_teamid,v_toroleid,v_fromroleid,V_last_supDisposition
	  from routing where objectid = v_intakenumber and activeflag=1;
	        update routing
				set activeflag = 0,
				--eventcode = 'XXXX',
				updatedon = now(),
				updatedby = v_fromsecurityusersid
				where objectid = v_intakenumber and activeflag=1;
				if(v_action ='worker') then 
						INSERT INTO routing (
						eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid, routingstatustypeid, activeflag,
						insertedby, updatedby, insertedon, updatedon, isreviewrequest,
						servicerequestnumber, remarks, routeddescription,intakerecommendation,supervisordecision )
				VALUES ('INTR', v_fromsecurityusersid, v_tosecurityusersid, v_teamid, 
						v_fromroleid, v_toroleid, v_intakenumber, 861, 1,
						v_fromsecurityusersid, v_fromsecurityusersid, now(), now(), false, 
						' ', 'Return to worker', 'Return to Worker',v_intakerecomendation,'Return to Worker');  
				else 
				INSERT INTO routing (
						eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid, routingstatustypeid, activeflag,
						insertedby, updatedby, insertedon, updatedon, isreviewrequest,
						servicerequestnumber, remarks, routeddescription,intakerecommendation,supervisordecision )
				VALUES ('INTR', v_fromsecurityusersid, v_fromsecurityusersid, v_teamid, 
						v_fromroleid, v_fromroleid, v_intakenumber, 860, 1,
						v_fromsecurityusersid, v_fromsecurityusersid, now(), now(), true, 
						' ',  'Navigate to Narrative', 'Navigate to Narrative',v_intakerecomendation,'Navigate to Narrative');  
				end if;

			update administrativeoverrides
			set activeflag = 0,
			updatedon = now(),
			updatedby = v_fromsecurityusersid
			where entityid = v_intakenumber;
			if(V_last_supDisposition = 'scrnin') 
			then
			v_intakeserviceid_forOverride := v_intakeserviceid;			
			else
			v_intakeserviceid_forOverride := '00000000-0000-0000-0000-000000000000';
			end if;
			

			


         INSERT INTO administrativeoverrides (approvalid,entitytypekey,entityid,referralsnapshotid,overridereasontypekey,overridetypekey,overridedate,overridetimestamp,overridestaffid,"comments",insertedon,insertedby,updatedon,updatedby,activeflag,intakeserviceid,overridekeyid,intakeapproveddate,contactmadewithhhmember) VALUES 
			('00000000-0000-0000-0000-000000000000','2530',v_intakenumber,v_intakesnapshotid,
			request ->> 'overrideReason','2530',(request ->> 'overrideDate')::timestamp,(request ->> 'overrideDate')::timestamp,
			v_fromsecurityusersid,request ->> 'overrideComment',now(),v_fromsecurityusersid,now(),v_fromsecurityusersid,1,
			v_intakeserviceid_forOverride,1,v_intakeapproveddate,v_contactmadewithhhmember);
				-- 		jsonb (jsondata->'reviewstatus')- 'ismanualrouting'-'assignsecurityuserid'-'status'-'appevent' || jsonb '{"status": "","appevent": "DRAFT"}'
				-- into v_reviewstatus from intakedastaging where intakenumber = v_intakenumber and activeflag=1;

				-- update intakedastaging
				-- set jsondata = (select jsonb (jsondata) - 'reviewstatus' || jsonb(json_build_object ('reviewstatus',v_reviewstatus)) from intakedastaging where intakenumber = v_intakenumber and activeflag = 1 limit 1),
				-- status = 'pending',
				-- updatedon = now(),
				-- updatedby = v_fromsecurityusersid
				-- where intakenumber = v_intakenumber and activeflag = 1;

				INSERT INTO cjams.intakedastaging
(intakenumber, daterecieved, narrative, raname, entityname, cruworkername, "data", insertedon, insertedby, updatedon, updatedby, status, jsondata, activeflag, versionnumber, timerecieved, dispositiondescription, statusdescription, intakeuser, ispreintake, isclw, clwstatus, old_id, sstastatustypekey, focuspersonid, isrestricteditem, supervisordecision, intakedecision, supervisorstatus, approvaldate, teamtypekey)
SELECT  intakenumber, daterecieved, narrative, raname, entityname, cruworkername, "data", now(), insertedby, updatedon, updatedby, status, jsondata, activeflag, versionnumber+1, timerecieved, dispositiondescription, statusdescription, intakeuser, false, isclw, clwstatus, old_id, sstastatustypekey, focuspersonid, isrestricteditem, supervisordecision, intakedecision, supervisorstatus, approvaldate, teamtypekey
FROM cjams.intakedastaging
where intakenumber =v_intakenumber and activeflag=1  order by updatedon desc limit 1 returning id into intakedastaging_id ;
update intakedastaging set activeflag=0  where intakenumber =v_intakenumber and id !=intakedastaging_id  ;

UPDATE intakedastaging
SET 
updatedby = v_fromsecurityusersid, updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
where intakenumber =v_intakenumber and activeflag =1;

UPDATE intakedastaging
SET 
updatedby = v_fromsecurityusersid, updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{DAStatus}', '""'))))
where intakenumber =v_intakenumber and activeflag =1;

UPDATE intakedastaging
SET 
updatedby = v_fromsecurityusersid, updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supStatus}', '""'))))
where intakenumber =v_intakenumber and activeflag =1;

UPDATE intakedastaging
SET 
updatedby = v_fromsecurityusersid, updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{DADisposition}', '""'))))
where intakenumber =v_intakenumber and activeflag =1;

INSERT INTO cjams.intakesnapshot
( intakenumber, intakeserviceid, approvedate, jsondata, approverusersid, activeflag, insertedby, insertedon, updatedby, updatedon, old_id)
select  intakenumber, intakeserviceid, approvedate, jsondata, approverusersid, activeflag, insertedby, now(), updatedby, updatedon, old_id
from cjams.intakesnapshot where intakenumber =v_intakenumber and activeflag=1 order by updatedon desc limit 1 returning intakesnapshotid into intakesnapshot_id  ;

update intakesnapshot set activeflag=0,updatedby = v_fromsecurityusersid, updatedon = now()  where intakenumber =v_intakenumber and intakesnapshotid !=intakesnapshot_id;

UPDATE intakesnapshot
SET 
updatedby = v_fromsecurityusersid, updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{DAStatus}', '""'))))
where intakenumber =v_intakenumber and activeflag =1;

UPDATE intakesnapshot
SET 
updatedby = v_fromsecurityusersid, updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supStatus}', '""'))))
where intakenumber =v_intakenumber and activeflag =1;

UPDATE intakesnapshot
SET 
updatedby = v_fromsecurityusersid, updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
where intakenumber =v_intakenumber and activeflag =1;


UPDATE intakesnapshot
SET 
updatedby = v_fromsecurityusersid, updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{DADisposition}', '""'))))
where intakenumber =v_intakenumber and activeflag =1;

				update intakedastaging
				set jsondata =  (select jsonb (jsondata) - 'disposition' || jsonb(json_build_object ('DADisposition',null)) from intakedastaging where intakenumber = v_intakenumber and activeflag = 1 limit 1),
				status = 'pending',
				updatedon = now(), ispreintake = false,
				updatedby = v_fromsecurityusersid
				where intakenumber = v_intakenumber and activeflag = 1;
-- update intakeservicerequestdispositioncode
-- 				set intakeserreqstatustypeid='c8dbf10f-843d-4b40-97ca-288d750463da',
-- 				updatedon = now(),
-- 				updatedby = v_fromsecurityusersid
-- 				where  intakeserviceid= (select intakeserviceid from intakeservicerequest where intakenumber = v_intakenumber and activeflag = 1) 
--  and activeflag = 1;

-- delete from intakeservicerequestdispositioncode where intakeserviceid ='fcc154e1-7c9b-47c0-85b9-7a2f66d896e1';
				update intakedastaging
				set jsondata =  (select jsonb (jsondata) - 'disposition' || jsonb(json_build_object ('dispositioncode',null)) from intakedastaging where intakenumber = v_intakenumber and activeflag = 1 limit 1),
				status = 'pending',
				updatedon = now(), ispreintake = false,
				updatedby = v_fromsecurityusersid
				where intakenumber = v_intakenumber and activeflag = 1;

						l_status := 'success';

	END IF;

	-- if(v_action='narrative') then 
	--     select teamid into v_teamid from routing where objectid = v_intakenumber and activeflag=1;

    --     INSERT INTO routing (
	-- 					eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
	-- 					fromroleid, toroleid, objectid, routingstatustypeid, activeflag,
	-- 					insertedby, updatedby, insertedon, updatedon, isreviewrequest,
	-- 					servicerequestnumber, remarks, routeddescription )
	-- 			VALUES ('xxxx', v_fromsecurityusersid, v_fromsecurityusersid, v_teamid, 
	-- 					'CWSP', 'CWSP', v_intakenumber, 860, 1,
	-- 					v_fromsecurityusersid, v_fromsecurityusersid, now(), now(), false, 
	-- 					' ', 'return to narrative', 'return to narrative');  
	-- END IF;
	IF( v_action !='worker' and v_action != 'narrative') THEN
	if (v_cpsstatus='Closed' or v_cpsstatus='Completed') then 
		l_status := 'invalid-cc';
	    elsif(v_servicecaseid is null) then
		if(v_intakeserviceid is not null) then 
			select intakesnapshotid into v_intakesnapshotid from intakesnapshot where intakeserviceid=v_intakeserviceid and activeflag = 1 order by updatedon limit 1;
		
			update intakesnapshot
			set activeflag = 0,
			updatedon = now(),
			updatedby = v_fromsecurityusersid
			where intakesnapshotid::character varying = v_intakesnapshotid;

			update administrativeoverrides
			set activeflag = 0,
			updatedon = now(),
			updatedby = v_fromsecurityusersid
			where intakeserviceid = v_intakeserviceid;
		
			INSERT INTO administrativeoverrides (approvalid,entitytypekey,entityid,referralsnapshotid,overridereasontypekey,overridetypekey,overridedate,overridetimestamp,overridestaffid,"comments",insertedon,insertedby,updatedon,updatedby,activeflag,intakeserviceid,overridekeyid,intakeapproveddate,contactmadewithhhmember) VALUES 
			('00000000-0000-0000-0000-000000000000','2530',v_intakenumber,v_intakesnapshotid,request ->> 'overrideReason','2530',(request ->> 'overrideDate')::timestamp,(request ->> 'overrideDate')::timestamp,v_fromsecurityusersid,request ->> 'overrideComment',now(),v_fromsecurityusersid,now(),v_fromsecurityusersid,1,v_intakeserviceid,1,v_intakeapproveddate,v_contactmadewithhhmember);
		
			if((select count(*) from administrativeoverrides where entityid = v_intakenumber and activeflag=1) = 0) then
				l_status := 'failure';
			else
				update intakeservicerequestsdm
				set activeflag = 0,
				updatedon = now(),
				updatedby = v_fromsecurityusersid
				where intakeserviceid = v_intakeserviceid;
			--Remove the case connection with existing service case if available
				update intakeservicerequest
				set activeflag = 0,
				servicecaseid = null,
				updatedon = now(),
				updatedby = v_fromsecurityusersid				
				where intakenumber = v_intakenumber;

				update caseassignment 
				set activeflag = 0, 
				updatedon = now(), 
				updatedby = v_fromsecurityusersid 
				where objectid = v_intakeserviceid and activeflag = 1;

			
				select fromsecurityusersid into v_tonotification
				from routing
				where objectid = v_intakenumber ORDER BY insertedon LIMIT 1;
				
				update routing
				set activeflag = 0,
				eventcode = 'XXXX',
				updatedon = now(),
				updatedby = v_fromsecurityusersid
				where objectid = v_intakenumber;
			
				update intakedastatus
				set status = null,
				updatedon = now(),
				updatedby = v_fromsecurityusersid
				where intakenumber = v_intakenumber and activeflag=1;
							
				select 
				jsonb (jsondata->'reviewstatus')- 'ismanualrouting'-'assignsecurityuserid'-'status'-'appevent' || jsonb '{"status": "","appevent": "DRAFT"}'
				into v_reviewstatus from intakedastaging where intakenumber = v_intakenumber and activeflag=1;
		
				update intakedastaging
				set jsondata = (select jsonb (jsondata) - 'reviewstatus' || jsonb(json_build_object ('reviewstatus',v_reviewstatus)) from intakedastaging where intakenumber = v_intakenumber and activeflag = 1 limit 1),
				status = 'pending',
				updatedon = now(),
				updatedby = v_fromsecurityusersid
				where intakenumber = v_intakenumber and activeflag = 1;
				
				update intakedastaging
				set jsondata =  (select jsonb (jsondata) - 'disposition' || jsonb(json_build_object ('disposition',null)) from intakedastaging where intakenumber = v_intakenumber and activeflag = 1 limit 1),
				status = 'pending',
				updatedon = now(), ispreintake = false,
				updatedby = v_fromsecurityusersid
				where intakenumber = v_intakenumber and activeflag = 1;

				update personprogramarea
				set activeflag = 0,
				updatedon = now(),
				updatedby = v_fromsecurityusersid
				where objectid = v_intakeserviceid:: character varying;
 				
				select fullname || ' overrode the decision on ' || v_intakenumber || ' and sent back the intake' into v_msg from userprofile where securityusersid = v_fromsecurityusersid::character varying;
				
				select send_notification into v_notifystatus from send_notification(
					v_tonotification, v_fromsecurityusersid::character varying, v_tonotification, 'System', 'Normal', v_msg, v_msg, v_intakenumber
					);
					
				l_status := 'success';
			end if;
		else 
			l_status := 'failure';
		end if;
	else
		l_status := 'invalid-sc';
	end if;   
	END IF;                                                                                                                                                                                                                                                           
 RETURN l_Status;                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                         
 END;                                                                                                                                                                                                                                                                    

$function$
;