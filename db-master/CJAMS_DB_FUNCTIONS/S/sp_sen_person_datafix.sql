CREATE OR REPLACE FUNCTION cjams.sp_sen_person_datafix(	as_user_id character varying, 
														OUT al_sqlcode integer, 
														OUT as_mess character varying
													  )
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 08/04/2022
-- To fix the Person Substance Exposed Newborn Flag issue (CIDM-5306)
-- 1) Update the Person tbale with SEN information 
-- 2) Update the SDM table (intakeservicerequestsdm --> drugexposednewbornflag)

-- Revision(s)
------------------------------------------------------------------------
Declare sqlcode int default 0;
Declare vu_person_id uuid;
Declare vu_personroleid uuid;
Declare vu_intakeserviceid uuid;
Declare vu_servicecaseid uuid;

Declare vs_intakenumber character varying;
Declare vs_servicerequestnumber character varying;
Declare vs_servicecasenumber character varying;
Declare vs_case_type character varying;
Declare vs_case_number character varying;
Declare vs_otherdrugs character varying;

Declare v_drug_info_insertedon timestamp;
Declare v_drugexposedtypekey json;
								
Declare vl_drugexposednewbornflag Integer;

cur_sen_person record;
cur_sen_persons REFCURSOR;

cur_sen_sdm record;
cur_sen_sdms REFCURSOR;

BEGIN
	if as_user_id is NULL then
		as_user_id := 'cwcjams_senfix';
	end if;
	
	-- Update the Person tbale with SEN information 
	DROP TABLE IF EXISTS ttb_sen_persons CASCADE;
	CREATE TEMPORARY TABLE ttb_sen_persons
		(	personid uuid ) ;
		
	
	insert into ttb_sen_persons ( personid )
	select distinct prl.personid 
	from personrole prl,
		person p 
	where prl.personid = p.personid 
		and prl.activeflag = 1
		and p.activeflag = 1
		and prl.drugexposednewbornflag = 1
		and coalesce(p.substanceexposednewbornflag, 0) <> 1
		-- Unit Testing
		-- and prl.personid = 'c58ad1a2-6a55-4339-9573-723512815948'
	;
	
	OPEN cur_sen_persons FOR
		select personid			
		from ttb_sen_persons ;
	loop
		fetch cur_sen_persons into cur_sen_person;
			exit when not found;
		
			-- Reset
			vu_person_id := NULL;
			vu_personroleid := NULL;
			vs_intakenumber := NULL;
			vu_intakeserviceid := NULL;
			vu_servicecaseid := NULL;
			vs_case_type := NULL;
			
			vu_person_id := cur_sen_person.personid;
			
			RAISE NOTICE 'vu_person_id >> %',vu_person_id;
			
			select prl.personroleid,	
				prl.intakenumber,
				prl.intakeserviceid,
				prl.servicecaseid,
				prl.insertedon,
				prl.drugexposedtypekey, 
				prl.otherdrugs
			into vu_personroleid, 
				vs_intakenumber,
				vu_intakeserviceid,
				vu_servicecaseid,
				v_drug_info_insertedon,
				v_drugexposedtypekey,
				vs_otherdrugs	
			from personrole prl 
			where prl.activeflag = 1
				and prl.drugexposednewbornflag = 1
				and prl.personid = vu_person_id
				and (	prl.intakenumber is not null 
						or 
						prl.intakeserviceid is not null 
						or
						prl.servicecaseid is not null 
					)	
			order by prl.insertedon	
			limit 1 ;
					
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error in Getting first case where SEN was identified.';
				al_sqlcode := -1;
				ROLLBACK;
				exit;
			END IF ;
			
			RAISE NOTICE 'vu_personroleid >> %',vu_personroleid;
			RAISE NOTICE 'vs_intakenumber >> %',vs_intakenumber;
			RAISE NOTICE 'vu_intakeserviceid >> %',vu_intakeserviceid;
			RAISE NOTICE 'vu_servicecaseid >> %',vu_servicecaseid;
			
			
			if vs_intakenumber is not null then
				vs_case_type := '2954'; -- Intake/Referral
				vs_case_number := vs_intakenumber ;
			elseif vu_intakeserviceid is not null then	
				vs_case_type := '2957'; -- CPS
				
				select servicerequestnumber 
					into vs_servicerequestnumber
				from intakeservicerequest 
				where intakeserviceid  = vu_intakeserviceid ;
				
				vs_case_number := vs_servicerequestnumber;
			elseif vu_servicecaseid is not null then	
				vs_case_type := '2952'; --Service Case
				
				select servicecasenumber 
					into vs_servicecasenumber
				from servicecase 
				where servicecaseid = vu_servicecaseid;

				vs_case_number := vs_servicecasenumber ;
			else
				vs_case_type := 'Error';	
			end if;	
			
			if vs_case_type <> 'Error' then
				RAISE NOTICE 'Update Person table...' ;
				RAISE NOTICE 'vs_case_type >> %',vs_case_type;
				RAISE NOTICE 'vs_case_number >> %',vs_case_number;
				RAISE NOTICE 'v_drug_info_insertedon >> %',v_drug_info_insertedon;
				RAISE NOTICE 'v_drugexposedtypekey >> %',v_drugexposedtypekey;
				RAISE NOTICE 'vs_otherdrugs >> %',vs_otherdrugs;
			
				update person
				set substanceexposednewbornflag = 1,
					substanceexposednewbornsourcetypekey = vs_case_type,
					substanceexposednewbornsourceid = vs_case_number,
					substanceexposednewborntimetamp = v_drug_info_insertedon,
					substanceclasses = v_drugexposedtypekey, 
					othersubstances = vs_otherdrugs,
					updatedby = as_user_id,
					updatedon = now()
				where personid = vu_person_id
				and activeflag = 1 ;
				
			else
				RAISE NOTICE 'Case info is missing where SEN is identified >> %',vu_person_id;
			end if;
			
	END LOOP;	
	close cur_sen_persons;	
	
	-- Update the SDM table (intakeservicerequestsdm --> drugexposednewbornflag)
	OPEN cur_sen_sdms FOR
		select pr.substanceexposednewbornsourcetypekey,
			pr.substanceexposednewbornsourceid
		from person pr
		where pr.activeflag  = 1
			and pr.substanceexposednewbornflag = 1
			and pr.updatedby = 'CIDM-5306' ;
	loop
		fetch cur_sen_sdms into cur_sen_sdm;
			exit when not found;
		
			-- Reset
			vs_case_type := NULL;
			vs_case_number := NULL;
			vu_intakeserviceid := NULL;
			vl_drugexposednewbornflag := NULL;
			
			vs_case_type := cur_sen_sdm.substanceexposednewbornsourcetypekey;
			vs_case_number := cur_sen_sdm.substanceexposednewbornsourceid;
			
			RAISE NOTICE 'vs_case_type >> %',vs_case_type;
			RAISE NOTICE 'vs_case_number >> %',vs_case_number;
			
			if vs_case_type = '2954' then  
				select intakeserviceid
					into vu_intakeserviceid
				from intakeservicerequest 
				where intakenumber = vs_case_number 
					-- and activeflag = 1 -- Commented for SEN Risk of harm cases 
				;
			else -- '2957'
				select intakeserviceid 
					into vu_intakeserviceid
				from intakeservicerequest 
				where servicerequestnumber = vs_case_number 
					and activeflag = 1 ;
			end if;
			
			RAISE NOTICE 'vu_intakeserviceid >> %',vu_intakeserviceid;
			
			select drugexposednewbornflag
				into vl_drugexposednewbornflag
			from intakeservicerequestsdm   
			where intakeserviceid  = vu_intakeserviceid
				and activeflag = 1 ;

			if vl_drugexposednewbornflag is null then
				vl_drugexposednewbornflag := 0;
			end if;
			
			if vl_drugexposednewbornflag <> 1 then
				RAISE NOTICE 'Update drugexposednewbornflag';
				
				update intakeservicerequestsdm
				set drugexposednewbornflag = 1, 
					updatedby = as_user_id,
					updatedon = now()
				where intakeserviceid  = vu_intakeserviceid
				and activeflag = 1 ;
			else
				RAISE NOTICE 'No changes required, drugexposednewbornflag value is 1';			
			end if;
			
	END LOOP;	
	close cur_sen_sdms;	
	
	IF al_sqlcode <> -1 then
		al_sqlcode := 0;
		as_mess := 'Success';
	END IF;	

	DROP TABLE IF EXISTS ttb_sen_persons CASCADE;	  
END;

$function$
;
