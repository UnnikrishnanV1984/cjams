CREATE OR REPLACE FUNCTION cjams.sp_personrole_fix(	as_user_id character varying, 
													OUT al_sqlcode integer, 
													OUT as_mess character varying
												  )
RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 04/17/2023

-- To fix the duplicate Person card issue (CIDM-7001)

-- Revision(s)
------------------------------------------------------------------------
Declare sqlcode int default 0;

Declare vu_person_id uuid;
Declare vu_intakeserviceid uuid;
Declare vu_servicecaseid uuid;
Declare vu_personroleid uuid;
Declare vu_personroleid_to_keep uuid;
 
Declare vs_actiontype character varying;
Declare vs_servicerequestnumber character varying;
Declare vs_servicecasenumber character varying;

Declare vl_cjamspid bigint;
Declare vl_role_with_case bigint;

cur_person_role record;
cur_person_roles REFCURSOR;

cur_case_person_role record;
cur_case_person_roles REFCURSOR;
			
BEGIN
	if as_user_id is NULL then
		as_user_id := 'cw_personrole_fix';
	end if;
	
	-- Remove Duplicate	Person roles
	DROP TABLE IF EXISTS ttb_cps_dup_person_roles CASCADE;
	CREATE TEMPORARY TABLE ttb_cps_dup_person_roles
		( actiontype character varying, 
		  servicerequestnumber character varying,
		  cjamspid bigint,
		  personid uuid,
		  intakeserviceid uuid,
		  role_count integer 
		) ;
		
	
	-- CPS cases 
	insert into ttb_cps_dup_person_roles 
	(	actiontype, 
		servicerequestnumber,
		cjamspid,
		personid,
		intakeserviceid,
		role_count
    )
	select distinct isr.actiontype, 
		isr.servicerequestnumber, 
		pr.cjamspid,
		prl.personid,
		prl.intakeserviceid,
		count(*) as role_count
	from personrole prl,
		intakeservicerequest isr,
		person pr
	where prl.intakeserviceid = isr.intakeserviceid
		and prl.personid =  pr.personid
		and prl.activeflag = 1
		and isr.activeflag = 1
		and pr.activeflag = 1
		and isr.actiontype in ('AR', 'IR')
		and coalesce(isr.teamtypekey, 'CW') = 'CW'
		and prl.personid not in ('00000000-0000-0000-0000-000000000000')
		and prl.intakeserviceid is not null
		and (select count(*)
				from personrole prl1
				where prl1.ishouseholdmember = 1 
					and prl1.intakeserviceid = prl.intakeserviceid
					and prl1.personid = prl.personid
					and prl1.activeflag = 1
				) > 0	
		and (select count(*)
				from personrole prl2
				where prl2.ishouseholdmember = 2 
					and prl2.intakeserviceid = prl.intakeserviceid
					and prl2.personid = prl.personid
					and prl2.activeflag = 1
				) > 0
		-- Unit Testing 			
		-- and isr.servicerequestnumber in ( 'CW2956374', 'CW2915951', '231020480177', '231020477455' )
	group by pr.cjamspid,
		isr.actiontype, 
		isr.servicerequestnumber, 
		prl.personid,
		prl.intakeserviceid
	having count(*) > 1
	order by isr.servicerequestnumber desc;
	

	OPEN cur_person_roles FOR
		select actiontype, 
			servicerequestnumber,
			cjamspid,
			personid,
			intakeserviceid,
			role_count			
		from ttb_cps_dup_person_roles ;
	loop
		fetch cur_person_roles into cur_person_role;
			exit when not found;
		
			-- Reset
			vs_actiontype := NULL;
			vs_servicerequestnumber := NULL;
			vl_cjamspid := NULL;
			vu_person_id := NULL;
			vu_intakeserviceid := NULL;
			
			vs_actiontype := cur_person_role.actiontype;
			vs_servicerequestnumber := cur_person_role.servicerequestnumber;
			vl_cjamspid := cur_person_role.cjamspid;
			vu_person_id := cur_person_role.personid;
			vu_intakeserviceid := cur_person_role.intakeserviceid;
			
			RAISE NOTICE 'vl_cjamspid >> %',vl_cjamspid;
			RAISE NOTICE 'vs_servicerequestnumber >> %', vs_actiontype || ' ' || vs_servicerequestnumber;
			
			-- Reset
			vu_personroleid_to_keep := NULL;
				
			OPEN cur_case_person_roles FOR
				select prl.personroleid, 
					-- prl.intakeserviceid, 
					prl.servicecaseid, 
					--	prl.intakenumber, 
					-- prl.ishouseholdmember, 
					RANK() OVER(PARTITION BY prl.personid, prl.intakeserviceid
						ORDER BY prl.insertedon desc, prl.updatedon desc, prl.personroleid desc 
						) role_rank, 
					(select count(*)
					from personrole prl1
					where prl1.intakeserviceid = prl.intakeserviceid
						and prl1.personid = prl.personid
						and prl1.servicecaseid is not null
						and prl1.activeflag = 1
					) as role_with_case		
				from personrole prl
				where prl.intakeserviceid = vu_intakeserviceid
					and prl.personid = vu_person_id
					and prl.activeflag = 1
				order by role_rank  ;
			loop
				fetch cur_case_person_roles into cur_case_person_role;
					exit when not found;
			
				-- Reset
				vl_role_with_case := NULL;
				vu_personroleid := NULL;
				vu_servicecaseid := NULL;
				
				vl_role_with_case := cur_case_person_role.role_with_case;
				vu_personroleid := cur_case_person_role.personroleid;
				vu_servicecaseid := cur_case_person_role.servicecaseid;
				
				if vu_personroleid_to_keep is NULL then
					if vl_role_with_case = 0 then 
						vu_personroleid_to_keep := vu_personroleid;
					else
						If vu_servicecaseid is not null then
							vu_personroleid_to_keep := vu_personroleid;
						end if;
					end if;	
				end if;
				
			END LOOP;	
			close cur_case_person_roles;	
			
			if vu_personroleid_to_keep is NULL then
				RAISE NOTICE 'Error - vu_personroleid_to_keep NOT Found';
			else	
				update personrole
				set activeflag = 0,
					updatedby = as_user_id,
					updatedon = now()
				where intakeserviceid = vu_intakeserviceid
					and personid = vu_person_id
					and activeflag = 1
					and personroleid <> vu_personroleid_to_keep ;
							
				al_sqlcode := SQLCODE;
				IF al_sqlcode < 0 THEN
					as_mess := 'Error updating duplicate Person Roles.';
					al_sqlcode := -1;
					ROLLBACK;
					exit;
				END IF ;
			end if;
	END LOOP;	
	close cur_person_roles;	
	
	-- DROP TABLE IF EXISTS ttb_cps_dup_person_roles CASCADE;	  
END;

$function$
;
