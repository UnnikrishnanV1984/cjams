CREATE OR REPLACE FUNCTION cjams.sp_adoptive_parents_data_sync(		as_user_id character varying, 
																	OUT al_sqlcode integer, 
																	OUT as_mess character varying
															  )
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 08/25/2023
-- To replace Adoptive Parent Person (CJAMS PIDs) 
-- with Applicant & Co-applicant Person CJAMS PIDs from the Provider Module side (CIDM-7696)

-- Revision(s)
-- 
------------------------------------------------------------------------
Declare sqlcode int default 0;

Declare vu_adoptioncaseid uuid;
Declare vu_adoptioncaseactorid uuid;
Declare vu_personid uuid;
Declare vu_prov_personid uuid;

Declare vs_adoptioncasenumber character varying;
Declare vs_firstname character varying;
Declare vs_middlename character varying;
Declare vs_lastname character varying;
Declare vs_MDM_ID character varying;
Declare vs_prov_MDM_ID character varying;
Declare vs_parents character varying;  
Declare vs_app_coapp_type character varying;  

Declare vl_count Bigint default 1;	
Declare vl_provider_id Bigint;
Declare vl_cjamspid Bigint;
Declare vl_prov_cjamspid Bigint;
Declare vl_provider2id Bigint;
Declare vl_app_coapp_provider_id Bigint;
	
Declare vl_clientflag integer;	
Declare vl_service_log integer;	
Declare vl_payments integer;	
Declare vl_program_assignment integer;	
Declare vl_prov_clientflag integer;	
Declare vl_old_prov_person integer;	

cur_adotion_cases_record record;
cur_adotion_cases_REFCURSOR REFCURSOR;

cur_adotion_parents_record record;
cur_adotion_parents_REFCURSOR REFCURSOR;

BEGIN

	if as_user_id is NULL then
		as_user_id := 'adop_pr_fix';
	end if;
		
	OPEN cur_adotion_cases_REFCURSOR FOR
		select distinct ad.adoptioncaseid,
			ad.adoptioncasenumber::bigint as adoptioncasenumber, 
			(select asa.provider_id
				from tb_adoption_subsidy_agreement asa 
			where asa.adoption_id = ad.alternateid 
			order by asa.agreement_start_dt desc
			limit 1) as provider_id
		from adoptioncase ad,
			adoptioncaseactor adc,
			person pr
		where ad.adoptioncaseid  = adc.adoptioncaseid 
			and adc.personid = pr.personid
			and adc.actortypekey = 'ADOPTIVEPARENT'
			and ad.activeflag = 1
			and adc.activeflag = 1
			and pr.activeflag = 1
			-- Unit Testing 
			-- and ad.adoptioncaseid  = '72edb5ee-3f37-493a-8fb4-9e0c8c02784a' -- 3004443
			-- and ad.adoptioncaseid = 'c4487328-6224-4721-ac1e-2cd463f4083f' -- 3086096
		order by ad.adoptioncasenumber::bigint ;  
	loop
	fetch cur_adotion_cases_REFCURSOR into cur_adotion_cases_record;
		exit when not found;
		
		RAISE NOTICE 'Case # >> %',  vl_count;	

		-- Reset
		vu_adoptioncaseid := NULL;
		vs_adoptioncasenumber := NULL;
		vl_provider_id := NULL;
		
		vu_adoptioncaseid := cur_adotion_cases_record.adoptioncaseid;
		vs_adoptioncasenumber := cur_adotion_cases_record.adoptioncasenumber;
		vl_provider_id := cur_adotion_cases_record.provider_id;
		
		select * from getadoptiveparents(vl_provider_id::character varying) into vs_parents; 

		select (case when ((vs_parents::character varying)::json -> 0 -> 'provider2id')::character varying = 'null' then 
					null 
				else 
					((vs_parents::character varying)::json -> 0 -> 'provider2id')
				end) 
		into vl_provider2id;
		  
		RAISE NOTICE 'Adoption Case ID >> %', vs_adoptioncasenumber;	
		RAISE NOTICE 'Provider ID >> %',  vl_provider_id;	
		RAISE NOTICE 'Co-App Provider ID >> %',  vl_provider2id;	
		
		OPEN cur_adotion_parents_REFCURSOR FOR
			select pr.cjamspid, 
				pr.firstname, 
				pr.middlename, 
				pr.lastname, 
				pr.clientflag, 
				adc.adoptioncaseactorid, 
				adc.personid,
				( 
				 select pd.personidentifiervalue 
					from personidentifier pd
				 where pd.personid = adc.personid
					and pd.personidentifiertypekey = 'MDM_ID'
					and pd.activeflag = 1	
				 order by pd.insertedon desc
				 limit 1
				) as MDM_ID
			from adoptioncaseactor adc,
				person pr
			where adc.personid = pr.personid
				and adc.adoptioncaseid = vu_adoptioncaseid
				and actortypekey = 'ADOPTIVEPARENT'
				and adc.activeflag = 1
				and pr.activeflag = 1;  
		loop
		fetch cur_adotion_parents_REFCURSOR into cur_adotion_parents_record;
			exit when not found;

			-- Reset
			vl_cjamspid := NULL;
			vs_firstname := NULL;
			vs_middlename := NULL;
			vs_lastname := NULL;
			vl_clientflag := NULL;
			vu_adoptioncaseactorid := NULL;
			vu_personid := NULL;
			vs_MDM_ID := NULL;
			vl_service_log := 0;
			vl_payments := 0;
			vl_program_assignment := 0;
			vl_old_prov_person := 0;
			
			vl_cjamspid := cur_adotion_parents_record.cjamspid;
			vs_firstname := cur_adotion_parents_record.firstname;
			vs_middlename := cur_adotion_parents_record.middlename;
			vs_lastname := cur_adotion_parents_record.lastname;
			vl_clientflag := cur_adotion_parents_record.clientflag;
			vu_adoptioncaseactorid := cur_adotion_parents_record.adoptioncaseactorid;
			vu_personid := cur_adotion_parents_record.personid;
			vs_MDM_ID := cur_adotion_parents_record.MDM_ID;
				
			RAISE NOTICE 'CW Adoptive Parent CJAMS PID >> %', vl_cjamspid;	
			
			-- Check for MDM ID
			if vs_MDM_ID is not null then
				RAISE NOTICE 'Adoptive Parent is registered with MDM.';	
			end if;
			
			-- Check for Old Provider Parent CJAMS PID
			select count(*)
				into vl_old_prov_person
			from intakeservicerequestactor isra,
				actor ac,
				person pr
			where isra.actorid = ac.actorid
				and ac.personid = pr.personid
				and isra.objectid = vl_provider_id::character varying
				and isra.objecttype = 'prov_provider' 
				and coalesce(isra.isprimary, false) = true
				and isra.activeflag = 1 -- ??
				and isra.intakeservicerequestpersontypekey in ('APLCNT', 'COAPLCNT')
				and pr.cjamspid = vl_cjamspid
				and pr.activeflag = 1 ;
			
			if vl_old_prov_person > 0 then
				RAISE NOTICE 'Old Provider Parent CJAMS PID Data found.';	
			end if;
			
			-- Check for Sevice log 
			select count(*)
				into vl_service_log
			from tb_service_log
			where case_id = vs_adoptioncasenumber::bigint
				and client_id = vl_cjamspid
				and delete_sw = 'N' ;
			
			if vl_service_log > 0 then
				RAISE NOTICE 'Service Log Data found.';	
			end if;
			
			-- Check for Payment
			select count(*)
				into vl_payments
			from tb_payment_detail
			where case_id = vs_adoptioncasenumber::bigint
				and client_id = vl_cjamspid
				and delete_sw = 'N' ;
				
			if vl_payments > 0 then
				RAISE NOTICE 'Payment Data found.';	
			end if;
			
			-- Check for Program Assignment 
			select count(*)
				into vl_program_assignment
			from personprogramarea
			where objectid = vu_adoptioncaseid::character varying
				and personid = vu_personid
				and activeflag = 1 ;

			if vl_program_assignment > 0 then
				RAISE NOTICE 'Program Assignment Data found.';	
			end if;

			if vs_MDM_ID is not null  or vl_service_log > 0 or vl_payments > 0 
				or vl_program_assignment > 0 or vl_old_prov_person > 0 then
				RAISE NOTICE 'Do NOT update Adoption Parent ID as Transactions(s) found.';	
			else
			
				vl_prov_cjamspid := NULL ;
				vu_prov_personid := NULL ;
				vl_prov_clientflag := NULL ;
				vs_prov_MDM_ID := NULL ;
				vs_app_coapp_type := NULL;
				vl_app_coapp_provider_id := NULL;
				
				select pr.cjamspid,
					pr.personid, 
					coalesce(pr.clientflag, 2) as clientflag,
					( select pid.personidentifiervalue
						from personidentifier pid
						where pid.personid = pr.personid
							and pid.activeflag = 1
							and pid.personidentifiertypekey = 'MDM_ID'
					) as MDM_ID,
					(case when isra.intakeservicerequestpersontypekey = 'APLCNT' then 
						'Applicant'
					 else -- 'COAPLCNT'
						'Co-Applicant'
					 end) as app_coapp_type
				into vl_prov_cjamspid,
					vu_prov_personid,
					vl_prov_clientflag,
					vs_prov_MDM_ID,
					vs_app_coapp_type
				from intakeservicerequestactor isra,
					actor ac,
					person pr
				where isra.actorid = ac.actorid
					and ac.personid = pr.personid
					and isra.objectid = vl_provider_id::character varying
					and isra.objecttype = 'prov_provider' 
					and coalesce(isra.isprimary, false) = true
					and isra.activeflag = 1 -- ??
					and isra.intakeservicerequestpersontypekey in ('APLCNT', 'COAPLCNT')
					and lower(pr.firstname) = lower(vs_firstname)
					and lower(pr.lastname) = lower(vs_lastname)
					and pr.activeflag = 1
				order by isra.insertedon desc 
				limit 1 ;
			
				RAISE NOTICE 'PROV Adoptive Parent CJAMS PID >> %', vl_prov_cjamspid;	
				
				-- check if Adoptive Parent first name and last name are the same from CW side and Provider side 
				If vl_prov_cjamspid > 0 and vu_personid <> vu_prov_personid then 
					-- Update Adoption Parent ID from Provider side 
					
					-- For Test RUN
					RAISE NOTICE 'Update Adoptive Parent personid as >> %', vu_prov_personid;	
					
					update adoptioncaseactor 
					set personid = vu_prov_personid, 
						updatedby = as_user_id,
						updatedon = now() 
					where adoptioncaseactorid = vu_adoptioncaseactorid
						and activeflag = 1 ; 
					
					-- Update Provider IDs
					RAISE NOTICE 'Update providerid for >> %' , vs_app_coapp_type ;	
						
					if vs_app_coapp_type = 'Applicant' then
						vl_app_coapp_provider_id := vl_provider_id;
					else -- 'Co-Applicant'
						vl_app_coapp_provider_id := coalesce(vl_provider2id, vl_provider_id);
					end if;
					
					RAISE NOTICE 'Update  vl_app_coapp_provider_id >> %' , vl_app_coapp_provider_id ;
					
					update person 
					set -- clientflag = 1, 
						providerid = vl_app_coapp_provider_id,
						updatedon = now(), 
						updatedby = as_user_id
					where cjamspid = vl_prov_cjamspid
						and activeflag = 1;
						
					-- Update Client flag as 1 and Register with MDM - take as seperate activiy 
					/*
					if vl_prov_clientflag <> 1 then  
						
						if vs_app_coapp_type = 'Applicant' then
							vl_app_coapp_provider_id := vl_provider2id;
						else -- 'Co-Applicant'
							vl_app_coapp_provider_id := coalesce(vl_provider2id, vl_provider_id);
						end if;
						
						update person 
						set clientflag = 1, 
							providerid = vl_app_coapp_provider_id,
							updatedon = now(), 
							updatedby = as_user_id
						where cjamspid = vl_prov_cjamspid
							and activeflag = 1;
					end if;
					*/
				else
					if vu_personid = vu_prov_personid  then
						RAISE NOTICE 'Do NOT update, Adoption Parent CJAMS PID is same on CW & PROV side.';	
					else
						RAISE NOTICE 'Do NOT update Adoption Parent ID as NO first and last name match found.';	
					end if;	
				end if;
			end if;
		END LOOP;	
	
		close cur_adotion_parents_REFCURSOR;
		
		vl_count := vl_count + 1;
	END LOOP;	
	
	close cur_adotion_cases_REFCURSOR;
	
	al_sqlcode := 0;
	as_mess :=  'success' ;
		
END;

$function$
;

