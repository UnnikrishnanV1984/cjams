CREATE OR REPLACE FUNCTION cjams.sp_update_historic_sen_person_flag(	ad_run_dt date,
																		as_user_id character varying, 
																		OUT al_sqlcode integer, 
																		OUT as_mess character varying
																	)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 10/18/2022
-- B-137390 - PI 32 - SP05-Historic SEN Persons Flag (CIDM-5758)
-- To update the Person SEN (Substance Exposed Newborn) Flag status as Active or Historic 

-- Argument   : 1) IN ad_run_dt - Batch Run Date 	
--				2) IN as_user_id - User ID for Audit column update 	

-- Revision(s)

------------------------------------------------------------------------
Declare sqlcode int default 0;
Declare vu_person_id uuid;

Declare vl_cjamspid bigint;
Declare vl_total_sens bigint;
Declare vl_senstatusflag integer;
Declare vl_SFCI_count integer;
Declare vl_active_SFCI_count integer;
Declare vl_servicecase_count integer;
Declare vl_active_service_cases integer;
Declare vl_active_prog_assignment_count integer;
 
Declare vt_sentimestamp timestamp;
Declare vt_dob timestamp;
		
Declare vb_over90_days boolean;
Declare vb_over120_days boolean;
Declare vb_historic_sen boolean;

cur_sen_person record;
cur_sen_persons REFCURSOR;

BEGIN
	if as_user_id is NULL then
		as_user_id := 'cwsenupdt';
	end if;
	
	if ad_run_dt is NULL then
		ad_run_dt := current_date;
	end if;
	
	-- Update the Person tbale with SEN information 
	DROP TABLE IF EXISTS ttb_sen_persons CASCADE;
	CREATE TEMPORARY TABLE ttb_sen_persons
		(	cjamspid bigint,
			personid uuid,
			senstatusflag character varying,
			sentimestamp timestamp,
			dob timestamp
		) ;
	
	insert into ttb_sen_persons 
		(	cjamspid,
			personid, 
			senstatusflag, 
			sentimestamp, 
			dob 
		)
		select pr.cjamspid,
			pr.personid, 
			pr.senstatusflag,
			pr.substanceexposednewborntimetamp,
			pr.dob		
		from person pr 
		where pr.activeflag = 1
			and coalesce(pr.substanceexposednewbornflag, 0) = 1
			and coalesce(pr.senstatusflag, 1) = 1
			-- Unit Testing
			-- and pr.cjamspid in (200936406, 200936365, 200936327, 200936322,1012802, 1046742, 1051925, 1084539)
		;
	
	select count(*) into vl_total_sens from ttb_sen_persons ;
	
	OPEN cur_sen_persons FOR
		select cjamspid,
			personid,
			senstatusflag, 
			sentimestamp, 
			dob 		
		from ttb_sen_persons ;
	loop
	fetch cur_sen_persons into cur_sen_person;
		exit when not found;
	
		-- Reset
		vl_cjamspid := NULL;
		vu_person_id := NULL;
		vl_senstatusflag := NULL;
		vt_sentimestamp := NULL;
		vt_dob := NULL;
		
		vb_over90_days := FALSE;
		vb_over120_days := FALSE;
		vl_SFCI_count := NULL;
		vl_active_SFCI_count := NULL;
		vl_servicecase_count := NULL;
		vl_active_service_cases := NULL;
		vl_active_prog_assignment_count := NULL;
		vb_historic_sen := FALSE;
				
		vl_cjamspid	:= cur_sen_person.cjamspid;
		vu_person_id := cur_sen_person.personid;
		vl_senstatusflag := cur_sen_person.senstatusflag;
		vt_sentimestamp := cur_sen_person.sentimestamp;
		vt_dob := cur_sen_person.dob;
		
		-- RAISE NOTICE 'vl_total_sens >> %', vl_total_sens;
		-- RAISE NOTICE 'vl_cjamspid >> %',vl_cjamspid;
		
		-- After 90 days after the SEN Flag Added Date 
		IF ( vt_sentimestamp::date + interval '90 day')::date <= ad_run_dt THEN
			vb_over90_days := TRUE;
		END IF;

		-- the Age of the Child is more than 120 days (4 months)
		IF vb_historic_sen = FALSE THEN 
			IF ( vt_dob::date + interval '120 day')::date <= ad_run_dt THEN
				vb_over120_days := TRUE;
			END IF;
		END IF;	
		
		-- RAISE NOTICE 'vb_over90_days >> %',vb_over90_days;
		-- RAISE NOTICE 'vb_over120_days >> %',vb_over120_days;
				
		IF vb_over90_days = TRUE or vb_over120_days = TRUE THEN
			vb_historic_sen := TRUE;
		ELSE
			-- after end dating Program Assignment "Services to Families with Children - Intake" 
			select count(*) 
				into vl_SFCI_count
			from personprogramarea pp
			where pp.personid = vu_person_id
				and pp.programkey = 'IHSFP' -- In-Home Services/Family Preservation
				and pp.subprogramkey = 'SFCI' -- Services to Families with Children - Intake
				and pp.activeflag = 1 ;
				
			select count(*) 
				into vl_active_SFCI_count
			from personprogramarea pp
			where pp.personid = vu_person_id
				and pp.programkey = 'IHSFP' -- In-Home Services/Family Preservation
				and pp.subprogramkey = 'SFCI' -- Services to Families with Children - Intake
				and pp.activeflag = 1 			
				and pp.startdate is not null
				and pp.enddate is null ;
		
			-- RAISE NOTICE 'vl_SFCI_count >> %',vl_SFCI_count;
			-- RAISE NOTICE 'vl_active_SFCI_count >> %',vl_active_SFCI_count;
			
			IF vl_SFCI_count > 0 and vl_active_SFCI_count = 0 THEN
				vb_historic_sen := TRUE;
			END IF;
			
			-- Person is not involved in any open case must have the flag changed to a historic SEN.
			-- Active Service Case(s)
			select count(*) 
				into vl_servicecase_count
			from actor ac,
				intakeservicerequestactor acr
			where ac.actorid = acr.actorid 
				and acr.personid = vu_person_id
				and ac.activeflag = 1
				and acr.activeflag = 1
				and acr.servicecaseid is not null;
				
			select count(*)
				into vl_active_service_cases
			from (
				select acr.servicecaseid,
					(	select sd.dispositioncode 
							from servicecasedisposition sd
						where sd.servicecaseid = acr.servicecaseid
							and sd.activeflag = 1
						order by sd.statusdate desc
						limit 1 
					) as case_status	
				from actor ac,
					intakeservicerequestactor acr
				where ac.actorid = acr.actorid 
					and acr.personid = vu_person_id
					and ac.activeflag = 1
					and acr.activeflag = 1
					and acr.servicecaseid is not null
			) tab
			where lower(case_status) <> 'closed' ;
			
			-- RAISE NOTICE 'vl_servicecase_count >> %',vl_servicecase_count;			
			-- RAISE NOTICE 'vl_active_service_cases >> %',vl_active_service_cases;			
			
			/*
			-- Active Program Assignment(s)
			select count(*) 
				into vl_active_prog_assignment_count
			from personprogramarea pp
			where pp.personid = vu_person_id
				and pp.activeflag = 1 			
				and pp.startdate is not null
				and pp.enddate is null ;
			
			RAISE NOTICE 'vl_active_prog_assignment_count >> %',vl_active_prog_assignment_count;
			
			... and vl_active_prog_assignment_count = 0 THEN
			*/
			IF vl_servicecase_count > 0 and vl_active_service_cases = 0 THEN
				vb_historic_sen := TRUE;
			END IF;
		END IF;
		
		RAISE NOTICE 'vb_historic_sen >> %',vb_historic_sen;			
		IF vb_historic_sen = TRUE THEN 
			update person
			set senstatusflag = 0,
				updatedby = as_user_id,
				updatedon = now()
			where personid = vu_person_id
				and activeflag = 1 ;
			
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error in updating SEN Status Flag for ' || (vl_cjamspid)::character varying ;
				al_sqlcode := -1;
				ROLLBACK;
				exit;
			END IF;
		ELSE	
			update person
			set senstatusflag = 1,
				updatedby = as_user_id,
				updatedon = now()
			where personid = vu_person_id
				and activeflag = 1 ;
			
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error in updating SEN Status Flag for ' || (vl_cjamspid)::character varying ;
				al_sqlcode := -1;
				ROLLBACK;
				exit;
			END IF;
		
		END IF;	
		
		vl_total_sens := vl_total_sens - 1;
	END LOOP;	
	close cur_sen_persons;	
	
	IF al_sqlcode <> -1 then
		al_sqlcode := 0;
		as_mess := 'Success';
	END IF;	

	DROP TABLE IF EXISTS ttb_sen_persons CASCADE;	  
END;

$function$
;
