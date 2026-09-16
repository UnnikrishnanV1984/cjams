CREATE OR REPLACE FUNCTION cjams.placementapproval(v_placementid character varying, userid character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 04/05/2021 Vineet Tirodkar 
-- Modifications to Close CPA Homes with the Placement Exit (CDM-11926)
-- CIDM-5312 - 08-16 - adding leastrestriveplacement
-- Aurora Issue fix 11-21
-- 07/17/2023 - Vineet Tirodkar - Modifications to fix Provider vacancy discrepancy issue (CDM-32894)
-- 10/17/2023 - Vineet Tirodkar - Modifications for PLCC scenario, end date the corresponding OOH program assignment. (CDM-34782)
-- 11/15/2023 -Smitha Somasekharan -Child removal exit In placement PLCC scenario (CDM-35396)
-- 6/18/2024 -Smitha Somasekharan -Child removal enddate when editing exot placement with PLCC scenario
-- 04/30/2034 -Smitha Somasekharan - Modificatins for sending notification for QI assessment 
-- 09/06/2024 - CIDM-9160 - Veera changes for Living arrangement and hospitalization user story 
-- 02/18/2025 - Naveenkumar - CIDM-8802 - Child removal end date not updating when PLCC with placement type LA and child removal end date is already updated.
--03/13/2025-Veera/Sai Chintha - CIDM-10047-Child-Removal-table-returntime-column.
--04/07/2025 - Sai Kothapalli -- Approval Inbox - after approval requests not leaving
--01/06/2025 Smitha Somasekharan -Modifications for luggage question update userstory- (CIDM-10008-b-210234)
--2/26/2025 Smitha Somasekharan -Modifications for luggage question update userstory- (CIDM-10220-b-214910)
--4/15/2025 CIDM-10396- Vinesh Puthan - Placement return to worker by supervisor is not working 
------------------------------------------------------------------------
DECLARE
v_ticklerstatus character varying;
v_intakeservicerequestactorid uuid;
v_entryddate timestamp without time zone;
v_exitdate timestamp without time zone;
ld_first_day_entry_dt character varying;
v_intakeservreqchildremovalid uuid;
v_servicecaseid uuid;
v_tbplacementid int;
v_providerid int;
v_placement_structureid int;
v_rate_structureid int;
v_clientid bigint;
v_removalid bigint;
v_contract_program_id bigint;
v_isapproval int;
v_isapprovaldate timestamp without time zone;
v_placement_revision_id uuid;
v_placementid_placementrevision_id uuid;
v_totalcount bigint;
v_isvoided  int;
v_isvoid integer;
l_response   character varying;
l_personid uuid;
l_assignedto character varying;
v_eventcode  character varying;
v_routingstatustypeid int;
v_intakeservreqchildremovalhistoryid uuid;

v_prentrydate timestamp without time zone;
v_prentrytime character varying;
v_count int;
v_cpa_cnt int;
v_voidreasontypekey character varying;
v_voidremarks character varying;
v_enddate timestamp without time zone;
v_endtime character varying;
v_exittypekey character varying;
v_remarks character varying;
v_leastrestrictiveplacement character varying;
v_reasontypekey character varying;

r_enddate timestamp without time zone;
r_prexitdate timestamp without time zone;
r_enddatetime timestamp without time zone;
r_endtime time;
r_prexittime time;
r_exittypekey character varying;
r_reasontypekey character varying;
r_transferagency Character varying;
r_otherpublicagency character varying;
r_count integer := 0;
openremovalexitornot integer := 0;
r_placementluggage boolean;
r_plluggagepurchased boolean;
r_plluggagecomments character varying;
r_placementdisposableortrashbag boolean;
r_updatedby character varying;
r_updatedon timestamp;

v_pentrydate timestamp without time zone;
v_prexitdate timestamp without time zone;
v_prexittime character varying;
v_prexittypekey character varying;
v_prexitreasontypkey character varying;
v_ischangepreadoptive boolean;

v_provider_category_cd VARCHAR(50);  
v_routingdescription VARCHAR(100);  
v_routeddescription_voidexit  VARCHAR(100);  
v_routingstatustypeid_voidexit int;
v_voiddate  timestamp without time zone;
v_objectid character varying;
v_requestedby  VARCHAR(50);  
v_requesteddate  timestamp without time zone;
l_record RECORD;
v_removalexitdate timestamp without time zone;
flag record;
v_pl_rev_entry_dt timestamp without time zone;
v_pl_rev_exit_dt timestamp without time zone;
v_pl_rev_isvoided integer;
v_approved_placement integer;
v_qrtpnotificationmessage character varying;
v_personfirstname character varying;
v_personlastname character varying;
v_placementdate character varying;

v_placementluggage boolean;
v_plluggagepurchased boolean;
v_plluggagecomments character varying;
v_placementdisposableortrashbag boolean;
 v_exitluggage boolean;
 v_exitluggageprovided boolean; 
 v_exitluggagecomments character varying;
 v_exitdisposableortrashbag boolean;

r_is_la_with_enddtae boolean;


BEGIN
	/*Get Placement information to process financial tables */

	CREATE TEMP TABLE IF NOT EXISTS
	Temp_insert_person_program_area (
				personprogramid uuid
	);

	SELECT pl.alternateid, pl.intakeservicerequestactorid,
		pl.startdatetime, pl.enddatetime,pl.intakeservreqchildremovalid,
		pl.servicecaseid,pl.service_id ,pl.service_id,
		pr.cjamspid ,irl.removalid,contractprogramid,
		pl.isssaapproval,pl.ifcapprovaldate,
		pl.altproviderid,pl.isvoided,pr.personid,pl.insertedby,pr.firstname,pr.lastname
	INTO v_tbplacementid,v_intakeservicerequestactorid,
		v_entryddate,v_exitdate,v_intakeservreqchildremovalid, 
		v_servicecaseid,v_placement_structureid,v_rate_structureid,
		v_clientid,v_removalid,v_contract_program_id,
		v_isapproval,v_isapprovaldate,
		v_providerid,v_isvoided,l_personid,l_assignedto,v_personfirstname,v_personlastname
	FROM placement pl  
		INNER JOIN person pr ON pl.personid = pr.personid 
			AND pr.activeflag =1
		left JOIN Intakeservreqchildremoval irl 
			ON (case when pl.placementtypekey = 'LA' and pl.intakeservreqchildremovalid is null then 
					irl.personid = pl.personid 
				else 
					irl.intakeservreqchildremovalid = pl.intakeservreqchildremovalid 
				end ) 
				AND irl.activeflag =1
		LEFT JOIN tb_provider tbp ON tbp.provider_id = pl.altproviderid 
			AND trim(tbp.delete_sw)= 'N'
		LEFT JOIN tb_provider_contracts tbpc ON tbpc.provider_id = COALESCE(tbp.affiliate_provider_id, tbp.provider_id) 
			AND tbpc.delete_sw ='N'
	WHERE pl.placementid::character varying = v_placementid  
		AND pl.activeflag = 1 
	LIMIT 1;

	-- Get the placement request details from placement revision table
	select entrydate, exitdate, isvoided
		into v_pl_rev_entry_dt, v_pl_rev_exit_dt, v_pl_rev_isvoided
	from placementrevision
	where placementid = v_placementid::uuid
		and activeflag = 1 
		and approvalstatustypkey = '3045'
	order by insertedon desc
	limit 1 ;

	-- Verfiy if the placement is having initial apporval  
	select count(*)
		into v_approved_placement
	from routing 
	where objectid = v_placementid
		and toroleid not in ( 'IVESV', 'IVESP' )
		and routingstatustypeid = 16
		and activeflag = 1 ;
	
	SELECT eventcode,routingstatustypeid,routeddescription 
		into v_eventcode,v_routingstatustypeid,v_routingdescription
    FROM routing 
	WHERE objectid = v_placementid
    order by insertedon desc 
	limit 1;
	
	/*
   	SELECT routeddescription,routingstatustypeid 
		into v_routeddescription_voidexit,v_routingstatustypeid_voidexit
    FROM routing 
	WHERE objectid = v_placementid 
		and routeddescription in ('Placement Exit Submitted for review','Void placement submitted for review')  
	order by insertedon desc 
	limit 1 ;	
	
   */ --11410 is QRTP provider service
     if( v_approved_placement = 1  and v_placement_structureid =11410 ) then 
		select CAST(to_char(v_entryddate::timestamp,'MM/dd/yyyy')as character varying) into v_placementdate;
		v_qrtpnotificationmessage :='A youth ' || v_personfirstname ||  ' ' || v_personlastname || '- ' ||  v_clientid   ||' has been placed in a QRTP on ' || v_placementdate  || '. Please complete the QI assessment - Attachment B. This must be completed within 30 days of placement.';
		PERFORM cjams.qrtpplacementnotifictiontoqi(userid::uuid,v_qrtpnotificationmessage,v_servicecaseid);
	end if;	 

   	if (v_routingstatustypeid = 16 -- Approved
			-- and ( 
			-- 	  ( v_exitdate is null and v_pl_rev_exit_dt is not null ) -- Placement Exit Request 
			-- 		or 
			-- 		v_pl_rev_isvoided = 1 -- Void Placement Request
			-- 	  )	


			-- and v_routingstatustypeid_voidexit = 15 
			-- and v_routeddescription_voidexit in ('Placement Exit Submitted for review','Void placement submitted for review') 
			) then 
		   	
		/*	
		select tpcl1.PICKLIST_VALUE_CD 
			into v_provider_category_cd 
		FROM TB_PROVIDER_PICKLIST tpcl1 
		WHERE tpcl1.PICKLIST_TYPE_ID=155 
			AND tpcl1.PICKLIST_VALUE_CD IN ('1783') 
			AND tpcl1.PROVIDER_ID = v_providerid 
			AND tpcl1.DELETE_SW = 'N';

		IF v_provider_category_cd = '1783' THEN
			UPDATE tb_provider 
				set vacancy_no = (vacancy_no + 1)  
			where provider_id = v_providerid;
		END IF;
		*/
		
		if ( v_exitdate is null and v_pl_rev_exit_dt is not null ) -- Placement Exit Request 
			or 
		   ( v_pl_rev_isvoided = 1 and v_exitdate is null) -- Void Active Placement Request
			then 
			IF v_contract_program_id IS NOT NULL THEN
				UPDATE tb_contract_program 
					SET vacancy_no  = (vacancy_no + 1),
						update_user_id = userid,
						update_ts = now()
				where  program_id = v_contract_program_id;
			else
				UPDATE tb_provider 
					set vacancy_no = (vacancy_no + 1),
						update_user_id = userid,
						update_ts = now()					
				where provider_id = v_providerid;		
			END IF;
		end if;	

		
		select enddate,endtime,exittypekey,exitreasontypkey, exitdate, exittime, transferagency, otherpublicagency,exitluggage,exitluggageprovided,exitluggagecomments,exitdisposableortrashbag,updatedby,updatedon
		into r_enddate, r_endtime , 
		     r_exittypekey,r_reasontypekey, r_prexitdate, r_prexittime, r_transferagency , r_otherpublicagency, r_placementluggage, r_plluggagepurchased, r_plluggagecomments, r_placementdisposableortrashbag,r_updatedby,r_updatedon
		from placementrevision 
		where placementid = v_placementid::uuid 
			and activeflag = 1;

		-- Cheking if childremoval end date is avilable and placement type is LA
		If
		 EXISTS(select exitdate from intakeservreqchildremoval where intakeservreqchildremovalid = 
				(select intakeservreqchildremovalid from placement where placementid = v_placementid::uuid 	and activeflag = 1 and placementtypekey ='LA') 
				and exitdate is null)
		AND  EXISTS(select placementtypekey from placement where placementid = v_placementid::uuid and activeflag = 1 and placementtypekey = 'LA') THEN
			r_is_la_with_enddtae = true;
		END IF;

       select count(*) into openremovalexitornot from intakeservreqchildremoval where intakeservreqchildremovalid = v_intakeservreqchildremovalid and activeflag = 1 and exitdate is null;

select count(*) into r_count
    from placement pl
where intakeservreqchildremovalid = v_intakeservreqchildremovalid 
    and pl.placementid::character varying <> v_placementid 
    and pl.activeflag = 1
    and pl.startdatetime is not null
    and pl.enddatetime is null
    and pl.placementtypekey = 'PRPL'
    and coalesce(pl.isvoided, 0) <> 1
    and ( select count(*)
                from routing ro
              where ro.objectid = pl.placementid::character varying
                and ro.eventcode = 'PLTR'
                and ro.routingstatustypeid = 16
                and ro.activeflag = 1
        ) > 0;

 raise notice 'r_count 257 >>>>>>>>>>>> %',r_count;
 raise notice 'openremovalexitornot 259 >>>>>>>>>>>> %',openremovalexitornot;


		IF r_exittypekey = 'PLCC' and r_count = 0 and openremovalexitornot > 0 THEN
			UPDATE cjams.intakeservreqchildremoval 
			SET exitdate = case when r_enddate is null then 
								(r_prexitdate + case when r_endtime is null then r_prexittime else r_endtime end) 
							else 
								(r_enddate + case when r_endtime is null then r_prexittime else r_endtime end) 
							end, 
				returntime = case when r_enddate is null then 
								(r_prexitdate + case when r_endtime is null then r_prexittime else r_endtime end) 
							else 
								(r_enddate + case when r_endtime is null then r_prexittime else r_endtime end) 
							end, 
				removalexitreason = (select * 
									 from convertRemovalCodeFromPlacToChldRmvl(r_reasontypekey)
									 ), 
				luggageupdatedby = (select up.fullname from userprofile up where up.securityusersid = r_updatedby),					 
				returntransts=now(),
				transferagency = r_transferagency, 
				otherpublicagency = r_otherpublicagency,
				childremovalluggage =r_placementluggage,
				luggageprovided =r_plluggagepurchased,
				luggagecomments =r_plluggagecomments,
				placementdisposableortrashbag =r_placementdisposableortrashbag,
				luggageupdatedon =r_updatedon,
				updatedby = userid,
				updatedon = now()  --@Simar D-22599 updated audit info were missing
			WHERE intakeservreqchildremovalid= v_intakeservreqchildremovalid 
			RETURNING exitdate into v_removalexitdate;

			update cjams.tb_client_eligibility  
			set end_dt = v_removalexitdate::date,
				update_ts = now()
			where client_id::int8 = v_clientid::int8 
				and removal_id::bigint = v_removalid::bigint;
		 
			If v_intakeservreqchildremovalid is not null then
				WITH temp_ids AS 
				(	UPDATE personprogramarea 
					SET enddate = case when r_enddate is null then r_prexitdate else r_enddate end, 
						datatransferflag = 'U',
						updatedby = userid,
						updatedon = now()  --@Simar D-22599  updated audit info were missing
					WHERE activeflag = 1 
						AND enddate IS NULL
						AND personid = l_personid
						AND lower(programkey) = 'ooh'
						and startdate::date = ( select removaldate::date
													from intakeservreqchildremoval
												where intakeservreqchildremovalid = v_intakeservreqchildremovalid
											   )	
					RETURNING personprogramid
				)
				INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;		
			end if;
		END IF;
		
		IF r_exittypekey = 'PLCC' THEN	
				If v_intakeservreqchildremovalid is not null then 
                 INSERT INTO intakeservreqchildremoval_history 
					SELECT gen_random_uuid (),
					'{"status":"Updated","data":[{"key":" justification","new_value":"Removal was end dated by the system due to placement exit reason is Permanently Leaving Custody & Care.","old_value":null,"display_name":"System Removal - Exit Date"}]}'::json
					, 'HISTORY'::character varying
					, *
					FROM intakeservreqchildremoval 
				WHERE intakeservreqchildremovalid = v_intakeservreqchildremovalid
				RETURNING intakeservreqchildremovalhistoryid into v_intakeservreqchildremovalhistoryid;
				if v_intakeservreqchildremovalhistoryid is not null then
					Update intakeservreqchildremoval_history set
					insertedby = userid,
					updatedby =userid,
					insertedon =now(),
					updatedon =now()
					where intakeservreqchildremovalhistoryid =v_intakeservreqchildremovalhistoryid;
				end if;
			end if;
		END IF;
	end if;


	if (v_routingstatustypeid = 17 ) then 
		raise notice 'v_routingstatustypeid>>>>>>>>>>>> %',v_routingstatustypeid;
		
		select requestedby,requesteddate 
			into v_requestedby, v_requesteddate 
		from placementrevision
		where placementid = v_placementid::uuid 
			and approvalstatustypkey = '3045' 
			and activeflag = 1;
		
		select count(*), entrydate, entrytime, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, leastrestrictiveplacement, 
			exitreasontypkey, exitdate, exittime, isvoided, voiddate,placementluggage,plluggagepurchased,plluggagecomments, objectid
		into v_count, v_prentrydate, v_prentrytime, v_voidreasontypekey, v_voidremarks, v_enddate, v_endtime, 
		    v_exittypekey, v_remarks, v_leastrestrictiveplacement, v_reasontypekey, v_prexitdate, v_prexittime, v_isvoid, v_voiddate,v_placementluggage,v_plluggagepurchased,v_plluggagecomments, v_objectid,v_placementdisposableortrashbag 
		from placementrevision 
		where placementid = v_placementid::uuid 
		and activeflag = 1 
		group by entrydate,entrytime,
			voidreasontypekey,voidremarks,enddate,endtime,exittypekey,remarks,leastrestrictiveplacement,exitreasontypkey,exitdate,exittime,
			isvoided,voiddate,placementluggage,plluggagepurchased,plluggagecomments, objectid,placementdisposableortrashbag;
		
		-- Fetch the most recent approved placement revision
		SELECT 
			entrydate, 
			exitdate, 
			entrytime, 
			exittime,
			exitreasontypkey,
			exittypekey
		INTO 
			v_prentrydate, 
			v_prexitdate, 
			v_prentrytime, 
			v_prexittime,
			v_prexitreasontypkey,
			v_prexittypekey
		FROM 
			placementrevision
		WHERE 
			placementid = v_placementid::uuid 
			AND status = 'Approved'
		ORDER BY 
			insertedon DESC
		LIMIT 1;

		-- Update the placement table with the recent approved dates
		IF v_prentrydate IS NOT NULL THEN
			UPDATE 
				placement
			SET 
				startdatetime = v_prentrydate, 
				enddatetime = v_prexitdate, 
				starttime = v_prentrytime, 
				endtime = v_prexittime,
				exitreasontypekey = v_prexitreasontypkey,
				exittypekey = v_prexittypekey
			WHERE 
				placementid = v_placementid::uuid;
		END IF;	
		UPDATE 
			placement
		SET 
			startdatetime = v_prentrydate, 
			enddatetime = v_prexitdate, 
			starttime = v_prentrytime, 
			endtime = v_prexittime,
			exitreasontypekey = v_prexitreasontypkey,
			exittypekey = v_prexittypekey
		WHERE 
			placementid = v_placementid::uuid;
		END IF;		
			
		update cjams.placementrevision 
		set approvedby = userid, 
			approveddate = now(),
			status = 'Rejected'
		where placementid = v_placementid::uuid 
			and approvalstatustypkey = '3045' 
			and activeflag = 1;

		update cjams.placementrevision  
		set activeflag = 0,
			updatedby = userid,
			updatedon = now() 
		where placementid = v_placementid::uuid;
		
		INSERT INTO cjams.placementrevision
		( 	placementid, transactiondate, entrydate, entrytime, exitdate, 
			exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, 
			approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag,
			voidreasontypekey,voidremarks,enddate,endtime,exittypekey,remarks,leastrestrictiveplacement,isvoided,voiddate
			,requestedby,requesteddate,approvedby,approveddate,status,placementluggage,plluggagepurchased,plluggagecomments, objectid,placementdisposableortrashbag 
		)
		VALUES
		(	v_placementid:: uuid,(v_requesteddate::date), (v_prentrydate :: date), v_prentrytime, (v_prexitdate :: date)
			,v_prexittime, null, v_reasontypekey, '', '3281', now()::date, 1, now(),userid, now(),  userid, 1,
			v_voidreasontypekey , v_voidremarks, (v_enddate :: date) , v_endtime , 
			v_exittypekey , v_remarks::text, v_leastrestrictiveplacement, v_isvoid,v_voiddate, v_requestedby, v_requesteddate, userid, now(), 'Rejected',v_placementluggage,v_plluggagepurchased,v_plluggagecomments, v_objectid,v_placementdisposableortrashbag
		);
	
		/*
		select tpcl1.PICKLIST_VALUE_CD 
			into v_provider_category_cd 
		FROM TB_PROVIDER_PICKLIST tpcl1 
		WHERE tpcl1.PICKLIST_TYPE_ID = 155 
			AND tpcl1.PICKLIST_VALUE_CD IN ('1783') 
			AND tpcl1.PROVIDER_ID = v_providerid 
			AND tpcl1.DELETE_SW = 'N';

		IF v_provider_category_cd = '1783' THEN
			UPDATE tb_provider set vacancy_no = (vacancy_no + 1) where provider_id = v_providerid;
		END IF;
		*/

			if v_objectid is not null then


				 raise notice 'v_routingstatustypeid 370 >>>>>>>>>>>> %',v_objectid;

				 update personhospitalization set activeflag = 0,updatedby = userid, updatedon = now()
				 where hospitalizationid = (v_objectid)::uuid;

				select * into flag from cjams.generate_audit_data('personhospitalization',v_objectid:: uuid);


			end if ;
		
		if v_approved_placement = 0 then -- Rejection is for the Placement Entry approval request
			IF v_contract_program_id IS NOT NULL THEN
				UPDATE tb_contract_program 
				SET vacancy_no = (vacancy_no + 1),
					update_user_id = userid,
					update_ts = now()					
				where program_id = v_contract_program_id;
			ELSE
				UPDATE tb_provider 
				set vacancy_no = (vacancy_no + 1),
					update_user_id = userid,
					update_ts = now() 
				where provider_id = v_providerid;
			END IF;
		end if;
		
	end if;


	if (v_routingstatustypeid = 16 ) then 

		raise notice 'v_routingstatustypeid>>>>>>>>>>>> %',v_routingstatustypeid; 
		/* if (v_routingstatustypeid = 15 ) then 
		raise notice 'v_routingstatustypeid>>>>>>>>>>>> %',v_routingstatustypeid;
			select provider_category_cd into v_provider_category_cd from tb_provider where provider_id = v_providerid;
			raise notice 'v_provider_category_cd>>>>>>>>>>>> %',v_provider_category_cd;
			IF v_provider_category_cd = '1783' THEN
			UPDATE  tb_provider  set  vacancy_no  =  (vacancy_no - 1)  where  provider_id = v_providerid;
			END IF;
		end if; */
 
		--if v_routingstatustypeid = 16 then
	 	
		select count(*), entrydate, entrytime, voidreasontypekey, voidremarks, enddate, endtime, exittypekey,
			remarks, leastrestrictiveplacement, exitreasontypkey, exitdate, exittime, isvoided, voiddate, ischangepreadoptive,placementluggage,plluggagepurchased,plluggagecomments, objectid,placementdisposableortrashbag,exitluggage , exitluggageprovided, exitluggagecomments ,exitdisposableortrashbag
		into v_count, v_prentrydate, v_prentrytime, v_voidreasontypekey, v_voidremarks, v_enddate, v_endtime, v_exittypekey,
			v_remarks, v_leastrestrictiveplacement, v_reasontypekey, v_prexitdate, v_prexittime, v_isvoid, v_voiddate, v_ischangepreadoptive,v_placementluggage,v_plluggagepurchased,v_plluggagecomments, v_objectid,v_placementdisposableortrashbag,v_exitluggage , v_exitluggageprovided, v_exitluggagecomments , v_exitdisposableortrashbag
		from placementrevision 
		where placementid = v_placementid::uuid 
			and activeflag = 1 
		group by entrydate,entrytime,
			voidreasontypekey,voidremarks,enddate,endtime,exittypekey,remarks,leastrestrictiveplacement,exitreasontypkey,exitdate,exittime,
			isvoided,voiddate,ischangepreadoptive,placementluggage,plluggagepurchased,plluggagecomments, objectid,placementdisposableortrashbag,exitluggage , exitluggageprovided, exitluggagecomments ,exitdisposableortrashbag ;
		--	 raise notice 'v_count>>>>>>>>>>>> %',v_count;
		--	 raise notice 'v_prentrydate>>>>>>>>>>>> %',v_prentrydate;
		--	 raise notice 'v_entryddate>>>>>>>>>>>> %',v_entryddate;
	 
	  	if v_count > 0 then 
	  	  	if v_prentrydate is null then
			  	SELECT startdatetime 
					into v_prentrydate 
				from placement 
				where placementid = v_placementid::uuid;
			end if;
			raise notice 'v_prentrydate>>>>>>>>>>>> %',v_prentrydate;	
	
			select requestedby, requesteddate 
				into v_requestedby, v_requesteddate 
			from placementrevision
			where placementid = v_placementid::uuid 
				and approvalstatustypkey = '3045' 
				and activeflag = 1;
	
			update cjams.placementrevision 
			set approvedby = userid, 
				approveddate = now(),
				status = 'Approved'
			where placementid = v_placementid::uuid 
				and approvalstatustypkey = '3045' 
				and activeflag = 1;
	
			update cjams.placementrevision 
			set activeflag = 0,
				updatedby = userid,
				updatedon = now() 
			where placementid = v_placementid::uuid;
			
			update cjams.placement 
			set startdatetime = case when v_prentrydate is null then v_entryddate else v_prentrydate end,
				starttime= v_prentrytime,
				--enddatetime = v_enddate,
				enddatetime = CASE WHEN v_isvoid = 1 THEN 
								now() 
							  ELSE 
								case when v_enddate is null then v_prexitdate else v_enddate end 
							  END,
				-- endtime = v_endtime,
				endtime = case when v_endtime is null then v_prexittime else v_endtime end,
				voidreasontypekey = v_voidreasontypekey,
				voidremarks = v_voidremarks,
				voidapprovaldate = current_date,
				isvoided = v_isvoid,
				voiddate = v_voiddate,
				overunderflag = 0,	--@TM: set the over-under flag to 0; this will set the over under switch in tb_placement view to 'N' and then be picked up for under-over payments
				exittypekey = v_exittypekey,
				exitreasontypekey = v_reasontypekey, --placement table has 'exitreasontypekey'. placementrevision has 'extreasontypkey'
				remarks = v_remarks,
				leastrestrictiveplacement = v_leastrestrictiveplacement,
				ischangepreadoptive = v_ischangepreadoptive,
				placementluggage = v_placementluggage,
                plluggagepurchased =v_plluggagepurchased,
                plluggagecomments =v_plluggagecomments ,
				placementdisposableortrashbag =v_placementdisposableortrashbag,
				updatedby = userid,
				updatedon = now()
			where placementid = v_placementid::uuid;

			-- IF v_isvoid = 1 THEN 
			-- 	UPDATE tb_PLACEMENT_VALIDATION
			-- 		SET delete_sw = 'Y'
			-- 	WHERE placement_validation_id in (
			-- 		SELECT tbpv1.placement_validation_id  FROM placement p1
			-- 		INNER JOIN tb_placement_validation tbpv1 ON tbpv1.placement_id = p1.alternateid
			-- 		WHERE p1.placementid= v_placementid:: uuid
			-- 		ORDER BY tbpv1.validation_start_dt DESC LIMIT 1
			-- 	);
			-- END IF;
			raise notice 'v_objectid>>>>>>>>>>>> 479%',v_objectid;
			
			if v_objectid is not null then

			     update livingarrangement set objectid = v_objectid,updatedby = userid, updatedon = now()
			     where placementid = v_placementid::uuid; 

				 update personhospitalization set activeflag = 1,updatedby = userid, updatedon = now()
				 where hospitalizationid = (v_objectid)::uuid;

				 raise notice 'v_objectid>>>>>>>>>>>> 504 %',v_objectid;

				 select * into flag from cjams.generate_audit_data('personhospitalization',v_objectid::uuid);

			end if ;


   
			IF v_isvoid = 1 THEN 
				UPDATE tb_PLACEMENT_VALIDATION
					SET delete_sw = 'Y'
				WHERE placement_validation_id in (
					SELECT tbpv1.placement_validation_id  
					FROM placement p1
						INNER JOIN tb_placement_validation tbpv1 ON tbpv1.placement_id = p1.alternateid
					WHERE p1.placementid= v_placementid:: uuid
					ORDER BY tbpv1.validation_start_dt DESC 
					LIMIT 1
				);

			ELSE
				--CDM-3062
				-- ld_first_day_entry_dt = Date( String(YEAR(N_entry_dt)) + '-'  + String(Month(N_entry_dt)) + '-' + '01' )
				ld_first_day_entry_dt = concat( date_part('year', v_entryddate)::character varying, '-', date_part('month', v_entryddate)::character varying, '-01' )::character varying;

				-- IF Not Isnull(ld_first_day_entry_dt) AND IsDate(String(ld_first_day_entry_dt)) THEN
				IF coalesce(ld_first_day_entry_dt:: character varying, '') <> '' THEN

					UPDATE TB_PLACEMENT_VALIDATION
					SET DELETE_SW = 'Y' ,
						UPDATE_TS = current_timestamp,
						UPDATE_USER_ID = userid
					WHERE PLACEMENT_ID = (select alternateid from placement where placementid::uuid = v_placementid::uuid)
						AND DELETE_SW = 'N'
						AND VALIDATION_START_DT::date < ld_first_day_entry_dt::date  ;
				END IF;

				-- IF not isnull(N_exit_dt) THEN
				IF coalesce(v_exitdate:: character varying, '') <> '' THEN

					UPDATE TB_PLACEMENT_VALIDATION
					SET DELETE_SW = 'Y' ,
						UPDATE_TS = current_timestamp,
						UPDATE_USER_ID = userid
					WHERE PLACEMENT_ID = (select alternateid from placement where placementid::uuid = v_placementid:: uuid)
						AND DELETE_SW = 'N'
						AND VALIDATION_START_DT::date > v_exitdate::date ;
				END IF ;
			END IF;

  
			INSERT INTO cjams.placementrevision
			( 	placementid, transactiondate, entrydate, entrytime, exitdate, 
				exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, 
				approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag,
				voidreasontypekey,voidremarks,enddate,endtime,exittypekey,remarks, leastrestrictiveplacement, isvoided,voiddate
				,requestedby,requesteddate,approvedby,approveddate,ischangepreadoptive,status,placementluggage,plluggagepurchased,plluggagecomments,placementdisposableortrashbag
			)
			VALUES
			(	v_placementid:: uuid,(v_requesteddate::date), (v_prentrydate :: date), v_prentrytime, (v_prexitdate :: date)
				,v_prexittime, null, v_reasontypekey, '', '3047', now()::date, 1, now(),userid, now(),  userid, 1,
				v_voidreasontypekey , v_voidremarks, (v_enddate :: date) , v_endtime , 
				v_exittypekey , v_remarks::text, v_leastrestrictiveplacement, v_isvoid,v_voiddate, 
				v_requestedby, v_requesteddate, userid, now(),v_ischangepreadoptive,'Approved',v_placementluggage,v_plluggagepurchased,v_plluggagecomments,v_placementdisposableortrashbag
			);

			
			-- IF coalesce(v_enddate:: character varying, '') <> '' THEN -- CDM-3463
			IF coalesce(v_prexitdate::character varying, '') <> '' THEN -- CDM-11926
				select count(*) 
					into v_cpa_cnt
				from placementcpahomes
				where placementid = v_placementid ::uuid
					and exitdt is null 
					and activeflag = 1;

				IF v_cpa_cnt > 0 THEN
					update placementcpahomes p 
					set exitdt = v_prexitdate, -- v_enddate, 
						exittm = concat((date(v_prexitdate))::character varying, ' ', v_prexittime)::timestamp, -- v_endtime, 
						updatets = current_timestamp, 
						updateuserid = userid::uuid
					where placementid = v_placementid::uuid
						and exitdt is null 
						and activeflag = 1;
				END IF;
			END IF;

		END IF;

		select placementexitvoidtickler into v_ticklerstatus from placementexitvoidtickler(v_placementid::character varying,userid); 
			RAISE NOTICE 'v_ticklerstatus 1682:%', v_ticklerstatus; 
  
	end if;
	-- END IF;
				
	-- IF v_exitdate is not null  then	
	-- 	WITH temp_ids AS (UPDATE personprogramarea SET enddate = v_exitdate, datatransferflag='U', updatedon = now()
	-- 	WHERE  activeflag=1 AND enddate IS NULL AND objectid = v_servicecaseid::character varying
	-- 	AND personid = l_personid
	-- 	AND lower(programkey) = 'ooh'
	-- 	RETURNING personprogramid)
	-- 	INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;
	-- END IF;

	FOR l_record IN (select personprogramid from Temp_insert_person_program_area group by personprogramid)
	LOOP
		INSERT INTO auditlog ( referenceid, logtypekey, description, metadata, insertedon, insertedby )
		VALUES
		(	l_record.personprogramid,'PRGMAREA','systemupdate08',
			(SELECT row_to_json(personprogramarea) FROM personprogramarea WHERE personprogramid = l_record.personprogramid), 
			now(), userid
		);
	END LOOP;

	DROP TABLE Temp_insert_person_program_area;

RETURN 'Success';	
END;
$function$
;
