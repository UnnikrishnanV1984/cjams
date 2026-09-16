Drop function if exists cjams.placementrevisionupdate(
v_placementid character varying, 
v_startdate timestamp without time zone, 
v_starttime character varying, 
v_voidreasontypekey character varying, 
v_voidremarks character varying, 
v_enddate timestamp without time zone, 
v_endtime character varying, 
v_exittypekey character varying, 
v_remarks character varying, 
v_exitreasontypekey character varying, 
v_isvoid integer, 
securityuserid character varying, 
v_voiddate timestamp without time zone, 
v_justification character varying, 
v_ischangepreadoptive boolean, 
v_transferagency character varying,
v_otherpublicagency character varying,
v_leastrestrictiveplacement character varying
) ;
Drop function if exists cjams.placementrevisionupdate(
v_placementid character varying, 
v_startdate timestamp without time zone, 
v_starttime character varying, 
v_voidreasontypekey character varying, 
v_voidremarks character varying, 
v_enddate timestamp without time zone, 
v_endtime character varying, 
v_exittypekey character varying, 
v_remarks character varying, 
v_exitreasontypekey character varying, 
v_isvoid integer, 
securityuserid character varying, 
v_voiddate timestamp without time zone, 
v_justification character varying, 
v_ischangepreadoptive boolean, 
v_transferagency character varying,
v_otherpublicagency character varying,
v_leastrestrictiveplacement character varying,
v_luggage character varying ,
v_luggagepurchased character varying ,
v_luggagecomments character varying 
) ;
Drop function if exists cjams.placementrevisionupdate(
v_placementid character varying, 
v_startdate timestamp without time zone, 
v_starttime character varying, 
v_voidreasontypekey character varying, 
v_voidremarks character varying, 
v_enddate timestamp without time zone, 
v_endtime character varying, 
v_exittypekey character varying, 
v_remarks character varying, 
v_exitreasontypekey character varying, 
v_isvoid integer, 
securityuserid character varying, 
v_voiddate timestamp without time zone, 
v_justification character varying, 
v_ischangepreadoptive boolean, 
v_transferagency character varying,
v_otherpublicagency character varying,
v_leastrestrictiveplacement character varying,
v_luggage boolean ,
v_luggagepurchased boolean ,
v_luggagecomments character varying 
) ;
DROP FUNCTION if exists cjams.placementrevisionupdate(character varying, timestamp without time zone,  character varying, character varying, character varying, timestamp without time zone,character varying,character varying, character varying,character varying,integer, character varying, timestamp without time zone, character varying, boolean,  character varying , character varying , character varying,  boolean ,boolean, character varying,boolean);
CREATE OR REPLACE FUNCTION cjams.placementrevisionupdate(v_placementid character varying, v_startdate timestamp without time zone, v_starttime character varying, v_voidreasontypekey character varying, v_voidremarks character varying, v_enddate timestamp without time zone, v_endtime character varying, v_exittypekey character varying, v_remarks character varying, v_exitreasontypekey character varying, v_isvoid integer, securityuserid character varying, v_voiddate timestamp without time zone, v_justification character varying, v_ischangepreadoptive boolean, v_transferagency character varying DEFAULT NULL::character varying, v_otherpublicagency character varying DEFAULT NULL::character varying, v_leastrestrictiveplacement character varying DEFAULT NULL::character varying, v_luggage boolean DEFAULT NULL::boolean, v_luggagepurchased boolean DEFAULT NULL::boolean, v_luggagecomments character varying DEFAULT NULL::character varying,v_placementdisposableortrashbag boolean DEFAULT NULL::boolean,v_exitluggage boolean DEFAULT NULL::boolean , v_exitluggageprovided boolean DEFAULT NULL::boolean, v_exitluggagecomments character varying DEFAULT NULL::character ,v_exitdisposableortrashbag boolean DEFAULT NULL::boolean)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 06/17/2021 Vineet Tirodkar - Modifications to capture the original placement revision for Migrated data (B-81542)
-- 08/08/2022 Pratap - Modifications to capture Least Restrictive Placement for the child information (B-126654)
-- 01/24/2023 Prashanth Sampathirao- Added transferagency and otherpublicagency (CDM-6419)(B-130562)
-- 07-21-2023 - Veera CDM-32945 data type change for placement
-- 07/18/2024 Smitha Somasekharan - Modifications for luggage indicator n placement userstory -(CIDM-9031-B-195080)
-- 08/22/2024 - CIDM-9160 - Veera changes for Living arrangement and hospitalization user story 
--01/06/2025-CIDM-10008 -Smitha Somasekharan -changes for adding disposable or trashbag in luggage questions
--2/26/2025 Smitha Somasekharan -Modifications for luggage question update userstory- (CIDM-10220-b-214910)
------------------------------------------------------------------------------------------------------------	
DECLARE
	v_intakeservicerequestactorid uuid;
	v_entryddate timestamp without time zone;
	v_exitdate timestamp without time zone;
	v_intakeservreqchildremovalid uuid;
	v_servicecaseid uuid;
	v_tbplacementid int;
	v_providerid int;
	v_placement_structureid int;
	v_rate_structureid int;
	v_clientid bigint;
	v_caseid character varying;
	v_objectid character varying;
	v_removalid bigint;
	v_contract_program_id bigint;
	v_isapproval int;
	v_isapprovaldate timestamp without time zone;
	v_placement_revision_id uuid;
	v_placementid_placementrevision_id uuid;
	v_isvoided  int;
	l_response   character varying;
	l_personid uuid;
	v_count int;
	l_assignedto character varying;
	v_eventcode  character varying;
	v_routingstatustypeid int;
	p_startdate date;
	p_starttime character varying;
	v_plcrevisions int;
	p_insertedon timestamp without time zone;
	p_endtime varchar(20);
	p_exittypekey varchar(15);
	p_exitreasontypekey varchar(15);
	p_remarks text;
	p_leastrestrictiveplacement text;
	p_ischangepreadoptive bool;
	v_org_insertedby varchar(50);
	v_org_updatedby varchar(50);
	v_org_approvaldate timestamp without time zone;
	p_entrytime time; 
	p_exittime time;
		
BEGIN
	/*Get Placement information to process financial tables */ 
	SELECT routingstatustypeid into v_count
    FROM routing WHERE  objectid=v_placementid;

   
	-- if v_count > 0  then 
	
	raise notice 'v_routingstatustypeid>>>>>>>>>>>> %',v_routingstatustypeid;
    
	raise notice 'v_transferagency>>>>>>>>>>>> %',v_transferagency;
	raise notice 'v_otherpublicagency>>>>>>>>>>>> %',v_otherpublicagency;

	if (v_transferagency is not null) then 
			update placement p set transferagency= v_transferagency, otherpublicagency = v_otherpublicagency where
			 placementid:: character varying = v_placementid;
	end if;

	SELECT pl.alternateid, 
		pl.intakeservicerequestactorid,
		pl.startdatetime, 
		pl.enddatetime,
		pl.intakeservreqchildremovalid,
		pl.servicecaseid,
		pl.service_id,
		pl.service_id,
		pr.cjamspid,
		irl.removalid,
		contract_id,
		pl.isssaapproval,
		pl.ifcapprovaldate,
		sc.servicecasenumber,
		pl.alternateid,
		pl.isvoided,
		pr.personid,
		pl.insertedby,
		pl.startdatetime,
		pl.starttime,
		pl.insertedon,
		pl.endtime,
		pl.exittypekey,
		pl.exitreasontypekey,
		pl.remarks,
		pl.leastrestrictiveplacement,
		pl.ischangepreadoptive,
		pl.entrytime,
		pl.exittime
	INTO v_tbplacementid,
		v_intakeservicerequestactorid,
		v_entryddate,
		v_exitdate,
		v_intakeservreqchildremovalid, 
		v_servicecaseid,
		v_placement_structureid,
		v_rate_structureid,
		v_clientid,
		v_removalid,
		v_contract_program_id,
		v_isapproval,
		v_isapprovaldate,
		v_caseid,
		v_providerid,
		v_isvoided,
		l_personid,
		l_assignedto,
		p_startdate,
		p_starttime,
		p_insertedon,
		p_endtime,
		p_exittypekey,
		p_exitreasontypekey,
		p_remarks,
		p_leastrestrictiveplacement,
		p_ischangepreadoptive,
		p_entrytime, 
		p_exittime 
	FROM placement pl  
		INNER JOIN servicecase sc ON sc.servicecaseid = pl.servicecaseid 
			AND sc.activeflag =1
		INNER JOIN  intakeservicerequestactor isra ON pl.intakeservicerequestactorid = isra.intakeservicerequestactorid 
			AND isra.activeflag =1
		INNER JOIN person pr ON pr.personid = isra.personid 
			AND pr.activeflag =1
		INNER JOIN  Intakeservreqchildremoval irl ON irl.intakeservreqchildremovalid = pl.intakeservreqchildremovalid 
			AND irl.activeflag =1
		LEFT JOIN tb_provider_contracts tbpc ON  tbpc.provider_id = pl.altproviderid 
			AND tbpc.delete_sw ='N'
	WHERE pl.placementid::character varying = v_placementid  
		AND pl.activeflag = 1 
	LIMIT 1;

	raise notice 'v_routingstatustypeid>>>>>>>>>>>> %',v_routingstatustypeid;
	raise notice 'v_providerid>>>>>>>>>>>> %',v_providerid;
	raise notice 'v_tbplacementid>>>>>>>>>>>> %',v_tbplacementid;
	raise notice 'v_isapprovaldate>>>>>>>>>>>> %',v_isapprovaldate;
	raise notice 'v_isapproval>>>>>>>>>>>> %',v_isapproval;
	
	-- B-81542
	select count(*)
		into v_plcrevisions	
	from cjams.placementrevision 
	where placementid = v_placementid::uuid ; 	
 
	-- Capture original placement revision
	IF v_plcrevisions = 0 THEN
		raise notice 'Capture original placement revision ... v_plcrevisions>>>>>>>>>>>> %',v_plcrevisions;
		
		-- Get original apporval data
		select fromsecurityusersid, 
			tosecurityusersid, 
			insertedon::date
		into v_org_insertedby, 
			v_org_updatedby, 
			v_org_approvaldate
		from routing 
		where objectid = v_placementid::character varying
			and routingstatustypeid = '16'
		order by insertedon 
		limit 1 ;
		
		raise notice 'v_org_insertedby>>>>>>>>>>>> %',v_org_insertedby;
		raise notice 'v_org_updatedby>>>>>>>>>>>> %',v_org_updatedby;
		raise notice 'v_org_approvaldate>>>>>>>>>>>> %',v_org_approvaldate;
		
		INSERT INTO cjams.placementrevision
			(	placementid, transactiondate, entrydate, entrytime, 
				exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, 
				isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag,
				voidreasontypekey, voidremarks, exittypekey, remarks, leastrestrictiveplacement, isvoided, voiddate,
				requestedby, requesteddate, approvedby, approvaldate,
				justification, status, ischangepreadoptive, transferagency , otherpublicagency, approveddate
			)
		VALUES
			( 	v_placementid::uuid, p_insertedon::date, v_entryddate, coalesce(p_entrytime::varchar, p_starttime::varchar), 
				v_exitdate, coalesce(p_exittime::varchar, p_endtime::varchar), null, p_exitreasontypekey, '', '3045',
				'Y', now() -  interval '1 seconds', securityuserid, now() -  interval '1 seconds', securityuserid, 0,
				null, null, p_exittypekey, p_remarks, p_leastrestrictiveplacement, 0, null,
				v_org_insertedby::character varying, v_org_approvaldate, v_org_updatedby::character varying, null,
				null, 'Approved', p_ischangepreadoptive, v_transferagency ,v_otherpublicagency, v_org_approvaldate
			);
		
		INSERT INTO cjams.placementrevision
			(	placementid, transactiondate, entrydate, entrytime, 
				exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, 
				isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag,
				voidreasontypekey, voidremarks, exittypekey, remarks, leastrestrictiveplacement, isvoided, voiddate,
				requestedby, requesteddate, approvedby, approvaldate,
				justification, status, ischangepreadoptive, transferagency , otherpublicagency, approveddate
			)
		VALUES
			( 	v_placementid::uuid, p_insertedon::date, v_entryddate, coalesce(p_entrytime::varchar, p_starttime::varchar), 
				v_exitdate, coalesce(p_exittime::varchar, p_endtime::varchar), null, p_exitreasontypekey, '', '3047',
				'Y', now() -  interval '1 seconds', securityuserid, now() -  interval '1 seconds', securityuserid, 0,
				null, null, p_exittypekey, p_remarks, p_leastrestrictiveplacement, 0, null,
				v_org_insertedby::character varying, v_org_approvaldate, v_org_updatedby::character varying, v_org_approvaldate,
				null, 'Approved', p_ischangepreadoptive, v_transferagency ,v_otherpublicagency, v_org_approvaldate
			);
	
	ELSE

	select objectid into v_objectid from cjams.placementrevision 
	where placementid = v_placementid::uuid and objectid is not null  order by insertedon desc limit 1 ; 

	    
		update cjams.placementrevision 
		set activeflag = 0,
			transactiondate = now()::date,
			approvaldate = now()::date,
			entrytime = coalesce(v_starttime, p_starttime,null),
			exittime = coalesce(v_endtime,null),
			exittypetypkey = null, 
			exitreasontypkey = v_exitreasontypekey
		where placementid = v_placementid::uuid ;
	END IF;
        	
	INSERT INTO cjams.placementrevision
		(	placementid, transactiondate, entrydate, 
			entrytime, exitdate, exittime, exittypetypkey, 
			exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, 
			isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag,
			voidreasontypekey, voidremarks, exittypekey, remarks, leastrestrictiveplacement, isvoided, voiddate,
			requestedby, requesteddate, justification, status, ischangepreadoptive, transferagency, otherpublicagency,placementluggage,plluggagepurchased,plluggagecomments, objectid,placementdisposableortrashbag,
			exitluggage , exitluggageprovided, exitluggagecomments , exitdisposableortrashbag
		)
	VALUES
		(	v_placementid::uuid, now()::date, coalesce((v_startdate::date), (p_startdate::date),null), 
			coalesce(v_starttime, p_starttime,null), (v_enddate::date), coalesce(v_endtime,null), null, 
			v_exitreasontypekey, '', '3045', v_isapprovaldate, 
			1, now(), securityuserid, now(), securityuserid, 1,
			v_voidreasontypekey, v_voidremarks, v_exittypekey, v_remarks::text, v_leastrestrictiveplacement, v_isvoid, v_voiddate,
			securityuserid, now(), v_justification, 'Review', v_ischangepreadoptive, v_transferagency  ,v_otherpublicagency, v_luggage, v_luggagepurchased, v_luggagecomments, v_objectid,v_placementdisposableortrashbag,
			v_exitluggage , v_exitluggageprovided, v_exitluggagecomments , v_exitdisposableortrashbag
		);


	--  END IF;
					
	RETURN 'Success';
		
END;
$function$
;
