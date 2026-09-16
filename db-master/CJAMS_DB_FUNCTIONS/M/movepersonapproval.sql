DROP FUNCTION IF EXISTS cjams.movepersonapproval(v_touserid uuid, v_fromuserid uuid, programs jsonb, casetype character varying, v_status character varying, eventtype character varying, l_personid uuid, l_caseid uuid, v_comments character varying);

CREATE OR REPLACE FUNCTION cjams.movepersonapproval(v_touserid uuid, v_fromuserid uuid, programs jsonb, casetype character varying, v_status character varying, eventtype character varying, l_personid uuid, l_caseid uuid, v_comments character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 01/13/2025 Sandeep Kiran Anugou - B-123960- CIDM-10020 - Person card Move based on program assignment
-- 01/14/2025 Sandeep Kiran Anugou/AKhil Katukuri - B-123960- CIDM-10020 - Person card move updates
-- 01/30/2025 Sandeep Kiran Anugou/AKhil Katukuri - B-123960- CIDM-10020 - Updated to add notifications and review comments
------------------------------------------------------------------------------------------------------------  

DECLARE 
    l_actorId uuid;
    description character varying;
    routingstatustypeid int4;
   householdswitchValue character varying;
	currentRow json;
	v_endValues jsonb;
v_notifystatus character varying;  
	 v_msg character varying;   
	  v_username character varying; 
	  l_touserid uuid;    

begin
	l_touserid := v_touserid;
    if(eventType = 'MPAI') then
        description = 'Moved from Active to Inactive screen';
    else
        description = 'Moved from Inactive to Active screen';
    end if;
	SELECT COALESCE(lastname,'')||', '|| COALESCE(firstname,'')into v_username                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                    FROM userprofile WHERE securityusersid = v_fromuserid::character varying;
	v_msg:= 'Move Person request ' || COALESCE( v_status,'') || ' by ' ||COALESCE( v_username,''); 
    if(v_status = 'Review') then
       routingstatustypeid := 15;
       householdswitchValue := 'PRRV';
	   SELECT COALESCE(lastname,'')||', '|| COALESCE(firstname,'')into v_username                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                    FROM userprofile WHERE securityusersid = v_touserid::character varying;
		v_msg:= 'Move Person request ' || COALESCE( v_status,'') || ' sent to ' ||COALESCE( v_username,''); 
    elseif(v_status = 'Approved') then
       routingstatustypeid := 16;
      householdswitchValue := 'PRAP';
    elseif(v_status = 'Rejected') then
      routingstatustypeid := 17;
     householdswitchValue := 'PRRJ';
    end if;
    
    select actorid  into l_actorId from actor where personid =l_personId and activeflag =1 and (servicecaseid = l_caseId or intakeserviceid = l_caseId);

    --    Send for approval(CPS/NonCPS)
    if(v_status= 'Review') then
		update routing
		set activeflag = 0,
		updatedby = v_fromuserid,
		updatedon=now()
		where objectid = l_actorId:: character varying;
    
	    UPDATE cjams.actor
	    SET updatedby=v_fromuserid, 
	    updatedon=now(), 
	    householdswitch=householdswitchValue
	    WHERE actorid=l_actorId;
	    
	    INSERT INTO cjams.moveperson_history(movepersonhistoryid, insertedby, insertedon, updatedby, updatedon, fromuserid, touserid, objectid, endvalue, status, activeflag, actiondescription, casetype, objecttype)
	    VALUES(gen_random_uuid(), v_fromuserid, now(), v_fromuserid, now(), v_fromuserid, v_touserid, l_actorId, programs::json, v_status, 1, description, casetype, 'actor');
	
	     INSERT INTO cjams.routing
	    (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
	    VALUES(gen_random_uuid(), eventType, v_fromuserid, v_touserid, v_fromuserid::uuid, 'CWCW', 'CWSP', l_actorId, routingstatustypeid, 1, v_fromuserid, now(), v_fromuserid, now(), true, 'Forwarded to Case Supervisor', NULL, description, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
	else

		if(casetype='NonCPS' AND v_status= 'Approved') then
		-- end person programs
		SELECT mph.endvalue into v_endValues FROM moveperson_history mph where mph.objectid = l_actorId:: character varying;		
		for currentRow IN SELECT * from jsonb_array_elements(v_endValues)
			loop
				update personprogramarea
				set enddate = (currentRow->>'enddate')::timestamp,
				endreasonkey = currentRow->>'endreasonkey',
				updatedon=now(),
				updatedby=v_fromuserid
				where personprogramid = (currentRow->>'personprogramid')::uuid;
			end loop;
		end if;
		
		UPDATE cjams.actor
	    SET updatedby=v_fromuserid, 
	    updatedon=now(), 
	    householdswitch=householdswitchValue
	    WHERE actorid=l_actorId;
	   
		select fromuserid into l_touserid from moveperson_history WHERE objectid = l_actorId:: character varying and activeflag=1 and status='Review';

	   UPDATE cjams.moveperson_history
		SET status = v_status,
		comments = v_comments,
		updatedby = v_fromuserid,
		updatedon = now()
		WHERE objectid = l_actorId:: character varying and activeflag=1 and status='Review';

	
		update routing
		set activeflag = 0,
		updatedby = v_fromuserid,
		updatedon=now()
		where objectid = l_actorId:: character varying;
	
		INSERT INTO cjams.routing
	    (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
	    VALUES(gen_random_uuid(), eventType, v_fromuserid, l_touserid, v_fromuserid::uuid, 'CWCW', 'CWSP', l_actorId, routingstatustypeid, 1, v_fromuserid, now(), v_fromuserid, now(), true, 'Supervisor Reviewed', NULL, description, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, v_status, NULL);

    end if;
		--Send Notification
    	SELECT send_notIFication INTO v_notIFystatus FROM cjams.send_notification(l_touserid::character varying, v_fromuserid::character varying, l_touserid::character varying, 'System', 'High', v_msg, v_msg , l_caseid::character varying, false, l_actorId);
    RETURN 'success';
end;

$function$
;
