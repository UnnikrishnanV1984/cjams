CREATE OR REPLACE FUNCTION cjams.sp_permanency_plan_datafix(	as_user_id character varying, 
																OUT al_sqlcode integer, 
																OUT as_mess character varying
															  )
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 01/05/2023
-- To Close the Multiple Open Permanency Plans (CIDM-6350/B-151829)

-- Revision(s)
-- 
------------------------------------------------------------------------
Declare sqlcode int default 0;

Declare vu_personid uuid;
Declare vu_servicecaseid uuid;
Declare vu_permanencyplanid uuid;

Declare vs_actiontype character varying;
Declare vs_casenumber character varying;
Declare vs_msg character varying;

Declare vl_cjamspid Bigint;
Declare vl_counter Integer;
Declare vl_rank_no Integer;
Declare vl_pp_count Integer;
				
Declare vdt_establisheddate timestamp;
Declare vdt_next_establisheddate timestamp;
Declare vdt_enddate timestamp;

Declare vb_active_GAP boolean default False;
Declare vb_active_Adoption boolean default False;
				
cur_permanency_plans record;
cur_permanency_plans_REFCURSOR REFCURSOR;

cur_person_perm_plans record;
cur_person_perm_plans_REFCURSOR REFCURSOR;

BEGIN
	if as_user_id is NULL then
		as_user_id := 'cwPermPlnUp';
	end if;
		
	DROP TABLE IF EXISTS ttb_permanency_plans CASCADE;
	CREATE TEMPORARY TABLE ttb_permanency_plans
		(	personid uuid, 
			servicecaseid character varying 
		 ) ;
	
	DROP TABLE IF EXISTS ttb_person_perm_plans CASCADE;
	CREATE TEMPORARY TABLE ttb_person_perm_plans
		(	cjamspid bigint,
			casenumber character varying,
			permanencyplanid uuid, 
			establisheddate timestamp,
			enddate timestamp,
			rank_no integer,
			actiontype character varying 
			-- 'E' Update End date, 'A' Active Adoption, 'G' Active GAP, 'R' Most Recent 
		 ) ;
		 
	
	-- Load Temp table with all clients/Service cases
	Insert into ttb_permanency_plans ( personid, servicecaseid )
		select tab.personid, tab.servicecaseid
		from ( 
				select distinct isa.personid, pp.servicecaseid
				from permanencyplan pp,
					intakeservicerequestactor isa 
				where pp.intakeservicerequestactorid = isa.intakeservicerequestactorid 
					and pp.enddate is null
					and pp.activeflag = 1
					-- Unit Test
					-- and isa.personid = '1820acb2-de33-4326-a7e9-50c8aa04de82' 
					-- and isa.personid = '89c1e056-2353-4f6c-b931-47bcb01af3e5' -- 1077678
					-- and isa.personid = 'e839972a-c6e7-444c-ae45-3649ecf96683' -- Adoption 
					-- and isa.personid = 'ffbc9f66-4476-4bbc-a306-45a65faa789e'
					-- and isa.personid = '50b2302b-0120-49a7-8734-36f65a5f9d73'
				group by  isa.personid, pp.servicecaseid	
				having count(distinct pp.permanencyplanid) > 1 
			) tab
		where  (	select count(*) 
					from intakeservreqchildremoval rm
					where rm.activeflag = 1
					   and rm.personid = tab.personid
					   -- and ( rm.exitdate is null or rm.exitdate::date >= '2021-07-01'::date )
					   and ( select count(*) 
								from routing rur
							  where rur.objectid = rm.intakeservreqchildremovalid::character varying
								and rur.eventcode = 'CHRR'
								and rur.activeflag = 1
								and rur.routingstatustypeid = '16'
							) > 0
				) > 0
		;		

	OPEN cur_permanency_plans_REFCURSOR FOR
		select personid, 
			servicecaseid		
		from ttb_permanency_plans ;
	loop
		fetch cur_permanency_plans_REFCURSOR into cur_permanency_plans;
		exit when not found;
	
		-- Reset
		vu_personid := NULL;
		vu_servicecaseid := NULL;
		
		vu_personid := cur_permanency_plans.personid;
		vu_servicecaseid := cur_permanency_plans.servicecaseid;
		
		-- RAISE NOTICE 'vu_personid >> %',vu_personid;
		-- RAISE NOTICE 'vu_servicecaseid >> %',vu_servicecaseid;
		
		-- Get Count of Permanency Plans 
		-- Reset 
		vl_pp_count := NULL;
		
		select count(pp.permanencyplanid)
			into vl_pp_count
		from permanencyplan pp,
			intakeservicerequestactor isa,
			person pr,
			servicecase sc
		where pp.intakeservicerequestactorid = isa.intakeservicerequestactorid
			and pr.personid = isa.personid
			and sc.servicecaseid = pp.servicecaseid
			-- and pp.enddate is null
			and pp.activeflag = 1
			and isa.personid = vu_personid
			and pp.servicecaseid = vu_servicecaseid ;
				
		-- Clear Temp table data
		delete from ttb_person_perm_plans ;
		
		-- Get Permanency Plans into Temp table	
		Insert into ttb_person_perm_plans 
			(	cjamspid,
				casenumber,
				permanencyplanid, 
				establisheddate, 
				enddate, 
				rank_no, 
				actiontype
			)	 
			select pr.cjamspid,
				sc.servicecasenumber,
				pp.permanencyplanid,
				pp.establisheddate,
				pp.enddate,
				RANK() OVER(order by pp.establisheddate, pp.ctid) as rank_no,
				-- ROW_NUMBER() OVER() as rank_no,
				-- RANK() OVER(order by pp.establisheddate) as rank_no,
				-- RANK() OVER(PARTITION BY isa.personid, pp.servicecaseid ORDER BY pp.establisheddate ) as rank_no,
				NULL as actiontype			
			from permanencyplan pp,
				intakeservicerequestactor isa,
				person pr,
				servicecase sc
			where pp.intakeservicerequestactorid = isa.intakeservicerequestactorid
				and pr.personid = isa.personid
				and sc.servicecaseid = pp.servicecaseid
				-- and pp.enddate is null
				and pp.activeflag = 1
				and isa.personid = vu_personid
				and pp.servicecaseid = vu_servicecaseid
			order by pp.establisheddate ;

		-- Reset 
		vl_counter := 0;
		
		OPEN cur_person_perm_plans_REFCURSOR FOR
			select cjamspid,
				casenumber,
				permanencyplanid, 
				establisheddate, 
				enddate, 
				rank_no, 
				actiontype
			from ttb_person_perm_plans
			order by rank_no;
		loop
			fetch cur_person_perm_plans_REFCURSOR into cur_person_perm_plans;
				exit when not found;
			
				-- Reset
				vl_cjamspid := NULL;
				vs_casenumber := NULL;
				vu_permanencyplanid := NULL;
				vdt_establisheddate := NULL;
				vdt_next_establisheddate := NULL;
				vdt_enddate := NULL;
				vl_rank_no := NULL;
				vb_active_GAP := False;
				vb_active_Adoption := False;
				vs_msg := NULL;
				
				vl_cjamspid := cur_person_perm_plans.cjamspid;
				vs_casenumber := cur_person_perm_plans.casenumber;
				vu_permanencyplanid := cur_person_perm_plans.permanencyplanid;
				vdt_establisheddate := cur_person_perm_plans.establisheddate;
				vdt_enddate := cur_person_perm_plans.enddate;
				vl_rank_no := cur_person_perm_plans.rank_no;
				
				-- RAISE NOTICE 'vu_permanencyplanid >> %',vu_permanencyplanid;
				-- RAISE NOTICE 'vdt_establisheddate >> %',vdt_establisheddate;
				-- RAISE NOTICE 'vl_rank_no >> %',vl_rank_no;
				
				
				-- Verify Active GAP
				select (case when count(*) > 0 then true else false end)
					into vb_active_GAP
				from guardianship g
					join gapagreement ga ON ga.gapid = g.gapid and ga.activeflag = 1
				where g.permanencyplanid = vu_permanencyplanid
					and ga.startdate is not null	
					and ga.enddate > current_date
					and coalesce((	SELECT count(*) AS count
										FROM routing
									WHERE routing.routingstatustypeid = 16 
										AND routing.eventcode::text = 'GAAR'::text 
										AND routing.activeflag = 1 
										AND routing.objectid::text = ga.gapagreementid::character varying::text
								), 0 ) > 0	 ;	 

				
				-- Verify Active Adoption
				select (case when count(*) > 0 then true else false end) 
					into vb_active_Adoption
				from adoptionplanning apl,
					adoptionagreement agr
				where apl.adoptionplanningid = agr.adoptionplanningid
					and apl.permanencyplanid = vu_permanencyplanid
					and apl.activeflag = 1
					and agr.activeflag = 1
					and agr.startdate is not null	
					and agr.enddate > current_date
					and coalesce((	SELECT count(*) AS count
										FROM routing
									WHERE routing.routingstatustypeid = 16 
										AND routing.eventcode::text = 'ASAR'::text 
										AND routing.activeflag = 1 
										AND routing.objectid::text = agr.adoptionagreementid::character varying::text
								), 0 ) > 0;		
				
				-- RAISE NOTICE 'vl_counter >> %',vl_counter;
				-- RAISE NOTICE 'vb_active_GAP >> %',vb_active_GAP;
				-- RAISE NOTICE 'vb_active_Adoption >> %',vb_active_Adoption;
					
				IF vdt_enddate is not null  then
					-- Do not update 
					RAISE NOTICE 'vl_cjamspid >> %',vl_cjamspid;
					RAISE NOTICE 'vs_casenumber >> %',vs_casenumber;
					RAISE NOTICE 'vu_permanencyplanid >> %',vu_permanencyplanid;
					RAISE NOTICE 'Do not update - This Plan is having End Date.';
					
				elseIf vl_pp_count = vl_rank_no or vb_active_GAP = True or vb_active_Adoption = True then
					-- Do not update 
					RAISE NOTICE 'vl_cjamspid >> %',vl_cjamspid;
					RAISE NOTICE 'vs_casenumber >> %',vs_casenumber;
					RAISE NOTICE 'vu_permanencyplanid >> %',vu_permanencyplanid;
					
					IF vb_active_GAP = True THEN	
						vs_msg := 'Do not update - This Plan is having Active GAP.';
					ELSEIF vb_active_Adoption = true then
						vs_msg := 'Do not update - This Plan is having Active Adoption.';
					END IF;
					
					RAISE NOTICE 'vs_msg >> %',vs_msg;
						
					update ttb_person_perm_plans 
					set actiontype = (	case when vb_active_GAP = True Then 
											'G' -- Active GAP
										when vb_active_Adoption = True Then 
											'A' -- Active Adoption
										else
											'R' -- Most Recent 
										end
									 )			
					where rank_no = vl_rank_no ;
					
				else
					If vdt_establisheddate is null then
						RAISE NOTICE 'vl_cjamspid >> %',vl_cjamspid;
						RAISE NOTICE 'vs_casenumber >> %',vs_casenumber;
						RAISE NOTICE 'vu_permanencyplanid >> %',vu_permanencyplanid;
						RAISE NOTICE 'Error - This Plan Established Date is NULL.';
						
						update ttb_person_perm_plans 
						set actiontype = 'Error - This Plan Established Date is NULL.'
						where rank_no = vl_rank_no ;
					else	
						select establisheddate 
							into vdt_next_establisheddate
						from ttb_person_perm_plans 
						where rank_no = vl_rank_no + 1 ;
						
						if vdt_next_establisheddate::date >= vdt_establisheddate::date then
							update ttb_person_perm_plans 
							set enddate = vdt_next_establisheddate,
								actiontype = 'E' -- Update End date		
							where rank_no = vl_rank_no ;
							
							update permanencyplan
							set enddate = vdt_next_establisheddate,
								updatedby = as_user_id,
								updatedon = now()
							where permanencyplanid = vu_permanencyplanid 
								and activeflag = 1;
						else
							RAISE NOTICE 'vl_cjamspid >> %',vl_cjamspid;
							RAISE NOTICE 'vs_casenumber >> %',vs_casenumber;
							RAISE NOTICE 'vu_permanencyplanid >> %',vu_permanencyplanid;
							RAISE NOTICE 'vdt_establisheddate >> %',vdt_establisheddate;
							RAISE NOTICE 'vdt_next_establisheddate >> %',vdt_next_establisheddate;
							RAISE NOTICE 'Error - Next Plan Established Date is < This Plan Established Date.';
							
							update ttb_person_perm_plans 
							set actiontype = 'Error - Next Plan Established Date is < This Plan Established Date.'
							where rank_no = vl_rank_no ;
						end if;	
					end if;	
				end if;
				
				vl_counter = vl_counter + 1;
				
				-- RAISE NOTICE 'cpsresponsetimerupdate Return Status >> %',v_status;	
		END LOOP;	
		close cur_person_perm_plans_REFCURSOR;	
		
		-- RAISE NOTICE 'cpsresponsetimerupdate Return Status >> %',v_status;	
	END LOOP;	
	close cur_permanency_plans_REFCURSOR;	
	
	-- IF al_sqlcode <> -1 then
		al_sqlcode := 0;
		as_mess := 'Success';
	-- END IF;	
	
	DROP TABLE IF EXISTS ttb_permanency_plans CASCADE;	  
	DROP TABLE IF EXISTS ttb_person_perm_plans CASCADE;
END;

$function$
;
