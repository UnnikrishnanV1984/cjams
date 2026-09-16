drop function if exists cjams.sendNotificationForPrevRunAwayPlacement(servicecaseid uuid, objectid uuid, securityuserid character varying);

create or replace function cjams.sendNotificationForPrevRunAwayPlacement(servicecaseid uuid, objectid uuid, securityuserid character varying) 
returns text language plpgsql 
as $function$ 
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Pratap Paluru
-- Date Created : 07/18/2022 
-- Stored Procedure to Insert/Update the Notification for Runaway(CIDM-4942)

-- Revision(s)
-- 06/30/2023 Vineet Tirodkar - Sex trafficking user notification logic fix (CDM-32568)
------------------------------------------------------------------------  
declare v_status text;

	v_securityuserid character varying;
	v_livingarrangementtypekey character varying;
	v_persondetails character varying;
	v_objectid uuid;
	v_updatedon timestamp;
	vs_notification_txt character varying;
	case_assignment_worker_refcur REFCURSOR;
	case_assignment_worker record;
	v_sendnotification bool;
	vs_message character varying;
	vl_output_sqlcode character varying;
	v_servicecaseid uuid;
	v_notificationresponse character varying;
	v_usernotificationid uuid;
	v_objectcasenumber CHARACTER VARYING;

begin
	v_securityuserid := securityuserid;
	v_objectid := objectid;
	v_servicecaseid := servicecaseid;
	v_sendnotification := false;

	v_status := 'starting with objectid:' || v_objectid || ' servicecaseid:' || v_servicecaseid;
	-- RAISE NOTICE 'starting of ad sp %, service:%', v_objectid, v_servicecaseid;

	-- Get the last child placement exit reason or Living Arrangement Type
	select (case when pl.provider_id is not null then
				pl.exit_reason_cd
			else
				(select la.livingarrangementtypekey
					from livingarrangement la 
				 where la.placementid = pl.placementid
						and la.activeflag = 1
				)			
			end) 
		into v_livingarrangementtypekey
	from tb_placement pl 
	where pl.placementid <> v_objectid
		and pl.personid = (select personid 
							 from placement 
						   where placementid = v_objectid
							 and activeflag = 1
						  )
		and pl.approval_status_cd = '3047'	
		and coalesce(pl.void_sw, '') <> 'Y'  
	order by pl.entry_dt desc
	limit 1 ;

	/*
	select la.livingarrangementtypekey into v_livingarrangementtypekey
		from placement p
				inner join livingarrangement la on la.placementid = p.placementid and p.personid = la.personid 
				inner join routing r on r.objectid = v_objectid :: character varying and r.routingstatustypeid = 16 and r.activeflag = 1 and fromroleid = 'CWSP' and toroleid = 'CWCW' --and placmenttypekey = `
				inner join placementrevision p2 on p2.placementid = p.placementid and p2.activeflag = 1
				where p.servicecaseid = v_servicecaseid	and p.isvoided  = 0 and p.placementid != v_objectid	
				and p.personid = (select personid from placement where placementid = v_objectid and activeflag = 1)
				order by p.startdatetime desc	
				limit 1;
	*/
--		select '('||cjamspid || '/'|| lastname || ' ' || firstname || ')' into v_persondetails from person p
--			inner join placementid pl on pl.personid = p.personid and pl.activeflag =1
--		where pl.placementid = v_objectid;
	
	
	if v_livingarrangementtypekey is null then 
		-- Do not generate the notification.
	else
		-- Previous placement is run away. send a notification.
		if btrim(v_livingarrangementtypekey) 
			in  ( 	-- Placement exit_reason_cd
					'CIR', -- Child Issue: Runaway
					'CIPRA', -- Child Issue: Runaway
					'CIR', -- Child Issue: Runaway
					'CIPR', -- Runaway
					'PLCCRA', -- Runaway
					'RNAWAY', -- Runaway or Whereabouts Unknown
					-- Living Arrangement livingarrangementtypekey
					'UNK', -- Unknown
					'RNW' -- Runaway
				 ) then
			v_sendnotification := true;
		end if;	
	end if;
	
	
	/*
	if (v_livingarrangementtypekey is not null) then
	-- check previous placement exists. If no previous placement exists then Where abouts unknown case. need to send notification.        

		-- previous approved placement found
		if(v_livingarrangementtypekey = 'RNW' ) then
			-- previous placement is run away. send a notification.
			v_sendnotification := true;
		end if;
	else
		-- nore previous placement so it will be 'whereabout unknown' case send notification.
		v_sendnotification := true;
	end if;
	
	v_status := v_status || ', sendnotification' || v_sendnotification;
	RAISE NOTICE 'v_sendnotification:%',v_sendnotification;
	*/
	
	if v_sendnotification = true then
		select ' ('||cjamspid || '/'|| lastname || ' ' || firstname || ') ' into v_persondetails 
			from person 
		where personid  = (select personid from placement where placementid = v_objectid and activeflag = 1);
	
		v_status := v_status || ', livingarrangementtypekey:' || v_livingarrangementtypekey || ', v_persondetails:' ||v_persondetails;
		-- RAISE NOTICE 'v_livingarrangementtypekey:%, v_persondetails:%',v_livingarrangementtypekey, v_persondetails;

		vs_notification_txt := v_persondetails || 'sex trafficking information need to be updated.' || ' Please update the information in Person Card > Health Tab > Behavioral Health/Substance Use Card.';
		
		SELECT sc.servicecasenumber 
			INTO v_objectcasenumber 
		FROM servicecase sc  WHERE sc.servicecaseid = v_servicecaseid AND sc.activeflag = 1;
	
		-- taking approved placement record by checking status type = approvaed 16, and role from Supervisor (childwelfare Supervisor) to case worker (childwelfare case worker)
		open case_assignment_worker_refcur for
		select ca.toworkeridno 
			from caseassignment ca 
		where ca.objectid = v_servicecaseid 
			and (ca.enddate is null or ca.enddate >= now())
			and lower(ca.responsibilitytypekey) in ('family', 'child')
			and ca.activeflag = 1;

		-- select r.tosecurityusersid from routing r where r.objectid = v_objectid :: character varying and r.activeflag =1 and r.tosecurityusersid is not null
		-- and r.fromroleid = 'CWSP' and r.toroleid = 'CWCW' and r.routingstatustypeid = 16 limit 1;
		loop
			fetch case_assignment_worker_refcur into case_assignment_worker;
			exit when not found;
			RAISE NOTICE 'case_assignment_worker:%',case_assignment_worker.toworkeridno;
		
			INSERT INTO usernotification 
				(	securityusersid,usernotificationtypekey,objectid,activeflag,subject,
					priorityleveltypekey,body,isexternalentity,updatedby,                                                                                                                                                                                                                                                                        
					updatedon,insertedby,insertedon,effectivedate,ismailsent, objecttype, objectcasenumber, 
					teamtypekey, old_id, entityid
				)
			VALUES 
				(	case_assignment_worker.toworkeridno, 'System'::character varying, v_servicecaseid::character varying, 1, vs_notification_txt::character varying,
					'Normal'::character varying, vs_notification_txt::character varying,false, case_assignment_worker.toworkeridno,                                                                                                                                                                                                                                                                                        
					now(), case_assignment_worker.toworkeridno,now(),now(),false, 'servicecase', v_objectcasenumber, 
					'CW', 'MS_INITIAL', v_objectid
				)  RETURNING "usernotificationid" INTO  v_usernotificationid;                                                                                                                                                                                                                                             
																																																																																							
			INSERT INTO usernotificationmap
				(	usernotificationid,fromsecurityusersid,tosecurityusersid,isread,
					effectivedate,activeflag,updatedby,updatedon,insertedby,insertedon
				)
			VALUES 
				(	v_usernotificationid, case_assignment_worker.toworkeridno, case_assignment_worker.toworkeridno, false,
					now(), 1, case_assignment_worker.toworkeridno,now(), case_assignment_worker.toworkeridno, now()
				);
		
			v_status := v_status || ' notification sent to '|| case_assignment_worker.toworkeridno;
			v_notificationresponse = 'sucess';

			RAISE NOTICE 'v_notificationresponse:%',v_notificationresponse;
		end loop;
		close case_assignment_worker_refcur;
	end if;
	return v_status;

	EXCEPTION WHEN OTHERS THEN
		v_status := 'FAILED with  '||SQLERRM  ;
		vl_output_sqlcode := SQLSTATE;
		RAISE NOTICE 'SQLERRM%, SQLSTATE:%',sqlerrm, sqlstate ;
		--log error in some place for tracking.
	return v_status;
end;

$function$ ;