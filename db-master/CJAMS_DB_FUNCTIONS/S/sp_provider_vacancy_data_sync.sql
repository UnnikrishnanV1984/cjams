CREATE OR REPLACE FUNCTION cjams.sp_provider_vacancy_data_sync(		as_user_id character varying, 
																	as_fix_closed_providers character varying, 
																	OUT al_sqlcode integer, 
																	OUT as_mess character varying
															  )
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 07/12/2023
-- Update provider vacancy to sync with Approved beds and active approved placements/ Placement Entries in Review status (CDM-32895)

-- Revision(s)
-- 09/15/2023 - Vineet Tirodkar - To capture data in the Audit Log table (CIDM-7866)
-- 03/28/2024 - Vineet Tirodkar - To fix the providers with multiple addresses marked as default data issue (CIDM-8613)
-- 03/12/2026 - Sreekanth Marrikanti - Fix for clearing the rowlocks on tb_provider & tb_contract_program table records (CIDM-11219)
------------------------------------------------------------------------
Declare sqlcode int default 0;

Declare vl_provider_id Bigint;
Declare vl_program_id Bigint;
Declare vs_program_nm character varying;
Declare vs_status character varying;
Declare vs_logtypekey character varying default 'PROVVACANCY';
Declare v_event_org_description character varying;
Declare v_event_description character varying;
Declare vs_parent_key_id character varying;

Declare vl_contract_beds_no Integer;
Declare vl_approved_beds Integer;
Declare vl_active_placements Integer;
Declare vl_calculated_vacancy Integer;
Declare vl_vacancy_no Integer;
Declare vl_address_rank Integer;

Declare vl_address_id Bigint;
		
cur_private_provider_record record;
cur_private_provider_REFCURSOR REFCURSOR;

cur_public_provider_record record;
cur_public_provider_REFCURSOR REFCURSOR;

cur_impacted_providers_record record;
cur_impacted_providers_REFCURSOR REFCURSOR;

cur_provider_add_fix_record record;
cur_provider_add_fix_REFCURSOR REFCURSOR;

BEGIN

	if as_user_id is NULL then
		as_user_id := 'vacancy_fix';
	end if;
		
	if as_fix_closed_providers is NULL or btrim(as_fix_closed_providers) = '' then
		as_fix_closed_providers = 'N';
	end if;	
	
	select logtype 
		into v_event_org_description
	from auditlogtype 
	where lower(btrim(logtypekey)) = lower(btrim(vs_logtypekey));

	-- Active Public providers
	RAISE NOTICE 'Active Public Provider - Start';
	
	OPEN cur_public_provider_REFCURSOR FOR
		select tb_main.provider_id,
				tb_main.status,
				tb_main.approved_beds,
				tb_main.active_placements,
				tb_main.calculated_vacancy,
				tb_main.vacancy_no
		from (
			select tab.*,
				(tab.approved_beds - tab.active_placements )as calculated_vacancy
			from (
				select pr.provider_id, 
					f_pdesc(pr.provider_status_cd, 159) as status,
					(	select pa.approved_beds_no
							from prov.tb_provider_approval pa
						where pa.provider_id = pr.provider_id
							and pa.delete_sw = 'N'
						order by pa.provider_approval_id desc
						limit 1
					) as approved_beds,
					(select count(*) 
							from placement pl
						where pl.altproviderid = pr.provider_id
							and pl.activeflag = 1
							and pl.startdatetime is not null
							and pl.enddatetime is null
							and coalesce(pl.isvoided, 0) <> 1
							and (
									( select count(*)
										from routing ro
									  where ro.objectid = pl.placementid::character varying
										and ro.eventcode = 'PLTR'
										and ro.routingstatustypeid = 16
										and ro.activeflag = 1
									) > 0	
									or 
									( select count(*)
										from routing ro
									  where ro.objectid = pl.placementid::character varying
										and ro.eventcode = 'PLTR'
										and ro.routingstatustypeid = 15
										and ro.activeflag = 1
									) > 0	
								)
						) as active_placements,
					pr.vacancy_no 
				from prov.tb_provider pr
				where pr.delete_sw = 'N' 
					-- Active
					and btrim(pr.provider_status_cd) <> '1792'
					-- Closed 
					-- and btrim(pr.provider_status_cd) <> '1791'
					and f_prvpcklst_cat(pr.provider_id::bigint,'PLACEMENT') = '1783' 
			) tab 
		) tb_main
		where tb_main.vacancy_no <> tb_main.calculated_vacancy
		order by tb_main.provider_id;  
	loop
	fetch cur_public_provider_REFCURSOR into cur_public_provider_record;
		exit when not found;

		-- Reset
		vl_provider_id := NULL;
		vs_status := NULL;
		vl_approved_beds := NULL;
		vl_active_placements := NULL;
		vl_calculated_vacancy := NULL;
		vl_vacancy_no := NULL;
		v_event_description := v_event_org_description;
		
		vl_provider_id := cur_public_provider_record.provider_id;
		vs_status := cur_public_provider_record.status;
		vl_approved_beds := cur_public_provider_record.approved_beds;
		vl_active_placements := cur_public_provider_record.active_placements;
		vl_calculated_vacancy := cur_public_provider_record.calculated_vacancy;
		vl_vacancy_no := cur_public_provider_record.vacancy_no;
			
		RAISE NOTICE 'vl_provider_id >> %',vl_provider_id;	
		
		If vl_calculated_vacancy <> vl_vacancy_no 
			-- and vl_calculated_vacancy >= 0 
			-- and vl_calculated_vacancy <= vl_approved_beds 
			then 
			
			update prov.tb_provider
			set vacancy_no = vl_calculated_vacancy,
				update_user_id = as_user_id,
				update_ts = now()
			where provider_id = vl_provider_id
				and delete_sw = 'N' ;
				
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error updating the vacancy_no for Provider # ' || vl_provider_id;
				al_sqlcode := -1;
				ROLLBACK;
				exit;
			END IF ;
			
			v_event_description :=  v_event_description || ' to ' || vl_calculated_vacancy || ' for Provider # ' || vl_provider_id || '. (' || 'Incorrect vacancy was ' || vl_vacancy_no || ')';
			
			INSERT INTO cjams.auditlog
				(	logid, logtypekey, intakeserviceid, servicerequestnumber, referenceid, 
					description, isnew, isedit, isdelete, insertedby, 
					updatedby, insertedon, updatedon, metadata, ipaddress, 
					old_id, modifieddata, objectid, objecttype
				)
			VALUES
				(	gen_random_uuid(), vs_logtypekey, NULL, NULL, NULL, 
					v_event_description, NULL, NULL, NULL, as_user_id, 
					as_user_id, now(), now(), NULL, NULL, 
					NULL, NULL, vl_provider_id, 'Provider'
				);

			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error in capturing the data in the audit log table for Provider # ' || vl_provider_id;
				al_sqlcode := -1;
				ROLLBACK;
				exit;
			END IF ;
		end if;
	END LOOP;	
	
	close cur_public_provider_REFCURSOR;
	
	RAISE NOTICE 'Active Public Provider - End';
	
	-- Private Provider
	RAISE NOTICE 'Private Provider - Start';
	
	OPEN cur_private_provider_REFCURSOR FOR
		select tb_main.provider_id,
			tb_main.program_id,
			tb_main.program_nm,
			tb_main.contract_beds_no,
			tb_main.active_placements,
			tb_main.calculated_vacancy,
			tb_main.vacancy_no
		from (
			select tab.*,
				(tab.contract_beds_no - tab.active_placements )as calculated_vacancy
			from (
			select cc.provider_id,
				cp.program_id, 
				cp.program_nm, 
				f_pdesc(cp.program_status_cd, 374) as status,
				cp.contract_beds_no, 
				(select count(*) 
					from placement pl
				 where pl.contractprogramid = cp.program_id
					and pl.activeflag = 1
					and pl.startdatetime is not null
					and pl.enddatetime is null
					and coalesce(pl.isvoided, 0) <> 1	
					and (
							( select count(*)
								from routing ro
							  where ro.objectid = pl.placementid::character varying
								and ro.eventcode = 'PLTR'
								and ro.routingstatustypeid = 16
								and ro.activeflag = 1
							) > 0	
							or 
							( select count(*)
								from routing ro
							  where ro.objectid = pl.placementid::character varying
								and ro.eventcode = 'PLTR'
								and ro.routingstatustypeid = 15
								and ro.activeflag = 1
							) > 0	
						)
				) as active_placements,
				cp.vacancy_no
			from prov.tb_contract_program cp,
				prov.tb_provider_contracts cc
			where cp.contract_id = cc.contract_id
				and cp.delete_sw = 'N' 
				and cc.delete_sw = 'N' 
				-- and cp.program_status_cd is null 
			) as tab 
		) tb_main
		where tb_main.vacancy_no <> tb_main.calculated_vacancy
		order by tb_main.provider_id,
			tb_main.program_id 	; 
	loop
	fetch cur_private_provider_REFCURSOR into cur_private_provider_record;
		exit when not found;

		-- Reset
		vl_provider_id := NULL;
		vl_program_id := NULL;
		vs_program_nm := NULL;
		vl_contract_beds_no := NULL;
		vl_active_placements := NULL;
		vl_calculated_vacancy := NULL;
		vl_vacancy_no := NULL;
		v_event_description := v_event_org_description;
		
		vl_provider_id := cur_private_provider_record.provider_id;
		vl_program_id := cur_private_provider_record.program_id;
		vs_program_nm := cur_private_provider_record.program_nm;
		vl_contract_beds_no := cur_private_provider_record.contract_beds_no;
		vl_active_placements := cur_private_provider_record.active_placements;
		vl_calculated_vacancy := cur_private_provider_record.calculated_vacancy;
		vl_vacancy_no := cur_private_provider_record.vacancy_no;
			
		RAISE NOTICE 'vl_provider_id >> %',vl_provider_id;	
		RAISE NOTICE 'vl_program_id >> %',vl_program_id;
		
		If vl_calculated_vacancy <> vl_vacancy_no 
			-- and vl_calculated_vacancy >= 0 
			-- and vl_calculated_vacancy <= vl_contract_beds_no 
			then 
			
			update prov.tb_contract_program
			set vacancy_no = vl_calculated_vacancy,
				update_user_id = as_user_id,
				update_ts = now()
			where program_id = vl_program_id
				and delete_sw = 'N' ;
				
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error updating the vacancy_no for Contarct Program # ' || vl_program_id;
				al_sqlcode := -1;
				ROLLBACK;
				exit;
			END IF ;
			
			v_event_description :=  v_event_description || ' to ' || vl_calculated_vacancy || ' for Provider # ' || vl_provider_id || ' - Contract Program # ' || vl_program_id || '. (' || 'Incorrect vacancy was ' || vl_vacancy_no || ')';
			
			INSERT INTO cjams.auditlog
				(	logid, logtypekey, intakeserviceid, servicerequestnumber, referenceid, 
					description, isnew, isedit, isdelete, insertedby, 
					updatedby, insertedon, updatedon, metadata, ipaddress, 
					old_id, modifieddata, objectid, objecttype
				)
			VALUES
				(	gen_random_uuid(), vs_logtypekey, NULL, NULL, NULL, 
					v_event_description, NULL, NULL, NULL, as_user_id, 
					as_user_id, now(), now(), NULL, NULL, 
					NULL, NULL, vl_provider_id, 'Provider'
				);

			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error in capturing the data in the audit log table for Contarct Program # ' || vl_program_id;
				al_sqlcode := -1;
				ROLLBACK;
				exit;
			END IF ;
			
		end if;
	END LOOP;	
	
	close cur_private_provider_REFCURSOR;	
	
	RAISE NOTICE 'Private Provider - End';
	
	-- Closed Public Providers
	if as_fix_closed_providers = 'Y' then 
	
		RAISE NOTICE 'Closed Public Provider - Start';
		
		OPEN cur_public_provider_REFCURSOR FOR
			select tb_main.provider_id,
					tb_main.status,
					tb_main.approved_beds,
					tb_main.active_placements,
					tb_main.calculated_vacancy,
					tb_main.vacancy_no
			from (
				select tab.*,
					(tab.approved_beds - tab.active_placements )as calculated_vacancy
				from (
					select pr.provider_id, 
						f_pdesc(pr.provider_status_cd, 159) as status,
						(	select pa.approved_beds_no
								from prov.tb_provider_approval pa
							where pa.provider_id = pr.provider_id
								and pa.delete_sw = 'N'
							order by pa.provider_approval_id desc
							limit 1
						) as approved_beds,
						(select count(*) 
								from placement pl
							where pl.altproviderid = pr.provider_id
								and pl.activeflag = 1
								and pl.startdatetime is not null
								and pl.enddatetime is null
								and coalesce(pl.isvoided, 0) <> 1
								and (
										( select count(*)
											from routing ro
										  where ro.objectid = pl.placementid::character varying
											and ro.eventcode = 'PLTR'
											and ro.routingstatustypeid = 16
											and ro.activeflag = 1
										) > 0	
										or 
										( select count(*)
											from routing ro
										  where ro.objectid = pl.placementid::character varying
											and ro.eventcode = 'PLTR'
											and ro.routingstatustypeid = 15
											and ro.activeflag = 1
										) > 0	
									)
							) as active_placements,
						pr.vacancy_no 
					from prov.tb_provider pr
					where pr.delete_sw = 'N' 
						-- Closed 
						and btrim(pr.provider_status_cd) <> '1791'
						and f_prvpcklst_cat(pr.provider_id::bigint,'PLACEMENT') = '1783' 
				) tab 
			) tb_main
			where tb_main.vacancy_no <> tb_main.calculated_vacancy
			order by tb_main.provider_id;  
		loop
		fetch cur_public_provider_REFCURSOR into cur_public_provider_record;
			exit when not found;

			-- Reset
			vl_provider_id := NULL;
			vs_status := NULL;
			vl_approved_beds := NULL;
			vl_active_placements := NULL;
			vl_calculated_vacancy := NULL;
			vl_vacancy_no := NULL;
			v_event_description := v_event_org_description;
			
			vl_provider_id := cur_public_provider_record.provider_id;
			vs_status := cur_public_provider_record.status;
			vl_approved_beds := cur_public_provider_record.approved_beds;
			vl_active_placements := cur_public_provider_record.active_placements;
			vl_calculated_vacancy := cur_public_provider_record.calculated_vacancy;
			vl_vacancy_no := cur_public_provider_record.vacancy_no;
				
			RAISE NOTICE 'vl_provider_id >> %',vl_provider_id;
			
			If vl_calculated_vacancy <> vl_vacancy_no 
				-- and vl_calculated_vacancy >= 0 
				-- and vl_calculated_vacancy <= vl_approved_beds 
				then 
				
				update prov.tb_provider
				set vacancy_no = vl_calculated_vacancy,
					update_user_id = as_user_id,
					update_ts = now()
				where provider_id = vl_provider_id
					and delete_sw = 'N' ;
					
				al_sqlcode := SQLCODE;
				IF al_sqlcode < 0 THEN
					as_mess := 'Error updating the vacancy_no for Provider # ' || vl_provider_id;
					al_sqlcode := -1;
					ROLLBACK;
					exit;
				END IF ;
				
				v_event_description :=  v_event_description || ' to ' || vl_calculated_vacancy || ' for Provider # ' || vl_provider_id || '. (' || 'Incorrect vacancy was ' || vl_vacancy_no || ')';
			
				INSERT INTO cjams.auditlog
					(	logid, logtypekey, intakeserviceid, servicerequestnumber, referenceid, 
						description, isnew, isedit, isdelete, insertedby, 
						updatedby, insertedon, updatedon, metadata, ipaddress, 
						old_id, modifieddata, objectid, objecttype
					)
				VALUES
					(	gen_random_uuid(), vs_logtypekey, NULL, NULL, NULL, 
						v_event_description, NULL, NULL, NULL, as_user_id, 
						as_user_id, now(), now(), NULL, NULL, 
						NULL, NULL, vl_provider_id, 'Provider'
					);

				al_sqlcode := SQLCODE;
				IF al_sqlcode < 0 THEN
					as_mess := 'Error in capturing the data in the audit log table for Provider # ' || vl_provider_id;
					al_sqlcode := -1;
					ROLLBACK;
					exit;
				END IF ;
				
			end if;
		END LOOP;	
		
		close cur_public_provider_REFCURSOR;
		
		RAISE NOTICE 'Closed Public Provider - End';
	end if;
	
	-- Provider Address fix for the multiple default addresses
	RAISE NOTICE 'Provider Address Fix - Start';
	
	v_event_org_description := NULL;
	vs_logtypekey := 'PROVADDRESS';
	as_user_id := 'address_fix';
	
	select logtype 
		into v_event_org_description
	from auditlogtype 
	where lower(btrim(logtypekey)) = lower(btrim(vs_logtypekey));
	
	v_event_description := v_event_org_description;

	OPEN cur_impacted_providers_REFCURSOR FOR
		select distinct parent_key_id
			from prov.tb_provider_addresses
		where parent_key_id is not null
			and delete_sw = 'N'
			and adr_default_sw = 'Y'
		group by parent_key_id, adr_type_cd
		having count(*) > 1 ;  
	loop
	fetch cur_impacted_providers_REFCURSOR into cur_impacted_providers_record;
		exit when not found;

		-- Reset
		vs_parent_key_id := NULL;
		
		vs_parent_key_id := cur_impacted_providers_record.parent_key_id;
			
		RAISE NOTICE 'vs_parent_key_id >> %',vs_parent_key_id;	
		
		OPEN cur_provider_add_fix_REFCURSOR FOR
			select pa.address_id,
				RANK() OVER(PARTITION BY pa.parent_key_id, pa.adr_type_cd 
					ORDER BY pa.address_id desc
					) address_rank
			from prov.tb_provider_addresses pa
			where pa.parent_key_id = vs_parent_key_id
				and pa.delete_sw = 'N'
				and pa.adr_default_sw = 'Y'
			order by pa.address_id desc;  
		loop
		fetch cur_provider_add_fix_REFCURSOR into cur_provider_add_fix_record;
			exit when not found;

			-- Reset
			vl_address_id := NULL;
			vl_address_rank := NULL;
			v_event_description := v_event_org_description;
			
			vl_address_id := cur_provider_add_fix_record.address_id;
			vl_address_rank := cur_provider_add_fix_record.address_rank;

			If vl_address_rank <> 1 then 
				update prov.tb_provider_addresses
					set adr_default_sw = 'N',
					update_user_id = as_user_id,
					update_ts = now()
				where address_id = vl_address_id
					and delete_sw = 'N' ;		
					
				al_sqlcode := SQLCODE;
				IF al_sqlcode < 0 THEN
					as_mess := 'Error updating the tb_provider_addresses - adr_default_sw for Provider # ' || vs_parent_key_id ' (' || 'Address ID ' || vl_address_id::character varying || ')';
					al_sqlcode := -1;
					ROLLBACK;
					exit;
				END IF ;
				
				v_event_description :=  v_event_description || ' for Provider # ' || vs_parent_key_id || ' (' || 'Address ID ' || vl_address_id::character varying || ')';
		
				INSERT INTO cjams.auditlog
					(	logid, logtypekey, intakeserviceid, servicerequestnumber, referenceid, 
						description, isnew, isedit, isdelete, insertedby, 
						updatedby, insertedon, updatedon, metadata, ipaddress, 
						old_id, modifieddata, objectid, objecttype
					)
				VALUES
					(	gen_random_uuid(), vs_logtypekey, NULL, NULL, NULL, 
						v_event_description, NULL, NULL, NULL, as_user_id, 
						as_user_id, now(), now(), NULL, NULL, 
						NULL, NULL, vs_parent_key_id, 'Provider'
					);

				al_sqlcode := SQLCODE;
				IF al_sqlcode < 0 THEN
					as_mess := 'Error in capturing the data in the audit log table for Provider Address Fix # ' || vs_parent_key_id;
					al_sqlcode := -1;
					ROLLBACK;
					exit;
				END IF ;
			end if;
		END LOOP;	
	
		close cur_provider_add_fix_REFCURSOR;
		
	END LOOP;	
	
	close cur_impacted_providers_REFCURSOR;
	
	UPDATE prov.tb_provider
		SET row_lock = null,
			update_ts = now(),
			update_user_id = 'ROW_LOCK_RELEASE'
		WHERE delete_sw = 'N'
		 AND row_lock IS NOT NULL;
		
	UPDATE prov.tb_contract_program
		SET row_lock = null,
			update_ts = now(),
			update_user_id = 'ROW_LOCK_RELEASE'
		WHERE delete_sw = 'N'
		 AND row_lock IS NOT NULL;
	
	RAISE NOTICE 'Provider Address Fix - End';
	
	al_sqlcode := 0;
	as_mess :=  'success' ;
		
END;

$function$
;
